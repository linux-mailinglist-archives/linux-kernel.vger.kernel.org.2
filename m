Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62913B8D71
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 07:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbhGAFkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 01:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbhGAFkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 01:40:21 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECA9C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 22:37:51 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id b12so3788816pfv.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 22:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=LKUXWb2rBeM5K5/NYqhjzjCyk25gIHmuSp3zZKAsfwM=;
        b=u2IS3e10FG1GD47P660k5uGo33LXlovwLziuh2ZtN2RJJN5tsp7KHEn9p2cZPnQLib
         tDPmAS+jTYlT90FNvg8dIVwVMpQXaZ6AMS97+3WPUYMK1U2NW0M0e8BXShO8oAVFhZdE
         PQHa9jDFqsRzkDkkRiUOwXRSPeClx1vVRP12wlX+DbE6YuAEdGIvQHUvIy3ltjlLIWEg
         I9QP3yCjTHyaGRz0JFQTPEETN4Xj0Qf62X6yeAvlwHLrSiaq9iuedZskI2kdSZqf6ly6
         mjWQEgLkVLpIC7xsCsC07xaGxn8DpPPnUoRfxeZgCovtX6SjRtXD15uIAI+iGpJyWiVH
         HkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=LKUXWb2rBeM5K5/NYqhjzjCyk25gIHmuSp3zZKAsfwM=;
        b=tLORT2VMv41WIxvajX34XtDCQIL3sskp5maDZzhzti1dOnlFilXuClUuXsnDPV+KlE
         p90IGDwTwvnb1JbPs7aDKYrpr+6Dl5AbKAkHltuzLkPhUcZV1iV9tnsm3mDcFjc58LGN
         /GYxNucrvywZvF9iINpZtNIQ31V5N98ldSTwSMI7f+LFWOYTHQS7sS84fTmJrgcVL3yB
         bN653JmNC9ykm+rt+vObDhhZFCoZPLCyyzRYAirTJNVdLafnaM3uDx1YreEwwuGBlDhb
         AkG1Dy3CIEzeHWAcWxYoRjpMYks2/cYkeLx3L9DMsb3mJCZoo0hSF2Js9eDZvxZkybdS
         3qng==
X-Gm-Message-State: AOAM532TwjqGdyJ8C7PXhdDGh8FU2mAieOuiciNDWzEDW6X2iB/oLblA
        kixR+bg6Yp/NBJTmRumQ5WdKZg==
X-Google-Smtp-Source: ABdhPJzsEBR5uFgCIFkOhQ1RPDFoLWD3+/29t3TwfroaZOx7LPDc68hfp7XjHNKw9GbUKLM/HMQTnA==
X-Received: by 2002:a63:1308:: with SMTP id i8mr38134510pgl.19.1625117870449;
        Wed, 30 Jun 2021 22:37:50 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id x27sm19057331pgl.74.2021.06.30.22.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 22:37:49 -0700 (PDT)
Date:   Wed, 30 Jun 2021 22:37:49 -0700 (PDT)
X-Google-Original-Date: Wed, 30 Jun 2021 22:37:43 PDT (-0700)
Subject:     Re: [PATCH v8 0/2] Map the kernel with correct permissions the first time 
In-Reply-To: <20210624120041.2786419-1-alex@ghiti.fr>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        jszhang@kernel.org, Christoph Hellwig <hch@infradead.org>,
        zong.li@sifive.com, anup@brainfault.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        alex@ghiti.fr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-0f00c990-c928-4a9d-ab2c-5036b29b2861@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2021 05:00:39 PDT (-0700), alex@ghiti.fr wrote:
> The kernel permissions are fixed after the kernel page table is created:
> avoid that by mapping the kernel 'correctly' the first time.
>
> Patch 1 introduces a new helper to set kernel mapping permissions while
> avoiding all the casts when using set_memory_* API.
>
> Patch 2  is the bulk of this work and deals with mapping the kernel with
> the right permissions.
>
> Changes in v8:
> * Move set_kernel_memory inline function into set_memory.h header as suggested
>   by Jisheng
> * Make set_kernel_memory arguments name consistent
>
> Changes in v7:
> * Split long lines and reintroduce parameters names of set_kernel_memory
>   callback, as suggested by Christoph
> * Make set_kernel_memory __always_inline as suggested by Christoph
> * Change 64b spelling into 64-bit, as suggested by Christoph
>
> Changes in v6:
> * load_sz was placed in init section but is now used in kernel address
>   conversions macros, so remove this attribute.
>
> Changes in v5:
> * Remove non-relevant commits to this patchset that raised issues
> * Make load_sz non-static as it is used in kernel address conversions
>   macros
> * Rebased on top for-next
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
> Alexandre Ghiti (2):
>   riscv: Introduce set_kernel_memory helper
>   riscv: Map the kernel with correct permissions the first time
>
>  arch/riscv/include/asm/page.h       |  13 +++-
>  arch/riscv/include/asm/sections.h   |  17 +++++
>  arch/riscv/include/asm/set_memory.h |  24 ++++--
>  arch/riscv/kernel/setup.c           |  12 +--
>  arch/riscv/mm/init.c                | 112 ++++++++++++----------------
>  5 files changed, 97 insertions(+), 81 deletions(-)

I had what looks to be two earlier versions of these patches on 
for-next.  I've fixed that up, but there were some merge conflicts.  
Let me know if there were any issues, but it's really getting too late 
in the cycle to be rebasing so I'd prefer just a fixup.

Thanks!
