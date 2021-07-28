Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04AD3D9471
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 19:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhG1Rll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 13:41:41 -0400
Received: from foss.arm.com ([217.140.110.172]:34158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229556AbhG1Rlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 13:41:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 109B36D;
        Wed, 28 Jul 2021 10:41:38 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D29A53F66F;
        Wed, 28 Jul 2021 10:41:34 -0700 (PDT)
Date:   Wed, 28 Jul 2021 18:41:32 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com,
        peter.hilber@opensynergy.com, alex.bennee@linaro.org,
        jean-philippe@linaro.org, mikhail.golubev@opensynergy.com,
        anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com,
        Andriy.Tryshnivskyy@opensynergy.com
Subject: Re: [PATCH v6 10/17] firmware: arm_scmi: Make polling mode optional
Message-ID: <20210728174132.GM6592@e120937-lin>
References: <20210712141833.6628-1-cristian.marussi@arm.com>
 <20210712141833.6628-11-cristian.marussi@arm.com>
 <20210728143418.5lton6l7t2oa6rtz@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728143418.5lton6l7t2oa6rtz@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 03:34:18PM +0100, Sudeep Holla wrote:
> On Mon, Jul 12, 2021 at 03:18:26PM +0100, Cristian Marussi wrote:
> > Add a check for the presence of .poll_done transport operation so that
> > transports that do not need to support polling mode have no need to provide
> > a dummy .poll_done callback either and polling mode can be disabled in the
> > SCMI core for that tranport.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---

Hi,

> >  drivers/firmware/arm_scmi/driver.c | 43 ++++++++++++++++++------------
> >  1 file changed, 26 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > index a952b6527b8a..4183d25c9289 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -777,25 +777,34 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
> >  	}
> >  
> >  	if (xfer->hdr.poll_completion) {
> > -		ktime_t stop = ktime_add_ns(ktime_get(), SCMI_MAX_POLL_TO_NS);
> > -
> > -		spin_until_cond(scmi_xfer_done_no_timeout(cinfo, xfer, stop));
> > -
> > -		if (ktime_before(ktime_get(), stop)) {
> > -			unsigned long flags;
> > -
> > -			/*
> > -			 * Do not fetch_response if an out-of-order delayed
> > -			 * response is being processed.
> > -			 */
> > -			spin_lock_irqsave(&xfer->lock, flags);
> > -			if (xfer->state == SCMI_XFER_SENT_OK) {
> > -				info->desc->ops->fetch_response(cinfo, xfer);
> > -				xfer->state = SCMI_XFER_RESP_OK;
> > +		if (info->desc->ops->poll_done) {
> > +			ktime_t stop = ktime_add_ns(ktime_get(),
> > +						    SCMI_MAX_POLL_TO_NS);
> > +
> > +			spin_until_cond(scmi_xfer_done_no_timeout(cinfo, xfer,
> > +								  stop));
> > +
> > +			if (ktime_before(ktime_get(), stop)) {
> > +				unsigned long flags;
> > +
> > +				/*
> > +				 * Do not fetch_response if an out-of-order delayed
> > +				 * response is being processed.
> > +				 */
> > +				spin_lock_irqsave(&xfer->lock, flags);
> > +				if (xfer->state == SCMI_XFER_SENT_OK) {
> > +					info->desc->ops->fetch_response(cinfo,
> > +									xfer);
> > +					xfer->state = SCMI_XFER_RESP_OK;
> > +				}
> > +				spin_unlock_irqrestore(&xfer->lock, flags);
> > +			} else {
> > +				ret = -ETIMEDOUT;
> >  			}
> > -			spin_unlock_irqrestore(&xfer->lock, flags);
> >  		} else {
> > -			ret = -ETIMEDOUT;
> > +			dev_warn_once(dev,
> > +				      "Polling mode is not supported by transport.\n");
> > +			ret = EINVAL;
> 
> Can't we just return this error as early as possible if the user isn't
> expected to use polling with this transport ? That would simplify the patch
> (as most of it is due to indentation which can go away) as you need not
> check it later ?
> 

Yes, indeed at first it was something like

if (xfer->hdr.poll_completion && !info->desc->ops->poll_done)
	return -EINVAL;

at the very beginning of do_xfer(), even before attempting to send
anything...and I liked much more but then I thought I would have run such
if-test for each and every command do_xfer() attempted...but maybe it's
just irrelevant and instead much more tidy if done as above.

I'll fix it as above.

Thanks,
Cristian
