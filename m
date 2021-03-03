Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460A732D644
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 16:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbhCDPPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 10:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbhCDPOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 10:14:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA771C061756
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 07:14:09 -0800 (PST)
Message-Id: <20210303132711.645314577@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614870848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=P7h+Ao9vOsNudD955CeMK9tU9n4YH9q4LoCgy/oWh2E=;
        b=2uXV0ePRVVVN5aKy2Fo0e96bYkFzUnbSPbDA9mnjFGs+bbvURtfkKgZsQJOXfsFhfOqAx3
        OKSUQ7A2lNXYMCPR5mt7GR8WB0thYvCiB4N4KF25U224lG1bd10Wr84gbQIvOPtxPz3S61
        OTBC7TJIKKNT+7owvCTNX96McxO5XIkAJM607UjWjAXvuDuzKj/vkGN/mMIFPVgKtW7FiY
        sMDkWETXLSLQCzV0BfhUq6uLpZrsKcZbHLAlqzznBehEpom/zQ1YITugOutFHAyMs86+RS
        kQNSvVUTjxm2uWu56Y8iErhFOW+/7R5MUYLuWMVdNNi/wd0eYJsJQIPIhJonBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614870848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=P7h+Ao9vOsNudD955CeMK9tU9n4YH9q4LoCgy/oWh2E=;
        b=yQ29yECbLb01f6/UnQLUET487mIC0cSmmm0evPuZXcme37cSI8DlyGVW46Rppt1VI46dBD
        FPkb1BDl/xOp+sAQ==
Date:   Wed, 03 Mar 2021 14:20:26 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        nouveau@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org
Subject: [patch 3/7] highmem: Remove kmap_atomic_prot()
References: <20210303132023.077167457@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

No more users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 include/linux/highmem-internal.h |   14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -88,16 +88,11 @@ static inline void __kunmap_local(void *
 	kunmap_local_indexed(vaddr);
 }
 
-static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
+static inline void *kmap_atomic(struct page *page)
 {
 	preempt_disable();
 	pagefault_disable();
-	return __kmap_local_page_prot(page, prot);
-}
-
-static inline void *kmap_atomic(struct page *page)
-{
-	return kmap_atomic_prot(page, kmap_prot);
+	return __kmap_local_page_prot(page, kmap_prot);
 }
 
 static inline void *kmap_atomic_pfn(unsigned long pfn)
@@ -184,11 +179,6 @@ static inline void *kmap_atomic(struct p
 	return page_address(page);
 }
 
-static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
-{
-	return kmap_atomic(page);
-}
-
 static inline void *kmap_atomic_pfn(unsigned long pfn)
 {
 	return kmap_atomic(pfn_to_page(pfn));

