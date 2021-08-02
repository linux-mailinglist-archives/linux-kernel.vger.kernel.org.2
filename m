Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0B43DDE87
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 19:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhHBRaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 13:30:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229607AbhHBR3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 13:29:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D34FA61102;
        Mon,  2 Aug 2021 17:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627925384;
        bh=CW+mp2qidRVwZuQRESt49L6zsHui5LNvQSbJNC6LeVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GJuxzopT4ZZ8IP7n6PDsaXGTnmND1JBKaef9LYBwxNX3ZZwt+Ch+6o0qBNDCJtud1
         KehPtmMIKy4vZzh5qbRRpxnBkoDSFUpK/Qf44+LUI3dScFDQIkIcZL1FMvPAgZisU2
         CQgHBAcNY6O2xFRRjDEeJIv/gEXIU6DCxc17oD7gipRSDfuc5I373kwPTgKNYn8gkn
         Ok9uP2iamkjtNeAOXjgQET4zOjkQktxmiO5pWwXOFuDxYqWHMLBgMSKlxg5xtvpxQH
         br4+qjZTrR9qwSZG8Po9ZVSDNnzcSzdkNk6wew0AR9dmnOWMDzx/rXa27tQjS7BSYs
         CEVcHQBzKVclA==
Received: by pali.im (Postfix)
        id 9AAF4B98; Mon,  2 Aug 2021 19:29:41 +0200 (CEST)
Date:   Mon, 2 Aug 2021 19:29:41 +0200
From:   Pali Rohar <pali@kernel.org>
To:     Carlos Alberto Lopez Perez <clopez@igalia.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH] hwmon: (dell-smm) Add Dell Precision 7510 to fan control
 whitelist
Message-ID: <20210802172941.is2e4bxpsnuwslew@pali>
References: <20210802131538.8660-1-clopez@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210802131538.8660-1-clopez@igalia.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 August 2021 14:15:38 Carlos Alberto Lopez Perez wrote:
> This allows manual PWM control without the BIOS fighting back on Dell
> Precision 7510. Meanwhile at it, also sort alphabetically the entries
> of the i8k_whitelist_fan_control struct.
> 
> Signed-off-by: Carlos Alberto Lopez Perez <clopez@igalia.com>

Acked-by: Pali Rohár <pali@kernel.org>

> ---
>  drivers/hwmon/dell-smm-hwmon.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index f2221ca0aa7b..a677c8a4ef29 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -1186,14 +1186,6 @@ static const struct i8k_fan_control_data i8k_fan_control_data[] = {
>  };
>  
>  static struct dmi_system_id i8k_whitelist_fan_control[] __initdata = {
> -	{
> -		.ident = "Dell Precision 5530",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Precision 5530"),
> -		},
> -		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
> -	},
>  	{
>  		.ident = "Dell Latitude 5480",
>  		.matches = {
> @@ -1218,6 +1210,22 @@ static struct dmi_system_id i8k_whitelist_fan_control[] __initdata = {
>  		},
>  		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
>  	},
> +	{
> +		.ident = "Dell Precision 5530",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Precision 5530"),
> +		},
> +		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
> +	},
> +	{
> +		.ident = "Dell Precision 7510",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Precision 7510"),
> +		},
> +		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
> +	},
>  	{ }
>  };
>  
> -- 
> 2.20.1
> 
