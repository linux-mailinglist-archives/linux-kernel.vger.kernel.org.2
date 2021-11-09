Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9704544A550
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 04:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238013AbhKID0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 22:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236036AbhKID0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 22:26:39 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168A6C061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 19:23:54 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id a24so13349403qvb.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 19:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2V3HogjR6tzeLasoYLzy6we6u4i3vWdwDzTcRieWiEM=;
        b=LKmalwKErazJJMZDAs8oZwXA/te5qGZYGXTxMEHcmVJf+XS9M8wT0fh3k0hmf/XDZ0
         yi6id+IP38VRYUwbGNeq4MlUgDwU6N9MtCw1q1yYh3c6N0FV1jJbo4WOxtjzaZtrryUS
         NFWk0a96iyu6mjMc260jlsndn+BUXvcJjLP5KXc1Nl0vksgTp8IIAEQ4GuzXrRJ8+Hi5
         SM021kwP48z1A77N3qqpuKy2P0XXTXHnFSTvBr8VmJ/Jt7CClHTX47WUh1yw15J51bu+
         9NHvn3fWf/R0o/blQpqIr2amky3axROrIpPPoeDiU+gOAQXGZhygjP9eTO9tFM20Lcjx
         ZPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=2V3HogjR6tzeLasoYLzy6we6u4i3vWdwDzTcRieWiEM=;
        b=NXgaeESj4JuG6gfIBAgW6DFh6wATZdORZWKvzdRyKk3KLbHXttGP9Lp3nrwVMd4dC2
         AhdIsetDZ9NWPCsFBTNgkKnZapELouBnoxdDCt/bPHRO3ZmC52Akbqy19PpL5qdzfiT0
         FQ7a0gz6yXRiKAoEtQNrXKRlGgHmMsLzxp13d7HtIG2IrkuV1Bq3fxx+Z176nFUFljEL
         ImhYSck+jZ1q9aHr98mmSNJlHvZ3aWVkiBgFdCf9evgJiCpIyC5igOUGmRx3EyhqXGxm
         G5h7dsi2EnawARRq6xuwjmFSJ6LH62yHfVVuHyGGAqa2JQPe4FqVHSLSFjaWrceP285H
         SMBg==
X-Gm-Message-State: AOAM5305UHkQjWy5v3xabICanObABtgC+qtZlcvbgTviPOXeF4uF2Rp7
        M+lqKf05WQtQLa2Mz+MZRfGuB2MNQY+6c95/Hqg=
X-Google-Smtp-Source: ABdhPJx/A45jDBxyjJp26aQ17KId/KksS/DEix+3w66MMwl/WrSdu8dJIgKKzsVCzb8Z0GoWSqPLkg==
X-Received: by 2002:a05:6214:411d:: with SMTP id kc29mr4253736qvb.22.1636428233263;
        Mon, 08 Nov 2021 19:23:53 -0800 (PST)
Received: from localhost.localdomain ([67.8.38.84])
        by smtp.gmail.com with ESMTPSA id f7sm11032327qkp.107.2021.11.08.19.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 19:23:52 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, jernej.skrabec@gmail.com,
        wens@csie.org, mripard@kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, fazilyildiran@gmail.com
Subject: [PATCH] [PATCH v2] drm/sun4i: fix unmet dependency on RESET_CONTROLLER for PHY_SUN6I_MIPI_DPHY
Date:   Mon,  8 Nov 2021 22:23:51 -0500
Message-Id: <20211109032351.43322-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When PHY_SUN6I_MIPI_DPHY is selected, and RESET_CONTROLLER
is not selected, Kbuild gives the following warning:

WARNING: unmet direct dependencies detected for PHY_SUN6I_MIPI_DPHY
  Depends on [n]: (ARCH_SUNXI [=n] || COMPILE_TEST [=y]) && HAS_IOMEM [=y] && COMMON_CLK [=y] && RESET_CONTROLLER [=n]
  Selected by [y]:
  - DRM_SUN6I_DSI [=y] && HAS_IOMEM [=y] && DRM_SUN4I [=y]

This is because DRM_SUN6I_DSI selects PHY_SUN6I_MIPI_DPHY
without selecting or depending on RESET_CONTROLLER, despite
PHY_SUN6I_MIPI_DPHY depending on RESET_CONTROLLER.

These unmet dependency bugs were detected by Kismet,
a static analysis tool for Kconfig. Please advise if this
is not the appropriate solution.

v2:
Fixed indentation to match the rest of the file.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/gpu/drm/sun4i/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
index 5755f0432e77..8c796de53222 100644
--- a/drivers/gpu/drm/sun4i/Kconfig
+++ b/drivers/gpu/drm/sun4i/Kconfig
@@ -46,6 +46,7 @@ config DRM_SUN6I_DSI
 	default MACH_SUN8I
 	select CRC_CCITT
 	select DRM_MIPI_DSI
+	select RESET_CONTROLLER
 	select PHY_SUN6I_MIPI_DPHY
 	help
 	  Choose this option if you want have an Allwinner SoC with
-- 
2.30.2

