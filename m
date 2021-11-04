Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08BE445762
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 17:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbhKDQn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 12:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbhKDQny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 12:43:54 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF966C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 09:41:15 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id n13-20020a170902d2cd00b0014228ffc40dso2481302plc.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 09:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=B/Zu1r2lWoaGRs4vZ4DYzM83YZYEZ7XIPjfjvmaVSuQ=;
        b=ki3AaxqFOvGvvbJJZVr35PCVsFHsUCxZqbsEF1iDWMjKZKRWHNVpZlaeyll1xDRuqZ
         Fe9NsSq5NdIlDhb0JLDZfyM4lzNAJm+sMyKu7XG3OZnwhCX0lDAr0jFvnCTVlBd7Rlcf
         91yoEX88+q6nDsjG+XcTr8pjIQnVgIspEYZF36luc29Bya+BC7bNTBu763VhyOSfxu1/
         ZjYG+aZ9p9yMtavbux/GVKKU3aGIISPuiv5jHwBtGmAL06kN/HT7OfW5saTVeBTigG3Q
         3Ld0kCq2NzU5RRSSR7+xT2EDJ1GsS8+HpmW85Q3Hm2ukUg6jrEEJgklHclpTDmpPrHOL
         OSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=B/Zu1r2lWoaGRs4vZ4DYzM83YZYEZ7XIPjfjvmaVSuQ=;
        b=nXfBIMu9XlBK4INhPlttEq1D5AagJq9hR87+vPumldTsmEx8XPL4Fbq+n8a4DPws4I
         WXo9G5VvDLnJ4m4O62dMDPygZkib7leR07DGqceVG0ygA0fivF3DJW73O6VyjkS3SdYg
         SAR2znf8ZAwSFjhoHjFi53EjSB04KN56I0exIr7U01AeUlGK4xa8GUJ3FjkgxY70AY6G
         MmPQHXjC2Rw3TB309Ge7kAi+jRUw4X2bSEcAYEOK45/is+iMXoFb3Kykqy9r5/j63uFH
         vaY/fqz46ArM1ZnFOGST+r2Y0qR9zhhD2VyGtoU9afQeuioFsZusunNlN/Ow6qUKIalu
         94kA==
X-Gm-Message-State: AOAM530MY1mNDRQiDhGtRrnh/EIybQEd/WzTq48VqedSQkwYJ1FD2xr2
        VhPM+DnEs09isC/EzsfSPq0A9ft5dFA=
X-Google-Smtp-Source: ABdhPJyhpgJIbP/ZAmnJDHk9Tyo9aV2ayAs3W7Wg+/tcco9KaG6KLs6a+BwMRjVfrIktXi2iqzXjnoCxBEk=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a62:1bcc:0:b0:480:fcb7:76a9 with SMTP id
 b195-20020a621bcc000000b00480fcb776a9mr34631165pfb.22.1636044075227; Thu, 04
 Nov 2021 09:41:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  4 Nov 2021 16:41:05 +0000
Message-Id: <20211104164107.1291793-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH 0/2] KVM: RISC-V: MMU bug fix and cleanup
From:   Sean Christopherson <seanjc@google.com>
To:     Anup Patel <anup.patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bug fix and a cleanup for things I noticed by inspection when working on
the scalable memslots series.  Regarding the fix, unless there's a magic
unmapping hiding in the corners of the MMU, RISC-V completely fails to
handle memslot DELETE or MOVE.

Compile tested only.

Sean Christopherson (2):
  KVM: RISC-V: Unmap stage2 mapping when deleting/moving a memslot
  KVM: RISC-V: Use common KVM implementation of MMU memory caches

 arch/riscv/include/asm/kvm_host.h  | 10 +----
 arch/riscv/include/asm/kvm_types.h |  2 +-
 arch/riscv/kvm/mmu.c               | 70 ++++++++----------------------
 arch/riscv/kvm/vcpu.c              |  5 ++-
 4 files changed, 22 insertions(+), 65 deletions(-)

-- 
2.34.0.rc0.344.g81b53c2807-goog

