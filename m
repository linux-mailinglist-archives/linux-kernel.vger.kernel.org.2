Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913F13A7D7E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 13:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhFOLsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 07:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhFOLr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:47:59 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF53C061767
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 04:45:54 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id nb6so1891364ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 04:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cjnjDoJBfZhZJVO2FID2+A6Z+bbUnLGHOvVeeup41CI=;
        b=CRm6tR+lE8D0BZKRUMkTP1Oo3QURCpIVNE5SyqLH+71S/0AhKbsglRsjgJ88W5aMfk
         T8ECeamUdTBBf7LMH4u2UllItfThCHFaQHl1Q2+NCaRn2PxEOwgP7p015/hjgAbVtdNc
         LUFHYW/bNHtfSlV2c/1jvXXOLdGLfoWZO93IZLa5/sb9PqO9vU3qvB90wt6TEnEQF8AX
         7XMRPmwRwr7QjzvGFYelDPYYAhK9h49zDr1lO+9Pz0SogdJPEqvLS0SKWrr8xrGn7f2U
         4XSt3PTGCiy92NEt73BYS9pxehM2jDPL1kFPeuiPLLNPkFgHtH91OtAl48imbTHn1/xB
         G3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cjnjDoJBfZhZJVO2FID2+A6Z+bbUnLGHOvVeeup41CI=;
        b=Ltr5i5+L6gHrA4OT8bty9S1WKMda85c4GabB86+XXl020XBi08t4xLiz1am2pPoz1C
         UsEYxe5JgBFQOLERu4d2q08+X1CLpihCHNWTZNmgIROjbiW8bpTQ+h9Jo7SVzWT/HBN9
         WIXu3tuStnU1VwCLlLLZeSPJS7ThH/Gma5uDvjX6UAggpfTTbkWO5EWL3aOBa9Aodgqd
         zJK8cExAkdZ/40Rz5UzKpy0jFEIr/mrUwXuf2YyXnDE6LPmOaJgEUBiuVQ3VE6Jdc3go
         NRx11Gl+HdlntsLqfUTP7iA9/YvBFf6LyB5CES4LCHX6D1oaCWzXZ7CsWrL4zaCpICr9
         9SlA==
X-Gm-Message-State: AOAM530+LGTslJQ/J4tTWxgWpW+Oz2UyNeeAKGsrhLxFMWbzHKkSsHMQ
        k9y8y/Ynq9f4M5AEoh5CYdPrPK+zjB5LIQ==
X-Google-Smtp-Source: ABdhPJz/5fROQTw1dvpDAlFl30mJTG6TV+UM0nyoxn0QBlvgAt5KaXZOz8ghFsd7JTcRASGpMjohdg==
X-Received: by 2002:a17:906:d15a:: with SMTP id br26mr20827617ejb.232.1623757551865;
        Tue, 15 Jun 2021 04:45:51 -0700 (PDT)
Received: from agape ([5.171.72.142])
        by smtp.gmail.com with ESMTPSA id w8sm1970829edq.67.2021.06.15.04.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 04:45:51 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] staging: rtl8723bs: remove two unused files from tree
Date:   Tue, 15 Jun 2021 13:45:38 +0200
Message-Id: <ef7c21270ccaa2ee3d48b93d0a16fa55911c6cce.1623756906.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1623756906.git.fabioaiuto83@gmail.com>
References: <cover.1623756906.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused files from tree, for they are excluded
by the build process.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_eeprom.c  | 208 -------------------
 drivers/staging/rtl8723bs/include/drv_conf.h |  18 --
 2 files changed, 226 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/core/rtw_eeprom.c
 delete mode 100644 drivers/staging/rtl8723bs/include/drv_conf.h

diff --git a/drivers/staging/rtl8723bs/core/rtw_eeprom.c b/drivers/staging/rtl8723bs/core/rtw_eeprom.c
deleted file mode 100644
index 4dcee4d2e513..000000000000
--- a/drivers/staging/rtl8723bs/core/rtw_eeprom.c
+++ /dev/null
@@ -1,208 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-#include <drv_conf.h>
-#include <osdep_service.h>
-#include <drv_types.h>
-
-void up_clk(_adapter *padapter,	 u16 *x)
-{
-_func_enter_;
-	*x = *x | _EESK;
-	rtw_write8(padapter, EE_9346CR, (u8)*x);
-	udelay(CLOCK_RATE);
-
-_func_exit_;
-
-}
-
-void down_clk(_adapter *padapter, u16 *x)
-{
-_func_enter_;
-	*x = *x & ~_EESK;
-	rtw_write8(padapter, EE_9346CR, (u8)*x);
-	udelay(CLOCK_RATE);
-_func_exit_;
-}
-
-void shift_out_bits(_adapter *padapter, u16 data, u16 count)
-{
-	u16 x, mask;
-_func_enter_;
-
-	if (padapter->bSurpriseRemoved)
-		goto out;
-
-	mask = 0x01 << (count - 1);
-	x = rtw_read8(padapter, EE_9346CR);
-
-	x &= ~(_EEDO | _EEDI);
-
-	do {
-		x &= ~_EEDI;
-		if (data & mask)
-			x |= _EEDI;
-		if (padapter->bSurpriseRemoved)
-			goto out;
-
-		rtw_write8(padapter, EE_9346CR, (u8)x);
-		udelay(CLOCK_RATE);
-		up_clk(padapter, &x);
-		down_clk(padapter, &x);
-		mask = mask >> 1;
-	} while (mask);
-	if (padapter->bSurpriseRemoved)
-		goto out;
-
-	x &= ~_EEDI;
-	rtw_write8(padapter, EE_9346CR, (u8)x);
-out:
-_func_exit_;
-}
-
-u16 shift_in_bits(_adapter *padapter)
-{
-	u16 x, d = 0, i;
-_func_enter_;
-	if (padapter->bSurpriseRemoved)
-		goto out;
-
-	x = rtw_read8(padapter, EE_9346CR);
-
-	x &= ~(_EEDO | _EEDI);
-	d = 0;
-
-	for (i = 0; i < 16; i++) {
-		d = d << 1;
-		up_clk(padapter, &x);
-	if (padapter->bSurpriseRemoved)
-		goto out;
-
-		x = rtw_read8(padapter, EE_9346CR);
-
-		x &= ~(_EEDI);
-		if (x & _EEDO)
-		d |= 1;
-
-		down_clk(padapter, &x);
-	}
-out:
-_func_exit_;
-
-	return d;
-}
-
-void standby(_adapter *padapter)
-{
-	u8   x;
-_func_enter_;
-	x = rtw_read8(padapter, EE_9346CR);
-
-	x &= ~(_EECS | _EESK);
-	rtw_write8(padapter, EE_9346CR, x);
-
-	udelay(CLOCK_RATE);
-	x |= _EECS;
-	rtw_write8(padapter, EE_9346CR, x);
-	udelay(CLOCK_RATE);
-_func_exit_;
-}
-
-void eeprom_clean(_adapter *padapter)
-{
-	u16 x;
-_func_enter_;
-	if (padapter->bSurpriseRemoved)
-		goto out;
-
-	x = rtw_read8(padapter, EE_9346CR);
-	if (padapter->bSurpriseRemoved)
-		goto out;
-
-	x &= ~(_EECS | _EEDI);
-	rtw_write8(padapter, EE_9346CR, (u8)x);
-	if (padapter->bSurpriseRemoved)
-		goto out;
-
-	up_clk(padapter, &x);
-	if (padapter->bSurpriseRemoved)
-		goto out;
-
-	down_clk(padapter, &x);
-out:
-_func_exit_;
-}
-
-u16 eeprom_read16(_adapter *padapter, u16 reg) /*ReadEEprom*/
-{
-
-	u16 x;
-	u16 data = 0;
-
-_func_enter_;
-
-	if (padapter->bSurpriseRemoved)
-		goto out;
-
-	/* select EEPROM, reset bits, set _EECS*/
-	x = rtw_read8(padapter, EE_9346CR);
-
-	if (padapter->bSurpriseRemoved)
-		goto out;
-
-	x &= ~(_EEDI | _EEDO | _EESK | _EEM0);
-	x |= _EEM1 | _EECS;
-	rtw_write8(padapter, EE_9346CR, (unsigned char)x);
-
-	/* write the read opcode and register number in that order*/
-	/* The opcode is 3bits in length, reg is 6 bits long*/
-	shift_out_bits(padapter, EEPROM_READ_OPCODE, 3);
-	shift_out_bits(padapter, reg, padapter->EepromAddressSize);
-
-	/* Now read the data (16 bits) in from the selected EEPROM word*/
-	data = shift_in_bits(padapter);
-
-	eeprom_clean(padapter);
-out:
-_func_exit_;
-	return data;
-
-
-}
-
-/*addr_off : address offset of the entry in eeprom (not the tuple number of eeprom (reg); that is addr_off !=reg)*/
-u8 eeprom_read(_adapter *padapter, u32 addr_off, u8 sz, u8 *rbuf)
-{
-	u8 quotient, remainder, addr_2align_odd;
-	u16 reg, stmp, i = 0, idx = 0;
-_func_enter_;
-	reg = (u16)(addr_off >> 1);
-	addr_2align_odd = (u8)(addr_off & 0x1);
-
-	/*read that start at high part: e.g  1,3,5,7,9,...*/
-	if (addr_2align_odd) {
-		stmp = eeprom_read16(padapter, reg);
-		rbuf[idx++] = (u8) ((stmp>>8)&0xff); /*return hogh-part of the short*/
-		reg++; sz--;
-	}
-
-	quotient = sz >> 1;
-	remainder = sz & 0x1;
-
-	for (i = 0; i < quotient; i++) {
-		stmp = eeprom_read16(padapter, reg+i);
-		rbuf[idx++] = (u8) (stmp&0xff);
-		rbuf[idx++] = (u8) ((stmp>>8)&0xff);
-	}
-
-	reg = reg+i;
-	if (remainder) { /*end of read at lower part of short : 0,2,4,6,...*/
-		stmp = eeprom_read16(padapter, reg);
-		rbuf[idx] = (u8)(stmp & 0xff);
-	}
-_func_exit_;
-	return true;
-}
diff --git a/drivers/staging/rtl8723bs/include/drv_conf.h b/drivers/staging/rtl8723bs/include/drv_conf.h
deleted file mode 100644
index 9e8c37b29a7f..000000000000
--- a/drivers/staging/rtl8723bs/include/drv_conf.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-#ifndef __DRV_CONF_H__
-#define __DRV_CONF_H__
-
-#define DYNAMIC_CAMID_ALLOC
-
-#ifndef CONFIG_RTW_HIQ_FILTER
-	#define CONFIG_RTW_HIQ_FILTER 1
-#endif
-
-//#include <rtl871x_byteorder.h>
-
-#endif // __DRV_CONF_H__
-- 
2.20.1

