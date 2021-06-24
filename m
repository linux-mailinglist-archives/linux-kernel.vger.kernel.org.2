Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD26C3B356B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 20:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbhFXSQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 14:16:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20877 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232560AbhFXSQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 14:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624558445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Nog/14DIgnUZ4IUiuS7R5o+tAccEjG5oUAeY24gLNU=;
        b=cfeWZYQeGbZOc9HD6XL336UVT7xuTVQgmZHe6nHVGGtl0vt2qC4MZAAZCIN28mI6cH9OsN
        zJQRUwKmurz3jVWfDOevmsR2n4jWw4Dz8mj8csCmwMXGAu0vWKTYOOIfY9xXwaBLoN8n2G
        fsN8p+4WC0W/KWto5q72vRXILfIYWBk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-ODUR3fdvNl6h0a7AGNNB8g-1; Thu, 24 Jun 2021 14:14:04 -0400
X-MC-Unique: ODUR3fdvNl6h0a7AGNNB8g-1
Received: by mail-qk1-f198.google.com with SMTP id y5-20020a37af050000b02903a9c3f8b89fso7932923qke.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 11:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Nog/14DIgnUZ4IUiuS7R5o+tAccEjG5oUAeY24gLNU=;
        b=PRBi1TnOJfpBLL9Uo7BwOEHzVo4cWNbcAkRcUUentTmbKTjK5Y0pE5DKaYiprfNDN7
         1n5Pts7NL2VvJE8UXygw+ubuLQ1i1dEKpu+siXk/H7ltpoUoRg/zfp+XAQjwdpR5W7Pw
         F+t9KcPloMgWu2gujY6ioPiGd6rzA+pPSwJsNyOvT8WEP2+p/VhY20szLnM1RG//3a/2
         5V9m12dqSw6wT+QMKBXbpNniWHNus0xGQfTJKgRuMaG/325QgTGF7jryW6EXs2l7nD8O
         6zT2/qKzO+uocGgeTocXydLI+Uipbg1EYkjfzUhKKcbZArrBJe6+Foyj7ZiX3ZzdPytk
         rvSA==
X-Gm-Message-State: AOAM530O1yEPGkaHy3XGPYag2hodt4VoaPL2a22B2r1dUNx7+gYUj6tT
        L0NYUU0S8Klttn8Ol8o6qpDLjNo0SKvPEEpyT9nvekCQ0wmnzB7/kYUTpy4E+OhAEZW6JM0aGSa
        7hJcKCpALC2AeHZzrR9ZZmiXv
X-Received: by 2002:ac8:5784:: with SMTP id v4mr1635150qta.29.1624558443555;
        Thu, 24 Jun 2021 11:14:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYmWyDHbFW8nYB7xKKg3q0sHZXRjTyTswPy+lanRmvJq7eYT+PD7e4EYtu6p98y3KOK2o0GA==
X-Received: by 2002:ac8:5784:: with SMTP id v4mr1635136qta.29.1624558443350;
        Thu, 24 Jun 2021 11:14:03 -0700 (PDT)
Received: from t490s.redhat.com (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id b7sm2529301qti.21.2021.06.24.11.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 11:14:02 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>, peterx@redhat.com,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH 3/9] KVM: Allow to have arch-specific per-vm debugfs files
Date:   Thu, 24 Jun 2021 14:13:50 -0400
Message-Id: <20210624181356.10235-4-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210624181356.10235-1-peterx@redhat.com>
References: <20210624181356.10235-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow archs to create arch-specific nodes under kvm->debugfs_dentry directory
besides the stats fields.  The new interface kvm_arch_create_vm_debugfs() is
defined but not yet used.  It's called after kvm->debugfs_dentry is created, so
it can be referenced directly in kvm_arch_create_vm_debugfs().  Arch should
define their own versions when they want to create extra debugfs nodes.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/kvm_host.h |  1 +
 virt/kvm/kvm_main.c      | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 53d7d09eebd7..480baa55d93f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1009,6 +1009,7 @@ bool kvm_arch_dy_runnable(struct kvm_vcpu *vcpu);
 bool kvm_arch_dy_has_pending_interrupt(struct kvm_vcpu *vcpu);
 int kvm_arch_post_init_vm(struct kvm *kvm);
 void kvm_arch_pre_destroy_vm(struct kvm *kvm);
+int kvm_arch_create_vm_debugfs(struct kvm *kvm);
 
 #ifndef __KVM_HAVE_ARCH_VM_ALLOC
 /*
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 0b4f55370b18..6648743f4dcf 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -847,6 +847,7 @@ static int kvm_create_vm_debugfs(struct kvm *kvm, int fd)
 	char dir_name[ITOA_MAX_LEN * 2];
 	struct kvm_stat_data *stat_data;
 	struct kvm_stats_debugfs_item *p;
+	int ret;
 
 	if (!debugfs_initialized())
 		return 0;
@@ -872,6 +873,13 @@ static int kvm_create_vm_debugfs(struct kvm *kvm, int fd)
 				    kvm->debugfs_dentry, stat_data,
 				    &stat_fops_per_vm);
 	}
+
+	ret = kvm_arch_create_vm_debugfs(kvm);
+	if (ret) {
+		kvm_destroy_vm_debugfs(kvm);
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -892,6 +900,17 @@ void __weak kvm_arch_pre_destroy_vm(struct kvm *kvm)
 {
 }
 
+/*
+ * Called after per-vm debugfs created.  When called kvm->debugfs_dentry should
+ * be setup already, so we can create arch-specific debugfs entries under it.
+ * Cleanup should be automatic done in kvm_destroy_vm_debugfs() recursively, so
+ * a per-arch destroy interface is not needed.
+ */
+int __weak kvm_arch_create_vm_debugfs(struct kvm *kvm)
+{
+	return 0;
+}
+
 static struct kvm *kvm_create_vm(unsigned long type)
 {
 	struct kvm *kvm = kvm_arch_alloc_vm();
-- 
2.31.1

