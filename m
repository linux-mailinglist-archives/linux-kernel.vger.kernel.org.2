Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7C3375A50
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 20:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbhEFSoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 14:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236445AbhEFSn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 14:43:59 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BA3C061763
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 11:43:00 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id o6-20020a0ccb060000b02901c0933b76e1so4872423qvk.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 11:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=O0n4OZEsHYcsD2VSr2bO/0IhfkveI/qdk1WzUKQRQFQ=;
        b=vFvBjOncg7aGdK7ZU3LRmt/7t3P8qKHD9RrHXpR7ksCarWtGJ5CoVNsZ3frJsz8zcE
         d+kD9605lOQD5m3JuliJXQ+DS6c8bTD4yRrrc+qvzedtPSYxHMgukU1t2NYZeLegfbDG
         u6gd6rV6z49+HuFFlf5U0l3sfgeEANJngIim1etpwROcdpRmka65K/Y0IDCQ2ePDryGU
         bTGnbnOWRyhozHOUegzpbf3bj+fDFDbTZyBcZBUgNLOcr5j4/OjiQwnlPsqfyHPQ6B8b
         waFkFvheUZ/oQebkPGpa3lux0lYv/ZOFxI7UgGzxrBa9dLdxuMP/1G9g0TBuw0UwuNy0
         3ofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=O0n4OZEsHYcsD2VSr2bO/0IhfkveI/qdk1WzUKQRQFQ=;
        b=OzVU54dj9osC5qNtmrR3o65GYSmWGsbV+LRApWwmXNDbsy2Fz9rLmTRQ0FhEf5wqTU
         0FXDUecYnEGpjmbkIV/zUZMvSQUGdGwZV7RmBTJIML3oyn31DqZD2pXn7GU6y+bxXBE9
         iD/bz0hkwOzwRtPCQuNmH4u7gDwCTUpLAqdHwP0hb/TQlG+ODT9/xkBsVda9M6Uikx23
         DEdZHK0snF8s9jtZwLtAGOy4ew85A8tKN8yQVSu2BMGPyy9I4X0D9qPDCA61oWGUfkh8
         N1o5jl5Sf9MldR61weeqsGqgf4skJahjT2NzMlnvWVPahRQ/Kl1FpB0EYRGc6BKNxpYj
         sXJw==
X-Gm-Message-State: AOAM53091YCjFrSWE0bJxpOk8LlXnhAAwWvfM/GH2Msmgb1vJ9tPzY8p
        KnYoobWOEBPlbnOaL1VT/tmZ9XICCzCix5ECQfdCUVWx6guMIe9Fj31YHwHzFMfV3kAaOfV4F3j
        9rntjyYWVYlaR7WgoK/4bltL26FDdDdLRr5DCmcgEvFoGOdsXqpKqsbg6C5HkBdmr/YniJd7k
X-Google-Smtp-Source: ABdhPJzbdZ5eidTYLUpqAxffM6plVUL8/poFE64k5MuNYLOFnQEKczGzc8DsayccIR3TMxHrquLZoy2dqOfk
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:9258:9474:54ca:4500])
 (user=bgardon job=sendgmr) by 2002:ad4:4634:: with SMTP id
 x20mr6228412qvv.49.1620326579461; Thu, 06 May 2021 11:42:59 -0700 (PDT)
Date:   Thu,  6 May 2021 11:42:36 -0700
In-Reply-To: <20210506184241.618958-1-bgardon@google.com>
Message-Id: <20210506184241.618958-4-bgardon@google.com>
Mime-Version: 1.0
References: <20210506184241.618958-1-bgardon@google.com>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH v3 3/8] KVM: mmu: Refactor memslot copy
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
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out copying kvm_memslots from allocating the memory for new ones
in preparation for adding a new lock to protect the arch-specific fields
of the memslots.

No functional change intended.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 virt/kvm/kvm_main.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2799c6660cce..c8010f55e368 100644
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
+static void kvm_copy_memslots(struct kvm_memslots *from,
+			      struct kvm_memslots *to)
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
+		kvm_copy_memslots(old, slots);
 
 	return slots;
 }
-- 
2.31.1.607.g51e8a6a459-goog

