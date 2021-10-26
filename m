Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03BC43AA5E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 04:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbhJZCjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 22:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbhJZCjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 22:39:32 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14F9C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 19:37:08 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id v10so8571272qvb.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 19:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DTETaP1KHJxtdRGnmmwFS1JhyLh5JLZ7RKeF7+RrWiA=;
        b=OrBodLzIXlm6nxqfY+94yHCUYNEcJnqFjcdyih3/zIslBn7l9+A9n9y89La2RyhoVr
         8XntsxU3cmaoYTIMx5nsDUnmJAsdZGq8lWqNX5HUi4VeileOrEdk1TKAoM7xRUO+3Dqa
         vzn6yHKSyi0lawa1kTR+BP7TDMPwZqWJSR0P0vwSIkCTDHstZsSiq3O6KpLbDWGNWeNg
         9hLsDiEt7D6e71ZiGAx1BDnmRxlfdHrpV6bdf6nLnCququ4N/vNLfrZWaZc0p2mUN6as
         imlFVUc4jH6JS/Kbw9q9wX0dcemiHd5FMBtAJl4xYONxy7Eh77S/7VIATd2T1aNeB0D5
         o1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=DTETaP1KHJxtdRGnmmwFS1JhyLh5JLZ7RKeF7+RrWiA=;
        b=tlm4xRvtqXTZGmiCtuEQKgNFR6i0wa9fuNfnJ50FNAONYCWqYhNqEzj4s4IKwkhahQ
         pEHcPkwQbkQ3sSxd3/noh4jBdmPK12vzCawmBGee6EkJv9wKCn9Ca0MqlcWAM+mdbtUK
         EoJqGWSPlVIxgKevPvD8g8XQHnDEHtSJg5OwRPuBKI07+P3Oa9uGrmL4OeUP4vj3rt/x
         kwfp4inetk9ueoN79dmqeMfjQY95r5crzBnMbk8urBSxNPy3gpHOMZ44l5BWK25edtLx
         PPAF69h2Sd/XV3TmwQwBEaBLYFdmqaqwhyBPtf5SBZMKfqROSkn6AGEBpE7lZBW0++Zz
         3W9Q==
X-Gm-Message-State: AOAM530Mi1bO4TdFB5fe8DKjzmmTKEegZoSl78XWTUCBg6FjhtutwUC/
        kfj0x5Xz9kavWSKmr7/DFfY=
X-Google-Smtp-Source: ABdhPJyplLk91Tr+sae/eJApG3oOhuPL/YK5EjJO+0q6JfySRWctAIEqlx8TukbyjBuFt8elF81YIw==
X-Received: by 2002:ad4:5903:: with SMTP id ez3mr14330933qvb.14.1635215827851;
        Mon, 25 Oct 2021 19:37:07 -0700 (PDT)
Received: from localhost.localdomain ([67.8.38.84])
        by smtp.gmail.com with ESMTPSA id q196sm9948468qke.27.2021.10.25.19.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 19:37:07 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     robert.foss@linaro.org, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     jagan@amarulasolutions.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm: bridge: fix unmet dependency on DRM_KMS_HELPER for DRM_PANEL_BRIDGE
Date:   Mon, 25 Oct 2021 22:36:38 -0400
Message-Id: <20211026023638.41646-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When DRM_CHIPONE_ICN6211 is selected, and DRM_KMS_HELPER is not selected,
Kbuild gives the following warning:

WARNING: unmet direct dependencies detected for DRM_PANEL_BRIDGE
  Depends on [n]: HAS_IOMEM [=y] && DRM_BRIDGE [=y] && DRM_KMS_HELPER [=n]
  Selected by [y]:
  - DRM_CHIPONE_ICN6211 [=y] && HAS_IOMEM [=y] && DRM [=y] && DRM_BRIDGE [=y] && OF [=y]

This is because DRM_CHIPONE_ICN6211 selects DRM_PANEL_BRIDGE
without depending on or selecting DRM_KMS_HELPER,
despite DRM_PANEL_BRIDGE depending on DRM_KMS_HELPER.

This unmet dependency bug was detected by Kismet,
a static analysis tool for Kconfig.
Please advise if this is not the appropriate solution.

v2:
- changed from "select" to "depends on"

Fixes: ce517f18944e ("drm: bridge: Add Chipone ICN6211 MIPI-DSI to RGB bridge")
Reviewed-by: Robert Foss <robert.foss@linaro.org>
Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/gpu/drm/bridge/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 431b6e12a81f..a630cb8fd1c8 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -30,6 +30,7 @@ config DRM_CDNS_DSI
 config DRM_CHIPONE_ICN6211
 	tristate "Chipone ICN6211 MIPI-DSI/RGB Converter bridge"
 	depends on OF
+  depends on DRM_KMS_HELPER
 	select DRM_MIPI_DSI
 	select DRM_PANEL_BRIDGE
 	help
--
2.30.2
