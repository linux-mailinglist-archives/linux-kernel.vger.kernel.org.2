Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7244339E5B2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 19:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhFGRpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 13:45:10 -0400
Received: from foss.arm.com ([217.140.110.172]:39002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229997AbhFGRpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 13:45:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DA6612FC;
        Mon,  7 Jun 2021 10:43:18 -0700 (PDT)
Received: from bogus (unknown [10.57.73.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 670063F73D;
        Mon,  7 Jun 2021 10:43:16 -0700 (PDT)
Date:   Mon, 7 Jun 2021 18:42:57 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [RFC PATCH 02/10] firmware: arm_scmi: Add missing xfer
 reinit_completion
Message-ID: <20210607174142.jdirvbasvgl7q4oj@bogus>
References: <20210606221232.33768-1-cristian.marussi@arm.com>
 <20210606221232.33768-3-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210606221232.33768-3-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2021 at 11:12:24PM +0100, Cristian Marussi wrote:
> Reusing timed out xfers in a loop can lead to issue if completion was not
> properly reinitialized.
>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  drivers/firmware/arm_scmi/driver.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index bee33f9c2032..759ae4a23e74 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -448,6 +448,7 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
>  			      xfer->hdr.poll_completion);
>
>  	xfer->hdr.status = SCMI_SUCCESS;
> +	reinit_completion(&xfer->done);
>

What could happen after xfer_get_init->scmi_xfer_get->reinit_completion
that it needs to be re-initialised again. I don't see any reason for this ?
If there are, please state them explicitly. If this is needed, I would drop
the one in scmi_xfer_get().

--
Regards,
Sudeep
