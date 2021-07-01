Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89873B9050
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 12:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbhGAKHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 06:07:01 -0400
Received: from foss.arm.com ([217.140.110.172]:50280 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234907AbhGAKG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 06:06:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88598D6E;
        Thu,  1 Jul 2021 03:04:29 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF90D3F718;
        Thu,  1 Jul 2021 03:04:25 -0700 (PDT)
Date:   Thu, 1 Jul 2021 11:04:19 +0100
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
Subject: Re: [PATCH v4 01/16] firmware: arm_scmi: Fix max pending messages
 boundary check
Message-ID: <20210701100258.GB50227@e120937-lin>
References: <20210611165937.701-1-cristian.marussi@arm.com>
 <20210611165937.701-2-cristian.marussi@arm.com>
 <cb24778e-60fd-4582-c855-238d71319067@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb24778e-60fd-4582-c855-238d71319067@opensynergy.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Thu, Jul 01, 2021 at 10:42:40AM +0200, Peter Hilber wrote:
> Hi Cristian,
> 
> please find some remarks to the patch series in this email and the
> following.
> 

Thanks for your comments, very much appreciated. I'll reply inline.

Just to let you know, I have ready a V5 series where, beside some
general cleanup and further simplification, I addressed in the SCMI core
the issue that you pointed out about the possible concurrent and out-of-order
response/delayed_response delivery by the transport.

I've refrained from posting that on the list still, due to the merge window
being open. I'll post most probably next week. (still have to see if I
can also simplify probing sequence in V5...which is the last point in my
list)

> On 11.06.21 18:59, Cristian Marussi wrote:
> > SCMI message headers carry a sequence number and such field is sized to
> > allow for MSG_TOKEN_MAX distinct numbers; moreover zero is not really an
> > acceptable maximum number of pending in-flight messages.
> > 
> > Fix accordignly the checks performed on the value exported by transports
> > in scmi_desc.max_msg.
> > 
> > Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Fixes: aa4f886f3893 ("firmware: arm_scmi: add basic driver infrastructure for SCMI")
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >  drivers/firmware/arm_scmi/driver.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > index 66e5e694be7d..6713b259f1e6 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -1025,8 +1025,9 @@ static int __scmi_xfer_info_init(struct scmi_info *sinfo,
> >  	const struct scmi_desc *desc = sinfo->desc;
> >  	/* Pre-allocated messages, no more than what hdr.seq can support */
> > -	if (WARN_ON(desc->max_msg >= MSG_TOKEN_MAX)) {
> > -		dev_err(dev, "Maximum message of %d exceeds supported %ld\n",
> > +	if (WARN_ON(!desc->max_msg || desc->max_msg > MSG_TOKEN_MAX)) {
> > +		dev_err(dev,
> > +			"Invalid max_msg %d. Maximum messages supported %ld.\n",
> 
> %ld -> %lu
> 

Right, I'll fix.

> >  			desc->max_msg, MSG_TOKEN_MAX);
> >  		return -EINVAL;
> >  	}
> > 

Thanks,
Cristian

