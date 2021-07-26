Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC683D56A4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 11:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbhGZItj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 04:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbhGZItS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 04:49:18 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E48C061796
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:29:47 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id e19-20020ac84b530000b0290251f0b91196so4019218qts.14
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4KB8zz71n+ckn7q+A5npd/SGGm4PNZq4hk1c6+NwEJY=;
        b=kkbETL0dMsBo3aqN8t9V/kIx0Ztkf3eaIwZl0PzH5SGS9l2R07gZCo3SrYhlVi0Aq8
         DYE6R8DSj9iT04q9VHzh6K+4SpsFIWhZ21iXDGINKGvc1prCFhcttOusRwxU37nyzoBJ
         cGXebYm+WF+eQ3xmw+KAK1J3BjSZ3bPpSTpuIEjXY099wkk5S/7jGm6iLAJW4Ee1idbp
         5Skr4vyXufnVr58Rb40+iWEREgGtIjuPt7Gzvmz14VSeW3GBhdK8I9sPFbIysDe099cl
         VJTQxXrn2ZOjquQC+U5SzPZy1y6uov5YuZ6+JVs5ya29jcZkLE3TflfMn+pwghu4p+ZT
         uC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4KB8zz71n+ckn7q+A5npd/SGGm4PNZq4hk1c6+NwEJY=;
        b=gAgLsvsPE6+gPP3bhfuiro1ykzB4OyutSZMeKMTXXgwH1Fm9Go3tlatEei7GsVhcwu
         kEo+hbA260LwppiGRTYmjA0WMuFpWIBYY8KsXY7R+OgLIAXiPpxTLUYSk4mJuK7tZazj
         72d87Dm1aErxcjkNBXMNy1DmoknrRUF2ddHHqsYHi/aTBKFxDjIKDhkP9KvactA3yiY7
         3rEUctcspAXIUwIIz9fFyTNM65lXFlvqse9gy7/4wprC982S7qKjBGgbMVGoEsJHyZmq
         GJVvHShIEJoLLAwhYWv5f0Vaw6c93LI52klSeDhTC7qKq4jitx5d7MW6X/7TH/hrDO/8
         gcDA==
X-Gm-Message-State: AOAM530CeXrVloCtfrqazF+RYYxP/GvEKkQyvtn3Js54G1ji8Y+gWl8q
        SkKjHQeAmohGqMfIygxBKKEhFLV3UcF6
X-Google-Smtp-Source: ABdhPJw4rV2DFKIOrC4bodeI8pRwP94WRLnn2cUKstVXAH0e5UMS4sxvzAPdNEu8x+a/0hc9RNwJfIDJlSr6
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:23a0:2f14:433:e6cb])
 (user=qperret job=sendgmr) by 2002:a05:6214:2482:: with SMTP id
 gi2mr13928371qvb.51.1627291786850; Mon, 26 Jul 2021 02:29:46 -0700 (PDT)
Date:   Mon, 26 Jul 2021 10:29:05 +0100
In-Reply-To: <20210726092905.2198501-1-qperret@google.com>
Message-Id: <20210726092905.2198501-17-qperret@google.com>
Mime-Version: 1.0
References: <20210726092905.2198501-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v2 16/16] KVM: arm64: Make __pkvm_create_mappings static
From:   Quentin Perret <qperret@google.com>
To:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        tabba@google.com, dbrazdil@google.com, kernel-team@android.com,
        Quentin Perret <qperret@google.com>
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
index 256cbe5c0dca..80303041f72f 100644
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
2.32.0.432.gabb21c7263-goog

