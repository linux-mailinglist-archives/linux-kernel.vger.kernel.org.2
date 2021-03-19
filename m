Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02B9341776
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 09:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbhCSIZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 04:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbhCSIYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 04:24:50 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3C0C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:24:49 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y6so9777177eds.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QN4aBNwxKOCABxwfpyuG0Xk/7oUm3WT2PgkGnXFzadY=;
        b=xWnz3znjFX0tNlW97leA+LZR30kAS4pJ8PYHiwxM/+iY/SDaIbTj6tWToOXKAZNWUw
         3Fc8+e74T6Vu46ecZ3bBMYpLvi60D6XBeSEfImpnAHgWEoyGx2x7vu9tVcgEsKTnkJB3
         Z0uLIUTCwAaSFxopOOrNDj4nSHqdQ/XfofC89C+sKyV97q9eUBvjxq5/89nvlo2QB9rq
         9aNacsmrTFvmNCUC456ULATHyldGtn4gY9hqJeg2Rb9UUy2m6ovSXOV9dOycIsIfINVD
         Ka6tGO2ZRhIOVH1CpnUY+l/ra1+5xL3x4JO8o0swlS0Jn9HnkFWNtCQxWTBAWVH5rlbE
         +UMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QN4aBNwxKOCABxwfpyuG0Xk/7oUm3WT2PgkGnXFzadY=;
        b=bGlyL5J0osWjWb55txLNyRfwM/D95MFt/blVShXRNJFkaxdUgPKZZ2zOoIJfM7L3MC
         LBZvZV4hXNjiSR6gGojm92gjjbchAssECjOAcvqi9WWy6LzwlSkWNzHpzsf7qAApw+lN
         LkSVNDTgyv5LnvgpclX+groKVxgJQUsnW5sCu1irgBVMKqT8XkQe8Bs+nzuNKiMBS+5a
         SUidE0m4bY6tPXSp7LOIV7sxZAOvFQev0ynJAXDxNgtB6p/g2CmDo1Hx2N3pubZmTl48
         TevHodBO7wm6e7rJSqdE75MQms3TdoF32Qrb0gpImE5t3fEhX10m83hglEldJG8bffWs
         kNLQ==
X-Gm-Message-State: AOAM530BfgpJ1uYzX2V9NpZp2fkwgQB9VULwgpWiAbsS0WckwmWtEWwm
        4S0TZSaOA69UDI7ZMZ6BD21m1g==
X-Google-Smtp-Source: ABdhPJwscQWu+LWU/WdUY0149XPKN1oU1qX01NKk8VcKSVszs01UoBJnFfmsmVlA0SKHNDd4ocW6yQ==
X-Received: by 2002:a05:6402:3486:: with SMTP id v6mr8079033edc.109.1616142288680;
        Fri, 19 Mar 2021 01:24:48 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id b18sm3273727ejb.77.2021.03.19.01.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 01:24:48 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 17/19] drm/nouveau/nouveau_ioc32: File headers are not good candidates for kernel-doc
Date:   Fri, 19 Mar 2021 08:24:26 +0000
Message-Id: <20210319082428.3294591-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210319082428.3294591-1-lee.jones@linaro.org>
References: <20210319082428.3294591-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/nouveau/nouveau_ioc32.c:2: warning: Cannot understand  * file mga_ioc32.c

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/nouveau_ioc32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_ioc32.c b/drivers/gpu/drm/nouveau/nouveau_ioc32.c
index adf01ca9e035d..8ddf9b2325a42 100644
--- a/drivers/gpu/drm/nouveau/nouveau_ioc32.c
+++ b/drivers/gpu/drm/nouveau/nouveau_ioc32.c
@@ -1,4 +1,4 @@
-/**
+/*
  * \file mga_ioc32.c
  *
  * 32-bit ioctl compatibility routines for the MGA DRM.
-- 
2.27.0

