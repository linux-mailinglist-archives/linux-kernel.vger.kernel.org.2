Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A10E39AFF7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 03:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhFDBmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 21:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhFDBmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 21:42:54 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E77CC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 18:40:59 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id z3-20020a17090a3983b029016bc232e40bso1551700pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 18:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XiCEBFYQs1wHoBsBq8qZHCHeWtBmY7GOb/awBPWsVM0=;
        b=hbR43tKlLsrx/D3uOQI9CXZlXNW70odw9gD6sUiwz/hnGkNBRz7RCKWP1KPxE7IVX0
         USzfmD0O7brF4DU3eI2z8LVM8cxTC6CQIZ3JV1J8xU7X8RWb1v6v9LyjxZgmMv37VudU
         yrF39zW/TcU4NhYz5DqbTCS8/lhN71tLLpGvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XiCEBFYQs1wHoBsBq8qZHCHeWtBmY7GOb/awBPWsVM0=;
        b=gz1HcT78a3+5320OJimnRjUGPQGTOzFmNNTaBWeO5NvChRTr2LhybEbJYjl+wuYp/m
         ETpRmMn4oD+XRsONrFUVz3PYF3t6hCAHRWxKTmx4x5yDqTkeL0aTqJSmUn6OSCdHAK5T
         H+UyIia1r/vgLo+eUixyfNB6BTn9mp60P6mos2DPfgtJKUrN3Z2MJWKM5tfberZj7gks
         WmO5udgWPx7nTUU6qUVRhtwFMzk5M5ZJkfRURe5n5iYZV5tWg+GezC9C366PiLqGCwhl
         rO/HsZc9nU/j+5qLzO43TdkNJ9HT0gElROLDPb9CAZrfN36j7s/bA3gGIk5XfL+Cb5iN
         cjkQ==
X-Gm-Message-State: AOAM532Q0slm4lgdotgYsLXpGlDaPuK5qcgmiuVU/xDUGBGUitKJG+4I
        /rJWGOt2zF9gVgwhu59DEG7pug==
X-Google-Smtp-Source: ABdhPJy6vUfFFweAQh1fJ/gd2t/8skp7dOMu1If6hoqtSK41KY3KdYZDUbkW/1Rw0btPE7HztchCYQ==
X-Received: by 2002:a17:90a:e541:: with SMTP id ei1mr2181414pjb.189.1622770858832;
        Thu, 03 Jun 2021 18:40:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d22sm261601pfn.147.2021.06.03.18.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 18:40:57 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Kees Cook <keescook@chromium.org>, Rob Herring <robh@kernel.org>,
        Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm/pl111: Actually fix CONFIG_VEXPRESS_CONFIG depends
Date:   Thu,  3 Jun 2021 18:40:55 -0700
Message-Id: <20210604014055.4060521-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=14c1e26a99e7a5c0826947861880974d3dec799c; i=DwQ2M6JPPIp1aqGMVRBW/n1FD/gTXx2QUVMc6SXkj4M=; m=E+lJDbe/6hLH7r7M/V+C+IdMvMSqFV7vypoHLWtjYP4=; p=KlVnos6MMZObwZsBAYHQc0hRN6QGRSQebq9sCHvfiro=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmC5hKYACgkQiXL039xtwCYwKg//SiS PhS38XmQqoSASnS9fIRyRodfKTHbNzV4rtVnziiv7X1ZPPQ0tsp0nW5/CJB1Pf5VCvjRJO5rXiq/8 lvD9INTOkWCGCkiiCy08m2p3d0gQiwJlk/X5GLb3qmfeFiruJD+fIHUKwPaRl7EOsVbMxZurlHrdl Si92Z/PBMWreYp8SeUXFyGjS2+TzSIfGNlMrhhxbtqYH9MIwZPuCN5GN58Y34kpn7MqwV2x2NCXLZ d78SyRzgIo0Qd4PRUrjrKrtSS31fOgO+gMTkWf6+8zTpZEivcMkodr8gb+gZALDm/ku2FIHJqaLsE Ho7MWVmUhi5B9cAiQc/cFsu3vbYhvBW/1nbHn9VITSQ6PfeR/tICFzkLRA4KG1xsxVkhlVB91HxgM IqGOYSh4KmTupDsFhbwVmMD/fVxSqUzlNP2DNFkdZ8+0jV+gGVRJAFaFRgshXx0tpSQefsVt/Fxxh Pmx5CwPdjKN05pnqtDM3vJz0TATQ/a3nUZpOPhovCZRYQy1/TjrTdCfj92TVMeASn1ziO4UVcorw0 Dnq1deOCgrD8xkfRmUMXm4WQfV+fVlHhW5MBI1/m4ygHdBYRRQBzGjPaYnyoqWmJRh0wf9UZnH6g5 uReNa0xN2nF1uQZlLDWxSnDKQvEO4degSHTK5Qf4BZi50yQNGMDW29EfjqTMcNkA=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VEXPRESS_CONFIG needs to either be missing, built-in, or modular when
pl111 is modular. Update the Kconfig to reflect the need.

Fixes: 4dc7c97d04dc ("drm/pl111: depend on CONFIG_VEXPRESS_CONFIG")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: use expected Kconfig style to express this. :)
v1: https://lore.kernel.org/lkml/20210603215819.3904733-1-keescook@chromium.org
---
 drivers/gpu/drm/pl111/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/pl111/Kconfig b/drivers/gpu/drm/pl111/Kconfig
index c5210a5bef1b..3aae387a96af 100644
--- a/drivers/gpu/drm/pl111/Kconfig
+++ b/drivers/gpu/drm/pl111/Kconfig
@@ -2,7 +2,8 @@
 config DRM_PL111
 	tristate "DRM Support for PL111 CLCD Controller"
 	depends on DRM
-	depends on VEXPRESS_CONFIG
+	depends on ARM || ARM64 || COMPILE_TEST
+	depends on VEXPRESS_CONFIG || VEXPRESS_CONFIG=n
 	depends on COMMON_CLK
 	select DRM_KMS_HELPER
 	select DRM_KMS_CMA_HELPER
-- 
2.25.1

