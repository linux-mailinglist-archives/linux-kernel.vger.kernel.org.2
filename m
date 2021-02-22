Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79E13221DC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 22:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhBVVz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 16:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhBVVzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 16:55:53 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D10C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 13:55:13 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id h22so5243744otr.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 13:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OLfykMuiVp97Rmb4dR5kZNxPyJhV2fWYdudzIpCtISY=;
        b=o88aOI+Dusj5SWjl2KYpv9ucVTpkAY0fQ25FXGveFb8RKroDMCMDiCSMOIhJE5PAY/
         DorEPAWkpAwzxXOBAs60MjmEVweeScjH48CeRtZ1wTTVdlVe42tJsiLi7/2OxseOmnR/
         TGf0g+FF9djMUj1Bt6dCh3jI/swyDz3JrA1gaGpmBE/OTo+GUrEJlCuNMY1PdVTp7eFL
         2eWi7/Mo/NbB4HKqXBzcbo1+y2+r/vVdQ+M/HDHlZt2fAW9HqznHSX8eXLkv0AKN2iVi
         J6PQxokMqI+cS/a6714M9N+7FpgfwqnyEGayLTbGBjIXQC98rhlXbmfcddFCvxSRG049
         424Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=OLfykMuiVp97Rmb4dR5kZNxPyJhV2fWYdudzIpCtISY=;
        b=My+uMOjlWYMX1cd0as3SIVdObHiJb2jylpt2VJVNYBZAGBT8JLjRG+I+jaCWqK086C
         CUNoBp0AyEqFt+8n0kR/0UZ+2qzBBamFpP+nim3VX2zbodrBVVdwErhsJ2k5FUq6b2i9
         VkGvWslKHY/5wup19jqzspQsvbiWrqeorl/3iUtUuaRu8jLx/aEa8aX/TlGoANOg4ssk
         bJGblPyon086PmXjgXkGPICmeT/KerPmdBPA5M0sGwwXlRVVPJMp9knUdil8hUN72m1W
         33oOziS3yNFLGIlXOAlm39k6SQGpYoWPaRSBlg1LehB3bHeMyzSwOCaLhwZt2hLfGlGM
         oDIg==
X-Gm-Message-State: AOAM533IkNa5dUcSAoyf0HhvXvWh4C+FMcoEw8IiHIxwepSGh947N1dl
        YeYD3eC2UvIIjkQ9Ed33zAk=
X-Google-Smtp-Source: ABdhPJzSx3nmidUraXL7Q0bwY9tezH7lG9cwiOijB4n65u5xyqTZ55zhqdS6qsaKTfnORT50fZ8Jww==
X-Received: by 2002:a9d:204f:: with SMTP id n73mr12064979ota.68.1614030911794;
        Mon, 22 Feb 2021 13:55:11 -0800 (PST)
Received: from localhost.localdomain ([208.64.158.253])
        by smtp.gmail.com with ESMTPSA id m11sm3996562oih.34.2021.02.22.13.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 13:55:11 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     a.hajda@samsung.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: gpu: drm: bridge: fix kconfig dependency on DRM_KMS_HELPER
Date:   Mon, 22 Feb 2021 16:55:02 -0500
Message-Id: <20210222215502.24487-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When DRM_TOSHIBA_TC358762 is enabled and DRM_KMS_HELPER is disabled,
Kbuild gives the following warning:

WARNING: unmet direct dependencies detected for DRM_PANEL_BRIDGE
  Depends on [n]: HAS_IOMEM [=y] && DRM_BRIDGE [=y] && DRM_KMS_HELPER [=n]
  Selected by [y]:
  - DRM_TOSHIBA_TC358762 [=y] && HAS_IOMEM [=y] && DRM [=y] && DRM_BRIDGE [=y] && OF [=y]

This is because DRM_TOSHIBA_TC358762 selects DRM_PANEL_BRIDGE,
without depending on or selecting DRM_KMS_HELPER,
despite that config option depending on DRM_KMS_HELPER.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/gpu/drm/bridge/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index e4110d6ca7b3..909d0a5643c2 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -183,6 +183,7 @@ config DRM_TOSHIBA_TC358762
 	tristate "TC358762 DSI/DPI bridge"
 	depends on OF
 	select DRM_MIPI_DSI
+	select DRM_KMS_HELPER
 	select DRM_PANEL_BRIDGE
 	help
 	  Toshiba TC358762 DSI/DPI bridge driver.
--
2.27.0
