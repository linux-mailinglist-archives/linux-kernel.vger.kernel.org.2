Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D97232BE76
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238433AbhCCR14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444499AbhCCNqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:46:37 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D607DC0611BE
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:43:51 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l22so5230168wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WQfVByDMubjxteIKJEZ6P0NR+Mqv9ZNp4le53NfYrp8=;
        b=iMTh4dk09sGxqAE/qzSGNAZyvWAptULs+nQCYT2OtIn3+7m0+6HrnZE1aUNidOxkd1
         HmBXyCE2zeEgjrHTRb3VZSeT3uOaMbsogo1LT36zL6TJcnQSaeedSmHxTVD7t846xMCV
         eDdK6AYjTARDjg8E/gMjAKx0AYRKmz5xxP6aPwaFs9bQtLq/cDZ+1G8tJCD8Sw6/+Si1
         oWKD8iQuNbtQnxKs9XREiEA3GzeA3/ge0ObQRTj0uRHSotea1Ndx9pvJUsW1OI6UJwh1
         m8FyDR4OSbUUM46rq97np9+8LfZYnGxDKtK3Vl0ooMSjZ2eHgo1Le9Z/NLIU8vnm9XBF
         UUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WQfVByDMubjxteIKJEZ6P0NR+Mqv9ZNp4le53NfYrp8=;
        b=Nq/50saLfpQkS5Mj2mBfpziKF3pPV6TpyLGjZd1HQy7n2m5F2uzhX6iEp7zu02P32l
         VKZaI+R4gN4v/bCQWTlt86JdoJMz8esBaLg5z25MFVSDYhfmDSqnVMERSIkRMsrPwQsc
         68enceWT2+DxtcusdLwOTz3yDh9sOpRJ9U0ruAQytND+urGaTtPOoVQv8wKQICXLT6cd
         svqa75oThP0miovzsoxSeHCmDqTeXzxjirMWRCCmPnlzLQMziAMGTtdG3OYn11DdvU3Z
         +Kk7NNoZd/TnkvhAgXn1gYnTdEZPmGcRnLgT2yrDYiHrKNPV9Jk5mqLvK58C+jNbloT6
         xY5A==
X-Gm-Message-State: AOAM530Bq4lo397pA4vKtFMex+l74pa5zwyH3DlmcAjXh1JraK2Vry3M
        K9wi6zYbOcmO8YwgM4XMRJlZZQ==
X-Google-Smtp-Source: ABdhPJzyUy+S8ulahsuVr/azQFNR9h4YD/I4Ad0ABeYj4bYvn2eB4B03dDyZjVZiwtN1lHjN0zcxjA==
X-Received: by 2002:a1c:400b:: with SMTP id n11mr9079631wma.167.1614779030643;
        Wed, 03 Mar 2021 05:43:50 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:43:50 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 19/53] drm/nouveau/dispnv50/disp: Include header containing our prototypes
Date:   Wed,  3 Mar 2021 13:42:45 +0000
Message-Id: <20210303134319.3160762-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
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

