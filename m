Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0825941F7CF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 00:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356075AbhJAW4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 18:56:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56424 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230433AbhJAW4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 18:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633128862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ngv1FWqUrC7WszvpfrssmeIqBsloegVrfJrePI9SEBc=;
        b=Iz5nFT1wrq7/+upvTiqQfOudDnPPA2uMAX+EqbVO//P/J8CanuvtB2ke5CxHUtQMYdjw8a
        1f8m4Cb3ByVmMnwyCfIgywOXTr6SMuHjBXd70HahBDT4/cCbLzqdt4QTSXT61/FgfBgMda
        YL0z7iE0Zs1hpUf0W9YMoVy0jy1RKao=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-dzhswEsoN0GRkgG4htzq_w-1; Fri, 01 Oct 2021 18:54:21 -0400
X-MC-Unique: dzhswEsoN0GRkgG4htzq_w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C23E802947;
        Fri,  1 Oct 2021 22:54:20 +0000 (UTC)
Received: from Ruby.redhat.com (unknown [10.22.17.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 460CB60BF4;
        Fri,  1 Oct 2021 22:54:19 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/4] drm/nouveau/kms/nv50-: Explicitly check DPCD backlights for aux enable/brightness
Date:   Fri,  1 Oct 2021 18:53:42 -0400
Message-Id: <20211001225344.1752203-3-lyude@redhat.com>
In-Reply-To: <20211001225344.1752203-1-lyude@redhat.com>
References: <20211001225344.1752203-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

