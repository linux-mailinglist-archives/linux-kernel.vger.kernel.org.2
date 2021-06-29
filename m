Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6A13B751F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 17:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbhF2P1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 11:27:49 -0400
Received: from atlmailgw1.ami.com ([63.147.10.40]:51399 "EHLO
        atlmailgw1.ami.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbhF2P1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 11:27:48 -0400
X-AuditID: ac1060b2-3d7ff70000000c56-e9-60db37d80924
Received: from atlms1.us.megatrends.com (atlms1.us.megatrends.com [172.16.96.144])
        (using TLS with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by atlmailgw1.ami.com (Symantec Messaging Gateway) with SMTP id EC.16.03158.8D73BD06; Tue, 29 Jun 2021 11:10:16 -0400 (EDT)
Received: from ami-us-wk.us.megatrends.com (172.16.98.207) by
 atlms1.us.megatrends.com (172.16.96.144) with Microsoft SMTP Server (TLS) id
 14.3.498.0; Tue, 29 Jun 2021 11:10:16 -0400
From:   Hongwei Zhang <hongweiz@ami.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>
CC:     Hongwei Zhang <hongweiz@ami.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/1] mtd: spi-nor: Add some M45PEx ids
Date:   Tue, 29 Jun 2021 11:08:46 -0400
Message-ID: <20210629150846.21547-2-hongweiz@ami.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210629150846.21547-1-hongweiz@ami.com>
References: <20210629150846.21547-1-hongweiz@ami.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.98.207]
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsWyRiBhgu4N89sJBmveG1lc3jWHzWJ30zJ2
        i7enN7Bb3H3+g93i4xIHB1aPzUvqPe78WMrocfzGdiaPz5vkPA7sbWELYI3isklJzcksSy3S
        t0vgyji99CxzQSNnxaNV69kaGJvZuxg5OSQETCR+/upk6WLk4hAS2MUk8ePpUjaQBJDDKPFi
        iheIzSagJrF38xwmEFtEoERiTfsXMJtZIF3i1dfzzCC2sIClxMSNL1m7GDk4WARUJX71CIGE
        eQVMJR692cICsUteYvWGA2DlnAJmEnunP2KBWGUq8WxNDxtEvaDEyZlPWCDGS0gcfPGCGaJG
        VuLWocdMEHMUJR78+s46gVFgFpKWWUhaFjAyrWIUSizJyU3MzEkvN9RLzM3US87P3cQICdZN
        OxhbLpofYmTiYDzEKMHBrCTC+zbvVoIQb0piZVVqUX58UWlOavEhRmkOFiVx3lXuR+OFBNIT
        S1KzU1MLUotgskwcnFINjKtCcpbdvs7z9JGzcF7pHIc/i+Zk/7h+NMdt2eqiP7+v14vqvzXL
        K/HbKtXpGNIe1yJjaPfib+IT9Tw+xZdKzxwC1FmjVpXz7SoKvWqwwWnntvZ1biW3fshryS/u
        1tK+ylnZyRv1MtEvP1bl176aop07lF96reEQ49K8d2Ri4aIfgpoeHNxaSizFGYmGWsxFxYkA
        mtAyL0QCAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some Micron M45PEx flash memeories into the IDs table.

Fixes: dd1e9367157f900616f (ARM: dts: everest: Add phase corrections for
eMMC)

Signed-off-by: Hongwei Zhang <hongweiz@ami.com>
---
 drivers/mtd/spi-nor/micron-st.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index ef3695080710..379b14e339ff 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -95,8 +95,12 @@ static const struct flash_info st_parts[] = {
 	{ "m25p128-nonjedec", INFO(0, 0, 256 * 1024,  64, 0) },
 
 	{ "m45pe10", INFO(0x204011,  0, 64 * 1024,    2, 0) },
+	{ "m45pe20", INFO(0x204012,  0, 64 * 1024,    4, 0) },
+	{ "m45pe40", INFO(0x204013,  0, 64 * 1024,    8, 0) },
 	{ "m45pe80", INFO(0x204014,  0, 64 * 1024,   16, 0) },
 	{ "m45pe16", INFO(0x204015,  0, 64 * 1024,   32, 0) },
+	{ "m45pe32", INFO(0x204016,  0, 64 * 1024,   64, 0) },
+	{ "m45pe64", INFO(0x204017,  0, 64 * 1024,  128, 0) },
 
 	{ "m25pe20", INFO(0x208012,  0, 64 * 1024,  4,       0) },
 	{ "m25pe80", INFO(0x208014,  0, 64 * 1024, 16,       0) },
-- 
2.17.1

