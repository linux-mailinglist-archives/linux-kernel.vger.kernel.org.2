Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0457534FDB9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 12:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbhCaKCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 06:02:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234939AbhCaKCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:02:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E161C61962;
        Wed, 31 Mar 2021 10:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617184934;
        bh=9vk1fqVTYDA21AIayVHMcpEsBbnF3Y8bs6YitEp1u0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ud8Xtc/OfKhB2dkQ/olmZ734evpDHD+C8jaHWHNlrlTL/KYTYFBG22qBbhO4z7Kql
         lV7DF9gCjvoOxlF1jux4/FMEZ4eVIEboTtNmUmYhQjcMoaPyTrPjWozbE2Dj86o4LX
         cxUlA6vYDHqpy5+Md9GXTwbyYNEqXzsiL8LP223QejG9ATuJhqdr1QOPPbQvndutSP
         OKIE6ZfkXg5SywrUaHZMVuqubXFIwghGPUweg7INjWVryIMVWYVd4SOCELJZJc/ptg
         Kc1snhWtO7jtFyESL5PsI4whFrO+xB6iclq8G4o3dRiXV3cpd2W14nHecCMqxXk+w9
         vGm/7vaYfsSOg==
Received: by pali.im (Postfix)
        id 68D74AF7; Wed, 31 Mar 2021 12:02:11 +0200 (CEST)
Date:   Wed, 31 Mar 2021 12:02:11 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Sebastian Oechsle <setboolean@icloud.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm) Add Dell Latitude 7440 to fan control
 whitelist
Message-ID: <20210331100211.jo56p4x2qm73fyed@pali>
References: <EE8F83B0-0C39-4E2A-B5FB-B94A1389588D@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EE8F83B0-0C39-4E2A-B5FB-B94A1389588D@icloud.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 March 2021 19:02:55 Sebastian Oechsle wrote:
> Allow manual PWM control on Dell Latitude 7440.
> 
> Signed-off-by: Sebastian Oechsle <setboolean@icloud.com <mailto:setboolean@icloud.com>>

Reviewed-by: Pali Rohár <pali@kernel.org>

(Btw, in commit message is small typo, model name is E7440, not 7440)

Guenter, would you take this patch?

> ---
> drivers/hwmon/dell-smm-hwmon.c | 8 ++++++++
> 1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index 73b9db9e3aab..2970892bed82 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -1210,6 +1210,14 @@ static struct dmi_system_id i8k_whitelist_fan_control[] __initdata = {
> 		},
> 		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
> 	},
> +	{
> +		.ident = "Dell Latitude E7440",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Latitude E7440"),
> +		},
> +		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
> +	},
> 	{ }
> };
> 
> --
> 2.31.1
