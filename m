Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC2A3E48C0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235654AbhHIPZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235657AbhHIPZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:25:42 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B19C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 08:25:20 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id u11-20020ad45aab0000b029033e289c093aso12569142qvg.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 08:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3dBIi1YzqMEm+UlYWRCSS5kKhcRIzlI2kVO6oR1gAJY=;
        b=pwqfES+b/309iPvlv8E1ftMhSnhlZy8mcMABvDRuAotG2budtPOdgJb73oPI6/MSGD
         ILhOvPTq8aIdf06m1VIM0yJOfipj9IDRQygTQK0MXZQ78+f+s6FJNc4eruv9GBpHUATi
         3DPVRIxc+WjDdgR385vu2hDXy4mP0G3jEB7NeE0p5xd7Tsw9AwVodm/pABL8JAkqLUJm
         Dedj5LkITe1ybQH+GMWWBsZx05lk6S7Iqa2v9OVbbFvui/pxn7ZMcFeqJTXh1zGzeV7/
         wCMz42JxwEpefj4CSksac16Vm16+9iQ0mxJgbtQYa+MRG8v10SN4Entl6tuQ2OhQ2q3X
         lIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3dBIi1YzqMEm+UlYWRCSS5kKhcRIzlI2kVO6oR1gAJY=;
        b=onKA5Nz2TeVd71bWcd4gDOv7f3zIwwxJJ8aqBQTubw/qqkapUr9FzLz2cUVA5lE7CG
         Wyoa/b9LhpxZA2ZeuHj9UCAZoVgEiPW1w6I9SAyXVKXjQnAwbq/gBqHN/Phxqbhro8uq
         ZWuPSWgK/onMlRqjKsFIegGWtdDYl1SI6R/7NkM4rU9Lh6oAxI4TmMorJnx89U77VzeQ
         Nn3wnAE2PLsdPvtPhJGglZ17EL+g+qljL4wbJc+M+S3PNOReVpSWC0Cm37vQNYOfhGzS
         L1QtJXMonuUhdqZ7wezbRRkjpFY+b0pAC0KGNezDsgbLcurM6Z+BIyD1ZK74uKq3qOfd
         vv6g==
X-Gm-Message-State: AOAM532L48cx1E1kURdAgsmr2742wHeFEz1xu16+d9nxWcaXRyDa4Hb2
        o8JWCpN7zDJl0YpaUoaaGJscPIbD7NEl
X-Google-Smtp-Source: ABdhPJwTAF1XYWSKb67BxPuZMFA3SIWFIr0NEvX9FTJFVSSti+daWMWMqdeklw8++yGxusAYBtawMwClTWQ8
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:b0e8:d460:758b:a0ae])
 (user=qperret job=sendgmr) by 2002:a05:6214:d4b:: with SMTP id
 11mr12803043qvr.44.1628522719790; Mon, 09 Aug 2021 08:25:19 -0700 (PDT)
Date:   Mon,  9 Aug 2021 16:24:40 +0100
In-Reply-To: <20210809152448.1810400-1-qperret@google.com>
Message-Id: <20210809152448.1810400-14-qperret@google.com>
Mime-Version: 1.0
References: <20210809152448.1810400-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v4 13/21] KVM: arm64: Expose host stage-2 manipulation helpers
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

We will need to manipulate the host stage-2 page-table from outside
mem_protect.c soon. Introduce two functions allowing this, and make
them usable to users of mem_protect.h.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  2 ++
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 18 +++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 87b1690c439f..0849ee8fa260 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -49,6 +49,8 @@ extern struct host_kvm host_kvm;
 int __pkvm_prot_finalize(void);
 int __pkvm_mark_hyp(phys_addr_t start, phys_addr_t end);
 
+int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
+int host_stage2_set_owner_locked(phys_addr_t addr, u64 size, u8 owner_id);
 int kvm_host_prepare_stage2(void *pgt_pool_base);
 void handle_host_mem_abort(struct kvm_cpu_context *host_ctxt);
 
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 6fed6772c673..f95a5a4aa09c 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -273,6 +273,22 @@ static int host_stage2_adjust_range(u64 addr, struct kvm_mem_range *range)
 	return 0;
 }
 
+int host_stage2_idmap_locked(phys_addr_t addr, u64 size,
+			     enum kvm_pgtable_prot prot)
+{
+	hyp_assert_lock_held(&host_kvm.lock);
+
+	return host_stage2_try(__host_stage2_idmap, addr, addr + size, prot);
+}
+
+int host_stage2_set_owner_locked(phys_addr_t addr, u64 size, u8 owner_id)
+{
+	hyp_assert_lock_held(&host_kvm.lock);
+
+	return host_stage2_try(kvm_pgtable_stage2_set_owner, &host_kvm.pgt,
+			       addr, size, &host_s2_pool, owner_id);
+}
+
 static bool host_stage2_force_pte_cb(u64 addr, u64 end, enum kvm_pgtable_prot prot)
 {
 	/*
@@ -309,7 +325,7 @@ static int host_stage2_idmap(u64 addr)
 	if (ret)
 		goto unlock;
 
-	ret = host_stage2_try(__host_stage2_idmap, range.start, range.end, prot);
+	ret = host_stage2_idmap_locked(range.start, range.end - range.start, prot);
 unlock:
 	hyp_spin_unlock(&host_kvm.lock);
 
-- 
2.32.0.605.g8dce9f2422-goog

