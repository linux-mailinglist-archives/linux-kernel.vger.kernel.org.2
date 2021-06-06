Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5781A39CC30
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 04:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhFFCMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 22:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhFFCMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 22:12:43 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962EAC061766
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 19:10:54 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g24so7723846pji.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 19:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7avx2T8f075ARet+0gGeHoQ0BkJ0iTYTzjaHSANW1to=;
        b=QQHK6kAQgP62w4Xo6NZCZy1A+Doq3PGUXA6fKwZJ0tBCDDUGNHhVQctQ4gXzZOEEPA
         5Pm/Yi1QXKzoXZC8sE+SD2GRml3XABQ5Oh4Pov3S3XHMoSjQ0kwvqQ1hgITFMX/nasdn
         vxUQNk1QwN+EBk+pfvC6+lr1AQRWL7Cid4j00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7avx2T8f075ARet+0gGeHoQ0BkJ0iTYTzjaHSANW1to=;
        b=EIJF4NQMJOkkmrDYlSX+/shAsV6ZyIBFKNzSjDqu4SWq4KaWFiHSI9Bz7/CjVSoNF8
         vdrBEPLK01fDvfKtVxMjwtHq54DO+qGzfo/M0eou9zFvaT1nXE5SMMt3/vEmM9z8lIKD
         /X2YIxOVbwuN/nLQkcNSNG+DAWZUgWTLjj/v+TeUrWkwuWlVNGpgO1CAciqiDp1MwoiI
         GXHKmnKiUEbvET5Pl0UY7lVBDetAZhySn6mzdrD2lxKZFHCWWAaraDHBdd0XrbqBRavu
         kOHQafbvixpiY6W34+lDkA90+dTj9ZuUB+y0/4/VpCzxTHQMZHTp0g7priffoJecy0YO
         xFsw==
X-Gm-Message-State: AOAM531COsUQeBlIkl9Act2K8fmc401Vbm2S5Wqsg7DGHPoWdPUUJzD9
        Nj5+LAHYFAzK9r+Q6KM7JIolCQ==
X-Google-Smtp-Source: ABdhPJwY64pggEuDy675dLTbCM9e3Z6V0n3gZaVRNlPKed1atW5KZCdzpxFNj1ey3LdknZOP32X9mQ==
X-Received: by 2002:a17:90a:7c4b:: with SMTP id e11mr25569688pjl.73.1622945451082;
        Sat, 05 Jun 2021 19:10:51 -0700 (PDT)
Received: from senozhatsky.flets-east.jp ([2409:10:2e40:5100:c87a:995:bf9d:93bb])
        by smtp.gmail.com with ESMTPSA id v15sm5586327pgf.26.2021.06.05.19.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 19:10:50 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suleiman Souhlal <suleiman@google.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 1/2] kvm: add PM-notifier
Date:   Sun,  6 Jun 2021 11:10:44 +0900
Message-Id: <20210606021045.14159-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add KVM PM-notifier so that architectures can have arch-specific
VM suspend/resume routines. Such architectures need to select
CONFIG_HAVE_KVM_PM_NOTIFIER and implement kvm_arch_pm_notifier().

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 include/linux/kvm_host.h |  9 +++++++++
 virt/kvm/Kconfig         |  3 +++
 virt/kvm/kvm_main.c      | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 76102efbf079..3db4c22e93cd 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -28,6 +28,7 @@
 #include <linux/rcuwait.h>
 #include <linux/refcount.h>
 #include <linux/nospec.h>
+#include <linux/notifier.h>
 #include <asm/signal.h>
 
 #include <linux/kvm.h>
@@ -585,6 +586,10 @@ struct kvm {
 	pid_t userspace_pid;
 	unsigned int max_halt_poll_ns;
 	u32 dirty_ring_size;
+
+#ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
+	struct notifier_block pm_notifier;
+#endif
 };
 
 #define kvm_err(fmt, ...) \
@@ -998,6 +1003,10 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu);
 
+#ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
+int kvm_arch_pm_notifier(struct kvm *kvm, unsigned long state);
+#endif
+
 #ifdef __KVM_HAVE_ARCH_VCPU_DEBUGFS
 void kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu, struct dentry *debugfs_dentry);
 #endif
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 1c37ccd5d402..62b39149b8c8 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -63,3 +63,6 @@ config HAVE_KVM_NO_POLL
 
 config KVM_XFER_TO_GUEST_WORK
        bool
+
+config HAVE_KVM_PM_NOTIFIER
+       bool
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index eb440eb1225a..1cceead1af46 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -51,6 +51,7 @@
 #include <linux/io.h>
 #include <linux/lockdep.h>
 #include <linux/kthread.h>
+#include <linux/suspend.h>
 
 #include <asm/processor.h>
 #include <asm/ioctl.h>
@@ -780,6 +781,38 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
 
 #endif /* CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER */
 
+#ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
+static int kvm_pm_notifier_call(struct notifier_block *bl,
+				unsigned long state,
+				void *unused)
+{
+	struct kvm *kvm = container_of(bl, struct kvm, pm_notifier);
+
+	return kvm_arch_pm_notifier(kvm, state);
+}
+
+static void kvm_init_pm_notifier(struct kvm *kvm)
+{
+	kvm->pm_notifier.notifier_call = kvm_pm_notifier_call;
+	/* Suspend KVM before we suspend ftrace, RCU, etc. */
+	kvm->pm_notifier.priority = INT_MAX;
+	register_pm_notifier(&kvm->pm_notifier);
+}
+
+static void kvm_destroy_pm_notifier(struct kvm *kvm)
+{
+	unregister_pm_notifier(&kvm->pm_notifier);
+}
+#else /* !CONFIG_HAVE_KVM_PM_NOTIFIER */
+static void kvm_init_pm_notifier(struct kvm *kvm)
+{
+}
+
+static void kvm_destroy_pm_notifier(struct kvm *kvm)
+{
+}
+#endif /* CONFIG_HAVE_KVM_PM_NOTIFIER */
+
 static struct kvm_memslots *kvm_alloc_memslots(void)
 {
 	int i;
@@ -963,6 +996,7 @@ static struct kvm *kvm_create_vm(unsigned long type)
 	mutex_unlock(&kvm_lock);
 
 	preempt_notifier_inc();
+	kvm_init_pm_notifier(kvm);
 
 	return kvm;
 
@@ -1010,6 +1044,7 @@ static void kvm_destroy_vm(struct kvm *kvm)
 	int i;
 	struct mm_struct *mm = kvm->mm;
 
+	kvm_destroy_pm_notifier(kvm);
 	kvm_uevent_notify_change(KVM_EVENT_DESTROY_VM, kvm);
 	kvm_destroy_vm_debugfs(kvm);
 	kvm_arch_sync_events(kvm);
-- 
2.32.0.rc1.229.g3e70b5a671-goog

