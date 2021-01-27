Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8E5305098
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 05:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237805AbhA0D7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S316534AbhA0Bws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 20:52:48 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CB0C061573
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 17:51:31 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id u4so348134pjn.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 17:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3yvptWfKORCEVwYy1ACTtiGifr+3cTipupRyRjthl2g=;
        b=W3oELcA9iI1ZLJQf2lRy3K5z1tVR/fGJ6GASMr9lo87icBB8J8WcIyHnigXabQnMTh
         DNe9drkZ9T1P6DYkqvsF5kMQiNMmtRRfhKvjBuWfLJA7AgdoohRPZNW4zzJy47IUOiyc
         SJqXZ2bQeybF2XHiEGZuFC7+WP1PrEJpRLPCJNIRgBQQqxLD9QVJAfbKGDuD5h1f7G8r
         Q1XSQg2XbwMUauHVq+K2soVh6soXod/I3NTwh6OObO0KO6TxqpsZeywgmV4nNiFrtKPH
         5UC+VdH00MsFTGst9EwWAroDJX41Sxmb9S6fm/0wweL0gdLoIyANlEsuA8iGHawAbDoK
         Hf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3yvptWfKORCEVwYy1ACTtiGifr+3cTipupRyRjthl2g=;
        b=Ha1xJbfUyxlPEkxPSHhaLHiEBb55OP2lp8ZOU8fXQaUQPz2omFfZ2tKhTJ8tX+7tYG
         hdHpgpUINE5GPpY0v1VKAsf8sn6ftG2HfpPdIsvQuv77bksk3bRtsea11+y5zW5ltZMA
         yMrXhwo4tBikAyMklpHIja21RIsDfxhBwYjqnhqa49GQF8H/kuWVfNoPNmCyzUyyCAsj
         WgIJqMSRuAMPo58qU4WPuujZDkME4BpRA3yxukepTu2BZXSIMAFsjiFibrcGDJQW0LXn
         PWFZ1XFE/8fASkbXGJHClaY7JTrzTc6bTAFSt7ksZ7nxyRYxYxW9GDvaX0uyvVpZ3sXD
         bPGw==
X-Gm-Message-State: AOAM533t7sCG5C5wRXZY+kTeq5HtLWlxW0ltgd/z8z7dhkM5xmNkPhvu
        4RO6uaj/oKc8jWkqNZDBqn10LyAf4qM=
X-Google-Smtp-Source: ABdhPJytgnP3XVHxsTdmA0Cu8bWPloY+2QADc/bc0RiANnTwjheceTjWakSGLieRfhC/iuWuQkgHEA==
X-Received: by 2002:a17:902:8ec7:b029:e0:a02:3d26 with SMTP id x7-20020a1709028ec7b02900e00a023d26mr8724235plo.24.1611712290234;
        Tue, 26 Jan 2021 17:51:30 -0800 (PST)
Received: from localhost ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id p7sm325105pfn.52.2021.01.26.17.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 17:51:29 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
To:     tomba@kernel.org, sebastian.reichel@collabora.com
Cc:     airlied@linux.ie, daniel@ffwll.ch,
        laurent.pinchart@ideasonboard.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Menglong Dong <dong.menglong@zte.com.cn>
Subject: [PATCH v2] drm/omap: dsi: fix unreachable code in dsi_vc_send_short()
Date:   Tue, 26 Jan 2021 17:51:17 -0800
Message-Id: <20210127015117.23267-1-dong.menglong@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Menglong Dong <dong.menglong@zte.com.cn>

The 'r' in dsi_vc_send_short() is of type 'unsigned int', so the
'r < 0' can't be true.

Fix this by introducing a 'err' of type 'int' insteaded.

Fixes: 1ed6253856cb ("drm/omap: dsi: switch dsi_vc_send_long/short to mipi_dsi_msg")

Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
v2:
- remove word wrap in 'Fixes' tag
---
 drivers/gpu/drm/omapdrm/dss/dsi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
index 8e11612f5fe1..febcc87ddfe1 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -2149,11 +2149,12 @@ static int dsi_vc_send_short(struct dsi_data *dsi, int vc,
 			     const struct mipi_dsi_msg *msg)
 {
 	struct mipi_dsi_packet pkt;
+	int err;
 	u32 r;
 
-	r = mipi_dsi_create_packet(&pkt, msg);
-	if (r < 0)
-		return r;
+	err = mipi_dsi_create_packet(&pkt, msg);
+	if (err)
+		return err;
 
 	WARN_ON(!dsi_bus_is_locked(dsi));
 
-- 
2.25.1

