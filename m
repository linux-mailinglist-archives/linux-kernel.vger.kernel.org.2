Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA8E387E81
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 19:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351250AbhERRf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 13:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351161AbhERRfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 13:35:43 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B48C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 10:34:24 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id j19-20020a63fc130000b029020f623342e0so6803087pgi.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 10:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=v1MO0W9O0n7ySv9W37vHhHDIdH76j1VB3klkPGT/WBc=;
        b=PO2xCBBq9JJtIvDZ8nDn5Ka4Edp0liYw6IfVGa9oMwRpTBLAu+UG3o574i7oMYNxXv
         udx/JxqDYBklu5i8dn0Vb0ugNbK/GO2+d/0k5MgHNuSPT8gG++vuxUhnOpQps0wJHUUV
         A+iMvzy1K1AseedYdAB86gcMgPQmUhm0PD1tSfOFuLgapqWlHEQEbov+m7ziEP79wxEH
         yElSKdINUd3pcddUO0wVlLXCUAGoaY+U4lO4Zf4QL6kOXhbgkOcGYeqqEd1crptMmSIt
         IAynryNMqK7F7Gj83ED8l8tGTyNf3sYz3satq3ftBc0MmO7bgSTvLxDRAuU5cqlhAGwB
         x6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=v1MO0W9O0n7ySv9W37vHhHDIdH76j1VB3klkPGT/WBc=;
        b=nejS+8LsHZ5wth+bkcu7sI0VPSrNrqQ71lew5BtlD05mFtq5XiskGLPEfNHy2N2/aC
         guZqi0I2rbXCqBnv+HjDDntE1Je5OqpARcaZLQXi3SwNmhU7JlWwZD2mT0qMFYFE/Ufa
         KyCDBAspM0C6pcKdJ636IDrbYq9xwe/0VSmHDzhJI45GdjXPNdiazV6AlMQ1UELrhHMM
         DYovzSsdFhXU+nxWyaSyvGO+Wogh/DB3nqoLnqQwW0YHaHVSdlMIwRlGE40cvZjwJAJA
         ujCK2hm4F3+PUFp2D4aDsqbYNpe1DHW1aIDZ25SaZ6Hdm3fmZUt/9WE4UD1/OVOBzXg6
         eC6Q==
X-Gm-Message-State: AOAM533J9FT86aYsu6ZxUDc5GKxvdBJr13TrO+1kaaoQZ521DTIc54zc
        Y5/4HcLVbE5Mlz/yW6pC3YYrMp0X6sVoMfQz9yNk74l9pDHHMDB0RiJi8+2drBMkEe6s56OgSX+
        FDbFjnS2/CrbDewDYb/tMmPdmNaVU2TA3lIrE+iUZOVkK0TQoaxpY1hE8BW3+kDa859HPPcNC
X-Google-Smtp-Source: ABdhPJw321z1csPExPfH8dsDrSd2fIlO/vtVqmtehmBJN7dVH2Sx5UUweKLHW0qGN3smX4BfLgWklnkpi2wX
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:2715:2de:868e:9db7])
 (user=bgardon job=sendgmr) by 2002:a05:6a00:1742:b029:2cc:b1b0:731c with SMTP
 id j2-20020a056a001742b02902ccb1b0731cmr6274826pfc.15.1621359263620; Tue, 18
 May 2021 10:34:23 -0700 (PDT)
Date:   Tue, 18 May 2021 10:34:10 -0700
In-Reply-To: <20210518173414.450044-1-bgardon@google.com>
Message-Id: <20210518173414.450044-4-bgardon@google.com>
Mime-Version: 1.0
References: <20210518173414.450044-1-bgardon@google.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v5 3/7] KVM: mmu: Refactor memslot copy
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Kai Huang <kai.huang@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out copying kvm_memslots from allocating the memory for new ones
in preparation for adding a new lock to protect the arch-specific fields
of the memslots.

No functional change intended.

Reviewed-by: David Hildenbrand <david@redhat.com>

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 virt/kvm/kvm_main.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 6b4feb92dc79..4acd4722d729 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1306,6 +1306,18 @@ static struct kvm_memslots *install_new_memslots(struct kvm *kvm,
 	return old_memslots;
 }
 
+static size_t kvm_memslots_size(int slots)
+{
+	return sizeof(struct kvm_memslots) +
+	       (sizeof(struct kvm_memory_slot) * slots);
+}
+
+static void kvm_copy_memslots(struct kvm_memslots *to,
+			      struct kvm_memslots *from)
+{
+	memcpy(to, from, kvm_memslots_size(from->used_slots));
+}
+
 /*
  * Note, at a minimum, the current number of used slots must be allocated, even
  * when deleting a memslot, as we need a complete duplicate of the memslots for
@@ -1315,19 +1327,16 @@ static struct kvm_memslots *kvm_dup_memslots(struct kvm_memslots *old,
 					     enum kvm_mr_change change)
 {
 	struct kvm_memslots *slots;
-	size_t old_size, new_size;
-
-	old_size = sizeof(struct kvm_memslots) +
-		   (sizeof(struct kvm_memory_slot) * old->used_slots);
+	size_t new_size;
 
 	if (change == KVM_MR_CREATE)
-		new_size = old_size + sizeof(struct kvm_memory_slot);
+		new_size = kvm_memslots_size(old->used_slots + 1);
 	else
-		new_size = old_size;
+		new_size = kvm_memslots_size(old->used_slots);
 
 	slots = kvzalloc(new_size, GFP_KERNEL_ACCOUNT);
 	if (likely(slots))
-		memcpy(slots, old, old_size);
+		kvm_copy_memslots(slots, old);
 
 	return slots;
 }
-- 
2.31.1.751.gd2f1c929bd-goog

