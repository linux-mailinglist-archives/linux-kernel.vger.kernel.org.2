Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7343388CB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbhCLJhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:37:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34310 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232482AbhCLJgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:36:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615541805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oFORvYYdUj0Nk+tu76LW9UmuFD9EYlT40w76crsJUJk=;
        b=fCH8W9DFXXgwHmv0c9FHW1FPKJK8/dmLV0p/q5BnUktFpY0HLK5lLRbsdgmwMeopHlKvVC
        uE9iGMtwp85PTzwnAI3XBXPytl/uMljQ4mQGZm3qF7EgNTETxeb9zVppTWjaT/bBpeTrTn
        bUA94RQq5WG24r6v9ImmIPnVCy9Q3i0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-3NDsw9FXMBy6VOhw8q_N4A-1; Fri, 12 Mar 2021 04:36:43 -0500
X-MC-Unique: 3NDsw9FXMBy6VOhw8q_N4A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D32A3107B106;
        Fri, 12 Mar 2021 09:36:37 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-47.pek2.redhat.com [10.72.13.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5BE31A8F2;
        Fri, 12 Mar 2021 09:36:35 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     jasowang@redhat.com, mst@redhat.com
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] vdpa: fix build dependency of VIRTIO_PCI_LIB
Date:   Fri, 12 Mar 2021 17:36:33 +0800
Message-Id: <20210312093633.3948-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The modern PCI device module should be built independently without
VIRTIO. This patch fixes this.

Fixes: 7075992ba8873（“vdpa: introduce virtio pci driver")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/Makefile b/drivers/Makefile
index fd11b9ac4cc3..911ee117def4 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_DMADEVICES)	+= dma/
 obj-y				+= soc/
 
 obj-$(CONFIG_VIRTIO)		+= virtio/
+obj-$(CONFIG_VIRTIO_PCI_LIB)	+= virtio/
 obj-$(CONFIG_VDPA)		+= vdpa/
 obj-$(CONFIG_XEN)		+= xen/
 
-- 
2.25.1

