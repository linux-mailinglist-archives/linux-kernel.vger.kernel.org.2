Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83EF342D16
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 14:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhCTN3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 09:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhCTN2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 09:28:47 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB87CC061762
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 06:28:46 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id bm8so11334254edb.4
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 06:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=BBm8e3ljXuTB2RwWH86mMYMB3mSh/3i2elGx86nbt2k=;
        b=MvAnzc4LPFs0OPxKBAzRip81IjdvkOQq5oCx+Db7pRo/laL2njO2DR8M29LndXu/Ge
         QigKDtEnw2zlFQQJP9ZXbYZ8AeBvKm0WZB4spAk6kkJaVxuHCDavXwgSjgi36GHTeWSf
         Y2Nb4Krx7dXb3pWTVR4po3SRdHLNanY3GxrxDG9J7nInBnVMrUoPOui8nP3JSRDqMwud
         P2xvicA4GwseQB2c9W4L+nTW4Xo0cG+0WxnbntuDUSvgsY/6aA6IjAUXNUVZq08B9OLw
         YCXiZ+Tuaz8h2XBUklamg7YL2yOszHtvHe+ArcV2vcuUuWcbz3+v6Hv1mJt22A32H9Xn
         f+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=BBm8e3ljXuTB2RwWH86mMYMB3mSh/3i2elGx86nbt2k=;
        b=dna4D06+v/Wk5FCByaPFcoLbzqq6giKckc9YxoGlAvTC3Tkni0g3mX2/vooVgDDOLI
         uSLUprRnM1ksomzgsjHADDGymM0owsqD5qWmcCsXiWr2uK9ClzVynUX/NJif1WzsFL3W
         NcMziO16qIMQ+HlmHNG6eadk8FH/GnkFwAG7uUqZ7ehkil1NbQ4OaPfgDxVNlccoWh2A
         Ej2lKeK6Pv8rKbq8lo8Z3t603KsnRZ97p/o7VD/WS8saabKaBi0HByi/uyQwiEnvD+Nv
         /JoOWTDAHqU98ZrHc3G7rNSG1RwEfdxzQ0mSUItzZQFjMBsu+1UREYHlKGGn8IOFY+J1
         ft8w==
X-Gm-Message-State: AOAM532RjNTGtxzHxrvJGFjJE6YlNJ7uZ5ZIrOanT8WSV4c13Ccqh128
        GMv25i1ufqJF5TN0L/oPZtFdhwH+s1Pe
X-Google-Smtp-Source: ABdhPJwPlInIesVyLJR/yWRN+uRqKL/K5/VS1q+KO2JbycUaR96xSyYa3dYnZk6gJduKpoluxtwJqqPtpmo3
X-Received: from dvyukov-desk.muc.corp.google.com ([2a00:79e0:15:13:84f2:bf18:7ada:738e])
 (user=dvyukov job=sendgmr) by 2002:a50:bb47:: with SMTP id
 y65mr15819702ede.305.1616246925213; Sat, 20 Mar 2021 06:28:45 -0700 (PDT)
Date:   Sat, 20 Mar 2021 14:28:40 +0100
Message-Id: <20210320132840.1315853-1-dvyukov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH] drm/vkms: fix misuse of WARN_ON
From:   Dmitry Vyukov <dvyukov@google.com>
To:     daniel@ffwll.ch, airlied@linux.ie, hamohammed.sa@gmail.com,
        melissa.srw@gmail.com, rodrigosiqueiramelo@gmail.com
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot+4fc21a003c8332eb0bdd@syzkaller.appspotmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vkms_vblank_simulate() uses WARN_ON for timing-dependent condition
(timer overrun). This is a mis-use of WARN_ON, WARN_ON must be used
to denote kernel bugs. Use pr_warn() instead.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Reported-by: syzbot+4fc21a003c8332eb0bdd@syzkaller.appspotmail.com
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Melissa Wen <melissa.srw@gmail.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Change-Id: I7f01c288092bc7e472ec63af198f93ce3d8c49f7
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 0443b7deeaef6..758d8a98d96b3 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -18,7 +18,8 @@ static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
 
 	ret_overrun = hrtimer_forward_now(&output->vblank_hrtimer,
 					  output->period_ns);
-	WARN_ON(ret_overrun != 1);
+	if (ret_overrun != 1)
+		pr_warn("%s: vblank timer overrun\n", __func__);
 
 	spin_lock(&output->lock);
 	ret = drm_crtc_handle_vblank(crtc);

base-commit: e94c55b8e0a0bbe9a026250cf31e2fa45957d776
-- 
2.31.0.291.g576ba9dcdaf-goog

