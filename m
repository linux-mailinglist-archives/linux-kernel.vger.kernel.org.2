Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094943173F4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 00:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbhBJXIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 18:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbhBJXHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 18:07:54 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C43C06178B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 15:06:39 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id p22so4189487ybc.18
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 15:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=GEZo8w0hgK50yVJrGIa5NClbFF0q/1wZWPqztqSAI8U=;
        b=rn5yL60zWHOSQ+4padKHXvkuITHPNRNSNM+Cf+9acwDztaCvEP/GBVQ46b4K61tWUh
         0rBN1xLJTmrJEjlUWrvyxWAHzpYRU+matvsXKhc05IbcvNWPj8T75zjBFATONuPPrZxP
         omSVOmXteiC47KavBtmbXLlzcOdxpao3dOCmu9aeF4UKwlt2bQGEahNFJY4aBRP2PtFc
         rlr6BsK92Pffqxz8x+FWpJtjLmil2U1AXIjWuvO10GvEQ8DFttN4VfIiO+5fHXVjSRjP
         NwL5raeTygbl0rz7OCb3GgcHwErhtvIBEGR9Qc3TDbNsP7D8Sj/4OdNyyeNmRr5kUGvI
         yULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=GEZo8w0hgK50yVJrGIa5NClbFF0q/1wZWPqztqSAI8U=;
        b=sxJ/GDJ0L0msgJs1ANFlGPusD7A4IsDVUPyyvyfeB2PD2u6bUp6CmrSqWV81auJMaj
         HOx31NCFyCKrNoqdh5Kyp9QmXJ4AfEcS8qG1d8GAdRhRPqTM5v8sYvU8ZaO0jmfPb7x1
         ScUvW2gyvrnVOx4qXMfLyqgmWG1CT8BefcRzipYb9AIIxkW9h13RLA77RLe9uQlshapL
         I0JwlopTHt/K+0kY5RsKK7ZmCT/R2FU69i7LGeVGK1g7bDKJ4AEJTyHd9T9WGWHLEG0g
         lveKSjWTeag047i4e3NH7CKjqUr/TtEKra1+HFQrDPTDaGbvKqsX0AlqQdhz5qMKgBPG
         wMaQ==
X-Gm-Message-State: AOAM532v9jcIH6sXZ8zJeNMK/urTlZwX1DYLLpJpLIo1325A81sY3JKX
        TWw4PCk1YwklDuZnZTWDZZW6mH1R/II=
X-Google-Smtp-Source: ABdhPJyKAtmGiuCuTcqrHgv9sAQanTocQ/PtnpyWOrlk2ZIw5XLV1hGfoeCCdeS0VxjghnW0oJbtesz/eSA=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:11fc:33d:bf1:4cb8])
 (user=seanjc job=sendgmr) by 2002:a25:a241:: with SMTP id b59mr7767318ybi.289.1612998399020;
 Wed, 10 Feb 2021 15:06:39 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 10 Feb 2021 15:06:13 -0800
In-Reply-To: <20210210230625.550939-1-seanjc@google.com>
Message-Id: <20210210230625.550939-4-seanjc@google.com>
Mime-Version: 1.0
References: <20210210230625.550939-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH 03/15] KVM: selftests: Align HVA for HugeTLB-backed memslots
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Ben Gardon <bgardon@google.com>,
        Yanan Wang <wangyanan55@huawei.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align the HVA for HugeTLB memslots, not just THP memslots.  Add an
assert so any future backing types are forced to assess whether or not
they need to be aligned.

Cc: Ben Gardon <bgardon@google.com>
Cc: Yanan Wang <wangyanan55@huawei.com>
Cc: Andrew Jones <drjones@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Aaron Lewis <aaronlewis@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 584167c6dbc7..deaeb47b5a6d 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -731,8 +731,11 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	alignment = 1;
 #endif
 
-	if (src_type == VM_MEM_SRC_ANONYMOUS_THP)
+	if (src_type == VM_MEM_SRC_ANONYMOUS_THP ||
+	    src_type == VM_MEM_SRC_ANONYMOUS_HUGETLB)
 		alignment = max(huge_page_size, alignment);
+	else
+		ASSERT_EQ(src_type, VM_MEM_SRC_ANONYMOUS);
 
 	/* Add enough memory to align up if necessary */
 	if (alignment > 1)
-- 
2.30.0.478.g8a0d178c01-goog

