Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3747638F328
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 20:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhEXSoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 14:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbhEXSoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 14:44:09 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D73C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 11:42:40 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id j12so20744644pgh.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 11:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0lIj2JPS56Xp2DBaz+Q3cwfyZBcU2zyGs0Uphk2Sqys=;
        b=XO4WiNivZKpaOGgwvH9M2+upDycSqmiKS7yAVt+IclB6rTZUJNwpeIWhJ94TpGm4yF
         x4KkkGUl8A1vD0M/B3BCA7lGYO23IQsq6BIU6/6eqY7YYv3wpqZJ2uAlOcLjUO1rCa+c
         Mr7j3Aet1fQP8HUFKhf8Uv+Tw26M5HF30s2Qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0lIj2JPS56Xp2DBaz+Q3cwfyZBcU2zyGs0Uphk2Sqys=;
        b=etKk5ZtSpu1/UyYRen7l2/TgmS3PXHIr5/1ku1mKa9YTN8J1u+JAc23wGXO+Tw6/r+
         ik1yF+hXg2ZIkDpPtgp/T0AM2Hxal94qdlsYirCL0p0JL5f+0kstOIXi6Vx8fGWhk1wc
         nj0u9AlfBa79BFQnAGG0gxu/8sj94/nGlB8vTVLaUfmcnY6gclAm9QSUwl0n/in/xip+
         vNwWF94xZcIge/x/HqJMtT708OTDbP067jNpoxOPLxeDE8/CyUSPISneVqNTMEcgJSt9
         vIE4TPyVlmShQmYMDTxrLRpZyR44zooRNhcsdxyRMLKHfB/SwQUlQj3qYCy8tmRsgNoR
         kSLw==
X-Gm-Message-State: AOAM532FA66mPWSaktXCZXTBVpLDgd9vOa8qO2XKvxZeTR54OmlWXt56
        R3UJVMILGYnDRGi/IJRtes/C+Q==
X-Google-Smtp-Source: ABdhPJyEESSJu6/xp/AD92L7LjPu5dY5wWdr0BidRyr6bfpQDMyd3WRLMHc+/WXauzF0qSpZA12prw==
X-Received: by 2002:a05:6a00:1996:b029:2e0:9d87:a547 with SMTP id d22-20020a056a001996b02902e09d87a547mr25586981pfl.12.1621881759691;
        Mon, 24 May 2021 11:42:39 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c00a:a884:3e9e:4cb3:3e0e:f4b1])
        by smtp.gmail.com with ESMTPSA id s2sm155655pjz.41.2021.05.24.11.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 11:42:39 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH] drm/panel: panel-simple: Fix proper bpc for ytc700tlag_05_201c
Date:   Tue, 25 May 2021 00:12:26 +0530
Message-Id: <20210524184226.3064621-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ytc700tlag_05_201c panel support 8 bpc not 6 bpc as per
recent testing in i.MX8MM platform.

Fix it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 9be050ab372f..6f4151729fb7 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -4164,7 +4164,7 @@ static const struct drm_display_mode yes_optoelectronics_ytc700tlag_05_201c_mode
 static const struct panel_desc yes_optoelectronics_ytc700tlag_05_201c = {
 	.modes = &yes_optoelectronics_ytc700tlag_05_201c_mode,
 	.num_modes = 1,
-	.bpc = 6,
+	.bpc = 8,
 	.size = {
 		.width = 154,
 		.height = 90,
-- 
2.25.1

