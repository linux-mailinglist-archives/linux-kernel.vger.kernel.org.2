Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3DCF35B336
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 12:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbhDKKsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 06:48:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229804AbhDKKsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 06:48:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84A29610C8;
        Sun, 11 Apr 2021 10:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618138095;
        bh=wjrS/KROvZgN4prWB2irrpi1jT+DNisYvdSKxbc6SrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=soC0vgn7RguM2iT5XuRh1zNC+MHgqtA1WFFw52SCDo+ky06u+AUTeOiLPmwOvihRB
         0Ai3sS/AdbwARbl2dL27ne/rxoPCcRsHNEUWZxSGurYLkTxBEcl6Vv6kTLn3CX59kR
         JL+gYUCPtm3XYmHGJDylsmowqiMerWtRpFH/gLBNzGGoGrd7vJ2xdqRb0NNasVELlM
         p9HyOZ7nBeG9upZ1eTVF1ClxhvQHzuNHS6NUXTOFmUr9ZnHVBRtQUsCN3aBj68y96P
         F0Xz6j4l8H2qqMCyaqYehaXwzamJqHuOtY7cfqqq5NtL+gmMsTC04LIUB6atlXwQtL
         t0is6A27yQmHg==
Received: by pali.im (Postfix)
        id 51E0686C; Sun, 11 Apr 2021 12:48:13 +0200 (CEST)
Date:   Sun, 11 Apr 2021 12:48:13 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Sebastian Oechsle <setboolean@icloud.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (dell-smm) Add Dell Latitude E7440 to fan
 control whitelist
Message-ID: <20210411104813.pksg3un2o45m2evl@pali>
References: <20210411095741.zmllsuc7pevdipvy@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210411095741.zmllsuc7pevdipvy@icloud.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 April 2021 11:57:41 Sebastian Oechsle wrote:
> Allow manual PWM control on Dell Latitude E7440.
> 
> Signed-off-by: Sebastian Oechsle <setboolean@icloud.com>

Reviewed-by: Pali Rohár <pali@kernel.org>

> 
> Changes in v2:
> - Fix spelling
> - Fix format
> ---
>  drivers/hwmon/dell-smm-hwmon.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index 73b9db9e3aab..2970892bed82 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -1210,6 +1210,14 @@ static struct dmi_system_id i8k_whitelist_fan_control[] __initdata = {
>  		},
>  		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
>  	},
> +	{
> +		.ident = "Dell Latitude E7440",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Latitude E7440"),
> +		},
> +		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
> +	},
>  	{ }
>  };
>  
> -- 
> 2.31.1
> 
