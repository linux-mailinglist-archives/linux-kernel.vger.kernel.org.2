Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB12630864C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 08:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhA2HOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 02:14:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:40200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229656AbhA2HO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 02:14:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A86A764DFD;
        Fri, 29 Jan 2021 07:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611904429;
        bh=wgZJ8Ko69dFLx/OeFIUuGPITGgyaxy6YKnlIOtJqSbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cyGqwueDDOG9MZriXuiwomeb7hWrplg6L2Y6Hz2mUGa805smrZLCnlP/ytqk2jDgf
         LdwXahN7k2b+dVa7NRbG5odMf/eITLl0IE5ImUcVlz0Kyo3FUe6GLf484x+p6kuTpg
         Qw6O7dvk7XPoKF8B4jOI4EW9kRDRsJUHMOntDhRskw7Nl7aCrVTutzKgbXHa/+KphD
         nTJFGVeEEX7KeAc/H8ii32B7k9zrurCjbYMrdJWZ9Css/099puZ7FXhVvowCtvpxei
         ui8ql9MfbgniEHS3znpIyrZQgNVC+hCaSaT/Hti7FBC7aVG9Q4VGUqqoaP/GBVkjPS
         Y9s3vxTMiAvsA==
Date:   Fri, 29 Jan 2021 15:13:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     arnd@arndb.de, olof@lixom.net, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com
Subject: Re: [PATCH v2 3/3] arch/arm/configs: Enable VMSPLIT_2G in
 imx_v6_v7_defconfig
Message-ID: <20210129071341.GH4356@dragon>
References: <20210117180301.1956-1-alistair@alistair23.me>
 <20210117180301.1956-3-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210117180301.1956-3-alistair@alistair23.me>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 17, 2021 at 10:03:01AM -0800, Alistair Francis wrote:
> The reMarkable2 requires VMSPLIT_2G, so lets set this in the
> imx_v6_v7_defconfig.

Hmm, why is VMSPLIT_2G required by reMarkable2?

Shawn

> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  arch/arm/configs/imx_v6_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index 55674cb1ffce..fa9229616106 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -29,6 +29,7 @@ CONFIG_SOC_IMX7D=y
>  CONFIG_SOC_IMX7ULP=y
>  CONFIG_SOC_VF610=y
>  CONFIG_SMP=y
> +CONFIG_VMSPLIT_2G=y
>  CONFIG_ARM_PSCI=y
>  CONFIG_HIGHMEM=y
>  CONFIG_FORCE_MAX_ZONEORDER=14
> -- 
> 2.29.2
> 
