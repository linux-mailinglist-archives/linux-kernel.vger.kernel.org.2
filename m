Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4BD341773
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 09:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbhCSIZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 04:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbhCSIYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 04:24:49 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C904BC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:24:48 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u5so8273153ejn.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WQfVByDMubjxteIKJEZ6P0NR+Mqv9ZNp4le53NfYrp8=;
        b=J7cBZga0HMi5iG0MBUZwq+qeZQWVYjaTEHrLyI9EUXYAQUPVTL0uLJnF3hBzdX6FIZ
         zVDwtYg3IT40ZqvObqkEA8SNak/MrlukLTeG32vP1M96twbR8MtsqufK1UIcwXfHjPnf
         2K2NJB8UHPugVxfg2oMC8GzczIRdANNmDdg2XqMK818eM2//X328KiyDO7xyh9o5sT97
         AVlqyCAsqbSQExSIbVOBgEbA2EI0WzjnzOjiCajnhzQV+qLA9KIaQ4PwZMgJ2JIrY1fl
         E9nJBb0VkUxHN0WG8ArEkjbhDPTOX5KTCOPJKYwk5PgIhndI2lYcOv2kun1XLWJgjxjS
         bn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WQfVByDMubjxteIKJEZ6P0NR+Mqv9ZNp4le53NfYrp8=;
        b=Tbht+uyREIxiHHoBuzicMPiJc4zotBdG75oXAXtQa1SX2Q8hLJKWWr+Zwi7jg2tawy
         QSzpD3dAdOvbJoWVNQYJLbrnhP6PqGOIe97DlK5kyAEluuzVMnIYuCvHPoX9yTRIC8P7
         k7gJMDX7uPs/1nGYQV8FnoY5wEQ1hQo4eOV8V8TV8Ll7U8sU1y/X+pp37i6JtPK4/Z+0
         3ahuOxwROONOtV+ozrDwoxx9WO89xOMJDqje4q0nJlhUqWtH+2MYY4lzbBInJPSsW9Pj
         e06EBnrL1FNkbWI3KmiGnhUi7v1mGlUHaiuWh731w2acpqJ6wEHXGGeB48Hy3bjCVJQ9
         d6OQ==
X-Gm-Message-State: AOAM533Y1FwoVnaunHgHAEBo0FXiY71SAAlSh6YRdWpcf57sPqLqYREc
        5lBLaoSW0fVSSE7HiYUmMBQi7A==
X-Google-Smtp-Source: ABdhPJx6jKnRq5nqPpVdA7aCaWOhgT0WB+9GfElNE7osCoFYtIg0/X6xNmLS5P73xbTCg6pNXGlfOA==
X-Received: by 2002:a17:906:f88a:: with SMTP id lg10mr3078558ejb.39.1616142287621;
        Fri, 19 Mar 2021 01:24:47 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id b18sm3273727ejb.77.2021.03.19.01.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 01:24:47 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 16/19] drm/nouveau/dispnv50/disp: Include header containing our prototypes
Date:   Fri, 19 Mar 2021 08:24:25 +0000
Message-Id: <20210319082428.3294591-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210319082428.3294591-1-lee.jones@linaro.org>
References: <20210319082428.3294591-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/nouveau/dispnv50/disp.c:2599:1: warning: no previous prototype for ‘nv50_display_create’ [-Wmissing-prototypes]

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 828f48d5bdd4e..cd16431422198 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -68,6 +68,8 @@
 
 #include <subdev/bios/dp.h>
 
+#include "nv50_display.h"
+
 /******************************************************************************
  * EVO channel
  *****************************************************************************/
-- 
2.27.0

