Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B66E3B356D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 20:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhFXSQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 14:16:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47122 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232598AbhFXSQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 14:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624558445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a/z5ekGyyTIFDc5iC+PDsxm8TweH5l/mhGx4xsPY5QA=;
        b=M4aNqQQiG7IscWvEbYGrkx/xRu1n8acPuYb5d0Gfq/Z6x9qk5TINMWMa1qVLOptGIS8AGY
        PstLq3Tuu5rHsgtb6qxMhAdZgPn/jKOmZEWtKmozEGjixNWC95FAnisg/WI4Guqg7KXtk+
        6ZHtf6dHPn/0KlcS4a1fagVZoJIOQtg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-9C3_uY_hOiul2EJOgottqg-1; Thu, 24 Jun 2021 14:14:02 -0400
X-MC-Unique: 9C3_uY_hOiul2EJOgottqg-1
Received: by mail-qv1-f72.google.com with SMTP id q10-20020a056214018ab029027751ec9742so7910519qvr.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 11:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a/z5ekGyyTIFDc5iC+PDsxm8TweH5l/mhGx4xsPY5QA=;
        b=VLhbASZqRudTC8c9KIdRNdLKd2VvSoevf4tb96Wgt3bG8JSXhLDyil0zMs6QZIpJqe
         q2t0wA2hCMelW+n5vtiplIy5wH7bKhZC3DQO9tRuonioorWuQopQdvjinhE+LSgUB8QU
         ssaWUH24+dvEmvXomVy5lkevMHsUKoSNnZCLIIzp9enDY947OCufEP5fPEgkPIB/e/p5
         2xG7zxZ52DO3CLJB0e3nAOS4VuT03bNnnQulgAV3bKxpm6tueC2eTbVRhr/xGsMkfmV8
         mhYm5E8ZsTCVPnwXAm8+uadUgWKlezG1yMGAmIwR0d1+e1zOquAQea0IvY1c3ZHS4PQ4
         PA0g==
X-Gm-Message-State: AOAM531On7cwfX9+Vx/bXcNJGW9xNhMadttDm864w3WkzWTuUbX58OR2
        LKiughCwxOcNLJT3iarPon2R8ESijLrHnc/eJh8bWerNNEbZ8Z2JYEI2PdbeE506LsnllktcEkd
        cJp9gF/vPtMuDalB9PH3Lrwj+
X-Received: by 2002:a37:9d90:: with SMTP id g138mr3201324qke.212.1624558441904;
        Thu, 24 Jun 2021 11:14:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw81+DaAwL/DpqMKlW8EsBoQO4jQNMsJoAjiZVBV2+Lx9VL6USjuQp2YkIyZMNrp4T6w5dGMg==
X-Received: by 2002:a37:9d90:: with SMTP id g138mr3201313qke.212.1624558441718;
        Thu, 24 Jun 2021 11:14:01 -0700 (PDT)
Received: from t490s.redhat.com (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id b7sm2529301qti.21.2021.06.24.11.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 11:14:01 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>, peterx@redhat.com,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH 2/9] KVM: Introduce kvm_get_kvm_safe()
Date:   Thu, 24 Jun 2021 14:13:49 -0400
Message-Id: <20210624181356.10235-3-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210624181356.10235-1-peterx@redhat.com>
References: <20210624181356.10235-1-peterx@redhat.com>
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
index 2f34487e21f2..53d7d09eebd7 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -698,6 +698,7 @@ int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
 void kvm_exit(void);
 
 void kvm_get_kvm(struct kvm *kvm);
+bool kvm_get_kvm_safe(struct kvm *kvm);
 void kvm_put_kvm(struct kvm *kvm);
 bool file_is_kvm(struct file *file);
 void kvm_put_kvm_no_destroy(struct kvm *kvm);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d170f65e15b0..0b4f55370b18 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1049,6 +1049,16 @@ void kvm_get_kvm(struct kvm *kvm)
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
@@ -4713,12 +4723,7 @@ static int kvm_debugfs_open(struct inode *inode, struct file *file,
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

