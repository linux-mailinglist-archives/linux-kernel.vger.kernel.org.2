Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072BE368630
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 19:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbhDVRrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 13:47:16 -0400
Received: from foss.arm.com ([217.140.110.172]:54604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236659AbhDVRrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 13:47:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0A1A1063;
        Thu, 22 Apr 2021 10:46:38 -0700 (PDT)
Received: from bogus (unknown [10.57.52.142])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C88EF3F694;
        Thu, 22 Apr 2021 10:46:37 -0700 (PDT)
Date:   Thu, 22 Apr 2021 18:46:31 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scpi: prevent ternary sign expansion bug
Message-ID: <20210422174631.aruiqqqx3szboqdp@bogus>
References: <YIE7pdqV/h10tEAK@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIE7pdqV/h10tEAK@mwanda>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(dropping Tixy as I am sure it will bounce, he left/retired from Linaro
long back)

On Thu, Apr 22, 2021 at 12:02:29PM +0300, Dan Carpenter wrote:
> How type promotion works in ternary expressions is a bit tricky.
> The problem is that scpi_clk_get_val() returns longs, "ret" is a int
> which holds a negative error code, and le32_to_cpu() is an unsigned int.

Agreed.

> We want the negative error code to be cast to a negative long.  But
> because le32_to_cpu() is an u32 then "ret" is type promoted to u32 and
> becomes a high positive and then it is promoted to long and it is still
> a high positive value.
>

Thanks a lot for finding and fixing the bug!

> Fix this by getting rid of the ternary.
>
> Fixes: 8cb7cf56c9fe ("firmware: add support for ARM System Control and Power Interface(SCPI) protocol")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/firmware/arm_scpi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
> index d0dee37ad522..3bf61854121d 100644
> --- a/drivers/firmware/arm_scpi.c
> +++ b/drivers/firmware/arm_scpi.c
> @@ -552,8 +552,10 @@ static unsigned long scpi_clk_get_val(u16 clk_id)
>
>  	ret = scpi_send_message(CMD_GET_CLOCK_VALUE, &le_clk_id,
>  				sizeof(le_clk_id), &rate, sizeof(rate));
> +	if (ret)
> +		return ret;

This could be still an issue, ideally I would prefer to pass the return
value via argument pointer and always return success/failure as return
value. Can't remember any reason for this. Since this is old interface
with limited platform to test, I think returning 0 as clock rate on error
should be fine as Cristain suggested. If you agree with that, I can
fix up when applying. 

If you don't, we can look at changing the scpi interface to clock driver
which will anyway need to do the same(i.e. send 0 in case of error)

Let me know.

--
Regards,
Sudeep
