Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C0531C9EE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 12:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBPLkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 06:40:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32827 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230374AbhBPLi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 06:38:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613475448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gy+qfCCUOiXuPG3/YfIFX5QFqh7lwdru5JnT0B7FhNU=;
        b=CH2UjqcC825e1BqBPVkeEAaUAs9DMvFY51uox2c1EsyANbQp7i4TmCeCdDUOx4COg9768H
        b+S+Rd8GrWVZwyciL4icWBzKaux2bNOJADHC9oD/2H8ivD7UJcMkuDnpHpkEUQUWwNVcpP
        /uabnTl75uN4NJP2CKNCQ3ttNamof3E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-x-sVj8BpMamYKKbJsOkX9w-1; Tue, 16 Feb 2021 06:37:27 -0500
X-MC-Unique: x-sVj8BpMamYKKbJsOkX9w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E054E9126F;
        Tue, 16 Feb 2021 11:37:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-184.ams2.redhat.com [10.36.114.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 49D255D765;
        Tue, 16 Feb 2021 11:37:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 2336A1800382; Tue, 16 Feb 2021 12:37:17 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 01/10] drm/qxl: properly handle device init failures
Date:   Tue, 16 Feb 2021 12:37:07 +0100
Message-Id: <20210216113716.716996-2-kraxel@redhat.com>
In-Reply-To: <20210216113716.716996-1-kraxel@redhat.com>
References: <20210216113716.716996-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specifically do not try release resources which where
not allocated in the first place.

Cc: Tong Zhang <ztong0001@gmail.com>
Tested-by: Tong Zhang <ztong0001@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 3 +++
 drivers/gpu/drm/qxl/qxl_kms.c     | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index c326412136c5..ec50d2cfd4e1 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -1183,6 +1183,9 @@ int qxl_destroy_monitors_object(struct qxl_device *qdev)
 {
 	int ret;
 
+	if (!qdev->monitors_config_bo)
+		return 0;
+
 	qdev->monitors_config = NULL;
 	qdev->ram_header->monitors_config = 0;
 
diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
index 66d74aaaee06..4dc5ad13f12c 100644
--- a/drivers/gpu/drm/qxl/qxl_kms.c
+++ b/drivers/gpu/drm/qxl/qxl_kms.c
@@ -288,6 +288,10 @@ void qxl_device_fini(struct qxl_device *qdev)
 {
 	int cur_idx;
 
+	/* check if qxl_device_init() was successful (gc_work is initialized last) */
+	if (!qdev->gc_work.func)
+		return;
+
 	for (cur_idx = 0; cur_idx < 3; cur_idx++) {
 		if (!qdev->current_release_bo[cur_idx])
 			continue;
-- 
2.29.2

