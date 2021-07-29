Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663443DA448
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237802AbhG2N3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237764AbhG2N3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:29:01 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8058BC061796
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:28:58 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id g187-20020a1c20c40000b02902458d430db6so820371wmg.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OjC24vlLeAeaPgTOLWCqiGMhh2YFKJ1LYBLN6vgVBCE=;
        b=FUVDUhP/Rgin9C5BP59XMAHUmYRtf8wsXok+/g39vfdccCUCbbIVDOgFIm6+T7feET
         OomVLcyL10A24g9qFkGVaYhLGSLUP+7LPM2rYyJvJcTC/EXcS3QMcQy9Zjn2OfviE4Vv
         pqDLpQ9h2b8lvFh1vVNIwNeokffqlvkzEHZ/4KbVuW5P3FYo7Kz/ngnmtxczHYdDl2aY
         dn8R3JChCBT+YQ6mC/tGYOavge71IRXVQjA3y7zhUwAZ9lCCEAZhdKwSqg682Veyp4Op
         H6zjmSwxexlMkOT79IpXhHTF8vO1H6IiZx2lHKa9zI3DieJ1lud/goMYV8Lz8Fg4Utho
         4szg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OjC24vlLeAeaPgTOLWCqiGMhh2YFKJ1LYBLN6vgVBCE=;
        b=T2aJSQ3awN3C2Malw2FdUyAnFLkJUjpsAEG+pSkS0N8/IOWL4rDcg8EwNaw9ICRrXN
         yXu7yBH4yko2NuWd6iQaU4ZVFlBzQzaKXFnaI1WJmX9tMdH/5IlXLX8TPCc0R2gvhlMU
         dukF4UzsfUhLAYEl/hq+Ca7B1LXNGpBWVfX5zUZCyhAnrvlIgo7F7B75cOFi6KozmbLE
         7SJsRj0qwAeT/0VUCxWXzsF1bP91ZB452REtZvbtxT/TykjScU+iUac0VYsYLuEdNZP5
         muLY1j2R0IGCrv9ljGyShXwrGmX1ur4AwFy+1PCUds4KSrftKhMH4pl86sYOzbMWNBXk
         JkpA==
X-Gm-Message-State: AOAM533eB4AkkGAoMTczKL23h3kesnp7fNPJ/XnAJdnqwyp+zsRyYUI7
        JZurHamLIR3b5hBMdYwpCFPxukUU5Evt
X-Google-Smtp-Source: ABdhPJypNTDOJ5B4zDhDCdj5CCbjzdEdEoifMoEeuxe0LOvoyI2vi5S+2I0+5g7DpCtXnyU4MWjdIokkLn73
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:293a:bc89:7514:5218])
 (user=qperret job=sendgmr) by 2002:a1c:1b14:: with SMTP id
 b20mr3965963wmb.170.1627565337101; Thu, 29 Jul 2021 06:28:57 -0700 (PDT)
Date:   Thu, 29 Jul 2021 14:28:12 +0100
In-Reply-To: <20210729132818.4091769-1-qperret@google.com>
Message-Id: <20210729132818.4091769-16-qperret@google.com>
Mime-Version: 1.0
References: <20210729132818.4091769-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v3 15/21] KVM: arm64: Introduce addr_is_memory()
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

Introduce a helper usable in nVHE protected mode to check whether a
physical address is in a RAM region or not.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h | 1 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index cc86598654b9..5968fbbb3514 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -51,6 +51,7 @@ extern const u8 pkvm_hyp_id;
 int __pkvm_prot_finalize(void);
 int __pkvm_mark_hyp(phys_addr_t start, phys_addr_t end);
 
+bool addr_is_memory(phys_addr_t phys);
 int host_stage2_idmap_locked(u64 start, u64 end, enum kvm_pgtable_prot prot);
 int host_stage2_set_owner_locked(u64 start, u64 end, u8 owner_id);
 int kvm_host_prepare_stage2(void *pgt_pool_base);
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index bb18940c3d12..4532f3d55a1a 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -196,6 +196,13 @@ static bool find_mem_range(phys_addr_t addr, struct kvm_mem_range *range)
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
2.32.0.432.gabb21c7263-goog

