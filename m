Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52A23E5777
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 11:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239308AbhHJJuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 05:50:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55474 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239310AbhHJJtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 05:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628588930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=59kuAZem85KPEOYWVkAOsAR4DDZk1OeL3s1/rT3mByM=;
        b=ZZHNb6Ij3Duc7VyXBGF+Z56HqmJwUp8+aYDrN3qpKliaiM/J27KVnbvL0HLTkDnZVkwy+L
        HXIrAAr+8AC4rc/DzsyWVEFFTI8YqUQwD4QM8+qC627zTHdO7sYqbQslnB2yeIeQpSHEUH
        GNDHSsSsEAk63tuERSG8Abnf6PGJJWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-qAtR2cvPMSGga2PEXQO7nw-1; Tue, 10 Aug 2021 05:48:46 -0400
X-MC-Unique: qAtR2cvPMSGga2PEXQO7nw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BAB24875049;
        Tue, 10 Aug 2021 09:48:44 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-79.pek2.redhat.com [10.72.12.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7396410013C1;
        Tue, 10 Aug 2021 09:48:39 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de,
        robin.murphy@arm.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
        m.szyprowski@samsung.com, rppt@linux.ibm.com,
        Baoquan He <bhe@redhat.com>
Subject: [RFC PATCH v2 0/5] Avoid requesting page from DMA zone when no managed pages
Date:   Tue, 10 Aug 2021 17:48:30 +0800
Message-Id: <20210810094835.13402-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some places of the current kernel, it assumes that DMA zone must have
managed pages and try to request pages if CONFIG_ZONE_DMA is enabled.
While this is not always true. E.g in kdump kernel of x86_64, only low 1M
is presented and locked down at very early stage of boot, so that there's
no managed pages at all in DMA zone. This exception will always cause page
allocation failure if page is requested from DMA zone.

E.g in kdump kernel of x86_64, atomic_pool_dma which is created with GFP_DMA
will cause page allocation failure, and dma-kmalloc initialization also
caused page allocation failure.

In this v2 patchset:

* Patch 1, 2 are clean up patches of atomic pool code when read code.
* Patch 3 introduces helper functions to help check if DMA zone with managed
  pages exists.
* Patch 4 is to check if managed DMA zone exists, then create atomic_pool_dma
  if yes.
* Patch 5 is to check if managed DMA zone exists, then create
* dma-kmalloc cache if yes.

This is v1 post:
https://lore.kernel.org/lkml/20210624052010.5676-1-bhe@redhat.com/

v1->v2:
 In v1, I tried to adjust code to allow user to disable atomic pool
 completely with "coherent_pool=0" kernek parameter, then expect to add
 this into kdump kernel to mute the page allocation failure. However,
 later found atomic pool is needed when DMA_DIRECT_REMAP=y or
 mem_encrypt_active() is true, and dma-kmalloc also always caused page
 allocation failure. 
 
 So in this v2, change to check if managed DMA zone exists. If DMA zone
 has managed pages, we go further to request page from DMA zone to
 initialize. Otherwise, just skip to initialize stuffs which need pages
 from DMA zone.

Baoquan He (5):
  docs: kernel-parameters: Update to reflect the current default size of
    atomic pool
  dma-pool: allow user to disable atomic pool
  mm_zone: add function to check if managed dma zone exists
  dma/pool: create dma atomic pool only if dma zone has mamaged pages
  mm/slub: do not create dma-kmalloc if no managed pages in DMA zone

 .../admin-guide/kernel-parameters.txt         |  5 ++++-
 include/linux/mmzone.h                        | 21 +++++++++++++++++++
 kernel/dma/pool.c                             | 11 ++++++----
 mm/page_alloc.c                               | 11 ++++++++++
 mm/slab_common.c                              |  6 ++++++
 5 files changed, 49 insertions(+), 5 deletions(-)

-- 
2.17.2

