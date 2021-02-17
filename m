Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5915A31D997
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 13:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbhBQMfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 07:35:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44072 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232688AbhBQMdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 07:33:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613565148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BMcEaTsr6hvZpRTO/Z+/hPVLzGmBLIj423n6krFv2UM=;
        b=NvOvP4Oa7MecTbpzKgwCYp98GTLUlpdqq9NxPNA5nNPNA5Qw54Mqq+6lN0mnljjgbhYMGh
        MkznNDFJTM5d6RU4X7hoZ+emYy4W0+5oxhZNU1tD3Lg6lpl7KkqZKAOaCS4Q4Pr78YYpUp
        bqP70hUXlYk4K4iwEUPLxs8/zg/OChs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-6b1LB9eDNZCnIMIw3U7qcQ-1; Wed, 17 Feb 2021 07:32:24 -0500
X-MC-Unique: 6b1LB9eDNZCnIMIw3U7qcQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42A08801975;
        Wed, 17 Feb 2021 12:32:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-184.ams2.redhat.com [10.36.114.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D77119D9B;
        Wed, 17 Feb 2021 12:32:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 3A8EB1800630; Wed, 17 Feb 2021 13:32:15 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 11/11] drm/qxl: add lock asserts to qxl_bo_vmap_locked + qxl_bo_vunmap_locked
Date:   Wed, 17 Feb 2021 13:32:13 +0100
Message-Id: <20210217123213.2199186-12-kraxel@redhat.com>
In-Reply-To: <20210217123213.2199186-1-kraxel@redhat.com>
References: <20210217123213.2199186-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try avoid re-introducing locking bugs.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/qxl/qxl_object.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
index 82c3bf195ad6..6e26d70f2f07 100644
--- a/drivers/gpu/drm/qxl/qxl_object.c
+++ b/drivers/gpu/drm/qxl/qxl_object.c
@@ -162,6 +162,8 @@ int qxl_bo_vmap_locked(struct qxl_bo *bo, struct dma_buf_map *map)
 {
 	int r;
 
+	dma_resv_assert_held(bo->tbo.base.resv);
+
 	if (bo->kptr) {
 		bo->map_count++;
 		goto out;
@@ -236,6 +238,8 @@ void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev,
 
 void qxl_bo_vunmap_locked(struct qxl_bo *bo)
 {
+	dma_resv_assert_held(bo->tbo.base.resv);
+
 	if (bo->kptr == NULL)
 		return;
 	bo->map_count--;
-- 
2.29.2

