Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBB742C589
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 17:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237145AbhJMQB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236277AbhJMQBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:01:08 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F24C061749
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:59:04 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id kk3-20020a056214508300b00382d8d1bd71so2979269qvb.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DEoxdh+qQqNfn4kriXOPtuGm5/KezrtRJAuAEOvIIEc=;
        b=TpLWDDRB66gNFtTO9H4DRYs+65J/g5K+vn3S4IswImh0cKDwKxr4tBSjZcRccVl/Gl
         PA7nAXYwmNvaJhrKw46Ts3VNmjOrJZAny7BGVWCNErEuHLrCRinaJt33ySp3tdu1rhlU
         ObF8iMNmln/oDydOezVDr5M8tvVtysJpT8v+dFboU9XBwY12v9a9YJdoISKQDzlPyc89
         gwxqYq45K+oRmNXwFvSb/RgfedaC9VADqHJA3tsa8lwe9+sahvN4PIU9zbtzmjuqi1TS
         TY2B5+x2nY3sIMBjjwqLbn3F5AEhqAsehabz6sua9uKu7eipWBEh68yQaYKn6biu+OzM
         jw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DEoxdh+qQqNfn4kriXOPtuGm5/KezrtRJAuAEOvIIEc=;
        b=rv6wfSB47FchnkElzmDOGIg/6PMnPuVJ1Z//gsZzbIHplFGAo1wxFvarIh6pbbE+89
         FZlmoh8ChThvNghHTuDrFA+D9NZ3cnCUz9ZC1kpbp78pO8rU4kzyP4lD+l05HhDDaVFJ
         KPDYO9i4/K4csqlCMS5R64HGRnG+hq7kGwTNtL9jO8TrvRl6jJ7DRLn5KHE/NBrFwic2
         ZkXGCvqJODLJQ5oVLVekNTPqh5n5X39sGezh0/mAmbbbPS4SDnm1kTRmoHo9+5I/oeNX
         BVXHbmJkNgniue383SazuWBq4x/UYkDdGapgataUKPNoILDj+p82iGW8hts5b2PEt3BA
         UfEg==
X-Gm-Message-State: AOAM532RcL2MlJuXtUg6ifXpU1D+aD+lKNLsDwxFXbZCVv/ZdFnFqhsS
        OfmOmM+ZBhZtOlBIF5ICeHIST8eZe5Vp
X-Google-Smtp-Source: ABdhPJxxY5hYqLzNoNmIsVUGeAsrdYoGroAg6GyRP+fKCKJAdv6jBH4kuWvly/Nv7EL03M4qWkxiLE/AW3NG
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:65b5:73d3:1558:b9ae])
 (user=qperret job=sendgmr) by 2002:ac8:5385:: with SMTP id
 x5mr73629qtp.105.1634140744121; Wed, 13 Oct 2021 08:59:04 -0700 (PDT)
Date:   Wed, 13 Oct 2021 16:58:28 +0100
In-Reply-To: <20211013155831.943476-1-qperret@google.com>
Message-Id: <20211013155831.943476-14-qperret@google.com>
Mime-Version: 1.0
References: <20211013155831.943476-1-qperret@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 13/16] KVM: arm64: Move double-sharing logic into hyp-specific function
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
        David Brazdil <dbrazdil@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

Strictly speaking, double-sharing a page is an invalid transition and
should be rejected, however we allow this in order to simplify the
book-keeping when KVM metadata (such as vcpu structures) co-exists in
the same page.

Given that double-sharing is only required for pages shared with the
hypervisor by the host, move the handling into a hyp-specific function
to check incoming shares, therefore preventing double-sharing outside
of this particular transition.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 57 +++++++++++++++++++--------
 1 file changed, 41 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 909e60f71b06..3378117d010c 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -536,6 +536,33 @@ static int ack_share(struct pkvm_page_share_ack *ack,
 	}
 }
 
+static int hyp_check_incoming_share(struct pkvm_page_req *req,
+				    struct pkvm_page_share_ack *ack,
+				    enum pkvm_component_id initiator,
+				    enum kvm_pgtable_prot prot)
+{
+	/*
+	 * We allow the host to share the same page twice, but that means we
+	 * have to check that the states really do match exactly.
+	 */
+	if (initiator != PKVM_ID_HOST)
+		return -EPERM;
+
+	if (req->initiator.state != PKVM_PAGE_SHARED_OWNED)
+		return -EPERM;
+
+	if (ack->completer.state != PKVM_PAGE_SHARED_BORROWED)
+		return -EPERM;
+
+	if (ack->completer.phys != req->phys)
+		return -EPERM;
+
+	if (ack->completer.prot != prot)
+		return -EPERM;
+
+	return 0;
+}
+
 /*
  * Check that the page states in the initiator and the completer are compatible
  * for the requested page-sharing operation to go ahead.
@@ -544,6 +571,8 @@ static int check_share(struct pkvm_page_req *req,
 		       struct pkvm_page_share_ack *ack,
 		       struct pkvm_mem_share *share)
 {
+	struct pkvm_mem_transition *tx = &share->tx;
+
 	if (!addr_is_memory(req->phys))
 		return -EINVAL;
 
@@ -552,25 +581,22 @@ static int check_share(struct pkvm_page_req *req,
 		return 0;
 	}
 
-	if (req->initiator.state != PKVM_PAGE_SHARED_OWNED)
-		return -EPERM;
-
-	if (ack->completer.state != PKVM_PAGE_SHARED_BORROWED)
-		return -EPERM;
-
-	if (ack->completer.phys != req->phys)
-		return -EPERM;
-
-	if (ack->completer.prot != share->prot)
+	switch (tx->completer.id) {
+	case PKVM_ID_HYP:
+		return hyp_check_incoming_share(req, ack, tx->initiator.id,
+						share->prot);
+	default:
 		return -EPERM;
-
-	return 0;
+	}
 }
 
 static int host_initiate_share(struct pkvm_page_req *req)
 {
 	enum kvm_pgtable_prot prot;
 
+	if (req->initiator.state == PKVM_PAGE_SHARED_OWNED)
+		return 0;
+
 	prot = pkvm_mkstate(PKVM_HOST_MEM_PROT, PKVM_PAGE_SHARED_OWNED);
 	return host_stage2_idmap_locked(req->initiator.addr, PAGE_SIZE, prot);
 }
@@ -595,6 +621,9 @@ static int hyp_complete_share(struct pkvm_page_req *req,
 	void *start = (void *)req->completer.addr, *end = start + PAGE_SIZE;
 	enum kvm_pgtable_prot prot;
 
+	if (req->initiator.state == PKVM_PAGE_SHARED_OWNED)
+		return 0;
+
 	prot = pkvm_mkstate(perms, PKVM_PAGE_SHARED_BORROWED);
 	return pkvm_create_mappings_locked(start, end, prot);
 }
@@ -653,10 +682,6 @@ static int do_share(struct pkvm_mem_share *share)
 		if (ret)
 			break;
 
-		/* Allow double-sharing by skipping over the page */
-		if (req.initiator.state == PKVM_PAGE_SHARED_OWNED)
-			continue;
-
 		ret = initiate_share(&req, share);
 		if (ret)
 			break;
-- 
2.33.0.882.g93a45727a2-goog

