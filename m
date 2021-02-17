Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8B831D956
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 13:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbhBQMXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 07:23:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:52032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232427AbhBQMXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 07:23:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFC8764E0F;
        Wed, 17 Feb 2021 12:22:21 +0000 (UTC)
Subject: Re: [SPAM?]Re: arch/m68k/68000/dragen2.c:73:16: error: 'screen_bits'
 undeclared
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <202102121331.d4C0ShlS-lkp@intel.com>
 <CAK8P3a3uM7rCbnJP9r2SFEjm0D7oy2YsXw7VcGzkg5tq7mQbag@mail.gmail.com>
 <2903dec9-b21d-9d91-0ad9-045bd9b2afd4@linux-m68k.org>
 <CAMuHMdVeErFJcngx6Jpznqd0Cm+Rb5OvgGdKjRi7Q8fNmgBA7g@mail.gmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <43ea12f4-5a54-2a13-95d3-503bd5557c17@linux-m68k.org>
Date:   Wed, 17 Feb 2021 22:22:19 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVeErFJcngx6Jpznqd0Cm+Rb5OvgGdKjRi7Q8fNmgBA7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 17/2/21 9:42 pm, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> On Wed, Feb 17, 2021 at 5:59 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
>> On 12/2/21 8:05 pm, Arnd Bergmann wrote:
>>> On Fri, Feb 12, 2021 at 6:48 AM kernel test robot <lkp@intel.com> wrote:
>>>> FYI, the error/warning still remains.
>>>
>>>>            |             ^~~~~~~~~~~~
>>>>      arch/m68k/68000/dragen2.c: In function 'init_dragen2':
>>>>>> arch/m68k/68000/dragen2.c:73:16: error: 'screen_bits' undeclared (first use in this function)
>>>>         73 |  LSSA = (long) screen_bits;
>>>>            |                ^~~~~~~~~~~
>>>>      arch/m68k/68000/dragen2.c:73:16: note: each undeclared identifier is reported only once for each function it appears in
>>>
>>> This problem existed before my patch, I just moved the line to another file.
>>> To fix it, one needs to test on real hardware and figure out what is supposed
>>> to go in there.
>>>
>>> The bug was apparently introduced in linux-2.5.70 in this commit:
>>   >
>>> commit 2b1a7e97c8c2d6330a432cbcaf83a0ef5fab848e
>>> Author: gerg <gerg>
>>> Date:   Mon May 26 16:45:57 2003 +0000
>>>
>>>       [PATCH] fix m68knommu DragonEngine2 target setup code
>>>
>>>       Numerous fixes for the m68knommu DragonEngine2 setup code.
>>>
>>>       It was out of date relative to more recent kernels.  Original patches
>>>       from Georges Menie.
>>>
>>>       BKrev: 3ed244c5dPVeFKP63b4kkeS_rEshag
>>
>> Digging around a bit I think the screen_bits data structure was
>> originally in a screen.h file that was generated from a screen.xbm file.
>> That was removed in commit 0c0e6db80683 ("m68k: drop unused parts of
>> 68VZ328 Makefile").
>>
>> Obviously no one seems to be using this, that has been broken for a long
>> time now.
>>
>> I could restore the generated screen.h here, so this could compile at
>> least. I don't have any of the hardware supported in the arch/m68k/68000
>> directory, so I can't test anything we fix in there.
> 
> Do you have the generated screen.h?
> Looks like both the tool (xbm2lcd.pl) and the source (screen.xbm)
> never made it upstream?

I have the tool (xbm2lcd.pl) and screen.xbm from a really old uClinux
distribution, and I can run it to generate the screen.h.
So yes, I have a screen.h now.


>> The other option is to remove the dragen code altogether.
> 
> Just remove the part protected by checks for CONFIG_INIT_LCD?

Yeah, or even all the dragen support if no one wants it anymore.

Easy enough to add the screen.h (probably rename it, since it is
dragen specific). And include that in dragen2.c.

Regards
Greg

