Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A033A40FF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 13:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhFKLPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 07:15:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231438AbhFKLPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 07:15:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 193696109E;
        Fri, 11 Jun 2021 11:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623409994;
        bh=/k+3lM8FCcwSaHqv2P5+2MbpRxWaZc7shGXGvJaDrsA=;
        h=From:To:Cc:Subject:Date:From;
        b=HFhsn+A7kFQbIfcP3v6qfhd3ZDPQnEi7Fazrn4TL9YmzmvSxpt9e3PumbXrCumIQG
         QtAFfkxG7OScdQjUYrrrFH7GeYANTcPv16FKeK0DjCvF2nHEC36xWZnTuYitiuloH1
         8P523IVy2oPas+6E7PlrYvVbC49YWvMdCGvnRpNBzd1LBeRcjMkoJ1dQWhkCp1pMdX
         Vmindf69LDAFEMllkklpaB4dptWCq+Gs0M5l/295UGCCdBSJGyReGbiqKBYvw/SB/+
         DcQBdZPEfwapuxw/APCBNaapadjVEO2Cf8hSYb/UoLWnngecztBQL0xn0GLEhD6n3A
         MhM720W7m3q9Q==
From:   matthias.bgg@kernel.org
To:     james.lo@mediatek.com
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH] soc: mediatek: pwarp: delete confusing comments
Date:   Fri, 11 Jun 2021 13:13:07 +0200
Message-Id: <20210611111307.29038-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>

Comments sugguest that MT8195 arb_en_all and int_en_all values need to
be confirmed. But actually these values are correct.

Suggested-by: James Lo <james.lo@mediatek.com>
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

---

 drivers/soc/mediatek/mtk-pmic-wrap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 952bc554f443..118eb4acdeb6 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -2047,8 +2047,8 @@ static const struct pmic_wrapper_type pwrap_mt8183 = {
 static struct pmic_wrapper_type pwrap_mt8195 = {
 	.regs = mt8195_regs,
 	.type = PWRAP_MT8195,
-	.arb_en_all = 0x777f, /* NEED CONFIRM */
-	.int_en_all = 0x180000, /* NEED CONFIRM */
+	.arb_en_all = 0x777f,
+	.int_en_all = 0x180000,
 	.int1_en_all = 0,
 	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
 	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
-- 
2.31.1

