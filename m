Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E13E3E48B8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbhHIPZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235604AbhHIPZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:25:33 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E6DC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 08:25:12 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id j1-20020ac866410000b029028bef7ed9e1so7813905qtp.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 08:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WndYnCDMOQzlPd71DewOIEPIaBhgx4ZmPbtWCPoDRhI=;
        b=XGuSt0YhxsImBr6msmOACUEnWDe5RjoMRsWfC6joinmJxH/ccrEqwcaqr0K9ea4kDM
         PLHmWbi+Lhh8yLHGdXomBavPSRAVZMAL8cyJlzE7Ayf/3/45f4IoNaWo2Hb4qacFglSJ
         +BJ8TUJOkcwkRMUt0arMJGnO1cL6VjSD/1EiVvMtauBxIazQsTDmLji32PyBKfkGscqY
         O+JEUiGOAV/z1LTCyODiwmScRaa//NHIuIiu2LpdEoVb3iH/ax0Akw30emloxQ5Y3LWh
         H7zcq+JTl/1swFcTt7/katDOOq5zfZrHT4eTqWSmVRKgGfAImEknabYM4aLPjNb8p8J4
         d1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WndYnCDMOQzlPd71DewOIEPIaBhgx4ZmPbtWCPoDRhI=;
        b=CGqTAB4Vsxyx32aUKJyFS3OpbhAdD45nCnV/DP+5pn0hBSkdMnt0n84ilEECl73sqU
         SBbjPkF30phPxb4Gv0c/CGt5T0vhKSs6qF1gnjJaBOfSk8ReQ/c3Buo60No46nwYzGFe
         +QVRmRu3gUXQT+jeA8CHChNv2SP3Rors01kj4gVefBrlW+zzkW4ZzzajF9ZeLQm2WGqz
         aAcLQAuXLDQ11mgz/c0+Wya7JgL482UtKm2ymcckN1ADmDnzbZC58inGDMLrZVGfptid
         0UH84DaggI67uiZj+i3SAFX1uoONwvTiKqVpuoW2uDC2VNCLdd0NIy+J3+BzSm/E6kvN
         CAsA==
X-Gm-Message-State: AOAM532B8qNQR19kdxBbRtgQxw8HFALMz5Nq/FmyXCTuaS/HwCQfO7Qn
        nWK9ol9c7fXIqkREUlt9KzGJEsR+NOFA
X-Google-Smtp-Source: ABdhPJxKbzxXq3vACntXFb3WeX5U2azY/J4P0m64KOuxC+yq1GUbq1EaY8YQtx4SiagyVZzS09eoTaGzaXW+
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:b0e8:d460:758b:a0ae])
 (user=qperret job=sendgmr) by 2002:a05:6214:10c4:: with SMTP id
 r4mr24444934qvs.58.1628522711297; Mon, 09 Aug 2021 08:25:11 -0700 (PDT)
Date:   Mon,  9 Aug 2021 16:24:36 +0100
In-Reply-To: <20210809152448.1810400-1-qperret@google.com>
Message-Id: <20210809152448.1810400-10-qperret@google.com>
Mime-Version: 1.0
References: <20210809152448.1810400-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v4 09/21] KVM: arm64: Tolerate re-creating hyp mappings to set
 software bits
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

The current hypervisor stage-1 mapping code doesn't allow changing an
existing valid mapping. Relax this condition by allowing changes that
only target software bits, as that will soon be needed to annotate shared
pages.

Reviewed-by: Fuad Tabba <tabba@google.com>
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
2.32.0.605.g8dce9f2422-goog

