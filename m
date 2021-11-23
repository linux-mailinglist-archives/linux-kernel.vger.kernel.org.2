Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07272459966
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 01:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbhKWAyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 19:54:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57757 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232597AbhKWAxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 19:53:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637628644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nu+6S5YnfxWC0/SRUjRUVc13IurCt0G9rMWN4/Et7NY=;
        b=H+cPb1YhRnyRNpMDd2JkEZU0gsnbsTonb5aZuyBiJ6BK6ii/NZ/9PpkyNmypSVplO8fJ9r
        dws3ookQRud9guw799s0T/zaWqUqYtMro8sGK77DqEHdNJ61qA/Snp0IQPPcH4toG6ZkqV
        I+bs/WRHVR2mptqwjWkrtdrH6lMi658=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-506-dxm3XyURPRibvZF_EtCEqg-1; Mon, 22 Nov 2021 19:50:43 -0500
X-MC-Unique: dxm3XyURPRibvZF_EtCEqg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D2651DDF2;
        Tue, 23 Nov 2021 00:50:42 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3EAC460C13;
        Tue, 23 Nov 2021 00:50:42 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     pgonda@google.com
Subject: [PATCH 12/12] KVM: SEV: accept signals in sev_lock_two_vms
Date:   Mon, 22 Nov 2021 19:50:36 -0500
Message-Id: <20211123005036.2954379-13-pbonzini@redhat.com>
In-Reply-To: <20211123005036.2954379-1-pbonzini@redhat.com>
References: <20211123005036.2954379-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generally, kvm->lock is not taken for a long time, but
sev_lock_two_vms is different: it takes vCPU locks
inside, so userspace can hold it back just by calling
a vCPU ioctl.  Play it safe and use mutex_lock_killable.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index bbbf980c7e40..59727a966f90 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1547,6 +1547,7 @@ static int sev_lock_two_vms(struct kvm *dst_kvm, struct kvm *src_kvm)
 {
 	struct kvm_sev_info *dst_sev = &to_kvm_svm(dst_kvm)->sev_info;
 	struct kvm_sev_info *src_sev = &to_kvm_svm(src_kvm)->sev_info;
+	int r = -EBUSY;
 
 	if (dst_kvm == src_kvm)
 		return -EINVAL;
@@ -1558,14 +1559,23 @@ static int sev_lock_two_vms(struct kvm *dst_kvm, struct kvm *src_kvm)
 	if (atomic_cmpxchg_acquire(&dst_sev->migration_in_progress, 0, 1))
 		return -EBUSY;
 
-	if (atomic_cmpxchg_acquire(&src_sev->migration_in_progress, 0, 1)) {
-		atomic_set_release(&dst_sev->migration_in_progress, 0);
-		return -EBUSY;
-	}
+	if (atomic_cmpxchg_acquire(&src_sev->migration_in_progress, 0, 1))
+		goto release_dst;
 
-	mutex_lock(&dst_kvm->lock);
-	mutex_lock(&src_kvm->lock);
+	r = -EINTR;
+	if (mutex_lock_killable(&dst_kvm->lock))
+		goto release_src;
+	if (mutex_lock_killable(&src_kvm->lock))
+		goto unlock_dst;
 	return 0;
+
+unlock_dst:
+	mutex_unlock(&dst_kvm->lock);
+release_src:
+	atomic_set_release(&src_sev->migration_in_progress, 0);
+release_dst:
+	atomic_set_release(&dst_sev->migration_in_progress, 0);
+	return r;
 }
 
 static void sev_unlock_two_vms(struct kvm *dst_kvm, struct kvm *src_kvm)
-- 
2.27.0

