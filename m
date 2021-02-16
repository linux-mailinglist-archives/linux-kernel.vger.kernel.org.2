Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442B931C9F0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 12:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhBPLkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 06:40:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55692 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230375AbhBPLi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 06:38:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613475449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LddbWRXDOdoIRx26pBviJhLeOTNZA/vNgqOHA0L1BFU=;
        b=CzHibBl2ysHjpTyXZnsHzDiEm4J5Kg6vrgtY5si9/pvghkuYvPaQ5w2j4GWFK6Ousxuumr
        s7Pf3jW5ZjtKDsnknptm8YWiAF8AeiM2212cSQmUvMRtrd8LPxBkAn+fQmvL+tT82MGd3M
        conhXV4ZI50xgxG6wbo9UDg4H5bGzHc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-f_YqtW_wO-iKbDjaR3aryA-1; Tue, 16 Feb 2021 06:37:27 -0500
X-MC-Unique: f_YqtW_wO-iKbDjaR3aryA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6713835E22;
        Tue, 16 Feb 2021 11:37:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-184.ams2.redhat.com [10.36.114.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D3EA5B698;
        Tue, 16 Feb 2021 11:37:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id A492A1800870; Tue, 16 Feb 2021 12:37:18 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 10/10] drm/qxl: add lock asserts to qxl_bo_kmap_locked + qxl_bo_kunmap_locked
Date:   Tue, 16 Feb 2021 12:37:16 +0100
Message-Id: <20210216113716.716996-11-kraxel@redhat.com>
In-Reply-To: <20210216113716.716996-1-kraxel@redhat.com>
References: <20210216113716.716996-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try avoid re-introducing locking bugs.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_object.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
index 22748b9566af..90d5e5b7f927 100644
--- a/drivers/gpu/drm/qxl/qxl_object.c
+++ b/drivers/gpu/drm/qxl/qxl_object.c
@@ -162,6 +162,8 @@ int qxl_bo_kmap_locked(struct qxl_bo *bo, struct dma_buf_map *map)
 {
 	int r;
 
+	dma_resv_assert_held(bo->tbo.base.resv);
+
 	if (bo->kptr) {
 		bo->map_count++;
 		goto out;
@@ -236,6 +238,8 @@ void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev,
 
 void qxl_bo_kunmap_locked(struct qxl_bo *bo)
 {
+	dma_resv_assert_held(bo->tbo.base.resv);
+
 	if (bo->kptr == NULL)
 		return;
 	bo->map_count--;
-- 
2.29.2

