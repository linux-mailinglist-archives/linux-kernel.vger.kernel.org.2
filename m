Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0A139539C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 03:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhEaBPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 21:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhEaBO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 21:14:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FC9C061574
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 18:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=EOkpvVLy8q5rA/U3L8o9G3KPJd8QKVTWK6ly0wZVXPg=; b=DokbNhlJcRUvX4evHUVIONfhms
        3GxQLGcaZfD99YBomPUuuHte9ezMeyTrtJp7moWUnrjfEUf+K1y9V++bs/a/ROOpDGb8kRPtYuFNo
        BKfZKjECr/wRFCjfA4YGr7tIbvqTgeymYWIKR1Fg651NIcXJEmkpzUONPRC92IPLvg9DB26w9cJk8
        GnbcrPEafot1EUlGzLp/iSUpC30XgtR2S5S9rFa8Wr2T3lE8Lz0UW5S07wEEhy/3xQBWNOhPqGm2G
        MVTy1xhDy85YbIxKmHzOt/Kvn1K56TKlES2C3GwAK5vcTEBAPFMCUKXRqaILRGAeKOX+S/lrY2sUH
        U5hdsOag==;
Received: from [2601:1c0:6280:3f0::ce7d]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lnWUU-00AQ0t-5j; Mon, 31 May 2021 01:13:14 +0000
Subject: Re: ERROR: modpost: "__delay" [drivers/net/mdio/mdio-cavium.ko]
 undefined!
From:   Randy Dunlap <rdunlap@infradead.org>
To:     kernel test robot <lkp@intel.com>, Andrew Lunn <andrew@lunn.ch>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rich Felker <dalias@libc.org>
References: <202105300736.7wVLvXHr-lkp@intel.com>
 <a0edf640-ec05-524e-9125-44decba27bbb@infradead.org>
Message-ID: <d4c47108-f4d2-4850-14fd-b4c4bd0e0591@infradead.org>
Date:   Sun, 30 May 2021 18:13:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <a0edf640-ec05-524e-9125-44decba27bbb@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/21 5:05 PM, Randy Dunlap wrote:
> On 5/29/21 4:25 PM, kernel test robot wrote:
>> Hi Andrew,
>>
>> First bad commit (maybe != root cause):
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   df8c66c4cfb91f2372d138b9b714f6df6f506966
>> commit: a9770eac511ad82390b9f4a3c1728e078c387ac7 net: mdio: Move MDIO drivers into a new subdirectory
>> date:   9 months ago
>> config: sh-allmodconfig (attached as .config)
>> compiler: sh4-linux-gcc (GCC) 9.3.0
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a9770eac511ad82390b9f4a3c1728e078c387ac7
>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>         git fetch --no-tags linus master
>>         git checkout a9770eac511ad82390b9f4a3c1728e078c387ac7
>>         # save the attached .config to linux build tree
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=sh 
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>, old ones prefixed by <<):
>>
>>>> ERROR: modpost: "__delay" [drivers/net/mdio/mdio-cavium.ko] undefined!

Should we make this one driver depend on !SUPERH ?


> 
> Just a comment here.  kernel test robot has reported this issue
> 5 times in 2021 that I know of -- and I could have missed some.
> 
> I see that Geert recently (June 2020) reverted the
> EXPORT_SYMBOL(__delay) in arch/sh/lib/delay.c, with this comment:
> 
>     __delay() is an internal implementation detail on several architectures.
>     Drivers should not call __delay() directly, as it has non-standardized
>     semantics, or may not even exist.
>     Hence there is no need to export __delay() to modules.
> 
>     See also include/asm-generic/delay.h:
>     
>         /* Undefined functions to get compile-time errors */
>         ...
>         extern void __delay(unsigned long loops);
> 
> However, s/several architectures/all but one architecture: SH/.
> All architectures except for SH provide either an exported function,
> an inline function, or a macro for __delay(). Yeah, they probably
> don't all do the same delay.
> 

-- 
~Randy

