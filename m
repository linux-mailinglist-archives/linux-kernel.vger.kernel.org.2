Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE3C3E998D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 22:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbhHKUPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 16:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbhHKUPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 16:15:50 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD6AC061798
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 13:15:26 -0700 (PDT)
Received: from dslb-094-219-033-123.094.219.pools.vodafone-ip.de ([94.219.33.123] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mDudG-0004sF-59; Wed, 11 Aug 2021 22:15:22 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 4/5] staging: r8188eu: use proper way to build a module
Date:   Wed, 11 Aug 2021 22:14:49 +0200
Message-Id: <20210811201450.31366-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210811201450.31366-1-martin@kaiser.cx>
References: <20210811201450.31366-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that for now, we can only build this driver as a module.

Use the same mechanism as other drivers (such as rtl8723bs or the
deprecated rtl8188eu) to enforce building as a module, i.e. depend on m
in Kconfig instead of setting CONFIG_R8188EU = m in the Makefile.

If we set CONFIG_R8188EU in the Makefile, this setting will not be visible
in .config.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/Kconfig  | 1 +
 drivers/staging/r8188eu/Makefile | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/Kconfig b/drivers/staging/r8188eu/Kconfig
index 6323d63a4a1b..dc1719d3f2e4 100644
--- a/drivers/staging/r8188eu/Kconfig
+++ b/drivers/staging/r8188eu/Kconfig
@@ -2,6 +2,7 @@
 config R8188EU
 	tristate "Realtek RTL8188EU Wireless LAN NIC driver"
 	depends on WLAN && USB && CFG80211
+	depends on m
 	select WIRELESS_EXT
 	select WEXT_PRIV
 	select LIB80211
diff --git a/drivers/staging/r8188eu/Makefile b/drivers/staging/r8188eu/Makefile
index 7f6658f931d1..cca7a58c5f29 100644
--- a/drivers/staging/r8188eu/Makefile
+++ b/drivers/staging/r8188eu/Makefile
@@ -4,8 +4,6 @@ EXTRA_CFLAGS += -O1
 
 ccflags-y += -D__CHECK_ENDIAN__
 
-CONFIG_R8188EU = m
-
 CONFIG_USB_HCI = y
 
 CONFIG_BT_COEXIST = n
-- 
2.20.1

