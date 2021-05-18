Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4511A387872
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244396AbhERMIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbhERMIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:08:06 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4966C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=A0bnY9zwm+FBk1NHGMYRSCnW726sXdnf0iswF1lZG/M=; b=mN9TPGfrX+kwGFJLCI5PeyMKy
        lZo1hFDQnbmMzX5T09tHHEdtqDYcqirqKPEiBpvcxWZNAvdQSOiQxa8D/Ayf4IA8TPp67kWys8AuP
        wfu36V0OxMa9mpORDRMM2NA3IKLzJWsNJmwIpQ64AnJnCME6M2NycLC3oNufDjSA12mrprJvVZ9GP
        ekCNsIVnyX+8RCuSTeq/ztkJ6dJLQJuXDTX1P3jA+wRMt87o1kwUkEuF2u5VkGmEb75Ei6+gywgFg
        wwp0kDPfz23dTInfsRKxg04O4/xd36n5g8IoF5NWoSfdFwypRYCKmfOVipzRJtJGXGGwhyikPsWo7
        x1+oL2xkg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44136)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1liyUf-0004FG-9g; Tue, 18 May 2021 13:06:37 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1liyUb-0007si-5J; Tue, 18 May 2021 13:06:33 +0100
Date:   Tue, 18 May 2021 13:06:33 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Yanfei Xu <yanfei.xu@windriver.com>
Cc:     rppt@kernel.org, ardb@kernel.org, linus.walleij@linaro.org,
        akpm@linux-foundation.org, carver4lio@163.com,
        tiantao6@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: make the size of vmalloc in cmdline and meminfo
 uniform
Message-ID: <20210518120633.GW12395@shell.armlinux.org.uk>
References: <20210518111254.3820480-1-yanfei.xu@windriver.com>
 <20210518112932.GV12395@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518112932.GV12395@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 12:29:32PM +0100, Russell King (Oracle) wrote:
> On Tue, May 18, 2021 at 07:12:54PM +0800, Yanfei Xu wrote:
> > The value of "vmalloc=" set in cmdline is always 8M more than the value
> > of "VmallocTotal" in meminfo. When use the "vmalloc=" parameter, user
> > expect to get the size what they input, and no need to consider the 8M
> > "hole" hided in codes. This commit make real vmalloc size equal to value
> > of "vmalloc=" in cmdline.
> > 
> > Also, the commit will reduce the size of vmalloc printed in boot message
> > by 8M when the size set in cmdline is irrational.
> 
> Hi,
> 
> I think I'd like to do several cleanups with this:
> 
> 1. change vmalloc_min to be an unsigned long.
> 2. exclude VMALLOC_OFFSET from vmalloc_min, moving it into
>    adjust_lowmem_bounds where vmalloc_min is used.
> 3. rename vmalloc_min to be vmalloc_start
> 4. enforce vmalloc_start to be a multiple of 2MiB
> 5. in early_vmalloc(), calculate vmalloc_max as:
> 	VMALLOC_END - (PAGE_OFFSET + SZ_32M + VMALLOC_OFFSET)
>    and use that to set the upper bound of vmalloc_reserve (which is
>    something your patch doesn't do, which I think is a bug.
> 
> Thoughts?

I've slightly modified the above idea, and will shortly follow up with
some patches to show the idea a bit better...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
