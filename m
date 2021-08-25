Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789C53F7BBC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 19:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242390AbhHYRvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 13:51:06 -0400
Received: from foss.arm.com ([217.140.110.172]:56998 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242258AbhHYRvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 13:51:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1273DD6E;
        Wed, 25 Aug 2021 10:50:18 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 982043F66F;
        Wed, 25 Aug 2021 10:50:16 -0700 (PDT)
Date:   Wed, 25 Aug 2021 18:50:13 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        etienne.carriere@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>
Subject: Re: [PATCH v4 03/12] firmware: arm_scmi: Add support for atomic
 transports
Message-ID: <20210825175013.GG13160@e120937-lin>
References: <20210824135941.38656-1-cristian.marussi@arm.com>
 <20210824135941.38656-4-cristian.marussi@arm.com>
 <CA+-6iNzTN6UHVX4qRssrqv6YVKeg97+Lz1KDcEcw6saMC0tubw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNzTN6UHVX4qRssrqv6YVKeg97+Lz1KDcEcw6saMC0tubw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 12:18:31PM -0400, Jim Quinlan wrote:
> Hi Christian,
> 

Hi Jim,

thanks for the review first of all.

> On Tue, Aug 24, 2021 at 10:00 AM Cristian Marussi
> <cristian.marussi@arm.com> wrote:
> >
> > An SCMI transport can declare itself as .atomic_capable in order to signal
> > to the SCMI core that all its transmit path can be executed in atomic
> > context: the core as a consequence will take care not to sleep to in the
> > corresponding rx path while waiting for a response or a delayed response.
> >
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >  drivers/firmware/arm_scmi/common.h |   3 +
> >  drivers/firmware/arm_scmi/driver.c | 167 ++++++++++++++++++++++-------
> >  2 files changed, 132 insertions(+), 38 deletions(-)
> >
> > diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> > index 67c761141a48..4ab310c2eae5 100644
> > --- a/drivers/firmware/arm_scmi/common.h
> > +++ b/drivers/firmware/arm_scmi/common.h
> > @@ -412,6 +412,8 @@ struct scmi_device *scmi_child_dev_find(struct device *parent,
> >   * @max_msg_size: Maximum size of data per message that can be handled.
> >   * @force_polling: Flag to force this whole transport to use SCMI core polling
> >   *                mechanism instead of completion interrupts even if available.
> > + * @atomic_capable: Flag to indicate that this transport is assured not to sleep
> > + *                 on the TX path.
> >   */
> >  struct scmi_desc {
> >         int (*transport_init)(void);
> > @@ -421,6 +423,7 @@ struct scmi_desc {
> >         int max_msg;
> >         int max_msg_size;
> >         bool force_polling;
> > +       bool atomic_capable;
> >  };
> >
> >  #ifdef CONFIG_ARM_SCMI_TRANSPORT_MAILBOX
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > index a3700f49e8ac..2ca1602afd80 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -681,6 +681,10 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
> >                 scmi_clear_channel(info, cinfo);
> >                 complete(xfer->async_done);
> >         } else {
> > +               /*
> > +                * This same xfer->done completion is used in atomic mode as a
> > +                * flag for polling.
> > +                */
> >                 complete(&xfer->done);
> >         }
> >
> > @@ -733,8 +737,6 @@ static void xfer_put(const struct scmi_protocol_handle *ph,
> >         __scmi_xfer_put(&info->tx_minfo, xfer);
> >  }
> >
> > -#define SCMI_MAX_POLL_TO_NS    (100 * NSEC_PER_USEC)
> > -
> >  static bool scmi_xfer_done_no_timeout(struct scmi_chan_info *cinfo,
> >                                       struct scmi_xfer *xfer, ktime_t stop)
> >  {
> > @@ -749,6 +751,90 @@ static bool scmi_xfer_done_no_timeout(struct scmi_chan_info *cinfo,
> >                ktime_after(ktime_get(), stop);
> >  }
> >
> > +static bool xfer_complete_or_timeout(struct completion *done, ktime_t stop)
> > +{
> > +       return try_wait_for_completion(done) || ktime_after(ktime_get(), stop);
> > +}
> > +
> > +static int spin_for_completion_timeout(struct completion *done, int timeout_ms)
> > +{
> > +       ktime_t stop = ktime_add_ms(ktime_get(), timeout_ms);
> > +
> > +       spin_until_cond(xfer_complete_or_timeout(done, stop));
> > +       if (ktime_after(ktime_get(), stop))
> > +               return -ETIMEDOUT;
> > +
> > +       return 0;
> > +}
> > +
> > +/**
> > + * scmi_wait_for_message_response  - An helper to group all the possible ways of
> > + * waiting for a synchronous message response.
> > + *
> > + * @cinfo: SCMI channel info
> > + * @xfer: Reference to the transfer being waited for.
> > + *
> > + * Chooses waiting strategy (sleep-waiting vs busy-waiting) depending on flags
> > + * configuration like xfer->hdr.poll_completion and scmi_desc.atomic.capable.
> > + *
> > + * Return: 0 on Success, error otherwise.
> > + */
> > +static int scmi_wait_for_message_response(struct scmi_chan_info *cinfo,
> > +                                         struct scmi_xfer *xfer)
> > +{
> > +       struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
> > +       struct device *dev = info->dev;
> > +       int ret = 0, timeout_ms = info->desc->max_rx_timeout_ms;
> > +
> > +       if (!xfer->hdr.poll_completion) {
> > +               if (!info->desc->atomic_capable) {
> > +                       if (!wait_for_completion_timeout(&xfer->done,
> > +                                                        msecs_to_jiffies(timeout_ms))) {
> > +                               dev_err(dev, "timed out in resp(caller: %pS)\n",
> > +                                       (void *)_RET_IP_);
> > +                               ret = -ETIMEDOUT;
> > +                       }
> > +               } else {
> > +                       /* Poll on xfer->done waiting for completion by interrupt */
> > +                       ret = spin_for_completion_timeout(&xfer->done,
> > +                                                         timeout_ms);
> We use the SMC transport with a completion interrupt but would prefer
> for the above to use wait_for_completion(...) instead of  using
> spin_for_completion().  A few of our SCMI commands can take a while to
> complete execution so we do not want to be spinning or polling while
> waiting.

Busy-waiting when using a completion IRQ is used indeed only if the
transport has been declared .atomic_capable: the idea was that if
the specific transport does not sleep, the core can avoid sleeping too
and so enable users like the clock framework to switch to 'atomic' mode
and being called from atomic context.

So if you drop indeed the SMC patch later in the series that mmake it
atomic

[PATCH v4 10/12] [RFC] firmware: arm_scmi: Make smc transport atomic

you'll end up using the wait_for here when completion IRQ is used.
(instead to avoid any polling while in polling mode (O_o) the idea was
to use the new .sync_cmds_atomic_replies) 

BUT the problem is that some other partner could possibly want to use
instead this same transport in atomic mode, so maybe it could be worth
introducing some sort of configurability so that atomic operations are
enabled only if (say) .atomic_capable && .atomic_enable.

Maybe this could be done on a per-channel base, so you could dedicate a
channel to a protocol and ask only for it to be atomic_enable (if the
whole transport is atomic_capable); mixing atomic/non_atomic behaviour
inside the same protocol/channel across different messages seems a bit
of a hell (...and I think a previous attempt led to a lot of issues in
the past)

Anyway, not sure really where to put this possible configuration bit
though...this not being really a FW config/description seems likely to
be a NACK for a placement in the DT :D

> 
> We could probably go back to a mailbox-based transport and use delayed
> messages here for these "long" SCMI messages,  but we do not have full
> control over the platform FW (plus there are backwards compatibility
> issues).  FWIW, the platform FW was setup before SCMI on Linux
> implemented delayed/async  messages.
> 

Having a completion IRQ couldn't you use it to send delayed responses or
notification even in this smc transport ? (well it'd need FW to be
updated in fact and maybe I'm missing something here)

Thanks a lot for the feedback, may I assume this initial series it sort
of worked (beside noted limitations) in your SMC test setup :D ?

Thanks,
Cristian
