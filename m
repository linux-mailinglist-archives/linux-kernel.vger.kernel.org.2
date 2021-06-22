Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754B33B0E41
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 22:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbhFVUIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 16:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbhFVUIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 16:08:22 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F87C0611C1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 13:06:02 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id e13-20020a37e50d0000b02903ad5730c883so2109090qkg.22
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 13:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=HLRh8AoU2d8SgUrNmHvZ5Mv1ioaKQWiagkHThEpM1Is=;
        b=G+GmFiPkocigkueGFrHCAgPjZhDtZlm7aPH7CS0V9LTvDu1nKkmqh3PUSLhTtriueE
         V29YT5vnhv6ZAttFC/tB+VsqGlU45uuxR8zOiTO3LX7lyZi7E2B2PN46GizH2hzXSMP5
         9gGV5cO7JYYAUAZPqyibqXMxhLn7jW+6L+7Z+ac5k8HOQVwJk5xH2OhJKk2QOtSoYZza
         7M/S8pvXOuJIVhrSWU4ytbQAexzjNIgpZdHSF+1v5OvJqA4+kdRoS4QzQyqflHaluR2w
         T8WjkKdYxrG447Dmcl/+t1G4wkL+opHWKWFPVGush4MrJFGB15GtNETh9yza730zYilo
         qdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=HLRh8AoU2d8SgUrNmHvZ5Mv1ioaKQWiagkHThEpM1Is=;
        b=JJ4SqngYL3amOFANdrvd4Jav5eAHmCm4iagFrRBFcZnqSseKqu+zkvpOWJAc/XTplB
         ceFyRwCmXwDe4VhxBxPFZ4eZt37KiVIak02bBl1EzbAlf57hnXT9eoSmA7cs/Evsgio9
         XYbzWF2haX+nMLIF4Nkq1rN+k4ePenQFYGfeYtyOMUOlC0PQhj8xjj7iyqqyV/7qlGXv
         4AUzxwpEaDLJpJ6H3eSsvB/40jyqNpylaZldSSjffJZkyHaoz4zyzq6E36wloIBe8CT+
         EdqjwbKgMi8ApwId4a7bLIfZcKBluqOVcDX7+TM3Genk/T67/UqXNbVLyLwGOZerj6oo
         EJ4Q==
X-Gm-Message-State: AOAM532ljttqdv8MJY3oqiihCNCFYBfmEavTe0EcnGeAGBeaSjG2I1Fc
        dKSAO7Ti9olDFsC9uLYMHGq79Sqjkzo=
X-Google-Smtp-Source: ABdhPJzEPoaOhegczuUyhwK+503E54Bl8gSY/uaudyXrO4kdWtq3dfiFDpHOuZxavTgRIELElHBaj8Jxe2U=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:7d90:4528:3c45:18fb])
 (user=seanjc job=sendgmr) by 2002:a0c:80ec:: with SMTP id 99mr506577qvb.55.1624392361765;
 Tue, 22 Jun 2021 13:06:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 22 Jun 2021 13:05:20 -0700
In-Reply-To: <20210622200529.3650424-1-seanjc@google.com>
Message-Id: <20210622200529.3650424-11-seanjc@google.com>
Mime-Version: 1.0
References: <20210622200529.3650424-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 10/19] KVM: selftests: Use "standard" min virtual address for
 CPUID test alloc
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use KVM_UTIL_MIN_ADDR as the minimum for x86-64's CPUID array.  The
system page size was likely used as the minimum because _something_ had
to be provided.  Increasing the min from 0x1000 to 0x2000 should have no
meaningful impact on the test, and will allow changing vm_vaddr_alloc()
to use KVM_UTIL_MIN_VADDR as the default.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86_64/get_cpuid_test.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/get_cpuid_test.c b/tools/testing/selftests/kvm/x86_64/get_cpuid_test.c
index 8c77537af5a1..5e5682691f87 100644
--- a/tools/testing/selftests/kvm/x86_64/get_cpuid_test.c
+++ b/tools/testing/selftests/kvm/x86_64/get_cpuid_test.c
@@ -145,8 +145,7 @@ static void run_vcpu(struct kvm_vm *vm, uint32_t vcpuid, int stage)
 struct kvm_cpuid2 *vcpu_alloc_cpuid(struct kvm_vm *vm, vm_vaddr_t *p_gva, struct kvm_cpuid2 *cpuid)
 {
 	int size = sizeof(*cpuid) + cpuid->nent * sizeof(cpuid->entries[0]);
-	vm_vaddr_t gva = vm_vaddr_alloc(vm, size,
-					getpagesize(), 0, 0);
+	vm_vaddr_t gva = vm_vaddr_alloc(vm, size, KVM_UTIL_MIN_VADDR, 0, 0);
 	struct kvm_cpuid2 *guest_cpuids = addr_gva2hva(vm, gva);
 
 	memcpy(guest_cpuids, cpuid, size);
-- 
2.32.0.288.g62a8d224e6-goog

