Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B603FF2BD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 19:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347189AbhIBRoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 13:44:12 -0400
Received: from mail-bn8nam08on2085.outbound.protection.outlook.com ([40.107.100.85]:42204
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346869AbhIBRn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 13:43:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEl9TqQqvTWFb2px2D2vKTv9u4uMPZ8j/8eRmFdPmU4A7L9fPgeJezo7lpnN4ZyNHIOxFaM/0wQiXH9SE5DSoedXSQMWcNRmo+8KoPnAIt30r2ZHt0+wzES3oCO9cr9F0WSrqOcbOQgWGF6uxRfaseMuAvdrOTtpzrrj0C+/uPltQsNRiNroT4bJy2tjYlVYrHfjHIwuVgdcINTn1NmcIr+GD7JK3AwsQSijEsIbh9KB2HXgpiq/iMrpxBS/IrxwBPi0uYJAWVl7DwHsl2TC+0Ut97rqCJFDgE2r9He501KezEqpXhM/WvNzxxkVPqysJuNIwGX7bARaRmMqIdm6WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=zB9IUhOPZQMuGXv6BnK08+UmD8gibSCkpP2k7UzbADo=;
 b=Zewbus+QDYa2iUj5aw28+agaAUF8ysjih++FRSatJtqWqrsaBLjHzUudv1ipgjE6W+lpxjghHwwFcJk/q/cwWnBdj2u/yH91L/J3Hbgh7a7jFwnB3SbACF+/OGgFGQTyanwEh59o2SRqoCI64uG7hKHykregcmeP19wq78IUX+YbBFmwzMIEhbnOX+zPOCu4JiwZkNvviZQgDma41UYiz2C/pTshd7UOkNgDc8uwPjByS+Sm9Gv2PhgHvgqUMNcKp5hKj9iA1cL9+CbdtzClw6pL9Jn1+QPKuxfBmYWxYHmbNaeEQuurqvCtHG97dDVSbMLm9OqPUoPdAT9YRBo4bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zB9IUhOPZQMuGXv6BnK08+UmD8gibSCkpP2k7UzbADo=;
 b=Z5Z9XzCtXjHuDJDrgC3SjE5LculqSauMLR4+CG6yr6yRP9bllsmjkGUa+QVoJHP5NMa4SgDe5XYrqcja/cqhSgjduqzYefT0YKLHciW5pPBHU6zFhUVTZgmDkGrTwD03Qg11PFE+TKCwVSOhflE2v/ZfDg8nk0ko5wujc6P1MUc=
Received: from MWHPR18CA0049.namprd18.prod.outlook.com (2603:10b6:300:39::11)
 by DM5PR12MB2582.namprd12.prod.outlook.com (2603:10b6:4:b5::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Thu, 2 Sep
 2021 17:42:28 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:39:cafe::2d) by MWHPR18CA0049.outlook.office365.com
 (2603:10b6:300:39::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend
 Transport; Thu, 2 Sep 2021 17:42:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4478.19 via Frontend Transport; Thu, 2 Sep 2021 17:42:27 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 2 Sep
 2021 12:42:23 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>
CC:     <linux@roeck-us.net>, <bp@alien8.de>, <yazen.ghannam@amd.com>,
        <mingo@redhat.com>, <nathan.fontenot@amd.com>,
        <lewis.carroll@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>
Subject: [PATCH 3/3] k10temp: Add power sensor for family 19h
Date:   Thu, 2 Sep 2021 23:11:55 +0530
Message-ID: <20210902174155.7365-3-nchatrad@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210902174155.7365-1-nchatrad@amd.com>
References: <20210902174155.7365-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fec8cdcf-2144-423e-b7bc-08d96e390853
X-MS-TrafficTypeDiagnostic: DM5PR12MB2582:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2582137849B7120014178F83E8CE9@DM5PR12MB2582.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VZX0/KOItjJnkOfUb0v20UakGvTDAerDzncJO2gkBo12P2sxAx1D0J688OxaIyxzfHIOaS3rqpMyUP0cgm4Cnfr9xdP03bJ1NdOVvZRfsIGERZqPOS5P8vwfAZP4XBfIjSxFOuQbLHDlJ9FbtaQrnkfmekMH9QWGY2DD8nl4eXFgZqcnuXfn8N575FSlun3gGBAAMCxm3BwF90cXhj4yXFkUGR+ejW4Th2rxtaVLl66AhACjfDqKeOyzZ5kQYivnoq//jWegjUL+UnlFNMpxco7D9ttyMNa/ernUzDcBKQhXCFRTGP503BFvZIS8AQyW4N94xBXm+8CyRhuquIoqgL3QzThBLWdN+G4r7uyJELLgkm+yITOOVsxrhzh+in47m4Ax3KLljioz757Nqt980l+pPGh1Z0UxT7bWSNBAL2Oj9Ps9bgU3wzi2xW7rdpzlGqfTBuL95gN/UP6lreOqR5jLo45XmXbuOQPOva1cZ0U7vnTS1IDbGkRz0wz5VH3srbVRRNcQ8vmbdE/TBDMx6ZmYCgQre1uvinzHHm5Amskb+UutppzrYYeigCjfqLKWleXTGP66lZ9H7urliaJ0ynoNBrQsqHthrDweEV3V66RbFxccpt0QYmVsgTgiLmXad9K/Dy1sipD59iDBb4EIS8nl408RYdP0MwV4+lgcYvEJPPgjthhF+DWFpP8VL4okQ+68mOYbpXrgsRyRUwf/CZ0/R619EjdEKm6RtBjkUaA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(36840700001)(46966006)(2906002)(36756003)(316002)(426003)(16526019)(186003)(26005)(1076003)(7696005)(336012)(81166007)(478600001)(83380400001)(70206006)(70586007)(54906003)(8936002)(4326008)(2616005)(6666004)(47076005)(5660300002)(110136005)(82310400003)(356005)(82740400003)(36860700001)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 17:42:27.9792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fec8cdcf-2144-423e-b7bc-08d96e390853
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2582
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On newer Fam19h server line of AMD processors a new channel
is created to report and manage socket power limits.

This patch creates hwmon_power sensor to report current power,
power cap and max power cap of the socket.
While at it, update the k10temp documentation

Tested-by: suma hegde <suma.hegde@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/k10temp.rst |  18 ++++++
 drivers/hwmon/k10temp.c         | 106 ++++++++++++++++++++++++++++++++
 2 files changed, 124 insertions(+)

diff --git a/Documentation/hwmon/k10temp.rst b/Documentation/hwmon/k10temp.rst
index 91b99adc6c48..d5a78a7b6ca5 100644
--- a/Documentation/hwmon/k10temp.rst
+++ b/Documentation/hwmon/k10temp.rst
@@ -132,3 +132,21 @@ On Family 17h and Family 18h CPUs, additional temperature sensors may report
 Core Complex Die (CCD) temperatures. Up to 8 such temperatures are reported
 as temp{3..10}_input, labeled Tccd{1..8}. Actual support depends on the CPU
 variant.
+
+On Family 19h server line of CPUs, additionally driver may report socket
+current power consumption with power cap and power cap max. This requires the
+HSMP support exported in the amd_nb module.
+
+The power1_cap can be set to any value, SMU FW will limit the maximum cap to
+the value reported by power1_cap_max entry. The SMU FW may not take any action
+if the power1_cap is set to a value lesser than the minimum socket consumption.
+
+The following attributes may be reported.
+
+================ ===== ========================================================
+Name             Perm  Description
+================ ===== ========================================================
+power1_input     RO    Socket current Power consumed
+power1_cap       RW    Socket Power limit can be set between 0 and power1_cap_max
+power1_cap_max   RO    Maximum powerlimit calculated and reported by the SMU FW
+================ ===== ========================================================
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 3618a924e78e..b993fdd94979 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -105,6 +105,9 @@ struct k10temp_data {
 	u32 show_temp;
 	bool is_zen;
 	u32 ccd_offset;
+	bool show_power;
+	char pwr_label[20];
+	u32 power_cap_max;
 };
 
 #define TCTL_BIT	0
@@ -197,10 +200,14 @@ static int k10temp_read_labels(struct device *dev,
 			       enum hwmon_sensor_types type,
 			       u32 attr, int channel, const char **str)
 {
+	struct k10temp_data *data = dev_get_drvdata(dev);
 	switch (type) {
 	case hwmon_temp:
 		*str = k10temp_temp_label[channel];
 		break;
+	case hwmon_power:
+		*str = data->pwr_label;
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -254,12 +261,43 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
 	return 0;
 }
 
+static int k10temp_read_power(struct device *dev, u32 attr, int channel, long *val)
+{
+	struct k10temp_data *data = dev_get_drvdata(dev);
+	struct hsmp_message msg = { 0 };
+	int err;
+
+	switch (attr) {
+	case hwmon_power_input:
+		msg.msg_id = HSMP_GET_SOCKET_POWER;
+		break;
+	case hwmon_power_cap:
+		msg.msg_id = HSMP_GET_SOCKET_POWER_LIMIT;
+		break;
+	case hwmon_power_cap_max:
+		/* power_cap_max does not change dynamically, hence return the cached value */
+		*val = data->power_cap_max * 1000;
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+	msg.response_sz = 1;
+	err = hsmp_send_message(amd_pci_dev_to_node_id(data->pdev), &msg);
+	if (!err)
+		/* power metric is reported in micro watts. hence multiply by 1000 */
+		*val = msg.response[0] * 1000;
+
+	return err;
+}
+
 static int k10temp_read(struct device *dev, enum hwmon_sensor_types type,
 			u32 attr, int channel, long *val)
 {
 	switch (type) {
 	case hwmon_temp:
 		return k10temp_read_temp(dev, attr, channel, val);
+	case hwmon_power:
+		return k10temp_read_power(dev, attr, channel, val);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -308,12 +346,45 @@ static umode_t k10temp_is_visible(const void *_data,
 			return 0;
 		}
 		break;
+	case hwmon_power:
+		switch (attr) {
+		case hwmon_power_input:
+		case hwmon_power_cap_max:
+		case hwmon_power_label:
+			/* Show power attributes only if show_power is available */
+			if (data->show_power)
+				break;
+			return 0;
+		case hwmon_power_cap:
+			if (data->show_power)
+				return 0644;
+			return 0;
+		default:
+			return -EOPNOTSUPP;
+		}
+		break;
 	default:
 		return 0;
 	}
 	return 0444;
 }
 
+static int k10temp_write(struct device *dev, enum hwmon_sensor_types type,
+			 u32 attr, int channel, long val)
+{
+	struct hsmp_message msg = { 0 };
+	struct k10temp_data *data = dev_get_drvdata(dev);
+
+	if (type == hwmon_power && attr == hwmon_power_cap) {
+		msg.response_sz = 1;
+		msg.num_args	= 1;
+		msg.msg_id	= HSMP_SET_SOCKET_POWER_LIMIT;
+		msg.args[0]	= val / 1000;
+		return hsmp_send_message(amd_pci_dev_to_node_id(data->pdev), &msg);
+	}
+	return -EOPNOTSUPP;
+}
+
 static bool has_erratum_319(struct pci_dev *pdev)
 {
 	u32 pkg_type, reg_dram_cfg;
@@ -362,6 +433,9 @@ static const struct hwmon_channel_info *k10temp_info[] = {
 			   HWMON_T_INPUT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_LABEL),
+	HWMON_CHANNEL_INFO(power,
+			   HWMON_P_INPUT | HWMON_P_LABEL |
+			   HWMON_P_CAP | HWMON_P_CAP_MAX),
 	NULL
 };
 
@@ -369,6 +443,7 @@ static const struct hwmon_ops k10temp_hwmon_ops = {
 	.is_visible = k10temp_is_visible,
 	.read = k10temp_read,
 	.read_string = k10temp_read_labels,
+	.write = k10temp_write,
 };
 
 static const struct hwmon_chip_info k10temp_chip_info = {
@@ -390,6 +465,32 @@ static void k10temp_get_ccd_support(struct pci_dev *pdev,
 	}
 }
 
+static int k10temp_get_max_power(struct k10temp_data *data)
+{
+	int err;
+	struct hsmp_message msg = { 0 };
+
+	msg.msg_id = HSMP_GET_SOCKET_POWER_LIMIT_MAX;
+	msg.response_sz = 1;
+	err = hsmp_send_message(amd_pci_dev_to_node_id(data->pdev), &msg);
+	if (!err)
+		data->power_cap_max = msg.response[0];
+	return err;
+}
+
+static void check_power_support(struct k10temp_data *data)
+{
+	/* HSMP support is required to obtain power metrics */
+	if (!amd_nb_has_feature(AMD_NB_HSMP))
+		return;
+
+	if (k10temp_get_max_power(data))
+		return;
+
+	sprintf(data->pwr_label, "socket%d_pwr", amd_pci_dev_to_node_id(data->pdev));
+	data->show_power = true;
+}
+
 static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	int unreliable = has_erratum_319(pdev);
@@ -448,6 +549,11 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 		switch (boot_cpu_data.x86_model) {
 		case 0x0 ... 0x1:	/* Zen3 SP3/TR */
+		case 0x30 ... 0x31:
+			check_power_support(data);
+			data->ccd_offset = 0x154;
+			k10temp_get_ccd_support(pdev, data, 8);
+			break;
 		case 0x21:		/* Zen3 Ryzen Desktop */
 		case 0x50 ... 0x5f:	/* Green Sardine */
 			data->ccd_offset = 0x154;
-- 
2.17.1

