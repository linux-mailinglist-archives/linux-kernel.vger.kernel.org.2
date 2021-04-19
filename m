Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF9F363E1D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 11:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238364AbhDSJCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 05:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhDSJCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 05:02:09 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE448C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 02:01:39 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e7so24160972wrs.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 02:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TPqPD/BdKbOmQoY/69ahqiLeLy4W5bUr61Qz2mAbQO8=;
        b=ZDkUmAfiNr7vTw1GLZge+A/3lbdsF/wNvgIGrY/66IjAeb7JkxqkJ0G/3heyKx1bpy
         ay9fjir4M6WU7e+kYVMvUrsqazj1q+JJWXuwS7rAWPWy/6fiD2YD6c9S5M6mBDH+QAPM
         5CXAQlIZx9XlaC2nvi9RbwwSyXIyUUKyvOOMiwChIzAAmagIFrLtJTjalX0x+tmZEGXW
         1sn5VFCVXt5RVUfiUM+8virAYqShpxLwyVnqBlqIWHV0i2dp14zdWT53ZatA1FpK3zOg
         Y6Bt18WS4izwrTSxGNzo8Ijpk9pSeVB98ss4KuzYKF3AnhDVBij0OAR2VXMa6HwLR84p
         pW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TPqPD/BdKbOmQoY/69ahqiLeLy4W5bUr61Qz2mAbQO8=;
        b=jPhY9Ft41FsDT3/TPTxhhRxy3UQgtlCYRXDnMBtnTcbyAtuqW/8h261PErUQvoBhgH
         6jCFjLZ56I397U6VMTBSmC/02Gs3RTwHKWbjFmkaMLKdXtiF7xIJw+iZrDsbi0Izhko3
         ulAiI6hs0S1IN2z4wycoXe3TYS3wSpSI53cGKOI+d5cFZlfee/VMLcHbtYMcCbPlwCWM
         3WKQK0ur1ACzHxsy1iNvl7sBFsK6/YrQ/ODA2aD8qvtiSuuNQKYRgooSpnehgRd+Dff5
         EyuzlxiEsxRv4hKG4tL9Mo/YvSdaZbXtmguQc6gdYzssvsw9kVjd01/mOOHOZV2Qvws7
         Bpbw==
X-Gm-Message-State: AOAM530TFg3N78ip/DT9Mgob83F5BDJ5gJkAVswrRLW5k+1QZuvQQBVT
        b/72JgPs0M4vJMZJLFyn9ZuQ1Q==
X-Google-Smtp-Source: ABdhPJys4VsgOUWkYQqpx+Qn/FCs2zadombmpxdeBA++SkKxsdC+yJFpD3mOYG/M8XmtvFWemf0B5w==
X-Received: by 2002:a5d:5912:: with SMTP id v18mr13582443wrd.14.1618822898682;
        Mon, 19 Apr 2021 02:01:38 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2454:3e3:5f00:4e60:4ba6:c549:25f6])
        by smtp.gmail.com with ESMTPSA id m14sm21477080wrh.28.2021.04.19.02.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 02:01:38 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     a.hajda@samsung.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net, airlied@linux.ie,
        daniel@ffwll.ch, cw00.choi@samsung.com, m.purski@samsung.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel test robot <lkp@intel.com>
Subject: [PATCH v3] drm/bridge/sii8620: fix dependency on extcon
Date:   Mon, 19 Apr 2021 11:01:24 +0200
Message-Id: <20210419090124.153560-1-robert.foss@linaro.org>
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

Fixes: 688838442147 ("drm/bridge/sii8620: use micro-USB cable detection logic to detect MHL")
Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reported-by: kernel test robot <lkp@intel.com>
---

LKP reported issue:
https://lore.kernel.org/lkml/202104040604.SSTe2Cxf-lkp@intel.com/


Changes since v1:
 - Fix typo on comment

Changes since v2:
 - Randy: Changed from `depends` to `select` 


 drivers/gpu/drm/bridge/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 22a467abd3e9..70402da5cc70 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -169,7 +169,7 @@ config DRM_SIL_SII8620
 	tristate "Silicon Image SII8620 HDMI/MHL bridge"
 	depends on OF
 	select DRM_KMS_HELPER
-	imply EXTCON
+	select EXTCON
 	depends on RC_CORE || !RC_CORE
 	help
 	  Silicon Image SII8620 HDMI/MHL bridge chip driver.
-- 
2.31.0.30.g398dba342d.dirty

