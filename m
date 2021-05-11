Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E60937A994
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 16:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbhEKOjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 10:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbhEKOjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 10:39:41 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC6CC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 07:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DiD4PYOAZotxD7EMjb8IDN4lhvwYB03jaL8Cc5l1R6Q=; b=GRda7b/YKuTLA3kQQ1V0ii2hF
        Vyr6MijmBwewwfRTyzYiQxUAsPAC/QcBrBGj9xz4yIKXo3jqbvwSedLcSoL/WsYTGiKTYA/1UYNlN
        kFTpld5NAFtSs/RlTtlL8ZjORLV7y2PFEq8Y4vKlS6dDXkhZnTny1yMxdVK7clS5rNR5t1RXp1VY5
        7MKTlR95RtFiKxl9YqQODD7AooNO/8L2H9Z63zSwtLc1UyRr2W6xedkoPVaRUZIaLDxwAHsf8QQVS
        gLwnXqczqH2yttPwo5HB+pkN4TM2Yihapy9uVY2p4Gx3O0j6K4ZmvOPN6FLvbDx1clByY0qGT3kdE
        JawHGxubA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43860)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lgTWI-0002jF-NN; Tue, 11 May 2021 15:37:58 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lgTWD-00019C-4d; Tue, 11 May 2021 15:37:53 +0100
Date:   Tue, 11 May 2021 15:37:53 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hailong Liu <carver4lio@163.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: mark prepare_page_table as __init
Message-ID: <20210511143752.GK1336@shell.armlinux.org.uk>
References: <20210511090318.478586-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511090318.478586-1-arnd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 11:03:13AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> In some configurations when building with gcc-11, prepare_page_table
> does not get inline, which causes a build time warning for a section
> mismatch:
> 
> WARNING: modpost: vmlinux.o(.text.unlikely+0xce8): Section mismatch in reference from the function prepare_page_table() to the (unknown reference) .init.data:(unknown)
> The function prepare_page_table() references
> the (unknown reference) __initdata (unknown).
> This is often because prepare_page_table lacks a __initdata
> annotation or the annotation of (unknown) is wrong.
> 
> Mark the function as __init to avoid the warning regardless of the
> inlining.

I think if we're doing this, it would probably also be a good idea to
drop the "inline" as well, and just let the compiler decide?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
