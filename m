Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75EE9314423
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 00:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhBHXko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 18:40:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37205 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230154AbhBHXkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 18:40:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612827554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=joZKjJYawGoDbtzmEfFLmQhifYmepL9zWpHMRRqfw2c=;
        b=g2LaOVffTlQOlp2Oy+F2dmESWX8vIfnshGrNaik58JQUBRP9qiH8RxscT8BJhZHGaipdmt
        af9X8N4pKAXj8Z6n+R9alnPUXiDDOtP8X0RpvmPa8F41suYmCeHa2zRn6qTnTE8rXES0YY
        wnUGReYI14f7BclhTXRh4AMGfOdLgOc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-tjFIZCXvM4u9x29MlHR5Ow-1; Mon, 08 Feb 2021 18:39:12 -0500
X-MC-Unique: tjFIZCXvM4u9x29MlHR5Ow-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC18F19357A2;
        Mon,  8 Feb 2021 23:39:10 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-114-219.rdu2.redhat.com [10.10.114.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46F10608DB;
        Mon,  8 Feb 2021 23:39:09 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Dave Airlie <airlied@gmail.com>, greg.depoire@gmail.com,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v4 02/11] drm/nouveau/kms: Don't probe eDP connectors more then once
Date:   Mon,  8 Feb 2021 18:38:52 -0500
Message-Id: <20210208233902.1289693-3-lyude@redhat.com>
In-Reply-To: <20210208233902.1289693-1-lyude@redhat.com>
References: <20210208233902.1289693-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

eDP doesn't do hotplugging, so there's no reason for us to reprobe it (unless a
connection status change is being forced, of course).

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Dave Airlie <airlied@gmail.com>
Cc: greg.depoire@gmail.com
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 61e6d7412505..55e986b3cad9 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -556,6 +556,12 @@ nouveau_connector_detect(struct drm_connector *connector, bool force)
 	int ret;
 	enum drm_connector_status conn_status = connector_status_disconnected;
 
+	/* eDP doesn't do hotplugging, never probe more then once */
+	if (nv_connector->type == DCB_CONNECTOR_eDP &&
+	    connector->force == DRM_FORCE_UNSPECIFIED &&
+	    connector->status != connector_status_unknown)
+		return connector->status;
+
 	/* Outputs are only polled while runtime active, so resuming the
 	 * device here is unnecessary (and would deadlock upon runtime suspend
 	 * because it waits for polling to finish). We do however, want to
-- 
2.29.2

