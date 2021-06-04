Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C7C39BB0D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 16:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFDOoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 10:44:38 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:41784 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhFDOog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 10:44:36 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 154EgOG21019151, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 154EgOG21019151
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 4 Jun 2021 22:42:24 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 4 Jun 2021 22:42:23 +0800
Received: from localhost (172.22.88.222) by RTEXMBS01.realtek.com.tw
 (172.21.6.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 4 Jun 2021
 22:42:23 +0800
From:   <ricky_wu@realtek.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <bhelgaas@google.com>, <rui_feng@realsil.com.cn>,
        <ulf.hansson@linaro.org>, <vaibhavgupta40@gmail.com>,
        <yang.lee@linux.alibaba.com>,
        <keitasuzuki.park@sslab.ics.keio.ac.jp>,
        <chris.chiu@canonical.com>, <linux-kernel@vger.kernel.org>
CC:     Ricky Wu <ricky_wu@realtek.com>
Subject: [PATCH] misc: rtsx: separate aspm mode into MODE_REG and MODE_CFG
Date:   Fri, 4 Jun 2021 22:42:11 +0800
Message-ID: <20210604144211.6470-1-ricky_wu@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.22.88.222]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS01.realtek.com.tw (172.21.6.94)
X-KSE-ServerInfo: RTEXMBS01.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/04/2021 14:25:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzYvNCCkVaTIIDAyOjAwOjAw?=
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/04/2021 14:23:27
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 164130 [Jun 04 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: ricky_wu@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 448 448 71fb1b37213ce9a885768d4012c46ac449c77b17
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/04/2021 14:25:00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ricky Wu <ricky_wu@realtek.com>

Divide Realtek Card Reader Group into two different modes
ASPM_MODE_CFG: 8411 5209 5227 5229 5249 5250
Change back to use original way to control aspm
ASPM_MODE_REG: 5227A 524A 5250A 5260 5261 5228
Keep the new way to control aspm

Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
---
 drivers/misc/cardreader/rtl8411.c  |  1 +
 drivers/misc/cardreader/rts5209.c  |  1 +
 drivers/misc/cardreader/rts5227.c  |  2 ++
 drivers/misc/cardreader/rts5228.c  |  1 +
 drivers/misc/cardreader/rts5229.c  |  1 +
 drivers/misc/cardreader/rts5249.c  |  3 ++
 drivers/misc/cardreader/rts5260.c  |  1 +
 drivers/misc/cardreader/rts5261.c  |  1 +
 drivers/misc/cardreader/rtsx_pcr.c | 44 +++++++++++++++++++++---------
 include/linux/rtsx_pci.h           |  3 ++
 10 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/cardreader/rtl8411.c b/drivers/misc/cardreader/rtl8411.c
index a07674ed0596..4c5621b17a6f 100644
--- a/drivers/misc/cardreader/rtl8411.c
+++ b/drivers/misc/cardreader/rtl8411.c
@@ -468,6 +468,7 @@ static void rtl8411_init_common_params(struct rtsx_pcr *pcr)
 	pcr->sd30_drive_sel_1v8 = DRIVER_TYPE_B;
 	pcr->sd30_drive_sel_3v3 = DRIVER_TYPE_D;
 	pcr->aspm_en = ASPM_L1_EN;
+	pcr->aspm_mode = ASPM_MODE_CFG;
 	pcr->tx_initial_phase = SET_CLOCK_PHASE(23, 7, 14);
 	pcr->rx_initial_phase = SET_CLOCK_PHASE(4, 3, 10);
 	pcr->ic_version = rtl8411_get_ic_version(pcr);
diff --git a/drivers/misc/cardreader/rts5209.c b/drivers/misc/cardreader/rts5209.c
index 39a6a7ecc32e..29f5414072bf 100644
--- a/drivers/misc/cardreader/rts5209.c
+++ b/drivers/misc/cardreader/rts5209.c
@@ -255,6 +255,7 @@ void rts5209_init_params(struct rtsx_pcr *pcr)
 	pcr->sd30_drive_sel_1v8 = DRIVER_TYPE_B;
 	pcr->sd30_drive_sel_3v3 = DRIVER_TYPE_D;
 	pcr->aspm_en = ASPM_L1_EN;
+	pcr->aspm_mode = ASPM_MODE_CFG;
 	pcr->tx_initial_phase = SET_CLOCK_PHASE(27, 27, 16);
 	pcr->rx_initial_phase = SET_CLOCK_PHASE(24, 6, 5);
 
diff --git a/drivers/misc/cardreader/rts5227.c b/drivers/misc/cardreader/rts5227.c
index 8200af22b529..4bcfbc9afbac 100644
--- a/drivers/misc/cardreader/rts5227.c
+++ b/drivers/misc/cardreader/rts5227.c
@@ -358,6 +358,7 @@ void rts5227_init_params(struct rtsx_pcr *pcr)
 	pcr->sd30_drive_sel_1v8 = CFG_DRIVER_TYPE_B;
 	pcr->sd30_drive_sel_3v3 = CFG_DRIVER_TYPE_B;
 	pcr->aspm_en = ASPM_L1_EN;
+	pcr->aspm_mode = ASPM_MODE_CFG;
 	pcr->tx_initial_phase = SET_CLOCK_PHASE(27, 27, 15);
 	pcr->rx_initial_phase = SET_CLOCK_PHASE(30, 7, 7);
 
@@ -483,6 +484,7 @@ void rts522a_init_params(struct rtsx_pcr *pcr)
 
 	rts5227_init_params(pcr);
 	pcr->ops = &rts522a_pcr_ops;
+	pcr->aspm_mode = ASPM_MODE_REG;
 	pcr->tx_initial_phase = SET_CLOCK_PHASE(20, 20, 11);
 	pcr->reg_pm_ctrl3 = RTS522A_PM_CTRL3;
 
diff --git a/drivers/misc/cardreader/rts5228.c b/drivers/misc/cardreader/rts5228.c
index 781a86def59a..ffc128278613 100644
--- a/drivers/misc/cardreader/rts5228.c
+++ b/drivers/misc/cardreader/rts5228.c
@@ -718,6 +718,7 @@ void rts5228_init_params(struct rtsx_pcr *pcr)
 	pcr->sd30_drive_sel_1v8 = CFG_DRIVER_TYPE_B;
 	pcr->sd30_drive_sel_3v3 = CFG_DRIVER_TYPE_B;
 	pcr->aspm_en = ASPM_L1_EN;
+	pcr->aspm_mode = ASPM_MODE_REG;
 	pcr->tx_initial_phase = SET_CLOCK_PHASE(28, 27, 11);
 	pcr->rx_initial_phase = SET_CLOCK_PHASE(24, 6, 5);
 
diff --git a/drivers/misc/cardreader/rts5229.c b/drivers/misc/cardreader/rts5229.c
index 89e6f124ca5c..c748eaf1ec1f 100644
--- a/drivers/misc/cardreader/rts5229.c
+++ b/drivers/misc/cardreader/rts5229.c
@@ -246,6 +246,7 @@ void rts5229_init_params(struct rtsx_pcr *pcr)
 	pcr->sd30_drive_sel_1v8 = DRIVER_TYPE_B;
 	pcr->sd30_drive_sel_3v3 = DRIVER_TYPE_D;
 	pcr->aspm_en = ASPM_L1_EN;
+	pcr->aspm_mode = ASPM_MODE_CFG;
 	pcr->tx_initial_phase = SET_CLOCK_PHASE(27, 27, 15);
 	pcr->rx_initial_phase = SET_CLOCK_PHASE(30, 6, 6);
 
diff --git a/drivers/misc/cardreader/rts5249.c b/drivers/misc/cardreader/rts5249.c
index b2676e7f5027..53f3a1f45c4a 100644
--- a/drivers/misc/cardreader/rts5249.c
+++ b/drivers/misc/cardreader/rts5249.c
@@ -566,6 +566,7 @@ void rts5249_init_params(struct rtsx_pcr *pcr)
 	pcr->sd30_drive_sel_1v8 = CFG_DRIVER_TYPE_B;
 	pcr->sd30_drive_sel_3v3 = CFG_DRIVER_TYPE_B;
 	pcr->aspm_en = ASPM_L1_EN;
+	pcr->aspm_mode = ASPM_MODE_CFG;
 	pcr->tx_initial_phase = SET_CLOCK_PHASE(1, 29, 16);
 	pcr->rx_initial_phase = SET_CLOCK_PHASE(24, 6, 5);
 
@@ -729,6 +730,7 @@ static const struct pcr_ops rts524a_pcr_ops = {
 void rts524a_init_params(struct rtsx_pcr *pcr)
 {
 	rts5249_init_params(pcr);
+	pcr->aspm_mode = ASPM_MODE_REG;
 	pcr->tx_initial_phase = SET_CLOCK_PHASE(27, 29, 11);
 	pcr->option.ltr_l1off_sspwrgate = LTR_L1OFF_SSPWRGATE_5250_DEF;
 	pcr->option.ltr_l1off_snooze_sspwrgate =
@@ -845,6 +847,7 @@ static const struct pcr_ops rts525a_pcr_ops = {
 void rts525a_init_params(struct rtsx_pcr *pcr)
 {
 	rts5249_init_params(pcr);
+	pcr->aspm_mode = ASPM_MODE_REG;
 	pcr->tx_initial_phase = SET_CLOCK_PHASE(25, 29, 11);
 	pcr->option.ltr_l1off_sspwrgate = LTR_L1OFF_SSPWRGATE_5250_DEF;
 	pcr->option.ltr_l1off_snooze_sspwrgate =
diff --git a/drivers/misc/cardreader/rts5260.c b/drivers/misc/cardreader/rts5260.c
index 080a7d67a8e1..9b42b20a3e5a 100644
--- a/drivers/misc/cardreader/rts5260.c
+++ b/drivers/misc/cardreader/rts5260.c
@@ -628,6 +628,7 @@ void rts5260_init_params(struct rtsx_pcr *pcr)
 	pcr->sd30_drive_sel_1v8 = CFG_DRIVER_TYPE_B;
 	pcr->sd30_drive_sel_3v3 = CFG_DRIVER_TYPE_B;
 	pcr->aspm_en = ASPM_L1_EN;
+	pcr->aspm_mode = ASPM_MODE_REG;
 	pcr->tx_initial_phase = SET_CLOCK_PHASE(27, 29, 11);
 	pcr->rx_initial_phase = SET_CLOCK_PHASE(24, 6, 5);
 
diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index 6c64dade8e1a..1fd4e0e50730 100644
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -783,6 +783,7 @@ void rts5261_init_params(struct rtsx_pcr *pcr)
 	pcr->sd30_drive_sel_1v8 = 0x00;
 	pcr->sd30_drive_sel_3v3 = 0x00;
 	pcr->aspm_en = ASPM_L1_EN;
+	pcr->aspm_mode = ASPM_MODE_REG;
 	pcr->tx_initial_phase = SET_CLOCK_PHASE(27, 27, 11);
 	pcr->rx_initial_phase = SET_CLOCK_PHASE(24, 6, 5);
 
diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index 273311184669..baf83594a01d 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -85,12 +85,18 @@ static void rtsx_comm_set_aspm(struct rtsx_pcr *pcr, bool enable)
 	if (pcr->aspm_enabled == enable)
 		return;
 
-	if (pcr->aspm_en & 0x02)
-		rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, FORCE_ASPM_CTL0 |
-			FORCE_ASPM_CTL1, enable ? 0 : FORCE_ASPM_CTL0 | FORCE_ASPM_CTL1);
-	else
-		rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, FORCE_ASPM_CTL0 |
-			FORCE_ASPM_CTL1, FORCE_ASPM_CTL0 | FORCE_ASPM_CTL1);
+	if (pcr->aspm_mode == ASPM_MODE_CFG) {
+		pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
+						PCI_EXP_LNKCTL_ASPMC,
+						enable ? pcr->aspm_en : 0);
+	} else if (pcr->aspm_mode == ASPM_MODE_REG) {
+		if (pcr->aspm_en & 0x02)
+			rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, FORCE_ASPM_CTL0 |
+				FORCE_ASPM_CTL1, enable ? 0 : FORCE_ASPM_CTL0 | FORCE_ASPM_CTL1);
+		else
+			rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, FORCE_ASPM_CTL0 |
+				FORCE_ASPM_CTL1, FORCE_ASPM_CTL0 | FORCE_ASPM_CTL1);
+	}
 
 	if (!enable && (pcr->aspm_en & 0x02))
 		mdelay(10);
@@ -1394,7 +1400,8 @@ static int rtsx_pci_init_hw(struct rtsx_pcr *pcr)
 			return err;
 	}
 
-	rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, 0x30, 0x30);
+	if (pcr->aspm_mode == ASPM_MODE_REG)
+		rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, 0x30, 0x30);
 
 	/* No CD interrupt if probing driver with card inserted.
 	 * So we need to initialize pcr->card_exist here.
@@ -1410,6 +1417,8 @@ static int rtsx_pci_init_hw(struct rtsx_pcr *pcr)
 static int rtsx_pci_init_chip(struct rtsx_pcr *pcr)
 {
 	int err;
+	u16 cfg_val;
+	u8 val;
 
 	spin_lock_init(&pcr->lock);
 	mutex_init(&pcr->pcr_mutex);
@@ -1477,6 +1486,21 @@ static int rtsx_pci_init_chip(struct rtsx_pcr *pcr)
 	if (!pcr->slots)
 		return -ENOMEM;
 
+	if (pcr->aspm_mode == ASPM_MODE_CFG) {
+		pcie_capability_read_word(pcr->pci, PCI_EXP_LNKCTL, &cfg_val);
+		if (cfg_val & PCI_EXP_LNKCTL_ASPM_L1)
+			pcr->aspm_enabled = true;
+		else
+			pcr->aspm_enabled = false;
+
+	} else if (pcr->aspm_mode == ASPM_MODE_REG) {
+		rtsx_pci_read_register(pcr, ASPM_FORCE_CTL, &val);
+		if (val & FORCE_ASPM_CTL0 && val & FORCE_ASPM_CTL1)
+			pcr->aspm_enabled = false;
+		else
+			pcr->aspm_enabled = true;
+	}
+
 	if (pcr->ops->fetch_vendor_settings)
 		pcr->ops->fetch_vendor_settings(pcr);
 
@@ -1506,7 +1530,6 @@ static int rtsx_pci_probe(struct pci_dev *pcidev,
 	struct pcr_handle *handle;
 	u32 base, len;
 	int ret, i, bar = 0;
-	u8 val;
 
 	dev_dbg(&(pcidev->dev),
 		": Realtek PCI-E Card Reader found at %s [%04x:%04x] (rev %x)\n",
@@ -1572,11 +1595,6 @@ static int rtsx_pci_probe(struct pci_dev *pcidev,
 	pcr->host_cmds_addr = pcr->rtsx_resv_buf_addr;
 	pcr->host_sg_tbl_ptr = pcr->rtsx_resv_buf + HOST_CMDS_BUF_LEN;
 	pcr->host_sg_tbl_addr = pcr->rtsx_resv_buf_addr + HOST_CMDS_BUF_LEN;
-	rtsx_pci_read_register(pcr, ASPM_FORCE_CTL, &val);
-	if (val & FORCE_ASPM_CTL0 && val & FORCE_ASPM_CTL1)
-		pcr->aspm_enabled = false;
-	else
-		pcr->aspm_enabled = true;
 	pcr->card_inserted = 0;
 	pcr->card_removed = 0;
 	INIT_DELAYED_WORK(&pcr->carddet_work, rtsx_pci_card_detect);
diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
index 6f155f99aa16..6c16837ee235 100644
--- a/include/linux/rtsx_pci.h
+++ b/include/linux/rtsx_pci.h
@@ -1234,6 +1234,9 @@ struct rtsx_pcr {
 	u8				card_drive_sel;
 #define ASPM_L1_EN			0x02
 	u8				aspm_en;
+#define ASPM_MODE_CFG		0x01
+#define ASPM_MODE_REG		0x02
+	u8				aspm_mode;
 	bool				aspm_enabled;
 
 #define PCR_MS_PMOS			(1 << 0)
-- 
2.17.1

