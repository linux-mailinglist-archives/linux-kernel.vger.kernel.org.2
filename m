Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A2E30F2A9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbhBDLqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbhBDLqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:46:20 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0823AC061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 03:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JGhVURvln/aI2r9tiRPahDvAcS6/jkWSFn2D77VPLeU=; b=dFRjefJBEbMh2cRlN7JhpLOnH
        JjeqGzRYQySK5TNV5E54n3VHqawx5pyNS1WZKSRntLzT4NB31aHvuxYZVmCNB129uih0y5qxj+E+p
        kId6f16iPz/kETZ/E0McmoJZhTv2jji7fNyOdCkMgy/21/hz3TJBbLftMDmjm9HIXX4k9yAakY+Jr
        fe1cHXxQZ+0SNSRhKpFY+4c99J+rrhv32KrQuWbVBEew6q5QVcuntzl9k7LAME31OtknDHudNId6Y
        Vs7Sen1OUvMf8RaVeyAG0uQxTYe+esxTF9YUmL/aqbbqqzSZbwQ25XUp91mqGk1+Nb4lgsh/74Hai
        9qqr/S8dw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39068)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1l7d4d-0006V8-GY; Thu, 04 Feb 2021 11:45:23 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1l7d3c-00058V-FB; Thu, 04 Feb 2021 11:44:20 +0000
Date:   Thu, 4 Feb 2021 11:44:20 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        "kernelci-results@groups.io" <kernelci-results@groups.io>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: next/master bisection: baseline.login on rk3288-rock2-square
Message-ID: <20210204114420.GW1463@shell.armlinux.org.uk>
References: <601b773a.1c69fb81.9f381.a32a@mx.google.com>
 <6c65bcef-d4e7-25fa-43cf-2c435bb61bb9@collabora.com>
 <CAMj1kXHMw5hMuV5VapcTeok3WJu1B79=Z3Xho0qda0nCqBFERA@mail.gmail.com>
 <20210204100601.GT1463@shell.armlinux.org.uk>
 <CAMj1kXFog3=5zD7+P=cRfRLj1xfD1h1kU58iifASBSXkRe-E6g@mail.gmail.com>
 <c0037472-75c8-6cf9-6ecf-e671fce9d636@collabora.com>
 <46373679-a149-8a3d-e914-780e4c6ff8be@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46373679-a149-8a3d-e914-780e4c6ff8be@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 11:32:05AM +0000, Guillaume Tucker wrote:
> Yes it does fix the issue:
> 
>   https://lava.collabora.co.uk/scheduler/job/3173819
> 
> with Ard's fix applied to this test branch:
> 
>   https://gitlab.collabora.com/gtucker/linux/-/commits/next-20210203-ard-fix/
> 
> 
> +clang +Nick
> 
> It's worth mentioning that the issue only happens with kernels
> built with Clang.  As you can see there are several other arm
> platforms failing with clang-11 builds but booting fine with
> gcc-8:

My gut feeling is that it isn't Clang specific - it's likely down to
the exact code/data placement, how things end up during decompression,
and exactly what state the cache ends up in.

That certainly was the case with the original regression.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
