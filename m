Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7307F3C8A24
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 19:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbhGNRyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 13:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239800AbhGNRyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 13:54:41 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96107C061765
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 10:51:49 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id r16so2425876ilt.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 10:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kmHsDnFQwSbOnRKSJ1vga0OhlV8P3CEw6FanKWDIy40=;
        b=H5XKgKLd+5dNWlW4hslIS9sT6Tl0O9uPJSZG6JlbzSbTp8sfCUAcF5hTY17SdgAg16
         UAjvuNJNKhlyj0b/AR6YrMwu7au1Kby9I15cpkByXiIz0+LgYoSe8QUwBjHov22V4c2Y
         lh8yWDoqVh/G31tKpZnHRkhfB4cAHDIa1tD9aSW4TMsv6EuyNWCzOppPQMhnU4Ex9SAy
         +HDu+F2WMF0uZlbj8/lBgFAlf1eGrD+scMsHvmKmqKmI91W7qpieVZUvJBqCuoA82rps
         j++6fkbjU/il82DYJZZ7zy1y/f45uZImCEgiLqWj1l1fppHeff/BGcKpvzcfwmZGWyHa
         kN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kmHsDnFQwSbOnRKSJ1vga0OhlV8P3CEw6FanKWDIy40=;
        b=gGZSTb+EzD2+gOdsy9XzBNEyu0skNyIQp/lORhVDTS0uMzD3fLGs8d+gFRWekkQJ75
         /PmVs57BdFTP4ra0IdIXzMt81NnK2aWrRHF4iDrYQYw9DRR9AYsmfn6NzooNIcmzknsf
         1ucibRjq2rbKrRn8Fd/B58sH6UlgSrdgppPxd5uxqyDROB9MRdmp7cK1Zw2Qib0kTcM/
         Pmvc7CdRrEiSrAVBrWA0U+pO9X1wS04YhdxzJ/eKrOTdJj8iJnyG10agqsqd0FdnSaAa
         aYLAddiTx0WQqgSLJNffc5RKd5ylPHTApWaDn8+rpgyZCTg5aApwYg1g4kh5jWbimCCM
         lttA==
X-Gm-Message-State: AOAM533DxXsLQ9T/QnNKFcCcCBh6526vKWCggGDop1CycMnmyJeMDh/g
        BzNJDxDZBJT21c/PZzJGV/k=
X-Google-Smtp-Source: ABdhPJwnFyiXb5DSNrcbdKnFIwb4qm5Xoi6BJ/1l3+bhS1x2qHPAYTt/JDpQ17FPwFLGkzaswqqP1A==
X-Received: by 2002:a92:3207:: with SMTP id z7mr7507025ile.288.1626285109045;
        Wed, 14 Jul 2021 10:51:49 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id b16sm706518ioh.5.2021.07.14.10.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 10:51:48 -0700 (PDT)
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
Subject: [PATCH v3 1/5] drm/print: fixup spelling in a comment
Date:   Wed, 14 Jul 2021 11:51:34 -0600
Message-Id: <20210714175138.319514-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714175138.319514-1-jim.cromie@gmail.com>
References: <20210714175138.319514-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/prink/printk/ - no functional changes

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/drm/drm_print.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 9b66be54dd16..15a089a87c22 100644
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

