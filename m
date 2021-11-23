Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93803459955
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 01:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbhKWAx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 19:53:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40948 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231950AbhKWAxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 19:53:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637628641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ErWr2xA93BRnrVaO3NOQrylu/I+3f37EMN2aGTybAI=;
        b=OjvWGGVHqlCXLKzEsgtXI0WFkvTvFvchphP7378V7LCRG/fT39JvShrBe+9KGbe6k4GO0V
        6L+q031+QQ7arJRDeddEgTlTJ0M3mIPwcF3LpvZrkdDKGMQdWEuV0s4P5wmSLpDJ3yTJSL
        rYLnEd4T+drqdX6MISNq/43rMeMIOa8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-214-HK_lkh6TMP-CQk4-D7ifTQ-1; Mon, 22 Nov 2021 19:50:40 -0500
X-MC-Unique: HK_lkh6TMP-CQk4-D7ifTQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 781751023F4D;
        Tue, 23 Nov 2021 00:50:39 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 083E95C1C5;
        Tue, 23 Nov 2021 00:50:38 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     pgonda@google.com
Subject: [PATCH 06/12] KVM: SEV: initialize regions_list of a mirror VM
Date:   Mon, 22 Nov 2021 19:50:30 -0500
Message-Id: <20211123005036.2954379-7-pbonzini@redhat.com>
In-Reply-To: <20211123005036.2954379-1-pbonzini@redhat.com>
References: <20211123005036.2954379-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was broken before the introduction of KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM,
but technically harmless because the region list was unused for a mirror
VM.  However, it is untidy and it now causes a NULL pointer access when
attempting to move the encryption context of a mirror VM.

Fixes: 54526d1fd593 ("KVM: x86: Support KVM VMs sharing SEV context")
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 23a4877d7bdf..dc974c1728b6 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2004,6 +2004,7 @@ int svm_vm_copy_asid_from(struct kvm *kvm, unsigned int source_fd)
 	mirror_sev->fd = source_sev.fd;
 	mirror_sev->es_active = source_sev.es_active;
 	mirror_sev->handle = source_sev.handle;
+	INIT_LIST_HEAD(&mirror_sev->regions_list);
 	/*
 	 * Do not copy ap_jump_table. Since the mirror does not share the same
 	 * KVM contexts as the original, and they may have different
-- 
2.27.0


