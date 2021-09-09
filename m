Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0884404304
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 03:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349983AbhIIBmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 21:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349609AbhIIBkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 21:40:25 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7856FC0611BC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 18:38:54 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id r18-20020a056214069200b0037a291a6081so1972653qvz.18
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 18:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZaJi8CrqCPyJ9SPVj5/tYaTEiQv3pZu/dBaNxFMezdY=;
        b=PpNPK3uv3KYTEq4zFRqcV0VpV1U/YFs1TworIZSltJ6BzjGT+CFyrsaUQ81pFogUpL
         pbP/AhfGKn8nVNt0WTzGj6Z0pBSDe5pb8JxKb4lU3xhg4/hh859JoG10iSFxaDX/Ty8y
         ed8kkUkiiYlectcv79/1l4B0ScLwUy5TYyCI8eSdU1OIyOw3AlwBzYxwPV213RHZn+tL
         c92kEM3PpqswL8bzE3Rt3tU2Gb5AaGu+c6TGX+YETcwN19ItCASnme49ODyP5pAtuM20
         5p6KnSq3BtkfvaGY7VjbVR/49ilbif92hnkWMBdj7yBJen8/3hFDiBNs3pao0KsWwySB
         MLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZaJi8CrqCPyJ9SPVj5/tYaTEiQv3pZu/dBaNxFMezdY=;
        b=ifs0qB99jHEfbtVWNoJeYaIFcPKqCwjy/C/cfO4w+M2UyQDCiFpaeRzm/Gzk2VE7Mx
         Rc02HbTcjU2uF+xUFZk1U484MUqGyFIreWqPWK9reT1Cf0YFY7J8iNVWaKUCJybgiGma
         5BAeldEVpCz0MyorTL947DhkWL5kkFO+8kWuecBpmAKTQ5wra4DJCRgG8ZMSyC0wKIWk
         He9wPF/KxSbsrZqIRr/nD+oBJaLLkLIjvDnE9Euf0bp6ySo4mKeWx72pu4xJiS93IKAz
         4G7EnhGFdIX9qTfRTYd7d6d6F4XUikqp4eSus5JQk8RrJZn5m2w0gkh6STvIZn74gEUq
         Voxw==
X-Gm-Message-State: AOAM531/yKbjS+zsALz7XVHdyQbuvCTZg8fLzYUDhEi5VL+iAVJFpLav
        DQQ2Io1GfoNNZMB+RZiO5KF9jhgjvwBN
X-Google-Smtp-Source: ABdhPJy8pEbKtkdH/W5PM7WuN1paWanl2LDh5YKLnSr+Z8j+HMVfew5uBZscRMSLZ2k43Mgwzdxpo2kAQeIp
X-Received: from rananta-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a05:6214:104d:: with SMTP id
 l13mr485175qvr.13.1631151533677; Wed, 08 Sep 2021 18:38:53 -0700 (PDT)
Date:   Thu,  9 Sep 2021 01:38:12 +0000
In-Reply-To: <20210909013818.1191270-1-rananta@google.com>
Message-Id: <20210909013818.1191270-13-rananta@google.com>
Mime-Version: 1.0
References: <20210909013818.1191270-1-rananta@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH v4 12/18] KVM: selftests: Keep track of the number of vCPUs
 for a VM
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Raghavendra Rao Anata <rananta@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The host may want to know the number of vCPUs that were
created for a particular VM (used in upcoming patches).
Hence, include nr_vcpus as a part of 'struct kvm_vm' to
keep track of vCPUs as and when they are added or
deleted, and return to the caller via vm_get_nr_vcpus().

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h      | 1 +
 tools/testing/selftests/kvm/lib/kvm_util.c          | 7 +++++++
 tools/testing/selftests/kvm/lib/kvm_util_internal.h | 1 +
 3 files changed, 9 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 010b59b13917..d5d0ca919928 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -399,5 +399,6 @@ uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc);
 
 int vm_get_stats_fd(struct kvm_vm *vm);
 int vcpu_get_stats_fd(struct kvm_vm *vm, uint32_t vcpuid);
+int vm_get_nr_vcpus(struct kvm_vm *vm);
 
 #endif /* SELFTEST_KVM_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 10a8ed691c66..1b5349b5132f 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -594,6 +594,7 @@ static void vm_vcpu_rm(struct kvm_vm *vm, struct vcpu *vcpu)
 
 	list_del(&vcpu->list);
 	free(vcpu);
+	vm->nr_vcpus--;
 }
 
 void kvm_vm_release(struct kvm_vm *vmp)
@@ -1143,6 +1144,7 @@ void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid)
 
 	/* Add to linked-list of VCPUs. */
 	list_add(&vcpu->list, &vm->vcpus);
+	vm->nr_vcpus++;
 }
 
 /*
@@ -2343,3 +2345,8 @@ int vcpu_get_stats_fd(struct kvm_vm *vm, uint32_t vcpuid)
 
 	return ioctl(vcpu->fd, KVM_GET_STATS_FD, NULL);
 }
+
+int vm_get_nr_vcpus(struct kvm_vm *vm)
+{
+	return vm->nr_vcpus;
+}
diff --git a/tools/testing/selftests/kvm/lib/kvm_util_internal.h b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
index a03febc24ba6..be4d852d2f3b 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util_internal.h
+++ b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
@@ -56,6 +56,7 @@ struct kvm_vm {
 	unsigned int va_bits;
 	uint64_t max_gfn;
 	struct list_head vcpus;
+	int nr_vcpus;
 	struct userspace_mem_regions regions;
 	struct sparsebit *vpages_valid;
 	struct sparsebit *vpages_mapped;
-- 
2.33.0.153.gba50c8fa24-goog

