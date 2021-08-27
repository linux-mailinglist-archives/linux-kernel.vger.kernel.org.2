Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748523FA06F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 22:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbhH0UQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 16:16:31 -0400
Received: from mail-mw2nam12on2066.outbound.protection.outlook.com ([40.107.244.66]:21728
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231462AbhH0UQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 16:16:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSdH+1IVEIaTG0fh84uwOQAStVcddMKz9XL/8mJEUHGfTbeV3UW+Fj7NsLhnq5e5tY8Y5bqbs7F9ZhO7lT2j05mPVcXYWbyQWKPB5gdp/ZN9thPTbaHzjsirXtRKITNfM5laEocf1Sj20PEnyG3n5uzoiUZaoL1G7nPjRvOjBAP1Ch95uiRTl5FxpxNqXT+EFjR9miLpe31sNTc49CI+XwNT3tqvAFQHsDg+FfhQ6bM43qWzXOUPnpKEowlpNEhpxfwBzYn0k6KBPHVL3CL7pMaN9fzvDXt24mz9vRlaHEQ135jV3iVFF+rgNH5Lf5S9j7BHxpPjr4jRCaLYoi8X5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MmZxqMP+H3792MRYkj4eTOuKdnr1ZF+7u8jG3Kx+dk=;
 b=KGLl5rPTma6hTCzARCRLZxG290AgkPft3GtTs5WTbv/0ipuLjEUOPbzM1WTNXb6ENFmOvvyokkaA0p/Tc+z7It12A/WqcMqLnA66J12TXVW29DfDxPqZGkZMlKpm3NGdy0iTEara2RUUR/yTVajCb5J0dhHALLUqA180xvH8rcyxrVHsJnFc91WPhBsAZ2JbJRQ+y5Zicj9ub7jl0FlCZoRw+Gly0HKc1mTdJzrLQmYx72Dti7fVqRUC4fO5dYuRNpNDAMBZkV3NvmbpezxHs+yWgk1n+ikTwVg0IHecUI4RfCiNRwVyioyqdPtO2b0dmh1aHdpnPQtdtJtsyCMJSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ladisch.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MmZxqMP+H3792MRYkj4eTOuKdnr1ZF+7u8jG3Kx+dk=;
 b=QKxy1fZg9/3pFQMiE6trgeZOlvkqD0omryrILIjeepkdAbGSsmGWM+QH+EJzCZ1T7O1qs62OY+KizOLHGkuMwPmbCEeUM5uDjVsE0nK0Wlf6nS0BBgOm5/UgG7ZPnYQDOONW8r/LXKwONaNkeJDjbB3KdssHvGW1NAAK8lfi9NQ=
Received: from DM5PR08CA0042.namprd08.prod.outlook.com (2603:10b6:4:60::31) by
 DM6PR12MB4171.namprd12.prod.outlook.com (2603:10b6:5:21f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.20; Fri, 27 Aug 2021 20:15:38 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::ff) by DM5PR08CA0042.outlook.office365.com
 (2603:10b6:4:60::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend
 Transport; Fri, 27 Aug 2021 20:15:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; ladisch.de; dkim=none (message not signed)
 header.d=none;ladisch.de; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 20:15:38 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 27 Aug
 2021 15:15:35 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Clemens Ladisch <clemens@ladisch.de>
CC:     <linux-hwmon@vger.kernel.org>,
        Gabriel Craciunescu <nix.or.die@googlemail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wei Huang <wei.huang2@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Jean Delvare" <jdelvare@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/3] hwmon: (k10temp): Show errors failing to read
Date:   Fri, 27 Aug 2021 15:15:27 -0500
Message-ID: <20210827201527.24454-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210827201527.24454-1-mario.limonciello@amd.com>
References: <20210827201527.24454-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a10b91f0-3554-44e1-300a-08d969976ff8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4171:
X-Microsoft-Antispam-PRVS: <DM6PR12MB417119830BB293237468C278E2C89@DM6PR12MB4171.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iDIiZB0h5N0ZRHUkEcpeRk7/O4/xrfEOg8zykF9/RTLDVVhF2HjbfZ/ApzCIbIB7Rnt6OOCTFY0j7fIcIN3wAGXvNoGJ4OJZfjgLOD76x9yM1I+YVago1ISRxy8Ni8GLCSbqVkON+hpe5ntC1pkRMvbN2XvJuQURIYeUoU/b6t9LlfCnMbATNoc3Goz9lsQ5VL0ojmQEodpVXypetA0Y5bhhaf3J/bRWeCRIqi2PjrEJIltknqdeDeUKvZLLR+g4oBGVvza5lYDCrWBOoU6SuqfmuiS6SoNRpEKyYySbt3uP/h3JdSdKGa5+KvSMICsDPbNP0Roc1GtVbk3lAFm+x3gJVjI7LDv41szzNe8ZROu4TR8Y/tmFBsiAdhLQPh+Xv4QYRHiG5JRWKpraA9f+xk+SfeA+UNGJXWsHgdDdGYG/0P7RrtO2K1xm55JZkF+TfWo1Hp7YEfkQkxb0ZoqbfgC7UxqE0s2E7nus4lcJbS/lC9dU2u9OvtessKoG2u19+Y4Tb7fpxF7PNPKnNgM09e4jDx5AatRzPHJDfboVAbu4GFFq6sn0N1BPhiUYuzs8YdzF0OJuUi5rcdDWmSK+IvNuQUA6aXD9GIrkdG1KPZN7OEOciXaGSj6sYv5K1H1nWr83LH/xUXGG4rajd6UfCnIUm7nNP6XhLjGM8frJNAhdJ2GaSyz27DLa44I4S3MUceuvc6pP1DeYiVYs7cJ2cwFf0en550oaAtB+32wHBKY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(46966006)(36840700001)(1076003)(6666004)(356005)(8676002)(6916009)(8936002)(186003)(2906002)(16526019)(86362001)(83380400001)(7696005)(478600001)(70206006)(70586007)(81166007)(82740400003)(44832011)(316002)(36756003)(5660300002)(26005)(82310400003)(4326008)(426003)(336012)(36860700001)(2616005)(54906003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 20:15:38.8120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a10b91f0-3554-44e1-300a-08d969976ff8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4171
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling Yellow Carp was initially not working "properly"
because extra IDs were needed, but this wasn't obvious because fail values
from `amd_smn_read` were ignored.

Don't discard errors from any functions providing them, instead pass up
to the caller.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/hwmon/k10temp.c | 87 ++++++++++++++++++++++++-----------------
 1 file changed, 52 insertions(+), 35 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 38bc35ac8135..2edb49d39d22 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -98,8 +98,8 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
 
 struct k10temp_data {
 	struct pci_dev *pdev;
-	void (*read_htcreg)(struct pci_dev *pdev, u32 *regval);
-	void (*read_tempreg)(struct pci_dev *pdev, u32 *regval);
+	int (*read_htcreg)(struct pci_dev *pdev, u32 *regval);
+	int (*read_tempreg)(struct pci_dev *pdev, u32 *regval);
 	int temp_offset;
 	u32 temp_adjust_mask;
 	u32 show_temp;
@@ -129,55 +129,65 @@ static const struct tctl_offset tctl_offset_table[] = {
 	{ 0x17, "AMD Ryzen Threadripper 29", 27000 }, /* 29{20,50,70,90}[W]X */
 };
 
-static void read_htcreg_pci(struct pci_dev *pdev, u32 *regval)
+static int read_htcreg_pci(struct pci_dev *pdev, u32 *regval)
 {
-	pci_read_config_dword(pdev, REG_HARDWARE_THERMAL_CONTROL, regval);
+	return pci_read_config_dword(pdev, REG_HARDWARE_THERMAL_CONTROL, regval);
 }
 
-static void read_tempreg_pci(struct pci_dev *pdev, u32 *regval)
+static int read_tempreg_pci(struct pci_dev *pdev, u32 *regval)
 {
-	pci_read_config_dword(pdev, REG_REPORTED_TEMPERATURE, regval);
+	return pci_read_config_dword(pdev, REG_REPORTED_TEMPERATURE, regval);
 }
 
-static void amd_nb_index_read(struct pci_dev *pdev, unsigned int devfn,
+static int amd_nb_index_read(struct pci_dev *pdev, unsigned int devfn,
 			      unsigned int base, int offset, u32 *val)
 {
+	int ret;
+
 	mutex_lock(&nb_smu_ind_mutex);
-	pci_bus_write_config_dword(pdev->bus, devfn,
-				   base, offset);
-	pci_bus_read_config_dword(pdev->bus, devfn,
-				  base + 4, val);
+	ret = pci_bus_write_config_dword(pdev->bus, devfn,
+					 base, offset);
+	if (ret)
+		goto out;
+	ret = pci_bus_read_config_dword(pdev->bus, devfn,
+					base + 4, val);
+out:
 	mutex_unlock(&nb_smu_ind_mutex);
+	return ret;
 }
 
-static void read_htcreg_nb_f15(struct pci_dev *pdev, u32 *regval)
+static int read_htcreg_nb_f15(struct pci_dev *pdev, u32 *regval)
 {
-	amd_nb_index_read(pdev, PCI_DEVFN(0, 0), 0xb8,
-			  F15H_M60H_HARDWARE_TEMP_CTRL_OFFSET, regval);
+	return amd_nb_index_read(pdev, PCI_DEVFN(0, 0), 0xb8,
+				F15H_M60H_HARDWARE_TEMP_CTRL_OFFSET, regval);
 }
 
-static void read_tempreg_nb_f15(struct pci_dev *pdev, u32 *regval)
+static int read_tempreg_nb_f15(struct pci_dev *pdev, u32 *regval)
 {
-	amd_nb_index_read(pdev, PCI_DEVFN(0, 0), 0xb8,
-			  F15H_M60H_REPORTED_TEMP_CTRL_OFFSET, regval);
+	return amd_nb_index_read(pdev, PCI_DEVFN(0, 0), 0xb8,
+				F15H_M60H_REPORTED_TEMP_CTRL_OFFSET, regval);
 }
 
-static void read_tempreg_nb_zen(struct pci_dev *pdev, u32 *regval)
+static int read_tempreg_nb_zen(struct pci_dev *pdev, u32 *regval)
 {
-	amd_smn_read(amd_pci_dev_to_node_id(pdev),
-		     ZEN_REPORTED_TEMP_CTRL_BASE, regval);
+	return amd_smn_read(amd_pci_dev_to_node_id(pdev),
+			    ZEN_REPORTED_TEMP_CTRL_BASE, regval);
 }
 
-static long get_raw_temp(struct k10temp_data *data)
+static int get_raw_temp(struct k10temp_data *data, long *val)
 {
 	u32 regval;
-	long temp;
+	int ret;
 
-	data->read_tempreg(data->pdev, &regval);
-	temp = (regval >> ZEN_CUR_TEMP_SHIFT) * 125;
+	ret = data->read_tempreg(data->pdev, &regval);
+	if (ret)
+		return ret;
+	*val = (regval >> ZEN_CUR_TEMP_SHIFT) * 125;
 	if (regval & data->temp_adjust_mask)
-		temp -= 49000;
-	return temp;
+		*val -= 49000;
+	if (*val < 0)
+		return -EINVAL;
+	return 0;
 }
 
 static const char *k10temp_temp_label[] = {
@@ -212,24 +222,27 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
 {
 	struct k10temp_data *data = dev_get_drvdata(dev);
 	u32 regval;
+	int ret;
 
 	switch (attr) {
 	case hwmon_temp_input:
 		switch (channel) {
 		case 0:		/* Tctl */
-			*val = get_raw_temp(data);
-			if (*val < 0)
-				*val = 0;
+			ret = get_raw_temp(data, val);
+			if (ret)
+				return ret;
 			break;
 		case 1:		/* Tdie */
-			*val = get_raw_temp(data) - data->temp_offset;
-			if (*val < 0)
-				*val = 0;
+			ret = get_raw_temp(data, val) - data->temp_offset;
+			if (ret)
+				return ret;
 			break;
 		case 2 ... 9:		/* Tccd{1-8} */
-			amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
+			ret = amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
 				     ZEN_CCD_TEMP(data->ccd_offset, channel - 2),
 						  &regval);
+			if (ret)
+				return ret;
 			*val = (regval & ZEN_CCD_TEMP_MASK) * 125 - 49000;
 			break;
 		default:
@@ -240,11 +253,15 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
 		*val = 70 * 1000;
 		break;
 	case hwmon_temp_crit:
-		data->read_htcreg(data->pdev, &regval);
+		ret = data->read_htcreg(data->pdev, &regval);
+		if (ret)
+			return ret;
 		*val = ((regval >> 16) & 0x7f) * 500 + 52000;
 		break;
 	case hwmon_temp_crit_hyst:
-		data->read_htcreg(data->pdev, &regval);
+		ret = data->read_htcreg(data->pdev, &regval);
+		if (ret)
+			return ret;
 		*val = (((regval >> 16) & 0x7f)
 			- ((regval >> 24) & 0xf)) * 500 + 52000;
 		break;
-- 
2.25.1

