Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741C53E48C7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbhHIP0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235673AbhHIPZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:25:46 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848E5C06179B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 08:25:25 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id f25-20020a1c6a190000b029024fa863f6b0so6909623wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 08:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sKHyMUAJ6pCT8dHKiixvyVxL5Tun5Zpw8bNGyjRM47Q=;
        b=bWc7R9nxej9wKPmFw7s2yZ0f0yAf+KeBkNmo6SjyRjbG3l1cLWkJ//rfxcBol1QBM7
         bPkIAEFKVfFoHoK13PoLaqLoJvb6nZ3IXRULnN60HmZseVOfW7IqrDGLo5xPMyCUrFYa
         QNp5B+AsF9CfudlTwOj1BQzPPvVR8mxu0Bizz9YrQIoIl8n/VrGwG34KxyaGSU7CCCg1
         ws45RKPPDGF2xUU2uTgxTbXSiMCwkNafZGCQQq9m57SYZjOC8Q9Sj6QFY5BE4m4nTDdN
         hWUNQ6xQnQ4fYbDe7R/P172LCOSA+nh7JJzs1dGHaL8xRuNJIqL3Qo7NbiHOilWilPRF
         LnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sKHyMUAJ6pCT8dHKiixvyVxL5Tun5Zpw8bNGyjRM47Q=;
        b=qkJNusEi9zDtcp8vGKGnb/lHWoV9DyJxeZO8iJRfKshc1LsXnf3CoyQNsVVBVFrO80
         1EI8Lr+QTGRjcBSSI+L/Bk6WUwdsqH07d1oOZSFGdLx2B1NYeDpNBrXHNo6C5kh6diIr
         AmHn1A5EbULaFM4JzY59QjEk8wzmNwhhlGFL23aXR9eIR4q90HF+xmEi3BgCh8A/OLf3
         znKaUl+I0jTr1MZrhnmR0DQARstVw3o7zhue7dA9yCNk/bf1u8IAHAyUBQlFAu+Ct8fb
         DdvBVbivSi00VsKZ0j7v9lEK9zj6Fm77IKcO/WBNsVGfMTE1LrlRh4u37hCYWG5rtwf3
         JivA==
X-Gm-Message-State: AOAM530BGYGIxc/j8btkxxas7Fs+0VxSb6lA8Q7FfGwjlhUh+/Gfx0mQ
        vIlWZZtCfItprlJdADJxdHkjDKbh9jWM
X-Google-Smtp-Source: ABdhPJwsP/UADjMl4ruQIGRGBcaP9Ad7CMQNtdJiMCBKVwCsIFF2Gv3r4iqTKkuIpNzqlGVjFMa4yXaF8yoo
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:b0e8:d460:758b:a0ae])
 (user=qperret job=sendgmr) by 2002:a05:600c:4f46:: with SMTP id
 m6mr17616703wmq.68.1628522724126; Mon, 09 Aug 2021 08:25:24 -0700 (PDT)
Date:   Mon,  9 Aug 2021 16:24:42 +0100
In-Reply-To: <20210809152448.1810400-1-qperret@google.com>
Message-Id: <20210809152448.1810400-16-qperret@google.com>
Mime-Version: 1.0
References: <20210809152448.1810400-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v4 15/21] KVM: arm64: Introduce addr_is_memory()
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

Introduce a helper usable in nVHE protected mode to check whether a
physical address is in a RAM region or not.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h | 1 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 23316a021880..49db0ec5a606 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -51,6 +51,7 @@ extern const u8 pkvm_hyp_id;
 int __pkvm_prot_finalize(void);
 int __pkvm_mark_hyp(phys_addr_t start, phys_addr_t end);
 
+bool addr_is_memory(phys_addr_t phys);
 int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
 int host_stage2_set_owner_locked(phys_addr_t addr, u64 size, u8 owner_id);
 int kvm_host_prepare_stage2(void *pgt_pool_base);
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index ee255171945c..cb023d31666e 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -197,6 +197,13 @@ static bool find_mem_range(phys_addr_t addr, struct kvm_mem_range *range)
 	return false;
 }
 
+bool addr_is_memory(phys_addr_t phys)
+{
+	struct kvm_mem_range range;
+
+	return find_mem_range(phys, &range);
+}
+
 static bool range_is_memory(u64 start, u64 end)
 {
 	struct kvm_mem_range r1, r2;
-- 
2.32.0.605.g8dce9f2422-goog

