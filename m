Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7EC3CF0B1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 02:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378675AbhGSXjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 19:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441853AbhGSWN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 18:13:59 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791B7C0617A7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 15:46:04 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i94so23884794wri.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 15:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Xdhpm2k+PKRkOIMYXDY5v+obTyo9rMVta8zQ2xLsEM=;
        b=vVUAywRyhSi0ve4UwHU/2A5NltsR81o/zKn31xuu70XIZQ7PB5lQL7yLaptb87Fl61
         B/RZ4hkRsM/dhR7JTKwPJ6T8d71glObR9UmC6XDahl0UZZPbR0U7oeI0boGbUR69gLt/
         7hXkUVSJ2THgvyyaNtTXkHkbsRA2oVWuPA1Tod8b7tJVG3MyHXvDtDsYOOGLv0JdGd+Z
         LFzqZFFDX4h7DsGmjb1U28FuWU9fWOasqy+elvkGV6AR2qJd+COSRskhvzI+IZgPj+Yf
         GEFRw4KpmulLvbj8o4IJ8pZfKR61K8hayKCjNUM73ThgRfWxUMJJm0/Wcm1r1cRMAENG
         MMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Xdhpm2k+PKRkOIMYXDY5v+obTyo9rMVta8zQ2xLsEM=;
        b=X0KepUj3bvHhYuAb1LaIJetO5XkTtgPysX5e2BodC3TQ6hnUTxV3NQZSwgvF9XEj9a
         Fb1v0tKGjEdCwsZ6cC3naUk/OLViwee6u8fq/eq1qauPDL3mGxmtRmoWuqimGF3lCEFl
         we6l7C3RHT9Xkj1WMbTKMgP+gPqBLYQAs9PPnrGex7rWqt3xwQoJUrCshjpVzr11QjoU
         h4r4ixX7O1B+aitCjw8myp2UchbQUfTRKzEW82TyccqaLDrk8A1aWU/j3SLxcjS+e30N
         D1U/gti810RRhPKHHPCnAgFWESeJpn1PTBcNrw1TUtMaUBxpN39uxSYHviMxYqFiJwZW
         z2tQ==
X-Gm-Message-State: AOAM532w0G9C1NO+xd40mBBPaF+cGvE5HldG5z93zNBO3njrEHG8/ueW
        GzaF6bXyibunc5/LhArnoCXl1A==
X-Google-Smtp-Source: ABdhPJyWrJ8/aw0IR8ZaKLCccjMcoWnkdlNznoFrfdnOQMcA+zd7+KuK+SITFtHmM/YabISkQa9QFw==
X-Received: by 2002:a5d:6851:: with SMTP id o17mr10645087wrw.346.1626734763100;
        Mon, 19 Jul 2021 15:46:03 -0700 (PDT)
Received: from localhost.localdomain (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id z6sm8423608wrw.9.2021.07.19.15.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 15:46:02 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH resend] staging: rtl8188eu: move all source files from core subdirectory
Date:   Mon, 19 Jul 2021 23:46:01 +0100
Message-Id: <20210719224601.255364-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move all C source files from the core subdirectory to the root
folder of the driver, and adjust Makefile accordingly. The ultmate
goal is to remove hal layer and fold its functionalty into the main
sources. At this point, the distinction between hal and core will be
meaningless, so this is the first step towards simplifying the file
layout.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/Makefile            | 34 +++++++++----------
 drivers/staging/rtl8188eu/{core => }/rtw_ap.c |  0
 .../staging/rtl8188eu/{core => }/rtw_cmd.c    |  0
 .../staging/rtl8188eu/{core => }/rtw_efuse.c  |  0
 .../rtl8188eu/{core => }/rtw_ieee80211.c      |  0
 .../rtl8188eu/{core => }/rtw_ioctl_set.c      |  0
 .../staging/rtl8188eu/{core => }/rtw_iol.c    |  0
 .../staging/rtl8188eu/{core => }/rtw_led.c    |  0
 .../staging/rtl8188eu/{core => }/rtw_mlme.c   |  0
 .../rtl8188eu/{core => }/rtw_mlme_ext.c       |  0
 .../rtl8188eu/{core => }/rtw_pwrctrl.c        |  0
 .../staging/rtl8188eu/{core => }/rtw_recv.c   |  0
 drivers/staging/rtl8188eu/{core => }/rtw_rf.c |  0
 .../rtl8188eu/{core => }/rtw_security.c       |  0
 .../staging/rtl8188eu/{core => }/rtw_sreset.c |  0
 .../rtl8188eu/{core => }/rtw_sta_mgt.c        |  0
 .../rtl8188eu/{core => }/rtw_wlan_util.c      |  0
 .../staging/rtl8188eu/{core => }/rtw_xmit.c   |  0
 18 files changed, 17 insertions(+), 17 deletions(-)
 rename drivers/staging/rtl8188eu/{core => }/rtw_ap.c (100%)
 rename drivers/staging/rtl8188eu/{core => }/rtw_cmd.c (100%)
 rename drivers/staging/rtl8188eu/{core => }/rtw_efuse.c (100%)
 rename drivers/staging/rtl8188eu/{core => }/rtw_ieee80211.c (100%)
 rename drivers/staging/rtl8188eu/{core => }/rtw_ioctl_set.c (100%)
 rename drivers/staging/rtl8188eu/{core => }/rtw_iol.c (100%)
 rename drivers/staging/rtl8188eu/{core => }/rtw_led.c (100%)
 rename drivers/staging/rtl8188eu/{core => }/rtw_mlme.c (100%)
 rename drivers/staging/rtl8188eu/{core => }/rtw_mlme_ext.c (100%)
 rename drivers/staging/rtl8188eu/{core => }/rtw_pwrctrl.c (100%)
 rename drivers/staging/rtl8188eu/{core => }/rtw_recv.c (100%)
 rename drivers/staging/rtl8188eu/{core => }/rtw_rf.c (100%)
 rename drivers/staging/rtl8188eu/{core => }/rtw_security.c (100%)
 rename drivers/staging/rtl8188eu/{core => }/rtw_sreset.c (100%)
 rename drivers/staging/rtl8188eu/{core => }/rtw_sta_mgt.c (100%)
 rename drivers/staging/rtl8188eu/{core => }/rtw_wlan_util.c (100%)
 rename drivers/staging/rtl8188eu/{core => }/rtw_xmit.c (100%)

diff --git a/drivers/staging/rtl8188eu/Makefile b/drivers/staging/rtl8188eu/Makefile
index 28b936e8be0a..2dad13bdbdeb 100644
--- a/drivers/staging/rtl8188eu/Makefile
+++ b/drivers/staging/rtl8188eu/Makefile
@@ -1,22 +1,22 @@
 # SPDX-License-Identifier: GPL-2.0
 r8188eu-y :=				\
-		core/rtw_ap.o		\
-		core/rtw_cmd.o		\
-		core/rtw_efuse.o	\
-		core/rtw_ieee80211.o	\
-		core/rtw_ioctl_set.o	\
-		core/rtw_iol.o		\
-		core/rtw_led.o		\
-		core/rtw_mlme.o		\
-		core/rtw_mlme_ext.o	\
-		core/rtw_pwrctrl.o	\
-		core/rtw_recv.o		\
-		core/rtw_rf.o		\
-		core/rtw_security.o	\
-		core/rtw_sreset.o	\
-		core/rtw_sta_mgt.o	\
-		core/rtw_wlan_util.o	\
-		core/rtw_xmit.o		\
+		rtw_ap.o		\
+		rtw_cmd.o		\
+		rtw_efuse.o		\
+		rtw_ieee80211.o		\
+		rtw_ioctl_set.o		\
+		rtw_iol.o		\
+		rtw_led.o		\
+		rtw_mlme.o		\
+		rtw_mlme_ext.o		\
+		rtw_pwrctrl.o		\
+		rtw_recv.o		\
+		rtw_rf.o		\
+		rtw_security.o		\
+		rtw_sreset.o		\
+		rtw_sta_mgt.o		\
+		rtw_wlan_util.o		\
+		rtw_xmit.o		\
 		hal/fw.o	\
 		hal/mac_cfg.o \
 		hal/bb_cfg.o \
diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/rtw_ap.c
similarity index 100%
rename from drivers/staging/rtl8188eu/core/rtw_ap.c
rename to drivers/staging/rtl8188eu/rtw_ap.c
diff --git a/drivers/staging/rtl8188eu/core/rtw_cmd.c b/drivers/staging/rtl8188eu/rtw_cmd.c
similarity index 100%
rename from drivers/staging/rtl8188eu/core/rtw_cmd.c
rename to drivers/staging/rtl8188eu/rtw_cmd.c
diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/rtw_efuse.c
similarity index 100%
rename from drivers/staging/rtl8188eu/core/rtw_efuse.c
rename to drivers/staging/rtl8188eu/rtw_efuse.c
diff --git a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c b/drivers/staging/rtl8188eu/rtw_ieee80211.c
similarity index 100%
rename from drivers/staging/rtl8188eu/core/rtw_ieee80211.c
rename to drivers/staging/rtl8188eu/rtw_ieee80211.c
diff --git a/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c b/drivers/staging/rtl8188eu/rtw_ioctl_set.c
similarity index 100%
rename from drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
rename to drivers/staging/rtl8188eu/rtw_ioctl_set.c
diff --git a/drivers/staging/rtl8188eu/core/rtw_iol.c b/drivers/staging/rtl8188eu/rtw_iol.c
similarity index 100%
rename from drivers/staging/rtl8188eu/core/rtw_iol.c
rename to drivers/staging/rtl8188eu/rtw_iol.c
diff --git a/drivers/staging/rtl8188eu/core/rtw_led.c b/drivers/staging/rtl8188eu/rtw_led.c
similarity index 100%
rename from drivers/staging/rtl8188eu/core/rtw_led.c
rename to drivers/staging/rtl8188eu/rtw_led.c
diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/rtw_mlme.c
similarity index 100%
rename from drivers/staging/rtl8188eu/core/rtw_mlme.c
rename to drivers/staging/rtl8188eu/rtw_mlme.c
diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/rtw_mlme_ext.c
similarity index 100%
rename from drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
rename to drivers/staging/rtl8188eu/rtw_mlme_ext.c
diff --git a/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c b/drivers/staging/rtl8188eu/rtw_pwrctrl.c
similarity index 100%
rename from drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
rename to drivers/staging/rtl8188eu/rtw_pwrctrl.c
diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/rtw_recv.c
similarity index 100%
rename from drivers/staging/rtl8188eu/core/rtw_recv.c
rename to drivers/staging/rtl8188eu/rtw_recv.c
diff --git a/drivers/staging/rtl8188eu/core/rtw_rf.c b/drivers/staging/rtl8188eu/rtw_rf.c
similarity index 100%
rename from drivers/staging/rtl8188eu/core/rtw_rf.c
rename to drivers/staging/rtl8188eu/rtw_rf.c
diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/rtw_security.c
similarity index 100%
rename from drivers/staging/rtl8188eu/core/rtw_security.c
rename to drivers/staging/rtl8188eu/rtw_security.c
diff --git a/drivers/staging/rtl8188eu/core/rtw_sreset.c b/drivers/staging/rtl8188eu/rtw_sreset.c
similarity index 100%
rename from drivers/staging/rtl8188eu/core/rtw_sreset.c
rename to drivers/staging/rtl8188eu/rtw_sreset.c
diff --git a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c b/drivers/staging/rtl8188eu/rtw_sta_mgt.c
similarity index 100%
rename from drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
rename to drivers/staging/rtl8188eu/rtw_sta_mgt.c
diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/rtw_wlan_util.c
similarity index 100%
rename from drivers/staging/rtl8188eu/core/rtw_wlan_util.c
rename to drivers/staging/rtl8188eu/rtw_wlan_util.c
diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/rtw_xmit.c
similarity index 100%
rename from drivers/staging/rtl8188eu/core/rtw_xmit.c
rename to drivers/staging/rtl8188eu/rtw_xmit.c
-- 
2.31.1

