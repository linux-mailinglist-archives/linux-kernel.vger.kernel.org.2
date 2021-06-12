Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F253A4C87
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 05:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhFLD6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 23:58:55 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:46610 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFLD6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 23:58:54 -0400
Received: by mail-pl1-f179.google.com with SMTP id e1so3780660pld.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 20:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=3FaZDzHblAzL8JBweWZZrBo7nK587IM5WRBAEUnGg6c=;
        b=rNklwOX3qCziQjAy4oQo5ZWjieeD2uWc/Vkb3pyYSfWd3+1Iecv2KXZyIrIXimSq55
         UPD/+cf17zzzd82uqFsN9h8j1fNOXQSzKqjo+RfefoPzB486DBEOVnFgm0VV5CENAnT/
         50KqwvfwrNdofbzCYU9IzYxuWj5eairSbyoobLwmwWFNChDV13/QL96bvzCkEQ78rEsf
         FpRYFGDCRlIS8XyT2P9Jqva05TiBu3l/MMhNUfLKTztMxcOLcBG7/Omg02rlCD4nd4lD
         EEf4511enfGgXeUdLrVvuluDrnUWTer8f7Omgp/ib5Tik5v+gF3DqitQzJjS/17B+JSq
         stjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=3FaZDzHblAzL8JBweWZZrBo7nK587IM5WRBAEUnGg6c=;
        b=hn3BsYmEftNC8RJwo2lLLgDCuiVTZGNi87Z/tQtCwsvcInlQsm65j3cgSDUsO2Jp4S
         fPxihrmgZmNS1ELJIRp35+ICjzWrPBxOarrFgQGttb8CIqBSJL17V1tcQMmQyUDGqYgI
         wvqSdWDQyZov5jt1B/QF/RP5HHgjkQfbnFZ8J+qP5OaSUzgao9Cy1rd0JjGS2PdKsRbU
         4p5GqKirCkjcQgzvMygjPnvc44jqJvk/Fk5FrkqFEaMM28RY71lnLN386sQg5xrheiFp
         XJ6S5UcVVsMSMoPgMzipJSyv2MyU5w8O6ABYUazLJwcgU1ob4CakmCW08HS1Xxb1TUs8
         eCqQ==
X-Gm-Message-State: AOAM530udM2mUy2eGk8W9SlH+O/H/oZBJwprjS1l/KxpLeXPTaDS1uNL
        Mp9O3hihAOe2B2KAu0zyEztdRQ==
X-Google-Smtp-Source: ABdhPJyPmv0YDhakVI+qt1MU1sO2SiUVOM15iYJNHsCtaA9Vw9ubH3wlOqitg67p36ZZ7aGhgkGYmQ==
X-Received: by 2002:a17:90a:31c4:: with SMTP id j4mr12376759pjf.105.1623470140772;
        Fri, 11 Jun 2021 20:55:40 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id v22sm6229256pff.105.2021.06.11.20.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 20:55:39 -0700 (PDT)
Date:   Fri, 11 Jun 2021 20:55:39 -0700 (PDT)
X-Google-Original-Date: Fri, 11 Jun 2021 19:51:04 PDT (-0700)
Subject:     Re: [PATCH v4 0/4] riscv: Map the kernel with correct permissions the first time
In-Reply-To: <20210604114950.1446390-1-alex@ghiti.fr>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        jszhang@kernel.org, Christoph Hellwig <hch@infradead.org>,
        zong.li@sifive.com, anup@brainfault.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        alex@ghiti.fr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-42d061b3-a03b-411b-9b2e-be08031661c1@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Jun 2021 04:49:46 PDT (-0700), alex@ghiti.fr wrote:
> The kernel permissions are fixed after the kernel page table is created:
> avoid that by mapping the kernel 'correctly' the first time.
>
> Patch 2 is a cleanup patch on which the next patches are based on, not
> necessary for this patchset though and relies on patch 1.
>
> Patch 3 introduces a new helper to set kernel mapping permissions while
> avoiding all the casts when using set_memory_* API.
>
> Patch 4  is the bulk of this work and deals with mapping the kernel with
> the right permissions.
>
> Changes in v4:
> * Add patch 1 as noted by Jisheng
> * Changes patch 2 title as suggested by Anup
> * Add Reviewed-by from Anup
>
> Changes in v3:
> * Add a patch that factorizes kernel address conversions
> * Add a helper called set_kernel_memory in its own patch, as suggested by
>   Christoph
> * Prefer IS_ENABLED over #ifdef, as suggested by Christoph
> * Split overly long lines, as suggested by Christoph
> * Simplify kernel mapping by mapping ALL text as readonly and taking advantage
>   of already present code that enables write for init text before
>   free_initmem_default.
>
> Changes in v2:
> * Rebased on top of for-next (and "riscv: mm: fix build errors caused by
>   mk_pmd()")
> * Get rid of protect_kernel_linear_mapping_text_rodata as suggested by
>   Jisheng
> * Improve code in general compared to previous RFC
>
> Alexandre Ghiti (4):
>   riscv: Remove CONFIG_PHYS_RAM_BASE_FIXED
>   riscv: Simplify xip and !xip kernel address conversion macros
>   riscv: Introduce set_kernel_memory helper
>   riscv: Map the kernel with correct permissions the first time
>
>  arch/riscv/Kconfig                  |   6 --
>  arch/riscv/include/asm/page.h       |  27 ++++----
>  arch/riscv/include/asm/pgtable.h    |   2 +
>  arch/riscv/include/asm/sections.h   |  17 +++++
>  arch/riscv/include/asm/set_memory.h |  13 ++--
>  arch/riscv/kernel/setup.c           |  11 +--
>  arch/riscv/mm/init.c                | 102 ++++++++++++----------------
>  arch/riscv/mm/pageattr.c            |  10 +++
>  8 files changed, 95 insertions(+), 93 deletions(-)

Thanks, these are on for-next.  I had a few conflicts, let me know if 
something went wrong.
