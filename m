Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953E93649E9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 20:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241159AbhDSSiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 14:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241056AbhDSSiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 14:38:21 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55110C061763
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 11:37:51 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id h15-20020a37de0f0000b029029a8ada2e18so5354683qkj.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 11:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HoqkQjsrXDA3MZHGIOhk4HW4WAmuJ8XwDMdNTYnM7sc=;
        b=ELAX9XpUiMG+kfljNBbVqTKe0lc7Ke4AvaC00ZGz8P71ngNC2AJQbz56Q4GyyPTMdI
         Ia9qpAxKMywq0uoRx1k/QJ3tiGLFaK/RIBN+yGpg2bdS2Ko/x4gBUpd6RdN+X/dJu01G
         JOD/HjSUw+gro2MBCX9WzBul4TX2nZRY9PtUZCiBm+Fsz/Jf3FBhoyzxj6Po3PT/iG4Y
         C/5nlFeMOTJyQq6bguLqVBgYHfBP79GQxZnEvcmdzvKZ3bFKFSHHpYsUx39TyUj18BdV
         YX1Y6HLweAJOJEvjAfwtHgLoBAWtUIZcaD/bXplVo8pAiXK2NhRu2YE6KjJVcsavnMEw
         rnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HoqkQjsrXDA3MZHGIOhk4HW4WAmuJ8XwDMdNTYnM7sc=;
        b=jb9+S5qIzISajULkugMKgk/KMtsrdjAF1Rbsn7uzeNJbPKeaJu4iOvDx/VG6iSXrXd
         n9IAEw7Z0cBLd+5I8M9041KTFub5rofWOMSNiHItHUMuvNu4yDEu/X1yn2VB7DvJ5N2F
         +VcdizUNQ6k+JWxHdir70+jhq0bjdtPNtvUCUhTEHqiX0Ff02yBwbe6U8xVGv80EQn2z
         aSI3UR61EmxdfY4HVLhLagD09A0j0mw6bJB9AZrMa/tQXYxaE+Swey4DQyFyjZp748HF
         QyjmyMLHO6i0eZZIO9rewI8vzYIyBO5WtGqnUPaprb7I1JoYCU3hRJu+2i6f8ItNlEIE
         Ohrw==
X-Gm-Message-State: AOAM532bnsPHC/YdDucFDczr6q3Zt+FsijGnzCc4DkfYuG1cCGICsjsD
        IJ2AryFe9uziuJWYAVT9Img8Cl0/089A5kv8+eWUpKn+zb0HKerwR+o8rrj2fwfi0IfRlrpv6Lv
        74gQrazGX9iXepAgWAPQWn3xQPAxW0Dobo1WfN+niZzWs9YTxggL3zK9cSwm16sUemFzmX6qu
X-Google-Smtp-Source: ABdhPJxDNUQifVrK5TglBw9VRQKofuvrxcmJwhMYLJLGSLq74F0mICiz92LmaYaprKTgoKs/JILk/og/CCcL
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:8c52:76ef:67d7:24b1])
 (user=bgardon job=sendgmr) by 2002:a0c:fbc5:: with SMTP id
 n5mr23225135qvp.0.1618857470495; Mon, 19 Apr 2021 11:37:50 -0700 (PDT)
Date:   Mon, 19 Apr 2021 11:37:42 -0700
In-Reply-To: <20210419183742.901647-1-bgardon@google.com>
Message-Id: <20210419183742.901647-2-bgardon@google.com>
Mime-Version: 1.0
References: <20210419183742.901647-1-bgardon@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH 2/2] KVM: x86/mmu: Fix typo in for_each_tdp_mmu_root
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Robert Hu <robert.hu@intel.com>,
        Farrah Chen <farrah.chen@intel.com>,
        Danmei Wei <danmei.wei@intel.com>,
        Ben Gardon <bgardon@google.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a typo in for_each_tdp_mmu_root which breaks compilation with
certain configurations. Fix it.

Fixes: 078d47ee71d6 ("KVM: x86/mmu: Protect the tdp_mmu_roots list with RCU")

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 8ce8d0916042..f0aef4969754 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -152,7 +152,7 @@ static struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
 #define for_each_tdp_mmu_root(_kvm, _root, _as_id)				\
 	list_for_each_entry_rcu(_root, &_kvm->arch.tdp_mmu_roots, link,		\
 				lockdep_is_held_type(&kvm->mmu_lock, 0) ||	\
-				lockdep_is_help(&kvm->arch.tdp_mmu_pages_lock))	\
+				lockdep_is_held(&kvm->arch.tdp_mmu_pages_lock))	\
 		if (kvm_mmu_page_as_id(_root) != _as_id) {		\
 		} else
 
-- 
2.31.1.368.gbe11c130af-goog

