Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F4B3B9E71
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 11:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhGBJl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 05:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbhGBJlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 05:41:21 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E731C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 02:38:49 -0700 (PDT)
Received: from mwalle01.fritz.box (ip4d17858c.dynamic.kabel-deutschland.de [77.23.133.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 54B1822249;
        Fri,  2 Jul 2021 11:38:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1625218727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BgGFzoe/HAoDDHuJaUL6REa6//gf/BtKSwE8c/6Kq/Q=;
        b=bjoxUW9Ns8ZMyl9hbo0Z2kkkCOSIR4uAI+h1Kv2HZmm1sf2WT185CQuTeK1sGJ9AtDNlBa
        Fu/AWNLuHVzGiQdCb8ZXQDcMB3SRvN7cqTP9951iDsg+DVBW33lg9v3CZbp3uvxo1Y9o9V
        Dx4NCswCEDXTYuScDWe2bVwbLVBpKnU=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] mtd: core: handle flashes without OTP gracefully
Date:   Fri,  2 Jul 2021 11:38:41 +0200
Message-Id: <20210702093841.32307-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are flash drivers which registers the OTP callbacks although the
flash doesn't support OTP regions and return -ENODATA for these
callbacks if there is no OTP. If this happens, the probe of the whole
flash will fail. Fix it by handling the ENODATA return code and skip
the OTP region nvmem setup.

Fixes: 4b361cfa8624 ("mtd: core: add OTP nvmem provider support")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/mtdcore.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index b5ccd3037788..6881d1423dd6 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -880,7 +880,10 @@ static int mtd_otp_nvmem_add(struct mtd_info *mtd)
 
 	if (mtd->_get_user_prot_info && mtd->_read_user_prot_reg) {
 		size = mtd_otp_size(mtd, true);
-		if (size < 0)
+		/* ENODATA means there is no OTP region */
+		if (size == -ENODATA)
+			size = 0;
+		else if (size < 0)
 			return size;
 
 		if (size > 0) {
@@ -896,7 +899,10 @@ static int mtd_otp_nvmem_add(struct mtd_info *mtd)
 
 	if (mtd->_get_fact_prot_info && mtd->_read_fact_prot_reg) {
 		size = mtd_otp_size(mtd, false);
-		if (size < 0) {
+		/* ENODATA means there is no OTP region */
+		if (size == -ENODATA) {
+			size = 0;
+		} else if (size < 0) {
 			err = size;
 			goto err;
 		}
-- 
2.20.1

