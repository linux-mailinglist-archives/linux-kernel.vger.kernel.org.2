Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7CB043C18B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 06:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbhJ0Ejr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 00:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbhJ0Ejo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 00:39:44 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB6BC061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 21:37:19 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id 3so1598830ilq.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 21:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mbanz3Hfm4S/C9DnDL7HTgcmeqSrMpcM5u5NhVQnBuE=;
        b=Z/MaaooGp7lzUsGLHzuh2gY0APQLsFpOF8gA2aeDSPAaRs9W7u7HuQM7JpCUorWKYs
         L9owXMrWUAQ9tUulXc81Do4d+/ZkiFmNLxHm3palrm9RVy3bIAdX8HZ014oLzTAIinZa
         2Iv2r0dH3Ch2WIP0V6PgsEp43lMxfWwTIHI9/bnSdIgKUKGopiIqjMz+Iro8XN6O1opC
         jvtkCkDoBpFKjlUqXZIyH4d6FsPmLEleinkbnbwSupZgZchrCKnb2Ie+VWqPg2G+WA/a
         rofPic+6gng8QebgbST0YhM5fRKtPEstfpscWEA/I8Mz0SqBqXaHrs9SgoTKQJiPhml/
         E3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mbanz3Hfm4S/C9DnDL7HTgcmeqSrMpcM5u5NhVQnBuE=;
        b=sZNdQkMz/1U8mW8P0sDhBZ1d8OkmcBbUL2htAJBYnLYg0bEo3O3EglAbp2q9+qdGcg
         aGIRo6+cgJKYWZHCm1P3pYTvujXjMJZhuGi/Z9Yw7dqx7Dvyj/6G0rrCcTwNJwgcJ08a
         LfsO5+qrCdsWhWymrRbMl03056LhylsM3JiVqmuWixC9H5sjayZClxAE0vBNm3A8mKr8
         UVuOFLyoZDan5Ig7f/6ll2mDQ0lYTQyNxaVjoypZiZ10Oz3cljVFvUB7i9xIzFGt5o1M
         xqhywy2Ac2hUHXu4mHVnG4UqshDqqnaXE4oV8UXMJfWFP1onvcFfIQPJ3ubd0Eo8FRM6
         jfxg==
X-Gm-Message-State: AOAM531hBZ74XIafDposuIr4ZVF8QtMKWJJoDxnc4Yhk7vt20WZvrDSU
        mQctvYDftIzFIf2+dBnK41M=
X-Google-Smtp-Source: ABdhPJzCjWJBO6TwyGKAzlLbv9h8AD95jezLmysBiRrJ7HXztnBlPBjVYeiF2M8DYLy9h9ZbJ7F8zA==
X-Received: by 2002:a92:ad0c:: with SMTP id w12mr16778504ilh.20.1635309439031;
        Tue, 26 Oct 2021 21:37:19 -0700 (PDT)
Received: from samwise.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id a15sm2030404ilj.81.2021.10.26.21.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 21:37:18 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9 02/10] drm: fix doc grammar
Date:   Tue, 26 Oct 2021 22:36:37 -0600
Message-Id: <20211027043645.153133-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027043645.153133-1-jim.cromie@gmail.com>
References: <20211027043645.153133-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

allocates and initializes ...

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/drm/drm_drv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 0cd95953cdf5..4b29261c4537 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -486,7 +486,7 @@ void *__devm_drm_dev_alloc(struct device *parent,
  * @type: the type of the struct which contains struct &drm_device
  * @member: the name of the &drm_device within @type.
  *
- * This allocates and initialize a new DRM device. No device registration is done.
+ * This allocates and initializes a new DRM device. No device registration is done.
  * Call drm_dev_register() to advertice the device to user space and register it
  * with other core subsystems. This should be done last in the device
  * initialization sequence to make sure userspace can't access an inconsistent
-- 
2.31.1

