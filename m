Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBFE942264A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 14:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbhJEMW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 08:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbhJEMW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 08:22:28 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F26C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 05:20:37 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id w2-20020a5d5442000000b0016061c95fb7so5651557wrv.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 05:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=m/O1dgx/6dc/3G/WHpfSWl4EY1iI+ZyzOq/yOOojIvY=;
        b=OD7BHJzoRVq9YndsXgA6wM/uouP19YQUkJYZ8SUt7BtxMUEI+dl3vAXpdyo4nfKnWt
         Vsk3eSZrnL0Xe2Kf7qXbwwa9X56ZprMhgVUSz8+b4KMXu1kWFP2HjR5vgHXhPoy3q2uk
         X3Ii7WpVkiUK2r48b53wLkrH/4pqCMMwoVCZy/1d9SHnKai8GthwWqAm0kbbsLwMqyTZ
         L1rwzgHNArnHLbBPv0/S6y4EUzjDFknvyxBXSxWd2aNnJOK/6Th6VsFTHqsxAsWAuz5N
         4/OkIdVv/6RiRMYvlaDGJumhw+2CBQPd+nv8BstqehoOILYGz0t1fie2R4BxE5Rh3G3V
         6DuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=m/O1dgx/6dc/3G/WHpfSWl4EY1iI+ZyzOq/yOOojIvY=;
        b=LjWtRA988rxGOdPMVMAURGCob11WdRJy9kJ8Z3UrGO5QzK7hZyQGYt93gRVahOaCW/
         UilprWbRt1DuJpPnWIDFJxAY9c006aJlV+aMkd+Nbewk8OT7gAhcKN/Ar3FArmqbwRHH
         rDLhXmlBCIwIIOryPxdq8ZCE0hOeRYFIDTpM1eVUxSynHie0+XLRBNnD3WWH37ybLDYd
         USrbX2173yVCvAQOj5xWFCePheOSQf8gMNLJwD24ZeyB6uGrWRTjKuemsIE7U0UgtdES
         HHA/sZ2uZC9FQrBlF1MFnHOUsv6m4E+DiMZBudqqSiUcGskyUAGacLJcZ/JSfgnevRWS
         8e8w==
X-Gm-Message-State: AOAM530K+ioPGeu6RWWsnMdXAUc9NmCZWyK62ACGe65jlBjfhhtWU+97
        I4NX2TJclLhAV83cLlGsmnI7TuO5iiNH
X-Google-Smtp-Source: ABdhPJwmuoUenb0uSWOlCBVEwk5H7f0VMu8HbnUjMB8fSNcFpLR024d7GwmK+6XLgt3zfreUU7OOwG2C8UMa
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:c8bd:fb02:d32e:faa0])
 (user=qperret job=sendgmr) by 2002:a05:600c:3b26:: with SMTP id
 m38mr612627wms.0.1633436435583; Tue, 05 Oct 2021 05:20:35 -0700 (PDT)
Date:   Tue,  5 Oct 2021 13:20:31 +0100
Message-Id: <20211005122031.809857-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH] KVM: arm64: Release mmap_lock when using VM_SHARED with MTE
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steven Price <steven.price@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VM_SHARED mappings are currently forbidden in a memslot with MTE to
prevent two VMs racing to sanitise the same page. However, this check
is performed while holding current->mm's mmap_lock, but fails to release
it. Fix this by releasing the lock when needed.

Fixes: ea7fc1bb1cd1 ("KVM: arm64: Introduce MTE VM feature")
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/mmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 1a94a7ca48f2..69bd1732a299 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1529,8 +1529,10 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 		 * when updating the PG_mte_tagged page flag, see
 		 * sanitise_mte_tags for more details.
 		 */
-		if (kvm_has_mte(kvm) && vma->vm_flags & VM_SHARED)
-			return -EINVAL;
+		if (kvm_has_mte(kvm) && vma->vm_flags & VM_SHARED) {
+			ret = -EINVAL;
+			break;
+		}
 
 		if (vma->vm_flags & VM_PFNMAP) {
 			/* IO region dirty page logging not allowed */
-- 
2.33.0.800.g4c38ced690-goog

