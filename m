Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1522B397FB8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 05:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhFBDyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 23:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFBDyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 23:54:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C85AC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 20:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=bKAynGD2tUUdaAU1fnYCknAfecCQjYDg5jV7d/FYPpo=; b=3e1z+9kEDswLv7P6hllZ1EhHOl
        ZisyuhUc/12P19W0nXAJd5JzWu1rwBmeOMspp6kl8gUxai0B21nluyuKdiS7b2puAw06tq6oHhYVI
        MIkgEB8KOHcca4kxvGwhJOx7x+RyGCtNAPHwWTXOwaYIfmTdHdxSUT6CNgKF6pWT0hoORuvQYNJ7T
        6g8hDmBOGUz9m3j2Ilz0mRVJXCmc6r8kUz0WcYvCT85gehMgld16uRT/1wMWPy1F8rOjGic8HC9jK
        uWlp8HoUoSzj4CI65fYiQTbPNZnJvq1xQU4rsjd4gU6gu1DSxNU72MToKM2Sak5KaZnS1jQQK5+2a
        62Lj6U1A==;
Received: from [2601:1c0:6280:3f0::ce7d]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1loHvh-001kzt-Tt; Wed, 02 Jun 2021 03:52:30 +0000
Subject: Re: ERROR: modpost: "__delay" [drivers/net/mdio/mdio-cavium.ko]
 undefined!
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     David Daney <david.daney@cavium.com>,
        kernel test robot <lkp@intel.com>,
        Andrew Lunn <andrew@lunn.ch>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rich Felker <dalias@libc.org>
References: <202105300736.7wVLvXHr-lkp@intel.com>
 <a0edf640-ec05-524e-9125-44decba27bbb@infradead.org>
 <CAMuHMdUrG5AWRQ-ypU0NdjFTEttyguMWSCLyvGE0pikdLij2Dw@mail.gmail.com>
 <CAMuHMdW+e8qvKsf4Ub1zNnBgBX6TKGmUKHSDK0jy05H5gmrh+g@mail.gmail.com>
 <9db68758-1bf0-cec9-4914-ccb8439e2d1f@infradead.org>
 <CAMuHMdWiPjuf47=SBjNrQNjf4QiwDf6t0kkx_5BdPVoa22zxmw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <45d58448-9b6c-d1f5-7e19-7821c9241cff@infradead.org>
Date:   Tue, 1 Jun 2021 20:52:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWiPjuf47=SBjNrQNjf4QiwDf6t0kkx_5BdPVoa22zxmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/21 8:45 AM, Geert Uytterhoeven wrote:
> Hi Randy,
> 
> On Mon, May 31, 2021 at 5:12 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>> On 5/31/21 12:32 AM, Geert Uytterhoeven wrote:
>>> CC David (original author, asked by driver location change)
>>>
>>> On Mon, May 31, 2021 at 9:29 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>>>
>>>> On Mon, May 31, 2021 at 2:05 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>>> On 5/29/21 4:25 PM, kernel test robot wrote:
>>>>>> First bad commit (maybe != root cause):
>>>>>>
>>>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>>>>> head:   df8c66c4cfb91f2372d138b9b714f6df6f506966
>>>>>> commit: a9770eac511ad82390b9f4a3c1728e078c387ac7 net: mdio: Move MDIO drivers into a new subdirectory
>>>>>> date:   9 months ago
>>>>>> config: sh-allmodconfig (attached as .config)
>>>>>> compiler: sh4-linux-gcc (GCC) 9.3.0
>>>>>> reproduce (this is a W=1 build):
>>>>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>>>>         chmod +x ~/bin/make.cross
>>>>>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a9770eac511ad82390b9f4a3c1728e078c387ac7
>>>>>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>>>>         git fetch --no-tags linus master
>>>>>>         git checkout a9770eac511ad82390b9f4a3c1728e078c387ac7
>>>>>>         # save the attached .config to linux build tree
>>>>>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=sh
>>>>>>
>>>>>> If you fix the issue, kindly add following tag as appropriate
>>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>>>
>>>>>> All errors (new ones prefixed by >>, old ones prefixed by <<):
>>>>>>
>>>>>>>> ERROR: modpost: "__delay" [drivers/net/mdio/mdio-cavium.ko] undefined!
>>>>>
>>>>> Just a comment here.  kernel test robot has reported this issue
>>>>> 5 times in 2021 that I know of -- and I could have missed some.
>>>>>
>>>>> I see that Geert recently (June 2020) reverted the
>>>>> EXPORT_SYMBOL(__delay) in arch/sh/lib/delay.c, with this comment:
>>>>>
>>>>>     __delay() is an internal implementation detail on several architectures.
>>>>>     Drivers should not call __delay() directly, as it has non-standardized
>>>>>     semantics, or may not even exist.
>>>>>     Hence there is no need to export __delay() to modules.
>>>>>
>>>>>     See also include/asm-generic/delay.h:
>>>>>
>>>>>         /* Undefined functions to get compile-time errors */
>>>>>         ...
>>>>>         extern void __delay(unsigned long loops);
>>>>>
>>>>> However, s/several architectures/all but one architecture: SH/.
>>>>> All architectures except for SH provide either an exported function,
>>>>> an inline function, or a macro for __delay(). Yeah, they probably
>>>>> don't all do the same delay.
>>>>
>>>> Hence it must not be used by drivers, as it might give the false assumption
>>>> of working everywhere.  While drivers/net/mdio/mdio-cavium is
>>>> platform-specific, code might be copied in a new driver, less restricted
>>>> to a specific platform.
>>
>> Geert, should all (15) of the other arch EXPORT_SYMBOL(__delay); exports
>> be removed?  (in theory?  I'm not planning to remove them.)
> 
> It depends.  If they are internal implementation details of an
> architecture's mdelay() or udelay() function (i.e. the latter are
> static inline functions that may call into out-of-line __delay()
> functions), then they should be kept.
> 
> I haven't checked all of them, but e.g. on arm64, mdelay() and udelay()
> don't call into __delay, so IMHO its export should be removed.
> 
> Generic drivers should not use __delay() with a hardcoded value, as
> its semantics are not defined (cfr. the undefined function comment
> in asm-generic).

Thanks, Geert. I get it.

Hopefully David Daney will jump in here with a patch at some point.

-- 
~Randy

