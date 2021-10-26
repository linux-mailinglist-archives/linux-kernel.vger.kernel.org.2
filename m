Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FD343BD03
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 00:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240009AbhJZWM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 18:12:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51414 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237385AbhJZWLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 18:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635286158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ngv1FWqUrC7WszvpfrssmeIqBsloegVrfJrePI9SEBc=;
        b=WzZ4mk4RWMb81HnH3WMyB+tHjAP43wc1A/WsGf2IinJcY/2dvSO68X33lzLOz98pl5SGy+
        PNNEYYi2cHevSh0y/W8d1fiVvleXUolfMKjiSyeT3MrlB2lC6N2k4ETRrP+sk2X9CySotn
        bqhfydXkXVDgUbSshCVoYEiS+/anMS8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-600-QhrBmdrkNZiPOjq3-Gi69A-1; Tue, 26 Oct 2021 18:09:14 -0400
X-MC-Unique: QhrBmdrkNZiPOjq3-Gi69A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55C19A40FA;
        Tue, 26 Oct 2021 22:09:13 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.18.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D41006A908;
        Tue, 26 Oct 2021 22:09:11 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Cc:     Satadru Pramanik <satadru@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 2/5] drm/nouveau/kms/nv50-: Explicitly check DPCD backlights for aux enable/brightness
Date:   Tue, 26 Oct 2021 18:08:45 -0400
Message-Id: <20211026220848.439530-3-lyude@redhat.com>
In-Reply-To: <20211026220848.439530-1-lyude@redhat.com>
References: <20211026220848.439530-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

