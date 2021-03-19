Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983ED341778
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 09:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbhCSIZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 04:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbhCSIYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 04:24:51 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B0FC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:24:51 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u5so8273338ejn.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BenSWVQP2zN1koiPW0t4kws5hTFRiEoau/BE1y9GfNM=;
        b=oYWlnV715tCLUBUZeEDrM0wpCjeONuoxo+3C79hxVxvB8pCEQYK+jSqFAx2gbfgfwH
         n1TztEimoVY6MF894XhvGVjWrmeVXaVorLFS8ocMbNhFlUz2t4DL8H9yv6Mi54buMcP2
         zrrtllvrV3JRgkGqf44mltxIzcxnMk8t7PnwcUJjIHICtm79tOaAYocHa45kjgQaqGIF
         E/gReLSRwchhEXGmAmFH0ZYmXlBGQ38VW6Ed/nUE783qy8NQ27hsty26IGAFI5ZZJv5E
         aYta5XBi+HF2Zq7l1JEX14Ib5cARXLIat30SuqSMDq/lG/mSrl8dk4NxJcs8BQCPG2a9
         tWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BenSWVQP2zN1koiPW0t4kws5hTFRiEoau/BE1y9GfNM=;
        b=l4fwySuaGWwXqWqkWxUBjyRlzA7y/KDExhR0mnO0z7rxp5VOao30Su4/r0gQWrkfTC
         xAsBPvAdoUFCzdGPqFwFCcdhA/jkHFwcfRoNQdwkt5rAEAgii3D3X0E8lyyy14IMf0Es
         kFCV8ZTbJVM61CpRmuAqLKTrbtya10b+aw9IEPxXKQDIOOhldu0Om89RbeszjzBlVjor
         P1PnITtZfdcvZ64hfZMhsD5CLLNBGDASJbgXkDmvle3MK987gelvXxBUd+PH7wOTQnoP
         MsBy+gny+AYkwSCVEwayMR3dvdTmoQE+uZL1m9xJ3ual2W5lyfU0ergRKA35vznaYEGh
         12TQ==
X-Gm-Message-State: AOAM532Y0dDTmHKMXixJMfmzx3zCXOgQDVXxH2X/nJoGxIJmi83HyeyA
        LSkvC1Uvaxa+w0LajUh8i80VozfQf2wU0g==
X-Google-Smtp-Source: ABdhPJxuH+2sZwvtwXnTvWJjVjs+eqo/uTPUENoEZ5KkXMAP0d9KhrIHoM6ef56AjMLywklcMo0kcA==
X-Received: by 2002:a17:906:2b46:: with SMTP id b6mr2916696ejg.521.1616142290404;
        Fri, 19 Mar 2021 01:24:50 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id b18sm3273727ejb.77.2021.03.19.01.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 01:24:50 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 19/19] drm/nouveau/nouveau_ioc32: Demote kernel-doc abuse to standard comment block
Date:   Fri, 19 Mar 2021 08:24:28 +0000
Message-Id: <20210319082428.3294591-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210319082428.3294591-1-lee.jones@linaro.org>
References: <20210319082428.3294591-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/nouveau/nouveau_ioc32.c:52: warning: Function parameter or member 'filp' not described in 'nouveau_compat_ioctl'
 drivers/gpu/drm/nouveau/nouveau_ioc32.c:52: warning: Function parameter or member 'cmd' not described in 'nouveau_compat_ioctl'
 drivers/gpu/drm/nouveau/nouveau_ioc32.c:52: warning: Function parameter or member 'arg' not described in 'nouveau_compat_ioctl'

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
index 8ddf9b2325a42..2af3615c5205c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_ioc32.c
+++ b/drivers/gpu/drm/nouveau/nouveau_ioc32.c
@@ -38,7 +38,7 @@
 
 #include "nouveau_ioctl.h"
 
-/**
+/*
  * Called whenever a 32-bit process running under a 64-bit kernel
  * performs an ioctl on /dev/dri/card<n>.
  *
-- 
2.27.0

