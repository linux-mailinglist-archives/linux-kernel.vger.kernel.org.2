Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F5D3B46A6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 17:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhFYPeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 11:34:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37576 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229959AbhFYPen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 11:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624635142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tm+fvqcK0gMUF4HiB0nRTnFiIWjA8jvrus1t7f0ofxA=;
        b=XMv4slkdysVkdpBngxodZb2/88tqa+YRdPhOgNwY8ukYiEhvtx87m2XYVUvgchbcDR1HmV
        K8smNx5+vl0D2+n3WNO4r/zHrFQWLRaQYZ2MrzxgbPQWeQcXh4c1Ypwfv02m+ZwcHK9NGl
        y7j2zavdonEXDvGcCyFSZSrxS76XdK0=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-eepHLwg1OMioJrVJtgXJAA-1; Fri, 25 Jun 2021 11:32:21 -0400
X-MC-Unique: eepHLwg1OMioJrVJtgXJAA-1
Received: by mail-il1-f198.google.com with SMTP id d17-20020a9236110000b02901cf25fcfdcdso6397625ila.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 08:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tm+fvqcK0gMUF4HiB0nRTnFiIWjA8jvrus1t7f0ofxA=;
        b=Srq33lttt4X0w1LqQIB7pwIAMOYOFced3T9yvaI7Mu3iiUCDLOKAKzRm+4xA6W0UQ5
         0E4bFwinExJFjwiRHws4WOaPBLBp4TsxT2jZFRnpdN7rbAHAbwH0fuFMKhRWpkKkrBJg
         Rsz/N/TiegOubKWxhdavxDFT+vpapV75HNi62Do4sn395V9Ue7ZKS+jW13fgBCEpago+
         ED0mjNZ5G+ev/d+6zZK7N7RIIFx49FjrWRWyWMPIHgOmd/PTjSRHifGMqjBv8ivZfGJh
         kfVAta/xbSu+KJHfR6DOEWLoyz+TQdSflPyLnOMfFG9TJzDuBJpkMFaRzZp2k7s+p/pS
         kJsw==
X-Gm-Message-State: AOAM531jFUgmnzndpzY3JepSMPJ3wfyYXstLFO2c4XKpsMM6MnfpI3Hz
        F8NjgjyzSW/ngZcYGiMiWxKR+utvn5SV2h1pC5nE/QjTCP6iBgYpMHrhT+w0i5VqqV+LnoQybr7
        mTUunmt/1pH70PjxZ2dQwWhZ0LJ8Cviwu0jRRZOVgqsvH3QDMVOjyT2Vn+F18dx1PiMbMQIUrCg
        ==
X-Received: by 2002:a02:942e:: with SMTP id a43mr10393271jai.74.1624635140354;
        Fri, 25 Jun 2021 08:32:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoOys8GtsgCTOdC7HU1OSYsX1Y5M+rHwqiqWpxEhcIMrFYq9NjwR0UauN7xWhdPtQoSa3ovg==
X-Received: by 2002:a02:942e:: with SMTP id a43mr10393241jai.74.1624635140109;
        Fri, 25 Jun 2021 08:32:20 -0700 (PDT)
Received: from t490s.redhat.com (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id s8sm3668772ilj.51.2021.06.25.08.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 08:32:19 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, peterx@redhat.com,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH v2 2/9] KVM: Introduce kvm_get_kvm_safe()
Date:   Fri, 25 Jun 2021 11:32:07 -0400
Message-Id: <20210625153214.43106-3-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625153214.43106-1-peterx@redhat.com>
References: <20210625153214.43106-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce this safe version of kvm_get_kvm() so that it can be called even
during vm destruction.  Use it in kvm_debugfs_open() and remove the verbose
comment.  Prepare to be used elsewhere.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/kvm_host.h |  1 +
 virt/kvm/kvm_main.c      | 17 +++++++++++------
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ae7735b490b4..c6fcd75dd8b9 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -720,6 +720,7 @@ int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
 void kvm_exit(void);
 
 void kvm_get_kvm(struct kvm *kvm);
+bool kvm_get_kvm_safe(struct kvm *kvm);
 void kvm_put_kvm(struct kvm *kvm);
 bool file_is_kvm(struct file *file);
 void kvm_put_kvm_no_destroy(struct kvm *kvm);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 3dcc2abbfc60..79b0c1b7b284 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1120,6 +1120,16 @@ void kvm_get_kvm(struct kvm *kvm)
 }
 EXPORT_SYMBOL_GPL(kvm_get_kvm);
 
+/*
+ * Make sure the vm is not during destruction, which is a safe version of
+ * kvm_get_kvm().  Return true if kvm referenced successfully, false otherwise.
+ */
+bool kvm_get_kvm_safe(struct kvm *kvm)
+{
+	return refcount_inc_not_zero(&kvm->users_count);
+}
+EXPORT_SYMBOL_GPL(kvm_get_kvm_safe);
+
 void kvm_put_kvm(struct kvm *kvm)
 {
 	if (refcount_dec_and_test(&kvm->users_count))
@@ -4925,12 +4935,7 @@ static int kvm_debugfs_open(struct inode *inode, struct file *file,
 	struct kvm_stat_data *stat_data = (struct kvm_stat_data *)
 					  inode->i_private;
 
-	/* The debugfs files are a reference to the kvm struct which
-	 * is still valid when kvm_destroy_vm is called.
-	 * To avoid the race between open and the removal of the debugfs
-	 * directory we test against the users count.
-	 */
-	if (!refcount_inc_not_zero(&stat_data->kvm->users_count))
+	if (!kvm_get_kvm_safe(stat_data->kvm))
 		return -ENOENT;
 
 	if (simple_attr_open(inode, file, get,
-- 
2.31.1

