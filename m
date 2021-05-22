Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4E738D695
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 19:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhEVRQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 13:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbhEVRQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 13:16:59 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15820C061574
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 10:15:34 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id v13so12540739ple.9
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 10:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=bumDb/hx+SGF/3ZOf+oQUyiA5GdTYW0dGDsrfTfTKto=;
        b=HKiQ2q/Oa7xiiKcVMCa7AvIAt9lPn/A6g7V2Uq/Vg8hrn7R+rfYNUlohVddpscTyNU
         V5Au+cNL/SvvHTwX72CFR2LU0A+VngyqTuIFSn7Y+0ahorvakRAkEjVNOzlWkXTn9JBq
         oQEJcXE14jwDfLPV1UJ0DwfWZ4w2PbhO05S14kNDYimegwyn70HLU2T7bH4XG21OcyEU
         I8M/ckYHnu43cawhO5emUvxWmVTHEibrRDe/Q7Utbb3nIjGEJjAmEpCvXoksAAdRiSKN
         Olw7goXxW60jbAaZA0PIljJGGpvwZ/2JZgDfYGVv5amow52CQFURrSZ1kNGNIocWKZKb
         Sk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=bumDb/hx+SGF/3ZOf+oQUyiA5GdTYW0dGDsrfTfTKto=;
        b=WlCddk5hOAPXHIJfwpMHNS7F9H7o66SV/H/NO5Wt2Klg+mcrKfjiH5GUONB23/2rxH
         MQMAJsFtcYyW5OjAfXiUi19McwN19URz4p5LZQd/iTs5LMkRpBc5L5RZhdfOIet4oIA/
         0knQkbHCu3Z/W7sVtuCLsWExMZF6pRFU74+fklUVaiTF9hKpjN7ohAoVCWw0Eut3DT9b
         GZFiaH6oAEa0l8G/Jz/KVGDJr8A3mfOBCpLFTMZZtV2q1wXRx5H/fwxoiKHI+v8yrFGN
         YRQZAY0I9t0rERj1VHhz6mTt9M5OH/m2DlaNe2oR54DeRyJw12Sf7FCLJfxBEFClA7kf
         viqg==
X-Gm-Message-State: AOAM531JfQGkXCHYezqRfhASwU2f4JKzKhucsaNNk58THuZFLfLYnjLd
        VsmWxGBaGLe3VQTBxcrMkJ1/Eg==
X-Google-Smtp-Source: ABdhPJznFfwkyGma5JO+7bDUDKAIsuGWCzbs9XnmRYVhhpZpD8vBb1vKiyEXpx8qRGUM50oIFQHTLw==
X-Received: by 2002:a17:902:b406:b029:ec:fbf2:4114 with SMTP id x6-20020a170902b406b02900ecfbf24114mr17994784plr.32.1621703733350;
        Sat, 22 May 2021 10:15:33 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id r11sm7203513pgl.34.2021.05.22.10.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 10:15:32 -0700 (PDT)
Date:   Sat, 22 May 2021 10:15:32 -0700 (PDT)
X-Google-Original-Date: Sat, 22 May 2021 10:15:28 PDT (-0700)
Subject:     Re: [PATCH] riscv: code patching only works on !XIP_KERNEL
In-Reply-To: <CAM4kBBJqF=AxTu50PF=EshLSyqn0=yeC2dwf4JJj_Grsi_Tccg@mail.gmail.com>
CC:     jszhang3@mail.ustc.edu.cn,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     vitaly.wool@konsulko.com
Message-ID: <mhng-1c10179a-d96b-4cf1-860a-03f0313ac980@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2021 11:19:30 PDT (-0700), vitaly.wool@konsulko.com wrote:
> On Mon, May 10, 2021 at 6:35 PM Jisheng Zhang <jszhang3@mail.ustc.edu.cn> wrote:
>>
>> From: Jisheng Zhang <jszhang@kernel.org>
>>
>> Some features which need code patching such as KPROBES, DYNAMIC_FTRACE
>> KGDB can only work on !XIP_KERNEL. Add dependencies for these features
>> that rely on code patching.
>
> Since we can define extra RW sections to place some tiny code bits in
> RAM, I would suggest that you hold back this patch for a while.
> I am not going to support the idea of e. g. compiling KGDB support
> into a XIP kernel, but disabling the whole HAVE_ARCH_JUMP_LABEL is
> hardly the way to go.

Do you have any updates on this?  The SOC_SIFIVE disable thread floated 
back to the top of my inbox and I didn't see anything there.  I'd prefer 
to avoid chasing around Kconfig disables for a bunch of stuff that we're 
just going to fix soon, but if this is going to be a big change then 
it's likely for next cycle anyway so in that case I'll start picking up 
these compile disable patches.

Not trying to rush any thing here, just don't want to have a bunch of 
broken configs.

>
> Best regards,
>    Vitaly
>
>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>> ---
>> Hi,
>>
>> Currently, the RISCV_ERRATA_ALTERNATIVE also only works on !XIP_KERNEL
>> but from the maillist it seem there's effort to make the co-exist, so
>> I drop RISCV_ERRATA_ALTERNATIVE dependency on !XIP_KERNEL.
>>
>> Thanks
>>
>>  arch/riscv/Kconfig | 18 +++++++++---------
>>  1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index a8ad8eb76120..61320b94ef97 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -60,11 +60,11 @@ config RISCV
>>         select GENERIC_TIME_VSYSCALL if MMU && 64BIT
>>         select HANDLE_DOMAIN_IRQ
>>         select HAVE_ARCH_AUDITSYSCALL
>> -       select HAVE_ARCH_JUMP_LABEL
>> -       select HAVE_ARCH_JUMP_LABEL_RELATIVE
>> +       select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
>> +       select HAVE_ARCH_JUMP_LABEL_RELATIVE if !XIP_KERNEL
>>         select HAVE_ARCH_KASAN if MMU && 64BIT
>>         select HAVE_ARCH_KASAN_VMALLOC if MMU && 64BIT
>> -       select HAVE_ARCH_KGDB
>> +       select HAVE_ARCH_KGDB if !XIP_KERNEL
>>         select HAVE_ARCH_KGDB_QXFER_PKT
>>         select HAVE_ARCH_MMAP_RND_BITS if MMU
>>         select HAVE_ARCH_SECCOMP_FILTER
>> @@ -79,9 +79,9 @@ config RISCV
>>         select HAVE_GCC_PLUGINS
>>         select HAVE_GENERIC_VDSO if MMU && 64BIT
>>         select HAVE_IRQ_TIME_ACCOUNTING
>> -       select HAVE_KPROBES
>> -       select HAVE_KPROBES_ON_FTRACE
>> -       select HAVE_KRETPROBES
>> +       select HAVE_KPROBES if !XIP_KERNEL
>> +       select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
>> +       select HAVE_KRETPROBES if !XIP_KERNEL
>>         select HAVE_PCI
>>         select HAVE_PERF_EVENTS
>>         select HAVE_PERF_REGS
>> @@ -230,11 +230,11 @@ config ARCH_RV64I
>>         bool "RV64I"
>>         select 64BIT
>>         select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && GCC_VERSION >= 50000
>> -       select HAVE_DYNAMIC_FTRACE if MMU && $(cc-option,-fpatchable-function-entry=8)
>> +       select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-option,-fpatchable-function-entry=8)
>>         select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
>> -       select HAVE_FTRACE_MCOUNT_RECORD
>> +       select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
>>         select HAVE_FUNCTION_GRAPH_TRACER
>> -       select HAVE_FUNCTION_TRACER
>> +       select HAVE_FUNCTION_TRACER if !XIP_KERNEL
>>         select SWIOTLB if MMU
>>
>>  endchoice
>> --
>> 2.31.0
>>
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
