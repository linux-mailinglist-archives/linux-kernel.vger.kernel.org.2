Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B341B3F31FF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 19:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbhHTRIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 13:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhHTRIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 13:08:20 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE78C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 10:07:41 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id o10so21906044lfr.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 10:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HSzOJV3YmSesczV9xfGw2eCGV8Ic6+dJWn1xwRpH8/E=;
        b=ioOUcze496ok/f5Zl2Kcy8WYUq5VphuZoJcfovl1J/ef6JMkGhVCe626SVici6wPrW
         Bg5Y93fcXT7eMbrIodlkc+S+snhl9DNyErUNGQLdhYugFL8b3PiIYBmZ9LrCPoakBFTv
         gEYMgCEOWKLQBA8Gdx2Wc4gZ0rKh9bJNB7to74HPq0RqjWwwr1xffTxbx3nqJkePCLj0
         U1R6JoMy6Ofc7ujFGtMhoR8CNEWbGEgb3bYqbO046jnfwaglxLxuHmMucdd9+Ad0VxP9
         0zYviM3GsdgarJd/lFODD+dGlLH0GnqJeTjw4zsDeMhG3jun1vrwf0+ARrnYq4C2evZN
         Di7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HSzOJV3YmSesczV9xfGw2eCGV8Ic6+dJWn1xwRpH8/E=;
        b=DbFW6OeCwJeV4zhikids7U13MGJ9gAUn7W5Mc7BwSGZ5QG0GxuGP9Y1rzMal1roAaN
         CFgZgzbilcPkwP+YoqhOLQPyybYu+QPqzW3UMqxXklIVJLSdSoqtNsE8ugTihV2icj2l
         r8rKCESLeOgSEQCAiqZoYq7ir5G85JG+vpcYNbGgWyy89QAXnXhpntwFih7N+rq89f5T
         lXtbbXtnWoAGuF3ch27WqR+OHCdUY8K9OLa1/shIhpGNFoRMnN2O3YVeSO83+j9n06ts
         fSdAvjZwax/YLIgVvbmJTK9k2lgVZssJNp/udyTtzQuyXhDdjR24Odd6wCitb0Wi+gMH
         VA8Q==
X-Gm-Message-State: AOAM533IvxGp4gWnFCUnbWFRo7ioYJ/JPyFQUWe36iWu14v6FRqoHaRE
        /+TSPAjqc2v6MGwJpaQCZfQ=
X-Google-Smtp-Source: ABdhPJxXvyYJ3aIRhx/Cf5tU+5i9oiOczDa2HpaFtkuBsQw/XBYM/a1k0M1Cur+WTMxIXvsh4gRJfg==
X-Received: by 2002:a05:6512:3455:: with SMTP id j21mr16061612lfr.8.1629479259028;
        Fri, 20 Aug 2021 10:07:39 -0700 (PDT)
Received: from localhost.localdomain ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id h2sm679666lfc.172.2021.08.20.10.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 10:07:38 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH RFC 1/3] staging: r8188eu: add proper rtw_read* error handling
Date:   Fri, 20 Aug 2021 20:07:36 +0300
Message-Id: <f4fb967c992c29c8d2e8f67e78835b52a60d2e52.1629479152.git.paskripkin@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629479152.git.paskripkin@gmail.com>
References: <cover.1629479152.git.paskripkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_read*() functions call usb_read* inside. These functions could fail
in some cases; for example: failed to receive control message. These
cases should be handled to prevent uninit value bugs, since usb_read*
functions blindly return stack variable without checking if this value
_actualy_ initialized.

To achive it, all usb_read* and rtw_read*() argument list is expanded
with pointer to error and added error usbctrl_vendorreq() error checking.
If transfer is successful error will be initialized to 0 otherwise to
error returned from usb_control_msg().

To not break the build, added error checking for rtw_read*() call all
across the driver.

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_debug.c      |  79 +++-
 drivers/staging/r8188eu/core/rtw_efuse.c      |  83 +++-
 drivers/staging/r8188eu/core/rtw_io.c         |  18 +-
 drivers/staging/r8188eu/core/rtw_mp.c         |  37 +-
 drivers/staging/r8188eu/core/rtw_mp_ioctl.c   |  20 +-
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    |   6 +-
 drivers/staging/r8188eu/core/rtw_sreset.c     |   7 +-
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    |   9 +-
 drivers/staging/r8188eu/hal/hal_com.c         |  22 +-
 drivers/staging/r8188eu/hal/odm_interface.c   |  12 +-
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  37 +-
 drivers/staging/r8188eu/hal/rtl8188e_dm.c     |   6 +-
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 198 +++++++--
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |  26 +-
 drivers/staging/r8188eu/hal/rtl8188e_sreset.c |  20 +-
 drivers/staging/r8188eu/hal/rtl8188eu_led.c   |  17 +-
 drivers/staging/r8188eu/hal/usb_halinit.c     | 394 ++++++++++++++----
 drivers/staging/r8188eu/hal/usb_ops_linux.c   |  16 +-
 drivers/staging/r8188eu/include/rtw_io.h      |  18 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 168 +++++---
 20 files changed, 941 insertions(+), 252 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_debug.c b/drivers/staging/r8188eu/core/rtw_debug.c
index 2ee64cef73f7..9f8df3cf3070 100644
--- a/drivers/staging/r8188eu/core/rtw_debug.c
+++ b/drivers/staging/r8188eu/core/rtw_debug.c
@@ -73,8 +73,9 @@ int proc_get_read_reg(char *page, char **start,
 {
 	struct net_device *dev = data;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-
+	int error;
 	int len = 0;
+	u32 tmp;
 
 	if (proc_get_read_addr == 0xeeeeeeee) {
 		*eof = 1;
@@ -83,19 +84,35 @@ int proc_get_read_reg(char *page, char **start,
 
 	switch (proc_get_read_len) {
 	case 1:
-		len += snprintf(page + len, count - len, "rtw_read8(0x%x)=0x%x\n", proc_get_read_addr, rtw_read8(padapter, proc_get_read_addr));
+		tmp = rtw_read8(padapter, proc_get_read_addr, &error);
+
+		if (error)
+			goto end;
+
+		len += snprintf(page + len, count - len, "rtw_read8(0x%x)=0x%x\n", proc_get_read_addr, (u8) tmp);
 		break;
 	case 2:
-		len += snprintf(page + len, count - len, "rtw_read16(0x%x)=0x%x\n", proc_get_read_addr, rtw_read16(padapter, proc_get_read_addr));
+		tmp = rtw_read16(padapter, proc_get_read_addr, &error);
+
+		if (error)
+			goto end;
+
+		len += snprintf(page + len, count - len, "rtw_read16(0x%x)=0x%x\n", proc_get_read_addr, (u16) tmp);
 		break;
 	case 4:
-		len += snprintf(page + len, count - len, "rtw_read32(0x%x)=0x%x\n", proc_get_read_addr, rtw_read32(padapter, proc_get_read_addr));
+		tmp = rtw_read32(padapter, proc_get_read_addr, &error);
+
+		if (error)
+			goto end;
+
+		len += snprintf(page + len, count - len, "rtw_read32(0x%x)=0x%x\n", proc_get_read_addr, tmp);
 		break;
 	default:
 		len += snprintf(page + len, count - len, "error read length=%d\n", proc_get_read_len);
 		break;
 	}
 
+end:
 	*eof = 1;
 	return len;
 }
@@ -305,13 +322,20 @@ int proc_get_mac_reg_dump1(char *page, char **start,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	int len = 0;
 	int i, j = 1;
+	int error;
+	u32 tmp;
 
 	len += snprintf(page + len, count - len, "\n======= MAC REG =======\n");
 
 	for (i = 0x0; i < 0x300; i += 4) {
 		if (j % 4 == 1)
 			len += snprintf(page + len, count - len, "0x%02x", i);
-		len += snprintf(page + len, count - len, " 0x%08x ", rtw_read32(padapter, i));
+
+		tmp = rtw_read32(padapter, i, &error);
+		if (error)
+			return len;
+	
+		len += snprintf(page + len, count - len, " 0x%08x ", tmp);
 		if ((j++) % 4 == 0)
 			len += snprintf(page + len, count - len, "\n");
 	}
@@ -328,13 +352,20 @@ int proc_get_mac_reg_dump2(char *page, char **start,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	int len = 0;
 	int i, j = 1;
+	int error;
+	u32 tmp;
 
 	len += snprintf(page + len, count - len, "\n======= MAC REG =======\n");
 	memset(page, 0, count);
 	for (i = 0x300; i < 0x600; i += 4) {
 		if (j % 4 == 1)
 			len += snprintf(page + len, count - len, "0x%02x", i);
-		len += snprintf(page + len, count - len, " 0x%08x ", rtw_read32(padapter, i));
+	
+		tmp = rtw_read32(padapter, i, &error);
+		if (error)
+			return len;
+
+		len += snprintf(page + len, count - len, " 0x%08x ", tmp);
 		if ((j++) % 4 == 0)
 			len += snprintf(page + len, count - len, "\n");
 	}
@@ -351,13 +382,20 @@ int proc_get_mac_reg_dump3(char *page, char **start,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	int len = 0;
 	int i, j = 1;
+	int error;
+	u32 tmp;
 
 	len += snprintf(page + len, count - len, "\n======= MAC REG =======\n");
 
 	for (i = 0x600; i < 0x800; i += 4) {
 		if (j % 4 == 1)
 			len += snprintf(page + len, count - len, "0x%02x", i);
-		len += snprintf(page + len, count - len, " 0x%08x ", rtw_read32(padapter, i));
+		
+		tmp = rtw_read32(padapter, i, &error);
+		if (error)
+			return len;
+
+		len += snprintf(page + len, count - len, " 0x%08x ", tmp);
 		if ((j++) % 4 == 0)
 			len += snprintf(page + len, count - len, "\n");
 	}
@@ -374,12 +412,19 @@ int proc_get_bb_reg_dump1(char *page, char **start,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	int len = 0;
 	int i, j = 1;
+	int error;
+	u32 tmp;
 
 	len += snprintf(page + len, count - len, "\n======= BB REG =======\n");
 	for (i = 0x800; i < 0xB00; i += 4) {
 		if (j % 4 == 1)
 			len += snprintf(page + len, count - len, "0x%02x", i);
-		len += snprintf(page + len, count - len, " 0x%08x ", rtw_read32(padapter, i));
+
+		tmp = rtw_read32(padapter, i, &error);
+		if (error)
+			return len;
+
+		len += snprintf(page + len, count - len, " 0x%08x ", tmp);
 		if ((j++) % 4 == 0)
 			len += snprintf(page + len, count - len, "\n");
 	}
@@ -395,12 +440,19 @@ int proc_get_bb_reg_dump2(char *page, char **start,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	int len = 0;
 	int i, j = 1;
+	int error;
+	u32 tmp;
 
 	len += snprintf(page + len, count - len, "\n======= BB REG =======\n");
 	for (i = 0xB00; i < 0xE00; i += 4) {
 		if (j % 4 == 1)
 			len += snprintf(page + len, count - len, "0x%02x", i);
-		len += snprintf(page + len, count - len, " 0x%08x ", rtw_read32(padapter, i));
+
+		tmp = rtw_read32(padapter, i, &error);
+		if (error)
+			return len;
+
+		len += snprintf(page + len, count - len, " 0x%08x ", tmp);
 		if ((j++) % 4 == 0)
 			len += snprintf(page + len, count - len, "\n");
 	}
@@ -416,12 +468,19 @@ int proc_get_bb_reg_dump3(char *page, char **start,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	int len = 0;
 	int i, j = 1;
+	int error;
+	u32 tmp;
 
 	len += snprintf(page + len, count - len, "\n======= BB REG =======\n");
 	for (i = 0xE00; i < 0x1000; i += 4) {
 		if (j % 4 == 1)
 			len += snprintf(page + len, count - len, "0x%02x", i);
-		len += snprintf(page + len, count - len, " 0x%08x ", rtw_read32(padapter, i));
+		
+		tmp = rtw_read32(padapter, i, &error);
+		if (error)
+			return len;
+
+		len += snprintf(page + len, count - len, " 0x%08x ", tmp);
 		if ((j++) % 4 == 0)
 			len += snprintf(page + len, count - len, "\n");
 	}
diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index decccf7622f0..47ff73b28380 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -159,6 +159,7 @@ ReadEFuseByte(
 	u32 value32;
 	u8 readbyte;
 	u16 retry;
+	int error;
 
 	if (pseudo) {
 		Efuse_Read1ByteFromFakeContent(Adapter, _offset, pbuf);
@@ -167,18 +168,27 @@ ReadEFuseByte(
 
 	/* Write Address */
 	rtw_write8(Adapter, EFUSE_CTRL + 1, (_offset & 0xff));
-	readbyte = rtw_read8(Adapter, EFUSE_CTRL + 2);
+	readbyte = rtw_read8(Adapter, EFUSE_CTRL + 2, &error);
+	if (error)
+		return;
 	rtw_write8(Adapter, EFUSE_CTRL + 2, ((_offset >> 8) & 0x03) | (readbyte & 0xfc));
 
 	/* Write bit 32 0 */
-	readbyte = rtw_read8(Adapter, EFUSE_CTRL + 3);
+	readbyte = rtw_read8(Adapter, EFUSE_CTRL + 3, &error);
+	if (error)
+		return;
 	rtw_write8(Adapter, EFUSE_CTRL + 3, (readbyte & 0x7f));
 
 	/* Check bit 32 read-ready */
 	retry = 0;
-	value32 = rtw_read32(Adapter, EFUSE_CTRL);
+	value32 = rtw_read32(Adapter, EFUSE_CTRL, &error);
+	if (error)
+		return;
+
 	while (!(((value32 >> 24) & 0xff) & 0x80)  && (retry < 10000)) {
-		value32 = rtw_read32(Adapter, EFUSE_CTRL);
+		value32 = rtw_read32(Adapter, EFUSE_CTRL, &error);
+		if (error)
+			return;
 		retry++;
 	}
 
@@ -187,7 +197,9 @@ ReadEFuseByte(
 	/*  Designer says that there shall be some delay after ready bit is set, or the */
 	/*  result will always stay on last data we read. */
 	udelay(50);
-	value32 = rtw_read32(Adapter, EFUSE_CTRL);
+	value32 = rtw_read32(Adapter, EFUSE_CTRL, &error);
+	if (error)
+		return;
 
 	*pbuf = (u8)(value32 & 0xff);
 }
@@ -244,6 +256,7 @@ u8 EFUSE_Read1Byte(struct adapter *Adapter, u16 Address)
 	u8 temp = {0x00};
 	u32 k = 0;
 	u16 contentLen = 0;
+	int error;
 
 	EFUSE_GetEfuseDefinition(Adapter, EFUSE_WIFI, TYPE_EFUSE_REAL_CONTENT_LEN, (void *)&contentLen, false);
 
@@ -251,27 +264,41 @@ u8 EFUSE_Read1Byte(struct adapter *Adapter, u16 Address)
 		/* Write E-fuse Register address bit0~7 */
 		temp = Address & 0xFF;
 		rtw_write8(Adapter, EFUSE_CTRL + 1, temp);
-		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL + 2);
+		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL + 2, &error);
+		if (error)
+			return 0xFF;
+
 		/* Write E-fuse Register address bit8~9 */
 		temp = ((Address >> 8) & 0x03) | (Bytetemp & 0xFC);
 		rtw_write8(Adapter, EFUSE_CTRL + 2, temp);
 
 		/* Write 0x30[31]= 0 */
-		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL + 3);
+		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL + 3, &error);
+		if (error)
+			return 0xFF;
+
 		temp = Bytetemp & 0x7F;
 		rtw_write8(Adapter, EFUSE_CTRL + 3, temp);
 
 		/* Wait Write-ready (0x30[31]= 1) */
-		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL + 3);
+		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL + 3, &error);
+		if (error)
+			return 0xFF;
+
 		while (!(Bytetemp & 0x80)) {
-			Bytetemp = rtw_read8(Adapter, EFUSE_CTRL + 3);
+			Bytetemp = rtw_read8(Adapter, EFUSE_CTRL + 3, &error);
+			if (error)
+				return 0xFF;
+
 			k++;
 			if (k == 1000) {
 				k = 0;
 				break;
 			}
 		}
-		data = rtw_read8(Adapter, EFUSE_CTRL);
+		data = rtw_read8(Adapter, EFUSE_CTRL, &error);
+		if (error)
+			return 0xFF;
 		return data;
 	} else {
 		return 0xFF;
@@ -284,6 +311,8 @@ u8 efuse_OneByteRead(struct adapter *pAdapter, u16 addr, u8 *data, bool pseudo)
 {
 	u8 tmpidx = 0;
 	u8 result;
+	u8 tmp;
+	int error;
 
 	if (pseudo) {
 		result = Efuse_Read1ByteFromFakeContent(pAdapter, addr, data);
@@ -292,15 +321,28 @@ u8 efuse_OneByteRead(struct adapter *pAdapter, u16 addr, u8 *data, bool pseudo)
 	/*  -----------------e-fuse reg ctrl --------------------------------- */
 	/* address */
 	rtw_write8(pAdapter, EFUSE_CTRL + 1, (u8)(addr & 0xff));
+	
+	tmp = rtw_read8(pAdapter, EFUSE_CTRL + 2, &error);
+	if (error)
+		return false;
+
 	rtw_write8(pAdapter, EFUSE_CTRL + 2, ((u8)((addr >> 8) & 0x03)) |
-		   (rtw_read8(pAdapter, EFUSE_CTRL + 2) & 0xFC));
+		   (tmp & 0xFC));
 
 	rtw_write8(pAdapter, EFUSE_CTRL + 3,  0x72);/* read cmd */
 
-	while (!(0x80 & rtw_read8(pAdapter, EFUSE_CTRL + 3)) && (tmpidx < 100))
+	tmp = rtw_read8(pAdapter, EFUSE_CTRL + 3, &error);
+	if (error)
+		return false;
+
+	while (!(0x80 & tmp) && (tmpidx < 100))
 		tmpidx++;
 	if (tmpidx < 100) {
-		*data = rtw_read8(pAdapter, EFUSE_CTRL);
+		tmp = rtw_read8(pAdapter, EFUSE_CTRL, &error);\
+		if (error)
+			return false;
+
+		*data = tmp;
 		result = true;
 	} else {
 		*data = 0xff;
@@ -314,6 +356,8 @@ u8 efuse_OneByteWrite(struct adapter *pAdapter, u16 addr, u8 data, bool pseudo)
 {
 	u8 tmpidx = 0;
 	u8 result;
+	u8 tmp;
+	int error;
 
 	if (pseudo) {
 		result = Efuse_Write1ByteToFakeContent(pAdapter, addr, data);
@@ -323,14 +367,23 @@ u8 efuse_OneByteWrite(struct adapter *pAdapter, u16 addr, u8 data, bool pseudo)
 	/*  -----------------e-fuse reg ctrl --------------------------------- */
 	/* address */
 	rtw_write8(pAdapter, EFUSE_CTRL + 1, (u8)(addr & 0xff));
+	
+	tmp = rtw_read8(pAdapter, EFUSE_CTRL + 2, &error);
+	if (error)
+		return false;
+
 	rtw_write8(pAdapter, EFUSE_CTRL + 2,
-		   (rtw_read8(pAdapter, EFUSE_CTRL + 2) & 0xFC) |
+		   (tmp & 0xFC) |
 		   (u8)((addr >> 8) & 0x03));
 	rtw_write8(pAdapter, EFUSE_CTRL, data);/* data */
 
 	rtw_write8(pAdapter, EFUSE_CTRL + 3, 0xF2);/* write cmd */
 
-	while ((0x80 &  rtw_read8(pAdapter, EFUSE_CTRL + 3)) && (tmpidx < 100))
+	tmp = rtw_read8(pAdapter, EFUSE_CTRL + 3, &error);
+	if (error)
+		return false;
+
+	while ((0x80 & tmp) && (tmpidx < 100))
 		tmpidx++;
 
 	if (tmpidx < 100)
diff --git a/drivers/staging/r8188eu/core/rtw_io.c b/drivers/staging/r8188eu/core/rtw_io.c
index cde0205816b1..d9684aa144c8 100644
--- a/drivers/staging/r8188eu/core/rtw_io.c
+++ b/drivers/staging/r8188eu/core/rtw_io.c
@@ -34,44 +34,44 @@ jackson@realtek.com.tw
 #define rtw_cpu_to_le16(val)		cpu_to_le16(val)
 #define rtw_cpu_to_le32(val)		cpu_to_le32(val)
 
-u8 _rtw_read8(struct adapter *adapter, u32 addr)
+u8 _rtw_read8(struct adapter *adapter, u32 addr, int *error)
 {
 	u8 r_val;
 	struct io_priv *pio_priv = &adapter->iopriv;
 	struct	intf_hdl *pintfhdl = &pio_priv->intf;
-	u8 (*_read8)(struct intf_hdl *pintfhdl, u32 addr);
+	u8 (*_read8)(struct intf_hdl *pintfhdl, u32 addr, int *error);
 
 
 	_read8 = pintfhdl->io_ops._read8;
-	r_val = _read8(pintfhdl, addr);
+	r_val = _read8(pintfhdl, addr, error);
 
 	return r_val;
 }
 
-u16 _rtw_read16(struct adapter *adapter, u32 addr)
+u16 _rtw_read16(struct adapter *adapter, u32 addr, int *error)
 {
 	u16 r_val;
 	struct io_priv *pio_priv = &adapter->iopriv;
 	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
-	u16 (*_read16)(struct intf_hdl *pintfhdl, u32 addr);
+	u16 (*_read16)(struct intf_hdl *pintfhdl, u32 addr, int *error);
 
 	_read16 = pintfhdl->io_ops._read16;
 
-	r_val = _read16(pintfhdl, addr);
+	r_val = _read16(pintfhdl, addr, error);
 
 	return r_val;
 }
 
-u32 _rtw_read32(struct adapter *adapter, u32 addr)
+u32 _rtw_read32(struct adapter *adapter, u32 addr, int *error)
 {
 	u32 r_val;
 	struct io_priv *pio_priv = &adapter->iopriv;
 	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
-	u32	(*_read32)(struct intf_hdl *pintfhdl, u32 addr);
+	u32	(*_read32)(struct intf_hdl *pintfhdl, u32 addr, int *error);
 
 	_read32 = pintfhdl->io_ops._read32;
 
-	r_val = _read32(pintfhdl, addr);
+	r_val = _read32(pintfhdl, addr, error);
 
 	return r_val;
 }
diff --git a/drivers/staging/r8188eu/core/rtw_mp.c b/drivers/staging/r8188eu/core/rtw_mp.c
index 93bb683b628f..601a1fd5d4e7 100644
--- a/drivers/staging/r8188eu/core/rtw_mp.c
+++ b/drivers/staging/r8188eu/core/rtw_mp.c
@@ -10,16 +10,17 @@
 u32 read_macreg(struct adapter *padapter, u32 addr, u32 sz)
 {
 	u32 val = 0;
+	int error;
 
 	switch (sz) {
 	case 1:
-		val = rtw_read8(padapter, addr);
+		val = rtw_read8(padapter, addr, &error);
 		break;
 	case 2:
-		val = rtw_read16(padapter, addr);
+		val = rtw_read16(padapter, addr, &error);
 		break;
 	case 4:
-		val = rtw_read32(padapter, addr);
+		val = rtw_read32(padapter, addr, &error);
 		break;
 	default:
 		val = 0xffffffff;
@@ -282,10 +283,14 @@ void GetPowerTracking(struct adapter *padapter, u8 *enable)
 static void disable_dm(struct adapter *padapter)
 {
 	u8 v8;
+	int error;
 
 	/* 3 1. disable firmware dynamic mechanism */
 	/*  disable Power Training, Rate Adaptive */
-	v8 = rtw_read8(padapter, REG_BCN_CTRL);
+	v8 = rtw_read8(padapter, REG_BCN_CTRL, &error);
+	if (error)
+		return;
+
 	v8 &= ~EN_BCN_FUNCTION;
 	rtw_write8(padapter, REG_BCN_CTRL, v8);
 
@@ -310,6 +315,7 @@ s32 mp_start_test(struct adapter *padapter)
 	struct mp_priv *pmppriv = &padapter->mppriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct wlan_network *tgt_network = &pmlmepriv->cur_network;
+	int error;
 
 	padapter->registrypriv.mp_mode = 1;
 	pmppriv->bSetTxPower = 0;		/* for  manually set tx power */
@@ -403,7 +409,11 @@ s32 mp_start_test(struct adapter *padapter)
 
 	if (res == _SUCCESS) {
 		/*  set MSR to WIFI_FW_ADHOC_STATE */
-		val8 = rtw_read8(padapter, MSR) & 0xFC; /*  0x0102 */
+		val8 = rtw_read8(padapter, MSR, &error);
+		if (error)
+			return _FAIL;
+
+		val8 &= 0xFC; /*  0x0102 */
 		val8 |= WIFI_FW_ADHOC_STATE;
 		rtw_write8(padapter, MSR, val8); /*  Link in ad hoc network */
 	}
@@ -795,12 +805,17 @@ static u32 GetPhyRxPktCounts(struct adapter *pAdapter, u32 selbit)
 {
 	/* selection */
 	u32 phyrx_set = 0, count = 0;
+	int error;
 
 	phyrx_set = _RXERR_RPT_SEL(selbit & 0xF);
 	rtw_write32(pAdapter, REG_RXERR_RPT, phyrx_set);
 
 	/* Read packet count */
-	count = rtw_read32(pAdapter, REG_RXERR_RPT) & RXERR_COUNTER_MASK;
+	count = rtw_read32(pAdapter, REG_RXERR_RPT, &error);
+	if (error)
+		return 0;
+
+	count &= RXERR_COUNTER_MASK;
 
 	return count;
 }
@@ -833,8 +848,12 @@ u32 GetPhyRxPktCRC32Error(struct adapter *pAdapter)
 static u32 rtw_GetPSDData(struct adapter *pAdapter, u32 point)
 {
 	int psd_val;
+	int error;
+
+	psd_val = rtw_read32(pAdapter, 0x808, &error);
+	if (error)
+		return error;
 
-	psd_val = rtw_read32(pAdapter, 0x808);
 	psd_val &= 0xFFBFFC00;
 	psd_val |= point;
 
@@ -844,7 +863,9 @@ static u32 rtw_GetPSDData(struct adapter *pAdapter, u32 point)
 
 	rtw_write32(pAdapter, 0x808, psd_val);
 	mdelay(1);
-	psd_val = rtw_read32(pAdapter, 0x8B4);
+	psd_val = rtw_read32(pAdapter, 0x8B4, &error);
+	if (error)
+		return error;
 
 	psd_val &= 0x0000FFFF;
 
diff --git a/drivers/staging/r8188eu/core/rtw_mp_ioctl.c b/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
index c85f8e467337..ad004b176f94 100644
--- a/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
+++ b/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
@@ -629,9 +629,10 @@ int rtl8188eu_oid_rt_pro8711_join_bss_hdl(struct oid_par_priv *poid_par_priv)
 int rtl8188eu_oid_rt_pro_read_register_hdl(struct oid_par_priv *poid_par_priv)
 {
 	struct mp_rw_reg *RegRWStruct;
-	u32		offset, width;
+	u32		offset, width, tmp;
 	int status = NDIS_STATUS_SUCCESS;
 	struct adapter *Adapter = (struct adapter *)(poid_par_priv->adapter_context);
+	int error;
 
 	if (poid_par_priv->type_of_oid != QUERY_OID)
 		return NDIS_STATUS_NOT_ACCEPTED;
@@ -647,17 +648,28 @@ int rtl8188eu_oid_rt_pro_read_register_hdl(struct oid_par_priv *poid_par_priv)
 
 	switch (width) {
 	case 1:
-		RegRWStruct->value = rtw_read8(Adapter, offset);
+		tmp = rtw_read8(Adapter, offset, &error);
+		if (error)
+			return NDIS_STATUS_FAILURE;
+
 		break;
 	case 2:
-		RegRWStruct->value = rtw_read16(Adapter, offset);
+		tmp = rtw_read16(Adapter, offset, &error);
+		if (error)
+			return NDIS_STATUS_FAILURE;
+
 		break;
 	default:
 		width = 4;
-		RegRWStruct->value = rtw_read32(Adapter, offset);
+		tmp = rtw_read32(Adapter, offset, &error);
+		if (error)
+			return NDIS_STATUS_FAILURE;
+
 		break;
 	}
 
+	RegRWStruct->value = tmp;
+
 	_irqlevel_changed_(&oldirql, RAISE);
 
 	*poid_par_priv->bytes_rw = width;
diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index c3897b29121c..f4accd0b01d8 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -55,6 +55,8 @@ int ips_leave(struct adapter *padapter)
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	int result = _SUCCESS;
 	int keyid;
+	u32 tmp;
+	int error;
 
 	_enter_pwrlock(&pwrpriv->lock);
 
@@ -83,7 +85,9 @@ int ips_leave(struct adapter *padapter)
 			}
 		}
 
-		DBG_88E("==> ips_leave.....LED(0x%08x)...\n", rtw_read32(padapter, 0x4c));
+		tmp = rtw_read32(padapter, 0x4c, &error);
+		if (!error)
+			DBG_88E("==> ips_leave.....LED(0x%08x)...\n", tmp);
 		pwrpriv->bips_processing = false;
 
 		pwrpriv->bkeepfwalive = false;
diff --git a/drivers/staging/r8188eu/core/rtw_sreset.c b/drivers/staging/r8188eu/core/rtw_sreset.c
index 8e1bc62e74e5..1ac3f5c6bdec 100644
--- a/drivers/staging/r8188eu/core/rtw_sreset.c
+++ b/drivers/staging/r8188eu/core/rtw_sreset.c
@@ -29,13 +29,16 @@ u8 sreset_get_wifi_status(struct adapter *padapter)
 {
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(padapter);
 	struct sreset_priv *psrtpriv = &pHalData->srestpriv;
-
+	int error;
 	u8 status = WIFI_STATUS_SUCCESS;
 	u32 val32 = 0;
 
 	if (psrtpriv->silent_reset_inprogress)
 		return status;
-	val32 = rtw_read32(padapter, REG_TXDMA_STATUS);
+	val32 = rtw_read32(padapter, REG_TXDMA_STATUS, &error);
+	if (error)
+		return WIFI_MAC_TXDMA_ERROR;
+
 	if (val32 == 0xeaeaeaea) {
 		psrtpriv->Wifi_Error_Status = WIFI_IF_NOT_EXIST;
 	} else if (val32 != 0) {
diff --git a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
index 0fd11aca7ac7..ed24d904e3f6 100644
--- a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
+++ b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
@@ -35,6 +35,7 @@ u8 HalPwrSeqCmdParsing(struct adapter *padapter, u8 cut_vers, u8 fab_vers,
 	u32 offset = 0;
 	u32 poll_count = 0; /*  polling autoload done. */
 	u32 max_poll_count = 5000;
+	int error;
 
 	do {
 		pwrcfgcmd = pwrseqcmd[aryidx];
@@ -48,7 +49,9 @@ u8 HalPwrSeqCmdParsing(struct adapter *padapter, u8 cut_vers, u8 fab_vers,
 				offset = GET_PWR_CFG_OFFSET(pwrcfgcmd);
 
 				/*  Read the value from system register */
-				value = rtw_read8(padapter, offset);
+				value = rtw_read8(padapter, offset, &error);
+				if (error)
+					return false;
 
 				value &= ~(GET_PWR_CFG_MASK(pwrcfgcmd));
 				value |= (GET_PWR_CFG_VALUE(pwrcfgcmd) & GET_PWR_CFG_MASK(pwrcfgcmd));
@@ -60,7 +63,9 @@ u8 HalPwrSeqCmdParsing(struct adapter *padapter, u8 cut_vers, u8 fab_vers,
 				poll_bit = false;
 				offset = GET_PWR_CFG_OFFSET(pwrcfgcmd);
 				do {
-					value = rtw_read8(padapter, offset);
+					value = rtw_read8(padapter, offset, &error);
+					if (error)
+						return false;
 
 					value &= GET_PWR_CFG_MASK(pwrcfgcmd);
 					if (value == (GET_PWR_CFG_VALUE(pwrcfgcmd) & GET_PWR_CFG_MASK(pwrcfgcmd)))
diff --git a/drivers/staging/r8188eu/hal/hal_com.c b/drivers/staging/r8188eu/hal/hal_com.c
index f09d4d49b159..b6cbbf2275c3 100644
--- a/drivers/staging/r8188eu/hal/hal_com.c
+++ b/drivers/staging/r8188eu/hal/hal_com.c
@@ -319,13 +319,15 @@ s32 c2h_evt_read(struct adapter *adapter, u8 *buf)
 {
 	s32 ret = _FAIL;
 	struct c2h_evt_hdr *c2h_evt;
-	int i;
+	int i, error;
 	u8 trigger;
 
 	if (!buf)
 		goto exit;
 
-	trigger = rtw_read8(adapter, REG_C2HEVT_CLEAR);
+	trigger = rtw_read8(adapter, REG_C2HEVT_CLEAR, &error);
+	if (error)
+		goto exit;
 
 	if (trigger == C2H_EVT_HOST_CLOSE)
 		goto exit; /* Not ready */
@@ -336,13 +338,21 @@ s32 c2h_evt_read(struct adapter *adapter, u8 *buf)
 
 	memset(c2h_evt, 0, 16);
 
-	*buf = rtw_read8(adapter, REG_C2HEVT_MSG_NORMAL);
-	*(buf + 1) = rtw_read8(adapter, REG_C2HEVT_MSG_NORMAL + 1);
+	*buf = rtw_read8(adapter, REG_C2HEVT_MSG_NORMAL, &error);
+	if (error)
+		goto clear_evt;
+
+	*(buf + 1) = rtw_read8(adapter, REG_C2HEVT_MSG_NORMAL + 1, &error);
+	if (error)
+		;
 
 	/* Read the content */
-	for (i = 0; i < c2h_evt->plen; i++)
+	for (i = 0; i < c2h_evt->plen; i++) {
 		c2h_evt->payload[i] = rtw_read8(adapter, REG_C2HEVT_MSG_NORMAL +
-						sizeof(*c2h_evt) + i);
+						sizeof(*c2h_evt) + i, &error);
+		if (error)
+			goto clear_evt;
+	}
 
 	ret = _SUCCESS;
 
diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index 5a01495d74bc..cedc68152401 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -7,19 +7,25 @@
 u8 ODM_Read1Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr)
 {
 	struct adapter *Adapter = pDM_Odm->Adapter;
-	return rtw_read8(Adapter, RegAddr);
+	int error;
+
+	return rtw_read8(Adapter, RegAddr, &error);
 }
 
 u16 ODM_Read2Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr)
 {
 	struct adapter *Adapter = pDM_Odm->Adapter;
-	return rtw_read16(Adapter, RegAddr);
+	int error;
+
+	return rtw_read16(Adapter, RegAddr, &error);
 }
 
 u32 ODM_Read4Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr)
 {
 	struct adapter *Adapter = pDM_Odm->Adapter;
-	return rtw_read32(Adapter, RegAddr);
+	int error;
+
+	return rtw_read32(Adapter, RegAddr, &error);
 }
 
 void ODM_Write1Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u8 Data)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index 3e1a45030bc8..4447fa8de275 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -21,11 +21,15 @@ static u8 _is_fw_read_cmd_down(struct adapter *adapt, u8 msgbox_num)
 {
 	u8 read_down = false;
 	int	retry_cnts = 100;
-
+	int error;
 	u8 valid;
 
 	do {
-		valid = rtw_read8(adapt, REG_HMETFR) & BIT(msgbox_num);
+		valid = rtw_read8(adapt, REG_HMETFR, &error);
+		if (error)
+			continue;
+
+		valid &= BIT(msgbox_num);
 		if (0 == valid)
 			read_down = true;
 	} while ((!read_down) && (retry_cnts--));
@@ -580,6 +584,8 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 	bool	bcn_valid = false;
 	u8 DLBcnCount = 0;
 	u32 poll = 0;
+	u8 tmp;
+	int error;
 
 	DBG_88E("%s mstatus(%x)\n", __func__, mstatus);
 
@@ -596,8 +602,17 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 		/*  Disable Hw protection for a time which revserd for Hw sending beacon. */
 		/*  Fix download reserved page packet fail that access collision with the protection time. */
 		/*  2010.05.11. Added by tynli. */
-		rtw_write8(adapt, REG_BCN_CTRL, rtw_read8(adapt, REG_BCN_CTRL) & (~BIT(3)));
-		rtw_write8(adapt, REG_BCN_CTRL, rtw_read8(adapt, REG_BCN_CTRL) | BIT(4));
+		tmp = rtw_read8(adapt, REG_BCN_CTRL, &error);
+		if (error)
+			return;
+
+		rtw_write8(adapt, REG_BCN_CTRL, tmp & (~BIT(3)));
+
+		tmp = rtw_read8(adapt, REG_BCN_CTRL, &error);
+		if (error)
+			return;
+
+		rtw_write8(adapt, REG_BCN_CTRL, tmp | BIT(4));
 
 		if (haldata->RegFwHwTxQCtrl & BIT(6)) {
 			DBG_88E("HalDownloadRSVDPage(): There is an Adapter is sending beacon.\n");
@@ -639,8 +654,18 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 		/*  */
 
 		/*  Enable Bcn */
-		rtw_write8(adapt, REG_BCN_CTRL, rtw_read8(adapt, REG_BCN_CTRL) | BIT(3));
-		rtw_write8(adapt, REG_BCN_CTRL, rtw_read8(adapt, REG_BCN_CTRL) & (~BIT(4)));
+
+		tmp = rtw_read8(adapt, REG_BCN_CTRL, &error);
+		if (error)
+			return;
+
+		rtw_write8(adapt, REG_BCN_CTRL, tmp | BIT(3));
+
+		tmp = rtw_read8(adapt, REG_BCN_CTRL, &error);
+		if (error)
+			return;
+
+		rtw_write8(adapt, REG_BCN_CTRL, tmp & (~BIT(4)));
 
 		/*  To make sure that if there exists an adapter which would like to send beacon. */
 		/*  If exists, the origianl value of 0x422[6] will be 1, we should check this to */
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index 78552303c990..c645d7fc8e8b 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -16,8 +16,12 @@ static void dm_CheckStatistics(struct adapter *Adapter)
 static void dm_InitGPIOSetting(struct adapter *Adapter)
 {
 	u8	tmp1byte;
+	int error;
+
+	tmp1byte = rtw_read8(Adapter, REG_GPIO_MUXCFG, &error);
+	if (error)
+		return;
 
-	tmp1byte = rtw_read8(Adapter, REG_GPIO_MUXCFG);
 	tmp1byte &= (GPIOSEL_GPIO | ~GPIOSEL_ENBT);
 
 	rtw_write8(Adapter, REG_GPIO_MUXCFG, tmp1byte);
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 393969f51206..0a2c08a24ad8 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -13,10 +13,14 @@
 static void iol_mode_enable(struct adapter *padapter, u8 enable)
 {
 	u8 reg_0xf0 = 0;
+	int error;
 
 	if (enable) {
 		/* Enable initial offload */
-		reg_0xf0 = rtw_read8(padapter, REG_SYS_CFG);
+		reg_0xf0 = rtw_read8(padapter, REG_SYS_CFG, &error);
+		if (error)
+			return;
+
 		rtw_write8(padapter, REG_SYS_CFG, reg_0xf0 | SW_OFFLOAD_EN);
 
 		if (!padapter->bFWReady) {
@@ -26,7 +30,10 @@ static void iol_mode_enable(struct adapter *padapter, u8 enable)
 
 	} else {
 		/* disable initial offload */
-		reg_0xf0 = rtw_read8(padapter, REG_SYS_CFG);
+		reg_0xf0 = rtw_read8(padapter, REG_SYS_CFG, &error);
+		if (error)
+			return;
+	
 		rtw_write8(padapter, REG_SYS_CFG, reg_0xf0 & ~SW_OFFLOAD_EN);
 	}
 }
@@ -36,18 +43,28 @@ static s32 iol_execute(struct adapter *padapter, u8 control)
 	s32 status = _FAIL;
 	u8 reg_0x88 = 0;
 	u32 start = 0, passing_time = 0;
+	int error;
 
 	control = control & 0x0f;
-	reg_0x88 = rtw_read8(padapter, REG_HMEBOX_E0);
+	reg_0x88 = rtw_read8(padapter, REG_HMEBOX_E0, &error);
+	if (error)
+		return status;
+
 	rtw_write8(padapter, REG_HMEBOX_E0,  reg_0x88 | control);
 
 	start = jiffies;
-	while ((reg_0x88 = rtw_read8(padapter, REG_HMEBOX_E0)) & control &&
-	       (passing_time = rtw_get_passing_time_ms(start)) < 1000) {
-		;
-	}
 
-	reg_0x88 = rtw_read8(padapter, REG_HMEBOX_E0);
+	do {
+		reg_0x88 = rtw_read8(padapter, REG_HMEBOX_E0, &error);
+		if (error)
+			return status;
+	} while (reg_0x88 & control &&
+	        (passing_time = rtw_get_passing_time_ms(start)) < 1000);
+
+	reg_0x88 = rtw_read8(padapter, REG_HMEBOX_E0, &error);
+	if (error)
+		return status;
+
 	status = (reg_0x88 & control) ? _FAIL : _SUCCESS;
 	if (reg_0x88 & control << 4)
 		status = _FAIL;
@@ -201,11 +218,15 @@ static void efuse_read_phymap_from_txpktbuf(
 	u16 len = 0, count = 0;
 	int i = 0;
 	u16 limit = *size;
+	int error;
 
 	u8 *pos = content;
 
-	if (bcnhead < 0) /* if not valid */
-		bcnhead = rtw_read8(adapter, REG_TDECTRL + 1);
+	if (bcnhead < 0) {	/* if not valid */
+		bcnhead = rtw_read8(adapter, REG_TDECTRL + 1, &error);
+		if (error)
+			return;
+	}
 
 	DBG_88E("%s bcnhead:%d\n", __func__, bcnhead);
 
@@ -218,22 +239,37 @@ static void efuse_read_phymap_from_txpktbuf(
 
 		rtw_write8(adapter, REG_TXPKTBUF_DBG, 0);
 		start = jiffies;
-		while (!(reg_0x143 = rtw_read8(adapter, REG_TXPKTBUF_DBG)) &&
+
+		reg_0x143 = rtw_read8(adapter, REG_TXPKTBUF_DBG, &error);
+		if (error)
+			return;
+
+		while (!reg_0x143 &&
 		       (passing_time = rtw_get_passing_time_ms(start)) < 1000) {
-			DBG_88E("%s polling reg_0x143:0x%02x, reg_0x106:0x%02x\n", __func__, reg_0x143, rtw_read8(adapter, 0x106));
+			DBG_88E("%s polling reg_0x143:0x%02x, reg_0x106:0x%02x\n", __func__, reg_0x143, rtw_read8(adapter, 0x106, &error));
 			rtw_usleep_os(100);
+
+			reg_0x143 = rtw_read8(adapter, REG_TXPKTBUF_DBG, &error);
+			if (error)
+				return;
 		}
 
 		/* data from EEPROM needs to be in LE */
-		lo32 = cpu_to_le32(rtw_read32(adapter, REG_PKTBUF_DBG_DATA_L));
-		hi32 = cpu_to_le32(rtw_read32(adapter, REG_PKTBUF_DBG_DATA_H));
+		lo32 = cpu_to_le32(rtw_read32(adapter, REG_PKTBUF_DBG_DATA_L, &error));
+		if (error)
+			return;
+		hi32 = cpu_to_le32(rtw_read32(adapter, REG_PKTBUF_DBG_DATA_H, &error));
+		if (error)
+			return;
 
 		if (i == 0) {
 			/* Although lenc is only used in a debug statement,
 			 * do not remove it as the rtw_read16() call consumes
 			 * 2 bytes from the EEPROM source.
 			 */
-			u16 lenc = rtw_read16(adapter, REG_PKTBUF_DBG_DATA_L);
+			u16 lenc = rtw_read16(adapter, REG_PKTBUF_DBG_DATA_L, &error);
+			if (error)
+				return;
 
 			len = le32_to_cpu(lo32) & 0x0000ffff;
 
@@ -342,6 +378,8 @@ void rtw_IOL_cmd_tx_pkt_buf_dump(struct adapter *Adapter, int data_len)
 	u32 addr, rstatus, loop = 0;
 	u16 data_cnts = (data_len / 8) + 1;
 	u8 *pbuf = vzalloc(data_len + 10);
+	int error;
+
 	DBG_88E("###### %s ######\n", __func__);
 
 	rtw_write8(Adapter, REG_PKT_BUFF_ACCESS_CTRL, TXPKT_BUF_SELECT);
@@ -351,12 +389,22 @@ void rtw_IOL_cmd_tx_pkt_buf_dump(struct adapter *Adapter, int data_len)
 			rtw_usleep_os(2);
 			loop = 0;
 			do {
-				rstatus = (reg_140 = rtw_read32(Adapter, REG_PKTBUF_DBG_CTRL) & BIT(24));
+				u32 tmp = rtw_read32(Adapter, REG_PKTBUF_DBG_CTRL, &error);
+
+				if (error)
+					break;
+
+				rstatus = (reg_140 = tmp & BIT(24));
 				if (rstatus) {
-					fifo_data = rtw_read32(Adapter, REG_PKTBUF_DBG_DATA_L);
+					fifo_data = rtw_read32(Adapter, REG_PKTBUF_DBG_DATA_L, &error);
+					if (error)
+						break;
+
 					memcpy(pbuf + (addr * 8), &fifo_data, 4);
 
-					fifo_data = rtw_read32(Adapter, REG_PKTBUF_DBG_DATA_H);
+					fifo_data = rtw_read32(Adapter, REG_PKTBUF_DBG_DATA_H, &error);
+					if (error)
+						break;
 					memcpy(pbuf + (addr * 8 + 4), &fifo_data, 4);
 				}
 				rtw_usleep_os(2);
@@ -371,18 +419,25 @@ void rtw_IOL_cmd_tx_pkt_buf_dump(struct adapter *Adapter, int data_len)
 static void _FWDownloadEnable(struct adapter *padapter, bool enable)
 {
 	u8 tmp;
+	int error;
 
 	if (enable) {
 		/*  MCU firmware download enable. */
-		tmp = rtw_read8(padapter, REG_MCUFWDL);
+		tmp = rtw_read8(padapter, REG_MCUFWDL, &error);
+		if (error)
+			return;
 		rtw_write8(padapter, REG_MCUFWDL, tmp | 0x01);
 
 		/*  8051 reset */
-		tmp = rtw_read8(padapter, REG_MCUFWDL + 2);
+		tmp = rtw_read8(padapter, REG_MCUFWDL + 2, &error);
+		if (error)
+			return;
 		rtw_write8(padapter, REG_MCUFWDL + 2, tmp & 0xf7);
 	} else {
 		/*  MCU firmware download disable. */
-		tmp = rtw_read8(padapter, REG_MCUFWDL);
+		tmp = rtw_read8(padapter, REG_MCUFWDL, &error);
+		if (error)
+			return;
 		rtw_write8(padapter, REG_MCUFWDL, tmp & 0xfe);
 
 		/*  Reserved for fw extension. */
@@ -452,8 +507,14 @@ static int _PageWrite(struct adapter *padapter, u32 page, void *buffer, u32 size
 {
 	u8 value8;
 	u8 u8Page = (u8)(page & 0x07);
+	int error;
+	u8 tmp;
 
-	value8 = (rtw_read8(padapter, REG_MCUFWDL + 2) & 0xF8) | u8Page;
+	tmp = rtw_read8(padapter, REG_MCUFWDL + 2, &error);
+	if (error)
+		return _FAIL;
+
+	value8 = (tmp & 0xF8) | u8Page;
 	rtw_write8(padapter, REG_MCUFWDL + 2, value8);
 
 	return _BlockWrite(padapter, buffer, size);
@@ -493,8 +554,12 @@ static int _WriteFW(struct adapter *padapter, void *buffer, u32 size)
 void _8051Reset88E(struct adapter *padapter)
 {
 	u8 u1bTmp;
+	int error;
+
+	u1bTmp = rtw_read8(padapter, REG_SYS_FUNC_EN + 1, &error);
+	if (error)
+		return;
 
-	u1bTmp = rtw_read8(padapter, REG_SYS_FUNC_EN + 1);
 	rtw_write8(padapter, REG_SYS_FUNC_EN + 1, u1bTmp & (~BIT(2)));
 	rtw_write8(padapter, REG_SYS_FUNC_EN + 1, u1bTmp | (BIT(2)));
 	DBG_88E("=====> _8051Reset88E(): 8051 reset success .\n");
@@ -504,10 +569,13 @@ static s32 _FWFreeToGo(struct adapter *padapter)
 {
 	u32	counter = 0;
 	u32	value32;
+	int error;
 
 	/*  polling CheckSum report */
 	do {
-		value32 = rtw_read32(padapter, REG_MCUFWDL);
+		value32 = rtw_read32(padapter, REG_MCUFWDL, &error);
+		if (error)
+			return _FAIL;
 		if (value32 & FWDL_ChkSum_rpt)
 			break;
 	} while (counter++ < POLLING_READY_TIMEOUT_COUNT);
@@ -518,7 +586,10 @@ static s32 _FWFreeToGo(struct adapter *padapter)
 	}
 	DBG_88E("%s: Checksum report OK! REG_MCUFWDL:0x%08x\n", __func__, value32);
 
-	value32 = rtw_read32(padapter, REG_MCUFWDL);
+	value32 = rtw_read32(padapter, REG_MCUFWDL, &error);
+	if (error)
+		return _FAIL;
+
 	value32 |= MCUFWDL_RDY;
 	value32 &= ~WINTINI_RDY;
 	rtw_write32(padapter, REG_MCUFWDL, value32);
@@ -528,7 +599,10 @@ static s32 _FWFreeToGo(struct adapter *padapter)
 	/*  polling for FW ready */
 	counter = 0;
 	do {
-		value32 = rtw_read32(padapter, REG_MCUFWDL);
+		value32 = rtw_read32(padapter, REG_MCUFWDL, &error);
+		if (error)
+			return -FAIL;
+
 		if (value32 & WINTINI_RDY) {
 			DBG_88E("%s: Polling FW ready success!! REG_MCUFWDL:0x%08x\n", __func__, value32);
 			return _SUCCESS;
@@ -591,6 +665,8 @@ s32 rtl8188e_FirmwareDownload(struct adapter *padapter)
 	u8 *pFirmwareBuf;
 	u32 FirmwareLen;
 	static int log_version;
+	int error;
+	u8 tmp;
 
 	if (!dvobj->firmware.szFwBuffer)
 		rtStatus = load_firmware(&dvobj->firmware, device);
@@ -621,7 +697,11 @@ s32 rtl8188e_FirmwareDownload(struct adapter *padapter)
 
 	/*  Suggested by Filen. If 8051 is running in RAM code, driver should inform Fw to reset by itself, */
 	/*  or it will cause download Fw fail. 2010.02.01. by tynli. */
-	if (rtw_read8(padapter, REG_MCUFWDL) & RAM_DL_SEL) { /* 8051 RAM code */
+	tmp = rtw_read8(padapter, REG_MCUFWDL, &error);
+	if (error)
+		return _FAIL;
+
+	if (tmp & RAM_DL_SEL) { /* 8051 RAM code */
 		rtw_write8(padapter, REG_MCUFWDL, 0x00);
 		_8051Reset88E(padapter);
 	}
@@ -629,8 +709,12 @@ s32 rtl8188e_FirmwareDownload(struct adapter *padapter)
 	_FWDownloadEnable(padapter, true);
 	fwdl_start_time = jiffies;
 	while (1) {
+		tmp = rtw_read8(padapter, REG_MCUFWDL, &error);
+		if (error)
+			return _FAIL;
+
 		/* reset the FWDL chksum */
-		rtw_write8(padapter, REG_MCUFWDL, rtw_read8(padapter, REG_MCUFWDL) | FWDL_ChkSum_rpt);
+		rtw_write8(padapter, REG_MCUFWDL, tmp | FWDL_ChkSum_rpt);
 
 		rtStatus = _WriteFW(padapter, pFirmwareBuf, FirmwareLen);
 
@@ -715,25 +799,35 @@ hal_EfusePowerSwitch_RTL8188E(
 {
 	u8 tempval;
 	u16	tmpV16;
+	int error;
 
 	if (PwrState) {
 		rtw_write8(pAdapter, REG_EFUSE_ACCESS, EFUSE_ACCESS_ON);
 
 		/*  1.2V Power: From VDDON with Power Cut(0x0000h[15]), defualt valid */
-		tmpV16 = rtw_read16(pAdapter, REG_SYS_ISO_CTRL);
+		tmpV16 = rtw_read16(pAdapter, REG_SYS_ISO_CTRL, &error);
+		if (error)
+			return;
+
 		if (!(tmpV16 & PWC_EV12V)) {
 			tmpV16 |= PWC_EV12V;
 			rtw_write16(pAdapter, REG_SYS_ISO_CTRL, tmpV16);
 		}
 		/*  Reset: 0x0000h[28], default valid */
-		tmpV16 =  rtw_read16(pAdapter, REG_SYS_FUNC_EN);
+		tmpV16 = rtw_read16(pAdapter, REG_SYS_FUNC_EN, &error);
+		if (error)
+			return;
+
 		if (!(tmpV16 & FEN_ELDR)) {
 			tmpV16 |= FEN_ELDR;
 			rtw_write16(pAdapter, REG_SYS_FUNC_EN, tmpV16);
 		}
 
 		/*  Clock: Gated(0x0008h[5]) 8M(0x0008h[1]) clock from ANA, default valid */
-		tmpV16 = rtw_read16(pAdapter, REG_SYS_CLKR);
+		tmpV16 = rtw_read16(pAdapter, REG_SYS_CLKR, &error);
+		if (error)
+			return;
+
 		if ((!(tmpV16 & LOADER_CLK_EN))  || (!(tmpV16 & ANA8M))) {
 			tmpV16 |= (LOADER_CLK_EN | ANA8M);
 			rtw_write16(pAdapter, REG_SYS_CLKR, tmpV16);
@@ -741,7 +835,9 @@ hal_EfusePowerSwitch_RTL8188E(
 
 		if (bWrite) {
 			/*  Enable LDO 2.5V before read/write action */
-			tempval = rtw_read8(pAdapter, EFUSE_TEST + 3);
+			tempval = rtw_read8(pAdapter, EFUSE_TEST + 3, &error);
+			if (error)
+				return;
 			tempval &= 0x0F;
 			tempval |= (VOLTAGE_V25 << 4);
 			rtw_write8(pAdapter, EFUSE_TEST + 3, (tempval | 0x80));
@@ -751,7 +847,9 @@ hal_EfusePowerSwitch_RTL8188E(
 
 		if (bWrite) {
 			/*  Disable LDO 2.5V after read/write action */
-			tempval = rtw_read8(pAdapter, EFUSE_TEST + 3);
+			tempval = rtw_read8(pAdapter, EFUSE_TEST + 3, &error);
+			if (error)
+				return;
 			rtw_write8(pAdapter, EFUSE_TEST + 3, (tempval & 0x7F));
 		}
 	}
@@ -1692,12 +1790,15 @@ static int rtl8188e_Efuse_PgPacketWrite(struct adapter *pAdapter, u8 offset, u8
 static struct HAL_VERSION ReadChipVersion8188E(struct adapter *padapter)
 {
 	u32				value32;
-	struct HAL_VERSION		ChipVersion;
+	struct HAL_VERSION		ChipVersion = { };
 	struct hal_data_8188e	*pHalData;
+	int error;
 
 	pHalData = GET_HAL_DATA(padapter);
 
-	value32 = rtw_read32(padapter, REG_SYS_CFG);
+	value32 = rtw_read32(padapter, REG_SYS_CFG, &error);
+	if (error)
+		return ChipVersion;
 	ChipVersion.ICType = CHIP_8188E;
 	ChipVersion.ChipType = ((value32 & RTL_ID) ? TEST_CHIP : NORMAL_CHIP);
 
@@ -1784,12 +1885,23 @@ void rtl8188e_stop_thread(struct adapter *padapter)
 
 static void hal_notch_filter_8188e(struct adapter *adapter, bool enable)
 {
+	int error;
+	u8 tmp;
+
 	if (enable) {
 		DBG_88E("Enable notch filter\n");
-		rtw_write8(adapter, rOFDM0_RxDSP + 1, rtw_read8(adapter, rOFDM0_RxDSP + 1) | BIT(1));
+		tmp = rtw_read8(adapter, rOFDM0_RxDSP + 1, &error);
+		if (error)
+			return;
+
+		rtw_write8(adapter, rOFDM0_RxDSP + 1, tmp | BIT(1));
 	} else {
 		DBG_88E("Disable notch filter\n");
-		rtw_write8(adapter, rOFDM0_RxDSP + 1, rtw_read8(adapter, rOFDM0_RxDSP + 1) & ~BIT(1));
+		tmp = rtw_read8(adapter, rOFDM0_RxDSP + 1, &error);
+		if (error)
+			return;
+
+		rtw_write8(adapter, rOFDM0_RxDSP + 1, TCA_DUMP_FLAGS_TERSE & ~BIT(1));
 	}
 }
 void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
@@ -1845,8 +1957,12 @@ u8 GetEEPROMSize8188E(struct adapter *padapter)
 {
 	u8 size = 0;
 	u32	cr;
+	int error;
+
+	cr = rtw_read16(padapter, REG_9346CR, &error);
+	if (error)
+		return size;
 
-	cr = rtw_read16(padapter, REG_9346CR);
 	/*  6: EEPROM used is 93C46, 4: boot from E-Fuse. */
 	size = (cr & BOOT_FROM_EEPROM) ? 6 : 4;
 
@@ -1866,12 +1982,16 @@ static s32 _LLTWrite(struct adapter *padapter, u32 address, u32 data)
 	s32	count = 0;
 	u32	value = _LLT_INIT_ADDR(address) | _LLT_INIT_DATA(data) | _LLT_OP(_LLT_WRITE_ACCESS);
 	u16	LLTReg = REG_LLT_INIT;
+	int error;
 
 	rtw_write32(padapter, LLTReg, value);
 
 	/* polling */
 	do {
-		value = rtw_read32(padapter, LLTReg);
+		value = rtw_read32(padapter, LLTReg, &error);
+		if (error)
+			return _FAIL;
+
 		if (_LLT_NO_ACTIVE == _LLT_OP_VALUE(value))
 			break;
 
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 30a9dca8f453..6264778ed9c3 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -75,8 +75,12 @@ rtl8188e_PHY_QueryBBReg(
 	)
 {
 	u32 ReturnValue = 0, OriginalValue, BitShift;
+	int error;
+
+	OriginalValue = rtw_read32(Adapter, RegAddr, &error);
+	if (error)
+		return ReturnValue;
 
-	OriginalValue = rtw_read32(Adapter, RegAddr);
 	BitShift = phy_CalculateBitShift(BitMask);
 	ReturnValue = (OriginalValue & BitMask) >> BitShift;
 	return ReturnValue;
@@ -103,9 +107,12 @@ rtl8188e_PHY_QueryBBReg(
 void rtl8188e_PHY_SetBBReg(struct adapter *Adapter, u32 RegAddr, u32 BitMask, u32 Data)
 {
 	u32 OriginalValue, BitShift;
+	int error;
 
 	if (BitMask != bMaskDWord) { /* if not "double word" write */
-		OriginalValue = rtw_read32(Adapter, RegAddr);
+		OriginalValue = rtw_read32(Adapter, RegAddr, &error);
+		if (error)
+			return;
 		BitShift = phy_CalculateBitShift(BitMask);
 		Data = ((OriginalValue & (~BitMask)) | (Data << BitShift));
 	}
@@ -577,11 +584,15 @@ PHY_BBConfig8188E(
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
 	u32 RegVal;
 	u8 CrystalCap;
+	int error;
 
 	phy_InitBBRFRegisterDefinition(Adapter);
 
 	/*  Enable BB and RF */
-	RegVal = rtw_read16(Adapter, REG_SYS_FUNC_EN);
+	RegVal = rtw_read16(Adapter, REG_SYS_FUNC_EN, &error);
+	if (error)
+		return -FAIL;
+
 	rtw_write16(Adapter, REG_SYS_FUNC_EN, (u16)(RegVal | BIT(13) | BIT(0) | BIT(1)));
 
 	/*  20090923 Joseph: Advised by Steven and Jenyu. Power sequence before init RF. */
@@ -960,6 +971,7 @@ _PHY_SetBWMode92C(
 	struct hal_data_8188e *pHalData = GET_HAL_DATA(Adapter);
 	u8 regBwOpMode;
 	u8 regRRSR_RSC;
+	int error;
 
 	if (pHalData->rf_chip == RF_PSEUDO_11N)
 		return;
@@ -975,8 +987,12 @@ _PHY_SetBWMode92C(
 	/* 3<1>Set MAC register */
 	/* 3 */
 
-	regBwOpMode = rtw_read8(Adapter, REG_BWOPMODE);
-	regRRSR_RSC = rtw_read8(Adapter, REG_RRSR + 2);
+	regBwOpMode = rtw_read8(Adapter, REG_BWOPMODE, &error);
+	if (error)
+		return;
+	regRRSR_RSC = rtw_read8(Adapter, REG_RRSR + 2, &error);
+	if (error)
+		return;
 
 	switch (pHalData->CurrentChannelBW) {
 	case HT_CHANNEL_WIDTH_20:
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_sreset.c b/drivers/staging/r8188eu/hal/rtl8188e_sreset.c
index 16fa249e35d3..1bb86629574d 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_sreset.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_sreset.c
@@ -14,13 +14,16 @@ void rtl8188e_sreset_xmit_status_check(struct adapter *padapter)
 {
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(padapter);
 	struct sreset_priv *psrtpriv = &pHalData->srestpriv;
-
+	int error;
 	unsigned long current_time;
 	struct xmit_priv	*pxmitpriv = &padapter->xmitpriv;
 	unsigned int diff_time;
 	u32 txdma_status;
 
-	txdma_status = rtw_read32(padapter, REG_TXDMA_STATUS);
+	txdma_status = rtw_read32(padapter, REG_TXDMA_STATUS, &error);
+	if (error)
+		return;
+
 	if (txdma_status != 0x00) {
 		DBG_88E("%s REG_TXDMA_STATUS:0x%08x\n", __func__, txdma_status);
 		rtw_write32(padapter, REG_TXDMA_STATUS, txdma_status);
@@ -49,12 +52,21 @@ void rtl8188e_sreset_linked_status_check(struct adapter *padapter)
 {
 	u32 rx_dma_status = 0;
 	u8 fw_status = 0;
-	rx_dma_status = rtw_read32(padapter, REG_RXDMA_STATUS);
+	int error;
+
+	rx_dma_status = rtw_read32(padapter, REG_RXDMA_STATUS, &error);
+	if (error)
+		return;
+
 	if (rx_dma_status != 0x00) {
 		DBG_88E("%s REG_RXDMA_STATUS:0x%08x\n", __func__, rx_dma_status);
 		rtw_write32(padapter, REG_RXDMA_STATUS, rx_dma_status);
 	}
-	fw_status = rtw_read8(padapter, REG_FMETHR);
+
+	fw_status = rtw_read8(padapter, REG_FMETHR, &error);
+	if (error)
+		return;
+
 	if (fw_status != 0x00) {
 		if (fw_status == 1)
 			DBG_88E("%s REG_FW_STATUS (0x%02x), Read_Efuse_Fail !!\n", __func__, fw_status);
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_led.c b/drivers/staging/r8188eu/hal/rtl8188eu_led.c
index 452d4bb87aba..2467adb51f7d 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_led.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_led.c
@@ -14,10 +14,15 @@
 void SwLedOn(struct adapter *padapter, struct LED_871x *pLed)
 {
 	u8	LedCfg;
+	int error;
 
 	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
 		return;
-	LedCfg = rtw_read8(padapter, REG_LEDCFG2);
+
+	LedCfg = rtw_read8(padapter, REG_LEDCFG2, &error);
+	if (error)
+		return;
+
 	switch (pLed->LedPin) {
 	case LED_PIN_LED0:
 		rtw_write8(padapter, REG_LEDCFG2, (LedCfg & 0xf0) | BIT(5) | BIT(6)); /*  SW control led0 on. */
@@ -37,11 +42,14 @@ void SwLedOff(struct adapter *padapter, struct LED_871x *pLed)
 {
 	u8	LedCfg;
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(padapter);
+	int error;
 
 	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
 		goto exit;
 
-	LedCfg = rtw_read8(padapter, REG_LEDCFG2);/* 0x4E */
+	LedCfg = rtw_read8(padapter, REG_LEDCFG2, &error);/* 0x4E */
+	if (error)
+		return;
 
 	switch (pLed->LedPin) {
 	case LED_PIN_LED0:
@@ -49,7 +57,10 @@ void SwLedOff(struct adapter *padapter, struct LED_871x *pLed)
 			/*  Open-drain arrangement for controlling the LED) */
 			LedCfg &= 0x90; /*  Set to software control. */
 			rtw_write8(padapter, REG_LEDCFG2, (LedCfg | BIT(3)));
-			LedCfg = rtw_read8(padapter, REG_MAC_PINMUX_CFG);
+			LedCfg = rtw_read8(padapter, REG_MAC_PINMUX_CFG, &error);
+			if (error)
+				return;
+
 			LedCfg &= 0xFE;
 			rtw_write8(padapter, REG_MAC_PINMUX_CFG, LedCfg);
 		} else {
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 5cdabf43d4fd..73ef2e0ead19 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -90,6 +90,8 @@ static u32 rtl8188eu_InitPowerOn(struct adapter *adapt)
 	u16 value16;
 	/*  HW Power on sequence */
 	struct hal_data_8188e	*haldata	= GET_HAL_DATA(adapt);
+	int error;
+	
 	if (haldata->bMacPwrCtrlOn)
 		return _SUCCESS;
 
@@ -103,7 +105,10 @@ static u32 rtl8188eu_InitPowerOn(struct adapter *adapt)
 	rtw_write16(adapt, REG_CR, 0x00);  /* suggseted by zhouzhou, by page, 20111230 */
 
 		/*  Enable MAC DMA/WMAC/SCHEDULE/SEC block */
-	value16 = rtw_read16(adapt, REG_CR);
+	value16 = rtw_read16(adapt, REG_CR, &error);
+	if (error)
+		return _FAIL;
+
 	value16 |= (HCI_TXDMA_EN | HCI_RXDMA_EN | TXDMA_EN | RXDMA_EN
 				| PROTOCOL_EN | SCHEDULE_EN | ENSEC | CALTMR_EN);
 	/*  for SDIO - Set CR bit10 to enable 32k calibration. Suggested by SD1 Gimmy. Added by tynli. 2011.08.31. */
@@ -120,6 +125,7 @@ static void _InitInterrupt(struct adapter *Adapter)
 	u32 imr, imr_ex;
 	u8  usb_opt;
 	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
+	int error;
 
 	/* HISR write one to clear */
 	rtw_write32(Adapter, REG_HISR_88E, 0xFFFFFFFF);
@@ -135,7 +141,9 @@ static void _InitInterrupt(struct adapter *Adapter)
 	/*  REG_USB_SPECIAL_OPTION - BIT(4) */
 	/*  0; Use interrupt endpoint to upload interrupt pkt */
 	/*  1; Use bulk endpoint to upload interrupt pkt, */
-	usb_opt = rtw_read8(Adapter, REG_USB_SPECIAL_OPTION);
+	usb_opt = rtw_read8(Adapter, REG_USB_SPECIAL_OPTION, &error);
+	if (error)
+		return;
 
 	if (!adapter_to_dvobj(Adapter)->ishighspeed)
 		usb_opt = usb_opt & (~INT_BULK_SEL);
@@ -204,7 +212,14 @@ static void _InitNormalChipRegPriority(struct adapter *Adapter, u16 beQ,
 				       u16 bkQ, u16 viQ, u16 voQ, u16 mgtQ,
 				       u16 hiQ)
 {
-	u16 value16	= (rtw_read16(Adapter, REG_TRXDMA_CTRL) & 0x7);
+	u16 value16;
+	int error;
+
+	value16 = rtw_read16(Adapter, REG_TRXDMA_CTRL, &error);
+	if (error)
+		return;
+
+	value16 &= 0x7;
 
 	value16 |= _TXDMA_BEQ_MAP(beQ)	| _TXDMA_BKQ_MAP(bkQ) |
 		   _TXDMA_VIQ_MAP(viQ)	| _TXDMA_VOQ_MAP(voQ) |
@@ -323,8 +338,11 @@ static void _InitQueuePriority(struct adapter *Adapter)
 static void _InitNetworkType(struct adapter *Adapter)
 {
 	u32 value32;
+	int error;
 
-	value32 = rtw_read32(Adapter, REG_CR);
+	value32 = rtw_read32(Adapter, REG_CR, &error);
+	if (error)
+		return;
 	/*  TODO: use the other function to set network type */
 	value32 = (value32 & ~MASK_NETTYPE) | _NETTYPE(NT_LINK_AP);
 
@@ -366,9 +384,13 @@ static void _InitAdaptiveCtrl(struct adapter *Adapter)
 {
 	u16 value16;
 	u32 value32;
+	int error;
 
 	/*  Response Rate Set */
-	value32 = rtw_read32(Adapter, REG_RRSR);
+	value32 = rtw_read32(Adapter, REG_RRSR, &error);
+	if (error)
+		return;
+
 	value32 &= ~RATE_BITMAP_ALL;
 	value32 |= RATE_RRSR_CCK_ONLY_1M;
 	rtw_write32(Adapter, REG_RRSR, value32);
@@ -435,8 +457,11 @@ static void _InitRxSetting(struct adapter *Adapter)
 static void _InitRetryFunction(struct adapter *Adapter)
 {
 	u8 value8;
+	int error;
 
-	value8 = rtw_read8(Adapter, REG_FWHW_TXQ_CTRL);
+	value8 = rtw_read8(Adapter, REG_FWHW_TXQ_CTRL, &error);
+	if (error)
+		return;
 	value8 |= EN_AMPDU_RTY_NEW;
 	rtw_write8(Adapter, REG_FWHW_TXQ_CTRL, value8);
 
@@ -463,12 +488,16 @@ static void usb_AggSettingTxUpdate(struct adapter *Adapter)
 {
 	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
 	u32 value32;
+	int error;
 
 	if (Adapter->registrypriv.wifi_spec)
 		haldata->UsbTxAggMode = false;
 
 	if (haldata->UsbTxAggMode) {
-		value32 = rtw_read32(Adapter, REG_TDECTRL);
+		value32 = rtw_read32(Adapter, REG_TDECTRL, &error);
+		if (error)
+			return;
+
 		value32 = value32 & ~(BLK_DESC_NUM_MASK << BLK_DESC_NUM_SHIFT);
 		value32 |= ((haldata->UsbTxAggDescNum & BLK_DESC_NUM_MASK) << BLK_DESC_NUM_SHIFT);
 
@@ -499,9 +528,14 @@ usb_AggSettingRxUpdate(
 	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
 	u8 valueDMA;
 	u8 valueUSB;
+	int error;
 
-	valueDMA = rtw_read8(Adapter, REG_TRXDMA_CTRL);
-	valueUSB = rtw_read8(Adapter, REG_USB_SPECIAL_OPTION);
+	valueDMA = rtw_read8(Adapter, REG_TRXDMA_CTRL, &error);
+	if (error)
+		return;
+	valueUSB = rtw_read8(Adapter, REG_USB_SPECIAL_OPTION, &error);
+	if (error)
+		return;
 
 	switch (haldata->UsbRxAggMode) {
 	case USB_RX_AGG_DMA:
@@ -589,6 +623,7 @@ static void _InitOperationMode(struct adapter *Adapter)
 static void _InitBeaconParameters(struct adapter *Adapter)
 {
 	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
+	int error;
 
 	rtw_write16(Adapter, REG_BCN_CTRL, 0x1010);
 
@@ -601,11 +636,11 @@ static void _InitBeaconParameters(struct adapter *Adapter)
 	/*  beacause test chip does not contension before sending beacon. by tynli. 2009.11.03 */
 	rtw_write16(Adapter, REG_BCNTCFG, 0x660F);
 
-	haldata->RegBcnCtrlVal = rtw_read8(Adapter, REG_BCN_CTRL);
-	haldata->RegTxPause = rtw_read8(Adapter, REG_TXPAUSE);
-	haldata->RegFwHwTxQCtrl = rtw_read8(Adapter, REG_FWHW_TXQ_CTRL + 2);
-	haldata->RegReg542 = rtw_read8(Adapter, REG_TBTT_PROHIBIT + 2);
-	haldata->RegCR_1 = rtw_read8(Adapter, REG_CR + 1);
+	haldata->RegBcnCtrlVal = rtw_read8(Adapter, REG_BCN_CTRL, &error);
+	haldata->RegTxPause = rtw_read8(Adapter, REG_TXPAUSE, &error);
+	haldata->RegFwHwTxQCtrl = rtw_read8(Adapter, REG_FWHW_TXQ_CTRL + 2, &error);
+	haldata->RegReg542 = rtw_read8(Adapter, REG_TBTT_PROHIBIT + 2, &error);
+	haldata->RegCR_1 = rtw_read8(Adapter, REG_CR + 1, &error);
 }
 
 static void _BeaconFunctionEnable(struct adapter *Adapter,
@@ -631,12 +666,18 @@ enum {
 static void _InitAntenna_Selection(struct adapter *Adapter)
 {
 	struct hal_data_8188e	*haldata	= GET_HAL_DATA(Adapter);
+	int error;
+	u32 tmp;
 
 	if (haldata->AntDivCfg == 0)
 		return;
 	DBG_88E("==>  %s ....\n", __func__);
 
-	rtw_write32(Adapter, REG_LEDCFG0, rtw_read32(Adapter, REG_LEDCFG0) | BIT(23));
+	tmp = rtw_read32(Adapter, REG_LEDCFG0, &error);
+	if (error)
+		return;
+
+	rtw_write32(Adapter, REG_LEDCFG0, tmp | BIT(23));
 	PHY_SetBBReg(Adapter, rFPGA0_XAB_RFParameter, BIT(13), 0x01);
 
 	if (PHY_QueryBBReg(Adapter, rFPGA0_XA_RFInterfaceOE, 0x300) == Antenna_A)
@@ -665,14 +706,22 @@ enum rt_rf_power_state RfOnOffDetect(struct adapter *adapt)
 {
 	u8 val8;
 	enum rt_rf_power_state rfpowerstate = rf_off;
+	int error;
 
 	if (adapt->pwrctrlpriv.bHWPowerdown) {
-		val8 = rtw_read8(adapt, REG_HSISR);
+		val8 = rtw_read8(adapt, REG_HSISR, &error);
+		if (error)
+			return rfpowerstate;
 		DBG_88E("pwrdown, 0x5c(BIT(7))=%02x\n", val8);
 		rfpowerstate = (val8 & BIT(7)) ? rf_off : rf_on;
 	} else { /*  rf on/off */
-		rtw_write8(adapt, REG_MAC_PINMUX_CFG, rtw_read8(adapt, REG_MAC_PINMUX_CFG) & ~(BIT(3)));
-		val8 = rtw_read8(adapt, REG_GPIO_IO_SEL);
+		val8 = rtw_read8(adapt, REG_MAC_PINMUX_CFG, &error);
+		if (error)
+			return rfpowerstate;
+		rtw_write8(adapt, REG_MAC_PINMUX_CFG, val8 & ~(BIT(3)));
+		val8 = rtw_read8(adapt, REG_GPIO_IO_SEL, &error);
+		if (error)
+			return rfpowerstate;
 		DBG_88E("GPIO_IN=%02x\n", val8);
 		rfpowerstate = (val8 & BIT(3)) ? rf_on : rf_off;
 	}
@@ -683,12 +732,14 @@ static u32 rtl8188eu_hal_init(struct adapter *Adapter)
 {
 	u8 value8 = 0;
 	u16  value16;
+	u32 value32;
 	u8 txpktbuf_bndy;
 	u32 status = _SUCCESS;
 	struct hal_data_8188e		*haldata = GET_HAL_DATA(Adapter);
 	struct pwrctrl_priv		*pwrctrlpriv = &Adapter->pwrctrlpriv;
 	struct registry_priv	*pregistrypriv = &Adapter->registrypriv;
 	u32 init_start_time = jiffies;
+	int error;
 
 	#define HAL_INIT_PROFILE_TAG(stage) do {} while (0)
 
@@ -826,7 +877,12 @@ static u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	/*  Hw bug which Hw initials RxFF boundary size to a value which is larger than the real Rx buffer size in 88E. */
 	/*  */
 	/*  Enable MACTXEN/MACRXEN block */
-	value16 = rtw_read16(Adapter, REG_CR);
+	value16 = rtw_read16(Adapter, REG_CR, &error);
+	if (error) {
+		status = _FAIL;
+		goto exit;
+	}
+
 	value16 |= (MACTXEN | MACRXEN);
 	rtw_write8(Adapter, REG_CR, value16);
 
@@ -835,7 +891,11 @@ static u32 rtl8188eu_hal_init(struct adapter *Adapter)
 
 	/* Enable TX Report */
 	/* Enable Tx Report Timer */
-	value8 = rtw_read8(Adapter, REG_TX_RPT_CTRL);
+	value8 = rtw_read8(Adapter, REG_TX_RPT_CTRL, &error);
+	if (error) {
+		status = _FAIL;
+		goto exit;
+	}
 	rtw_write8(Adapter,  REG_TX_RPT_CTRL, (value8 | BIT(1) | BIT(0)));
 	/* Set MAX RPT MACID */
 	rtw_write8(Adapter,  REG_TX_RPT_CTRL + 1, 2);/* FOR sta mode ,0: bc/mc ,1:AP */
@@ -910,7 +970,13 @@ static u32 rtl8188eu_hal_init(struct adapter *Adapter)
 		rtw_write16(Adapter, REG_TX_RPT_TIME, 0x3DF0);
 
 		/* enable tx DMA to drop the redundate data of packet */
-		rtw_write16(Adapter, REG_TXDMA_OFFSET_CHK, (rtw_read16(Adapter, REG_TXDMA_OFFSET_CHK) | DROP_DATA_EN));
+		value16 = rtw_read16(Adapter, REG_TXDMA_OFFSET_CHK, &error);
+		if (error) {
+			status = _FAIL;
+			goto exit;
+		}
+
+		rtw_write16(Adapter, REG_TXDMA_OFFSET_CHK, (value16 | DROP_DATA_EN));
 
 		HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_IQK);
 		/*  2010/08/26 MH Merge from 8192CE. */
@@ -936,7 +1002,13 @@ static u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	rtw_write8(Adapter, REG_USB_HRPWM, 0);
 
 	/* ack for xmit mgmt frames. */
-	rtw_write32(Adapter, REG_FWHW_TXQ_CTRL, rtw_read32(Adapter, REG_FWHW_TXQ_CTRL) | BIT(12));
+	value32 = rtw_read32(Adapter, REG_FWHW_TXQ_CTRL, &error);
+	if (error) {
+		status = _FAIL;
+		goto exit;
+	}
+
+	rtw_write32(Adapter, REG_FWHW_TXQ_CTRL, value32 | BIT(12));
 
 exit:
 	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_END);
@@ -962,9 +1034,13 @@ static void CardDisableRTL8188EU(struct adapter *Adapter)
 {
 	u8 val8;
 	struct hal_data_8188e	*haldata	= GET_HAL_DATA(Adapter);
+	int error;
 
 	/* Stop Tx Report Timer. 0x4EC[Bit1]=b'0 */
-	val8 = rtw_read8(Adapter, REG_TX_RPT_CTRL);
+	val8 = rtw_read8(Adapter, REG_TX_RPT_CTRL, &error);
+	if (error)
+		return;
+
 	rtw_write8(Adapter, REG_TX_RPT_CTRL, val8 & (~BIT(1)));
 
 	/*  stop rx */
@@ -975,10 +1051,16 @@ static void CardDisableRTL8188EU(struct adapter *Adapter)
 
 	/*  2. 0x1F[7:0] = 0		turn off RF */
 
-	val8 = rtw_read8(Adapter, REG_MCUFWDL);
+	val8 = rtw_read8(Adapter, REG_MCUFWDL, &error);
+	if (error)
+		return;
+
 	if ((val8 & RAM_DL_SEL) && Adapter->bFWReady) { /* 8051 RAM code */
 		/*  Reset MCU 0x2[10]=0. */
-		val8 = rtw_read8(Adapter, REG_SYS_FUNC_EN + 1);
+		val8 = rtw_read8(Adapter, REG_SYS_FUNC_EN + 1, &error);
+		if (error)
+			return;
+
 		val8 &= ~BIT(2);	/*  0x2[10], FEN_CPUEN */
 		rtw_write8(Adapter, REG_SYS_FUNC_EN + 1, val8);
 	}
@@ -988,26 +1070,44 @@ static void CardDisableRTL8188EU(struct adapter *Adapter)
 
 	/* YJ,add,111212 */
 	/* Disable 32k */
-	val8 = rtw_read8(Adapter, REG_32K_CTRL);
+	val8 = rtw_read8(Adapter, REG_32K_CTRL, &error);
+	if (error)
+		return;
+
 	rtw_write8(Adapter, REG_32K_CTRL, val8 & (~BIT(0)));
 
 	/*  Card disable power action flow */
 	HalPwrSeqCmdParsing(Adapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK, Rtl8188E_NIC_DISABLE_FLOW);
 
 	/*  Reset MCU IO Wrapper */
-	val8 = rtw_read8(Adapter, REG_RSV_CTRL + 1);
+	val8 = rtw_read8(Adapter, REG_RSV_CTRL + 1, &error);
+	if (error)
+		return;
+
 	rtw_write8(Adapter, REG_RSV_CTRL + 1, (val8 & (~BIT(3))));
-	val8 = rtw_read8(Adapter, REG_RSV_CTRL + 1);
+	val8 = rtw_read8(Adapter, REG_RSV_CTRL + 1, &error);
+	if (error)
+		return;
+
 	rtw_write8(Adapter, REG_RSV_CTRL + 1, val8 | BIT(3));
 
 	/* YJ,test add, 111207. For Power Consumption. */
-	val8 = rtw_read8(Adapter, GPIO_IN);
+	val8 = rtw_read8(Adapter, GPIO_IN, &error);
+	if (error)
+		return;
+
 	rtw_write8(Adapter, GPIO_OUT, val8);
 	rtw_write8(Adapter, GPIO_IO_SEL, 0xFF);/* Reg0x46 */
 
-	val8 = rtw_read8(Adapter, REG_GPIO_IO_SEL);
+	val8 = rtw_read8(Adapter, REG_GPIO_IO_SEL, &error);
+	if (error)
+		return;
+
 	rtw_write8(Adapter, REG_GPIO_IO_SEL, (val8 << 4));
-	val8 = rtw_read8(Adapter, REG_GPIO_IO_SEL + 1);
+	val8 = rtw_read8(Adapter, REG_GPIO_IO_SEL + 1, &error);
+	if (error)
+		return;
+
 	rtw_write8(Adapter, REG_GPIO_IO_SEL + 1, val8 | 0x0F);/* Reg0x43 */
 	rtw_write32(Adapter, REG_BB_PAD_CTRL, 0x00080808);/* set LNA ,TRSW,EX_PA Pin to output mode */
 	haldata->bMacPwrCtrlOn = false;
@@ -1181,9 +1281,13 @@ static void _ReadPROMContent(
 {
 	struct eeprom_priv *eeprom = GET_EEPROM_EFUSE_PRIV(Adapter);
 	u8 eeValue;
+	int error;
 
 	/* check system boot selection */
-	eeValue = rtw_read8(Adapter, REG_9346CR);
+	eeValue = rtw_read8(Adapter, REG_9346CR, &error);
+	if (error)
+		return;
+
 	eeprom->EepromOrEfuse		= (eeValue & BOOT_FROM_EEPROM) ? true : false;
 	eeprom->bautoload_fail_flag	= (eeValue & EEPROM_EN) ? false : true;
 
@@ -1262,12 +1366,23 @@ static void hw_var_set_opmode(struct adapter *Adapter, u8 variable, u8 *val)
 {
 	u8 val8;
 	u8 mode = *((u8 *)val);
+	u8 tmp;
+	int error;
 
 	/*  disable Port0 TSF update */
-	rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL) | BIT(4));
+	tmp = rtw_read8(Adapter, REG_BCN_CTRL, &error);
+	if (error)
+		return;
+
+	rtw_write8(Adapter, REG_BCN_CTRL, tmp | BIT(4));
 
 	/*  set net_type */
-	val8 = rtw_read8(Adapter, MSR) & 0x0c;
+	val8 = rtw_read8(Adapter, MSR, &error);
+	if (error)
+		return;
+
+	val8 &= 0x0c;
+
 	val8 |= mode;
 	rtw_write8(Adapter, MSR, val8);
 
@@ -1304,14 +1419,22 @@ static void hw_var_set_opmode(struct adapter *Adapter, u8 variable, u8 *val)
 		rtw_write8(Adapter, REG_DUAL_TSF_RST, BIT(0));
 
 		/* BIT(3) - If set 0, hw will clr bcnq when tx becon ok/fail or port 0 */
-		rtw_write8(Adapter, REG_MBID_NUM, rtw_read8(Adapter, REG_MBID_NUM) | BIT(3) | BIT(4));
+		tmp = rtw_read8(Adapter, REG_MBID_NUM, &error);
+		if (error)
+			return;
+
+		rtw_write8(Adapter, REG_MBID_NUM, tmp | BIT(3) | BIT(4));
 
 		/* enable BCN0 Function for if1 */
 		/* don't enable update TSF0 for if1 (due to TSF update when beacon/probe rsp are received) */
 		rtw_write8(Adapter, REG_BCN_CTRL, (DIS_TSF_UDT0_NORMAL_CHIP | EN_BCN_FUNCTION | BIT(1)));
 
 		/* dis BCN1 ATIM  WND if if2 is station */
-		rtw_write8(Adapter, REG_BCN_CTRL_1, rtw_read8(Adapter, REG_BCN_CTRL_1) | BIT(0));
+		tmp = rtw_read8(Adapter, REG_BCN_CTRL_1, &error);
+		if (error)
+			return;
+
+		rtw_write8(Adapter, REG_BCN_CTRL_1, tmp | BIT(0));
 	}
 }
 
@@ -1340,13 +1463,20 @@ static void hw_var_set_bssid(struct adapter *Adapter, u8 variable, u8 *val)
 static void hw_var_set_bcn_func(struct adapter *Adapter, u8 variable, u8 *val)
 {
 	u32 bcn_ctrl_reg;
+	u8 tmp;
+	int error;
 
 	bcn_ctrl_reg = REG_BCN_CTRL;
 
-	if (*((u8 *)val))
+	if (*((u8 *)val)) {
 		rtw_write8(Adapter, bcn_ctrl_reg, (EN_BCN_FUNCTION | EN_TXBCN_RPT));
-	else
-		rtw_write8(Adapter, bcn_ctrl_reg, rtw_read8(Adapter, bcn_ctrl_reg) & (~(EN_BCN_FUNCTION | EN_TXBCN_RPT)));
+	} else {
+		tmp = rtw_read8(Adapter, bcn_ctrl_reg, &error);
+		if (error)
+			return;
+
+		rtw_write8(Adapter, bcn_ctrl_reg, tmp & (~(EN_BCN_FUNCTION | EN_TXBCN_RPT)));
+	}
 }
 
 static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
@@ -1354,13 +1484,21 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
 	struct dm_priv	*pdmpriv = &haldata->dmpriv;
 	struct odm_dm_struct *podmpriv = &haldata->odmpriv;
+	int error;
+	u32 val32;
+	u8 val8;
 
 	switch (variable) {
 	case HW_VAR_MEDIA_STATUS:
 		{
 			u8 val8;
 
-			val8 = rtw_read8(Adapter, MSR) & 0x0c;
+			val8 = rtw_read8(Adapter, MSR, &error);
+			if (error)
+				return;
+
+			val8 &= 0x0c;
+
 			val8 |= *((u8 *)val);
 			rtw_write8(Adapter, MSR, val8);
 		}
@@ -1369,7 +1507,12 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 		{
 			u8 val8;
 
-			val8 = rtw_read8(Adapter, MSR) & 0x03;
+			val8 = rtw_read8(Adapter, MSR, &error);
+			if (error)
+				return;
+
+			val8 &= 0x03;
+	
 			val8 |= *((u8 *)val) << 2;
 			rtw_write8(Adapter, MSR, val8);
 		}
@@ -1407,7 +1550,12 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			/*  Set RRSR rate table. */
 			rtw_write8(Adapter, REG_RRSR, BrateCfg & 0xff);
 			rtw_write8(Adapter, REG_RRSR + 1, (BrateCfg >> 8) & 0xff);
-			rtw_write8(Adapter, REG_RRSR + 2, rtw_read8(Adapter, REG_RRSR + 2) & 0xf0);
+
+			val8 = rtw_read8(Adapter, REG_RRSR + 2, &error);
+			if (error)
+				return;
+
+			rtw_write8(Adapter, REG_RRSR + 2, val8 & 0xf0);
 
 			/*  Set RTS initial rate */
 			while (BrateCfg > 0x1) {
@@ -1437,13 +1585,19 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 				StopTxBeacon(Adapter);
 
 			/* disable related TSF function */
-			rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL) & (~BIT(3)));
+			val8 = rtw_read8(Adapter, REG_BCN_CTRL, &error);
+			if (error)
+				return;
+			rtw_write8(Adapter, REG_BCN_CTRL, val8 & (~BIT(3)));
 
 			rtw_write32(Adapter, REG_TSFTR, tsf);
 			rtw_write32(Adapter, REG_TSFTR + 4, tsf >> 32);
 
 			/* enable related TSF function */
-			rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL) | BIT(3));
+			val8 = rtw_read8(Adapter, REG_BCN_CTRL, &error);
+			if (error)
+				return;
+			rtw_write8(Adapter, REG_BCN_CTRL, val8 | BIT(3));
 
 			if (((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) || ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE))
 				ResumeTxBeacon(Adapter);
@@ -1451,11 +1605,17 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 		break;
 	case HW_VAR_CHECK_BSSID:
 		if (*((u8 *)val)) {
-			rtw_write32(Adapter, REG_RCR, rtw_read32(Adapter, REG_RCR) | RCR_CBSSID_DATA | RCR_CBSSID_BCN);
+			val32 = rtw_read32(Adapter, REG_RCR, &error);
+			if (error)
+				return;
+
+			rtw_write32(Adapter, REG_RCR, val32 | RCR_CBSSID_DATA | RCR_CBSSID_BCN);
 		} else {
-			u32 val32;
 
-			val32 = rtw_read32(Adapter, REG_RCR);
+			val32 = rtw_read32(Adapter, REG_RCR, &error);
+
+			if (error)
+				return;
 
 			val32 &= ~(RCR_CBSSID_DATA | RCR_CBSSID_BCN);
 
@@ -1471,19 +1631,29 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 		rtw_write8(Adapter, REG_DUAL_TSF_RST, (BIT(0) | BIT(1)));
 
 		/* disable update TSF */
-		rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL) | BIT(4));
+		val8 = rtw_read8(Adapter, REG_BCN_CTRL, &error);
+		if (error)
+			return;
+		rtw_write8(Adapter, REG_BCN_CTRL, val8 | BIT(4));
 		break;
 	case HW_VAR_MLME_SITESURVEY:
 		if (*((u8 *)val)) { /* under sitesurvey */
 			/* config RCR to receive different BSSID & not to receive data frame */
-			u32 v = rtw_read32(Adapter, REG_RCR);
+			u32 v = rtw_read32(Adapter, REG_RCR, &error);
+
+			if (error)
+				return;
+
 			v &= ~(RCR_CBSSID_BCN);
 			rtw_write32(Adapter, REG_RCR, v);
 			/* reject all data frame */
 			rtw_write16(Adapter, REG_RXFLTMAP2, 0x00);
 
 			/* disable update TSF */
-			rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL) | BIT(4));
+			val8 = rtw_read8(Adapter, REG_BCN_CTRL, &error);
+			if (error)
+				return;
+			rtw_write8(Adapter, REG_BCN_CTRL, val8 | BIT(4));
 		} else { /* sitesurvey done */
 			struct mlme_ext_priv	*pmlmeext = &Adapter->mlmeextpriv;
 			struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
@@ -1494,21 +1664,39 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 				rtw_write16(Adapter, REG_RXFLTMAP2, 0xFFFF);
 
 				/* enable update TSF */
-				rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL) & (~BIT(4)));
+				val8 = rtw_read8(Adapter, REG_BCN_CTRL, &error);
+				if (error)
+					return;
+				rtw_write8(Adapter, REG_BCN_CTRL, val8 & (~BIT(4)));
 			} else if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE) {
 				rtw_write16(Adapter, REG_RXFLTMAP2, 0xFFFF);
 				/* enable update TSF */
-				rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL) & (~BIT(4)));
+				val8 = rtw_read8(Adapter, REG_BCN_CTRL, &error);
+				if (error)
+					return;
+				rtw_write8(Adapter, REG_BCN_CTRL, val8 & (~BIT(4)));
 			}
 			if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE) {
-				rtw_write32(Adapter, REG_RCR, rtw_read32(Adapter, REG_RCR) | RCR_CBSSID_BCN);
+				val32 = rtw_read32(Adapter, REG_RCR, &error);
+				if (error)
+					return;
+
+				rtw_write32(Adapter, REG_RCR, val32 | RCR_CBSSID_BCN);
 			} else {
 				if (Adapter->in_cta_test) {
-					u32 v = rtw_read32(Adapter, REG_RCR);
+					u32 v = rtw_read32(Adapter, REG_RCR, &error);
+
+					if (error)
+						return;
+
 					v &= ~(RCR_CBSSID_DATA | RCR_CBSSID_BCN);/*  RCR_ADF */
 					rtw_write32(Adapter, REG_RCR, v);
 				} else {
-					rtw_write32(Adapter, REG_RCR, rtw_read32(Adapter, REG_RCR) | RCR_CBSSID_BCN);
+					val32 = rtw_read32(Adapter, REG_RCR, &error);
+					if (error)
+						return;
+
+					rtw_write32(Adapter, REG_RCR, val32 | RCR_CBSSID_BCN);
 				}
 			}
 		}
@@ -1524,11 +1712,20 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 				rtw_write16(Adapter, REG_RXFLTMAP2, 0xFFFF);
 
 				if (Adapter->in_cta_test) {
-					u32 v = rtw_read32(Adapter, REG_RCR);
+					u32 v = rtw_read32(Adapter, REG_RCR, &error);
+
+					if (error)
+						return;
+
 					v &= ~(RCR_CBSSID_DATA | RCR_CBSSID_BCN);/*  RCR_ADF */
 					rtw_write32(Adapter, REG_RCR, v);
 				} else {
-					rtw_write32(Adapter, REG_RCR, rtw_read32(Adapter, REG_RCR) | RCR_CBSSID_DATA | RCR_CBSSID_BCN);
+					val32 = rtw_read32(Adapter, REG_RCR, &error);
+
+					if (error)
+						return;
+
+					rtw_write32(Adapter, REG_RCR, val32 | RCR_CBSSID_DATA | RCR_CBSSID_BCN);
 				}
 
 				if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
@@ -1541,7 +1738,10 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			} else if (type == 2) {
 				/* sta add event call back */
 				/* enable update TSF */
-				rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL) & (~BIT(4)));
+				val8 = rtw_read8(Adapter, REG_BCN_CTRL, &error);
+				if (error)
+					return;
+				rtw_write8(Adapter, REG_BCN_CTRL, val8 & (~BIT(4)));
 
 				if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE | WIFI_ADHOC_MASTER_STATE))
 					RetryLimit = 0x7;
@@ -1671,7 +1871,10 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 	case HW_VAR_ACM_CTRL:
 		{
 			u8 acm_ctrl = *((u8 *)val);
-			u8 AcmCtrl = rtw_read8(Adapter, REG_ACMHWCTRL);
+			u8 AcmCtrl = rtw_read8(Adapter, REG_ACMHWCTRL, &error);
+
+			if (error)
+				return;
 
 			if (acm_ctrl > 1)
 				AcmCtrl = AcmCtrl | 0x1;
@@ -1719,7 +1922,11 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 				}
 				if (MinSpacingToSet < SecMinSpace)
 					MinSpacingToSet = SecMinSpace;
-				rtw_write8(Adapter, REG_AMPDU_MIN_SPACE, (rtw_read8(Adapter, REG_AMPDU_MIN_SPACE) & 0xf8) | MinSpacingToSet);
+
+				val8 = rtw_read8(Adapter, REG_AMPDU_MIN_SPACE, &error);
+				if (error)
+					return;
+				rtw_write8(Adapter, REG_AMPDU_MIN_SPACE, (val8 & 0xf8) | MinSpacingToSet);
 			}
 		}
 		break;
@@ -1826,18 +2033,31 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 		{
 			struct pwrctrl_priv *pwrpriv = &Adapter->pwrctrlpriv;
 			u8 trycnt = 100;
+			u32 tmp;
 
 			/* pause tx */
 			rtw_write8(Adapter, REG_TXPAUSE, 0xff);
 
 			/* keep sn */
-			Adapter->xmitpriv.nqos_ssn = rtw_read16(Adapter, REG_NQOS_SEQ);
+			tmp = rtw_read16(Adapter, REG_NQOS_SEQ, &error);
+			if (error)
+				return;
+
+			Adapter->xmitpriv.nqos_ssn = (u16) tmp;
 
 			if (!pwrpriv->bkeepfwalive) {
 				/* RX DMA stop */
-				rtw_write32(Adapter, REG_RXPKT_NUM, (rtw_read32(Adapter, REG_RXPKT_NUM) | RW_RELEASE_EN));
+				tmp = rtw_read32(Adapter, REG_RXPKT_NUM, &error);
+				if (error)
+					return;
+
+				rtw_write32(Adapter, REG_RXPKT_NUM, tmp | RW_RELEASE_EN);
 				do {
-					if (!(rtw_read32(Adapter, REG_RXPKT_NUM) & RXDMA_IDLE))
+					tmp = rtw_read32(Adapter, REG_RXPKT_NUM, &error);
+					if (error)
+						continue;
+
+					if (!(tmp & RXDMA_IDLE))
 						break;
 				} while (trycnt--);
 				if (trycnt == 0)
@@ -1868,7 +2088,10 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 		break;
 	case HW_VAR_BCN_VALID:
 		/* BCN_VALID, BIT(16) of REG_TDECTRL = BIT(0) of REG_TDECTRL+2, write 1 to clear, Clear by sw */
-		rtw_write8(Adapter, REG_TDECTRL + 2, rtw_read8(Adapter, REG_TDECTRL + 2) | BIT(0));
+		val8 = rtw_read8(Adapter, REG_TDECTRL + 2, &error);
+		if (error)
+			return;
+		rtw_write8(Adapter, REG_TDECTRL + 2, val8 | BIT(0));
 		break;
 	default:
 		break;
@@ -1880,17 +2103,26 @@ static void GetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 {
 	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
 	struct odm_dm_struct *podmpriv = &haldata->odmpriv;
+	int error;
+	u32 tmp;
 
 	switch (variable) {
 	case HW_VAR_BASIC_RATE:
 		*((u16 *)(val)) = haldata->BasicRateSet;
 		fallthrough;
 	case HW_VAR_TXPAUSE:
-		val[0] = rtw_read8(Adapter, REG_TXPAUSE);
+		tmp = rtw_read8(Adapter, REG_TXPAUSE, &error);
+		if (error)
+			return;
+
+		val[0] = tmp;
 		break;
 	case HW_VAR_BCN_VALID:
 		/* BCN_VALID, BIT(16) of REG_TDECTRL = BIT(0) of REG_TDECTRL+2 */
-		val[0] = (BIT(0) & rtw_read8(Adapter, REG_TDECTRL + 2)) ? true : false;
+		tmp = rtw_read8(Adapter, REG_TDECTRL + 2, &error);
+		if (error)
+			return;
+		val[0] = (BIT(0) & tmp) ? true : false;
 		break;
 	case HW_VAR_DM_FLAG:
 		val[0] = podmpriv->SupportAbility;
@@ -1907,7 +2139,9 @@ static void GetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 				val[0] = true;
 			} else {
 				u32 valRCR;
-				valRCR = rtw_read32(Adapter, REG_RCR);
+				valRCR = rtw_read32(Adapter, REG_RCR, &error);
+				if (error)
+					return;
 				valRCR &= 0x00070000;
 				if (valRCR)
 					val[0] = false;
@@ -1926,7 +2160,11 @@ static void GetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 		*val = haldata->bMacPwrCtrlOn;
 		break;
 	case HW_VAR_CHK_HI_QUEUE_EMPTY:
-		*val = ((rtw_read32(Adapter, REG_HGQ_INFORMATION) & 0x0000ff00) == 0) ? true : false;
+		tmp = rtw_read32(Adapter, REG_HGQ_INFORMATION, &error);
+		if (error)
+			return;
+
+		*val = ((tmp & 0x0000ff00) == 0) ? true : false;
 		break;
 	default:
 		break;
@@ -2041,6 +2279,7 @@ static u8 SetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eV
 		{
 			u8 dm_func = *((u8 *)pValue);
 			struct odm_dm_struct *podmpriv = &haldata->odmpriv;
+			int error;
 
 			if (dm_func == 0) { /* disable all dynamic func */
 				podmpriv->SupportAbility = DYNAMIC_FUNC_DISABLE;
@@ -2058,7 +2297,12 @@ static u8 SetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eV
 			} else if (dm_func == 6) {/* turn on all dynamic func */
 				if (!(podmpriv->SupportAbility  & DYNAMIC_BB_DIG)) {
 					struct rtw_dig *pDigTable = &podmpriv->DM_DigTable;
-					pDigTable->CurIGValue = rtw_read8(Adapter, 0xc50);
+					u8 tmp = rtw_read8(Adapter, 0xc50, &error);
+					
+					if (error)
+						return _FAIL;
+					
+					pDigTable->CurIGValue = tmp;
 				}
 				podmpriv->SupportAbility = DYNAMIC_ALL_FUNC_ENABLE;
 				DBG_88E("==> Turn on all dynamic function...\n");
@@ -2168,6 +2412,8 @@ static void SetBeaconRelatedRegisters8188EUsb(struct adapter *adapt)
 	struct mlme_ext_priv	*pmlmeext = &adapt->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	u32 bcn_ctrl_reg			= REG_BCN_CTRL;
+	int error;
+	u8 tmp;
 	/* reset TSF, enable update TSF, correcting TSF On Beacon */
 
 	/* BCN interval */
@@ -2178,7 +2424,9 @@ static void SetBeaconRelatedRegisters8188EUsb(struct adapter *adapt)
 
 	rtw_write8(adapt, REG_SLOT, 0x09);
 
-	value32 = rtw_read32(adapt, REG_TCR);
+	value32 = rtw_read32(adapt, REG_TCR, &error);
+	if (error)
+		return;
 	value32 &= ~TSFRST;
 	rtw_write32(adapt,  REG_TCR, value32);
 
@@ -2193,7 +2441,11 @@ static void SetBeaconRelatedRegisters8188EUsb(struct adapter *adapt)
 
 	ResumeTxBeacon(adapt);
 
-	rtw_write8(adapt, bcn_ctrl_reg, rtw_read8(adapt, bcn_ctrl_reg) | BIT(1));
+	tmp = rtw_read8(adapt, bcn_ctrl_reg, &error);
+	if (error)
+		return;
+
+	rtw_write8(adapt, bcn_ctrl_reg, tmp | BIT(1));
 }
 
 static void rtl8188eu_init_default_value(struct adapter *adapt)
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 953fa05dc30c..980af6c02be5 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -101,29 +101,31 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
 	return status;
 }
 
-static u8 usb_read8(struct intf_hdl *pintfhdl, u32 addr)
+static u8 usb_read8(struct intf_hdl *pintfhdl, u32 addr, int *error)
 {
 	u8 requesttype;
 	u16 wvalue;
 	u16 len;
 	u8 data = 0;
+	int res;
 
-
+	if (unlikely(!error))
+		WARN_ON_ONCE("r8188eu: Reading w/o error checking is bad idea\n");
 
 	requesttype = 0x01;/* read_in */
 
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 1;
 
-	usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
-
-
+	res = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
+	if (likely(error))
+		*error = res < 0? res: 0;
 
 	return data;
 
 }
 
-static u16 usb_read16(struct intf_hdl *pintfhdl, u32 addr)
+static u16 usb_read16(struct intf_hdl *pintfhdl, u32 addr, int *error)
 {
 	u8 requesttype;
 	u16 wvalue;
@@ -138,7 +140,7 @@ static u16 usb_read16(struct intf_hdl *pintfhdl, u32 addr)
 	return (u16)(le32_to_cpu(data) & 0xffff);
 }
 
-static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
+static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr, int *error)
 {
 	u8 requesttype;
 	u16 wvalue;
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index f1b3074fa075..7933c267b130 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -85,9 +85,9 @@ struct intf_hdl;
 struct io_queue;
 
 struct _io_ops {
-	u8 (*_read8)(struct intf_hdl *pintfhdl, u32 addr);
-	u16 (*_read16)(struct intf_hdl *pintfhdl, u32 addr);
-	u32 (*_read32)(struct intf_hdl *pintfhdl, u32 addr);
+	u8 (*_read8)(struct intf_hdl *pintfhdl, u32 addr, int *error);
+	u16 (*_read16)(struct intf_hdl *pintfhdl, u32 addr, int *error);
+	u32 (*_read32)(struct intf_hdl *pintfhdl, u32 addr, int *error);
 	int (*_write8)(struct intf_hdl *pintfhdl, u32 addr, u8 val);
 	int (*_write16)(struct intf_hdl *pintfhdl, u32 addr, u16 val);
 	int (*_write32)(struct intf_hdl *pintfhdl, u32 addr, u32 val);
@@ -248,9 +248,9 @@ void unregister_intf_hdl(struct intf_hdl *pintfhdl);
 void _rtw_attrib_read(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 void _rtw_attrib_write(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 
-u8 _rtw_read8(struct adapter *adapter, u32 addr);
-u16 _rtw_read16(struct adapter *adapter, u32 addr);
-u32 _rtw_read32(struct adapter *adapter, u32 addr);
+u8 _rtw_read8(struct adapter *adapter, u32 addr, int *error);
+u16 _rtw_read16(struct adapter *adapter, u32 addr, int *error);
+u32 _rtw_read32(struct adapter *adapter, u32 addr, int *error);
 void _rtw_read_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 void _rtw_read_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 void _rtw_read_port_cancel(struct adapter *adapter);
@@ -270,9 +270,9 @@ u32 _rtw_write_port_and_wait(struct adapter *adapter, u32 addr, u32 cnt,
 			     u8 *pmem, int timeout_ms);
 void _rtw_write_port_cancel(struct adapter *adapter);
 
-#define rtw_read8(adapter, addr) _rtw_read8((adapter), (addr))
-#define rtw_read16(adapter, addr) _rtw_read16((adapter), (addr))
-#define rtw_read32(adapter, addr) _rtw_read32((adapter), (addr))
+#define rtw_read8(adapter, addr, err) _rtw_read8((adapter), (addr), (err))
+#define rtw_read16(adapter, addr, err) _rtw_read16((adapter), (addr), (err))
+#define rtw_read32(adapter, addr, err) _rtw_read32((adapter), (addr), (err))
 #define rtw_read_mem(adapter, addr, cnt, mem)				\
 	_rtw_read_mem((adapter), (addr), (cnt), (mem))
 #define rtw_read_port(adapter, addr, cnt, mem)				\
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index ab4a9200f079..f5ec1daf1c30 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2074,6 +2074,7 @@ static int rtw_wx_read32(struct net_device *dev,
 	u32 data32;
 	u32 bytes;
 	u8 *ptmp;
+	int error;
 
 	padapter = (struct adapter *)rtw_netdev_priv(dev);
 	p = &wrqu->data;
@@ -2093,15 +2094,21 @@ static int rtw_wx_read32(struct net_device *dev,
 
 	switch (bytes) {
 	case 1:
-		data32 = rtw_read8(padapter, addr);
+		data32 = rtw_read8(padapter, addr, &error);
+		if (error)
+			goto end;
 		sprintf(extra, "0x%02X", data32);
 		break;
 	case 2:
-		data32 = rtw_read16(padapter, addr);
+		data32 = rtw_read16(padapter, addr, &error);
+		if (error)
+			goto end;
 		sprintf(extra, "0x%04X", data32);
 		break;
 	case 4:
-		data32 = rtw_read32(padapter, addr);
+		data32 = rtw_read32(padapter, addr, &error);
+		if (error)
+			goto end;
 		sprintf(extra, "0x%08X", data32);
 		break;
 	default:
@@ -2110,8 +2117,9 @@ static int rtw_wx_read32(struct net_device *dev,
 	}
 	DBG_88E(KERN_INFO "%s: addr = 0x%08X data =%s\n", __func__, addr, extra);
 
+end:
 	kfree(ptmp);
-	return 0;
+	return error;
 }
 
 static int rtw_wx_write32(struct net_device *dev,
@@ -2251,6 +2259,7 @@ static void rtw_dbg_mode_hdl(struct adapter *padapter, u32 id, u8 *pdata, u32 le
 	u8 path;
 	u8 offset;
 	u32 value;
+	int error;
 
 	DBG_88E("%s\n", __func__);
 
@@ -2262,13 +2271,13 @@ static void rtw_dbg_mode_hdl(struct adapter *padapter, u32 id, u8 *pdata, u32 le
 		RegRWStruct = (struct mp_rw_reg *)pdata;
 		switch (RegRWStruct->width) {
 		case 1:
-			RegRWStruct->value = rtw_read8(padapter, RegRWStruct->offset);
+			RegRWStruct->value = rtw_read8(padapter, RegRWStruct->offset, &error);
 			break;
 		case 2:
-			RegRWStruct->value = rtw_read16(padapter, RegRWStruct->offset);
+			RegRWStruct->value = rtw_read16(padapter, RegRWStruct->offset, &error);
 			break;
 		case 4:
-			RegRWStruct->value = rtw_read32(padapter, RegRWStruct->offset);
+			RegRWStruct->value = rtw_read32(padapter, RegRWStruct->offset, &error);
 			break;
 		default:
 			break;
@@ -3815,12 +3824,20 @@ static int rtw_cta_test_start(struct net_device *dev,
 		padapter->in_cta_test = 0;
 
 	if (padapter->in_cta_test) {
-		u32 v = rtw_read32(padapter, REG_RCR);
+		u32 v = rtw_read32(padapter, REG_RCR, &ret);
+
+		if (ret)
+			return ret;
+
 		v &= ~(RCR_CBSSID_DATA | RCR_CBSSID_BCN);/*  RCR_ADF */
 		rtw_write32(padapter, REG_RCR, v);
 		DBG_88E("enable RCR_ADF\n");
 	} else {
-		u32 v = rtw_read32(padapter, REG_RCR);
+		u32 v = rtw_read32(padapter, REG_RCR, &ret);
+
+		if (ret)
+			return ret;
+
 		v |= RCR_CBSSID_DATA | RCR_CBSSID_BCN;/*  RCR_ADF */
 		rtw_write32(padapter, REG_RCR, v);
 		DBG_88E("disable RCR_ADF\n");
@@ -3890,18 +3907,19 @@ static int rtw_rereg_nd_name(struct net_device *dev,
 static void mac_reg_dump(struct adapter *padapter)
 {
 	int i, j = 1;
+	int error;
 	pr_info("\n ======= MAC REG =======\n");
 	for (i = 0x0; i < 0x300; i += 4) {
 		if (j % 4 == 1)
 			pr_info("0x%02x", i);
-		pr_info(" 0x%08x ", rtw_read32(padapter, i));
+		pr_info(" 0x%08x ", rtw_read32(padapter, i, &error));
 		if ((j++) % 4 == 0)
 			pr_info("\n");
 	}
 	for (i = 0x400; i < 0x800; i += 4) {
 		if (j % 4 == 1)
 			pr_info("0x%02x", i);
-		pr_info(" 0x%08x ", rtw_read32(padapter, i));
+		pr_info(" 0x%08x ", rtw_read32(padapter, i, &error));
 		if ((j++) % 4 == 0)
 			pr_info("\n");
 	}
@@ -3910,12 +3928,13 @@ static void mac_reg_dump(struct adapter *padapter)
 static void bb_reg_dump(struct adapter *padapter)
 {
 	int i, j = 1;
+	int error;
 	pr_info("\n ======= BB REG =======\n");
 	for (i = 0x800; i < 0x1000; i += 4) {
 		if (j % 4 == 1)
 			pr_info("0x%02x", i);
 
-		pr_info(" 0x%08x ", rtw_read32(padapter, i));
+		pr_info(" 0x%08x ", rtw_read32(padapter, i, &error));
 		if ((j++) % 4 == 0)
 			pr_info("\n");
 	}
@@ -3964,6 +3983,8 @@ static int rtw_dbg_port(struct net_device *dev,
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 	struct wlan_network *cur_network = &pmlmepriv->cur_network;
 	struct sta_priv *pstapriv = &padapter->stapriv;
+	int error;
+	u32 tmp;
 
 	pdata = (u32 *)&wrqu->data;
 
@@ -3978,13 +3999,22 @@ static int rtw_dbg_port(struct net_device *dev,
 	case 0x70:/* read_reg */
 		switch (minor_cmd) {
 		case 1:
-			DBG_88E("rtw_read8(0x%x) = 0x%02x\n", arg, rtw_read8(padapter, arg));
+			tmp = rtw_read8(padapter, arg, &error);
+			if (error)
+				return error;
+			DBG_88E("rtw_read8(0x%x) = 0x%02x\n", arg, (u8) tmp);
 			break;
 		case 2:
-			DBG_88E("rtw_read16(0x%x) = 0x%04x\n", arg, rtw_read16(padapter, arg));
+			tmp = rtw_read16(padapter, arg, &error);
+			if (error)
+				return error;
+			DBG_88E("rtw_read16(0x%x) = 0x%04x\n", arg, (u16) tmp);
 			break;
 		case 4:
-			DBG_88E("rtw_read32(0x%x) = 0x%08x\n", arg, rtw_read32(padapter, arg));
+			tmp = rtw_read32(padapter, arg, &error);
+			if (error)
+				return error;
+			DBG_88E("rtw_read32(0x%x) = 0x%08x\n", arg, tmp);
 			break;
 		}
 		break;
@@ -3992,15 +4022,15 @@ static int rtw_dbg_port(struct net_device *dev,
 		switch (minor_cmd) {
 		case 1:
 			rtw_write8(padapter, arg, extra_arg);
-			DBG_88E("rtw_write8(0x%x) = 0x%02x\n", arg, rtw_read8(padapter, arg));
+			DBG_88E("rtw_write8(0x%x) = 0x%02x\n", arg, rtw_read8(padapter, arg, &error));
 			break;
 		case 2:
 			rtw_write16(padapter, arg, extra_arg);
-			DBG_88E("rtw_write16(0x%x) = 0x%04x\n", arg, rtw_read16(padapter, arg));
+			DBG_88E("rtw_write16(0x%x) = 0x%04x\n", arg, rtw_read16(padapter, arg, &error));
 			break;
 		case 4:
 			rtw_write32(padapter, arg, extra_arg);
-			DBG_88E("rtw_write32(0x%x) = 0x%08x\n", arg, rtw_read32(padapter, arg));
+			DBG_88E("rtw_write32(0x%x) = 0x%08x\n", arg, rtw_read32(padapter, arg, &error));
 			break;
 		}
 		break;
@@ -4096,7 +4126,10 @@ static int rtw_dbg_port(struct net_device *dev,
 			if (_SUCCESS != rtw_IOL_exec_cmds_sync(padapter, xmit_frame, 5000, 0))
 				ret = -EPERM;
 
-			final = rtw_read8(padapter, reg);
+			final = rtw_read8(padapter, reg, &error);
+			if (error)
+				return error;
+
 			if (start_value + write_num - 1 == final)
 				DBG_88E("continuous IOL_CMD_WB_REG to 0x%x %u times Success, start:%u, final:%u\n", reg, write_num, start_value, final);
 			else
@@ -4125,7 +4158,9 @@ static int rtw_dbg_port(struct net_device *dev,
 			if (_SUCCESS != rtw_IOL_exec_cmds_sync(padapter, xmit_frame, 5000, 0))
 				ret = -EPERM;
 
-			final = rtw_read16(padapter, reg);
+			final = rtw_read16(padapter, reg, &error);
+			if (error)
+				return error;
 			if (start_value + write_num - 1 == final)
 				DBG_88E("continuous IOL_CMD_WW_REG to 0x%x %u times Success, start:%u, final:%u\n", reg, write_num, start_value, final);
 			else
@@ -4153,7 +4188,9 @@ static int rtw_dbg_port(struct net_device *dev,
 			if (_SUCCESS != rtw_IOL_exec_cmds_sync(padapter, xmit_frame, 5000, 0))
 				ret = -EPERM;
 
-			final = rtw_read32(padapter, reg);
+			final = rtw_read32(padapter, reg, &error);
+			if (error)
+				return error;
 			if (start_value + write_num - 1 == final)
 				DBG_88E("continuous IOL_CMD_WD_REG to 0x%x %u times Success, start:%u, final:%u\n",
 					reg, write_num, start_value, final);
@@ -4423,39 +4460,39 @@ static int rtw_dbg_port(struct net_device *dev,
 
 		case 0xfd:
 			rtw_write8(padapter, 0xc50, arg);
-			DBG_88E("wr(0xc50) = 0x%x\n", rtw_read8(padapter, 0xc50));
+			DBG_88E("wr(0xc50) = 0x%x\n", rtw_read8(padapter, 0xc50, &error));
 			rtw_write8(padapter, 0xc58, arg);
-			DBG_88E("wr(0xc58) = 0x%x\n", rtw_read8(padapter, 0xc58));
+			DBG_88E("wr(0xc58) = 0x%x\n", rtw_read8(padapter, 0xc58, &error));
 			break;
 		case 0xfe:
-			DBG_88E("rd(0xc50) = 0x%x\n", rtw_read8(padapter, 0xc50));
-			DBG_88E("rd(0xc58) = 0x%x\n", rtw_read8(padapter, 0xc58));
+			DBG_88E("rd(0xc50) = 0x%x\n", rtw_read8(padapter, 0xc50, &error));
+			DBG_88E("rd(0xc58) = 0x%x\n", rtw_read8(padapter, 0xc58, &error));
 			break;
 		case 0xff:
-			DBG_88E("dbg(0x210) = 0x%x\n", rtw_read32(padapter, 0x210));
-			DBG_88E("dbg(0x608) = 0x%x\n", rtw_read32(padapter, 0x608));
-			DBG_88E("dbg(0x280) = 0x%x\n", rtw_read32(padapter, 0x280));
-			DBG_88E("dbg(0x284) = 0x%x\n", rtw_read32(padapter, 0x284));
-			DBG_88E("dbg(0x288) = 0x%x\n", rtw_read32(padapter, 0x288));
+			DBG_88E("dbg(0x210) = 0x%x\n", rtw_read32(padapter, 0x210, &error));
+			DBG_88E("dbg(0x608) = 0x%x\n", rtw_read32(padapter, 0x608, &error));
+			DBG_88E("dbg(0x280) = 0x%x\n", rtw_read32(padapter, 0x280, &error));
+			DBG_88E("dbg(0x284) = 0x%x\n", rtw_read32(padapter, 0x284, &error));
+			DBG_88E("dbg(0x288) = 0x%x\n", rtw_read32(padapter, 0x288, &error));
 
-			DBG_88E("dbg(0x664) = 0x%x\n", rtw_read32(padapter, 0x664));
+			DBG_88E("dbg(0x664) = 0x%x\n", rtw_read32(padapter, 0x664, &error));
 
 			DBG_88E("\n");
 
-			DBG_88E("dbg(0x430) = 0x%x\n", rtw_read32(padapter, 0x430));
-			DBG_88E("dbg(0x438) = 0x%x\n", rtw_read32(padapter, 0x438));
+			DBG_88E("dbg(0x430) = 0x%x\n", rtw_read32(padapter, 0x430, &error));
+			DBG_88E("dbg(0x438) = 0x%x\n", rtw_read32(padapter, 0x438, &error));
 
-			DBG_88E("dbg(0x440) = 0x%x\n", rtw_read32(padapter, 0x440));
+			DBG_88E("dbg(0x440) = 0x%x\n", rtw_read32(padapter, 0x440, &error));
 
-			DBG_88E("dbg(0x458) = 0x%x\n", rtw_read32(padapter, 0x458));
+			DBG_88E("dbg(0x458) = 0x%x\n", rtw_read32(padapter, 0x458, &error));
 
-			DBG_88E("dbg(0x484) = 0x%x\n", rtw_read32(padapter, 0x484));
-			DBG_88E("dbg(0x488) = 0x%x\n", rtw_read32(padapter, 0x488));
+			DBG_88E("dbg(0x484) = 0x%x\n", rtw_read32(padapter, 0x484, &error));
+			DBG_88E("dbg(0x488) = 0x%x\n", rtw_read32(padapter, 0x488, &error));
 
-			DBG_88E("dbg(0x444) = 0x%x\n", rtw_read32(padapter, 0x444));
-			DBG_88E("dbg(0x448) = 0x%x\n", rtw_read32(padapter, 0x448));
-			DBG_88E("dbg(0x44c) = 0x%x\n", rtw_read32(padapter, 0x44c));
-			DBG_88E("dbg(0x450) = 0x%x\n", rtw_read32(padapter, 0x450));
+			DBG_88E("dbg(0x444) = 0x%x\n", rtw_read32(padapter, 0x444, &error));
+			DBG_88E("dbg(0x448) = 0x%x\n", rtw_read32(padapter, 0x448, &error));
+			DBG_88E("dbg(0x44c) = 0x%x\n", rtw_read32(padapter, 0x44c, &error));
+			DBG_88E("dbg(0x450) = 0x%x\n", rtw_read32(padapter, 0x450, &error));
 			break;
 		}
 		break;
@@ -5326,6 +5363,8 @@ static int rtw_mp_read_reg(struct net_device *dev,
 	char data[20], tmp[20];
 	u32 addr;
 	u32 ret, i = 0, j = 0, strtout = 0;
+	int error;
+	u32 tmp_;
 
 	if (!input)
 		return -ENOMEM;
@@ -5361,12 +5400,20 @@ static int rtw_mp_read_reg(struct net_device *dev,
 	switch (width) {
 	case 'b':
 		/*  1 byte */
-		sprintf(extra, "%d\n",  rtw_read8(padapter, addr));
+		tmp_ = rtw_read16(padapter, addr, &error);
+		if (error)
+			return error;
+
+		sprintf(extra, "%d\n", (u8) tmp_);
 		wrqu->length = strlen(extra);
 		break;
 	case 'w':
 		/*  2 bytes */
-		sprintf(data, "%04x\n", rtw_read16(padapter, addr));
+		tmp_ = rtw_read16(padapter, addr, &error);
+		if (error)
+			return error;
+
+		sprintf(data, "%04x\n", (u16) tmp_);
 		for (i = 0; i <= strlen(data); i++) {
 			if (i % 2 == 0) {
 				tmp[j] = ' ';
@@ -5396,8 +5443,12 @@ static int rtw_mp_read_reg(struct net_device *dev,
 		wrqu->length = 6;
 		break;
 	case 'd':
+		tmp_ = rtw_read32(padapter, addr, &error);
+		if (error)
+			return error;
+
 		/*  4 bytes */
-		sprintf(data, "%08x", rtw_read32(padapter, addr));
+		sprintf(data, "%08x", tmp_);
 		/* add read data format blank */
 		for (i = 0; i <= strlen(data); i++) {
 			if (i % 2 == 0) {
@@ -5889,6 +5940,8 @@ static int rtw_mp_arx(struct net_device *dev,
 	u32 cckok = 0, cckcrc = 0, ofdmok = 0, ofdmcrc = 0, htok = 0, htcrc = 0, OFDM_FA = 0, CCK_FA = 0;
 	char	*input = kmalloc(wrqu->length, GFP_KERNEL);
 	struct adapter *padapter = rtw_netdev_priv(dev);
+	u8 tmp;
+	int error;
 
 	if (!input)
 		return -ENOMEM;
@@ -5934,7 +5987,18 @@ static int rtw_mp_arx(struct net_device *dev,
 		OFDM_FA = read_bbreg(padapter, 0xda4, 0x0000FFFF);
 		OFDM_FA = read_bbreg(padapter, 0xda4, 0xFFFF0000);
 		OFDM_FA = read_bbreg(padapter, 0xda8, 0x0000FFFF);
-		CCK_FA = (rtw_read8(padapter, 0xa5b) << 8) | (rtw_read8(padapter, 0xa5c));
+
+		tmp = rtw_read8(padapter, 0xa5b, &error);
+		if (error)
+			return error;
+
+		CCK_FA = (tmp << 8);
+
+		tmp = rtw_read8(padapter, 0xa5c, &error);
+		if (error)
+			return error;
+
+		CCK_FA |= (tmp);
 
 		sprintf(extra, "Phy Received packet OK:%d CRC error:%d FA Counter: %d", cckok + ofdmok + htok, cckcrc + ofdmcrc + htcrc, OFDM_FA + CCK_FA);
 	}
@@ -6097,20 +6161,30 @@ static int rtw_mp_dump(struct net_device *dev,
 	u8 rf_type, path_nums = 0;
 	u32 i, j = 1, path;
 	struct adapter *padapter = rtw_netdev_priv(dev);
+	int error;
+	u32 tmp;
 
 	if (strncmp(extra, "all", 4) == 0) {
 		DBG_88E("\n ======= MAC REG =======\n");
 		for (i = 0x0; i < 0x300; i += 4) {
 			if (j % 4 == 1)
 				DBG_88E("0x%02x", i);
-			DBG_88E(" 0x%08x ", rtw_read32(padapter, i));
+			
+			tmp = rtw_read32(padapter, i, &error);
+			if (!error)
+				DBG_88E(" 0x%08x ", tmp);
+
 			if ((j++) % 4 == 0)
 				DBG_88E("\n");
 		}
 		for (i = 0x400; i < 0x1000; i += 4) {
 			if (j % 4 == 1)
 				DBG_88E("0x%02x", i);
-			DBG_88E(" 0x%08x ", rtw_read32(padapter, i));
+
+			tmp = rtw_read32(padapter, i, &error);
+			if (!error)
+				DBG_88E(" 0x%08x ", tmp);
+
 			if ((j++) % 4 == 0)
 				DBG_88E("\n");
 		}
-- 
2.32.0

