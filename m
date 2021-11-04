Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381A54459AC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 19:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbhKDS07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 14:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbhKDS04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 14:26:56 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E430DC061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 11:24:17 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id p16so13785937lfa.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 11:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Drjex4BCzZzcGSa43EiuKsRpLjU3tkgoWhiUNLTwnVo=;
        b=Wpkdy3PLtZlZLPOafUHAkxn2EbtLQ6+4fDao3Wao2aWSstJx82EbyxQP8ll6MIXPg1
         bkhSoZCifr84VwVh6HOkCHoRMiy9tRmRKMleLKXGOyaPT8DVrnAKtBDDQYMY+A1P0z/Z
         28zI6P4vDT+a17DZPdhk+JzdfSXH28IVf1Gnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Drjex4BCzZzcGSa43EiuKsRpLjU3tkgoWhiUNLTwnVo=;
        b=75spIqu6ymq36dU1lANDYI9o/YfKSLyMk+cDqzoDfndTZf/0iOgGWU7NV91uReAtmz
         r5A0zqugTo8PpyGXK/YbvDS81dUcnwWooxWfZWwgQCCDmSWeE8H45O8O1AnsCCJTg5XG
         v9cCtSyUKacXc4x+QhWgziMdXut1D1ENIOPp8PyZ/B4AJyvPGdr7R4v0HDh4h3CZ/aU/
         lOaaA33s4tYY+GF10sEUS7WYzgOH5RoEK+jTkpdP7mPrZyWpc09zPcgQ6V9DH7vn4PgP
         MdwYyQrMhhIdTt6JwAfF8rwx/6PGdX+tC5fGzxsIjqOymur9T0TxZu9ST0vAXsBTa5Il
         T+EA==
X-Gm-Message-State: AOAM533NNBCIJq400+IOkoFr8d7TXR2O1vY+Hb4TNjDgxsqe4+4tQnBi
        ww33vUTDfAHz6fhmhdODKFt6jWa1f8h/cIK6
X-Google-Smtp-Source: ABdhPJyJAMCmR7q9b8BVgk3SBLk+u8RGlXMb9TSafR3HCZm785UdlTU6u+2XpXeutlY5nhG+R0oYMA==
X-Received: by 2002:ac2:4bc2:: with SMTP id o2mr48606110lfq.191.1636050255137;
        Thu, 04 Nov 2021 11:24:15 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id y1sm543162lfd.204.2021.11.04.11.24.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 11:24:13 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id v15so3871475ljc.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 11:24:12 -0700 (PDT)
X-Received: by 2002:a2e:a7d3:: with SMTP id x19mr27954480ljp.68.1636050252506;
 Thu, 04 Nov 2021 11:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <YYP1lAq46NWzhOf0@casper.infradead.org> <CAHk-=wiKac4t-fOP_3fAf7nETfFLhT3ShmRmBq2J96y6jAr56Q@mail.gmail.com>
 <YYQQPuhVUHqfldDg@arm.com> <CAHk-=wiDjjL50BBU=i8BFz3Rv5+-pGysEyCD+mcc_K_g0140oQ@mail.gmail.com>
 <YYQgvTn2NQdZK2Ku@arm.com>
In-Reply-To: <YYQgvTn2NQdZK2Ku@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Nov 2021 11:23:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjv--WRm9ay-D615xRwe+tUhZSg7dM0h32Rcf5TNMrD1g@mail.gmail.com>
Message-ID: <CAHk-=wjv--WRm9ay-D615xRwe+tUhZSg7dM0h32Rcf5TNMrD1g@mail.gmail.com>
Subject: Re: flush_dcache_page vs kunmap_local
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 4, 2021 at 11:04 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Luckily I don't think we have a (working) SMP system with VIVT caches.
> On UP, looking at arm, for VIVT caches it flushes the D-cache before
> kunmap_local() (arch_kmap_local_pre_unmap()). So any new kmap_local()
> would see the correct data even if it's in a different location.

Ok, good.

Yeah, because kmap_local and SMP really would seem to be a "that can't
work with VIVT".

> We still have VIVT processors supported in the kernel and a few where
> the VIPT cache is aliasing (some ARMv6 CPUs). On these,
> flush_dcache_page() is still used to ensure the user aliases are
> coherent with the kernel one, so it's not just about the I/D-cache
> coherency.

Maybe we could try to split it up and make each function have more
well-defined rules? One of the issues with the flush_dcache thing is
that it's always been so ad-hoc and it's not been hugely clear.

For example, people seem to think it's purely about flushing writes.
But for the virtual aliasing issue and kmap, you may need to flush
purely between reads too - just to make sure that you don't have any
stale contents.

That's why kunmap needs to have some unconditional cache flush thing
for the virtual aliasing issue.

But hey, it's entirely possible that it should *not* have that
"flush_dcache_page()" thing, but something that is private to the
architecture.

So VIVT arm (and whoever else) would continue to do the cache flushing
at kunmap_local time (or kmap - I don't think it matters which one you
do, as long as you make sure there are no stale contents from the
previous use of that address).

And then we'd relegate flush_dcache_page() purely for uses where
somebody modifies the data and wants to make sure it ends up being
coherent with subsequent uses (whether kmap and VIVT or I$/D$
coherency issues)?

> The cachetlb.rst doc states the two cases where flush_dcache_page()
> should be called:
>
> 1. After writing to a page cache page (that's what we need on arm64 for
>    the I-cache).
>
> 2. Before reading from a page cache page and user mappings potentially
>    exist. I think arm32 ensures the D-cache user aliases are coherent
>    with the kernel one (added rmk to confirm).

I think the "kernel cache coherency" matters too. The PTE contents
thing seems relevant if we use kmap for that...

So I do think that the "page cache or user mapping" is not necessarily
the only case.

But personally I consider these situations so broken at a hardware
level that I can't find it in myself to care too deeply.

Because user space with non-coherent I$/D$ should do its own cache
flushing if it does "read()" to modify an executable range - exactly
the same way it has to do it for just doing regular stores to that
range.

It really shouldn't be the kernel that cares at all.

             Linus
