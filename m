Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66FF238AF2E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243248AbhETMwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbhETMvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:51:14 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14681C05BD0A
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:14:07 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j14so15689114wrq.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n0j4QPlrS1ESzXZisQzsHyGnB0Eut3683WWFc4CZXvQ=;
        b=aNJoVpLJ8pUG4pXKVSaZhoG2vadFU/XYie/f6RhMNlJ2DCgfq5O0rmf2R7/4IK+W+f
         +B8LoXRlEz8k/DVZNkC30uqGq5oOzk7fSJf6nSkRkOJ2WENfwNePhrhKDPIkw6/O1Nc4
         4JcFkewU4vkOQHnPRlacrC8wviXUwq145SLBu0YMnDN4Kwgm8aIz3HEAQbehuuSsI0bp
         vkWxLgaSQ9yrZzND94i7gFs+UF0A+uWJcU+MJK2j4Zb+/W6KZV/xa9zHJA+Us9wHeCMi
         EKx5HjNhicj39eBgoGqwkCFtRfY4LiEzL3d7rkfiIY7vwDnx9T2HJBTVBKARf5nOOOtk
         MdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n0j4QPlrS1ESzXZisQzsHyGnB0Eut3683WWFc4CZXvQ=;
        b=ADYumEXZ87saw+9ffeAP3pNk01dYEWAufWRoh67POJdN2/3Tpc+o5RPCvqjucrCQbJ
         jTjlW9OHnzoP4DaWHu8A0cM00u53T1ZHoMGW+2TyddolpkuPuRBdZXLD4/hYCRh4oAtA
         F56YgwS/UoyRwXWaqWdLIq02T+lX2C2xQ6xmtfDR6BGh/wuPKtI+PlIjPphvmI9ci8Bt
         k9z2VqYPy5PqszMoWIUDRjkc3phwqNUzZQ2yZ+sqnPXC/jljSWjJ3zj7uGgpsJRkoPSC
         sPFk8TQBQPkpk0rVuWLWpmzu+uh/pjZUV/P+oUOqZzfIMpTjHhlbUcpS7ubCjQLYHvw5
         MOFw==
X-Gm-Message-State: AOAM532SyUu/81J2p719aDNVdCHM3COBKNoVEhumCA07FFpMiUScY2dX
        o+M8LISdBV2Up1S8LsiZQjjibA==
X-Google-Smtp-Source: ABdhPJwqwrsh8kXji8cwb4TcTSrH+cvbGq2XShUk3SWjvc4H3tdnTNx6GSqx5vVDZ9IedpFzlWWNnA==
X-Received: by 2002:a5d:408f:: with SMTP id o15mr3838654wrp.89.1621512845709;
        Thu, 20 May 2021 05:14:05 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id 61sm3393704wrm.52.2021.05.20.05.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:14:05 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>
Subject: [PATCH 10/16] char: agp: frontend: Include header file containing our prototypes
Date:   Thu, 20 May 2021 13:13:41 +0100
Message-Id: <20210520121347.3467794-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520121347.3467794-1-lee.jones@linaro.org>
References: <20210520121347.3467794-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/char/agp/frontend.c:46:20: warning: no previous prototype for ‘agp_find_mem_by_key’ [-Wmissing-prototypes]
 drivers/char/agp/frontend.c:161:5: warning: no previous prototype for ‘agp_create_segment’ [-Wmissing-prototypes]
 drivers/char/agp/frontend.c:213:26: warning: no previous prototype for ‘agp_find_private’ [-Wmissing-prototypes]
 drivers/char/agp/frontend.c:268:6: warning: no previous prototype for ‘agp_free_memory_wrap’ [-Wmissing-prototypes]
 drivers/char/agp/frontend.c:274:20: warning: no previous prototype for ‘agp_allocate_memory_wrap’ [-Wmissing-prototypes]
 drivers/char/agp/frontend.c:486:20: warning: no previous prototype for ‘agp_find_client_by_pid’ [-Wmissing-prototypes]
 drivers/char/agp/frontend.c:511:20: warning: no previous prototype for ‘agp_create_client’ [-Wmissing-prototypes]
 drivers/char/agp/frontend.c:524:5: warning: no previous prototype for ‘agp_remove_client’ [-Wmissing-prototypes]
 drivers/char/agp/frontend.c:735:5: warning: no previous prototype for ‘agpioc_acquire_wrap’ [-Wmissing-prototypes]
 drivers/char/agp/frontend.c:778:5: warning: no previous prototype for ‘agpioc_release_wrap’ [-Wmissing-prototypes]
 drivers/char/agp/frontend.c:785:5: warning: no previous prototype for ‘agpioc_setup_wrap’ [-Wmissing-prototypes]
 drivers/char/agp/frontend.c:865:5: warning: no previous prototype for ‘agpioc_protect_wrap’ [-Wmissing-prototypes]
 drivers/char/agp/frontend.c:899:5: warning: no previous prototype for ‘agpioc_deallocate_wrap’ [-Wmissing-prototypes]

Cc: David Airlie <airlied@linux.ie>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/char/agp/frontend.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/agp/frontend.c b/drivers/char/agp/frontend.c
index 00ff5fcb808a7..10186f5881cb9 100644
--- a/drivers/char/agp/frontend.c
+++ b/drivers/char/agp/frontend.c
@@ -40,6 +40,7 @@
 #include <linux/sched.h>
 #include <linux/uaccess.h>
 #include "agp.h"
+#include "compat_ioctl.h"
 
 struct agp_front_data agp_fe;
 
-- 
2.31.1

