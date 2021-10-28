Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8060543F27C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 00:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhJ1WP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 18:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbhJ1WP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 18:15:58 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93309C061767
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 15:13:30 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id r2so6018529qtw.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 15:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BxQeetJwEcrw7mZizeh9N8oA8I68HO4YJPCT6BOjW/s=;
        b=YFX4KkFo8sn9wUT9exIjYE3zy3X6XhfFyUpqK4woD/WNaVGG3KGkVpVflHcB2Qt1lE
         Xkhb3v3R7klYbEuJFZfZjc88uoGQTQlz55LXKAO/HgzTV1v+Iw3nk3r4l8kDktOetHWv
         zE+bQ06pDHenulNUaR3PQwa1vJ0rOPI/VD52aaxeqduMEy75r78mNhqQ8H2h5bci8jtS
         XwmcTcwMGOBl99eASIyea5vPhEfkpKyomJtpy9kr23OXOIjmoOzm/7kz1r2I8u/mpEdv
         Pn4gxdZZ5msiceUFeN0yQ5DE4zcoTWmFwaQLZYGeLXelxIx+UNHtzObZMzsrRiU9cZv5
         pTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=BxQeetJwEcrw7mZizeh9N8oA8I68HO4YJPCT6BOjW/s=;
        b=Faq3W2PXBpHks0m9FA0DFXGxZg93sV3dF+Rl4Hp+1mUhpw7GUav6GL1fapfptOQeNZ
         iVqmlbMGiZ6wCdfGxhWYI/MdhXZ1PfQBDYPyU8q71P3GUZS1VRGDVCq7REdqe4uFnvSi
         XwzT7yb+LTdLBbnsdoL4CY+BUgKf+ouwKp/5cR2IiwLKs5Dz9JXd1ZeuBCGd5GXrXgvA
         rwvG0tJodIJ4CqEfq/7HhbIVufSwaOvRJAE0I/WGeAXHOYbwda/3iP1KBL6PnCcPd7g2
         usl/EwcJJaypF31/kjNBS2G8IQHa/gW2QUJompnI0/pzNMIdsuGyLiTEs4HJnGhgZuRD
         /74A==
X-Gm-Message-State: AOAM531eX463/nroxFBqYcobmhzwPnxfF7NftKS1giZZ/lKSgbTmYZuC
        vGV0hpJ9GI+WylPM9pP6V64=
X-Google-Smtp-Source: ABdhPJw7Ip+mVVOhi3P5MeUydNnz0+e4/X81XifGWVT5beNjEjvIb8weALxoCTaaNT8lMLrlpNCpGQ==
X-Received: by 2002:ac8:5d8c:: with SMTP id d12mr7510623qtx.184.1635459209652;
        Thu, 28 Oct 2021 15:13:29 -0700 (PDT)
Received: from localhost.localdomain ([67.8.38.84])
        by smtp.gmail.com with ESMTPSA id h2sm2791097qkf.106.2021.10.28.15.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 15:13:29 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, jernej.skrabec@gmail.com,
        wens@csie.org, mripard@kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, fazilyildiran@gmail.com
Subject: [PATCH] drm/sun4i: fix unmet dependency on RESET_CONTROLLER for PHY_SUN6I_MIPI_DPHY
Date:   Thu, 28 Oct 2021 18:13:27 -0400
Message-Id: <20211028221327.17984-1-julianbraha@gmail.com>
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

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/gpu/drm/sun4i/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
index 5755f0432e77..3f70a14a3c94 100644
--- a/drivers/gpu/drm/sun4i/Kconfig
+++ b/drivers/gpu/drm/sun4i/Kconfig
@@ -46,6 +46,7 @@ config DRM_SUN6I_DSI
 	default MACH_SUN8I
 	select CRC_CCITT
 	select DRM_MIPI_DSI
+  select RESET_CONTROLLER
 	select PHY_SUN6I_MIPI_DPHY
 	help
 	  Choose this option if you want have an Allwinner SoC with
-- 
2.30.2

