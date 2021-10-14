Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A7542E148
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 20:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhJNSdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 14:33:14 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:37551 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhJNSdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 14:33:12 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 9666D1BF205;
        Thu, 14 Oct 2021 18:31:00 +0000 (UTC)
Subject: Re: [PATCH] kasan: Always respect CONFIG_KASAN_STACK
To:     Nathan Chancellor <nathan@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     elver@google.com, akpm@linux-foundation.org,
        ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, ndesaulniers@google.com,
        Arnd Bergmann <arnd@arndb.de>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-mm@kvack.org
References: <YUyWYpDl2Dmegz0a@archlinux-ax161>
 <mhng-b5f8a6a0-c3e8-4d25-9daa-346fdc8a2e5e@palmerdabbelt-glaptop>
 <YWhg8/UzjJsB51Gd@archlinux-ax161>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <afeaea5f-70f2-330f-f032-fb0c8b5d0aa5@ghiti.fr>
Date:   Thu, 14 Oct 2021 20:31:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YWhg8/UzjJsB51Gd@archlinux-ax161>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

Le 14/10/2021 à 18:55, Nathan Chancellor a écrit :
> On Fri, Oct 08, 2021 at 11:46:55AM -0700, Palmer Dabbelt wrote:
>> On Thu, 23 Sep 2021 07:59:46 PDT (-0700), nathan@kernel.org wrote:
>>> On Thu, Sep 23, 2021 at 12:07:17PM +0200, Marco Elver wrote:
>>>> On Wed, 22 Sept 2021 at 22:55, Nathan Chancellor <nathan@kernel.org> wrote:
>>>>> Currently, the asan-stack parameter is only passed along if
>>>>> CFLAGS_KASAN_SHADOW is not empty, which requires KASAN_SHADOW_OFFSET to
>>>>> be defined in Kconfig so that the value can be checked. In RISC-V's
>>>>> case, KASAN_SHADOW_OFFSET is not defined in Kconfig, which means that
>>>>> asan-stack does not get disabled with clang even when CONFIG_KASAN_STACK
>>>>> is disabled, resulting in large stack warnings with allmodconfig:
>>>>>
>>>>> drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c:117:12:
>>>>> error: stack frame size (14400) exceeds limit (2048) in function
>>>>> 'lb035q02_connect' [-Werror,-Wframe-larger-than]
>>>>> static int lb035q02_connect(struct omap_dss_device *dssdev)
>>>>>             ^
>>>>> 1 error generated.
>>>>>
>>>>> Ensure that the value of CONFIG_KASAN_STACK is always passed along to
>>>>> the compiler so that these warnings do not happen when
>>>>> CONFIG_KASAN_STACK is disabled.
>>>>>
>>>>> Link: https://github.com/ClangBuiltLinux/linux/issues/1453
>>>>> References: 6baec880d7a5 ("kasan: turn off asan-stack for clang-8 and earlier")
>>>>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>>>>
>>>> Reviewed-by: Marco Elver <elver@google.com>
>>>
>>> Thanks!
>>>
>>>> [ Which tree are you planning to take it through? ]
>>>
>>> Gah, I was intending for it to go through -mm, then I cc'd neither
>>> Andrew nor linux-mm... :/ Andrew, do you want me to resend or can you
>>> grab it from LKML?
>>
>> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
>>
>> (assuming you still want it through somewhere else)
> 
> Thanks, it is now in mainline as commit 19532869feb9 ("kasan: always
> respect CONFIG_KASAN_STACK").
> 
>>>> Note, arch/riscv/include/asm/kasan.h mentions KASAN_SHADOW_OFFSET in
>>>> comment (copied from arm64). Did RISC-V just forget to copy over the
>>>> Kconfig option?
>>>
>>> I do see it defined in that file as well but you are right that they did
>>> not copy the Kconfig logic, even though it was present in the tree when
>>> RISC-V KASAN was implemented. Perhaps they should so that they get
>>> access to the other flags in the "else" branch?
>>
>> Ya, looks like we just screwed this up.  I'm seeing some warnings like
>>
>>     cc1: warning: ‘-fsanitize=kernel-address’ with stack protection is not supported without ‘-fasan-shadow-offset=’ for this target
> 
> Hmmm, I thought I did a GCC build with this change but I must not have
> :/
> 
>> which is how I ended up here, I'm assuming that's what you're talking about
>> here?  LMK if you were planning on sending along a fix or if you want me to
>> go figure it out.
> 
> I took a look at moving the logic into Kconfig like arm64 before sending
> this change and I did not really understand it well enough to do so. I
> think it would be best if you were able to do that so that nothing gets
> messed up.
> 

I'll do it tomorrow, I'm the last one who touched kasan on riscv :)

Thanks,

Alex

> Cheers,
> Nathan
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
