Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C1E3CD2B3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 12:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbhGSKHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 06:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236710AbhGSKHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:07:16 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40FBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 02:55:51 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id d16-20020a1c73100000b02901f2d21e46efso5278681wmb.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 03:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4jouoD7WbUci7xn3YtWW0XHxA5H2d8wOqC0fOlAh9f8=;
        b=Uv/xPNZZd0zvHFvxq2GpDnhKRoZfKfkYeT7JrfEvu+elD14GHfRJV2UfPlcuLH0Nv9
         xGP4lSDAuHT744H30Nr3FuQqtA7zcfsuBVg1gpqjrcW0+SAKgbz3XsLytXwgeRD38gsy
         5U18heYUtdx1QOOER3ojuOyNMtIncmDBZRxyoXBEp12SJ5nq8mYIRIOoWUAxkLpxFWf/
         0MCRFOXhNv1Q4vAH+jiL5e8tyam8wKhtdPh0pvlTNUJuICxDUt4OlVPGpz2JloawDALr
         robsnCnc2EuFshx4qttMo42h1bgE0+RRFB1TJsGSde7AB8wG/OeSkfs/zeHYYE7cARWQ
         ybpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4jouoD7WbUci7xn3YtWW0XHxA5H2d8wOqC0fOlAh9f8=;
        b=kyGqeQF8kyY+gzbXUPzu9z+0zIu3OBQwQTNXqOuN8oyCfsaN+t9CjKvNXbd9qc+2qB
         L5q7RDdNex64r+JaMYG6qtbVP3XY8wvG5cgLgyPkMc4B8CmPVEhTPpIhuyqHS8OG0zz9
         wyg3DBuzUMcfz+4swwg3sMJI67rlnegFmTktsmsARNWA5ywT7uziw9moq1z8ySdbAIh8
         GHHxrfvKLCcfTYs5fVncCiM23wPeA+E9yLA7QBlD8XH2rrJZcjCsZ5lDzIN9CXusNU1Y
         EvLuEjs0yrZaGNpou28uCk4+BDfKuXWOi5i//tWhNaQ4E/Oe+hpzB8CTm02rVIETBKoD
         M5Hg==
X-Gm-Message-State: AOAM532eDhxJ0xbRNbzihki169W5RtSrrQtczB3PxaseK1nyYZEv5G/o
        PzcXY4wGcIioxa/eKEuO0FCQqn7rpiMv
X-Google-Smtp-Source: ABdhPJy/15n8M0Ndba/dPTUyDBcKgkjR9P3nSTL+iqL9mRoICMhdiGix+x/jfDLh68tcSqBfBCw3QGLbUiX4
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:1a96:a43f:6c2e:bb5a])
 (user=qperret job=sendgmr) by 2002:a1c:1bd0:: with SMTP id
 b199mr25225892wmb.108.1626691674895; Mon, 19 Jul 2021 03:47:54 -0700 (PDT)
Date:   Mon, 19 Jul 2021 11:47:27 +0100
In-Reply-To: <20210719104735.3681732-1-qperret@google.com>
Message-Id: <20210719104735.3681732-7-qperret@google.com>
Mime-Version: 1.0
References: <20210719104735.3681732-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 06/14] KVM: arm64: Tolerate re-creating hyp mappings to set
 ignored bits
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
only target ignored bits, as that will soon be needed to annotate shared
pages.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index a0ac8c2bc174..34cf67997a82 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -362,6 +362,17 @@ static int hyp_set_prot_attr(enum kvm_pgtable_prot prot, kvm_pte_t *ptep)
 	return 0;
 }
 
+static bool hyp_pte_needs_update(kvm_pte_t old, kvm_pte_t new)
+{
+	if (old == new)
+		return false;
+
+	if (!kvm_pte_valid(old))
+		return true;
+
+	return !WARN_ON((old ^ new) & ~KVM_PTE_LEAF_ATTR_IGNORED);
+}
+
 static bool hyp_map_walker_try_leaf(u64 addr, u64 end, u32 level,
 				    kvm_pte_t *ptep, struct hyp_map_data *data)
 {
@@ -371,9 +382,12 @@ static bool hyp_map_walker_try_leaf(u64 addr, u64 end, u32 level,
 	if (!kvm_block_mapping_supported(addr, end, phys, level))
 		return false;
 
-	/* Tolerate KVM recreating the exact same mapping */
+	/*
+	 * Tolerate KVM recreating the exact same mapping, or changing ignored
+	 * bits.
+	 */
 	new = kvm_init_valid_leaf_pte(phys, data->attr, level);
-	if (old != new && !WARN_ON(kvm_pte_valid(old)))
+	if (hyp_pte_needs_update(old, new))
 		smp_store_release(ptep, new);
 
 	data->phys += granule;
-- 
2.32.0.402.g57bb445576-goog

