Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882CF37A9FB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 16:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhEKO4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 10:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbhEKO4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 10:56:43 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38650C06174A;
        Tue, 11 May 2021 07:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=X8lDMzJEEbXETyVQFtFTx8ZhSJFE1TZtWKxi3YFPp0c=; b=toF8HtbtqJXqfoBCRkXfHJJnN
        bHuW1jFiDft5IunD0UGQxOp6uUWyDaAHqBZF6CUXEWfx5rlZ8ZLAi69tQwZTWenffikWdnQVtQ6zy
        GTtVzqT2WmStzeRXO7K73YC35ig06Abf41+kuIbfbAuHfBQuM4FU0MOm86aILtvui+M/LrWm+Jp6Q
        K2bpD0++pRGcaiMqhRJXaxzVhJ8B2aMH0E2BJZeIFl0s1evTfEWXYiT6IH1nBPfQQvtyIWXxalRpX
        Igi3anwmDEHCdkeG48pYVtgxYqbRLOI6jkH7ptCfZJ3mcI01CCDZIMZtiAftQM9Nii7WgDiOKZfS0
        e6kvjacKQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43868)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lgTnF-0002nL-Qc; Tue, 11 May 2021 15:55:29 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lgTnF-0001B9-JL; Tue, 11 May 2021 15:55:29 +0100
Date:   Tue, 11 May 2021 15:55:29 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Abbott Liu <liuwenliang@huawei.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm: Enlarge IO_SPACE_LIMIT needed for some SoC
Message-ID: <20210511145529.GN1336@shell.armlinux.org.uk>
References: <20210511021656.17719-1-ansuelsmth@gmail.com>
 <YJnq3Y3/I1kdV1Ov@casper.infradead.org>
 <YJnswvYFUjlNS7Fa@Ansuel-xps.localdomain>
 <CAMj1kXGLihr4gq3iwHy6mLKG4UHWnh5XAgxZDZmnmNPErfJ-bg@mail.gmail.com>
 <YJp1WYTXHsSAA0ES@Ansuel-xps.localdomain>
 <CAMj1kXHoc283aHT2EjxyRe8_cTWn_SUGoVLNKJ+40ia8Fppynw@mail.gmail.com>
 <YJp6mbJRMlN5yFC7@Ansuel-xps.localdomain>
 <CAMj1kXFDY0Go9yDXAfAiN8pm-q0qGSYaWNw0LVw044ErZ0zKvQ@mail.gmail.com>
 <YJp9w7FqxO6+SVT6@Ansuel-xps.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJp9w7FqxO6+SVT6@Ansuel-xps.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 02:51:15PM +0200, Ansuel Smith wrote:
> On Tue, May 11, 2021 at 02:46:49PM +0200, Ard Biesheuvel wrote:
> > OK, so the entire second host bridge fails to probe, because there is
> > no virtual address space left for the I/O window.
> > 
> > Just change the 'downstream I/O' window size in the DT to 64k
> > (0x10000) - I assume the current size (0x100000) is a typo anyway.
> 
> Ok, so my fear were right... someone just typo the IO when the dtsi was
> pushed and was wrong from all that times. Much easier and cleaner
> solution. 

Great news.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
