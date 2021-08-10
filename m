Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCF33E5779
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 11:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239453AbhHJJuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 05:50:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36786 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239313AbhHJJtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 05:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628588932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=gxvJrIXCAPVngRCoulL08SruZXEWluc1auUZjvsayVg=;
        b=RH4ycA5UirM6jhAQqOVFHGxBnsUxyz24vozH8GdhhNfVj7YXmEhiGl4oaDD6Vhb+PZ6l4M
        hYIEBvtuG9XOF37Mu6Ar9xUDXeW16TQjo44Yo3HDVGsTTE7LZ+r3FTMCNIZWQuy9TwkyOY
        LwsAFAaZcHLVa/S2XZXpzbDzA8mWSPI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-pm95iwqfM_qMasqi8y-IJg-1; Tue, 10 Aug 2021 05:48:51 -0400
X-MC-Unique: pm95iwqfM_qMasqi8y-IJg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 066D939384;
        Tue, 10 Aug 2021 09:48:50 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-79.pek2.redhat.com [10.72.12.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4FA1610013C1;
        Tue, 10 Aug 2021 09:48:45 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de,
        robin.murphy@arm.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
        m.szyprowski@samsung.com, rppt@linux.ibm.com,
        Baoquan He <bhe@redhat.com>
Subject: [RFC PATCH v2 1/5] docs: kernel-parameters: Update to reflect the current default size of atomic pool
Date:   Tue, 10 Aug 2021 17:48:31 +0800
Message-Id: <20210810094835.13402-2-bhe@redhat.com>
In-Reply-To: <20210810094835.13402-1-bhe@redhat.com>
References: <20210810094835.13402-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 1d659236fb43("dma-pool: scale the default DMA coherent pool
size with memory capacity"), the default size of atomic pool has been
changed to take by scaling with system memory capacity. So update the
document in kerenl-parameter.txt accordingly.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bdb22006f713..970ed65db89f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -653,7 +653,9 @@
 
 	coherent_pool=nn[KMG]	[ARM,KNL]
 			Sets the size of memory pool for coherent, atomic dma
-			allocations, by default set to 256K.
+			allocations. Otherwise the default size will be scaled
+			with memory capacity, while clamped between 128K and
+			1 << (PAGE_SHIFT + MAX_ORDER-1).
 
 	com20020=	[HW,NET] ARCnet - COM20020 chipset
 			Format:
-- 
2.17.2

