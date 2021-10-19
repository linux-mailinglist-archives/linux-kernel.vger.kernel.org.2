Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721B5432EE6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 09:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbhJSHGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 03:06:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43223 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234458AbhJSHGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 03:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634627051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DayTXBwbvVaQx4LfEv0thvml5ih6YQzC9fEqMQRhHrI=;
        b=EmbEFgmWCpLPhKQ3t25D81LT9oz8z9F4uyiISyXU2WWFsurL/NKwVQL0S5fI1tNzyEdQmh
        pBXyCPwm4rtkUvPfl94CvLaKstaOqu7hoW2HVb2U1uRxrqs0FCp6dzxgZXRz6JDCqQXAqX
        VctwAWzwl71gj+XD/FR35iHdGsPMIEY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-h87nX8GHPq28_CGD_xA8fg-1; Tue, 19 Oct 2021 03:04:08 -0400
X-MC-Unique: h87nX8GHPq28_CGD_xA8fg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 406C89126B;
        Tue, 19 Oct 2021 07:04:07 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-155.pek2.redhat.com [10.72.12.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98F06707B6;
        Tue, 19 Oct 2021 07:03:32 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com
Subject: [PATCH V3 06/10] virtio_ring: fix typos in vring_desc_extra
Date:   Tue, 19 Oct 2021 15:01:48 +0800
Message-Id: <20211019070152.8236-7-jasowang@redhat.com>
In-Reply-To: <20211019070152.8236-1-jasowang@redhat.com>
References: <20211019070152.8236-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're actually tracking descriptor address and length instead of the
buffer.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index dd95dfd85e98..d2ca0a7365f8 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -79,8 +79,8 @@ struct vring_desc_state_packed {
 };
 
 struct vring_desc_extra {
-	dma_addr_t addr;		/* Buffer DMA addr. */
-	u32 len;			/* Buffer length. */
+	dma_addr_t addr;		/* Descriptor DMA addr. */
+	u32 len;			/* Descriptor length. */
 	u16 flags;			/* Descriptor flags. */
 	u16 next;			/* The next desc state in a list. */
 };
-- 
2.25.1

