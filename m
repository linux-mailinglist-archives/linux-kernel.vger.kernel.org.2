Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6BD3C7D2D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 06:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237725AbhGNEM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 00:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhGNEMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 00:12:24 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3AAC0613DD;
        Tue, 13 Jul 2021 21:09:33 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id j3so858829plx.7;
        Tue, 13 Jul 2021 21:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dNtQuwwmGDuffyzJJxrC7J0rgzq3v1ZDzE0BZBmT5ME=;
        b=sxOlB05EOu4kn6zBdjcf/8lnqNeshmDp+JV2COQqQu3eiCOXAlCW2olxWyiux6I+cR
         m1fQCMhPWt1EJf3XgyTYjmTyqbItav6hVhx49OHEZ/1tiuLt+nG2C1YfW+X/dFO+2y1w
         kWxr5DUB8320YFJTUu/6OTMiDjYcGoxW/0xsOyX2GPbvaopJhuLL0Wau/Po7AITJgeuy
         ajetYOHwZWIofp8OCYSqVtWcIWIwJ/yFAMvylIkaFesFCjTCeLuAUkvXckFOx99zitMk
         9kh0djrXPHWJSLcJAIae59fRH8vXJ+ZiOtfWy566QkZZG7leZeWM+CUb02iH2qDQ3jTj
         0gaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dNtQuwwmGDuffyzJJxrC7J0rgzq3v1ZDzE0BZBmT5ME=;
        b=Pv4P7L5Ro2kTZafsR76Q6ANhePMhGH1IHHxKjgQa3rUlxnWvSSHCFGu+DXAv8jY5rg
         FZub3WF7RiJ2Qo6sMmh2IK5aCzbAzoDWXs865/sR1ICSaMd2b9y/VHMIbFZ7woLtWaV7
         C7guc5RdQEsRkrsiGtGJgk883HmsGxaO76G307G1+rw3K6+wANqaR9v3aAhgzk+KIv+h
         rsDeKsu638b9sXoqEqoQX18BWLHDqnbLpbsza04Xdoa9QNDzwDzuoo4mn6Qjgskw6LRL
         fPMt6ET+iZ8skEdwuKEgXYkVRqZ5cKxkowgjviEasV2lGj0qU8EE1MHa7CmerfSi1uCN
         w4TA==
X-Gm-Message-State: AOAM532wMCBORvJ2wGTRG4MfNbKAS5Ls2wVZBKvoAKRY+pbDHWeg+XwI
        AgH8Cp6/eXTSV/BN8PyK7aLU/frvPT+5RaY=
X-Google-Smtp-Source: ABdhPJxaKwld9avLXJiiCQB2C3ZpjTPxhGiFfOKosko60ULcCDLejOTZxvqG/4n0ipsTr8oB8dEiTA==
X-Received: by 2002:a17:90a:db53:: with SMTP id u19mr7808849pjx.4.1626235772271;
        Tue, 13 Jul 2021 21:09:32 -0700 (PDT)
Received: from vultr.guest ([107.191.53.97])
        by smtp.gmail.com with ESMTPSA id v23sm3675964pje.33.2021.07.13.21.09.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Jul 2021 21:09:31 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sam@ravnborg.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH v2] video: fbdev: kyro: fix a DoS bug by restricting user input
Date:   Wed, 14 Jul 2021 04:09:22 +0000
Message-Id: <1626235762-2590-1-git-send-email-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The user can pass in any value to the driver through the 'ioctl'
interface. The driver dost not check, which may cause DoS bugs.

The following log reveals it:

divide error: 0000 [#1] PREEMPT SMP KASAN PTI
RIP: 0010:SetOverlayViewPort+0x133/0x5f0 drivers/video/fbdev/kyro/STG4000OverlayDevice.c:476
Call Trace:
 kyro_dev_overlay_viewport_set drivers/video/fbdev/kyro/fbdev.c:378 [inline]
 kyrofb_ioctl+0x2eb/0x330 drivers/video/fbdev/kyro/fbdev.c:603
 do_fb_ioctl+0x1f3/0x700 drivers/video/fbdev/core/fbmem.c:1171
 fb_ioctl+0xeb/0x130 drivers/video/fbdev/core/fbmem.c:1185
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x19b/0x220 fs/ioctl.c:739
 do_syscall_64+0x32/0x80 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
Changes in v2:
    - Validate the inputs on a higher level
---
 drivers/video/fbdev/kyro/fbdev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/fbdev/kyro/fbdev.c b/drivers/video/fbdev/kyro/fbdev.c
index 8fbde92ae8b9..eb0cbd1d12d5 100644
--- a/drivers/video/fbdev/kyro/fbdev.c
+++ b/drivers/video/fbdev/kyro/fbdev.c
@@ -372,6 +372,11 @@ static int kyro_dev_overlay_viewport_set(u32 x, u32 y, u32 ulWidth, u32 ulHeight
 		/* probably haven't called CreateOverlay yet */
 		return -EINVAL;
 
+	if (ulWidth == 0 || ulWidth == 0xffffffff ||
+		ulHeight == 0 || ulHeight == 0xffffffff ||
+		(x < 2 && ulWidth + 2 == 0))
+		return -EINVAL;
+
 	/* Stop Ramdac Output */
 	DisableRamdacOutput(deviceInfo.pSTGReg);
 
-- 
2.17.6

