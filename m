Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA40237A4DF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 12:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhEKKqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 06:46:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45811 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231308AbhEKKqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 06:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620729931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oOVCZH0GMNMNdtZ2ya+zWwOIjr1e9ZYI1keq2iL/+5M=;
        b=NYP/fWgYi9wyubazZ3bqB32MTto7UjTF94bTr2Bfoip6KCSFwvpCj37L2rJi2SxipjAfV5
        OThU00KO4AelruVTk+OKPzPcWK9kbrLNdOB3V/qR1mRTVTkB9CZ+Gbh7twyHe7zbv0c7iD
        QOdzlkVKb+N/8i46tiGcRIUxFA+ATKg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-OXiYvagCPAqdDJhWd5RNAg-1; Tue, 11 May 2021 06:45:30 -0400
X-MC-Unique: OXiYvagCPAqdDJhWd5RNAg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FCE1501E0;
        Tue, 11 May 2021 10:45:29 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-11.ams2.redhat.com [10.36.112.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 057102B45D;
        Tue, 11 May 2021 10:45:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 3B1D61800903; Tue, 11 May 2021 12:45:22 +0200 (CEST)
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
Subject: [PATCH 1/2] drm/qxl: drop redundant code
Date:   Tue, 11 May 2021 12:45:21 +0200
Message-Id: <20210511104522.2694803-2-kraxel@redhat.com>
In-Reply-To: <20210511104522.2694803-1-kraxel@redhat.com>
References: <20210511104522.2694803-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not needed, qxl_io_destroy_primary() does that for us.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index a7637e79cb42..be5183733c1b 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -677,10 +677,8 @@ static void qxl_primary_atomic_disable(struct drm_plane *plane,
 
 		if (bo->shadow)
 			bo = bo->shadow;
-		if (bo->is_primary) {
+		if (bo->is_primary)
 			qxl_io_destroy_primary(qdev);
-			bo->is_primary = false;
-		}
 	}
 }
 
-- 
2.31.1

