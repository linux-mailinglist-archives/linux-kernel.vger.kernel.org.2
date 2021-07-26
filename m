Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472493D569F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 11:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbhGZItZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 04:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbhGZItJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 04:49:09 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4235C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:29:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d69-20020a25e6480000b02904f4a117bd74so12831925ybh.17
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MJIro2WTfm4GzLtRoDylovuZ45jqLgFOexzn+Zy4wjs=;
        b=FSUlFamdvZmCkq1K/PPVAVpzWQ2IdtDwEy8DAyitecCP9UoJnIxQmUsQfqZUzVuPEk
         Hn6Y0ZdCypMyVxkddka1PFuUUmL82O98WDLQQxOW9w5/1xNezpgSU3+VjjTAM3QiiFYb
         lc+Oyf1eR0aufgHOQtp6oaewCjRopIvo2NIIYIzU038nPMU79T0GnRIAM620SA+Uowrp
         PsNp374AxcYuwdiWR5/zympTvFOzT+i4A8R/bc8CeqCmKLxZ6wYASldpJ9oV5r2GkoYK
         WtkZCG4iM7dS0bKA4FDvw5WqKlxqUe23jdLdajTqkFZbRzI4KaYW5x8/tmwqWByjNRsS
         KBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MJIro2WTfm4GzLtRoDylovuZ45jqLgFOexzn+Zy4wjs=;
        b=ffy0KD8S/5Hmn+yyWXteFkVG0hZMkcWjqwnpoUFDeeLGprmV+B4wjPjkBIK87baEYu
         3TfKY9AGRLoyfLHsZMzPI9dxtLIDIjPZyiow9WU6pu1mvYV/2+5qnDudrfgl++n3Dann
         /LBl7fIv20mmZIHuw3XgADdHHlhbV7pot8+VWFmK8DsKexAoMDlodQBIrUf7QkVtHjnO
         DEdDlMXmzRJOC8qV4cGTWAiFKzhyc5/ytdWyX0doAf2R9Sder6I5caV8XIKDV3S92wRY
         xptjwOyxT1x+mkj5wSs5jSAcb5br82Uyf/9Sd1rHCcX8ULMJUn1DOESpPN/Kw+Atd9sT
         CVhQ==
X-Gm-Message-State: AOAM532P06joA499vrnKHY5+l54q1U7e1tLBTAkaI/S9XMRYWH0/9NAa
        z0jntDSFXhOCJ0m8uWrXTBRG8sxCw7ew
X-Google-Smtp-Source: ABdhPJzFtCNc3wRUZQkuMVZikxDARzQyAhA2u+pAgC1/vs0Dkse5PCCu9I9np2lmsIsb+H72joir6vU8V2M2
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:23a0:2f14:433:e6cb])
 (user=qperret job=sendgmr) by 2002:a25:6088:: with SMTP id
 u130mr23486646ybb.257.1627291778107; Mon, 26 Jul 2021 02:29:38 -0700 (PDT)
Date:   Mon, 26 Jul 2021 10:29:01 +0100
In-Reply-To: <20210726092905.2198501-1-qperret@google.com>
Message-Id: <20210726092905.2198501-13-qperret@google.com>
Mime-Version: 1.0
References: <20210726092905.2198501-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v2 12/16] KVM: arm64: Mark host bss and rodata section as shared
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

As the hypervisor maps the host's .bss and .rodata sections in its
stage-1, make sure to tag them as shared in hyp and host page-tables.

But since the hypervisor relies on the presence of these mappings, we
cannot let the host in complete control of the memory regions -- it
must not unshare or donate them to another entity for example. To
prevent this, let's transfer the ownership of those ranges to the
hypervisor itself, and share the pages back with the host.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/setup.c | 52 ++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 0b574d106519..285c8aea5065 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -58,6 +58,7 @@ static int recreate_hyp_mappings(phys_addr_t phys, unsigned long size,
 {
 	void *start, *end, *virt = hyp_phys_to_virt(phys);
 	unsigned long pgt_size = hyp_s1_pgtable_pages() << PAGE_SHIFT;
+	enum kvm_pgtable_prot prot;
 	int ret, i;
 
 	/* Recreate the hyp page-table using the early page allocator */
@@ -83,10 +84,6 @@ static int recreate_hyp_mappings(phys_addr_t phys, unsigned long size,
 	if (ret)
 		return ret;
 
-	ret = pkvm_create_mappings(__start_rodata, __end_rodata, PAGE_HYP_RO);
-	if (ret)
-		return ret;
-
 	ret = pkvm_create_mappings(__hyp_rodata_start, __hyp_rodata_end, PAGE_HYP_RO);
 	if (ret)
 		return ret;
@@ -95,10 +92,6 @@ static int recreate_hyp_mappings(phys_addr_t phys, unsigned long size,
 	if (ret)
 		return ret;
 
-	ret = pkvm_create_mappings(__hyp_bss_end, __bss_stop, PAGE_HYP_RO);
-	if (ret)
-		return ret;
-
 	ret = pkvm_create_mappings(virt, virt + size, PAGE_HYP);
 	if (ret)
 		return ret;
@@ -117,6 +110,24 @@ static int recreate_hyp_mappings(phys_addr_t phys, unsigned long size,
 			return ret;
 	}
 
+	/*
+	 * Map the host's .bss and .rodata sections RO in the hypervisor, but
+	 * transfer the ownerhsip from the host to the hypervisor itself to
+	 * make sure it can't be donated or shared with another entity.
+	 *
+	 * The ownership transtion requires matching changes in the host
+	 * stage-2. This will done later (see finalize_mappings()) once the
+	 * hyp_vmemmap is addressable.
+	 */
+	prot = pkvm_mkstate(PAGE_HYP_RO, PKVM_PAGE_SHARED_OWNED);
+	ret = pkvm_create_mappings(__start_rodata, __end_rodata, prot);
+	if (ret)
+		return ret;
+
+	ret = pkvm_create_mappings(__hyp_bss_end, __bss_stop, prot);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -148,6 +159,27 @@ static void hpool_put_page(void *addr)
 	hyp_put_page(&hpool, addr);
 }
 
+static int finalize_mappings(void)
+{
+	enum kvm_pgtable_prot prot;
+	int ret;
+
+	/*
+	 * The host's .bss and .rodata sections are now conceptually owned by
+	 * the hypervisor, so mark them as 'borrowed' in the host stage-2. We
+	 * can safely use host_stage2_idmap_locked() at this point since the
+	 * host stage-2 has not been enabled yet.
+	 */
+	prot = pkvm_mkstate(KVM_PGTABLE_PROT_RWX, PKVM_PAGE_SHARED_BORROWED);
+	ret = host_stage2_idmap_locked(__hyp_pa(__start_rodata),
+				       __hyp_pa(__end_rodata), prot);
+	if (ret)
+		return ret;
+
+	return host_stage2_idmap_locked(__hyp_pa(__hyp_bss_end),
+					__hyp_pa(__bss_stop), prot);
+}
+
 void __noreturn __pkvm_init_finalise(void)
 {
 	struct kvm_host_data *host_data = this_cpu_ptr(&kvm_host_data);
@@ -167,6 +199,10 @@ void __noreturn __pkvm_init_finalise(void)
 	if (ret)
 		goto out;
 
+	ret = finalize_mappings();
+	if (ret)
+		goto out;
+
 	pkvm_pgtable_mm_ops = (struct kvm_pgtable_mm_ops) {
 		.zalloc_page = hyp_zalloc_hyp_page,
 		.phys_to_virt = hyp_phys_to_virt,
-- 
2.32.0.432.gabb21c7263-goog

