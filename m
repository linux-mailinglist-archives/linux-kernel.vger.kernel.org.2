Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2CC93EC648
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 02:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbhHOARY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 20:17:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36746 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235663AbhHOAQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 20:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628986555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a4w2TmXf5rRgyDhpcntujf3KVtZFjumH6f0ydBAsOZs=;
        b=Xr1XObyT/fSmsmumwQHllWPiMMW8hTjpkeffhF9X1wYmhbH/MDnJ6p5AYe9yrzHt2J3cvb
        K4H1jYZP5bzBAetBT2BdXLHBc9dn2xlNUOmxVFv5t2r4/4ih8/ZbdW6dIX3zHqvrbBipvy
        pwIe6M2+SwPaQ+xW8iP4tXAUw2kFAOY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-l-MAQvVBNPW_trZYBJAZ2Q-1; Sat, 14 Aug 2021 20:15:54 -0400
X-MC-Unique: l-MAQvVBNPW_trZYBJAZ2Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B51751008061;
        Sun, 15 Aug 2021 00:15:52 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-103.bne.redhat.com [10.64.54.103])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 14DAD10016FF;
        Sun, 15 Aug 2021 00:15:47 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, james.morse@arm.com,
        mark.rutland@arm.com, Jonathan.Cameron@huawei.com, will@kernel.org,
        maz@kernel.org, pbonzini@redhat.com
Subject: [PATCH v4 20/21] KVM: arm64: Export SDEI capability
Date:   Sun, 15 Aug 2021 08:13:51 +0800
Message-Id: <20210815001352.81927-21-gshan@redhat.com>
In-Reply-To: <20210815001352.81927-1-gshan@redhat.com>
References: <20210815001352.81927-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SDEI functionality is ready to be exported so far. This adds
new capability (KVM_CAP_ARM_SDEI) and exports it.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/arm.c     | 3 +++
 include/uapi/linux/kvm.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 215cdbeb272a..7d9bbc888ae5 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -278,6 +278,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_ARM_PTRAUTH_GENERIC:
 		r = system_has_full_ptr_auth();
 		break;
+	case KVM_CAP_ARM_SDEI:
+		r = 1;
+		break;
 	default:
 		r = 0;
 	}
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 8cf41fd4bf86..2aa748fd89c7 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1112,6 +1112,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_BINARY_STATS_FD 203
 #define KVM_CAP_EXIT_ON_EMULATION_FAILURE 204
 #define KVM_CAP_ARM_MTE 205
+#define KVM_CAP_ARM_SDEI 206
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.23.0

