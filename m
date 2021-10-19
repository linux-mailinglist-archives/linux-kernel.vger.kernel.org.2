Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2CA4331C7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 11:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbhJSJE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 05:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbhJSJE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 05:04:57 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754D6C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 02:02:45 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id g184so18733813pgc.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 02:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sW5kzqI2ZLlgm72jV9aPPdFKNC889wnGZx9L6y3GNDE=;
        b=KQ6KKZrilTzlxQ5KkvqlvnbNQ/cJxM54GDqV4uxqzpBbCnSiHHjsgyu7ZqkvO12KPf
         uXVbkuTWMPodLFMAAM4pzZApcjfjUIj3lcRn3R9nX8Wx7UNRtXUcHaD1Cy0ikOksTAsi
         QB79kgXcaIdeJ2LEgdh+riEPU4/GUN98aUzchgmRJvakDLi89c6yVA2WpJ0cYxS6XA19
         G94hjk/Ay8IcRUV/tQav7P/AQNxN5tE/E+Y+J4rOT8oWdAH+q2KVtkHVCgnS4EUhq6LI
         uWt5500ppG1B5lgc+XqWt9oe6XbochwNDiCvhEXC5fmhErRKIobuJXptWKZybloQ18+C
         P7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sW5kzqI2ZLlgm72jV9aPPdFKNC889wnGZx9L6y3GNDE=;
        b=evBLAb3TK6ITle5yqGnSHI06yiFO1lJwaijIPXyCHM7ptFtSjmN0ypmrbf7jEvAOoh
         Rb2EocPrWYDsYJS52uor4q0aE0y9ccj9m80jwEtGa9xxg8gkPBO1Pene1/7KRFZE6SE9
         4e3+Mffi+FyjbnQ9qJCimLf7k87V2/f8NUn3aHJXNNz3zQUYg8EFJVST03Sm0tblRogB
         yEEp9zN1+o0sLuoBPrpe5SxiBecfty0HBwQsTdyrBYdwFJdVZmk2fND34qOAsIzz8wSC
         unpXYRguW1h0BDDFby9Ucp4bgi+C9xk9hkG4u4zzhV6QvuBPlY1AFTYobvn5P4umuyrX
         sCjA==
X-Gm-Message-State: AOAM531KNOgNAuJL91wO1lHYTTvhDlpRgICt7yLxXZOO4GIHb89X2ORg
        oCK6WCrB6sT6rJyEtD7ZXQU=
X-Google-Smtp-Source: ABdhPJwUfkoqRsVd+CCYM8ak6IRF7IftK8GgqFupS44n7zlu7KDBI56oFbj2TEQOPZQoPwy/mwU7DQ==
X-Received: by 2002:a63:8742:: with SMTP id i63mr16229969pge.328.1634634165079;
        Tue, 19 Oct 2021 02:02:45 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s2sm15184610pfw.30.2021.10.19.02.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 02:02:44 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.jianping@zte.com.cn
To:     jani.nikula@linux.intel.com
Cc:     joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, matthew.auld@intel.com,
        thomas.hellstrom@linux.intel.com, chris@chris-wilson.co.uk,
        maarten.lankhorst@linux.intel.com, ran.jianping@zte.com.cn,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] remove duplicate include in mock_region.c
Date:   Tue, 19 Oct 2021 09:02:05 +0000
Message-Id: <20211019090205.1003458-1-ran.jianping@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ran Jianping <ran.jianping@zte.com.cn>

'drm/ttm/ttm_placement.h' included in
'drivers/gpu/drm/i915/selftests/mock_region.c' is duplicated.
It is also included on the 9 line.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Ran Jianping <ran.jianping@zte.com.cn>
---
 drivers/gpu/drm/i915/selftests/mock_region.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/selftests/mock_region.c b/drivers/gpu/drm/i915/selftests/mock_region.c
index efa86dffe3c6..75793008c4ef 100644
--- a/drivers/gpu/drm/i915/selftests/mock_region.c
+++ b/drivers/gpu/drm/i915/selftests/mock_region.c
@@ -6,8 +6,6 @@
 #include <drm/ttm/ttm_placement.h>
 #include <linux/scatterlist.h>
 
-#include <drm/ttm/ttm_placement.h>
-
 #include "gem/i915_gem_region.h"
 #include "intel_memory_region.h"
 #include "intel_region_ttm.h"
-- 
2.25.1

