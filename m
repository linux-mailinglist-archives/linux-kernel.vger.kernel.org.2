Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06123B46AA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 17:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhFYPfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 11:35:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46711 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230008AbhFYPer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 11:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624635146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R6vqFh3euA4lluHZrjH7C0VB/8jbPFxvQZcd2X8+z8A=;
        b=iuwxKmoxsZlYJYeSVYR97hotoccR8adagS5QovQhoXjOkETqbrXq9d2IQFp41Fd2KNOuE+
        xwdLqGjKQ01lukySyR75jiLD8YLX+b0SlAljt8EuMrRIr3YjztvanDFblCycF/jmasmE+O
        HTfDst/7Cz/DrF5Bs9nEwdVa06kJbkw=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-v9vMb0H2OI-l58YmD6qY8g-1; Fri, 25 Jun 2021 11:32:25 -0400
X-MC-Unique: v9vMb0H2OI-l58YmD6qY8g-1
Received: by mail-io1-f69.google.com with SMTP id e24-20020a5d8e180000b02904dd8a55bbd7so7252895iod.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 08:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R6vqFh3euA4lluHZrjH7C0VB/8jbPFxvQZcd2X8+z8A=;
        b=DZTtV/CKXoHHWL7zIgMGYzsHd66vh8uOwd/uYVrCSuWhGVy2SESWpR9KnytYeWPQeQ
         exCroAzvswajp+6kM/Lw0hyPNS3HuB5Ek7yhsOmEDvhkmJEenkGMmrxNEXZWbUwOkuLx
         BrwIf6FwjtI2rPaSYy+sabh5tPSZC6WU6IQ0Jw6P5iRtZLMkeSd1Op5hePRsC9R6rebH
         mJ+2665ApC+vk27qUBcWpsQAw5+M0UepeBnbE3sjSm+xq6Mxwx+MrbpEio6VqTkWCIio
         5bpZEisb4nxGhkKDck5MIQbvrODAZu0jP2pOeunI4g1Ws8Yz8OeNx/wgydv7BS24xtEG
         Npjg==
X-Gm-Message-State: AOAM531nh+EHMuYdzUmuevNkyZhl/0Nz+8PprcvwOdl+UKnBpbRX4+au
        3sCyOCvf/s/EvNHijmcWr4iE1AQE9Y1GIEHq6ZwCaFqCJ7Bwh1tBHBHogI77GFpKVS6B6sLRzRI
        M3B9ouvSZEKR8szbKEybed2ogDhbioCzwq2ILWkxpk5M7lALYGb3j+4gZ6nxhA66YTvc2ygTNPg
        ==
X-Received: by 2002:a92:ddce:: with SMTP id d14mr8010930ilr.279.1624635143858;
        Fri, 25 Jun 2021 08:32:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiQrN5psgZSp7PJvYOwSrLNB9dXZdC9/rSyism8PuiJvzWVvPfNV/3BaOd5802wgskCbtFHg==
X-Received: by 2002:a92:ddce:: with SMTP id d14mr8010912ilr.279.1624635143672;
        Fri, 25 Jun 2021 08:32:23 -0700 (PDT)
Received: from t490s.redhat.com (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id s8sm3668772ilj.51.2021.06.25.08.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 08:32:23 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, peterx@redhat.com,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH v2 4/9] KVM: X86: Introduce pte_list_count() helper
Date:   Fri, 25 Jun 2021 11:32:09 -0400
Message-Id: <20210625153214.43106-5-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625153214.43106-1-peterx@redhat.com>
References: <20210625153214.43106-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helper is used to count the number of rmap entries in the rmap list
pointed by the kvm_rmap_head.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c          | 21 +++++++++++++++++++++
 arch/x86/kvm/mmu/mmu_internal.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index eb16c1dbbb32..b3f738a7c05e 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -990,6 +990,27 @@ static void pte_list_remove(struct kvm_rmap_head *rmap_head, u64 *sptep)
 	__pte_list_remove(sptep, rmap_head);
 }
 
+unsigned int pte_list_count(struct kvm_rmap_head *rmap_head)
+{
+	struct pte_list_desc *desc;
+	unsigned int i, count = 0;
+
+	if (!rmap_head->val)
+		return 0;
+	else if (!(rmap_head->val & 1))
+		return 1;
+
+	desc = (struct pte_list_desc *)(rmap_head->val & ~1ul);
+
+	while (desc) {
+		for (i = 0; (i < PTE_LIST_EXT) && desc->sptes[i]; i++)
+			count++;
+		desc = desc->more;
+	}
+
+	return count;
+}
+
 static struct kvm_rmap_head *__gfn_to_rmap(gfn_t gfn, int level,
 					   struct kvm_memory_slot *slot)
 {
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 35567293c1fd..325b4242deed 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -131,6 +131,7 @@ bool kvm_mmu_slot_gfn_write_protect(struct kvm *kvm,
 				    int min_level);
 void kvm_flush_remote_tlbs_with_address(struct kvm *kvm,
 					u64 start_gfn, u64 pages);
+unsigned int pte_list_count(struct kvm_rmap_head *rmap_head);
 
 /*
  * Return values of handle_mmio_page_fault, mmu.page_fault, and fast_page_fault().
-- 
2.31.1

