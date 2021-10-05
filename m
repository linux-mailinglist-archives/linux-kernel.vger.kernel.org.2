Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8603442317D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 22:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhJEUTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 16:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhJEUTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:19:09 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987B1C06174E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 13:17:18 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id i132so270901qke.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 13:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eQmPLWNW1IY5/Dg8Jm1l2vIuP9swkD1cu5LVox+VT4I=;
        b=PNG/pldsxqYbC9oCx2hEVKGUetySKmV/9Gw5YTbs6ImYpuZV8+B9ivdI7fNC+s7is6
         dkgUaOx4eJ6MENUZXVL1c1AWcx/FnzYqboM8ukXUWAHJ6lwM+Z881ND/uzP6cyD8ndsh
         ZPQUWSvztxr7OLcpPsncd35F5J3pib9WxpQteQt1cfRpuLgeyx0gJLRQlZNU699J51j2
         iCjjM8mZS3vJzwaN3ciThL/MMQ3KpdvM0gjEjMi+86Kh2O20GigaX11Lwbr6guwONYJ2
         HsXAbZbcRJGj8RMFUVyHEpqgnSmNxdZks0TideI1PWkfNGQqukuKVmg23OAvUotkiHV0
         8VlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eQmPLWNW1IY5/Dg8Jm1l2vIuP9swkD1cu5LVox+VT4I=;
        b=6q4ELWInbe3+41P+kltEoZY2/aW5nEaPrGozL1AXzzyMSxiKg9E2WhrXQ25IHdcF50
         b/UXW7g77H3X9NQ7VtZpUp1pUyzqOJyZxEWN5Rk1q/r1PuwaZeWl9iSZQepMgEt7eSTz
         dogrhZyAodHUoqmemWy4FFGcjpHbe9R7g8MT0QAXUJVLzFDowxEG9td0HmZmz2JYSIvM
         zRFNSioQCBfs3WpKW1zQQ+e9WS36/49DAkiyoNjrliQCSPmoo2xHh1O1ZHoqY+1ZFSVq
         LholKc+7vw3k9+Hq3xF/tTUAsL0q5rVCz/uoEyt6vcsloL4KGh27IcoNnYuSl8fqqsO7
         N+2g==
X-Gm-Message-State: AOAM530SdHuYMhDMOxrgYWKzPg9b2+UnPX66Pnhoc1THoZpOYJZNhk1H
        AT88lTeNn0Z49z7KFqZtUquwrPStgNJjpg==
X-Google-Smtp-Source: ABdhPJyS7pMg5Ied1Xw4G/llYOv2jaR5rl91JrAI1AzrWW/achNjVkFSaUGyiz7TZ/j3+ASMPZdgdA==
X-Received: by 2002:a05:620a:49d:: with SMTP id 29mr16626521qkr.518.1633465037876;
        Tue, 05 Oct 2021 13:17:17 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:125:9b98::1007])
        by smtp.googlemail.com with ESMTPSA id j2sm13056905qta.84.2021.10.05.13.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 13:17:17 -0700 (PDT)
From:   Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
To:     rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com
Cc:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        hamohammed.sa@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        contact@emersion.fr, leandro.ribeiro@collabora.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Subject: [PATCH 1/6] drm: vkms: Replace the deprecated drm_mode_config_init
Date:   Tue,  5 Oct 2021 17:16:32 -0300
Message-Id: <20211005201637.58563-2-igormtorrente@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211005201637.58563-1-igormtorrente@gmail.com>
References: <20211005201637.58563-1-igormtorrente@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `drm_mode_config_init` was deprecated since c3b790e commit, and it's
being replaced by the `drmm_mode_config_init`.

Signed-off-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 0ffe5f0e33f7..828868920494 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -140,8 +140,11 @@ static const struct drm_mode_config_helper_funcs vkms_mode_config_helpers = {
 static int vkms_modeset_init(struct vkms_device *vkmsdev)
 {
 	struct drm_device *dev = &vkmsdev->drm;
+	int ret = drmm_mode_config_init(dev);
+
+	if (ret < 0)
+		return ret;
 
-	drm_mode_config_init(dev);
 	dev->mode_config.funcs = &vkms_mode_funcs;
 	dev->mode_config.min_width = XRES_MIN;
 	dev->mode_config.min_height = YRES_MIN;
-- 
2.30.2

