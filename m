Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058E1368C3F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 06:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhDWEkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 00:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhDWEkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 00:40:02 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF42C061574
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 21:39:25 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gq23-20020a17090b1057b0290151869af68bso519182pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 21:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=6J3S1EowMxNgodKbT6VuqOpLG5n59kYtaEQul9RuocM=;
        b=G6vbo+4Rdmql+OYi5hs8Gm22/IgtpWNS4R/rUQtCppbXNatRIHJSdGYL5+cg0N9YkO
         6g6Xax/aKtDB1oKsSv3VEuoJ1KYVuytBAMDmOI8DdzZW4nypqSdPzQjUNf9cvUOvzpGg
         UXJSDminP52VTMGOPkFaYCTO41nldXADgh+LcRxWoE6DrjzwwLyzPxoUVgYDuYCxVMg+
         QQiz3g4Z7NVTyBCE17gQXSRO3VDZ5FZ54E4FiA8lveGm+dfLwf4Kq+Y9L1QIH1eoWAYs
         73hSNzfhm8cnNl5n5zvZhidPdvYISA1NeaXa3MOA4LB7/Sa8fVlHxviDXb3tlM7W9SZY
         KQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=6J3S1EowMxNgodKbT6VuqOpLG5n59kYtaEQul9RuocM=;
        b=l3u3jHG+IWiw7hBXf57eHfGYY+BSkc5gXBkFBY0L1ikFfHd3bCbWLPNmrNitxpTllj
         C38QZi49q9HLE0qCZJDzG6SbOK4WHMr/T0nCXlufdGk+vDOnoY7bwbXbf6IFYr3/grfv
         lVzEH1UyCeVzgGWXgyqUI4tjLxf5YEFD2dVd6N/UcYq7YJ5gGKighzCctLpV/IDBUR3X
         e5d7u6q0phuCQN1yfQynJ4MedCFbMORYpiyHrIa85i0lLIZcoaoAFp8RPKyshQXqzQEo
         C8+U4DXYPs5QjVXj7Y934I52Hi0eZ+XiYg9HuiJPYyfRYD4l+uGJyCEbXdlVwAwAg0Sb
         ysfw==
X-Gm-Message-State: AOAM530k/lzyZ949yqh/aoP2o37UIUa/EiRDzYpvHNt8VzPNdfw+vI1E
        75l6AOtccoMgqZkwE5ibJi0LEA==
X-Google-Smtp-Source: ABdhPJxooiiHU5Bw3U0Jm6BQ2vbg4+eeLs8IAwR4giBk61hPyKTGAhXnRp+COmX4wuGdjiR3Yq8VhA==
X-Received: by 2002:a17:902:b687:b029:eb:6491:b3f7 with SMTP id c7-20020a170902b687b02900eb6491b3f7mr1962804pls.38.1619152765050;
        Thu, 22 Apr 2021 21:39:25 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id o5sm3518344pgq.58.2021.04.22.21.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 21:39:24 -0700 (PDT)
Date:   Thu, 22 Apr 2021 21:39:24 -0700 (PDT)
X-Google-Original-Date: Thu, 22 Apr 2021 21:39:21 PDT (-0700)
Subject:     Re: [PATCH] implement flush_cache_vmap for RISC-V
In-Reply-To: <18d198ac-7bc0-934d-e1e9-eca01b790d61@ghiti.fr>
CC:     Jisheng.Zhang@synaptics.com, liu@jiuyang.me,
        waterman@eecs.berkeley.edu,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, akpm@linux-foundation.org,
        geert@linux-m68k.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-12e52134-80b2-409c-bf30-1300875c54a2@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2021 00:03:13 PDT (-0700), alex@ghiti.fr wrote:
> Hi,
>
> Le 4/12/21 à 3:08 AM, Jisheng Zhang a écrit :
>> Hi Jiuyang,
>>
>> On Mon, 12 Apr 2021 00:05:30 +0000 Jiuyang Liu <liu@jiuyang.me> wrote:
>>
>>
>>>
>>> This patch implements flush_cache_vmap for RISC-V, since it modifies PTE.
>>> Without this patch, SFENCE.VMA won't be added to related codes, which
>>> might introduce a bug in the out-of-order micro-architecture
>>> implementations.
>>>
>>> Signed-off-by: Jiuyang Liu <liu@jiuyang.me>
>>> Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>
>>> Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>
>>
>> IIRC, Palmer hasn't given this Reviewed-by tag.

Yes.  In fact, I gave the opposite of a RB: we shouldn't have this, at 
least without some demonstration of a meaningful performance improvement 
and likely with a host of other changes to change the whole port over to 
avoid relying on traps to handle new mappings.  I really don't think 
that's a sane way to go, as the theory is that reasonable 
microarchitectures won't have big windows over which these faults can 
occur so there won't be that many of them.  If it ends up being an issue 
on real hardware we can try and sort something out, but it's going to be 
a lot of work as we'll need to avoid hurting performance on 
implementations that don't make invalid mappings visible often.

>>
>>> ---
>>
>> Could you plz add version and changes? IIRC, this is the v3.
>>
>>>   arch/riscv/include/asm/cacheflush.h | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
>>> index 23ff70350992..3fd528badc35 100644
>>> --- a/arch/riscv/include/asm/cacheflush.h
>>> +++ b/arch/riscv/include/asm/cacheflush.h
>>> @@ -30,6 +30,12 @@ static inline void flush_dcache_page(struct page *page)
>>>   #define flush_icache_user_page(vma, pg, addr, len) \
>>>          flush_icache_mm(vma->vm_mm, 0)
>>>
>>> +/*
>>> + * flush_cache_vmap is invoked after map_kernel_range() has installed the page
>>> + * table entries, which modifies PTE, SFENCE.VMA should be inserted.
>>
>> Just my humble opinion, flush_cache_vmap() may not be necessary. vmalloc_fault
>> can take care of this, and finally sfence.vma is inserted in related path.
>>
>
>
> I believe Palmer and Jisheng are right, my initial proposal to implement
> flush_cache_vmap is wrong.
>
> But then, Jiuyang should not have noticed any problem here, so what's
> wrong? @Jiuyang: Does implementing flush_cache_vmap fix your issue?
>
> And regarding flush_cache_vunmap, from Jisheng call stack, it seems also
> not necessary.

FWIW: I still think that flush_cache_vunmap() is necessary -- we don't 
have any other way to guarantee that mapping isn't visible.  Implementing 
flush_cache_vmap() could work around the real bug of lacking 
flush_cache_vunmap(), as we'd see stale mappings.

That said, it could just be covering up some other bug.  Wouldn't be 
surprised if it's a bug in our port, but this is the sort of thing that 
could also be a hardware bug of some sort.

>
> @Jiuyang: Can you tell us more about what you noticed?
>
>
>> Regards
>>
>>> + */
>>> +#define flush_cache_vmap(start, end) flush_tlb_all()
>>> +
>>>   #ifndef CONFIG_SMP
>>>
>>>   #define flush_icache_all() local_flush_icache_all()
>>> --
>>> 2.31.1
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>
