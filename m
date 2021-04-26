Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C1836AAB5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 04:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbhDZCko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 22:40:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231794AbhDZCkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 22:40:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BA116137D;
        Mon, 26 Apr 2021 02:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619404802;
        bh=1C38oG1HSBJejAMBYNwU/O6KiGcfxVESRrt5c8ueQmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Js2RC9CWKdYJnY3ElwNNSklCnYVhm/9EBhpysH4vcaOEUToGIpf8VbSJnvVD/7Gje
         juCHNAPFRj3x/XgjucHUNfQsWeiGQMBhUHcWXtFnWdL4Fn5DB9Te60/8bhdetHX/Lh
         bTINQ+Y0uFphg4u3Soq5mOPfR8pgCaUbPgbHwcHR/plPUSY3CWHt/0qicKzeFQ5ph/
         Ud0/YlVxtH2uq0ZWhr808VnvFOKdmYYr0bPdFalc8XQbDfk60FgxFp2Z/T5c+mXDVe
         5Te3cji5vziOGxHz1/rHudfX+/4RmdgS37K29W8jZDVtlNDRA7tw/wH7ibK1/JzdPJ
         lFtM6oq6w3ISw==
Date:   Mon, 26 Apr 2021 10:39:58 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Mian Yousaf Kaukab <ykaukab@suse.de>
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: ls1012a: enable PCIe on freeway board
Message-ID: <20210426023957.GG27585@dragon>
References: <20210330151920.29146-1-ykaukab@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330151920.29146-1-ykaukab@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 05:19:20PM +0200, Mian Yousaf Kaukab wrote:
> ls1012a-freeway board contains a M.2 2230 slot. Update the status of
> pcei1 node to okay so that the pcie controller can be probed.
> 
> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dts
> index 6290e2f9de6a..e3f371788f85 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dts
> @@ -38,3 +38,7 @@ w25q16dw0: flash@0 {
>  		spi-tx-bus-width = <2>;
>  	};
>  };
> +
> +&pcie1 {
> +	status = "okay";
> +};

Keep the labeling nodes sort alphabetically.

Shawn

> -- 
> 2.26.2
> 
