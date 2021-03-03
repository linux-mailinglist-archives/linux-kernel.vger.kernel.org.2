Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE6932BE74
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574241AbhCCRWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444490AbhCCNqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:46:37 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2577BC061A27
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:43:53 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so2883193wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QN4aBNwxKOCABxwfpyuG0Xk/7oUm3WT2PgkGnXFzadY=;
        b=NUDheECZVxO5psCuCN1jM1xoZZajGPU7kVwWlnJ5mOiEUeZbufPZ3v7TtA6Mx91EwB
         1/eF9EQNvIVocgKdeUQr0i2ecHyxb2WvhGSpDs7vAlW79wJXc8BwVpIvUK9osgeDoQK9
         WQFjHYVajsn3pUsX0ce82bUYFY4YdoT9oAONAQt5o8wD29NlaynJv1vdmr+WN3q/P8ig
         cw4qY6aUnXiA+GZMlw1UE6KTSoQw6EYAjVktZ74xQsBtNL7ncpmrBeeEkrJG0GmoPSAE
         Im1UMfhp+V3Mgq1bA3ZghrYEcOE/U0l0pugJp5ElXdJaz/8FqB6GR2egDZ/lE4fpw9st
         YE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QN4aBNwxKOCABxwfpyuG0Xk/7oUm3WT2PgkGnXFzadY=;
        b=BF0L2iQ89g/9FD/ZxC8SMFktzx51nVjM72YaguWfTCcoW5/7gx9c1ur4czNYyGdXvs
         DFmJA96rfh/k+x+nCl0V8p7D/ewmIJLW/hUSFVZKZtYrw/DnDvIqjmw2bLoMlk62R+Mf
         VUBi+14cME0ri/X4xsNOA+zmUIguUA/lGuiuGMjG1cWPhwyYCO0W+NtrXxjBJT7NYI75
         wRhRV76GyYjLXu+MnF1QJ9NugFfm7YVhKwtBx2UoijZOJz8Zrf1VRYDHxaTEUvHZ/I3R
         NJrvn7mXDfKfm3o+Zc7Lja7/1tKEXvmOwB84Ep+ekEU5ziLaeoelaZnjWv3CsmsGnYiR
         zflA==
X-Gm-Message-State: AOAM532LBoq5NnT0o8Fys1jy+15Keln49GfU+FCHl9xjUiq61neeY2Lo
        0lB3CMFi0o7GYiOCmjzINytmug==
X-Google-Smtp-Source: ABdhPJwcbMgfY9dGf7vvbejG7AuPgCa0xeZZHmufjdUVKRtz1yvR/8lwcGHSFgXlR3Fr+RfMadR6zg==
X-Received: by 2002:a1c:2c05:: with SMTP id s5mr9141833wms.70.1614779031936;
        Wed, 03 Mar 2021 05:43:51 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:43:51 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 20/53] drm/nouveau/nouveau_ioc32: File headers are not good candidates for kernel-doc
Date:   Wed,  3 Mar 2021 13:42:46 +0000
Message-Id: <20210303134319.3160762-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
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

