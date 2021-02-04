Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A265F30F5B2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237055AbhBDPBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:01:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50432 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237073AbhBDO6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612450642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ORpRb/MAulS9LThamNcuHHfH5N6/z3HKl9IcxPXaxJg=;
        b=D/1IyQtsGZ53BhQr/8SjwIpLqIv7RP8rjnSj3z4eZXg16WozQlgVGr5XGk2qWMZAy23nZu
        UY1aLWnDxfVnKaIj6PvMzj6PAPmlKaUvtNkkuHglyw+mwbvoZKnoT7mKpg6dIq6bPr2G43
        RYPinFtCm/yaIKlDK5v7GFCZv9O4kG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-Fonb5rb1MtKOdseNGrGGXg-1; Thu, 04 Feb 2021 09:57:19 -0500
X-MC-Unique: Fonb5rb1MtKOdseNGrGGXg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B84A7192CC42;
        Thu,  4 Feb 2021 14:57:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-108.ams2.redhat.com [10.36.113.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AB9A85B695;
        Thu,  4 Feb 2021 14:57:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 28221180101D; Thu,  4 Feb 2021 15:57:12 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 01/10] [hack] silence ttm fini WARNING
Date:   Thu,  4 Feb 2021 15:57:02 +0100
Message-Id: <20210204145712.1531203-2-kraxel@redhat.com>
In-Reply-To: <20210204145712.1531203-1-kraxel@redhat.com>
References: <20210204145712.1531203-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kobject: '(null)' ((____ptrval____)): is not initialized, yet kobject_put() is being called.
WARNING: CPU: 0 PID: 209 at lib/kobject.c:750 kobject_put+0x3a/0x60
[ ... ]
Call Trace:
 ttm_device_fini+0x133/0x1b0 [ttm]
 qxl_ttm_fini+0x2f/0x40 [qxl]
---
 drivers/gpu/drm/ttm/ttm_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
index ac0903c9e60a..b638cbb0bd45 100644
--- a/drivers/gpu/drm/ttm/ttm_device.c
+++ b/drivers/gpu/drm/ttm/ttm_device.c
@@ -50,7 +50,7 @@ static void ttm_global_release(void)
 		goto out;
 
 	kobject_del(&glob->kobj);
-	kobject_put(&glob->kobj);
+//	kobject_put(&glob->kobj);
 	ttm_mem_global_release(&ttm_mem_glob);
 	__free_page(glob->dummy_read_page);
 	memset(glob, 0, sizeof(*glob));
-- 
2.29.2

