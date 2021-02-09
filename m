Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E233147EE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 06:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhBIFLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 00:11:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37394 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229517AbhBIFGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 00:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612847113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lykTvxA53wjtht4Rhfogm7ARHCpnIyEDc9oLghHVR9E=;
        b=LojbDHdwd93jbhPYXmWu3ukpZJnAc3HH/6PsRBdkJhNJS8sTGpK+Xr/NYsWajMoZdCSEhW
        RyOec1RAsw9yfCFIceIr3ISRhERJLP0UuN5ooaEYIxIJm/M0sdkzJ4hfvgp+hFk93W2QgB
        BXOUMDvpnDwv1+5N7zxStF/NkqxGfiE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-xJ1Cy6XOMlW3VF7ygWMSNQ-1; Tue, 09 Feb 2021 00:05:09 -0500
X-MC-Unique: xJ1Cy6XOMlW3VF7ygWMSNQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7043A192CC43;
        Tue,  9 Feb 2021 05:05:07 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-26.bne.redhat.com [10.64.54.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A36B5D9C0;
        Tue,  9 Feb 2021 05:05:02 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, pbonzini@redhat.com, maz@kernel.org,
        james.morse@arm.com, Jonathan.Cameron@huawei.com,
        mark.rutland@arm.com, will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v2 13/17] KVM: arm64: Export async PF capability
Date:   Tue,  9 Feb 2021 13:03:59 +0800
Message-Id: <20210209050403.103143-14-gshan@redhat.com>
In-Reply-To: <20210209050403.103143-1-gshan@redhat.com>
References: <20210209050403.103143-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This exports the asynchronous page fault capability:

    * Identify capability KVM_CAP_ASYNC_{PF, PF_INT}.

    * Standardize SDEI event for asynchronous page fault.

    * Enable kernel config CONFIG_KVM_ASYNC_{PF, PF_SLOT}.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/uapi/asm/kvm_sdei.h | 1 +
 arch/arm64/kvm/Kconfig                 | 2 ++
 arch/arm64/kvm/arm.c                   | 4 ++++
 arch/arm64/kvm/sdei.c                  | 5 +++++
 4 files changed, 12 insertions(+)

diff --git a/arch/arm64/include/uapi/asm/kvm_sdei.h b/arch/arm64/include/uapi/asm/kvm_sdei.h
index 232092de5e21..47d578abba1a 100644
--- a/arch/arm64/include/uapi/asm/kvm_sdei.h
+++ b/arch/arm64/include/uapi/asm/kvm_sdei.h
@@ -13,6 +13,7 @@
 #define KVM_SDEI_MAX_VCPUS     512
 #define KVM_SDEI_INVALID_NUM   0
 #define KVM_SDEI_DEFAULT_NUM   0x40400000
+#define KVM_SDEI_ASYNC_PF_NUM  0x40400001
 
 struct kvm_sdei_event_state {
 	uint64_t	num;
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 3964acf5451e..dfb3ed0de2ca 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -31,6 +31,8 @@ menuconfig KVM
 	select SRCU
 	select KVM_VFIO
 	select HAVE_KVM_EVENTFD
+	select KVM_ASYNC_PF
+	select KVM_ASYNC_PF_SLOT
 	select HAVE_KVM_IRQFD
 	select HAVE_KVM_MSI
 	select HAVE_KVM_IRQCHIP
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index be0e6c2db2a5..0940de3ebcff 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -269,6 +269,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_ARM_SDEI:
 		r = 1;
 		break;
+	case KVM_CAP_ASYNC_PF:
+	case KVM_CAP_ASYNC_PF_INT:
+		r = IS_ENABLED(CONFIG_KVM_ASYNC_PF) ? 1 : 0;
+		break;
 	default:
 		r = 0;
 	}
diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index 4f5a582daa97..437303bfafba 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -19,6 +19,11 @@ static struct kvm_sdei_event_state defined_kse[] = {
 	  1,
 	  SDEI_EVENT_PRIORITY_CRITICAL
 	},
+	{ KVM_SDEI_ASYNC_PF_NUM,
+	  SDEI_EVENT_TYPE_PRIVATE,
+	  1,
+	  SDEI_EVENT_PRIORITY_CRITICAL
+	},
 };
 
 static struct kvm_sdei_event *kvm_sdei_find_event(struct kvm *kvm,
-- 
2.23.0

