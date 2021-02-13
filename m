Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE1231A8FD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 01:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbhBMAvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 19:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbhBMAvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 19:51:41 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA992C06178B
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 16:50:26 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 11so1515876ybl.21
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 16:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=i+ZGhrnKuPWM2EUTyjRTEqFvmRgkb+1SD/2rklmgcTk=;
        b=KqaYODfcV7nggQfaJ4scLLVmaifGfME/RMcIJIdgowvyGEWXW9E8lqApJYsKmfDrlF
         rjLe25VECS2mTpwRLbDq1JHOKHjlQUvkCf0nGaanW2J8XmTGoTHrQGgc1pu19DeG8QdM
         i4EQaOC2+MzIa22bqqVekL/UoA6S6HGSPFnYfPgxaeVK4ZATE/ItsocqH3HJdT9kOlF9
         XsRxpBvtjQunUw4OW98zBktnPUK4Ml4EW+cgBF3AMsaRxVkY9KcVdjSIV6sOEfnkCEjC
         Z0D2mcMiOSjglDyPduEYnkyBwib9myX0ATDli2qavK69zmg/dpL29Y0u/JcAX/gx2z0p
         qgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=i+ZGhrnKuPWM2EUTyjRTEqFvmRgkb+1SD/2rklmgcTk=;
        b=SxpgRAXSBryZutmWYEW/wXdPgSICVDb9rKf9BDEYJCwDv3h2w1RiXzxbOCWt29SYaZ
         OJ7Ubk1a0lGNLcVKNJnkxgDyEx8wABYIJFYO0LyolGl9JBSGzTC9DAFDP9lS//iOwcUM
         1hLX6JvFj/n7IlrpX37eH8+s+D2GrT70Z8nrd1BTw/FS8E2aNfZMxpylQFNIL7Ou0gAl
         GGUV7NBcrVIG1vISXuHgUaRm/zCyh+w6EBLin9MwNt/F2YWrC58Liat9i1YuN8xdCIx+
         v/m2PbwZvqsbyPDf/+ClOb//KREbjaq3u9/l2CPqTR5hvhT2zocCNwBhdrL+WZsEMZlk
         cYUA==
X-Gm-Message-State: AOAM530O45pndt2M9bSJVUbix8Mg8458pyOUO8UgCpwwWd/cY8lP1RXa
        6rtzQRYLxbpjrr2pFVSQmRr9U5gS0zg=
X-Google-Smtp-Source: ABdhPJydadXiqwiePPV/u2nRZxbP9oNG8qal8CxU4l+Y3inZUDXFtfyb9NoV3cZws6bGobKUJ1RK+HH9dPk=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:b407:1780:13d2:b27])
 (user=seanjc job=sendgmr) by 2002:a5b:44f:: with SMTP id s15mr7978526ybp.85.1613177425898;
 Fri, 12 Feb 2021 16:50:25 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 12 Feb 2021 16:50:03 -0800
In-Reply-To: <20210213005015.1651772-1-seanjc@google.com>
Message-Id: <20210213005015.1651772-3-seanjc@google.com>
Mime-Version: 1.0
References: <20210213005015.1651772-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH 02/14] KVM: x86/mmu: Don't unnecessarily write-protect small
 pages in TDP MMU
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Makarand Sonare <makarandsonare@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Respect start_level when write-protect pages in the TDP MMU for dirty
logging.  When the dirty bitmaps are initialized with all bits set, small
pages don't need to be write-protected as they've already been marked
dirty.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index e507568cd55d..24325bdcd387 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5500,7 +5500,7 @@ void kvm_mmu_slot_remove_write_access(struct kvm *kvm,
 	flush = slot_handle_level(kvm, memslot, slot_rmap_write_protect,
 				start_level, KVM_MAX_HUGEPAGE_LEVEL, false);
 	if (is_tdp_mmu_enabled(kvm))
-		flush |= kvm_tdp_mmu_wrprot_slot(kvm, memslot, PG_LEVEL_4K);
+		flush |= kvm_tdp_mmu_wrprot_slot(kvm, memslot, start_level);
 	write_unlock(&kvm->mmu_lock);
 
 	/*
-- 
2.30.0.478.g8a0d178c01-goog

