Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEE831E990
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 13:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhBRMJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 07:09:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:56850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229994AbhBRKgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 05:36:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7537464DF0;
        Thu, 18 Feb 2021 09:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613641235;
        bh=FBgOPfIf3FC5lff30PU6rn5fUjdaBUeL1E0K+BMPxKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tL+9kgJaEcLuwkMVwNo0aCdBiv1m/MfJrHr86iQbWTzYp2ed7cdgaed7uJ2SOcl5s
         TckTA6KZ0woMrehJxyI3OtYKUOsIt17vuAdNqKLl2BRgHRIdNPK7VF+IW87ZOClCvg
         V5wJdqXFCcwLvdAJ8EmPQVGc32X+YU96KS2h1f/s=
Date:   Thu, 18 Feb 2021 10:40:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Muhammad Usama Anjum <musamaanjum@gmail.com>
Cc:     lee.jones@linaro.org, johannes@sipsolutions.net, arnd@arndb.de,
        kuba@kernel.org, gustavoars@kernel.org, wanghai38@huawei.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wimax/i2400m: don't change the endianness of
 one byte variable
Message-ID: <YC42ECUUtX1Ah90v@kroah.com>
References: <20210218092154.GA46388@LEGION>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218092154.GA46388@LEGION>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 02:21:54PM +0500, Muhammad Usama Anjum wrote:
> It is wrong to change the endianness of a variable which has just one
> byte size.
> 
> Sparse warnings fixed:
> drivers/staging//wimax/i2400m/control.c:452:17: warning: cast to restricted __le32
> drivers/staging//wimax/i2400m/control.c:452:17: warning: cast to restricted __le32
> drivers/staging//wimax/i2400m/op-rfkill.c:159:14: warning: cast to restricted __le32
> drivers/staging//wimax/i2400m/op-rfkill.c:160:14: warning: cast to restricted __le32
> 
> Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
> ---
>  drivers/staging/wimax/i2400m/control.c   | 4 ++--
>  drivers/staging/wimax/i2400m/op-rfkill.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/wimax/i2400m/control.c b/drivers/staging/wimax/i2400m/control.c
> index 1e270b2101e8..b6b2788af162 100644
> --- a/drivers/staging/wimax/i2400m/control.c
> +++ b/drivers/staging/wimax/i2400m/control.c
> @@ -452,8 +452,8 @@ void i2400m_report_state_parse_tlv(struct i2400m *i2400m,
>  		d_printf(2, dev, "%s: RF status TLV "
>  			 "found (0x%04x), sw 0x%02x hw 0x%02x\n",
>  			 tag, I2400M_TLV_RF_STATUS,
> -			 le32_to_cpu(rfss->sw_rf_switch),
> -			 le32_to_cpu(rfss->hw_rf_switch));
> +			 rfss->sw_rf_switch,
> +			 rfss->hw_rf_switch);

What do you mean by "one byte"?  This is a le32 sized variable, right?
If not, why isn't the le32_to_cpu() call complaining?

>  		i2400m_report_tlv_rf_switches_status(i2400m, rfss);
>  	}
>  	if (0 == i2400m_tlv_match(tlv, I2400M_TLV_MEDIA_STATUS, sizeof(*ms))) {
> diff --git a/drivers/staging/wimax/i2400m/op-rfkill.c b/drivers/staging/wimax/i2400m/op-rfkill.c
> index fbddf2e18c14..a159808f0ec2 100644
> --- a/drivers/staging/wimax/i2400m/op-rfkill.c
> +++ b/drivers/staging/wimax/i2400m/op-rfkill.c
> @@ -156,8 +156,8 @@ void i2400m_report_tlv_rf_switches_status(
>  	enum i2400m_rf_switch_status hw, sw;
>  	enum wimax_st wimax_state;
>  
> -	sw = le32_to_cpu(rfss->sw_rf_switch);
> -	hw = le32_to_cpu(rfss->hw_rf_switch);
> +	sw = rfss->sw_rf_switch;
> +	hw = rfss->hw_rf_switch;

Same here.

thanks,

greg k-h
