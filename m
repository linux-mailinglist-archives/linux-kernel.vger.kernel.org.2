Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D7538D70D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 20:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbhEVS45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 14:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhEVS44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 14:56:56 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C05FC061574
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 11:55:30 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 27so15630910pgy.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 11:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=PBEBzpg9msOXPzTQKT/dWbcjcMFg/plF1XqgYuF1BOc=;
        b=H0wH0sw5Be4k9+rZ2ZWodtQqyg56PZldBBHiY9jCZI+mi5EoBmMQkYj1qwQZ42DSCt
         BnjLQywzvqxJ5JTwRvq3YsMOfgiClxuDjkGm2LRvrsuD9XIPWrusRTmOoGK2YQcdKqNE
         JX3AasWFhNzNnPmQ04gwnpMR8wB7MHWjpODsT0diTdBGyA3f2KLQPGLmh2DVrLnvH49j
         P1MaDdZS+tzHRXdi28fnrkz7KmXSSr8G4jbhFm8++WIEIhV12piXBJ5rIvLnQ3DWFSPv
         YdFY/LAQ3Q7FGfmYpjEzHdiezLmivLRCNxh+ytfhsFG7OIguQitK5O5b6nMHfv6SsDDi
         TEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=PBEBzpg9msOXPzTQKT/dWbcjcMFg/plF1XqgYuF1BOc=;
        b=ZWaiukT7kitbbqecKgTclGucX86ZuoYWW3uANce5lI02ccqE4VC7JPeG6OSv662qNn
         3zxDxUqeZFO+C3/U8na1AKVxRv4GxWqTgB5kAcRe/9WBcsZmVk1iPlT9MDNeBPFddXJW
         vD+Y4SD0fuf1TRodE0SvAdUdh2M797agoZ1n9M8ZtDSZBq+1koCMApnvJbm6mnb1LYzI
         zmdII5k6BRCSvjIBZ5Qdq2c+YcrHDbo5s+wKRl5qPn0A4PE0KEv+O/uebFvn5rH1ybmE
         359WYOTqtsclqlZ9hY5QDjbwNpZTJTStCW8D9iCS69Y4q5D8sWx3j9VHq5qcmQ3Q+eIC
         Fjqw==
X-Gm-Message-State: AOAM5339g1EFMtx2QVIgwA/i8O5Xr098kfLA0dN1+7o5RjZUvSgrlZbo
        Xs14GPHPQU1nbi+iksgR+mbk4g==
X-Google-Smtp-Source: ABdhPJxwsckoqLAMui+4s8m4Rsm4xsMVudaNEfHg9xqCJTNnI2KZT3sqvL9+rF8K60wLc3JI08wtNg==
X-Received: by 2002:a05:6a00:216a:b029:2df:3461:4ac3 with SMTP id r10-20020a056a00216ab02902df34614ac3mr16175729pff.80.1621709729922;
        Sat, 22 May 2021 11:55:29 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id u22sm6929252pfl.118.2021.05.22.11.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 11:55:28 -0700 (PDT)
Date:   Sat, 22 May 2021 11:55:28 -0700 (PDT)
X-Google-Original-Date: Sat, 22 May 2021 11:55:26 PDT (-0700)
Subject:     Re: [PATCH -next 0/4] THP supprt for RISCV
In-Reply-To: <20210430082850.462609-1-sunnanyong@huawei.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Atish Patra <Atish.Patra@wdc.com>, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     sunnanyong@huawei.com
Message-ID: <mhng-a43b7855-77db-4be1-a3fd-8e2b59abe5be@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Apr 2021 01:28:46 PDT (-0700), sunnanyong@huawei.com wrote:
> This series brings transparent huge pages to RISCV on 64-bit.
>
> I have tested these testcases of vm selftest under qemu-riscv64:
> khugepaged
> split_huge_page_test
> transhuge-stress
>
> Nanyong Sun (4):
>   riscv: mm: add _PAGE_LEAF macro
>   riscv: mm: make pmd_bad() check leaf condition
>   riscv: mm: add param stride for __sbi_tlb_flush_range
>   riscv: mm: add THP support on 64-bit
>
>  arch/riscv/Kconfig                    |   1 +
>  arch/riscv/include/asm/pgtable-64.h   |   3 +-
>  arch/riscv/include/asm/pgtable-bits.h |   5 +
>  arch/riscv/include/asm/pgtable.h      | 164 +++++++++++++++++++++++++-
>  arch/riscv/mm/tlbflush.c              |  17 ++-
>  5 files changed, 178 insertions(+), 12 deletions(-)

Thanks, these are on for-next.
