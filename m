Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC2843C649
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 11:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240035AbhJ0JRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 05:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239238AbhJ0JRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 05:17:01 -0400
Received: from mx.msync.work (mx.msync.work [IPv6:2a01:4f9:2b:2dc2::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D065C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 02:14:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4AB0E17A1C2;
        Wed, 27 Oct 2021 09:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1635326072; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=jofw1FCj78Oscyhe6UWSuazXAC2R/ddQ0f2yw/Kz2T0=;
        b=Nn4kF7xteVBWcmNSsIlBM1imDYwTV21+MSCDnidfEj3xamjgq0YE8+5fDpNt/KvopIryTg
        aF7J714a8AtQCh6i4/WTr0n/S82MKYuTtPiuN7gUqd4oC0pofRmifMMArryv+ykMLsU9eg
        fIVyygprDtZDg49gj+rtdq1wYks320e+v4mimuo/aLslo8cWN/yK9xZg6ODHJr7Zt2URuJ
        798AUB83F07yMge8UcfLo7wAz6TgijFf4XkcrZQXtt335EZx7UZBdriWUC8+4ed2GnKn9U
        8NGyalZvWNeVfpTuMtxJ6ZXf41SCgwV/KDNW0I/nySnKJV54gCPMXelXmTgL3w==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] Bluetooth: btrtl: Add support for RTL8822C hci_ver 0x08
Date:   Wed, 27 Oct 2021 12:14:15 +0300
Message-Id: <20211027091416.1577668-2-adeep@lexina.in>
In-Reply-To: <20211027091416.1577668-1-adeep@lexina.in>
References: <20211027091416.1577668-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add detection of RTL8822CS controller with hci_ver = 0x08

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 drivers/bluetooth/btrtl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index c2bdd1e6060e..38d547cc6fcd 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -156,6 +156,13 @@ static const struct id_table ic_id_table[] = {
 	  .fw_name  = "rtl_bt/rtl8822cs_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8822cs_config" },
 
+	/* 8822C with UART interface */
+	{ IC_INFO(RTL_ROM_LMP_8822B, 0xc, 0x8, HCI_UART),
+	  .config_needed = true,
+	  .has_rom_version = true,
+	  .fw_name  = "rtl_bt/rtl8822cs_fw.bin",
+	  .cfg_name = "rtl_bt/rtl8822cs_config" },
+
 	/* 8822C with USB interface */
 	{ IC_INFO(RTL_ROM_LMP_8822B, 0xc, 0xa, HCI_USB),
 	  .config_needed = false,
-- 
2.30.2

