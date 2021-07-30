Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3093DC0BB
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 00:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbhG3WFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 18:05:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38408 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232729AbhG3WFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 18:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627682700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j/8ZgOgV9FABxcwPWKwd6pFZTEbb8PsS8jPvc0Wk6tg=;
        b=LlFe0ChDknfhEcDQ+9Q8UD5LgQO2g28Ioda+hPhgOeXMrj7xT8E8e5OuArIBEi8RsYUVEb
        NAvkPq70OatTgFRXoxFYMKTugJ+hgAuLW8NeLVtNHc873em2vqg/WosyAQHyuKIS4vezKN
        IRvlCf2TOriQFOspxBvdbPep59Id/lQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-Xyh58tGpMTKUaYgU8Lp-Sg-1; Fri, 30 Jul 2021 18:04:59 -0400
X-MC-Unique: Xyh58tGpMTKUaYgU8Lp-Sg-1
Received: by mail-qv1-f69.google.com with SMTP id b6-20020a0cbf460000b02902dbb4e0a8f2so6885717qvj.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 15:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j/8ZgOgV9FABxcwPWKwd6pFZTEbb8PsS8jPvc0Wk6tg=;
        b=LKy4V783n1SM6zPyyZFtXZilBf2iAV+DL8JeDJh+qfm+JN7/NeMPLyhBypW7170REc
         NanPB5RONQheV3YgvDihEEtAKwp1KwUKGDbYAa3dNIFSaq92cawQ8DVI59BWKtUTKjCt
         QC7wHmUZmHuwqcoN8qIDd/YB1TCHCOCD2T2EEm4DvhTH/Q2cPA2JV3BLP3EH6IpAYU3i
         Dxr5xsvPejJjarGphyFfzxfX9fVw6mKwFnDB7ESAp1jdEORLgDHu4nrzD44qqAVl0+fC
         eaiaOUaSA+XrPs1PWQw+2z5wfj4dl4c6T1cM96DXEvHpmGKchiJWs4K6LYAn8rVe/UMj
         YVsw==
X-Gm-Message-State: AOAM5333+DlrdIs1tuAPC6pLeeBcyRBxQXaZO7tQVvdMCk08lZ0FkArq
        UzZ0cq9ARvl05v/8beyECEvi4TSoB9H8EiYKUjJGYW6IAIPxPo3zKX9FRHRAjXKAIfPpObbJPsA
        Ct9JUaV/ZBR6DH66nPRVOC8Y/
X-Received: by 2002:a05:6214:d6e:: with SMTP id 14mr5095098qvs.53.1627682698948;
        Fri, 30 Jul 2021 15:04:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMTQNHX7PoV1dhRPzDF85NElhalv3f5AD26oUEYimWzW4mHcCPuq4K8RhKwVszC874lpIkBw==
X-Received: by 2002:a05:6214:d6e:: with SMTP id 14mr5095079qvs.53.1627682698761;
        Fri, 30 Jul 2021 15:04:58 -0700 (PDT)
Received: from t490s.. (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id l12sm1199651qtx.45.2021.07.30.15.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 15:04:58 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>, peterx@redhat.com,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 1/7] KVM: Allow to have arch-specific per-vm debugfs files
Date:   Fri, 30 Jul 2021 18:04:49 -0400
Message-Id: <20210730220455.26054-2-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210730220455.26054-1-peterx@redhat.com>
References: <20210730220455.26054-1-peterx@redhat.com>
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
 virt/kvm/kvm_main.c      | 20 +++++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9d6b4ad407b8..a3ec3271c4c8 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1067,6 +1067,7 @@ bool kvm_arch_dy_runnable(struct kvm_vcpu *vcpu);
 bool kvm_arch_dy_has_pending_interrupt(struct kvm_vcpu *vcpu);
 int kvm_arch_post_init_vm(struct kvm *kvm);
 void kvm_arch_pre_destroy_vm(struct kvm *kvm);
+int kvm_arch_create_vm_debugfs(struct kvm *kvm);
 
 #ifndef __KVM_HAVE_ARCH_VM_ALLOC
 /*
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index a96cbe24c688..327f8fae80a5 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -915,7 +915,7 @@ static int kvm_create_vm_debugfs(struct kvm *kvm, int fd)
 	char dir_name[ITOA_MAX_LEN * 2];
 	struct kvm_stat_data *stat_data;
 	const struct _kvm_stats_desc *pdesc;
-	int i;
+	int i, ret;
 	int kvm_debugfs_num_entries = kvm_vm_stats_header.num_desc +
 				      kvm_vcpu_stats_header.num_desc;
 
@@ -960,6 +960,13 @@ static int kvm_create_vm_debugfs(struct kvm *kvm, int fd)
 				    kvm->debugfs_dentry, stat_data,
 				    &stat_fops_per_vm);
 	}
+
+	ret = kvm_arch_create_vm_debugfs(kvm);
+	if (ret) {
+		kvm_destroy_vm_debugfs(kvm);
+		return i;
+	}
+
 	return 0;
 }
 
@@ -980,6 +987,17 @@ void __weak kvm_arch_pre_destroy_vm(struct kvm *kvm)
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

