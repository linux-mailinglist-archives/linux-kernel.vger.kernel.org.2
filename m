Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83EBB395366
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 02:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhEaAHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 20:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhEaAH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 20:07:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDADC061574
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 17:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=QBFeJEWLhkxc/qcZZjtAt+DcK86QhzK9y3LBbESmMYk=; b=LErk/5ROteKtog3Q1kW3P3H8As
        xMjuY+S8w+T++0/cybeca+ILc/03tS1T8G8Z7cIyXGDfnREL7RltsvLGzDDrgpb8+r2xEmkT5n8+8
        yeipD8UpNDhKOWT1rEKCzEHs0uxzxzPz0zH5VyAnAfkSx4XYe5pnYoCsEb/eCDIlRe9thmJ+ItSVr
        6Zn9crNqMJ1imt9QxnkEu7bhqLMag2wWZT+rtjyNA9pcJ2kfgQkNj6vBE0kMjGW/FZQyGO5ZGlbg9
        tCGThlzjk3JPuNRShkLsRs2cF0cYTjbU4S7mAHaux/3XnRR9oWsL1oTRr/oIb0NyUi/g/v9vkP4Cx
        iBbFiLVw==;
Received: from [2601:1c0:6280:3f0::ce7d]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lnVR9-00AL8e-PM; Mon, 31 May 2021 00:05:43 +0000
Subject: Re: ERROR: modpost: "__delay" [drivers/net/mdio/mdio-cavium.ko]
 undefined!
To:     kernel test robot <lkp@intel.com>, Andrew Lunn <andrew@lunn.ch>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rich Felker <dalias@libc.org>
References: <202105300736.7wVLvXHr-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a0edf640-ec05-524e-9125-44decba27bbb@infradead.org>
Date:   Sun, 30 May 2021 17:05:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <202105300736.7wVLvXHr-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/21 4:25 PM, kernel test robot wrote:
> Hi Andrew,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   df8c66c4cfb91f2372d138b9b714f6df6f506966
> commit: a9770eac511ad82390b9f4a3c1728e078c387ac7 net: mdio: Move MDIO drivers into a new subdirectory
> date:   9 months ago
> config: sh-allmodconfig (attached as .config)
> compiler: sh4-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a9770eac511ad82390b9f4a3c1728e078c387ac7
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout a9770eac511ad82390b9f4a3c1728e078c387ac7
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=sh 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
>>> ERROR: modpost: "__delay" [drivers/net/mdio/mdio-cavium.ko] undefined!

Just a comment here.  kernel test robot has reported this issue
5 times in 2021 that I know of -- and I could have missed some.

I see that Geert recently (June 2020) reverted the
EXPORT_SYMBOL(__delay) in arch/sh/lib/delay.c, with this comment:

    __delay() is an internal implementation detail on several architectures.
    Drivers should not call __delay() directly, as it has non-standardized
    semantics, or may not even exist.
    Hence there is no need to export __delay() to modules.

    See also include/asm-generic/delay.h:
    
        /* Undefined functions to get compile-time errors */
        ...
        extern void __delay(unsigned long loops);

However, s/several architectures/all but one architecture: SH/.
All architectures except for SH provide either an exported function,
an inline function, or a macro for __delay(). Yeah, they probably
don't all do the same delay.

-- 
~Randy

