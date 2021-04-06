Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C046355009
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 11:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244880AbhDFJgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 05:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237208AbhDFJgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 05:36:31 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250D5C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 02:36:22 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id e14so20808029ejz.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 02:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tRLcdHp/r22ZZ4PcHh6G508zCxRWigC1OCQlVxPhRIc=;
        b=s3gvTQpBxrBu9HNv8L9ieCPpZvgUZKeJAPZJpiBZw7mMCNS9YOnm7cH3eH0elPVGtZ
         02e0c0ZlVKHvn5ugMbcJyuMMa6CyuINh24Ulae18kyVJtuQqMV+A+/dnyHHXRFoLsjp6
         giOyWLo0fNAGWZMWvGdvgVDBGJ4BP9HkdcXQ5n3VH27jpGya9XS/V2Cn24AgBl8iAVl6
         HngUsXATQzTxfl1Ct5TegEvWW7zFmBGwTEjDWQjC94r4kGMdSGZKbtL7Dfywy8NnrTrU
         GRNnN1BKbvdSRenmyQRZC/G18xgs3QTMhoH7qtCI2kcq7Yos3Rnpz0mHCKeJ3VGcUpoV
         l6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tRLcdHp/r22ZZ4PcHh6G508zCxRWigC1OCQlVxPhRIc=;
        b=EkBJWW7k8BU6+S1fxxGsTIf/IoeFVna/BDJet96vJ0Ylh87cnijGtBXFFZ+qdtdjVr
         WjIDfc1ak8+G2yQJHw35Zsbj84cXH9hgXBzxPkNrL4fK6syQlylxJUjqGOCWmp0AU0eN
         70HdVorUrkywSJ/gZ4zXAhOn8eWUanz52HucIygMr+bQS884jkwQenW7ji42Tb7cgYDV
         Dcl2wiQoFLaneXQucnAusnkM8JBas4ckAV90HuHAdBpkaN7PrY1e/52fP/orm/wqxwcD
         2c44yDrExIDW+nAtk8twwj3eAW1wWtwcZmMWnAYqvSg8W2DL0BWNcja08p4BuILDPc22
         1DRA==
X-Gm-Message-State: AOAM530h3VVoQp+d400M2zWdn2f+76sOrzf9QyarRKIPN7+w9kwAMySz
        SZW6Kr1EUOWg7gfLgQgX6VLxIi/AohLsxA==
X-Google-Smtp-Source: ABdhPJzNhocq5G1WyqA/ps6DJH//95iJfkHV+CXSTISjrncYclhQnP2TePyBu2tH6fxD+TmeW3gVLA==
X-Received: by 2002:a17:906:2793:: with SMTP id j19mr5131459ejc.205.1617701780836;
        Tue, 06 Apr 2021 02:36:20 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2454:3e3:5f00:1e2c:6b54:28c7:31c6])
        by smtp.gmail.com with ESMTPSA id q18sm8782699edw.56.2021.04.06.02.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 02:36:20 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     a.hajda@samsung.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     kernel test robot <lkp@intel.com>
Subject: [PATCH v1] drm/bridge/sii8620: fix dependency on extcon
Date:   Tue,  6 Apr 2021 11:35:36 +0200
Message-Id: <20210406093536.635748-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.31.0.30.g398dba342d.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DRM_SIL_SII8620 kconfig has a weak `imply` dependency
on EXTCON, which causes issues when sii8620 is built
as a builtin and EXTCON is built as a module.

Th symptoms are 'undefined reference' errors caused
by the symbols in EXTCON not being available
to the sii8620 driver.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reported-by: kernel test robot <lkp@intel.com>
---

LKP reported issue:
https://lore.kernel.org/lkml/202104040604.SSTe2Cxf-lkp@intel.com/

 drivers/gpu/drm/bridge/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 7c15fc170510..204c38e87849 100644
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

