Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D244F375A49
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 20:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbhEFSnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 14:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbhEFSnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 14:43:50 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E69CC061761
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 11:42:51 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id u126-20020a3792840000b02902e769005fe1so4159171qkd.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 11:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ma9cEaNYQpiK24KAk14C2pwYKbfgwwx99tQd6V1vKOE=;
        b=LYvO9qL1KxuwwY8zXKo8FEJSIkPJvM+7iXkMC0Ql2RmJ+Aw8djkGrqQ0nooXX6LCqN
         vMoOU9dJbIHD2f/Nulg/MfRdxBbl17p77oGdeUwkND0cORvXlBjaOFjLgCQRhzCDu+SZ
         57ndJ1qJcK22He2ba7+ttqL5NibboxrFqI1uEZBymduSL0WTc06py/ny14uFb6D2DIoX
         79gV/oWqiT52iuQhyOCI+RgJa8arP8yybkAdYC8woKQd5WlhpTuqrgCzZOKXa5248qY/
         22QKi4SBvhMs156Q7+cOLCExdqJMbUFMRqU1ahGdAAm5R95VxNuYQ69xcgFea9U+L6CW
         uJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ma9cEaNYQpiK24KAk14C2pwYKbfgwwx99tQd6V1vKOE=;
        b=sBnUzZVG63esh0reI+5DYkYZhsB8v40r4E5UiNFEk8BsLwBA/tJ3leXg6I4xnxU6TJ
         DEosWndc+W4Bww0HEuOtsmc/ZQJWLN1MirYfG6BNMQgSsw07aMMZLXqZ8K3JNoDIUUte
         vUIVca5WNo07gA4iDDnfHwsj+IwVKRrjWAErohQQAT+uBRGBApnQQRfZBGG9nyCpflrh
         E3pJTNO7k21iwCmlcv8FInoQAL+nFpDMpsXOii+GIKgl684u3cX67bQCAqxkrkrLbvvF
         nfyV+jjzAOZnJ6rBMr8sFqJgDhgcXwFCZaz+odUMwg5WEiaC6wb1QwyuJS4zDb1azxAC
         wUlQ==
X-Gm-Message-State: AOAM5336i05ksEj0BTfvglxT5IWSFRisxvQllG1DcBpTc2NW9eU9+XOq
        TNJ85Njxkr6sAlVBP7eJJWagrXKQ/kPTYAc7hnVDFU2ccFcUnzXnhDcrGp4C2LTTMuq7djxQKih
        5lrXG1z7homDQk9l1YYrgfxH9mHecefLtB49ojxP75Sw3fYN9nyI7mn2jB/qpqL01bENQaJT0
X-Google-Smtp-Source: ABdhPJyNENTXrdjoSVNfItEX8J3Wb9EZHsSLEqNWcC9gEkVhLgIiJnnSfDKBbjTgQAWFiU+dEWlxTpcpyu/k
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:9258:9474:54ca:4500])
 (user=bgardon job=sendgmr) by 2002:a0c:b28c:: with SMTP id
 r12mr3231963qve.32.1620326570257; Thu, 06 May 2021 11:42:50 -0700 (PDT)
Date:   Thu,  6 May 2021 11:42:34 -0700
In-Reply-To: <20210506184241.618958-1-bgardon@google.com>
Message-Id: <20210506184241.618958-2-bgardon@google.com>
Mime-Version: 1.0
References: <20210506184241.618958-1-bgardon@google.com>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH v3 1/8] KVM: x86/mmu: Deduplicate rmap freeing
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

Small code deduplication. No functional change expected.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/x86.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index cf3b67679cf0..5bcf07465c47 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10818,17 +10818,23 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	kvm_hv_destroy_vm(kvm);
 }
 
-void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
+static void free_memslot_rmap(struct kvm_memory_slot *slot)
 {
 	int i;
 
 	for (i = 0; i < KVM_NR_PAGE_SIZES; ++i) {
 		kvfree(slot->arch.rmap[i]);
 		slot->arch.rmap[i] = NULL;
+	}
+}
 
-		if (i == 0)
-			continue;
+void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
+{
+	int i;
+
+	free_memslot_rmap(slot);
 
+	for (i = 1; i < KVM_NR_PAGE_SIZES; ++i) {
 		kvfree(slot->arch.lpage_info[i - 1]);
 		slot->arch.lpage_info[i - 1] = NULL;
 	}
@@ -10894,12 +10900,9 @@ static int kvm_alloc_memslot_metadata(struct kvm_memory_slot *slot,
 	return 0;
 
 out_free:
-	for (i = 0; i < KVM_NR_PAGE_SIZES; ++i) {
-		kvfree(slot->arch.rmap[i]);
-		slot->arch.rmap[i] = NULL;
-		if (i == 0)
-			continue;
+	free_memslot_rmap(slot);
 
+	for (i = 1; i < KVM_NR_PAGE_SIZES; ++i) {
 		kvfree(slot->arch.lpage_info[i - 1]);
 		slot->arch.lpage_info[i - 1] = NULL;
 	}
-- 
2.31.1.607.g51e8a6a459-goog

