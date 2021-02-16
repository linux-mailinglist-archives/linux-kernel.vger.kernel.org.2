Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02CB31C9EB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 12:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhBPLjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 06:39:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31407 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230365AbhBPLiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 06:38:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613475448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3FGcyZ1YMxCtgiuoN0O369he0ANjC3No6/UooUw2uNk=;
        b=M/EyJiWWQ8kdAsKfacl+dOYSsGGIHyCoJpqp1ZW1RlR+msE6X8XUfZgZXWkMkGVotvnBoU
        aPyq6F0aICg4RwAD24Q5UMA3l/IPfzwEvts/GgLzDnkxpXHd4kVAPsI6Lg8k64SJIvtY/T
        51bgJEU0jKdCGXJB3+g0mhKEjQ/uHXw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-Ydzhd4QxOySSOZx60YUisA-1; Tue, 16 Feb 2021 06:37:24 -0500
X-MC-Unique: Ydzhd4QxOySSOZx60YUisA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33EE4835E22;
        Tue, 16 Feb 2021 11:37:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-184.ams2.redhat.com [10.36.114.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 49DF45B698;
        Tue, 16 Feb 2021 11:37:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 420EB1800386; Tue, 16 Feb 2021 12:37:17 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 02/10] drm/qxl: more fence wait rework
Date:   Tue, 16 Feb 2021 12:37:08 +0100
Message-Id: <20210216113716.716996-3-kraxel@redhat.com>
In-Reply-To: <20210216113716.716996-1-kraxel@redhat.com>
References: <20210216113716.716996-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move qxl_io_notify_oom() call into wait condition.
That way the driver will call it again if one call
wasn't enough.

Also allows to remove the extra dma_fence_is_signaled()
check and the goto.

Fixes: 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait")
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_release.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index 6ed673d75f9f..63818b56218c 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -62,16 +62,13 @@ static long qxl_fence_wait(struct dma_fence *fence, bool intr,
 
 	qdev = container_of(fence->lock, struct qxl_device, release_lock);
 
-	if (dma_fence_is_signaled(fence))
-		goto signaled;
-
-	qxl_io_notify_oom(qdev);
 	if (!wait_event_timeout(qdev->release_event,
-				dma_fence_is_signaled(fence),
+				(dma_fence_is_signaled(fence) || (
+					qxl_io_notify_oom(qdev),
+					0)),
 				timeout))
 		return 0;
 
-signaled:
 	cur = jiffies;
 	if (time_after(cur, end))
 		return 0;
-- 
2.29.2

