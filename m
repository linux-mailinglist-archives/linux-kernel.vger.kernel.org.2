Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068393DA45A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237954AbhG2NaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237851AbhG2N3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:29:14 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7628AC061796
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:29:11 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id 15-20020ac84e8f0000b029024e8c2383c1so2752050qtp.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vQtosGJFAOrUOiBl4clG9WDMUZRQZWton/qwil1k0+Q=;
        b=dXygFS4MzHesaeMqbwJ0+cZ0afNQ4/u5vTF/RgsqUpPCSvO1FUb9yuOtobHsreJWqr
         dUqlIAu7Fvz+I43aDHKZyp8VKGAJcvdmKnnkeHIjZqt8EhOzaHANhcXh8RtV0Ilxlnt9
         4Pl/Gc+kDSrSP77EuPnHl91zLmkSkct+Gl67dPohs9YPPdMJ8ph+HGp8BjrsrKxaXVEy
         OoSuN3lBXk7s1yZPSllQnVPCpAnlYGI91eJ1m/mdcSbcCE+Z2qNsccfX2HfuY/+rJJcM
         noOMmdViiMNvT23lNHKkf8AZYFmTtkC55+7rWH4afynTCCzcjLC8ILshwjJH8cojfSWr
         oXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vQtosGJFAOrUOiBl4clG9WDMUZRQZWton/qwil1k0+Q=;
        b=e+7iRHTxW6ZQ8KWUoD2dM0migoSFurLBzLd1AjsQrrOMH+zsHh2PF+isnBd2mtsTXQ
         fG+QZI9jk8R52aRG9DJAwKfW+MdcwjzxsvgOXR6IUomJAzzj2m4B6WFz/RUl66pcCGCq
         fU5fbMXPzu4ksiqZFLn2nAFf7eBICj7UELoPKTfN+gkJNi2NXA5soTHgAjT86nSbwD6p
         5exN1/oQ10DRgnZM4kq1Tqm0Zr5PKEX9bQK+6mzRxW+rQPv+s91Ffe3UpA2BsxLf07HW
         g/vXoQFfiAJKn1CTiizezVLvp8WN8rypUccYJGrSdee9UzfukRq4SAz5FODO5nyGDogW
         h/MA==
X-Gm-Message-State: AOAM530V+u2nn2BNJI6HDTeTm5qOIHTnPl//80nodkS7aeWMYSKo1UtB
        awoR8WXk7Dw+kx6Lpgxl6Hfj14d7Rq0Z
X-Google-Smtp-Source: ABdhPJzMM++UNzruvJmyLbB/7mURxGlTSkGbvn6rPkDW6SXHchtq4/8ma0IIMxLOdpKM8oJyuuW51EsCRzfk
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:293a:bc89:7514:5218])
 (user=qperret job=sendgmr) by 2002:a05:6214:104b:: with SMTP id
 l11mr5321061qvr.40.1627565350559; Thu, 29 Jul 2021 06:29:10 -0700 (PDT)
Date:   Thu, 29 Jul 2021 14:28:18 +0100
In-Reply-To: <20210729132818.4091769-1-qperret@google.com>
Message-Id: <20210729132818.4091769-22-qperret@google.com>
Mime-Version: 1.0
References: <20210729132818.4091769-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v3 21/21] KVM: arm64: Make __pkvm_create_mappings static
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
2.32.0.432.gabb21c7263-goog

