Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6D24335A4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbhJSMPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbhJSMPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:15:39 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13529C061745
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:13:27 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id l8-20020a5d6d88000000b001611b5de796so10085982wrs.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FltoTPFX6jcmVGDt6TNVLWqV+gbyvD26Qibq15L3bkE=;
        b=jlG1oEJu0XALf3UMY9dDzZLKa57GGILI3CeQZbwtRWFXxRmxyJ4hrufsS2cJNR8YIr
         JNvbgekimwjNmNstdhzrPkwKZqgPJPeSo0J71SXvKrgiUXiuiHLmruUHs8rcc/indAiX
         26CLj+txDLSji5YnWMA6yzm7AtzfIVGTatEphI+y5c26xa90hXLAlmYFL//1dTQQOyPw
         HMCbzOhB4xv2VomYIlo14xWYxcD4vbtMZhrxk2yL7qWC5KwsBpwln8lsNwynvPrxIQHB
         Xiss9bsk7TSpL1SH0P53UFrzTXqsorbicgZEDet4/UyMoolHEu3NjoWnHFqaYu3ykP1r
         VGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FltoTPFX6jcmVGDt6TNVLWqV+gbyvD26Qibq15L3bkE=;
        b=fnQjhqIwib6T0FbXJbqd95IQPoz/7Y8gJeM3YJUfm3spL2+0vCES+pQk8uuV9NFQ8l
         eNH9YdGxHw2YGlLLmn3vFPOWFuJmSx4j8sgHJm655hSikEXhXokxGzts/0Ah8nDsVjax
         CIJ14z6aUOftHjs4iAs7DFUWpmoVv5wSfAw7TpD3WhaD4FJBporqJu/qxmZAzL94uvED
         IYv40NKDI6bp4L2gmb2yhnAC8jazCcP7Tiz0iUha7kQxR6NzfZEPus8ryZhFxvxCH8tB
         Zyo6d+yCZ5KzZm7pfrde658WDwqBverZhyOLRaFIbU0lko021Th9giHNC3CAK8CBk7/I
         Y/ow==
X-Gm-Message-State: AOAM5302y0qajG7gjz615PYSc8zoHd+l3CYL2DWx7wJHVNfcjTsIOtoD
        g0PrIIKTJs01WcqM2RT5lv8W/WtQsE6z
X-Google-Smtp-Source: ABdhPJzHTfoE95BxQfr07fXGEheE3lVwrZ1OysKwSSC2rt9N5CO+2igZJDqU/WMlnTkRLHPLM8olUAyj+sVU
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:59ca:401f:83a8:de6d])
 (user=qperret job=sendgmr) by 2002:a1c:2309:: with SMTP id
 j9mr5432829wmj.189.1634645605661; Tue, 19 Oct 2021 05:13:25 -0700 (PDT)
Date:   Tue, 19 Oct 2021 13:12:57 +0100
In-Reply-To: <20211019121304.2732332-1-qperret@google.com>
Message-Id: <20211019121304.2732332-9-qperret@google.com>
Mime-Version: 1.0
References: <20211019121304.2732332-1-qperret@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 08/15] KVM: arm64: pkvm: Refcount the pages shared with EL2
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
        David Brazdil <dbrazdil@google.com>,
        Andrew Walbran <qwandor@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to simplify the page tracking infrastructure at EL2 in nVHE
protected mode, move the responsibility of refcounting pages that are
shared multiple times on the host. In order to do so, let's create a
red-black tree tracking all the PFNs that have been shared, along with
a refcount.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/mmu.c | 78 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 68 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 0cc4b295e525..f0c16ed95974 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -284,30 +284,88 @@ static phys_addr_t kvm_kaddr_to_phys(void *kaddr)
 	}
 }
 
-static int pkvm_share_hyp(phys_addr_t start, phys_addr_t end)
+struct hyp_shared_pfn {
+	u64 pfn;
+	int count;
+	struct rb_node node;
+};
+
+static DEFINE_MUTEX(hyp_shared_pfns_lock);
+static struct rb_root hyp_shared_pfns = RB_ROOT;
+
+static struct hyp_shared_pfn *find_shared_pfn(u64 pfn, struct rb_node ***node,
+					      struct rb_node **parent)
 {
-	phys_addr_t addr;
-	int ret;
+	struct hyp_shared_pfn *this;
+
+	*node = &hyp_shared_pfns.rb_node;
+	*parent = NULL;
+	while (**node) {
+		this = container_of(**node, struct hyp_shared_pfn, node);
+		*parent = **node;
+		if (this->pfn < pfn)
+			*node = &((**node)->rb_left);
+		else if (this->pfn > pfn)
+			*node = &((**node)->rb_right);
+		else
+			return this;
+	}
 
-	for (addr = ALIGN_DOWN(start, PAGE_SIZE); addr < end; addr += PAGE_SIZE) {
-		ret = kvm_call_hyp_nvhe(__pkvm_host_share_hyp,
-					__phys_to_pfn(addr));
-		if (ret)
-			return ret;
+	return NULL;
+}
+
+static int share_pfn_hyp(u64 pfn)
+{
+	struct rb_node **node, *parent;
+	struct hyp_shared_pfn *this;
+	int ret = 0;
+
+	mutex_lock(&hyp_shared_pfns_lock);
+	this = find_shared_pfn(pfn, &node, &parent);
+	if (this) {
+		this->count++;
+		goto unlock;
 	}
 
-	return 0;
+	this = kzalloc(sizeof(*this), GFP_KERNEL);
+	if (!this) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+	this->pfn = pfn;
+	this->count = 1;
+	rb_link_node(&this->node, parent, node);
+	rb_insert_color(&this->node, &hyp_shared_pfns);
+	ret = kvm_call_hyp_nvhe(__pkvm_host_share_hyp, pfn, 1);
+unlock:
+	mutex_unlock(&hyp_shared_pfns_lock);
+
+	return ret;
 }
 
 int kvm_share_hyp(void *from, void *to)
 {
+	phys_addr_t start, end, cur;
+	u64 pfn;
+	int ret;
+
 	if (is_kernel_in_hyp_mode())
 		return 0;
 
 	if (kvm_host_owns_hyp_mappings())
 		return create_hyp_mappings(from, to, PAGE_HYP);
 
-	return pkvm_share_hyp(kvm_kaddr_to_phys(from), kvm_kaddr_to_phys(to));
+	start = ALIGN_DOWN(kvm_kaddr_to_phys(from), PAGE_SIZE);
+	end = PAGE_ALIGN(kvm_kaddr_to_phys(to));
+	for (cur = start; cur < end; cur += PAGE_SIZE) {
+		pfn = __phys_to_pfn(cur);
+		ret = share_pfn_hyp(pfn);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 /**
-- 
2.33.0.1079.g6e70778dc9-goog

