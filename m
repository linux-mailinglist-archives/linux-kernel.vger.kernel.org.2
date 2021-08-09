Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9943C3E48CB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbhHIP0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbhHIP0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:26:05 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB9CC061386
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 08:25:38 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id w10-20020a0cfc4a0000b0290335dd22451dso12599880qvp.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 08:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sdImyBobVK9C7JHfpgjE6AhabFh6YsuoqYzTsW8O26w=;
        b=kqZ+48HlyWqF47Nk0k2ceqQM9Fre+x1T8hoYnPiuq5PTJ4KtKnXsvPfN8z0efxyo2K
         1Cv/Y6nA1ri8uEP9fKKSe8ggvj8zxMwVMtyqCvsN0tbgapBu1uX/FRexEORPLaD7xkmC
         +iI0zK4K0HntIu3IDkwo8zkeuMEYV0LRMLftETQ0wMYxrrYH6anUuwIVrnBfhc6O89s9
         xaIOQKixOTX5PUFhjVwPfO+yshqSpKx+8GMXNTlSVVnsyFkqHsNp1k7CmVAv6G0yrlA6
         56I8EZTN3dqzfYafoy6B+aA2TdNoUdpIuu9GGm/oIh8KBQuT/PdupYj05j1672MfhIaQ
         EJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sdImyBobVK9C7JHfpgjE6AhabFh6YsuoqYzTsW8O26w=;
        b=bOC/8lFdtflOzONWE7i7svnT8phh2omzggGy5ol7qNypb9Acz5YEph/m6kFxTabjry
         3FF24TP0vuBPw/E8IJ3yhM5Ui/Uvh41/JzZLlhL1lfshL4/FG1jLDyKtnVZa2RzyLXPG
         wLXjmmfttiOKTcMMP/RqUqpAtZvsWiWLbBa64PaKYfmqeVUoYcxYmHBQZOVrrn3uTaEA
         0YxZ+62wJrfuSD8KartU0+PvWAb1pU5WSSxgs5M5YohPd5mFFL8BaEmUIlsXg3U2NglQ
         XMh9tutfqSqyOvnuaE0Rs7G48nvwwXbKfaV9s4Xnz0g1RxhJjYsw6GYd79nk++6h7ms7
         hEfg==
X-Gm-Message-State: AOAM530CAo8rSfhNFIiRobQWzbOXCTNgJaz/Coy98oCmZEaRw/RmIziq
        ylsFF7bbvEBSMj3x3JaVdvxcLbTdFV5M
X-Google-Smtp-Source: ABdhPJzOPEvCyZwawEXBs8XVbjr2ljQD5haVjnGzWMLXjl905o6lFfqoGXZgRYKpOaaVjXYS/gQ/pMM6dBBo
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:b0e8:d460:758b:a0ae])
 (user=qperret job=sendgmr) by 2002:a05:6214:6af:: with SMTP id
 s15mr6751903qvz.52.1628522737726; Mon, 09 Aug 2021 08:25:37 -0700 (PDT)
Date:   Mon,  9 Aug 2021 16:24:48 +0100
In-Reply-To: <20210809152448.1810400-1-qperret@google.com>
Message-Id: <20210809152448.1810400-22-qperret@google.com>
Mime-Version: 1.0
References: <20210809152448.1810400-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v4 21/21] KVM: arm64: Make __pkvm_create_mappings static
From:   Quentin Perret <qperret@google.com>
To:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        tabba@google.com, dbrazdil@google.com, kernel-team@android.com,
        qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __pkvm_create_mappings() function is no longer used outside of
nvhe/mm.c, make it static.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/mm.h | 2 --
 arch/arm64/kvm/hyp/nvhe/mm.c         | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mm.h b/arch/arm64/kvm/hyp/include/nvhe/mm.h
index c76d7136ed9b..c9a8f535212e 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mm.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mm.h
@@ -24,8 +24,6 @@ int hyp_back_vmemmap(phys_addr_t phys, unsigned long size, phys_addr_t back);
 int pkvm_cpu_set_vector(enum arm64_hyp_spectre_vector slot);
 int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
 int pkvm_create_mappings_locked(void *from, void *to, enum kvm_pgtable_prot prot);
-int __pkvm_create_mappings(unsigned long start, unsigned long size,
-			   unsigned long phys, enum kvm_pgtable_prot prot);
 unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
 					    enum kvm_pgtable_prot prot);
 
diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
index 6fbe8e8030f6..2fabeceb889a 100644
--- a/arch/arm64/kvm/hyp/nvhe/mm.c
+++ b/arch/arm64/kvm/hyp/nvhe/mm.c
@@ -23,8 +23,8 @@ u64 __io_map_base;
 struct memblock_region hyp_memory[HYP_MEMBLOCK_REGIONS];
 unsigned int hyp_memblock_nr;
 
-int __pkvm_create_mappings(unsigned long start, unsigned long size,
-			  unsigned long phys, enum kvm_pgtable_prot prot)
+static int __pkvm_create_mappings(unsigned long start, unsigned long size,
+				  unsigned long phys, enum kvm_pgtable_prot prot)
 {
 	int err;
 
-- 
2.32.0.605.g8dce9f2422-goog

