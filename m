Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65230410270
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 02:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237935AbhIRA55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 20:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhIRA54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 20:57:56 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E770AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 17:56:33 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id c4so7275143pls.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 17:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CphJpdcUwA/affbsOVFO5DnAc8eQGOBGWmZtfgDlxBY=;
        b=o97yKxa6HxYVb/bigR/PurwzV09IllKV4J47KGfFjba8lv4Yoy4ZU80wntcTnwqRRI
         kHszwAQA1iPWzuf6KdRuslQARo5cIehyEV0Xm9vxQ5DaLVaHKb+Gl9ORyzQQk8WBSxGs
         DoJbUGiXCN3a8eifusfzxyVFuIBUjPXzXaC7jbCyy35amhKhMqvD/0KjuzI5AHak3u4u
         rADghp0BTE+nnwfNpCyVal6PrMQdHFXw2ATcLwRxCQpF/LIJJkww15WaChUHE6VS2dfy
         Rqkqlvid/7VCCTvTAsAnCTwRQquDgWwXkFdBGV2xjqh6FRu5beVnV5D/NsfnflUa3B2i
         7f4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CphJpdcUwA/affbsOVFO5DnAc8eQGOBGWmZtfgDlxBY=;
        b=to9S3RS/BXwcdPS4uM7AHDACCER1/KAtyJrKIMODwujNzN5ogGt4O0xf7RsyGaYhYU
         LLex+t7obZH90TmLeU90BQJ5RNF8AP8zbT/jgPTXk6rHlfWOCNiYLSB/6lQsy5b7l3Hr
         dD7yK6hN8f9gI7k/GUedzrAvYKeuVo/FGGJE+/VBDRx7VFW00XC0dvhC51ZN8oT1FqNC
         uysLSysGXmK8tN99BfqL/Zs5C/o5qk+6AgHK0dpr7F5rHTbPsO+ZAPP9jfnQQpnFeYIN
         yuKHyzZJLCAlWCuwOyrrIc6M+8K3+F+jOLSt+mkHMJA5YqMIQHPHgF96Q+VtUgQJe1iW
         hXYA==
X-Gm-Message-State: AOAM530KjY94wIXnrkRWhRHhz0W9S8QCHng+CtM13NZnyrOabtm/Yrx7
        tId0P1XGnkuQA3Vqc5eE4jj/UeTYppk=
X-Google-Smtp-Source: ABdhPJzKnTjgZ4amW5Y71Y8n1C0aUHBO0DZsGGMMwXmlXC5u3kw/XUyvFatdQJsf384YyvM7qG0IrQ==
X-Received: by 2002:a17:90a:7301:: with SMTP id m1mr15429975pjk.164.1631926592147;
        Fri, 17 Sep 2021 17:56:32 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id p4sm7319482pgc.15.2021.09.17.17.56.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Sep 2021 17:56:31 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>
Subject: [PATCH V2 00/10] KVM: X86: MMU: misc fixes and cleanups
Date:   Sat, 18 Sep 2021 08:56:26 +0800
Message-Id: <20210918005636.3675-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The first two patches fix two old possible bugs.
And the others are just cleanups.

Changed from [V1]:
	The two fixes are changed as Sean suggested.
	And it triggers a different cleanup as patch3-6.
	Patch 7(V1's patch 3) is also updated as Sean suggested.
	Patch 8-10 which are not related to the fixes are unchanged.
	V1's patch 7 is dropped.
	
[V1]: https://lore.kernel.org/lkml/20210824075524.3354-1-jiangshanlai@gmail.com/

Lai Jiangshan (10):
  KVM: X86: Fix missed remote tlb flush in rmap_write_protect()
  KVM: X86: Synchronize the shadow pagetable before link it
  KVM: Remove tlbs_dirty
  KVM: X86: Don't flush current tlb on shadow page modification
  KVM: X86: Remove kvm_mmu_flush_or_zap()
  KVM: X86: Change kvm_sync_page() to return true when remote flush is
    needed
  KVM: X86: Zap the invalid list after remote tlb flushing
  KVM: X86: Remove FNAME(update_pte)
  KVM: X86: Don't unsync pagetables when speculative
  KVM: X86: Don't check unsync if the original spte is writible

 arch/x86/kvm/mmu/mmu.c          | 61 ++++++++++++---------------
 arch/x86/kvm/mmu/mmu_internal.h |  3 +-
 arch/x86/kvm/mmu/paging_tmpl.h  | 74 +++++++++++++++------------------
 arch/x86/kvm/mmu/spte.c         |  6 +--
 arch/x86/kvm/mmu/tdp_mmu.c      |  1 -
 include/linux/kvm_host.h        |  1 -
 virt/kvm/kvm_main.c             |  9 +---
 7 files changed, 66 insertions(+), 89 deletions(-)

-- 
2.19.1.6.gb485710b

