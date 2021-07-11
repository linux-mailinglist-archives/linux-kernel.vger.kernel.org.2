Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5163C3ACF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 07:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhGKFxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 01:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbhGKFxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 01:53:03 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C820BC0613DD
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 22:50:15 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id w1so13518057ilg.10
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 22:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RfbJyI1hmWPmulBvGl9yUX6sBfIUZuE+x/+Sb4PBAA4=;
        b=SXT+D1muNKI5ua6xuLy01IsiNNVAW/YwLCA/6pZSNl3BxgwBTBJS/ttTdjZmCvnJpV
         HeVS4rz6vpLq1rnZYVign5Ki4DWPILRyLnAyj2C9Z2+ew7+Jfle1uTXLyT13PLR93hTX
         2k7vxOOI4O7Ves/z5rJSFzJSbuS48hkXzcgCSBPmB7rg/xaRrNO4lPeXVo1wAosjQpfk
         hOBKnog3cC7liGBlJYDZQDsxObcSild+pPv2h3c2j7jChmXC0WAfUPg4EHR6jVQmEcoK
         BuQPUsgqUSvJHvqIifVSfyEpQ9ainHbC61tQstR9Q/ZRMEvnwIF/IQZxvJRUCBDduyfB
         nEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RfbJyI1hmWPmulBvGl9yUX6sBfIUZuE+x/+Sb4PBAA4=;
        b=oRknS6gV0JvPXiJVHOif4qQW8TFARs4e/HW1/nKxPruuSW6oJfwSLMXRVCbP8Pu5nI
         NwB9otS6bd9hkfnTAFmNtiqbV6NouVW4PNJx6RWsndQyProDZ3chQoy9+nNGdLJrEOfu
         fSvRg/TOIxU2hEyNglN++9rkqlpVbeCiElpf/VSq/lZU6K9Vo4ML+PWJjGWSRzVAet39
         9gkt5IEYRrwkYAnBvXwBoX2VYasZ01UaZBLFrRW9vlsWv/aqAvsi27pVnREFnlh6sEJC
         uo+NRQgiuE3AN4QHvTIkXINa+oj1RN+2cM5CZsx+cGNX8TBXpS5R5KY4EB4qKqDvhDkb
         hDVA==
X-Gm-Message-State: AOAM533qGF19cVrqHSP1a4TiJg6pnpMG/XVK/RMsDytS17yIYHYw8GDG
        RkXSXa9dcIJlKxTJPQInUSo=
X-Google-Smtp-Source: ABdhPJyxtqN38rozSDK3IWdzykjn6Ccg7cUzlLWdkk2kwWLYPIouP4b04xGQtDsPOJHTknN7CO1dDA==
X-Received: by 2002:a92:c56c:: with SMTP id b12mr33675200ilj.13.1625982615280;
        Sat, 10 Jul 2021 22:50:15 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id x8sm5852400ilq.63.2021.07.10.22.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 22:50:14 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jbaron@akamai.com, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v2 2/4] drm: fixup comment spelling
Date:   Sat, 10 Jul 2021 23:50:00 -0600
Message-Id: <20210711055003.528167-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210711055003.528167-1-jim.cromie@gmail.com>
References: <20210711055003.528167-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/prink/printk/ - no functional changes
---
 include/drm/drm_print.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 6419b4e7c5dc..4559583bc88b 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -327,7 +327,7 @@ static inline bool drm_debug_enabled(enum drm_debug_category category)
 /*
  * struct device based logging
  *
- * Prefer drm_device based logging over device or prink based logging.
+ * Prefer drm_device based logging over device or printk based logging.
  */
 
 __printf(3, 4)
-- 
2.31.1

