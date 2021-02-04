Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0942D30F5C8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236956AbhBDPEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:04:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45107 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237072AbhBDO6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612450642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NBs15qRjjzjdlUKrkJJe9FgGE4IM/0kRP7oncF/GMkk=;
        b=ejb1QP82rn9qhkZ+0uus96vXDOU1us8zlwAqatcJ6r5w1mOOGf0++Lf1WZMCBEKkwIBGv8
        U5jyTtq5756OwoxUcPEyIzC8aH2Fustf7MqtAANqVYyRuW3tMClovwuLpXbrPm/1sa6DIa
        LnwHGtLGuUwBekpj1RdZfWdBha7RZBY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-8N-LUYrQPYuG6999JiEovQ-1; Thu, 04 Feb 2021 09:57:20 -0500
X-MC-Unique: 8N-LUYrQPYuG6999JiEovQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 360A3107ACE6;
        Thu,  4 Feb 2021 14:57:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-108.ams2.redhat.com [10.36.113.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EC460100F493;
        Thu,  4 Feb 2021 14:57:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id DE1C31801023; Thu,  4 Feb 2021 15:57:12 +0100 (CET)
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
Subject: [PATCH v6 07/10] drm/qxl: handle shadow in primary destroy
Date:   Thu,  4 Feb 2021 15:57:08 +0100
Message-Id: <20210204145712.1531203-8-kraxel@redhat.com>
In-Reply-To: <20210204145712.1531203-1-kraxel@redhat.com>
References: <20210204145712.1531203-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qxl_primary_atomic_disable must check whenever the framebuffer bo has a
shadow surface and in case it has check the shadow primary status.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/qxl/qxl_display.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index d25fd3acc891..c326412136c5 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -562,6 +562,8 @@ static void qxl_primary_atomic_disable(struct drm_plane *plane,
 	if (old_state->fb) {
 		struct qxl_bo *bo = gem_to_qxl_bo(old_state->fb->obj[0]);
 
+		if (bo->shadow)
+			bo = bo->shadow;
 		if (bo->is_primary) {
 			qxl_io_destroy_primary(qdev);
 			bo->is_primary = false;
-- 
2.29.2

