Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAEF33CA0A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 00:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbhCOXiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 19:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbhCOXiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 19:38:16 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87139C061763
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 16:38:16 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id b136so2338241qkc.20
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 16:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bVFbFclWH6TVYcwCc+4Ci62XlhbttvVSTzGI6/A6UWQ=;
        b=bnmsw1QoRPS3s1v5bLuw2O+C1XzhjnLkvJZUHsa6fsbxPrVE7xckFD+pctBDSa8UJt
         YUTztapQGgjjwidq0KXl5UhkhBLOpJ3Vd13vu8+qDuerXA+zT0v8TvvH/Ocztju7/3+t
         24IYgEXsan4t7lO/9liC0yb4s3lghkEi+/gt7HE8yYE5LY6YgSwEBKosuUtU7LaBYlBx
         WMUPDSrcmql1hyxO1REX18EA8HXV6A+yAvYiNO7MXrvOs/U7XYG+5sY/l0dQv2EeT4UH
         oJgXt3eZVSfrw1xRueBaqMQuhzGmrnwbirr7Sx7+vlJ7l6LZxwnX+SyMV19mCEDCssfn
         wxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bVFbFclWH6TVYcwCc+4Ci62XlhbttvVSTzGI6/A6UWQ=;
        b=t2fAi1YXj2M5VSw8neFGzGSFYVf0gFPEtb4kcBiHw5Gi8vJZxT14Ics6kzKT1p7Jet
         ZRN17eXgcBIx2g9ha3sMn8h9en4IKCuPL7y6c+7JcM7zACdqnF9unuZ81JfDbXW/Cfp+
         h3lvpKDY8a1acVCXdN/2VRB64ffgDKFIofyk7mm8ytYNrAyqlkcvM7HZ8VFIqqwLxcQQ
         7n+fe+IS+MwIpPp2BLqNTWNXvnhJkts3LNdem+tiPTmDSkHh4hcI/6MWldcn9ovb//XD
         obdSq+y2/VAPTtxrDZKW0Aag9GzPpZrBsbsNyx3+0k15BRV9P5zMnzBK61WBnYK4PT8/
         Nb7w==
X-Gm-Message-State: AOAM533pGKMeRTIiEpIXQ+OR53PxZT92E/NJGUrytCk24ZnUk4KVXwdU
        457tv9v7TSfYoTlvDV+4P//Ge2QnWldYf0NSkP/iTTXS4YEsy7a7irgQWWcEUWkHxVdaRQpsk32
        VaSR33N8+9OL/MyuMXsNEsZrWfDP5g9gPTBqmTXX6PVRCi87M3OfRhIfwqT38J0uVGjEB/a1M
X-Google-Smtp-Source: ABdhPJyl9fl0/XiZ1Ci+Juu9xR/Oj+P6JLoVt2VTtmcqgs2461zw5PNZ3kkWaevlIWn7QJ6rL4eqGk0kyUaW
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:888a:4e22:67:844a])
 (user=bgardon job=sendgmr) by 2002:a05:6214:2623:: with SMTP id
 gv3mr12868051qvb.35.1615851495631; Mon, 15 Mar 2021 16:38:15 -0700 (PDT)
Date:   Mon, 15 Mar 2021 16:38:01 -0700
In-Reply-To: <20210315233803.2706477-1-bgardon@google.com>
Message-Id: <20210315233803.2706477-3-bgardon@google.com>
Mime-Version: 1.0
References: <20210315233803.2706477-1-bgardon@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v3 2/4] KVM: x86/mmu: Fix RCU usage when atomically zapping SPTEs
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Jim Mattson <jmattson@google.com>,
        Ben Gardon <bgardon@google.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a missing rcu_dereference in tdp_mmu_zap_spte_atomic.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index db2936cca4bf..946da74e069c 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -543,7 +543,7 @@ static inline bool tdp_mmu_zap_spte_atomic(struct kvm *kvm,
 	 * here since the SPTE is going from non-present
 	 * to non-present.
 	 */
-	WRITE_ONCE(*iter->sptep, 0);
+	WRITE_ONCE(*rcu_dereference(iter->sptep), 0);
 
 	return true;
 }
-- 
2.31.0.rc2.261.g7f71774620-goog

