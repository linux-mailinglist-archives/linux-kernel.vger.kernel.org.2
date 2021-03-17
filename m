Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAAB33F26E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 15:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbhCQOR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 10:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbhCQORZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 10:17:25 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7312C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 07:17:23 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id y5so18477776wrp.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 07:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Q4V+uOAPZg+8IRDU5mahURH8jFF9ksprgkE8pnV2+pI=;
        b=nOjGyLVk+LQQpkIGloNKaOBZGiHuZP3o8hZS0+/PkEKwar0iBam9A/S5fY3dDEp2tv
         9eaTVYSgiNCZd9vqBh9EaR6rr5ABZcqJhepuIaJP/qswFsC/PblA0Uj/H/9RTNGBhAwc
         nJsxrNTaJDJ2sleNFqxmCW2yVVO+d2Wjy6hZHm94blPNYxt/12pwGeKx0qud6E9mpXc1
         SkgMzZv/otO2vBE54oi6bzmLhcaJC4iVNMm+YLttfKkRvOxjqZWbpL8lX755fLMcGwww
         oOzTADmiTzBT7CrXki6+oREF4m72flOVuTEm78cImMKccnkACbjJhWURXjcoGTStJPPw
         +J2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Q4V+uOAPZg+8IRDU5mahURH8jFF9ksprgkE8pnV2+pI=;
        b=B+m83AnEWmFqevW/Q0l6ISviAUwoZ6CcARuzpstKfl7LB+WB9MEeWA9p4wBwYp1M3M
         qCs4OTQoMo8EtSW8nvZ8X8Li7qMGk9mA4+I1ch71/sG3CHrUuOq2+pgSnXeuy6InWp+Q
         nlkmblyEtKerv0j/T1wsg7zwDW//KxpETH7hOwZnNMWq5vI8UVgyb2X6m/0nGE3p5+XI
         wvta41qPhxnj/u1dCI/hFf/z0Cb2hr5KffJVhnZEc5Db5gLIM+wXjuOrv4F7uuf5bcjg
         17uFU2wlnrgJRtaZmgPqzLqSkNUMicyXclvC31cOsDe8+rm3TEgbN4ivdOl56sfEs4wP
         9sJA==
X-Gm-Message-State: AOAM530yucSZpELpdCGWXR0Dtdm5WthQfnK0WN8666XRk7zlt5xdlvIP
        DEEqh+vC5zdjqBrgdee34Vw70FbAruWM
X-Google-Smtp-Source: ABdhPJzfbGHlOZ2mswIVtX/K86GO+y6S/0YGq3nxkyi0qI2XV2uCdtoLRdQPNroMNClPqw4jAdENknrb1l1c
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:e912:: with SMTP id
 q18mr3949743wmc.59.1615990642409; Wed, 17 Mar 2021 07:17:22 -0700 (PDT)
Date:   Wed, 17 Mar 2021 14:17:14 +0000
In-Reply-To: <20210317141714.383046-1-qperret@google.com>
Message-Id: <20210317141714.383046-3-qperret@google.com>
Mime-Version: 1.0
References: <20210315143536.214621-34-qperret@google.com> <20210317141714.383046-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 2/2] KVM: arm64: Disable FWB in host stage-2
From:   Quentin Perret <qperret@google.com>
To:     qperret@google.com
Cc:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com, android-kvm@google.com, seanjc@google.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need the host to be in control of cacheability of its own mappings,
so let's disable FWB altogether in its stage 2.

Signed-off-by: Quentin Perret <qperret@google.com>

---

Obviously this will have to be folded in the relevant patch for v6, but
I kept it separate for the sake of review.
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index dd03252b9574..c472c3becf40 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -94,8 +94,8 @@ int kvm_host_prepare_stage2(void *mem_pgt_pool, void *dev_pgt_pool)
 	if (ret)
 		return ret;
 
-	ret = kvm_pgtable_stage2_init(&host_kvm.pgt, &host_kvm.arch,
-				      &host_kvm.mm_ops);
+	ret = kvm_pgtable_stage2_init_flags(&host_kvm.pgt, &host_kvm.arch,
+					    &host_kvm.mm_ops, KVM_PGTABLE_S2_NOFWB);
 	if (ret)
 		return ret;
 
@@ -116,8 +116,6 @@ int __pkvm_prot_finalize(void)
 	params->vttbr = kvm_get_vttbr(mmu);
 	params->vtcr = host_kvm.arch.vtcr;
 	params->hcr_el2 |= HCR_VM;
-	if (cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
-		params->hcr_el2 |= HCR_FWB;
 	kvm_flush_dcache_to_poc(params, sizeof(*params));
 
 	write_sysreg(params->hcr_el2, hcr_el2);
-- 
2.31.0.rc2.261.g7f71774620-goog

