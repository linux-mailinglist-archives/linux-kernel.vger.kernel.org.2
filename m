Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83158394E2D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhE2Uju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhE2Ujs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:39:48 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6590C061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:38:11 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id 69so3272000plc.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=nQPaH6kG3QdNq74eFLfWexfThSN9M42Oh4SfpVk0D5w=;
        b=z12bCbaCCIRQzFvYHBxDX/v9qdOUnb/7vT5APuXzjhv4lG0djahQIat7KpNPsA4Ser
         VYef58Fz/wA+ZZLeDL5IkNQjHzxc8l2LodFogwyxkcJIIhuqwS0ArSknATNV2AOafeQJ
         kND9u7AjL0duPYXDBpDJuqq5Fn0xWM32IJX/nZ3NLa9e3tKQTwXrUELNPL5wrx/Yg59i
         WFjnUPVHDvd64ogXBMmqTb/x4E7Xf2ve0ioxzlZuuiefqMt8Cwtll0683ItFq18B1vCv
         lQKlG3LK0z68dvHPtnracZdmcgVDyf1sJQTeEQhIllq9vuagFu4IFZfKNY803IfGtq0F
         TEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=nQPaH6kG3QdNq74eFLfWexfThSN9M42Oh4SfpVk0D5w=;
        b=AD2PUC/Ie2Ba8JVyeStWrOda8HsXkxqVein0iaKM5jGZ3YdoEXG0enCq8AlLwzgU0E
         869t6LRyZHigf3I+uxIhxc74B33fmV6ZqVU9FRcn7TJJg/RJJih6KNCNshJC+Ycvt+xr
         VcoQFFOrzf1yD2C2qx0n+g4ES0OYxbRU9ArvYTjSEqi8CDHOF4G94cbRgRVWxqRQsHCN
         kWEwKE5pra5FBrzfKXmL08uB5Wb7QU+pnRgOky5IjAP/jh13Ty3RSHXe7qqLr181zV0l
         kLAjKa8N4jg/h2dGKfPtD2BwGCIYL698IlFInCbbsS5rS7VcDODjZb5rhevNepR4RoVw
         0iJw==
X-Gm-Message-State: AOAM5332/MeS7PBaiRLoKGBsZ289PJHhGvpmelvhcy2SDfWym/4C0BMe
        8hzOGaHwfcldYhyWMSxbQ8OMug==
X-Google-Smtp-Source: ABdhPJy6geY+bi8Bvls5E8KipeNwzpNfnsWtzza2LxPLK6EPXXwvXA3vRRl/H6at+2dY6ZOJNJ+/WQ==
X-Received: by 2002:a17:90a:d496:: with SMTP id s22mr11215477pju.146.1622320691420;
        Sat, 29 May 2021 13:38:11 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id f5sm7017567pjp.37.2021.05.29.13.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:38:10 -0700 (PDT)
Date:   Sat, 29 May 2021 13:38:10 -0700 (PDT)
X-Google-Original-Date: Sat, 29 May 2021 13:37:33 PDT (-0700)
Subject:     Re: [PATCH] riscv: mm: Fix W+X mappings at boot
In-Reply-To: <20210520173859.7441aed8@xhacker.debian>
CC:     drew@beagleboard.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, alex@ghiti.fr, jszhang3@mail.ustc.edu.cn,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        tekkamanninja@gmail.com, emil.renner.berthing@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Jisheng.Zhang@synaptics.com
Message-ID: <mhng-e8b40095-7ee6-47eb-aeb7-bffa216d855a@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2021 02:38:59 PDT (-0700), Jisheng.Zhang@synaptics.com wrote:
> On Wed, 19 May 2021 21:55:40 -0700
> Drew Fustini <drew@beagleboard.org> wrote:
>
>>
>>
>> On Sun, May 16, 2021 at 05:00:38PM +0800, Jisheng Zhang wrote:
>> > From: Jisheng Zhang <jszhang@kernel.org>
>> >
>> > When the kernel mapping was moved the last 2GB of the address space,
>> > (__va(PFN_PHYS(max_low_pfn))) is much smaller than the .data section
>> > start address, the last set_memory_nx() in protect_kernel_text_data()
>> > will fail, thus the .data section is still mapped as W+X. This results
>> > in below W+X mapping waring at boot. Fix it by passing the correct
>> > .data section page num to the set_memory_nx().
>> >
>> > [    0.396516] ------------[ cut here ]------------
>> > [    0.396889] riscv/mm: Found insecure W+X mapping at address (____ptrval____)/0xffffffff80c00000
>> > [    0.398347] WARNING: CPU: 0 PID: 1 at arch/riscv/mm/ptdump.c:258 note_page+0x244/0x24a
>> > [    0.398964] Modules linked in:
>> > [    0.399459] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.13.0-rc1+ #14
>> > [    0.400003] Hardware name: riscv-virtio,qemu (DT)
>> > [    0.400591] epc : note_page+0x244/0x24a
>> > [    0.401368]  ra : note_page+0x244/0x24a
>> > [    0.401772] epc : ffffffff80007c86 ra : ffffffff80007c86 sp : ffffffe000e7bc30
>> > [    0.402304]  gp : ffffffff80caae88 tp : ffffffe000e70000 t0 : ffffffff80cb80cf
>> > [    0.402800]  t1 : ffffffff80cb80c0 t2 : 0000000000000000 s0 : ffffffe000e7bc80
>> > [    0.403310]  s1 : ffffffe000e7bde8 a0 : 0000000000000053 a1 : ffffffff80c83ff0
>> > [    0.403805]  a2 : 0000000000000010 a3 : 0000000000000000 a4 : 6c7e7a5137233100
>> > [    0.404298]  a5 : 6c7e7a5137233100 a6 : 0000000000000030 a7 : ffffffffffffffff
>> > [    0.404849]  s2 : ffffffff80e00000 s3 : 0000000040000000 s4 : 0000000000000000
>> > [    0.405393]  s5 : 0000000000000000 s6 : 0000000000000003 s7 : ffffffe000e7bd48
>> > [    0.405935]  s8 : ffffffff81000000 s9 : ffffffffc0000000 s10: ffffffe000e7bd48
>> > [    0.406476]  s11: 0000000000001000 t3 : 0000000000000072 t4 : ffffffffffffffff
>> > [    0.407016]  t5 : 0000000000000002 t6 : ffffffe000e7b978
>> > [    0.407435] status: 0000000000000120 badaddr: 0000000000000000 cause: 0000000000000003
>> > [    0.408052] Call Trace:
>> > [    0.408343] [<ffffffff80007c86>] note_page+0x244/0x24a
>> > [    0.408855] [<ffffffff8010c5a6>] ptdump_hole+0x14/0x1e
>> > [    0.409263] [<ffffffff800f65c6>] walk_pgd_range+0x2a0/0x376
>> > [    0.409690] [<ffffffff800f6828>] walk_page_range_novma+0x4e/0x6e
>> > [    0.410146] [<ffffffff8010c5f8>] ptdump_walk_pgd+0x48/0x78
>> > [    0.410570] [<ffffffff80007d66>] ptdump_check_wx+0xb4/0xf8
>> > [    0.410990] [<ffffffff80006738>] mark_rodata_ro+0x26/0x2e
>> > [    0.411407] [<ffffffff8031961e>] kernel_init+0x44/0x108
>> > [    0.411814] [<ffffffff80002312>] ret_from_exception+0x0/0xc
>> > [    0.412309] ---[ end trace 7ec3459f2547ea83 ]---
>> > [    0.413141] Checked W+X mappings: failed, 512 W+X pages found
>> >
>> > Fixes: 2bfc6cd81bd17e43 ("riscv: Move kernel mapping outside of linear mapping")
>> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>> > ---
>> >  arch/riscv/mm/init.c | 8 ++++++--
>> >  1 file changed, 6 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> > index 4faf8bd157ea..4c4c92ce0bb8 100644
>> > --- a/arch/riscv/mm/init.c
>> > +++ b/arch/riscv/mm/init.c
>> > @@ -746,14 +746,18 @@ void __init protect_kernel_text_data(void)
>> >       unsigned long init_data_start = (unsigned long)__init_data_begin;
>> >       unsigned long rodata_start = (unsigned long)__start_rodata;
>> >       unsigned long data_start = (unsigned long)_data;
>> > -     unsigned long max_low = (unsigned long)(__va(PFN_PHYS(max_low_pfn)));
>> > +#if defined(CONFIG_64BIT) && defined(CONFIG_MMU)
>> > +     unsigned long end_va = kernel_virt_addr + load_sz;
>> > +#else
>> > +     unsigned long end_va = (unsigned long)(__va(PFN_PHYS(max_low_pfn)));
>> > +#endif
>> >
>> >       set_memory_ro(text_start, (init_text_start - text_start) >> PAGE_SHIFT);
>> >       set_memory_ro(init_text_start, (init_data_start - init_text_start) >> PAGE_SHIFT);
>> >       set_memory_nx(init_data_start, (rodata_start - init_data_start) >> PAGE_SHIFT);
>> >       /* rodata section is marked readonly in mark_rodata_ro */
>> >       set_memory_nx(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
>> > -     set_memory_nx(data_start, (max_low - data_start) >> PAGE_SHIFT);
>> > +     set_memory_nx(data_start, (end_va - data_start) >> PAGE_SHIFT);
>> >  }
>> >
>> >  void mark_rodata_ro(void)
>> > --
>> > 2.31.0
>> >
>
>
>
>> I know there is a new thread now with a different approach but I wanted
>> to say that this did fix that warning on the BeagleV Starlight beta
>> prototype board [1] with the StarFive JH7100 SoC [2]. I am using Emil's
>> starlight branch [3] which is a set of StarFive patches on top of
>> 5.13-rc2. Emil included this W+X mapping patch [4]. It does fix the
>> warning on boot for me and the bootlog [5] shows:
>>
>>   [    2.302598] Checked W+X mappings: passed, no W+X pages found
>>
>> Thus if useful, here is my TB:
>>
>> Tested-by: Drew Fustini <drew@beagleboard.org>
>>
>
> Thank you. Alex's solution is better. It ensures there's no W+X mapping
> from the beginning. So far, riscv's STRICT_KERNEL_RWX method is to create
> W+X mapping from the beginning but remove W or X attribute at the end of kernel
> booting. Alex's solution changes STRICT_KERNEL_RWX method, one effective side
> of it is fixing this W+X mapping. I'm not sure whether Alex's patch should
> be merged in this cycle or next window since rc1 is released.
>
> Two choice to fix:
> Merge this small fix for linux-5.13 and bring Alex's patch for linux-next

I'm going to do this.  That way we keep can fix the bug now.  I've put 
this on a branch that I've merged into fixes, it looks like Alex is 
going to send a v3 so I'll wait on that.

Thanks!

>
> Or
>
> Use Alex's patch directly.
>
>
> I would leave the decision to riscv maintainers.
>
> Thanks
