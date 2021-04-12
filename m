Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B176135B7AC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 02:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbhDLANz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 20:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbhDLANy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 20:13:54 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69F2C061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 17:13:37 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id z22-20020a17090a0156b029014d4056663fso6105316pje.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 17:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jiuyang-me.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lsO9wDeiKRkCueWk+Uo59AFUAIZUeyl1sLeiaU6tHFA=;
        b=K2tDKT4xzKymCVMPHvadEmcdm0a1x8aLaFoaG5MQe4e+Xn4naDTC8Nc4pWtKyrJr6I
         nsYRKKUxGh5KXWI2W/y/eSPFdEayyrUthlmURylu2FRDZwPiU0TJ11OVnEAWcxePPppS
         76FPVpEbVWhS83sfB07nICWhN79knF5+DCYzT55maZbR2g1FB0SW7HIkwM9ThR5fdjPr
         VmpoWZRS7BJA7ePSqyVKXSNLdbf8JNMpUnOGvDfdFuaSdTzkTGwE6/8ozdM3BXpPnelE
         qXmhnUL/ME5/HjtRgqFvztDLS8n1l/32covStYD23HhzzKI0s24igywkHmyA+78upGAS
         LcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lsO9wDeiKRkCueWk+Uo59AFUAIZUeyl1sLeiaU6tHFA=;
        b=gEoJEXsuPD9pUEtFMcQ5/FQzV8PddmPWCcGA6gGka6xrlcsWVxrIcGTrhTjsEQq3VM
         HaAsBr4vuD82GMoQtyfwUWHRu9HiQfzryDUGy+3qHkdelYs9VEEu3pSbKlJvCd0eQDiy
         PN1kDbgBr2gR/X7k9DsmH2dWkfSsUZSR3YmOPaNQ7IrkPQTxxkcDr/Gc1nqWpSx9Kaay
         8X7KMoV4r5yMX9FrQY3iypskrwX59Z7OwDxUJBKDDC1ly942Opvcxazsdml2ombLSKxR
         4n8Mw5Kiej7T7vI65ipVrZsCxXY5PjXKtUId54DuiO/QLWhtH9XxyQKHxNtL3FxwiCvn
         yQTA==
X-Gm-Message-State: AOAM533LyuHyCFkFcWwtjfgOCKsZLtoAH2OM5xTJLrefVrjPTWOKfP20
        eWezUmPqv9NFLPyEOhz91KlgwQ==
X-Google-Smtp-Source: ABdhPJyIkZY1Ik8aSQCpIbtdPVUxw1S+J4AL0nTIcAjIJvi9oH/F9v5OD5U4iRqMNKfJYgnrQVlBHQ==
X-Received: by 2002:a17:90a:29a5:: with SMTP id h34mr22019900pjd.158.1618186417547;
        Sun, 11 Apr 2021 17:13:37 -0700 (PDT)
Received: from nuc.localnet ([193.110.201.196])
        by smtp.gmail.com with ESMTPSA id n52sm8308138pfv.13.2021.04.11.17.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 17:13:37 -0700 (PDT)
From:   Jiuyang Liu <liu@jiuyang.me>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     alex@ghiti.fr, waterman@eecs.berkeley.edu,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, akpm@linux-foundation.org,
        geert@linux-m68k.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] implement flush_cache_vmap and flush_cache_vunmap for RISC-V
Date:   Mon, 12 Apr 2021 00:13:32 +0000
Message-ID: <1846750.LAPMfGk2HC@nuc>
In-Reply-To: <mhng-92e28f5c-ced0-4a92-949f-0fd865c0bbf5@palmerdabbelt-glaptop>
References: <mhng-92e28f5c-ced0-4a92-949f-0fd865c0bbf5@palmerdabbelt-glaptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, April 11, 2021 9:41:07 PM UTC you wrote:
> On Sun, 28 Mar 2021 18:55:09 PDT (-0700), liu@jiuyang.me wrote:
> > This patch implements flush_cache_vmap and flush_cache_vunmap for
> > RISC-V, since these functions might modify PTE. Without this patch,
> > SFENCE.VMA won't be added to related codes, which might introduce a bug
> > in some out-of-order micro-architecture implementations.
> > 
> > Signed-off-by: Jiuyang Liu <liu@jiuyang.me>
> > ---
> > 
> >  arch/riscv/include/asm/cacheflush.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/riscv/include/asm/cacheflush.h
> > b/arch/riscv/include/asm/cacheflush.h index 23ff70350992..4adf25248c43
> > 100644
> > --- a/arch/riscv/include/asm/cacheflush.h
> > +++ b/arch/riscv/include/asm/cacheflush.h
> > @@ -8,6 +8,14 @@
> > 
> >  #include <linux/mm.h>
> > 
> > +/*
> > + * flush_cache_vmap and flush_cache_vunmap might modify PTE, needs
> > SFENCE.VMA. + * - flush_cache_vmap is invoked after map_kernel_range()
> > has installed the page table entries. + * - flush_cache_vunmap is invoked
> > before unmap_kernel_range() deletes the page table entries
> These should have line breaks.
Fixed in the newest patch, thanks for pointing out.
> 
> > + */
> > +#define flush_cache_vmap(start, end) flush_tlb_all()
> 
> We shouldn't need cache flushes for permission upgrades: the ISA allows
> the old mappings to be visible until a fence, but the theory is that
> window will be sort for reasonable architectures so the overhead of
> flushing the entire TLB will overwhelm the extra faults.  There are a
> handful of places where we preemptively flush, but those are generally
> because we can't handle the faults correctly.
Got it, I removed this. 
> If you have some benchmark that demonstrates a performance issue on real
> hardware here then I'm happy to talk about this further, but this
> assumption is all over arch/riscv so I'd prefer to keep things
> consistent for now.
We are using riscv-boom + FireSim setting up a benchmark environment, I can 
try it after setting this.
> > +#define flush_cache_vunmap(start, end) flush_tlb_all()
> 
> This one does seem necessary.
> 
> > +
> > 
> >  static inline void local_flush_icache_all(void)
> >  {
> >  
> >  	asm volatile ("fence.i" ::: "memory");




