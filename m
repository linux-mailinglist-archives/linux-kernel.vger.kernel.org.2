Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF8F41B266
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 16:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241394AbhI1Oy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 10:54:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:32960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241294AbhI1Oy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 10:54:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 295F960F24;
        Tue, 28 Sep 2021 14:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632840768;
        bh=EjAj38R6MzpC/IJoRNuUzACYBXlnF5xx5+AhIZAZq1I=;
        h=From:To:Cc:Subject:Date:From;
        b=n86tKqPDoTvDHsrfXJeU5CQbucGAePlnHYIembVwPk1okFJ6lPVbcmdIkBSwtutzL
         mTrxFo+BOuWt8RYzCLQvF9mATxeuYoApZLEdCBJommD+5p9OUrE1trRDqizELQfo9e
         JVIaT9Nq85hXIDNoQrSY4Mw85X9LWWDj3HTNCeIitLtjIpYM/CuHYWMTfozO0H9HBy
         gUEJrveYqs9FC0vSMofirXWgZebHMdVPPgV4WVYadrX9R0JB81Ihp+9KJRyGzRd9sO
         FcWcP1SBrrEOpZbE3b91ZWwN4kPvMUxAAdZU1n3dv1oKuBtxhlvIO6b+jE9BvQJdXs
         pKX+sBB/wwpMg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH] [SUBMITTED 20210721] fbdev: simplefb: fix Kconfig dependencies
Date:   Tue, 28 Sep 2021 16:52:10 +0200
Message-Id: <20210928145243.1098064-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Configurations with both CONFIG_FB_SIMPLE=y and CONFIG_DRM_SIMPLEDRM=m
are allowed by Kconfig because the 'depends on !DRM_SIMPLEDRM' dependency
does not disallow FB_SIMPLE as long as SIMPLEDRM is not built-in. This
can however result in a build failure when cfb_fillrect() etc are then
also in loadable modules:

x86_64-linux-ld: drivers/video/fbdev/simplefb.o:(.rodata+0x1f8): undefined reference to `cfb_fillrect'
x86_64-linux-ld: drivers/video/fbdev/simplefb.o:(.rodata+0x200): undefined reference to `cfb_copyarea'
x86_64-linux-ld: drivers/video/fbdev/simplefb.o:(.rodata+0x208): undefined reference to `cfb_imageblit'

To work around this, change FB_SIMPLE to be a 'tristate' symbol,
which still allows both to be =m together, but not one of them to
be =y if the other one is =m. If a distro kernel picks this
configuration, it can be determined by local policy which of
the two modules gets loaded. The 'of_chosen' export is needed
as this is the first loadable module referencing it.

Alternatively, the Kconfig dependency could be changed to
'depends on DRM_SIMPLEDRM=n', which would forbid the configuration
with both drivers.

Fixes: 11e8f5fd223b ("drm: Add simpledrm driver")
Acked-by: Rob Herring <robh@kernel.org> # for drivers/of/
Link: https://lore.kernel.org/all/20210721151839.2484245-1-arnd@kernel.org/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/of/base.c           | 1 +
 drivers/video/fbdev/Kconfig | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index f720c0d246f2..0ac17256258d 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -36,6 +36,7 @@ LIST_HEAD(aliases_lookup);
 struct device_node *of_root;
 EXPORT_SYMBOL(of_root);
 struct device_node *of_chosen;
+EXPORT_SYMBOL(of_chosen);
 struct device_node *of_aliases;
 struct device_node *of_stdout;
 static const char *of_stdout_options;
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index b26b79dfcac9..6ed5e608dd04 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2193,8 +2193,9 @@ config FB_HYPERV
 	  This framebuffer driver supports Microsoft Hyper-V Synthetic Video.
 
 config FB_SIMPLE
-	bool "Simple framebuffer support"
-	depends on (FB = y) && !DRM_SIMPLEDRM
+	tristate "Simple framebuffer support"
+	depends on FB
+	depends on !DRM_SIMPLEDRM
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
2.29.2

