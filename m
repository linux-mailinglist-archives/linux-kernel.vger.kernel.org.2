Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E47E40C577
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbhIOMnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237734AbhIOMnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:43:51 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1CDC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 05:42:32 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id x11so5994086ejv.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 05:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UUJSGDbnVaSW6IkF1hmLWYJune4CPKV8br/bhPi+Sss=;
        b=KVBmqGlksO/YHajAvQWojtbyobVvFCKIsoL22ytLUQvy48EeQgxO3C2/j1kS3rSEFO
         pi9AIZ7ugo0eyWhTLOBotYIJyqJu9uNNv3KzeqhBSkHyOGPSzvTwQqgofAINEL7tUSmJ
         +cjVZ4chXZc+lpw1UmR1x5Rk6fdKW6SLIIFpdGMa4Gcl8fdT66wwgWN59YlOsbM8NzUo
         EyNX5+ABuVH+Qi8XQFZkv700jpbuGRtWKqD8nE9n9+6pb6k8wYBi0IMDDqpZ/hThlexS
         HUFXIKTRwGMQbnjWXIo7r/atdlcnhJFxvYBi5jN+ztaztJ0BfjYxybdHri1AcXyxwEtI
         oxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UUJSGDbnVaSW6IkF1hmLWYJune4CPKV8br/bhPi+Sss=;
        b=ol9c2H7IkrgeCzN1LHLypqzCD0bx2eZgj1VSHzhfUYzYY09mxSnlOwCW8/9//diQvQ
         0i5/f7elZ+evTetAh6XWOqEMk4RRg5OA0/WhksXuwiqcNz/xEQgsQN7uArHZKmi5g1ln
         yQlB/ls+A5pzP5QQAv6yNGSnPfUNimmO0tf5LQZvXY4Upf1LzG3KA+TzW4T10PdZ6Kf2
         xqcJoN9lHPIns8e++3M16rnTb6DcDlATjhxHbVhv+mQ4xgsIxkRxfzoLnmZxnpA+FRxh
         URdicJaG4+ysy4oY6DahJMx72T1ZHp2wQfu6Iw26XWCh8EKg0vOmh1HJ27pH7Vkzbiz3
         7AyQ==
X-Gm-Message-State: AOAM533lc+eMeBwx/sW9pN9d6ngU3bc7mZEa5WvXRSSvkI5oL1m23dzC
        VY7bJOXOHUfPU3qq4eJ37Ir7vr+yDCE=
X-Google-Smtp-Source: ABdhPJwZorau7lPu8lHGcPkWuGlCc1maejdMyaSfbCBypISeAuOkxKB+nQbkMQKcXdYyI398pSVPlg==
X-Received: by 2002:a17:906:30d6:: with SMTP id b22mr25670622ejb.442.1631709751480;
        Wed, 15 Sep 2021 05:42:31 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-43-5-131.retail.telecomitalia.it. [79.43.5.131])
        by smtp.gmail.com with ESMTPSA id s3sm6394002ejm.49.2021.09.15.05.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 05:42:30 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Philip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v5 04/19] staging: r8188eu: remove the helpers of rtw_read32()
Date:   Wed, 15 Sep 2021 14:41:34 +0200
Message-Id: <20210915124149.27543-5-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915124149.27543-1-fmdefrancesco@gmail.com>
References: <20210915124149.27543-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Skripkin <paskripkin@gmail.com>

Remove the unnecessary _rtw_readr32() and usb_read32() and embed their
code into the caller (i.e., rtw_read32()).

_rtw_read32() is a mere redefinition of rtw_read32() and it is unneeded.
usb_read32() was the only functions assigned to the (*_usb_read32) pointer,
so we can simply remove it and make a direct call.

This patch is in preparation for the _io_ops structure removal.

Co-developed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_io.c       | 14 --------------
 drivers/staging/r8188eu/hal/usb_ops_linux.c |  5 +++--
 drivers/staging/r8188eu/include/rtw_io.h    |  3 +--
 3 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_io.c b/drivers/staging/r8188eu/core/rtw_io.c
index b5d1c8e52b22..cb24500cbc6e 100644
--- a/drivers/staging/r8188eu/core/rtw_io.c
+++ b/drivers/staging/r8188eu/core/rtw_io.c
@@ -34,20 +34,6 @@ jackson@realtek.com.tw
 #define rtw_cpu_to_le16(val)		cpu_to_le16(val)
 #define rtw_cpu_to_le32(val)		cpu_to_le32(val)
 
-u32 _rtw_read32(struct adapter *adapter, u32 addr)
-{
-	u32 r_val;
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
-	u32	(*_read32)(struct intf_hdl *pintfhdl, u32 addr);
-
-	_read32 = pintfhdl->io_ops._read32;
-
-	r_val = _read32(pintfhdl, addr);
-
-	return r_val;
-}
-
 int _rtw_write8(struct adapter *adapter, u32 addr, u8 val)
 {
 	struct io_priv *pio_priv = &adapter->iopriv;
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 8b4fc014d93a..39fd9994787d 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -121,8 +121,10 @@ u16 rtw_read16(struct adapter *adapter, u32 addr)
 	return (u16)(le32_to_cpu(data) & 0xffff);
 }
 
-static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
+u32 rtw_read32(struct adapter *adapter, u32 addr)
 {
+	struct io_priv *pio_priv = &adapter->iopriv;
+	struct intf_hdl *pintfhdl = &pio_priv->intf;
 	u16 wvalue = (u16)(addr & 0x0000ffff);
 	__le32 data;
 
@@ -542,7 +544,6 @@ void rtl8188eu_set_intf_ops(struct _io_ops	*pops)
 {
 
 	memset((u8 *)pops, 0, sizeof(struct _io_ops));
-	pops->_read32 = &usb_read32;
 	pops->_read_port = &usb_read_port;
 	pops->_write8 = &usb_write8;
 	pops->_write16 = &usb_write16;
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index 527503d3ecc8..c53d9c8bd9a7 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -247,7 +247,7 @@ void _rtw_attrib_write(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 
 u8 rtw_read8(struct adapter *adapter, u32 addr);
 u16 rtw_read16(struct adapter *adapter, u32 addr);
-u32 _rtw_read32(struct adapter *adapter, u32 addr);
+u32 rtw_read32(struct adapter *adapter, u32 addr);
 void _rtw_read_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 void _rtw_read_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 void _rtw_read_port_cancel(struct adapter *adapter);
@@ -267,7 +267,6 @@ u32 _rtw_write_port_and_wait(struct adapter *adapter, u32 addr, u32 cnt,
 			     u8 *pmem, int timeout_ms);
 void _rtw_write_port_cancel(struct adapter *adapter);
 
-#define rtw_read32(adapter, addr) _rtw_read32((adapter), (addr))
 #define rtw_read_port(adapter, addr, cnt, mem)				\
 	_rtw_read_port((adapter), (addr), (cnt), (mem))
 #define rtw_read_port_cancel(adapter) _rtw_read_port_cancel((adapter))
-- 
2.33.0

