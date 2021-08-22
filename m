Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908FF3F41FE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 00:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbhHVWVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 18:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbhHVWVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 18:21:40 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C338C06179A
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 15:20:57 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id v33-20020a0568300921b0290517cd06302dso31189294ott.13
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 15:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RGFh1ocE7GYNytaK9ZVTk/INwYTyxPotKB7s3KrmExE=;
        b=JPWE+YmgJlBbdQhhKNkRpvMJ0ojOSmUS9FePAMQGlTfPDjeNpo3zhNdxkBSWX6yeXZ
         f8w8Drri6PMkZN9qsTYerEzg53OkH4cb+sQrQ+xriq3D/Q8ZyXZni+YxRuhAWY5nK6Bb
         YM3F8KR1vJ0RB0kifp57wduOe3YgOmHIvr5cfMv/baXSDDHujQhLdqWI3ZDaTNhrJ88x
         Bo/RD1WgWLkk16UJCzFa2M036CAH3EgtskC9fyVTvGhcvxYbE0XdJBBIBurWLdIPFiRF
         oIIDrqlIspA9tI+iZN7QtN+knEbbmggtkHfLFI9apQBhV6WTlZK5xn3E74VPhi5s3JJv
         MVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RGFh1ocE7GYNytaK9ZVTk/INwYTyxPotKB7s3KrmExE=;
        b=jumXiFuX77GAR2kndFx56e8AGxYHSvkb5ooRFZ+wpncOCPq79NNTz5efJCwBC2IeKK
         cgBrwfjlD7XMt6RD4MpUldiHvqDjtGPBK24GVeFg+Pc+He+yYhV+m2MLQ2ZQh+DBrE1g
         Ao3u3OGUHCGhXtVUIFkUPepYUN8w3RS/cnaG4c77kckCde8DHtXqG6qfIQWbb8eHxJO1
         evtF2UWqf7gw8SaUdO5Q7+VjGXyu1ahuLv67gGrRBggU52rcjE9QY9P/wSaJCKOkUJQf
         HyMqpddG0oiyxEfsx2Pz8Nwbk6+TLDCI/18ctNEL8PQ9/C+ReTpbN/CLcIpKknRXlVEF
         ChKQ==
X-Gm-Message-State: AOAM531uno+giWcYMDAaNp4XGRXhwdP7tqQ8OtT9UT16rvmw1XGxEVT0
        b97cOvqXWKd7vRFMtkBKaOc=
X-Google-Smtp-Source: ABdhPJx+yWcZ3I+WyB6O09Vf/MP/6Q/RWo3l1z8RmQISKj4KBmaNhmIqVPxxO7TcXUeuhViA5nMR6w==
X-Received: by 2002:a05:6808:209b:: with SMTP id s27mr9403654oiw.98.1629670856722;
        Sun, 22 Aug 2021 15:20:56 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id x198sm2964122ooa.43.2021.08.22.15.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 15:20:56 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        seanpaul@chromium.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 09/11] nouveau: fold multiple DRM_DEBUG_DRIVERs together
Date:   Sun, 22 Aug 2021 16:20:07 -0600
Message-Id: <20210822222009.2035788-10-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210822222009.2035788-1-jim.cromie@gmail.com>
References: <20210822222009.2035788-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With DRM_USE_DYNAMIC_DEBUG, each callsite record requires 56 bytes.
We can combine 12 into one here and save ~620 bytes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 36 +++++++++++++++++----------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index a616cf4573b8..58693e40b447 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -1246,19 +1246,29 @@ nouveau_drm_pci_table[] = {
 
 static void nouveau_display_options(void)
 {
-	DRM_DEBUG_DRIVER("Loading Nouveau with parameters:\n");
-
-	DRM_DEBUG_DRIVER("... tv_disable   : %d\n", nouveau_tv_disable);
-	DRM_DEBUG_DRIVER("... ignorelid    : %d\n", nouveau_ignorelid);
-	DRM_DEBUG_DRIVER("... duallink     : %d\n", nouveau_duallink);
-	DRM_DEBUG_DRIVER("... nofbaccel    : %d\n", nouveau_nofbaccel);
-	DRM_DEBUG_DRIVER("... config       : %s\n", nouveau_config);
-	DRM_DEBUG_DRIVER("... debug        : %s\n", nouveau_debug);
-	DRM_DEBUG_DRIVER("... noaccel      : %d\n", nouveau_noaccel);
-	DRM_DEBUG_DRIVER("... modeset      : %d\n", nouveau_modeset);
-	DRM_DEBUG_DRIVER("... runpm        : %d\n", nouveau_runtime_pm);
-	DRM_DEBUG_DRIVER("... vram_pushbuf : %d\n", nouveau_vram_pushbuf);
-	DRM_DEBUG_DRIVER("... hdmimhz      : %d\n", nouveau_hdmimhz);
+	DRM_DEBUG_DRIVER("Loading Nouveau with parameters:\n"
+			 "... tv_disable   : %d\n"
+			 "... ignorelid    : %d\n"
+			 "... duallink     : %d\n"
+			 "... nofbaccel    : %d\n"
+			 "... config       : %s\n"
+			 "... debug        : %s\n"
+			 "... noaccel      : %d\n"
+			 "... modeset      : %d\n"
+			 "... runpm        : %d\n"
+			 "... vram_pushbuf : %d\n"
+			 "... hdmimhz      : %d\n"
+			 , nouveau_tv_disable
+			 , nouveau_ignorelid
+			 , nouveau_duallink
+			 , nouveau_nofbaccel
+			 , nouveau_config
+			 , nouveau_debug
+			 , nouveau_noaccel
+			 , nouveau_modeset
+			 , nouveau_runtime_pm
+			 , nouveau_vram_pushbuf
+			 , nouveau_hdmimhz);
 }
 
 static const struct dev_pm_ops nouveau_pm_ops = {
-- 
2.31.1

