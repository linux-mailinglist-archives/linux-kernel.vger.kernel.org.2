Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992913BF356
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 03:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhGHBOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 21:14:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230106AbhGHBO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 21:14:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5847761C77;
        Thu,  8 Jul 2021 01:11:47 +0000 (UTC)
Subject: Re: [PATCH] m68k/coldfire: change pll var. to clk_pll
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        uclinux-dev@uclinux.org
References: <20210704230137.28915-1-rdunlap@infradead.org>
 <024360ce-41b2-c072-f399-7e87f516bfd0@linux-m68k.org>
 <CAK8P3a3sqC4nFsP=3cnz-zYjKRLHun5NSgSF31ZJErsYX7yP=g@mail.gmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <2d31fb13-818b-7a90-4071-9c36b50527d1@linux-m68k.org>
Date:   Thu, 8 Jul 2021 11:11:45 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3sqC4nFsP=3cnz-zYjKRLHun5NSgSF31ZJErsYX7yP=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/7/21 6:32 am, Arnd Bergmann wrote:
> On Wed, Jul 7, 2021 at 2:30 PM Greg Ungerer <gerg@linux-m68k.org> wrote:
>> On 5/7/21 9:01 am, Randy Dunlap wrote:
>>> DEFINE_CLK() makes the variable name be clk_xyz, so variable
>>> 'pll' should instead be 'clk_pll'.
>>>
>>> In file included from ../arch/m68k/coldfire/m525x.c:12:
>>> ../arch/m68k/coldfire/m525x.c:29:30: error: 'pll' undeclared here (not in a function)
>>>      29 |  CLKDEV_INIT(NULL, "pll.0", &pll),
>>>         |                              ^~~
>>> ../include/linux/clkdev.h:30:10: note: in definition of macro 'CLKDEV_INIT'
>>>      30 |   .clk = c, \
>>>         |          ^
>>> In file included from ../arch/m68k/coldfire/m525x.c:21:
>>> ../arch/m68k/include/asm/mcfclk.h:43:27: warning: 'clk_pll' defined but not used [-Wunused-variable]
>>>      43 |         static struct clk clk_##clk_ref = { \
>>>         |                           ^~~~
>>> ../arch/m68k/coldfire/m525x.c:25:1: note: in expansion of macro 'DEFINE_CLK'
>>>      25 | DEFINE_CLK(pll, "pll.0", MCF_CLK);
>>>         | ^~~~~~~~~~
>>>
>>> Fixes: 63aadb77669a ("m68k: coldfire: use clkdev_lookup on most coldfire")
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> Cc: Greg Ungerer <gerg@linux-m68k.org>
>>> Cc: linux-m68k@lists.linux-m68k.org
>>> Cc: uclinux-dev@uclinux.org
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>
>> Thanks Randy.
>>
>> Arnd: since this has hit mainline do you want me to pick it up
>> in the m68knommu git tree and push to Linus from there?
> 
> Yes, that would be good. Sorry I completely missed the bug report and the
> earlier fix.

No worries. I'll take care of it.

Regards
Greg

