Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C418B35842E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhDHNIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhDHNIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:08:41 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9740AC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 06:08:26 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id w3so2944694ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 06:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5exdKRCsF2K4PXIw6d81pZy/xw7djq4cWgROPZxTAk8=;
        b=Nl0s25l5X8itmVUheFUnCgSuowcv1/yp0zA1y/YMBbgllKIobZK4nMivhQcQD4yZ16
         oRzOG9daL9N69Uu8s5vxjW8HsOgJHZvaezCz6C/UKcr/OXkoqo7IHcA9jedV3WvBDo/q
         fnomhjkzf85xntrL6860oENHsamBrFzCW/ZgKjjcl+KgCTumJPMgh6IyY++BZyjEdOZ+
         bNsP9tEpEkdPPXhdmTNNC/rd5/HHSixKnqxdIgWEr/JV+jncLOCEejj8BiukP5/ABYQq
         yRxNuJgi/DQ51dCaOKtidC5fs5WALXzrR0ua515HMSgvSjI57EJNCYj743QXo3pFFPYD
         szhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5exdKRCsF2K4PXIw6d81pZy/xw7djq4cWgROPZxTAk8=;
        b=DrXjyyGoGIO2/u351YNHMjSUUIQnajZiSdU6UuqNsbugkvcuO5MhNMePzRL+MOxOed
         TFyiZTgWJJz3FZzON8xAoJaQpbh9Z2xgx6vJEC3dmzGOAVrPNSZxiYPPIN8eygBK1qZd
         Db7fvIxbwZQlPerUElhRrUuxaOqB/MV2q63JHddDa0hW92gBXBisAjd/ofZsylJ8LPFc
         Zu298TzBTVcrJez5t2xd9uuAyWjiEnP/dchch7eHfrbupYrDbmbGD+mBPH/XKZ6mqkmA
         G/2lwRH74CJYTFCHbXwgrOi125LQ4A6y8KN4hGzZY3+RL9NHLuW5S7A3USjBYs6w0/Wi
         Kn8w==
X-Gm-Message-State: AOAM530kTn3euhbeHI2QAlOB0zyYak/quI3Z0Q77twHjD9bmNpls1BlX
        9o1+XWtFwGOe5G8Rld6m/e7OnQ==
X-Google-Smtp-Source: ABdhPJzwRDkQpD/aOazIwsyHErfvxEl6JLS8G/cPiWQj9wnvWAeA/fHyCuKNDxGRpnHKfH/NEntH2A==
X-Received: by 2002:a17:906:814a:: with SMTP id z10mr10324785ejw.476.1617887305361;
        Thu, 08 Apr 2021 06:08:25 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2454:3e3:5f00:1381:463f:8d12:2777])
        by smtp.gmail.com with ESMTPSA id a27sm46674ejk.80.2021.04.08.06.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 06:08:24 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     a.hajda@samsung.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     kernel test robot <lkp@intel.com>
Subject: [PATCH v2] drm/bridge/sii8620: fix dependency on extcon
Date:   Thu,  8 Apr 2021 15:07:46 +0200
Message-Id: <20210408130746.175358-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.31.0.30.g398dba342d.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DRM_SIL_SII8620 kconfig has a weak `imply` dependency
on EXTCON, which causes issues when sii8620 is built
as a builtin and EXTCON is built as a module.

The symptoms are 'undefined reference' errors caused
by the symbols in EXTCON not being available
to the sii8620 driver.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reported-by: kernel test robot <lkp@intel.com>
---

Changes since v1:
 - Fix typo on comment

 drivers/gpu/drm/bridge/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 22a467abd3e9..2289b44613af 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -169,7 +169,7 @@ config DRM_SIL_SII8620
 	tristate "Silicon Image SII8620 HDMI/MHL bridge"
 	depends on OF
 	select DRM_KMS_HELPER
-	imply EXTCON
+	depends on EXTCON || !EXTCON # if EXTCON=m, this cannot be built-in
 	depends on RC_CORE || !RC_CORE
 	help
 	  Silicon Image SII8620 HDMI/MHL bridge chip driver.
-- 
2.31.0.30.g398dba342d.dirty

