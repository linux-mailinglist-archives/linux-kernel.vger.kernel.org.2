Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE25C3D569D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 11:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbhGZItX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 04:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbhGZItI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 04:49:08 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C03C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:29:37 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id z10-20020adfdf8a0000b02901536d17cd63so1769766wrl.21
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fyCHOW6maJF9L7guSoQxIXFDKYajZ5tEfL0M1nzcu3g=;
        b=b6cEmvJ0vdEy2FGe8oxQq0HlmnKC08AOEIcGg2mj6fy+SSGskiuESRrYptCgJBbUZu
         mt0BDG+nEREOBOG2gON7kzVvLlgj83N/3hY4W0c6StPuMfpFjuKVeuGnNBubwob1lg/y
         noakRpnUfRpGOAidTPg/rki9g0KqzEwYypxs4M7HTnvPXf7iFxu/B6GlMaKalYBVBH14
         YkQii/9BBIPj6M2rqhx9TIywxni7ift1Cnpcz6Om6njwYOV6G8R2RL+mltGn89rqQd3x
         lPyubLT/kp4B80c1Rt5WC3DkG7lsQlG7ga2RipuW01KExo0V3PSpKTM1DAMcXKZlw0ft
         7ibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fyCHOW6maJF9L7guSoQxIXFDKYajZ5tEfL0M1nzcu3g=;
        b=QPWFVpJw6T0i/qJ8Jn+U6VdVivKFsA7cF+xeUo7bnXhWR56UKhqO6aQ1lVm/wh2EI2
         1d4YbjCTcIeqfUOxH7GmbDC3iw4m0fl2kh0I7scKX/WQeCWgcdFFCeEGA/3d2xiuJh1Q
         femGB1xB14tq1YT7KoxG2sjWYONn2A36JKniCI0pKqwz8HTSXZOd6ZCOYOimQ57XRjhj
         VNdFr3sptAV52/Jr/ulMEnVQQnkBJNbBssAQxkJ7jc3ZQEOmRzZ5EJi21GEhe+pCVtid
         7qWvSUDEWSrHg3XIN0NwIuAw9WQIj65A2oEBeHifZ73HKqVSGpcxmGumeHepiWPUP3aE
         NVOg==
X-Gm-Message-State: AOAM5306Nv/pzmCPuS1B8Tu5rNhGZgAh+dkJEf4O45w25wLpIVr9ShyL
        zhdgVFA0mvTd/zAeqjvin0tPmYeFNQJH
X-Google-Smtp-Source: ABdhPJwpwF4hCeEcD8WP2F52FmGpoCMVmSoE2R/VRCPmMc5vvMGS4yzbAZ1WyJM7j6+dONr435cj4ZE0ccVT
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:23a0:2f14:433:e6cb])
 (user=qperret job=sendgmr) by 2002:a7b:cb4d:: with SMTP id
 v13mr14985934wmj.68.1627291775721; Mon, 26 Jul 2021 02:29:35 -0700 (PDT)
Date:   Mon, 26 Jul 2021 10:29:00 +0100
In-Reply-To: <20210726092905.2198501-1-qperret@google.com>
Message-Id: <20210726092905.2198501-12-qperret@google.com>
Mime-Version: 1.0
References: <20210726092905.2198501-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v2 11/16] KVM: arm64: Introduce and export host_stage2_idmap_locked()
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

We will need to manipulate the host stage-2 page-table from outside
mem_protect.c soon. Introduce a function wrapping the host_stage2_try()
call and make it usable to users of mem_protect.h.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h | 1 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index facbd9a7ab99..8e5725d032b2 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -50,6 +50,7 @@ extern struct host_kvm host_kvm;
 int __pkvm_prot_finalize(void);
 int __pkvm_mark_hyp(phys_addr_t start, phys_addr_t end);
 
+int host_stage2_idmap_locked(u64 start, u64 end, enum kvm_pgtable_prot prot);
 int kvm_host_prepare_stage2(void *pgt_pool_base);
 void handle_host_mem_abort(struct kvm_cpu_context *host_ctxt);
 
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 2d41d4fa8901..223c541a7051 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -266,6 +266,11 @@ static int host_stage2_find_range(u64 addr, struct kvm_mem_range *range)
 	return 0;
 }
 
+int host_stage2_idmap_locked(u64 start, u64 end, enum kvm_pgtable_prot prot)
+{
+	return host_stage2_try(__host_stage2_idmap, start, end, prot);
+}
+
 static bool host_stage2_force_pte_cb(u64 addr, u64 end, enum kvm_pgtable_prot prot)
 {
 	/*
@@ -303,7 +308,7 @@ static int host_stage2_idmap(u64 addr)
 	if (ret)
 		goto unlock;
 
-	ret = host_stage2_try(__host_stage2_idmap, range.start, range.end, prot);
+	ret = host_stage2_idmap_locked(range.start, range.end, prot);
 unlock:
 	hyp_spin_unlock(&host_kvm.lock);
 
-- 
2.32.0.432.gabb21c7263-goog

