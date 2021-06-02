Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB07398FAD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 18:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhFBQKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 12:10:44 -0400
Received: from foss.arm.com ([217.140.110.172]:48786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229607AbhFBQKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 12:10:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC5F012FC;
        Wed,  2 Jun 2021 09:08:59 -0700 (PDT)
Received: from bogus (unknown [10.57.72.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E5D13F73D;
        Wed,  2 Jun 2021 09:08:57 -0700 (PDT)
Date:   Wed, 2 Jun 2021 17:08:53 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH v2 1/5] firmware: arm_scmi: reset_rx_to_maxsz during
 async commands
Message-ID: <20210602160853.mui3xdr7v4cmmwn2@bogus>
References: <20210601102421.26581-1-cristian.marussi@arm.com>
 <20210601102421.26581-2-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601102421.26581-2-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 11:24:17AM +0100, Cristian Marussi wrote:
> During an async commands execution the rx buffer len is at first set to
> max_msg_sz when the synchronous part of the command is first sent; once
> the synchronous part completes the transport layer waits for the delayed
> response which will be processed using the same xfer descriptor initially
> allocated, but synchronous response received at the end of the xfer will
> have shrunk the rx buffer len to the effective payload response length.
> 
> Raise the rx buffer length again to max_msg_sz while waiting for the
> delayed response, while adding an informational error message.
> 
> Fixes: 58ecdf03dbb9 ("firmware: arm_scmi: Add support for asynchronous commands and delayed response")
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  drivers/firmware/arm_scmi/driver.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 66eb3f0e5daf..75141b90ae53 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -513,8 +513,16 @@ static int do_xfer_with_response(const struct scmi_protocol_handle *ph,
>  	xfer->async_done = &async_response;
>  
>  	ret = do_xfer(ph, xfer);
> -	if (!ret && !wait_for_completion_timeout(xfer->async_done, timeout))
> -		ret = -ETIMEDOUT;
> +	if (!ret) {
> +		/* rx.len would have been shrunk in the sync do_xfer above */
> +		reset_rx_to_maxsz(ph, xfer);

Won't this race with delayed response notification ? I think so, let me
know if not and how. Can't we have this before we fetch the response into xfer ?

-- 
Regards,
Sudeep
