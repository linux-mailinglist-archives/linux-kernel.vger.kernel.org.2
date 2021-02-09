Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01053147F0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 06:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhBIFLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 00:11:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27066 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229991AbhBIFGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 00:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612847121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iUu+lzwBSV+fLOITGUpcU5W0RbJdTJsAIGp714lX3hQ=;
        b=FVfQaM8O4Kjt7/jPEgETNjEJn3zdRE889NzDVv9QJdSJfJruwy0YgF7eQXVyLvfnxY/KbK
        NgoM8otv7W82suYFeeGJ03mqU7hEhF/2V7XLM8G/7xpT1GFd6zBtwpjK2a7z23Lh6VcOjW
        tesQNjxJaQyz7coxVQ2w/Y6ENIEVmAY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-Dr5KQhgwM0Gwv1MGTmGang-1; Tue, 09 Feb 2021 00:05:17 -0500
X-MC-Unique: Dr5KQhgwM0Gwv1MGTmGang-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C80AB803F48;
        Tue,  9 Feb 2021 05:05:15 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-26.bne.redhat.com [10.64.54.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D11F95D9C0;
        Tue,  9 Feb 2021 05:05:07 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, pbonzini@redhat.com, maz@kernel.org,
        james.morse@arm.com, Jonathan.Cameron@huawei.com,
        mark.rutland@arm.com, will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v2 14/17] arm64: Detect async PF para-virtualization feature
Date:   Tue,  9 Feb 2021 13:04:00 +0800
Message-Id: <20210209050403.103143-15-gshan@redhat.com>
In-Reply-To: <20210209050403.103143-1-gshan@redhat.com>
References: <20210209050403.103143-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implements kvm_para_available() to check if para-virtualization
features are available or not. Besides, kvm_para_has_feature() is
enhanced to detect the asynchronous page fault para-virtualization
feature. These two functions are going to be used by guest kernel
to enable the asynchronous page fault.

This also adds kernel option (CONFIG_KVM_GUEST), which is the umbrella
for the optimizations related to KVM para-virtualization.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/Kconfig                     | 11 +++++++++++
 arch/arm64/include/asm/kvm_para.h      | 12 +++++++++++-
 arch/arm64/include/uapi/asm/kvm_para.h |  2 ++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index f39568b28ec1..792ae09aa690 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1078,6 +1078,17 @@ config PARAVIRT_TIME_ACCOUNTING
 
 	  If in doubt, say N here.
 
+config KVM_GUEST
+	bool "KVM Guest Support"
+	depends on PARAVIRT
+	default y
+	help
+	  This option enables various optimizations for running under the KVM
+	  hypervisor. Overhead for the kernel when not running inside KVM should
+	  be minimal.
+
+	  In case of doubt, say Y
+
 config KEXEC
 	depends on PM_SLEEP_SMP
 	select KEXEC_CORE
diff --git a/arch/arm64/include/asm/kvm_para.h b/arch/arm64/include/asm/kvm_para.h
index 0ea481dd1c7a..8f39c60a6619 100644
--- a/arch/arm64/include/asm/kvm_para.h
+++ b/arch/arm64/include/asm/kvm_para.h
@@ -3,6 +3,8 @@
 #define _ASM_ARM_KVM_PARA_H
 
 #include <uapi/asm/kvm_para.h>
+#include <linux/of.h>
+#include <asm/hypervisor.h>
 
 static inline bool kvm_check_and_clear_guest_paused(void)
 {
@@ -11,7 +13,12 @@ static inline bool kvm_check_and_clear_guest_paused(void)
 
 static inline unsigned int kvm_arch_para_features(void)
 {
-	return 0;
+	unsigned int features = 0;
+
+	if (kvm_arm_hyp_service_available(ARM_SMCCC_KVM_FUNC_ASYNC_PF))
+		features |= (1 << KVM_FEATURE_ASYNC_PF);
+
+	return features;
 }
 
 static inline unsigned int kvm_arch_para_hints(void)
@@ -21,6 +28,9 @@ static inline unsigned int kvm_arch_para_hints(void)
 
 static inline bool kvm_para_available(void)
 {
+	if (IS_ENABLED(CONFIG_KVM_GUEST))
+		return true;
+
 	return false;
 }
 
diff --git a/arch/arm64/include/uapi/asm/kvm_para.h b/arch/arm64/include/uapi/asm/kvm_para.h
index 162325e2638f..70bbc7d1ec75 100644
--- a/arch/arm64/include/uapi/asm/kvm_para.h
+++ b/arch/arm64/include/uapi/asm/kvm_para.h
@@ -4,6 +4,8 @@
 
 #include <linux/types.h>
 
+#define KVM_FEATURE_ASYNC_PF		0
+
 /* Async PF */
 #define KVM_ASYNC_PF_ENABLED		(1 << 0)
 #define KVM_ASYNC_PF_SEND_ALWAYS	(1 << 1)
-- 
2.23.0

