Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD8B3147E9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 06:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhBIFJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 00:09:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55793 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229895AbhBIFGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 00:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612847094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v6D2GLD5js6g58nNNfu2Yz/oGqZy4P8k9pLRln8bcoU=;
        b=QtNs7vH4hRGUTdLBDqXKQknzy0Vv2x/KZxanGFddYAbLUaxkgeFZAoek26xt/dEeJQlZyB
        4iycZcXyOCXYWkYxYIvmkzYyUIH03v/reqF74zXmUo5JD4odUVS5HSHIiT5KxQQd34PYaE
        PvuWYD6U4XNjqgAiCEpdBfj/JdjdsLA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-juvzsWAeNoa-p2GzonrCeQ-1; Tue, 09 Feb 2021 00:04:50 -0500
X-MC-Unique: juvzsWAeNoa-p2GzonrCeQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1E06192CC40;
        Tue,  9 Feb 2021 05:04:48 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-26.bne.redhat.com [10.64.54.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81E0E5D9C0;
        Tue,  9 Feb 2021 05:04:46 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, pbonzini@redhat.com, maz@kernel.org,
        james.morse@arm.com, Jonathan.Cameron@huawei.com,
        mark.rutland@arm.com, will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v2 08/17] KVM: arm64: Add paravirtualization header files
Date:   Tue,  9 Feb 2021 13:03:54 +0800
Message-Id: <20210209050403.103143-9-gshan@redhat.com>
In-Reply-To: <20210209050403.103143-1-gshan@redhat.com>
References: <20210209050403.103143-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need put more stuff in the paravirtualization header files when
the asynchronous page fault is supported. The generic header files
can't meet the goal. This duplicate the generic header files to be
our platform specific header files. It's the preparatory work to
support the asynchronous page fault in subsequent patches:

   include/uapi/asm-generic/kvm_para.h
   include/asm-generic/kvm_para.h

   arch/arm64/include/uapi/asm/kvm_para.h
   arch/arm64/include/asm/kvm_para.h

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/kvm_para.h      | 27 ++++++++++++++++++++++++++
 arch/arm64/include/uapi/asm/Kbuild     |  2 --
 arch/arm64/include/uapi/asm/kvm_para.h |  5 +++++
 3 files changed, 32 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_para.h
 create mode 100644 arch/arm64/include/uapi/asm/kvm_para.h

diff --git a/arch/arm64/include/asm/kvm_para.h b/arch/arm64/include/asm/kvm_para.h
new file mode 100644
index 000000000000..0ea481dd1c7a
--- /dev/null
+++ b/arch/arm64/include/asm/kvm_para.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_ARM_KVM_PARA_H
+#define _ASM_ARM_KVM_PARA_H
+
+#include <uapi/asm/kvm_para.h>
+
+static inline bool kvm_check_and_clear_guest_paused(void)
+{
+	return false;
+}
+
+static inline unsigned int kvm_arch_para_features(void)
+{
+	return 0;
+}
+
+static inline unsigned int kvm_arch_para_hints(void)
+{
+	return 0;
+}
+
+static inline bool kvm_para_available(void)
+{
+	return false;
+}
+
+#endif /* _ASM_ARM_KVM_PARA_H */
diff --git a/arch/arm64/include/uapi/asm/Kbuild b/arch/arm64/include/uapi/asm/Kbuild
index 602d137932dc..f66554cd5c45 100644
--- a/arch/arm64/include/uapi/asm/Kbuild
+++ b/arch/arm64/include/uapi/asm/Kbuild
@@ -1,3 +1 @@
 # SPDX-License-Identifier: GPL-2.0
-
-generic-y += kvm_para.h
diff --git a/arch/arm64/include/uapi/asm/kvm_para.h b/arch/arm64/include/uapi/asm/kvm_para.h
new file mode 100644
index 000000000000..cd212282b90c
--- /dev/null
+++ b/arch/arm64/include/uapi/asm/kvm_para.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_ASM_ARM_KVM_PARA_H
+#define _UAPI_ASM_ARM_KVM_PARA_H
+
+#endif /* _UAPI_ASM_ARM_KVM_PARA_H */
-- 
2.23.0

