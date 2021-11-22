Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744514592DA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 17:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239469AbhKVQVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 11:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhKVQVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 11:21:15 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39B6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 08:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=24LjR7gSAjMhRN/vywVP1+SlgTQtcn8P8tFurSL+i2o=; b=LPbs3R9yHEGt5XVWTVcNGe9NSb
        SsTfagyVS204f1CijpQwuVjOmklRJOHVeASb7QPcEIzTkzHFTrFCVcUatC94rwY63vFBKxAzQjS/4
        HciZnMMPOvKyn9IPyXoFigDgJzxcaSgc8162QdYDSpByRmD74lp1o9a+UuhA30GK+QWdsvU12m7Z+
        PGjCtvwBiURAJ1lmFLuWPxmOfC28lD5BrInXMPZ/7lLbus4CCt5G5Pk44UuQa9COQYPdr68yDrxuK
        bKkSoSqOQP3bmb61mPI88qrgm5GVVz0SROWRNj4yYDfs0PT92N7w+dNkHCuz2Q9EAdYh6EmQkzfr7
        SH0zNF0Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55792)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mpC11-0006u7-3J; Mon, 22 Nov 2021 16:17:59 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mpC0y-0007pI-Vn; Mon, 22 Nov 2021 16:17:56 +0000
Date:   Mon, 22 Nov 2021 16:17:56 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: ptrace: Use bitfield helpers
Message-ID: <YZvCtN/WNyogs9JZ@shell.armlinux.org.uk>
References: <a1445d3abb45cfc95cb1b03180fd53caf122035b.1637593297.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1445d3abb45cfc95cb1b03180fd53caf122035b.1637593297.git.geert+renesas@glider.be>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 04:53:41PM +0100, Geert Uytterhoeven wrote:
> The isa_mode() macro extracts two fields, and recombines them into a
> single value.  The shift value of the J-bit may look off-by-one to the
> casual reader, as it is the net result of the extraction and
> recombination steps.

I'd recommend avoiding the suggestion that the explicit "- 1" could
be misinterpreted as an off-by-one error.

>  #define isa_mode(regs) \
> -	((((regs)->ARM_cpsr & PSR_J_BIT) >> (__ffs(PSR_J_BIT) - 1)) | \
> -	 (((regs)->ARM_cpsr & PSR_T_BIT) >> (__ffs(PSR_T_BIT))))
> +	((FIELD_GET(PSR_J_BIT, (regs)->ARM_cpsr) << 1) | \

I'd suggest getting rid of the extra unnecessary parens there.
Too many parens leads to a decrease in readability.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
