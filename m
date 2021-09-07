Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8AE4025B1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 10:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244582AbhIGIyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 04:54:35 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:34044
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244491AbhIGIyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 04:54:09 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id B740E401A4;
        Tue,  7 Sep 2021 08:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631004782;
        bh=YVKAThawjAoSDAeEprgD3mnzbZ4u6HBoKcAGGqllCTg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=vy/d+zBgJhFy7aAhGvUjxjvSZX2mG6upP8DqcXWF9gjt+tB4C+5NRQ6CcVTD8tjSP
         ltTiS85VA3fDkA++3KjoSpNtcc3FtkDHrrzZoWbyob6ZRa9Dok8jAjTD5vx8tcM3iK
         HVzBiMJ5yZGMc29IXK6P73gWa3O6Up6lixj1a30a+igyrhuUHmzXKDK22lDDSnzQtc
         xj/r2axzt4i5UzSz4Dg3vQVyFeOq8yw6wxIFTzUZhbOkZTE71n5LcDT1mCKou7d684
         eaDZ4G9tsynoc7UPcwvCjaNNi1oD2BYlSLBL9BkgghnfwSx5SaSPEZj14kGVC7uC+8
         xRSxts0wmx5TA==
From:   Colin King <colin.king@canonical.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: remove redundant variable hoffset
Date:   Tue,  7 Sep 2021 09:53:02 +0100
Message-Id: <20210907085302.10672-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable hoffset is being assigned values but it is never being
used. The variable is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 14758361960c..7c12ca548c47 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1143,7 +1143,7 @@ static u16 hal_EfuseGetCurrentSize_8188e(struct adapter *pAdapter, bool bPseudoT
 {
 	int	bContinual = true;
 	u16	efuse_addr = 0;
-	u8 hoffset = 0, hworden = 0;
+	u8 hworden = 0;
 	u8 efuse_data, word_cnts = 0;
 
 	if (bPseudoTest)
@@ -1156,18 +1156,15 @@ static u16 hal_EfuseGetCurrentSize_8188e(struct adapter *pAdapter, bool bPseudoT
 	       AVAILABLE_EFUSE_ADDR(efuse_addr)) {
 		if (efuse_data != 0xFF) {
 			if ((efuse_data & 0x1F) == 0x0F) {		/* extended header */
-				hoffset = efuse_data;
 				efuse_addr++;
 				efuse_OneByteRead(pAdapter, efuse_addr, &efuse_data, bPseudoTest);
 				if ((efuse_data & 0x0F) == 0x0F) {
 					efuse_addr++;
 					continue;
 				} else {
-					hoffset = ((hoffset & 0xE0) >> 5) | ((efuse_data & 0xF0) >> 1);
 					hworden = efuse_data & 0x0F;
 				}
 			} else {
-				hoffset = (efuse_data >> 4) & 0x0F;
 				hworden =  efuse_data & 0x0F;
 			}
 			word_cnts = Efuse_CalculateWordCnts(hworden);
-- 
2.32.0

