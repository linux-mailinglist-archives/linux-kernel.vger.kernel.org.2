Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2573CD058
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 11:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbhGSIfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 04:35:07 -0400
Received: from foss.arm.com ([217.140.110.172]:53378 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234991AbhGSIfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 04:35:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 641126D;
        Mon, 19 Jul 2021 02:15:45 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BF923F73D;
        Mon, 19 Jul 2021 02:15:42 -0700 (PDT)
Date:   Mon, 19 Jul 2021 10:15:35 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Peter Hilber <peter.hilber@opensynergy.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, sudeep.holla@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        igor.skalkin@opensynergy.com, alex.bennee@linaro.org,
        jean-philippe@linaro.org, mikhail.golubev@opensynergy.com,
        anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com,
        Andriy.Tryshnivskyy@opensynergy.com
Subject: Re: [PATCH v6 10/17] firmware: arm_scmi: Make polling mode optional
Message-ID: <20210719091535.GG49078@e120937-lin>
References: <20210712141833.6628-1-cristian.marussi@arm.com>
 <20210712141833.6628-11-cristian.marussi@arm.com>
 <4ad5a421-d9ab-816f-b721-9f88ffabfb39@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ad5a421-d9ab-816f-b721-9f88ffabfb39@opensynergy.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 06:36:10PM +0200, Peter Hilber wrote:
> On 12.07.21 16:18, Cristian Marussi wrote:
> > Add a check for the presence of .poll_done transport operation so that
> > transports that do not need to support polling mode have no need to provide
> > a dummy .poll_done callback either and polling mode can be disabled in the
> > SCMI core for that tranport.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >   drivers/firmware/arm_scmi/driver.c | 43 ++++++++++++++++++------------
> >   1 file changed, 26 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > index a952b6527b8a..4183d25c9289 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -777,25 +777,34 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
> >   	}
> >   	if (xfer->hdr.poll_completion) {
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
> >   			}
> > -			spin_unlock_irqrestore(&xfer->lock, flags);
> >   		} else {
> > -			ret = -ETIMEDOUT;
> > +			dev_warn_once(dev,
> > +				      "Polling mode is not supported by transport.\n");
> > +			ret = EINVAL;
> 
> s/EINVAL/-EINVAL

Ah. Right. I'll fix.

Thanks,
Cristian
