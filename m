Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3669C3E4A4C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 18:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbhHIQv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 12:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbhHIQvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 12:51:21 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90155C061799
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 09:50:58 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l18so22346327wrv.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 09:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NyiIplakq4MSvNabcXva5WLk0bCoGGYQJOMtAI5jTQE=;
        b=Tq1l00RmDef4Wx3z1rbBvWxxMsQV403ptPKldnurrHM6BhvPloLHSPvSrv7MbNTYZ3
         Tzg3i4V9PsAP27mmIt84sH5+QrFWnz93xB3ZCWF91cBUXC9396nB3fxpPiZfI3bYehD1
         PpHNWDaQnMQTER1D483kB8Ab3qxVk0lhr937dqgW3NTrge+1Cge7ZRZXVRJVj5iQ3LxL
         JHLVoMFyTEeMDBQcVuX3s1ApEREHAnck3RHhM/b6jyqsa0EtauNjpbpR9x5sbxteAfAj
         SXmM8xtJWR16jl1G1u2OyB4QPnGrNRfw/u60tMFJF5F/h+EAKGQtxGchy31NNmoWDEP4
         zbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NyiIplakq4MSvNabcXva5WLk0bCoGGYQJOMtAI5jTQE=;
        b=MJEdW1cjCE4P5mLXL1u8fZpyR2bfq0B4y+YgzzcUouVZTRFzUDOQ0aI056Hned6qjf
         ht0lnE+X1okCkZo17AjcLA/oYrP9F3ttcPN6phr4b0Wrcj8t2E/1Eu0mDjEzROIXcTq8
         w0w0sQztzopKNb8FSirnMbfqgi93URDT6do4jrlQ8PJkrWxxVfxoB0QHeKfd9zc77W0P
         VCgHPumg0AwFWKbjNdtJQOmt9WH1/Pn4+2oAVlSSANLD55hud47uYh2fHTrpLhyp4G60
         hUp7rxvimk1s0vvKlsWAFnUdtLldmGSi+CdPKGs4qaimgQPdkrIvpv/6sTRgYZAOTT/4
         ZkUw==
X-Gm-Message-State: AOAM532J4+R9DO53mepDtK+9md62Whk6dJGiFk95Aw3UBIz096dix9UM
        7WTA8n44QT/dZ2JyYrHTLA0=
X-Google-Smtp-Source: ABdhPJzgMLD9vkTkpg1UPo9afHNG10+QVQnJB8aUu8FPOctt/5CW9AIcfUcZ1XOtPFCq4YPBIL0fuA==
X-Received: by 2002:adf:f141:: with SMTP id y1mr12016551wro.173.1628527857282;
        Mon, 09 Aug 2021 09:50:57 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::996b])
        by smtp.gmail.com with ESMTPSA id q5sm20484469wrx.33.2021.08.09.09.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 09:50:57 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 14/17] staging: r8188eu: remove unnecessary parentheses in core/rtw_io.c
Date:   Mon,  9 Aug 2021 18:50:04 +0200
Message-Id: <20210809165007.23204-15-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210809165007.23204-1-straube.linux@gmail.com>
References: <20210809165007.23204-1-straube.linux@gmail.com>
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

