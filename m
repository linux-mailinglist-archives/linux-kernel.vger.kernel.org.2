Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EDA45995B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 01:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbhKWAyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 19:54:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53847 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232114AbhKWAxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 19:53:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637628642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VWwD6Uf/5FSnYox5qmCe+VNqcN1QdoA7hD2pKantygc=;
        b=A/ASrTcusQKdFtc88G2gX6xr5RBWF84L03HGj5biZkbkZZGVZ6WBU3f91csKWDA6kJMrSV
        a41WtkznRwskI360XQTDkSDPaz/PUnKbnqI68WDq/Y77LYJteBj8MBftPsSa/EPATnGJk9
        Ysn8xIpUl5+KsuZ8u7LShjfOB/QbSGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-84RfZUrrPQ-03cCvyXoawQ-1; Mon, 22 Nov 2021 19:50:39 -0500
X-MC-Unique: 84RfZUrrPQ-03cCvyXoawQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01E80802B52;
        Tue, 23 Nov 2021 00:50:38 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A72625FC25;
        Tue, 23 Nov 2021 00:50:37 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     pgonda@google.com
Subject: [PATCH 03/12] KVM: SEV: expose KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM capability
Date:   Mon, 22 Nov 2021 19:50:27 -0500
Message-Id: <20211123005036.2954379-4-pbonzini@redhat.com>
In-Reply-To: <20211123005036.2954379-1-pbonzini@redhat.com>
References: <20211123005036.2954379-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The capability, albeit present, was never exposed via KVM_CHECK_EXTENSION.

Fixes: b56639318bb2 ("KVM: SEV: Add support for SEV intra host migration")
Cc: Peter Gonda <pgonda@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/x86.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a8f12c83db4b..7b7b56c89bd8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4133,6 +4133,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_SGX_ATTRIBUTE:
 #endif
 	case KVM_CAP_VM_COPY_ENC_CONTEXT_FROM:
+	case KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM:
 	case KVM_CAP_SREGS2:
 	case KVM_CAP_EXIT_ON_EMULATION_FAILURE:
 	case KVM_CAP_VCPU_ATTRIBUTES:
-- 
2.27.0


