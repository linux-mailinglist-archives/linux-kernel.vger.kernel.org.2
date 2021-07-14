Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F273C7BD9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 04:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237650AbhGNCcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 22:32:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237501AbhGNCck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 22:32:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C97F611C0;
        Wed, 14 Jul 2021 02:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626229789;
        bh=fJ0Dq3fQhjh3SWzCSmUPy9q5NI47mlLoil/I18nwT6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tKHsjbF7CPgARD9d18snj36j92UbnLRl7jt/sw0+CCt1AUW4VTnl2J8DnfQmynSkj
         lPmmQMJMMjw/yoJoaJi77nCvPF2LEJkrawhA7awPBHve4IoWmgi8Fx+hYChqkZ4zoA
         nT0Gqfyt5q0r7cegQlzLLitt2qkrp9K3Go2losmKIzGtpA+24DKUSuJk/Iy8eZWDCg
         YumNoTiYOfHNXzoaF6iBly5KFpLMRk9pHBWUj/hFeXA971GKuVs1n25inp6kyyzVJN
         oYejDwIywpvauK1vHnPjo9SBYtsBdVzF1oURy7cyhMWQSiKealbFj6b4NugiGZKo4f
         5oM1iekSEpxJQ==
Date:   Wed, 14 Jul 2021 10:29:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     devicetree@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH] arm64: dts: fix node name for the sysclk
Message-ID: <20210714022943.GC31370@dragon>
References: <20210608112658.4087235-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608112658.4087235-1-olteanv@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 02:26:58PM +0300, Vladimir Oltean wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> U-Boot attempts to fix up the "clock-frequency" property of the "/sysclk" node:
> https://elixir.bootlin.com/u-boot/v2021.04/source/arch/arm/cpu/armv8/fsl-layerscape/fdt.c#L512
> 
> but fails to do so:
> 
>   ## Booting kernel from Legacy Image at a1000000 ...
>      Image Name:
>      Created:      2021-06-08  10:31:38 UTC
>      Image Type:   AArch64 Linux Kernel Image (gzip compressed)
>      Data Size:    15431370 Bytes = 14.7 MiB
>      Load Address: 80080000
>      Entry Point:  80080000
>      Verifying Checksum ... OK
>   ## Flattened Device Tree blob at a0000000
>      Booting using the fdt blob at 0xa0000000
>      Uncompressing Kernel Image
>      Loading Device Tree to 00000000fbb19000, end 00000000fbb22717 ... OK
>   Unable to update property /sysclk:clock-frequency, err=FDT_ERR_NOTFOUND
> 
>   Starting kernel ...
> 
> All Layerscape SoCs except LS1028A use "sysclk" as the node name, and
> not "clock-sysclk". So change the node name of LS1028A accordingly.
> 
> Fixes: 8897f3255c9c ("arm64: dts: Add support for NXP LS1028A SoC")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Applied, thanks.
