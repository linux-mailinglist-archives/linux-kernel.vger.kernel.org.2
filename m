Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DAE32BE81
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377106AbhCCRbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444839AbhCCNrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:47:05 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B7BC061A31
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:44:02 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id v15so23747574wrx.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XZmI3Pr1jHFtcMrfTt6XXf4g0zv3hzYPvnP4OKNbsog=;
        b=yV5tYX7sM66C63eujllHcaOJ32XhnRuSYM/2ysLql2AqOw+0JFFtYrW1BeMOOIHrZ8
         2UxRh0GBKyBo386hNVibHh13wK44EFoEUJTGtQTp9oqSnU7fby17L706jr/Wf3ztNjYM
         e0evuYs/GWXlUByzjSYua4Tix9Hu9A1wpB1z9zkkMtLkCPj9GJB0U3Y9GzJg0G0GTUFv
         zY2ExaVCmrwe0zXYkSET4B5WBIYN3G8+2iTBnc/2WURR17wbrq2tlLA6QGo9PzSCUQka
         8MsbRoPLLrgWQvdGQr6UxayoAfr/mFvceRlGPzYb4pD9Hkm/WG0C4bvaPHLmwj9wJS3F
         I1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XZmI3Pr1jHFtcMrfTt6XXf4g0zv3hzYPvnP4OKNbsog=;
        b=Xp/M/3Fugtsd7hZH51LxReKN4l5MPhln2838v5ksCia+q4kva3Skx3oRHA5YrijnyL
         LiRSs4RHzdNPgnxrn/bwZUlSzhKxaztTYjkaVqIPb6bT3vk4FOejtnrzm1e0hUNLr5SQ
         NY2/PdJeePhRRxKnkCYVXHzTnnxuprGdr5YVjWhW7TWYTHnPtKy4zlWsmG+NyiEozlXf
         +8+mjz2sjDJ2AEL6RMWSeCe9N6UrYbzLEaWyYZ4Rq4TIfxxZOZEIXrcaojXRzULj6i7h
         P+20Y1sU+xLMpv0YknLU5Oh40DVh+XLH/ovCzrUtj0JKQPk1ASGeh0McGcnJPwp3unxu
         nXsA==
X-Gm-Message-State: AOAM530P+hDT+r05z8jYSo6B1Rr9+wlvI0dycHBcD3SvlgubqIvNgeBp
        D9ZWbWW3zVqxFy6XPszo5pNBUw==
X-Google-Smtp-Source: ABdhPJzL6t/K2FE9rWW+xuELLulwr2MIoNYvIh8upvVA3qbwZ8TmosW+CD13NqnCN6jab6u9DAhE9w==
X-Received: by 2002:adf:a1ce:: with SMTP id v14mr27677100wrv.228.1614779040787;
        Wed, 03 Mar 2021 05:44:00 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:44:00 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Zack Rusin <zackr@vmware.com>
Subject: [PATCH 27/53] drm/vmwgfx/vmwgfx_ioctl: Provide missing '@' sign required by kernel-doc
Date:   Wed,  3 Mar 2021 13:42:53 +0000
Message-Id: <20210303134319.3160762-28-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c:30:
 drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c:448: warning: Function parameter or member 'offset' not described in 'vmw_fops_read'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Zack Rusin <zackr@vmware.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20210115181313.3431493-10-lee.jones@linaro.org
---
 drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c
index 80af8772b8c24..b36032964b2fe 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c
@@ -437,7 +437,7 @@ __poll_t vmw_fops_poll(struct file *filp, struct poll_table_struct *wait)
  * @filp: See the linux fops read documentation.
  * @buffer: See the linux fops read documentation.
  * @count: See the linux fops read documentation.
- * offset: See the linux fops read documentation.
+ * @offset: See the linux fops read documentation.
  *
  * Wrapper around the drm_read function that makes sure the device is
  * processing the fifo if drm_read decides to wait.
-- 
2.27.0

