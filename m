Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23433341962
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhCSKDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbhCSKC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:02:56 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD61EC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:55 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id t14so4199674wrx.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=az3qu5AfEWynjCbFKTE0XZEp3dT+VbY/5SeZh8Qx1Io=;
        b=cxbBujXKeT7rjNVAEodiKZztncnTfQVckR4v8vwFPMKDrgrm1aS5gn6bsHGTh26ozr
         5NXwVfmV3JBwX9v2RgOlXugAGAj22i37MNTbOcZwFdW8Q8Q3L9fEdOvqiG7ablWqHS7F
         ZKZmf+usDnAKHy69Fovh8Oc7K0mZ1R7Kjz4m80j63v8xbEYNJT216buBFJQTuizAJmUs
         jBv+o9Q9+p3iUJ7tcHdP1AhV1463HK3ZlBCTE/xNJz3FJn2A+ruZ+LfKIQ85QUJhuulQ
         /P8bBvB0pH38dveW/rwtcRUU+iIcl/0fvhnTlyUEAkdskj8jaK4CCHehnwAvL7WIlDnt
         ydnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=az3qu5AfEWynjCbFKTE0XZEp3dT+VbY/5SeZh8Qx1Io=;
        b=Kms5IBolillnVsz2VckaAQgNDwNYcFpjRvwqEjOe79ZGN3JYPUjKVDN3WrJqXRma6D
         EJZMMgtXP+UdoGhVfylftAPuB3UrPBoOtMgILSCoNcom8t3S0DxeBWS8gTNH3ZFRskFl
         5nHVxjROFxNmp6ZQzrRjPPYlS8pwMYTwTY5Kyu44wbV8WIHsgnVHzxxXky8xYVzY1iOV
         P4Cai8QYbLJpbR7db9LWV/QWRkdNWVLAGHDHm8MUIil3kX8AB9EUikT6OC2B3Awf8DLs
         3lbmhbAxH8m0NuiVLUdfomsBEDPwVaHyg+6fSev6oBG0b3uwPWHmGTZoLrEdCa0iBmE8
         /LTA==
X-Gm-Message-State: AOAM533ofBDtHHh667QjWsxCAfGOAZUZKdsKUtkKt1YeMT5B3wbCcWx4
        VThF58MQimmXD/r+gL2D+b9eOzehGnkV
X-Google-Smtp-Source: ABdhPJw0KphugbkLaQeWstGqY/zCm8YSOnc3bOjtBswO1zBwU/9BG0fClCmUPZTFDDpqAABcRYc9sN+uHyq/
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:e18b:: with SMTP id
 y133mr2987504wmg.22.1616148174537; Fri, 19 Mar 2021 03:02:54 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:01:38 +0000
In-Reply-To: <20210319100146.1149909-1-qperret@google.com>
Message-Id: <20210319100146.1149909-31-qperret@google.com>
Mime-Version: 1.0
References: <20210319100146.1149909-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v6 30/38] KVM: arm64: Refactor the *_map_set_prot_attr() helpers
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to ease their re-use in other code paths, refactor the
*_map_set_prot_attr() helpers to not depend on a map_data struct.
No functional change intended.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index eefb226e1d1e..f4a514a2e7ae 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -325,8 +325,7 @@ struct hyp_map_data {
 	struct kvm_pgtable_mm_ops	*mm_ops;
 };
 
-static int hyp_map_set_prot_attr(enum kvm_pgtable_prot prot,
-				 struct hyp_map_data *data)
+static int hyp_set_prot_attr(enum kvm_pgtable_prot prot, kvm_pte_t *ptep)
 {
 	bool device = prot & KVM_PGTABLE_PROT_DEVICE;
 	u32 mtype = device ? MT_DEVICE_nGnRE : MT_NORMAL;
@@ -351,7 +350,8 @@ static int hyp_map_set_prot_attr(enum kvm_pgtable_prot prot,
 	attr |= FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S1_AP, ap);
 	attr |= FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S1_SH, sh);
 	attr |= KVM_PTE_LEAF_ATTR_LO_S1_AF;
-	data->attr = attr;
+	*ptep = attr;
+
 	return 0;
 }
 
@@ -408,7 +408,7 @@ int kvm_pgtable_hyp_map(struct kvm_pgtable *pgt, u64 addr, u64 size, u64 phys,
 		.arg	= &map_data,
 	};
 
-	ret = hyp_map_set_prot_attr(prot, &map_data);
+	ret = hyp_set_prot_attr(prot, &map_data.attr);
 	if (ret)
 		return ret;
 
@@ -501,8 +501,7 @@ u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift)
 	return vtcr;
 }
 
-static int stage2_map_set_prot_attr(enum kvm_pgtable_prot prot,
-				    struct stage2_map_data *data)
+static int stage2_set_prot_attr(enum kvm_pgtable_prot prot, kvm_pte_t *ptep)
 {
 	bool device = prot & KVM_PGTABLE_PROT_DEVICE;
 	kvm_pte_t attr = device ? PAGE_S2_MEMATTR(DEVICE_nGnRE) :
@@ -522,7 +521,8 @@ static int stage2_map_set_prot_attr(enum kvm_pgtable_prot prot,
 
 	attr |= FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S2_SH, sh);
 	attr |= KVM_PTE_LEAF_ATTR_LO_S2_AF;
-	data->attr = attr;
+	*ptep = attr;
+
 	return 0;
 }
 
@@ -742,7 +742,7 @@ int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
 		.arg		= &map_data,
 	};
 
-	ret = stage2_map_set_prot_attr(prot, &map_data);
+	ret = stage2_set_prot_attr(prot, &map_data.attr);
 	if (ret)
 		return ret;
 
-- 
2.31.0.rc2.261.g7f71774620-goog

