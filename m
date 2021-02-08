Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F80313193
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 12:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbhBHL5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 06:57:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51395 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232813AbhBHLgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612784082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bJzjfpKQDXUTrhd/jJ7jwPu/B+J6oLNodRb+ffVR+9o=;
        b=Mh6pPlfHckP9xJNF+pMD6G4o7Vy2esnDPHVOfSC8SKb6RENRo9WQkHMOm/JvL1B8jJ2cxo
        3tlyDKoeiOnX3o4qocYGJZZCt6ZTNkv2nET9+obAX5hw2ddfEZvvfu3admX2mrx1VLIEZD
        UnjECkmJWbde7iGkaasehUdinq9nmEE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-5S6thMDWOIORihOXxYxBhg-1; Mon, 08 Feb 2021 06:34:40 -0500
X-MC-Unique: 5S6thMDWOIORihOXxYxBhg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B54551005501;
        Mon,  8 Feb 2021 11:34:38 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E0A619C71;
        Mon,  8 Feb 2021 11:34:38 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org
Cc:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        intel-gfx@lists.freedesktop.org
Subject: [FYI PATCH] i915: kvmgt: the KVM mmu_lock is now an rwlock
Date:   Mon,  8 Feb 2021 06:34:37 -0500
Message-Id: <20210208113437.94661-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust the KVMGT page tracking callbacks.

Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Cc: intel-gvt-dev@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 drivers/gpu/drm/i915/gvt/kvmgt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index 60f1a386dd06..b4348256ae95 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1703,7 +1703,7 @@ static int kvmgt_page_track_add(unsigned long handle, u64 gfn)
 		return -EINVAL;
 	}
 
-	spin_lock(&kvm->mmu_lock);
+	write_lock(&kvm->mmu_lock);
 
 	if (kvmgt_gfn_is_write_protected(info, gfn))
 		goto out;
@@ -1712,7 +1712,7 @@ static int kvmgt_page_track_add(unsigned long handle, u64 gfn)
 	kvmgt_protect_table_add(info, gfn);
 
 out:
-	spin_unlock(&kvm->mmu_lock);
+	write_unlock(&kvm->mmu_lock);
 	srcu_read_unlock(&kvm->srcu, idx);
 	return 0;
 }
@@ -1737,7 +1737,7 @@ static int kvmgt_page_track_remove(unsigned long handle, u64 gfn)
 		return -EINVAL;
 	}
 
-	spin_lock(&kvm->mmu_lock);
+	write_lock(&kvm->mmu_lock);
 
 	if (!kvmgt_gfn_is_write_protected(info, gfn))
 		goto out;
@@ -1746,7 +1746,7 @@ static int kvmgt_page_track_remove(unsigned long handle, u64 gfn)
 	kvmgt_protect_table_del(info, gfn);
 
 out:
-	spin_unlock(&kvm->mmu_lock);
+	write_unlock(&kvm->mmu_lock);
 	srcu_read_unlock(&kvm->srcu, idx);
 	return 0;
 }
@@ -1772,7 +1772,7 @@ static void kvmgt_page_track_flush_slot(struct kvm *kvm,
 	struct kvmgt_guest_info *info = container_of(node,
 					struct kvmgt_guest_info, track_node);
 
-	spin_lock(&kvm->mmu_lock);
+	write_lock(&kvm->mmu_lock);
 	for (i = 0; i < slot->npages; i++) {
 		gfn = slot->base_gfn + i;
 		if (kvmgt_gfn_is_write_protected(info, gfn)) {
@@ -1781,7 +1781,7 @@ static void kvmgt_page_track_flush_slot(struct kvm *kvm,
 			kvmgt_protect_table_del(info, gfn);
 		}
 	}
-	spin_unlock(&kvm->mmu_lock);
+	write_unlock(&kvm->mmu_lock);
 }
 
 static bool __kvmgt_vgpu_exist(struct intel_vgpu *vgpu, struct kvm *kvm)
-- 
2.26.2

