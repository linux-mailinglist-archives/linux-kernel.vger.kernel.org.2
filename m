Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32213E34AF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 12:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbhHGKOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 06:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbhHGKMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:12:51 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0757C0617A5
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 03:12:19 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id k9so16824294edr.10
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 03:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NyiIplakq4MSvNabcXva5WLk0bCoGGYQJOMtAI5jTQE=;
        b=JIBmOfnaNdA8WbEBNlCfHWe8Bc0PZmb730kfI/ppZMzZAoVCkZEoi0w+j6EhsYOlw/
         1MdQJwwBNp/UjWUlKO7bH7O+Gmp7KdUTqH2DvozLKhK2gXWE1ozXOFbB8HnhwWllMgfJ
         c2ctDwxc1czIbAZpoEKS02fsTv6y+w1h6INXk4Zjii3wN4lXJ+OqNuMZf82Tnt5cpvvt
         2lPQVHk00zuCwfF7JcZOM5NbilktdLJHG7HTlhD6hzGmKdYAR511pUZSuW9GqfmTs6RD
         Q8NgGQLCarAOrMXsyUBC3hWmWcul4OLe6+BTbpt7jgVhYuJEMncfy9rAmLGYLRoPyICN
         NX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NyiIplakq4MSvNabcXva5WLk0bCoGGYQJOMtAI5jTQE=;
        b=Vcq7rGFgC7fNuNU7cpR47RTQ6QCsK3ftyTbKUE2CbSEVP6qt+/LKSgSdvLLK7jeU7W
         SgWBi9q7QsX8AFECXM15vjwUPo46CdHrSfCcw3QNgdN03aGJ270qsBEZpqjNjhGwLVLC
         Fce8tLsXB72YfGE7XKLwnu3K6dzeZeYzAJj33DU71srtvBW/+4PfEBOzkiIMbJimg53Z
         L/3VRO6/xumVYba00EBQql0w4WGhO/Q2F+Yw5MUv506PxMRes8aU8WVibvvG1q0bUVAr
         8RaLvdVZ3IeOqX+OeFWPWRvpqgaeSccPYoAM6mMT0KSpNCfiqrD6G559I2Cwj84i5uV2
         gKyg==
X-Gm-Message-State: AOAM530H9TKp+E+Dw4SbwTOnAkLY2w9cgJQEq2OmNTRiwLYZiBQS7p/O
        lTsiQSSRLm888Yl0PSsj764=
X-Google-Smtp-Source: ABdhPJziSVqJn+U00tOIPcaqcIxGYHDt/XDcYD6f6LqFbB82uX4wcr3dvkv7SRwfQDrTG9ORhi/JCQ==
X-Received: by 2002:a05:6402:28a4:: with SMTP id eg36mr18438940edb.84.1628331137732;
        Sat, 07 Aug 2021 03:12:17 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::a83e])
        by smtp.gmail.com with ESMTPSA id u4sm3662514eje.81.2021.08.07.03.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 03:12:17 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 14/17] staging: r8188eu: remove unnecessary parentheses in core/rtw_io.c
Date:   Sat,  7 Aug 2021 12:11:16 +0200
Message-Id: <20210807101119.16085-15-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210807101119.16085-1-straube.linux@gmail.com>
References: <20210807101119.16085-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses in core/rtw_io.c reported by
checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_io.c | 32 +++++++++++++--------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_io.c b/drivers/staging/r8188eu/core/rtw_io.c
index 2a47329d90e8..b5cd9bbc1ce1 100644
--- a/drivers/staging/r8188eu/core/rtw_io.c
+++ b/drivers/staging/r8188eu/core/rtw_io.c
@@ -38,7 +38,7 @@ u8 _rtw_read8(struct adapter *adapter, u32 addr)
 {
 	u8 r_val;
 	struct io_priv *pio_priv = &adapter->iopriv;
-	struct	intf_hdl *pintfhdl = &(pio_priv->intf);
+	struct	intf_hdl *pintfhdl = &pio_priv->intf;
 	u8 (*_read8)(struct intf_hdl *pintfhdl, u32 addr);
 
 
@@ -52,7 +52,7 @@ u16 _rtw_read16(struct adapter *adapter, u32 addr)
 {
 	u16 r_val;
 	struct io_priv *pio_priv = &adapter->iopriv;
-	struct	intf_hdl		*pintfhdl = &(pio_priv->intf);
+	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
 	u16 (*_read16)(struct intf_hdl *pintfhdl, u32 addr);
 
 	_read16 = pintfhdl->io_ops._read16;
@@ -66,7 +66,7 @@ u32 _rtw_read32(struct adapter *adapter, u32 addr)
 {
 	u32 r_val;
 	struct io_priv *pio_priv = &adapter->iopriv;
-	struct	intf_hdl		*pintfhdl = &(pio_priv->intf);
+	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
 	u32	(*_read32)(struct intf_hdl *pintfhdl, u32 addr);
 
 	_read32 = pintfhdl->io_ops._read32;
@@ -79,7 +79,7 @@ u32 _rtw_read32(struct adapter *adapter, u32 addr)
 int _rtw_write8(struct adapter *adapter, u32 addr, u8 val)
 {
 	struct io_priv *pio_priv = &adapter->iopriv;
-	struct	intf_hdl		*pintfhdl = &(pio_priv->intf);
+	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
 	int (*_write8)(struct intf_hdl *pintfhdl, u32 addr, u8 val);
 	int ret;
 
@@ -94,7 +94,7 @@ int _rtw_write8(struct adapter *adapter, u32 addr, u8 val)
 int _rtw_write16(struct adapter *adapter, u32 addr, u16 val)
 {
 	struct io_priv *pio_priv = &adapter->iopriv;
-	struct	intf_hdl		*pintfhdl = &(pio_priv->intf);
+	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
 	int (*_write16)(struct intf_hdl *pintfhdl, u32 addr, u16 val);
 	int ret;
 
@@ -108,7 +108,7 @@ int _rtw_write16(struct adapter *adapter, u32 addr, u16 val)
 int _rtw_write32(struct adapter *adapter, u32 addr, u32 val)
 {
 	struct io_priv *pio_priv = &adapter->iopriv;
-	struct	intf_hdl		*pintfhdl = &(pio_priv->intf);
+	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
 	int (*_write32)(struct intf_hdl *pintfhdl, u32 addr, u32 val);
 	int ret;
 
@@ -123,7 +123,7 @@ int _rtw_write32(struct adapter *adapter, u32 addr, u32 val)
 int _rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *pdata)
 {
 	struct io_priv *pio_priv = &adapter->iopriv;
-	struct	intf_hdl *pintfhdl = (struct intf_hdl *)(&(pio_priv->intf));
+	struct	intf_hdl *pintfhdl = (struct intf_hdl *)(&pio_priv->intf);
 	int (*_writeN)(struct intf_hdl *pintfhdl, u32 addr, u32 length, u8 *pdata);
 	int ret;
 
@@ -137,7 +137,7 @@ int _rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *pdata)
 int _rtw_write8_async(struct adapter *adapter, u32 addr, u8 val)
 {
 	struct io_priv *pio_priv = &adapter->iopriv;
-	struct	intf_hdl		*pintfhdl = &(pio_priv->intf);
+	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
 	int (*_write8_async)(struct intf_hdl *pintfhdl, u32 addr, u8 val);
 	int ret;
 
@@ -152,7 +152,7 @@ int _rtw_write8_async(struct adapter *adapter, u32 addr, u8 val)
 int _rtw_write16_async(struct adapter *adapter, u32 addr, u16 val)
 {
 	struct io_priv *pio_priv = &adapter->iopriv;
-	struct	intf_hdl		*pintfhdl = &(pio_priv->intf);
+	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
 	int (*_write16_async)(struct intf_hdl *pintfhdl, u32 addr, u16 val);
 	int ret;
 
@@ -165,7 +165,7 @@ int _rtw_write16_async(struct adapter *adapter, u32 addr, u16 val)
 int _rtw_write32_async(struct adapter *adapter, u32 addr, u32 val)
 {
 	struct io_priv *pio_priv = &adapter->iopriv;
-	struct	intf_hdl		*pintfhdl = &(pio_priv->intf);
+	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
 	int (*_write32_async)(struct intf_hdl *pintfhdl, u32 addr, u32 val);
 	int ret;
 
@@ -179,7 +179,7 @@ void _rtw_read_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem)
 {
 	void (*_read_mem)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pmem);
 	struct io_priv *pio_priv = &adapter->iopriv;
-	struct	intf_hdl		*pintfhdl = &(pio_priv->intf);
+	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
 
 
 	if (adapter->bDriverStopped || adapter->bSurpriseRemoved)
@@ -193,7 +193,7 @@ void _rtw_write_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem)
 {
 	void (*_write_mem)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pmem);
 	struct io_priv *pio_priv = &adapter->iopriv;
-	struct	intf_hdl		*pintfhdl = &(pio_priv->intf);
+	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
 
 
 
@@ -208,7 +208,7 @@ void _rtw_read_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem)
 {
 	u32 (*_read_port)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pmem);
 	struct io_priv *pio_priv = &adapter->iopriv;
-	struct	intf_hdl		*pintfhdl = &(pio_priv->intf);
+	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
 
 
 
@@ -226,7 +226,7 @@ void _rtw_read_port_cancel(struct adapter *adapter)
 {
 	void (*_read_port_cancel)(struct intf_hdl *pintfhdl);
 	struct io_priv *pio_priv = &adapter->iopriv;
-	struct intf_hdl *pintfhdl = &(pio_priv->intf);
+	struct intf_hdl *pintfhdl = &pio_priv->intf;
 
 	_read_port_cancel = pintfhdl->io_ops._read_port_cancel;
 
@@ -238,7 +238,7 @@ u32 _rtw_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem)
 {
 	u32 (*_write_port)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pmem);
 	struct io_priv *pio_priv = &adapter->iopriv;
-	struct	intf_hdl		*pintfhdl = &(pio_priv->intf);
+	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
 	u32 ret = _SUCCESS;
 
 
@@ -273,7 +273,7 @@ void _rtw_write_port_cancel(struct adapter *adapter)
 {
 	void (*_write_port_cancel)(struct intf_hdl *pintfhdl);
 	struct io_priv *pio_priv = &adapter->iopriv;
-	struct intf_hdl *pintfhdl = &(pio_priv->intf);
+	struct intf_hdl *pintfhdl = &pio_priv->intf;
 
 	_write_port_cancel = pintfhdl->io_ops._write_port_cancel;
 
-- 
2.32.0

