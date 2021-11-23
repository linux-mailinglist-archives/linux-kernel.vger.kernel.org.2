Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F018459963
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 01:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbhKWAyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 19:54:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23164 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232569AbhKWAxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 19:53:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637628644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZLx+c2PtpPiU3SXapjfN8tu6CHBo6y1PgJJZl+hqYwU=;
        b=ell4B7BW3AxE4u4g+/E+iuhd2o2nX+HjaIzK0ki3TF3f/puOJpxZtqsaKZr0KzrrZzXoct
        IS7/6k/6rtpKydd6gorIctN9eHQQNcrhMh8vM9b25YtOEQvd4EoxffN85bsm38BOcOwX9a
        NNlS+Yjeis1Ds0JV6Y0LDlNYxsQYnus=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-zkE_Y0paNs-bSMU5MNDJZw-1; Mon, 22 Nov 2021 19:50:43 -0500
X-MC-Unique: zkE_Y0paNs-bSMU5MNDJZw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24C091DDE1;
        Tue, 23 Nov 2021 00:50:42 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA62260C5F;
        Tue, 23 Nov 2021 00:50:41 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     pgonda@google.com
Subject: [PATCH 11/12] KVM: SEV: do not take kvm->lock when destroying
Date:   Mon, 22 Nov 2021 19:50:35 -0500
Message-Id: <20211123005036.2954379-12-pbonzini@redhat.com>
In-Reply-To: <20211123005036.2954379-1-pbonzini@redhat.com>
References: <20211123005036.2954379-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Taking the lock is useless since there are no other references,
and there are already accesses (e.g. to sev->enc_context_owner)
that do not take it.  So get rid of it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 89a716290fac..bbbf980c7e40 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2048,8 +2048,6 @@ void sev_vm_destroy(struct kvm *kvm)
 		return;
 	}
 
-	mutex_lock(&kvm->lock);
-
 	/*
 	 * Ensure that all guest tagged cache entries are flushed before
 	 * releasing the pages back to the system for use. CLFLUSH will
@@ -2069,8 +2067,6 @@ void sev_vm_destroy(struct kvm *kvm)
 		}
 	}
 
-	mutex_unlock(&kvm->lock);
-
 	sev_unbind_asid(kvm, sev->handle);
 	sev_asid_free(sev);
 }
-- 
2.27.0


