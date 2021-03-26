Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5036234A7A2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 13:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhCZMzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 08:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhCZMzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 08:55:39 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33380C0613AA;
        Fri, 26 Mar 2021 05:55:39 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so2442934pjb.0;
        Fri, 26 Mar 2021 05:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bD7BmJLsMFKPJi26Vt4AcHwe8h+Gi9tyJ2So5fUgWQg=;
        b=PBEzo7+X1jjaDjoT3sILVgIkuqHSGdjHybEj7ugJj1stn7nVD9ZjNdIzhw27oj9PKj
         Fl8f1ZyIlCxaAWvLdbnyU2OUClBKnKnSdpWVPrZaDIPsFL+BFXGgBX1e8Aiu7GR1COka
         gm7zDpYF0Wbv7eAvf65i3fUpKVY0ldy/5N7arDvwH9gZMjw8Oh3nQiI0x8/QbqNSZHrB
         1TLs+10jsNDzoBkowEJIDeZKosA2d2f0zSnC5FcujIoEX8KVpWz+MBB/J4jr883ziy/0
         L8nvqiSsgYK/3Cn6DBu5DAhalefbp60+jyL2hBEp8b5a3dKozwPqCgv34JEDFdNMIrNH
         XG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bD7BmJLsMFKPJi26Vt4AcHwe8h+Gi9tyJ2So5fUgWQg=;
        b=Mm1dRyYXoiPHpaA++fSGjXEYvNUUz0qv8goT9rhYNAHksEl7ZvKCCvp7jn+kHKfNXP
         XG+24SNLp/5bjbD5GKvlfgJ5Vnhu1KN0UvTA+AAfsqdEYOfk6+RInsTSIkJiKOjfQIji
         7GbHT+sy9OJ7M4SCD4LGK4DS636X9Brzu6Wi46Lw5jDlpfUJSRyDGr0+xA8S5lIh46Y1
         jNPNveO4zMndnELsY2eLqW11b4iS/l9Y5YmqolMxN+P8PKDqLaU3FmTQFwS0tL9xmKB5
         x4SUFTwruKmczdUsIy5QQYvO+GzXJvKd6ivi+YTB+KS0FlFFYVBgxQAex90NuojvlUvj
         gl3Q==
X-Gm-Message-State: AOAM533Bs1IZpuqFXsL8Ru1+C2f3Nz80I3lDPlxE7ypWQWqZ3oo/Epg1
        L50clYnP2oBvYAgv7uOTggg=
X-Google-Smtp-Source: ABdhPJyBJT+jB/6VmowdbHzWRJITwo+Vt9TueqySl4LbJbSV6+tKmwR9e21rR/tQvLODSxDkupaGow==
X-Received: by 2002:a17:90a:8a8b:: with SMTP id x11mr13657566pjn.151.1616763338813;
        Fri, 26 Mar 2021 05:55:38 -0700 (PDT)
Received: from bf-rmsz-10.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id l190sm9164110pfl.73.2021.03.26.05.55.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Mar 2021 05:55:38 -0700 (PDT)
From:   Carlis <zhangxuezhi3@gmail.com>
To:     gregkh@linuxfoundation.org, zhangxuezhi1@yulong.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: fbtft: fix a typo
Date:   Fri, 26 Mar 2021 20:55:51 +0800
Message-Id: <1616763351-7433-1-git-send-email-zhangxuezhi3@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xuezhi Zhang <zhangxuezhi1@yulong.com>

Change 'tft' to 'TFT'

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@yulong.com>
---
v2: use full name.
 drivers/staging/fbtft/fbtft-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 4f362da..44e7acb 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -775,7 +775,7 @@ void fbtft_framebuffer_release(struct fb_info *info)
 EXPORT_SYMBOL(fbtft_framebuffer_release);
 
 /**
- *	fbtft_register_framebuffer - registers a tft frame buffer device
+ *	fbtft_register_framebuffer - registers a TFT frame buffer device
  *	@fb_info: frame buffer info structure
  *
  *  Sets SPI driverdata if needed
@@ -873,7 +873,7 @@ int fbtft_register_framebuffer(struct fb_info *fb_info)
 EXPORT_SYMBOL(fbtft_register_framebuffer);
 
 /**
- *	fbtft_unregister_framebuffer - releases a tft frame buffer device
+ *	fbtft_unregister_framebuffer - releases a TFT frame buffer device
  *	@fb_info: frame buffer info structure
  *
  *  Frees SPI driverdata if needed
-- 
1.9.1

