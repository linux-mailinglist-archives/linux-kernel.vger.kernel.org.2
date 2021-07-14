Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117C63C7C1E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 04:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237728AbhGNCyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 22:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237664AbhGNCyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 22:54:31 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DC0C0613E9;
        Tue, 13 Jul 2021 19:51:36 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id h19so1115203ljl.4;
        Tue, 13 Jul 2021 19:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kpbizncc7+SuJBG6C71TwiHiHc9sZLjNv469fqOByg8=;
        b=GRRjGYOZBjod34rUbjtJ3wV1jEinBlHDr0TGip0ybClPKEazc7krPRLyRck/mwIvB4
         8pho6I7H2HwEVAU3SEdNr5kDlDk3tx/rrTheUpIbaJHprh7mSahlQRaKYOmo7vLSAzF4
         zJAG5wAxf0ccnJ74YZ/qsNmaqHz5+shBQHyS4P4BoEDeqU0VN5Gv9TKVlcxyF8xpI7GL
         w14321EYYUcQ9y/GiV2a3psBrnGIO+r4mkV0tFyzXEmkuiZz4LR6AU4E9P9As5VxUwj1
         BFUgtEoBsifyweLQmhyszxNaazWnIXo1Q+TJOoDml7WdGd+wi1yc8Py81HcNd23xlgrU
         brgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kpbizncc7+SuJBG6C71TwiHiHc9sZLjNv469fqOByg8=;
        b=tydSJMQ0Q0T1AJOSH9UzUm9NcNl+Li7K588Gwzmdzg1cJOdhtxBKi45ZFKRHXZixas
         XibBXgz9Qj1FBiaEUVxs0rJ26xBxtoALOOiCUlhDoUhF4sFKkNn3Oz3Z3UDv04behEnV
         3ldNJL980Y/0uTJXTCHbFx6oytW9+PDfsAx0Lmp2ylseENANV/b39YB8EKETpGBc31Tn
         4ok39yQvZjB6ZQyvMvJXQY4iEJqKge+3ydTjtezbeHpHOxEUQfWm9nbxgq8Qv2a6uOhy
         kqPtim9UmrB2+kvbrEAYzIxLgV4z/a0VBYT9wEiLCKEB0cxc6qF1W1V26QmZOnVBjZBn
         P5rg==
X-Gm-Message-State: AOAM5311DxS6QP3dXbq17uNH3pw8X3O9SVkC5Ix4CHPwtBwV91/LAsZM
        HyQPZ32f4jqJOqo5Zz2MuyI=
X-Google-Smtp-Source: ABdhPJzHZhbUNUAqLvKekablIWhJGlJkNT4wsjFOe8BeX0qwWQWPd0+5eZqDgUFGUSROm7IKlXLD0A==
X-Received: by 2002:a05:651c:c8:: with SMTP id 8mr6771649ljr.334.1626231094693;
        Tue, 13 Jul 2021 19:51:34 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id a10sm50281lfb.93.2021.07.13.19.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 19:51:34 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 2/7] ARM: tegra_defconfig: Enable CONFIG_FB
Date:   Wed, 14 Jul 2021 05:51:22 +0300
Message-Id: <20210714025127.2411-3-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210714025127.2411-1-digetx@gmail.com>
References: <20210714025127.2411-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously CONFIG_FB was auto-selected, now it's not. We completely lost
framebuffer in tegra_defconfig. Select the CONFIG_FB to fix it.

Fixes: f611b1e7624c ("drm: Avoid circular dependencies for CONFIG_FB")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 63e7f3261e6d..ced01b114cd3 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -209,6 +209,7 @@ CONFIG_DRM_LVDS_CODEC=y
 # CONFIG_LCD_CLASS_DEVICE is not set
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_PWM=y
+CONFIG_FB=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
 CONFIG_LOGO=y
-- 
2.32.0

