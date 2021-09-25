Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2986E418350
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 17:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238418AbhIYP4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 11:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbhIYP4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 11:56:34 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAE3C061570
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 08:54:59 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id j195so12823855ybj.8
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 08:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=vVrbd0GlH8nKXHhxxNmtQyrLg1aP+cO+SPkH4BuRaFI=;
        b=GuiJIXyu4QYZaQIxnbt8gPsRabyXWXfOI5teHq1uH5vHqkxea2yCT28sHXomV9WZ+p
         ojfmjpiXAD5n3v3bch+uRnMzeD6JjwUEYDToKVFyc7LXnajNGKO49NzfXuUqXw7/Ctlv
         85HoqAo9P2BhMbjRqMQQsDhBML5uOzDq8GXcFDZyvfDXD03GBXC8cy8Ot0VCPiU1yfW1
         Kb+SEXzJlSbc49hhCZ8TnFJnd3AJDgQ4u+OX4NhJvIghZ4ysVQtSsRSMYH62k7LtQg/e
         FUUrsC1e1i+j9XLHYNIfiSPHuqZMqx1Fm5/DxXXkJEAanU6USFLtSQEAkYdXE6LcICgQ
         37Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=vVrbd0GlH8nKXHhxxNmtQyrLg1aP+cO+SPkH4BuRaFI=;
        b=bCIpYqj9UIgEEZtey6LgeMmV5KCTypZ+BKHTjWBzdEgC4rOF+www2HUbuhpaYwNjgx
         3ytfa58scvhVGiUatYoAGI6lysTtMWUCd29of4PDLn1R1q9+PE6piZWMXvtSTuemXZlp
         2LdffhIdBjKnL09eaoqa3uvj8+x2VzNYxqAHHJTtubMcT0Ts78ZsobfF1Yv1IrkYcKwI
         MhIg0eNWsrTGO8c5x9LWwZGhLpcqy3BqGAyEH4HrYPS+HHzVH3cxNFiaaHERTZQpP5Dw
         IrvtGRclfIje3MeJFxHS+fdprLGRursXWPf6wugcy7T/NMPUm1x89lZMUJ73meO1v/+5
         /JKQ==
X-Gm-Message-State: AOAM531Kqqad+YOwcnu0v96GCeIckBAx/PNEMDRP9xzdPTbrr88c0CWQ
        kpoy1hP3Btyq/eb5zhVb7V+0Cq45c6VGwaivwcrmVw==
X-Google-Smtp-Source: ABdhPJxMyo/HEajKd711jJrRicDZGRLr8VNTveo65pduC6l0IgOfvvLZQ/6jY4z3kA91lOQy7aQ8KkDx9V1UGb5rP9I=
X-Received: by 2002:a25:7c42:: with SMTP id x63mr7001204ybc.225.1632585298182;
 Sat, 25 Sep 2021 08:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <CANn89iL6AAyWhfxdHO+jaT075iOa3XcYn9k6JJc7JR2XYn6k_Q@mail.gmail.com>
In-Reply-To: <CANn89iL6AAyWhfxdHO+jaT075iOa3XcYn9k6JJc7JR2XYn6k_Q@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sat, 25 Sep 2021 08:54:46 -0700
Message-ID: <CANn89iLofTR=AK-QOZY87RdUZENCZUT4O6a0hvhu3_EwRMerOg@mail.gmail.com>
Subject: Re: [BUG] numa spreading of large hash tables no longer a thing
To:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 12:55 PM Eric Dumazet <edumazet@google.com> wrote:
>
> Hi Andrew and mm experts
>
> It seems recent kernels lost the NUMA spreading of large hash tables
> allocated at boot time.
>
> Does it ring a bell, was it intentional ?
> Thanks

I did a bisection and it went back to the following commit [1]

Probably the removal of

-               if (node == NUMA_NO_NODE)
-                       page = alloc_page(gfp_mask);
-               else
-                       page = alloc_pages_node(node, gfp_mask, 0);

had something to do with the regression.

Things got a little bit more complicated after the introduction of
bulk allocations.

[1]
commit 121e6f3258fe393e22c36f61a319be8a4f2c05ae
Author: Nicholas Piggin <npiggin@gmail.com>
Date:   Thu Apr 29 22:58:49 2021 -0700

    mm/vmalloc: hugepage vmalloc mappings

    Support huge page vmalloc mappings.  Config option HAVE_ARCH_HUGE_VMALLOC
    enables support on architectures that define HAVE_ARCH_HUGE_VMAP and
    supports PMD sized vmap mappings.

    vmalloc will attempt to allocate PMD-sized pages if allocating PMD size or
    larger, and fall back to small pages if that was unsuccessful.

    Architectures must ensure that any arch specific vmalloc allocations that
    require PAGE_SIZE mappings (e.g., module allocations vs strict module rwx)
    use the VM_NOHUGE flag to inhibit larger mappings.

    This can result in more internal fragmentation and memory overhead for a
    given allocation, an option nohugevmalloc is added to disable at boot.

    [colin.king@canonical.com: fix read of uninitialized pointer area]
      Link: https://lkml.kernel.org/r/20210318155955.18220-1-colin.king@canonical.com

    Link: https://lkml.kernel.org/r/20210317062402.533919-14-npiggin@gmail.com
    Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
    Cc: Borislav Petkov <bp@alien8.de>
    Cc: Catalin Marinas <catalin.marinas@arm.com>
    Cc: Christoph Hellwig <hch@lst.de>
    Cc: Ding Tianhong <dingtianhong@huawei.com>
    Cc: "H. Peter Anvin" <hpa@zytor.com>
    Cc: Ingo Molnar <mingo@redhat.com>
    Cc: Miaohe Lin <linmiaohe@huawei.com>
    Cc: Michael Ellerman <mpe@ellerman.id.au>
    Cc: Russell King <linux@armlinux.org.uk>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
    Cc: Will Deacon <will@kernel.org>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

 arch/Kconfig            |  11 +++
 include/linux/vmalloc.h |  21 +++++
 mm/page_alloc.c         |   5 +-
 mm/vmalloc.c            | 220 +++++++++++++++++++++++++++++++++++++-----------
 4 files changed, 209 insertions(+), 48 deletions(-)

>
> Old behavior
> otrv5:~# grep alloc_large_system_hash /proc/vmallocinfo
> 0x000000006381d67a-0x000000009bc8465a   12288
> alloc_large_system_hash+0xf1/0x290 pages=2 vmalloc N0=1 N1=1
> 0x000000009bc8465a-0x00000000b70c6dfc   12288
> alloc_large_system_hash+0xf1/0x290 pages=2 vmalloc N0=1 N1=1
> 0x00000000b70c6dfc-0x00000000ab13330f   12288
> alloc_large_system_hash+0xf1/0x290 pages=2 vmalloc N0=1 N1=1
> 0x000000008685d551-0x000000009ce0c789   12288
> alloc_large_system_hash+0xf1/0x290 pages=2 vmalloc N0=1 N1=1
> 0x000000004d87acca-0x00000000781b44e4  266240
> alloc_large_system_hash+0xf1/0x290 pages=64 vmalloc N0=32 N1=32
> 0x00000000dea0f2d2-0x00000000909e9fb3 268439552
> alloc_large_system_hash+0xf1/0x290 pages=65536 vmalloc vpages N0=32768
> N1=32768
> 0x00000000909e9fb3-0x00000000d23f4353  528384
> alloc_large_system_hash+0xf1/0x290 pages=128 vmalloc N0=64 N1=64
> 0x00000000d23f4353-0x000000003913e8bc 134221824
> alloc_large_system_hash+0xf1/0x290 pages=32768 vmalloc vpages N0=16384
> N1=16384
> 0x000000003913e8bc-0x000000007a60bcd6 4198400
> alloc_large_system_hash+0xf1/0x290 pages=1024 vmalloc vpages N0=512
> N1=512
> 0x000000007a60bcd6-0x0000000001bc8bf9 4198400
> alloc_large_system_hash+0xf1/0x290 pages=1024 vmalloc vpages N0=512
> N1=512
> 0x0000000001bc8bf9-0x0000000022629b89 4198400
> alloc_large_system_hash+0xf1/0x290 pages=1024 vmalloc vpages N0=512
> N1=512
> 0x0000000022629b89-0x0000000027d1b0a7 1052672
> alloc_large_system_hash+0xf1/0x290 pages=256 vmalloc N0=128 N1=128
> 0x0000000027d1b0a7-0x0000000027310068 4198400
> alloc_large_system_hash+0xf1/0x290 pages=1024 vmalloc vpages N0=512
> N1=512
> 0x0000000027310068-0x00000000a845050a 1052672
> alloc_large_system_hash+0xf1/0x290 pages=256 vmalloc N0=128 N1=128
> 0x00000000a845050a-0x0000000028b8c1bc 2101248
> alloc_large_system_hash+0xf1/0x290 pages=512 vmalloc N0=256 N1=256
> 0x0000000028b8c1bc-0x000000002aff2d3d 2101248
> alloc_large_system_hash+0xf1/0x290 pages=512 vmalloc N0=256 N1=256
>
> New behavior
> otrv6:~# grep alloc_large_system_hash /proc/vmallocinfo
> 0x00000000de22dded-0x000000006574cf88   12288
> alloc_large_system_hash+0x18c/0x272 pages=2 vmalloc N0=2
> 0x000000006574cf88-0x00000000bc158a1d   12288
> alloc_large_system_hash+0x18c/0x272 pages=2 vmalloc N0=2
> 0x00000000afa304a2-0x0000000009981fb8   12288
> alloc_large_system_hash+0x18c/0x272 pages=2 vmalloc N0=2
> 0x00000000e3ab78c1-0x00000000ddbeadf2  528384
> alloc_large_system_hash+0x18c/0x272 pages=128 vmalloc N0=128
> 0x0000000000cce551-0x0000000022096e73   12288
> alloc_large_system_hash+0x18c/0x272 pages=2 vmalloc N0=2
> 0x0000000072a43217-0x00000000cf0c05f7  266240
> alloc_large_system_hash+0x18c/0x272 pages=64 vmalloc N0=64
> 0x000000003f85e695-0x0000000042154f88 268439552
> alloc_large_system_hash+0x18c/0x272 pages=65536 vmalloc vpages
> N0=65536
> 0x0000000042154f88-0x0000000066fcdca2 134221824
> alloc_large_system_hash+0x18c/0x272 pages=32768 vmalloc vpages
> N0=32768
> 0x0000000066fcdca2-0x000000004074129c 4198400
> alloc_large_system_hash+0x18c/0x272 pages=1024 vmalloc vpages N0=1024
> 0x000000004074129c-0x00000000ca32b7f9 4198400
> alloc_large_system_hash+0x18c/0x272 pages=1024 vmalloc vpages N0=1024
> 0x00000000ca32b7f9-0x00000000a56b8117 4198400
> alloc_large_system_hash+0x18c/0x272 pages=1024 vmalloc vpages N0=1024
> 0x00000000a56b8117-0x0000000089e9e39e 2101248
> alloc_large_system_hash+0x18c/0x272 pages=512 vmalloc N0=512
> 0x0000000089e9e39e-0x0000000090a80b5a 1052672
> alloc_large_system_hash+0x18c/0x272 pages=256 vmalloc N0=256
> 0x0000000090a80b5a-0x00000000e84776cb 4198400
> alloc_large_system_hash+0x18c/0x272 pages=1024 vmalloc vpages N0=1024
> 0x00000000e84776cb-0x000000006cfc05bf 1052672
> alloc_large_system_hash+0x18c/0x272 pages=256 vmalloc N0=256
> 0x000000006cfc05bf-0x00000000f6ce3623 1576960
> alloc_large_system_hash+0x18c/0x272 pages=384 vmalloc N0=384
> 0x00000000f6ce3623-0x0000000002737823 2101248
> alloc_large_system_hash+0x18c/0x272 pages=512 vmalloc N0=512
> 0x0000000002737823-0x00000000d4e74269 2101248
> alloc_large_system_hash+0x18c/0x272 pages=512 vmalloc N0=512
