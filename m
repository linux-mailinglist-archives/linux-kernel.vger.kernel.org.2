Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D5138AEE3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242969AbhETMrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242517AbhETMn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:43:56 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE2EC05649A
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:03:13 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q5so17383845wrs.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dzEKHJu7OFwu6XLDUaDLxDd4w/v+Udk50uYERKk06w8=;
        b=akXNjOoWI+hd9MtdjEd3PDOoyWFJFQqHYHLes7Q/ANFm6XOCR8E5Cujfd2BlPcBXCJ
         C3YQiJErJHlF0iiCtQSDwYs4ICfqx8+8BRPLBFZnIoPK3c0o/YXhMgTid38JyROYm/Vo
         teMr/RuOODaLYuS6h3C46IBLgzrTnsodcGqrjjrXvOrTzmRU6NoLhk6W3BhXiVTACjp8
         jyK92zW0AYM7tqwKFCElGatYODSlzWHsVPJIox4VcBOVAKulRUxCE1MhQwL16a6CszDD
         7yoZj+SHj4mtjkv1Id4QNGOSta7CCCLMZ9DdAYN154UEh2+GSkR27h/PMlGz9jv3heXo
         P0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dzEKHJu7OFwu6XLDUaDLxDd4w/v+Udk50uYERKk06w8=;
        b=OyXJ+8QH2qAnwIuJjv/JcAFhk7AfVDUDhe7KnwNLxRLQBwJLkGoDesc6KSb8aqrZVp
         aAvcnljbdiZGUqgnRLtKfGV300GsYAdNtdi5Ge6MNhzmaU2y8VoxWq7QzUZidllM26XI
         e8bLj0xU9vDHHIJOxvP18p1E9iBBemy/U7K+Kf46+F0PjIb652nZufwkl76uCF7VKKe7
         lPiAwjvK0UJy8+KvsSIRlBHESM90M/jDrLLjKpptiOGYJpMmK49JEkU9MyZpVvk+Hlz5
         zukRZGWthegZU4P72VkCJasRX2OYvn9AF7Eg40OXRh9ju8acv+WWrmjABfx2UYtQSFmc
         F5Fg==
X-Gm-Message-State: AOAM5330guNujwS/aJNhz9sfErLGiSalMEaApe+9w5PXVZVaZ8tzN5fl
        QBfvMhySu/Lk77rXxyJONLYHQw==
X-Google-Smtp-Source: ABdhPJxIY7yv+rgs4XU+BqyHdRbSGkXegiiRFWqmNpb2diUp8p6mFeKESLGtV9djEkTEbXFrm/ADbQ==
X-Received: by 2002:a5d:4408:: with SMTP id z8mr4009264wrq.2.1621512192604;
        Thu, 20 May 2021 05:03:12 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:03:12 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 20/38] drm/radeon/radeon_vm: Fix function naming disparities
Date:   Thu, 20 May 2021 13:02:30 +0100
Message-Id: <20210520120248.3464013-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120248.3464013-1-lee.jones@linaro.org>
References: <20210520120248.3464013-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/radeon_vm.c:61: warning: expecting prototype for radeon_vm_num_pde(). Prototype was for radeon_vm_num_pdes() instead
 drivers/gpu/drm/radeon/radeon_vm.c:642: warning: expecting prototype for radeon_vm_update_pdes(). Prototype was for radeon_vm_update_page_directory() instead

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/radeon_vm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_vm.c b/drivers/gpu/drm/radeon/radeon_vm.c
index 2dc9c9f98049b..36a38adaaea96 100644
--- a/drivers/gpu/drm/radeon/radeon_vm.c
+++ b/drivers/gpu/drm/radeon/radeon_vm.c
@@ -51,7 +51,7 @@
  */
 
 /**
- * radeon_vm_num_pde - return the number of page directory entries
+ * radeon_vm_num_pdes - return the number of page directory entries
  *
  * @rdev: radeon_device pointer
  *
@@ -626,7 +626,7 @@ static uint32_t radeon_vm_page_flags(uint32_t flags)
 }
 
 /**
- * radeon_vm_update_pdes - make sure that page directory is valid
+ * radeon_vm_update_page_directory - make sure that page directory is valid
  *
  * @rdev: radeon_device pointer
  * @vm: requested vm
-- 
2.31.1

