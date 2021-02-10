Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CF8316EE3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 19:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbhBJSi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 13:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbhBJS1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 13:27:00 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E6FC0617A7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 10:26:20 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 6so3409542ybq.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 10:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=qP8W8fesy6rJnl8LFgqcqjLlutMaErDAaGGZqrc5ReM=;
        b=IDp6SH8FucguzZwM8vydazWPuRkkyBURwiL/ZFhG83f5Q5Y+skiev5m88thBUBeLYl
         Iay7T5UchXCsRJGKwHSl4hVNHJ/uBXakaJW5DzO7yZx/DyNf4TA8C9JFEoBsct6RZp0/
         sKNwBbf3IFpvZbbYrwy15yEgKWeCtsA29trFbXPLw0+5eCelppO7mtBn+X/1IpXEQr70
         iUilso7ROd+pLw5F43ylf16NL7Pyr8kl11UulCYa4UYzdZHZKsnhGvHosy94UoAabhaz
         X1pvWU5032pfh2HnarV4zCvh06PlflO5u6EgP2Te3X8H5jJPaYw7yy+BC6lRWTPPQSOF
         148g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=qP8W8fesy6rJnl8LFgqcqjLlutMaErDAaGGZqrc5ReM=;
        b=nxDuFKYCKMZsXpKR94oIrqXOFHG2YYais4zjnKzy6ie1ncSo1DpExt6EkCI/m5FOfl
         T4Iy1AxIkCiZptiBNZSr1ydmaQmfrAQzzpBDXqfJ7nXX/Y9HwXkP4bbURGtGvZJNaFtN
         VY6Kvx1mILGKZxw9jzVkjO4JEJtZ7Ww2Jll0fd94fL9BFR85Jl/5jKMw7+Qup3QRjLVa
         mrMtIU/XuYynYzeFWZf8pi2AJ4dBjPttC6a9aCAEDfvq94Z7jHV+9NEwDKirA3SI5GGu
         87mUT+qdWtwUGVd7Tzv6lFShw34nNgf4Jx2KqwY1oQ6RTeQ6HKBAZmjNBiWEy+6NiqpT
         Qb9w==
X-Gm-Message-State: AOAM5329PX+X7ek4pG/Jz51dJbtlsmZ20/z/c6aoceMeT+GUkOrsYIZV
        7EzojApcihFcVhzEkP/hGuulbLoH/+M=
X-Google-Smtp-Source: ABdhPJyTPd8l9+mGvnSeTAJBG98ENRZMMYVImrNTwMJ6HjhsDvl2vtCgsZfrvQuK99U9B1lHIpDbTDAOWVM=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:11fc:33d:bf1:4cb8])
 (user=seanjc job=sendgmr) by 2002:a25:ad26:: with SMTP id y38mr6225800ybi.391.1612981579216;
 Wed, 10 Feb 2021 10:26:19 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 10 Feb 2021 10:26:06 -0800
In-Reply-To: <20210210182609.435200-1-seanjc@google.com>
Message-Id: <20210210182609.435200-3-seanjc@google.com>
Mime-Version: 1.0
References: <20210210182609.435200-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH 2/5] KVM: selftests: Fix size of memslots created by Xen tests
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For better or worse, the memslot APIs take the number of pages, not the
size in bytes.  The Xen tests need 2 pages, not 8192 pages.

Fixes: 8d4e7e80838f ("KVM: x86: declare Xen HVM shared info capability and add test case")
Cc: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c | 3 +--
 tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
index bdb3feb86b5b..cb3963957b3b 100644
--- a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
@@ -79,8 +79,7 @@ int main(int argc, char *argv[])
 
 	/* Map a region for the shared_info page */
 	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
-                                    SHINFO_REGION_GPA, SHINFO_REGION_SLOT,
-				    2 * getpagesize(), 0);
+				    SHINFO_REGION_GPA, SHINFO_REGION_SLOT, 2, 0);
 	virt_map(vm, SHINFO_REGION_GPA, SHINFO_REGION_GPA, 2, 0);
 
 	struct kvm_xen_hvm_config hvmc = {
diff --git a/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c b/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c
index 86653361c695..8389e0bfd711 100644
--- a/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c
@@ -102,8 +102,7 @@ int main(int argc, char *argv[])
 
 	/* Map a region for the hypercall pages */
 	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
-                                    HCALL_REGION_GPA, HCALL_REGION_SLOT,
-				    2 * getpagesize(), 0);
+				    HCALL_REGION_GPA, HCALL_REGION_SLOT, 2, 0);
 	virt_map(vm, HCALL_REGION_GPA, HCALL_REGION_GPA, 2, 0);
 
 	for (;;) {
-- 
2.30.0.478.g8a0d178c01-goog

