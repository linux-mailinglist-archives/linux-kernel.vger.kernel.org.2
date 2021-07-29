Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5692A3DA431
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237716AbhG2N26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237666AbhG2N2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:28:49 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52865C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:28:45 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id d6-20020a50f6860000b02903bc068b7717so2952442edn.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3edu5r5MgiwqKIsFZqWR1OVvbwtz5pLkXdnxfKTgrkE=;
        b=kiFyFVttc3U28KQ3sfRTofJfHRrKRTa08Tr1wUv7AmJ7kmxQRQqWLqlx2vJLxnRtiB
         gRP5OSpTMXZ/ELbIz+ZiYYSRyHJQB4gpq308Q//Q+M8a+IkmJK4zXuePNe1iad8R6ja5
         eMzYY5Z+oyjxt+f/5LtLu0Hsc68dLxTSalqaiC6MOS51NM7Vok4vOIm5S9qUlX2pNnEf
         OeA6/wlF2Q8cQRv34+Q8Oe3lAuIlBdBzWJOPvwJcpQE1dOMoCrTw3OPaL+7abgre+E4P
         F0O7kH46klsMF5HsRReEdQc0jztwb9nOkD0bFWkPhtVneMWJ37S8n/CMDzd2iYeuib5c
         oFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3edu5r5MgiwqKIsFZqWR1OVvbwtz5pLkXdnxfKTgrkE=;
        b=LtWLRvWWGkzkNlJsndaoy4SJD7kRmQu+0aG/kzy7N7GXJrnXB1P5l0G0iqA1IRap1n
         wIKlPLVgtc5x43+t/YjSWR/J7qp382QIk41eRCtIEEkehhAz6ETrSHntjpZMxgGC8izF
         ERfMWYyOMnsRF/KME+QlY0M0mr75PBQgySYlovl7DKUTaXvKty9/zmAK3y/xyVIBujzT
         ICU04rv1vvtnrhj+NZyailkufZc/1rRMEGgBbhsn8rOM7Tha9RoJZ9UB6KlCqTw10WCv
         /APHiKeRDXVhFYq/GxMBNaTJb16ylRGchRF358TIJWYoCHqgf3VxPHXG50YqGX8AS0hN
         WViA==
X-Gm-Message-State: AOAM5321Rgd+KuBFL5zqt52WVWPuDblRWAluSTgKyRw21he+tDGNT++9
        t59pwbk1d5IqDnppNvffHDwVrjPsStgl
X-Google-Smtp-Source: ABdhPJwP/AN3fa8sbZcgybFMXXlf8hjA0Q9gZJpOb0OUTytheQm4ssO6cEU1bGXuFiecy7eUiVkRiSSKUJ8i
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:293a:bc89:7514:5218])
 (user=qperret job=sendgmr) by 2002:a17:906:2bc9:: with SMTP id
 n9mr4537344ejg.23.1627565323698; Thu, 29 Jul 2021 06:28:43 -0700 (PDT)
Date:   Thu, 29 Jul 2021 14:28:06 +0100
In-Reply-To: <20210729132818.4091769-1-qperret@google.com>
Message-Id: <20210729132818.4091769-10-qperret@google.com>
Mime-Version: 1.0
References: <20210729132818.4091769-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v3 09/21] KVM: arm64: Tolerate re-creating hyp mappings to set
 software bits
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

The current hypervisor stage-1 mapping code doesn't allow changing an
existing valid mapping. Relax this condition by allowing changes that
only target software bits, as that will soon be needed to annotate shared
pages.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 1ee1168ac32d..2689fcb7901d 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -362,6 +362,21 @@ static int hyp_set_prot_attr(enum kvm_pgtable_prot prot, kvm_pte_t *ptep)
 	return 0;
 }
 
+static bool hyp_pte_needs_update(kvm_pte_t old, kvm_pte_t new)
+{
+	/*
+	 * Tolerate KVM recreating the exact same mapping, or changing software
+	 * bits if the existing mapping was valid.
+	 */
+	if (old == new)
+		return false;
+
+	if (!kvm_pte_valid(old))
+		return true;
+
+	return !WARN_ON((old ^ new) & ~KVM_PTE_LEAF_ATTR_HI_SW);
+}
+
 static bool hyp_map_walker_try_leaf(u64 addr, u64 end, u32 level,
 				    kvm_pte_t *ptep, struct hyp_map_data *data)
 {
@@ -371,9 +386,8 @@ static bool hyp_map_walker_try_leaf(u64 addr, u64 end, u32 level,
 	if (!kvm_block_mapping_supported(addr, end, phys, level))
 		return false;
 
-	/* Tolerate KVM recreating the exact same mapping */
 	new = kvm_init_valid_leaf_pte(phys, data->attr, level);
-	if (old != new && !WARN_ON(kvm_pte_valid(old)))
+	if (hyp_pte_needs_update(old, new))
 		smp_store_release(ptep, new);
 
 	data->phys += granule;
-- 
2.32.0.432.gabb21c7263-goog

