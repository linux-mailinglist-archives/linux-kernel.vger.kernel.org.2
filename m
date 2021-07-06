Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532EA3BD86D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhGFOlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:41:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58781 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232376AbhGFOkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625582284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=INHpBOzecXW3uN1gYFoHGsu1Y3t/3VmqaiRaKVReXwU=;
        b=ZGDgB16gAL475TSdIt9X9RkJhformoZsHryXiKvvDjY6zD9VWukZ/b5D3DW9s1MruDJ1af
        lTfoYHwAmHHAlbFEzaWAenPwKS2HdeD/Z+V+vPW8PkMuzi2lGKcE8SC1K9XFLFx59QVVA9
        y7LwdG7GaRhM4UzkweYsyeTfdYYbXLY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-Qd_dwfLzMMKMaN-VudyKYg-1; Tue, 06 Jul 2021 10:26:45 -0400
X-MC-Unique: Qd_dwfLzMMKMaN-VudyKYg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70FD1804140;
        Tue,  6 Jul 2021 14:26:44 +0000 (UTC)
Received: from eperezma.remote.csb (ovpn-113-20.ams2.redhat.com [10.36.113.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 010B0369A;
        Tue,  6 Jul 2021 14:26:42 +0000 (UTC)
From:   =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To:     mst@redhat.com, linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jason Wang <jasowang@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH 2/2] vringh: Include spinlock.h
Date:   Tue,  6 Jul 2021 16:26:32 +0200
Message-Id: <20210706142632.670483-3-eperezma@redhat.com>
In-Reply-To: <20210706142632.670483-1-eperezma@redhat.com>
References: <20210706142632.670483-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f53d9910d009 ("vringh: add 'iotlb_lock' to synchronize iotlb
accesses") introduces this dependency, but does not include spinlock.h.
While kernel seems to compile as usual, tools/virtio cannot do the
same.

Fixes: f53d9910d009 ("vringh: add 'iotlb_lock' to synchronize iotlb accesses")

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 include/linux/vringh.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/vringh.h b/include/linux/vringh.h
index 84db7b8f912f..212892cf9822 100644
--- a/include/linux/vringh.h
+++ b/include/linux/vringh.h
@@ -14,6 +14,7 @@
 #include <linux/virtio_byteorder.h>
 #include <linux/uio.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #if IS_REACHABLE(CONFIG_VHOST_IOTLB)
 #include <linux/dma-direction.h>
 #include <linux/vhost_iotlb.h>
-- 
2.27.0

