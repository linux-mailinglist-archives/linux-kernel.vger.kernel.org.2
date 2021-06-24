Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB1C3B2B4B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhFXJZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbhFXJZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:25:46 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDA9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 02:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1pmChoBW4Vklc89y9mnmj8rHXFIWoQLJkt3ISHBJjPA=; b=cIrdSflpgvObNOuPNkvvmSK2X
        92wv8VMyb5eWMdC/0+q3TOemrhNqoPa5ftWcYAT6XL4EGYAzQaXjPJgIcgFbR8Zr3umsGAle5yu9G
        hFEkkwM/6XyfVoMETvuXpmfJ9A+uqhd9p5BDiuMXj6/S4tm4VWdh6IaY1T6NWQ+G034LIlesfkHoQ
        4vFVdzZmIWGfCv2aqC5QUoC1UwvopTjGPHW8mC0eALU/Y1Kf5be5X+xQwI5VfyKVMhRrx0LoAKptg
        ey0e6i/sOKwPD4Lb7PcsPEztX7+tlLDTLtWeYQrQlnnd8sq4znld5HBqiY4Ld3IIRiYTgp9pnokA+
        2ePNgP5Yw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45300)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lwLa1-0007U1-1E; Thu, 24 Jun 2021 10:23:25 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lwLZz-0005b3-V1; Thu, 24 Jun 2021 10:23:23 +0100
Date:   Thu, 24 Jun 2021 10:23:23 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: bL_switcher: use IS_ERR_OR_NULL() to simplify code
Message-ID: <20210624092323.GP22278@shell.armlinux.org.uk>
References: <20210624074223.11372-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624074223.11372-1-tangbin@cmss.chinamobile.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 03:42:23PM +0800, Tang Bin wrote:
> diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
> index 9a9aa5354..b8e8e2567 100644
> --- a/arch/arm/common/bL_switcher.c
> +++ b/arch/arm/common/bL_switcher.c
> @@ -352,11 +352,9 @@ int bL_switch_request_cb(unsigned int cpu, unsigned int new_cluster_id,
>  
>  	t = &bL_threads[cpu];
>  
> -	if (IS_ERR(t->task))
> -		return PTR_ERR(t->task);
> -	if (!t->task)
> -		return -ESRCH;
> -
> +	if (IS_ERR_OR_NULL(t->task))
> +		return t->task ? PTR_ERR(t->task) : -ESRCH;
> +
>  	spin_lock(&t->lock);
>  	if (t->completer) {
>  		spin_unlock(&t->lock);

I don't think this improves the code. The original is more readable, and
readability is what we care about rather than code compactness.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
