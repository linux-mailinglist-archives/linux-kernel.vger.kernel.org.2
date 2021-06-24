Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA56E3B2B52
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhFXJ05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbhFXJ04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:26:56 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCD6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 02:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tt6UaeRlnvQ/LqzUoMV5djDpHwMmNzyPLkgPlqHESpI=; b=Lk0IgBIyHXjQusUL010FMmRhx
        ofa+q61khUBL6X2lhF4xeBXEy6ZdTUvYIcFc5K820QchYh5zbFYLj73aRCdDhyT6DbfkG/CKKyMJg
        K8s/GfXjt+zEFHKXTV2Hx7JgAwPOxMlFsS5jkUWMBnXiNTrbtt4QcgeivC1aVTkSpW3vREmod2pE/
        cvNFyScP19BxG+ZmOmh+3Lx85wLpOyYrxcYo+dmTnnqi2a8TPN8C1dgTwTYd9eVYyy2BwE3j1vPow
        UBgoXbXs8aevIHtKubinesoWyDEkHKB2Wjq27Hi8tz4H8LNkiR89kSFilDXbI8JWDqD07ccChqr1x
        eTF86mwmg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45302)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lwLb7-0007UH-0O; Thu, 24 Jun 2021 10:24:33 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lwLb0-0005bE-J6; Thu, 24 Jun 2021 10:24:26 +0100
Date:   Thu, 24 Jun 2021 10:24:26 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     13145886936@163.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        gushengxian <gushengxian@yulong.com>
Subject: Re: [PATCH] ARM: pxa: ssp: remove unnecessary print function
 dev_err()
Message-ID: <20210624092426.GQ22278@shell.armlinux.org.uk>
References: <20210624024139.23879-1-13145886936@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624024139.23879-1-13145886936@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 07:41:39PM -0700, 13145886936@163.com wrote:
> From: gushengxian <gushengxian@yulong.com>
> 
> The print function dev_err() is redundant because
> platform_get_irq() already prints an error.
> 
> Signed-off-by: gushengxian <gushengxian@yulong.com>
> ---
>  arch/arm/plat-pxa/ssp.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
> index 563440315acd..96b8765e4f57 100644
> --- a/arch/arm/plat-pxa/ssp.c
> +++ b/arch/arm/plat-pxa/ssp.c
> @@ -147,7 +147,6 @@ static int pxa_ssp_probe(struct platform_device *pdev)
>  
>  	ssp->irq = platform_get_irq(pdev, 0);
>  	if (ssp->irq < 0) {
> -		dev_err(dev, "no IRQ resource defined\n");
>  		return -ENODEV;
>  	}

Please also remove the now unnecessary braces around the return block.
Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
