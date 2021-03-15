Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B018033AA5C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 05:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhCOETr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 00:19:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22035 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229607AbhCOETJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 00:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615781948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pu3kXgjRojY47OfIAlD63r8hsjSPAEDkqXq/WsE53ds=;
        b=UAohMhC5tInVDho0Fvn4UPwdJF9Ag0WUgOTcghZDYlPT+3IDr8llJ0G1JegK/y4FrR8VlG
        G2kVMq5pHqo629ggdfY9mFRkR0WsDLVpKxXwCR9Gj438y2Ym2Jpq31CRlSr2WQByW7jUpU
        GGm4LUq+74s0TFV14JjVgDI2O9UdiQ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-6sHIAiESPqStPy2FM__12Q-1; Mon, 15 Mar 2021 00:19:07 -0400
X-MC-Unique: 6sHIAiESPqStPy2FM__12Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D453981746C;
        Mon, 15 Mar 2021 04:19:05 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-175.bne.redhat.com [10.64.54.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 466AD437F;
        Mon, 15 Mar 2021 04:19:03 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, will@kernel.org,
        alexandru.elisei@arm.com, shan.gavin@gmail.com
Subject: [PATCH 3/4] KVM: arm64: Fix address check for memory slot
Date:   Mon, 15 Mar 2021 12:18:43 +0800
Message-Id: <20210315041844.64915-4-gshan@redhat.com>
In-Reply-To: <20210315041844.64915-1-gshan@redhat.com>
References: <20210315041844.64915-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last (IPA) page can't be specified when a new memory slot is
added. The error -EFAULT is returned when the memory slot is added
with the following parameters for the VM, which has 40-bits IPA
limit. The host has 4KB base page size. It's not correct because
the last (IPA) page is still usable.

   struct kvm_userspace_memory_region {
      __u32 slot;               /* 1            */
      __u32 flags;              /* 0            */
      __u64 guest_phys_addr;    /* 0xfffffff000 */
      __u64 memory_size;        /* 0x1000       */
      __u64 userspace_addr;
   };

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 286b603ed0d3..a5a8ade9fde4 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1313,7 +1313,7 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 	 * Prevent userspace from creating a memory region outside of the IPA
 	 * space addressable by the KVM guest IPA space.
 	 */
-	if (memslot->base_gfn + memslot->npages >=
+	if (memslot->base_gfn + memslot->npages >
 	    (kvm_phys_size(kvm) >> PAGE_SHIFT))
 		return -EFAULT;
 
-- 
2.23.0

