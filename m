Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9CC317400
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 00:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbhBJXKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 18:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbhBJXIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 18:08:12 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A409C06121C
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 15:06:51 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id v13so2646229qvm.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 15:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=e5jFMrrVTL3Dr57yHyEm8DbSRLvZbC2fcWOYRcpawLw=;
        b=jmUj7q3UldLs6UfNTjcZFYwOWuWOU5AEIh73Rn0L0A4OwvAp8hNiKjx6UrN32ZTfku
         /nZd+Kgbvgkc0F6kH1bSD++xWkguFd94O0gFCt6TykBWVfbWzeAQ6LdaxebM8ETCGS7O
         SmTIPmQaG61cJ0C7o7eXm6KBXgLBPjiNh01C5ZzGui+hIkQQhAt4fjRPG0tUWp9+jb5W
         xuv2C9sTiPtfXKySs/3K6ghx+Ctt6DHCu6PKCXX7ccSqj4jm9KrVd1RV1olES8jpWaKw
         rNXCnWLvC2VtbRlGO1SEgALBj4rF+zS5hp34r+tQcho0v3jWBPKVpJ025q0D31pXCVGz
         tRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=e5jFMrrVTL3Dr57yHyEm8DbSRLvZbC2fcWOYRcpawLw=;
        b=UNQvLnAnuyVzNxOes16Krm/gYkV1Z4vsVDzplwNDjaoq0MMryME7KV5LJYyfweGcL+
         73SPsYxdlwjBYoIM3UVyzjUbVW4LHT96MKCGt3TP+dQJu3d6cfDzLKuYmXMtd0o0BRY+
         X9iKT77exbamYpqkTB73x05H3LjNdk0+Ibxvj4nUe6sTl/VWIeV3DZy1SMICqTgL29qa
         iIYI7e1xxIqHW1owbETzSgaJnhU5Z4TJ2X7R5fXRQvLmM+pVx5rlQYOYtoUBNFSW1z7C
         K1bcJN12C8QvoXByK2jiC39/RRSLBcjGaT2k8DeUM1xJ6grnbhqXWmu2UAJeONs0E8Qg
         0Axw==
X-Gm-Message-State: AOAM532+gRJFSudGv//SsGjmPGd1VLHJ7kUx0XawDjYMQTjXX0qkdlsi
        ilB9uyWFjDwn6K079b8HVWIhdAfjBpw=
X-Google-Smtp-Source: ABdhPJxc4qHNBFHbYRDNxf4FuEMWtACgfpMEd2VqY/lSClmBZhLHicmuP6qrtwxeJam5kLy3ONb23opabhQ=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:11fc:33d:bf1:4cb8])
 (user=seanjc job=sendgmr) by 2002:a0c:bd93:: with SMTP id n19mr5163222qvg.5.1612998410537;
 Wed, 10 Feb 2021 15:06:50 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 10 Feb 2021 15:06:18 -0800
In-Reply-To: <20210210230625.550939-1-seanjc@google.com>
Message-Id: <20210210230625.550939-9-seanjc@google.com>
Mime-Version: 1.0
References: <20210210230625.550939-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH 08/15] KVM: selftests: Use perf util's per-vCPU GPA/pages in
 demand paging test
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

Grab the per-vCPU GPA and number of pages from perf_util in the demand
paging test instead of duplicating perf_util's calculations.

Note, this may or may not result in a functional change.  It's not clear
that the test's calculations are guaranteed to yield the same value as
perf_util, e.g. if guest_percpu_mem_size != vcpu_args->pages.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/demand_paging_test.c        | 20 +++++--------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 5f7a229c3af1..0cbf111e6c21 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -294,24 +294,13 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 		TEST_ASSERT(pipefds, "Unable to allocate memory for pipefd");
 
 		for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++) {
-			vm_paddr_t vcpu_gpa;
+			struct perf_test_vcpu_args *vcpu_args;
 			void *vcpu_hva;
-			uint64_t vcpu_mem_size;
 
-
-			if (p->partition_vcpu_memory_access) {
-				vcpu_gpa = guest_test_phys_mem +
-					   (vcpu_id * guest_percpu_mem_size);
-				vcpu_mem_size = guest_percpu_mem_size;
-			} else {
-				vcpu_gpa = guest_test_phys_mem;
-				vcpu_mem_size = guest_percpu_mem_size * nr_vcpus;
-			}
-			PER_VCPU_DEBUG("Added VCPU %d with test mem gpa [%lx, %lx)\n",
-				       vcpu_id, vcpu_gpa, vcpu_gpa + vcpu_mem_size);
+			vcpu_args = &perf_test_args.vcpu_args[vcpu_id];
 
 			/* Cache the HVA pointer of the region */
-			vcpu_hva = addr_gpa2hva(vm, vcpu_gpa);
+			vcpu_hva = addr_gpa2hva(vm, vcpu_args->gpa);
 
 			/*
 			 * Set up user fault fd to handle demand paging
@@ -325,7 +314,8 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 						&uffd_handler_threads[vcpu_id],
 						pipefds[vcpu_id * 2],
 						p->uffd_delay, &uffd_args[vcpu_id],
-						vcpu_hva, vcpu_mem_size);
+						vcpu_hva,
+						vcpu_args->pages * perf_test_args.guest_page_size);
 			if (r < 0)
 				exit(-r);
 		}
-- 
2.30.0.478.g8a0d178c01-goog

