Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86414235F5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 04:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237242AbhJFCn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 22:43:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30831 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237163AbhJFCnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 22:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633488092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ngv1FWqUrC7WszvpfrssmeIqBsloegVrfJrePI9SEBc=;
        b=L4qttnwB1DH4Qi6/9UdnaFirgSBoKHVef8CNzfq7E9AvhN6olAYGhNozBWmcu4crzZIPEK
        Cc9aiBy8cRCRJQKnTNvpBIFTrKk1x0TWe4sXGKfVVN3pyxum0U7/5gJtuhHprYWynuGtu5
        Yyb20V7fwI2JNIG9FkYFFHtKJt4GS9c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-B2SN_D-INzeQn-Rp6JdYCw-1; Tue, 05 Oct 2021 22:41:31 -0400
X-MC-Unique: B2SN_D-INzeQn-Rp6JdYCw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D172835DE3;
        Wed,  6 Oct 2021 02:41:30 +0000 (UTC)
Received: from Ruby.lyude.net (unknown [10.22.16.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DD6D9AA2E;
        Wed,  6 Oct 2021 02:41:27 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/5] drm/nouveau/kms/nv50-: Explicitly check DPCD backlights for aux enable/brightness
Date:   Tue,  5 Oct 2021 22:40:15 -0400
Message-Id: <20211006024018.320394-3-lyude@redhat.com>
In-Reply-To: <20211006024018.320394-1-lyude@redhat.com>
References: <20211006024018.320394-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we don't support hybrid AUX/PWM backlights in nouveau right now,
let's add some explicit checks so that we don't break nouveau once we
enable support for these backlights in other drivers.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_backlight.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/drm/nouveau/nouveau_backlight.c
index 1cbd71abc80a..ae2f2abc8f5a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
+++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
@@ -308,7 +308,10 @@ nv50_backlight_init(struct nouveau_backlight *bl,
 		if (ret < 0)
 			return ret;
 
-		if (drm_edp_backlight_supported(edp_dpcd)) {
+		/* TODO: Add support for hybrid PWM/DPCD panels */
+		if (drm_edp_backlight_supported(edp_dpcd) &&
+		    (edp_dpcd[1] & DP_EDP_BACKLIGHT_AUX_ENABLE_CAP) &&
+		    (edp_dpcd[2] & DP_EDP_BACKLIGHT_BRIGHTNESS_AUX_SET_CAP)) {
 			NV_DEBUG(drm, "DPCD backlight controls supported on %s\n",
 				 nv_conn->base.name);
 
-- 
2.31.1

