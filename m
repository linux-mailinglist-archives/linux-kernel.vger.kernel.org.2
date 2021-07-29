Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF713DA0B5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 11:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbhG2J6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 05:58:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235175AbhG2J6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 05:58:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 055C461076;
        Thu, 29 Jul 2021 09:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627552696;
        bh=jU/mVxIYzVpDQbC61+5+mpAlihguu9WTIumYgAJw8Dw=;
        h=From:To:Cc:Subject:Date:From;
        b=waM/KqvyOq+yOCVb4Y7Movu+Gw2kQRd8sEn7qKGl2Fb3gdPojP0dyQg7aEuCyy1tf
         3yoPeCsmXz1m2HTn5W9OrWeigDeEINSk0ciadtW/Vg+SXAUTTCBu7Mo7lnqBwTUwaz
         0cG8lejnJeg4hCEgS9pV/CwEy5z4erfQPK+Pv1CY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-staging@lists.linux.dev
Cc:     forest@alittletooquiet.net, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] staging: vt665X: remove unused CONFIG_PATH
Date:   Thu, 29 Jul 2021 11:58:12 +0200
Message-Id: <20210729095812.1693061-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1386; h=from:subject; bh=jU/mVxIYzVpDQbC61+5+mpAlihguu9WTIumYgAJw8Dw=; b=owGbwMvMwCRo6H6F97bub03G02pJDIlM1Rv/c/FLbX+pVXeyU1FIjnli5P/Ovq0qR/vN/8TPWS6n WVDcEcvCIMjEICumyPJlG8/R/RWHFL0MbU/DzGFlAhnCwMUpABMxm8OwYMmT8EWdxcxybnE7Z+66Mr viSkDxJoa58nIOz/5c6lPz7Hsf0Bon/XC+8dE9AA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vt6655 and vt6656 drivers have an unused CONFIG_PATH define floating
around in the code, but it is never used.  Remove it as drivers should
never be reading from config files anyway, even if these were valid
files.

Reported-by: Joe Perches <joe@perches.com>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/vt6655/device_cfg.h | 3 ---
 drivers/staging/vt6656/device.h     | 2 --
 2 files changed, 5 deletions(-)

diff --git a/drivers/staging/vt6655/device_cfg.h b/drivers/staging/vt6655/device_cfg.h
index db0304f6e21c..2d647a3619ba 100644
--- a/drivers/staging/vt6655/device_cfg.h
+++ b/drivers/staging/vt6655/device_cfg.h
@@ -38,9 +38,6 @@
 
 #include <linux/fs.h>
 #include <linux/fcntl.h>
-#ifndef CONFIG_PATH
-#define CONFIG_PATH            "/etc/vntconfiguration.dat"
-#endif
 
 #define PKT_BUF_SZ          2390
 
diff --git a/drivers/staging/vt6656/device.h b/drivers/staging/vt6656/device.h
index 947530fefe94..2c93a2e66c8a 100644
--- a/drivers/staging/vt6656/device.h
+++ b/drivers/staging/vt6656/device.h
@@ -77,8 +77,6 @@
 #define FIRMWARE_NAME			"vntwusb.fw"
 #define FIRMWARE_CHUNK_SIZE		0x400
 
-#define CONFIG_PATH			"/etc/vntconfiguration.dat"
-
 #define MAX_UINTS			8
 #define OPTION_DEFAULT			{ [0 ... MAX_UINTS - 1] = -1}
 
-- 
2.32.0

