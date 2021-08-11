Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC87C3E92B2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 15:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhHKNb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 09:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhHKNb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:31:56 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF053C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 06:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z/i7uQ6NKzurDPa7kL9kranXmn5doyAE8sAhZqvAspI=; b=coUue+pPIg0Yq4CHnDyn+K7Al
        Kho/NHvDSf05QcdOdTXMnJW3EbccdgpHkjtjFVREEiv0NPbmTUHb/gh/7lqL0ZuAkWhh1X3Ft4mK5
        WmIlbFl2nO4EXVyk0dsILamKbJYbNYuDTeGKh+c0UQvNiM/N+CUzNFlvuJT/YuUuHl0Ks36PEF26l
        fKKEMrAYKYlhIK+/Xvv2o0pT+c1oQZ54gUmwJcrDlkcAbwMNJerZPZKYbYdUI1jmsTgwQVN93eOTi
        N4+QyNilC3uAwbC8ANiwkGAL5qnLC29Xv8pOpqEoptyRuPiHU9/+qd4sXkhq23xGgEdnsSsY29zXV
        pUzcFF6GA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47182)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mDoKJ-0000Z6-1p; Wed, 11 Aug 2021 14:31:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mDoKI-0003Bu-QI; Wed, 11 Aug 2021 14:31:22 +0100
Date:   Wed, 11 Aug 2021 14:31:22 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM/smp_twd: Cleanup the unnecessary cast
Message-ID: <20210811133121.GV22278@shell.armlinux.org.uk>
References: <20210811131512.940-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811131512.940-1-tangbin@cmss.chinamobile.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 09:15:12PM +0800, Tang Bin wrote:
> It's not necessary to specify 'int' castingfor 'PTR_ERR(twd_clk)'.
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  arch/arm/kernel/smp_twd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> index 9a14f721a..423e9079d 100644
> --- a/arch/arm/kernel/smp_twd.c
> +++ b/arch/arm/kernel/smp_twd.c
> @@ -199,7 +199,7 @@ static void twd_get_clock(struct device_node *np)
>  		twd_clk = clk_get_sys("smp_twd", NULL);
>  
>  	if (IS_ERR(twd_clk)) {
> -		pr_err("smp_twd: clock not found %d\n", (int) PTR_ERR(twd_clk));
> +		pr_err("smp_twd: clock not found %d\n", PTR_ERR(twd_clk));

Sorry, NAK.

This change _will_ produce a compiler warning. "%d" expects an argument
of type "int", but PTR_ERR() returns a type of "long". Sorry, but the
cast is entirely necessary.

A better solution today would be to get rid of the PTR_ERR() entirely
and use %pe, which will get us a textual description of the error when
the appropriate kernel configuration option is enabled.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
