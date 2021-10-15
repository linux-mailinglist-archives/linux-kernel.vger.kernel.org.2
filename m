Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0CB442F9A6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241955AbhJORHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:07:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41703 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241981AbhJORHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634317510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/ylNS4/x2ePFO7q1tP1Dy6i8S8Qh2yZkvFSuzVQxuoQ=;
        b=asjPv6oDVa/F0MxYKEU8+MV4UpFZZuSp+97xo6dPQxzEvF5fr6XXIJ+XvMQbZcce6qrz/k
        lg1piSCyrLeyR4GsTQCkRjKIej8WommculkQMovn1E/if6eqnehyHVlkgEccaQWo93NX8c
        VJwUnUlW6wpjijISNXUNIUGrVq+fRBc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-GS9HGaIJPiG3dlVAgS_miQ-1; Fri, 15 Oct 2021 13:05:09 -0400
X-MC-Unique: GS9HGaIJPiG3dlVAgS_miQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 306791923763;
        Fri, 15 Oct 2021 17:05:08 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E45F95BAFB;
        Fri, 15 Oct 2021 17:05:07 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH] KVM: X86: fix lazy allocation of rmaps
Date:   Fri, 15 Oct 2021 13:05:07 -0400
Message-Id: <20211015170507.136732-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If allocation of rmaps fails, but some of the pointers have already been written,
those pointers can be cleaned up when the memslot is freed, or even reused later
for another attempt at allocating the rmaps.  Therefore there is no need to
WARN, as done for example in memslot_rmap_alloc, but the allocation *must* be
skipped lest KVM will overwrite the previous pointer and will indeed leak memory.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/x86.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 07f5760ea30c..cba7a99374bc 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11392,7 +11392,8 @@ static int memslot_rmap_alloc(struct kvm_memory_slot *slot,
 		int level = i + 1;
 		int lpages = __kvm_mmu_slot_lpages(slot, npages, level);
 
-		WARN_ON(slot->arch.rmap[i]);
+		if (slot->arch.rmap[i])
+			continue;
 
 		slot->arch.rmap[i] = vcalloc(lpages, sz);
 		if (!slot->arch.rmap[i]) {
-- 
2.27.0

