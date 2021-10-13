Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436FE42C58B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 17:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237710AbhJMQBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237194AbhJMQBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:01:11 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29F9C061765
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:59:07 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id v15-20020adfa1cf000000b00160940b17a2so2327009wrv.19
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5BoaM6D6gNLK4spf2rCygUFZYyg82caSdHjxEWdrlQU=;
        b=lCYZR0Kok1ZJ/F1Bc4qnzND5K7Zjs/qag8dPQUKLfKY1Vuju+0hrk97PbxTbLFIE92
         dhF98EBgTqhqQt92nIfoE7GMC2K4/ghR4OjSzZq65MJp4AT7ibXNQwUHSePHfSjriq+s
         qj1OBYf3ab/2GRzkKLmCCNN9sNsIntPaQklJ6mwQ/XKR3fKPsRo3EWTXDVVPSTrHWBVD
         1rD/QwOnSIbGCAAkjEKSTIRdQXrNpoLM7Rs+deBDWlZEA49xNVEQoxCXD+YunfwM3WR5
         9SFni/ujR7WAYzyn4Pom8B/djSepucfAa3KiUobigruMi97cJGEedWHGkG8p0udLt1y2
         BQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5BoaM6D6gNLK4spf2rCygUFZYyg82caSdHjxEWdrlQU=;
        b=mK91XMePgpoJlcmxCwIjVi/2OWgtnWn9MD3HYxSVhGvjzlx7bghkQTglw20yVGS5vW
         K28HVCmVVd7+57bRUyp4nlkicGIFKVUHHHxlzELZkYCQW7fo6RhbCu+UsMje0TEVrTd2
         1P4Kt6JKA5r3m8c7RxKYNbOZKNRGEz89KoY73HWZEbDmkhJI8yNSZuEreOiNzsrGWxpD
         e5aIHvwxHtynY1bXFv0rtDm7bL8DDz7+CwGSODTBYSuRdM/0Ux891ySmd/TcA6osEkFG
         ukEpnYAnduVVe0pz/A1ZZP5lTQpbNTkw6aWeMv3X+chDBjB2S2A4KEHTYrx0u2L6Ha4A
         +/Zg==
X-Gm-Message-State: AOAM530ilrfUHaNKe6NMCeX9HOQrjikJLlxrYfS5kCrWAXOjT/U6JO/i
        pgTwjFuN52nkpuR4aAoiEfV7YNIlW2kW
X-Google-Smtp-Source: ABdhPJycAkElHpHQ2AGMbSwm3DR+JicypQn/HrqmtGvR6c4BW8hrAjG63/uNsstYDVBkOL0PzEyul2i7qtoG
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:65b5:73d3:1558:b9ae])
 (user=qperret job=sendgmr) by 2002:a7b:cd90:: with SMTP id
 y16mr93339wmj.146.1634140746365; Wed, 13 Oct 2021 08:59:06 -0700 (PDT)
Date:   Wed, 13 Oct 2021 16:58:29 +0100
In-Reply-To: <20211013155831.943476-1-qperret@google.com>
Message-Id: <20211013155831.943476-15-qperret@google.com>
Mime-Version: 1.0
References: <20211013155831.943476-1-qperret@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 14/16] KVM: arm64: Refcount shared pages at EL2
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

We currently allow double sharing of pages from the hypervisor to the
host, but don't track how many times each page is shared. In order to
prepare the introduction of an unshare operation in the hypervisor,
refcount the physical pages which the host shares more than once.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 3378117d010c..cad76bc68e53 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -560,6 +560,9 @@ static int hyp_check_incoming_share(struct pkvm_page_req *req,
 	if (ack->completer.prot != prot)
 		return -EPERM;
 
+	if (WARN_ON(!hyp_phys_to_page(req->phys)->refcount))
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -619,13 +622,22 @@ static int hyp_complete_share(struct pkvm_page_req *req,
 			      enum kvm_pgtable_prot perms)
 {
 	void *start = (void *)req->completer.addr, *end = start + PAGE_SIZE;
+	struct hyp_page *page = hyp_phys_to_page(req->phys);
 	enum kvm_pgtable_prot prot;
+	int ret = 0;
 
-	if (req->initiator.state == PKVM_PAGE_SHARED_OWNED)
+	if (req->initiator.state == PKVM_PAGE_SHARED_OWNED) {
+		hyp_page_ref_inc(page);
 		return 0;
+	}
 
 	prot = pkvm_mkstate(perms, PKVM_PAGE_SHARED_BORROWED);
-	return pkvm_create_mappings_locked(start, end, prot);
+	ret = pkvm_create_mappings_locked(start, end, prot);
+
+	if (!ret)
+		hyp_set_page_refcounted(page);
+
+	return ret;
 }
 
 /* Update the completer's page-table for the page-sharing request */
-- 
2.33.0.882.g93a45727a2-goog

