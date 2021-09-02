Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3FDB3FF2BA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 19:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346800AbhIBRn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 13:43:58 -0400
Received: from mail-dm6nam12on2056.outbound.protection.outlook.com ([40.107.243.56]:9440
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347182AbhIBRnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 13:43:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/fZGzm/t6giAXnPQjjR7PCs0S1EIswJCMU8GRbK+u42Z78+3Gk+da26WfSN2Nzg9p9P2zgTN9wR5GIg9RAU50HqAsAhCQiF1XPC1ZEojo6pNttAPD2V4XU2k7EEkPU9Ynt8L9vQuvEECydWvn49tK2yKBOeRoOSO1p79aBbA0w9VlsnGG0vNmiQ9Nkd0w33b4+ZAPCMxEggzGzj7+1gRY/8bOt468pxwU3mD3WJubckUCXSkpPd+lXEakGrMDiIVkchE4kGBeTOxqWHncDnJNW1wODS3CJJ3E5Zy2pyKcdlOR3EK1uKgJDzZiPqt40KPaFIiUj2V2oxWJ3jcMpJJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4A5muJOFLivcI6L2xL2DFd7r1aQpYh/q6Zd4iG53ZmU=;
 b=ZMiKD/Q9d4puOUBGe5Dhh8Qaz0tvijxww6x2torYfN/G6qOjyrRcWekc9VJ5Vs9KxHj1flsINRXZu7XatofdfAhMMSNVpPHgDacK8jbP2vb1fV8q5lXELDXyLN7eVjG8PwW9SBeVHrlruws5omUlKx1zvsAkwLyFHEhMQOd0aE7BJ1xxsKyA7pihmp9UfRhaneeA6ZtuwNgBIG+8zyAyJS0Xe2tsWrbuOCk5iQnWNwTjIOF6vO9mors9q6EnGy9GSXmN5Uuteixgc2HD6F3flfGgb9VMKuEJwRFSQSHDR8Vq8861z36KFDP58nLm9I7I67INOdg8BjOHYflrGK6asQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4A5muJOFLivcI6L2xL2DFd7r1aQpYh/q6Zd4iG53ZmU=;
 b=jjSxI1SsqvvXQewT84wluIx5X376qNsy11Ew30eXYs55GUIWLKmurAQou4TwLSK5Ye9z/zzXYpuiODg8Ln/8xUC2rMFKHOws8EUP1RXiGSAvwb9eoYnDVZG1um9ouTRATHw58ifwlfprrqL7dABlJ6lKe/JcjGYarE/iNVr1RFI=
Received: from MW3PR05CA0021.namprd05.prod.outlook.com (2603:10b6:303:2b::26)
 by MN2PR12MB3487.namprd12.prod.outlook.com (2603:10b6:208:c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Thu, 2 Sep
 2021 17:42:15 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::78) by MW3PR05CA0021.outlook.office365.com
 (2603:10b6:303:2b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.4 via Frontend
 Transport; Thu, 2 Sep 2021 17:42:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4478.19 via Frontend Transport; Thu, 2 Sep 2021 17:42:14 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 2 Sep
 2021 12:42:09 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>
CC:     <linux@roeck-us.net>, <bp@alien8.de>, <yazen.ghannam@amd.com>,
        <mingo@redhat.com>, <nathan.fontenot@amd.com>,
        <lewis.carroll@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jean Delvare <jdelvare@suse.com>
Subject: [PATCH 1/3] x86/amd_nb: Add support for HSMP mailbox access
Date:   Thu, 2 Sep 2021 23:11:53 +0530
Message-ID: <20210902174155.7365-1-nchatrad@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dba29508-60db-47a5-c40b-08d96e390075
X-MS-TrafficTypeDiagnostic: MN2PR12MB3487:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3487810246F20BA3B716834FE8CE9@MN2PR12MB3487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2HbLBNahsu/xPhtYtELwJmp4+aE+7TQk7/gymuG8X/ZzaJulyAZ2mevDkC8ttaBQ43PADUOcNGtfucuyumrwV2g2AnGz7riya12C5w4HGzsTyzuyrI3nfcZHJ3+eZIR6muq4pNULbwAsEIsBZoG7DybH1T4xoa7VI5oul7JcvszFL9Sju0/byF2lKnjqjUHPVEJhnZQl3isgo1SjWZTU/nrUNAzAGdlxpBy174AnUJoTh6JWtFHA4fUTgAcGIeqa/rZmMutcY2bHwC5Z7CBFthfmUbTZ8wAAZsyM0dOLWyT8h1wY1UJX3RhTQM3SgU2tdGNhtqpxUvQzef4LMD8RDcuAa1gbgQtSbFtey7TgQ8LJcmnbiqWWSD5oQJTfe5AzE323Rc5gF9JUpXW4yZ/4GV0I5B2OvJFql8hGmqQ4/9njxrJ/PMlniiWpe+B7Z7Oe85JEs6g6FKKJOvLGDPxnvLR8XK3l+oIZkQ2rVyODF1eJ4/AO4GuqH9m6B5GeKArnduWD3u0UbaAAGnBBDiAh4wg0C+I66atahGzf9cmGX9SQG/SVemHt1XuW/U0rzeYSeN8i3e9hoAiYZh2hEblcp84ozlClZITfZFb6bDi/nvp+bHhiPw1kfuTiNw4EOgZd/40X6v5wMzIC6glGV5Fqk256AxfyrneYmCpSUCfjrYV20Ix4c6C/vTXbK4CIk0/MiWlET0hvZHMs6f4mWcsb12WRceLUn1Qy0XtpEC8GSAw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(82310400003)(316002)(15650500001)(336012)(4326008)(110136005)(54906003)(16526019)(186003)(47076005)(36756003)(83380400001)(6666004)(2616005)(26005)(426003)(70586007)(36860700001)(5660300002)(8936002)(1076003)(8676002)(508600001)(356005)(7696005)(2906002)(70206006)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 17:42:14.7725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dba29508-60db-47a5-c40b-08d96e390075
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3487
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fam19h server CPUs from AMD an HSMP (Host System Management Port)
mailbox interface is added to monitor and manage the CPU parameters.

Export hsmp_send_message() function which takes a socket number and
a messages structure as inputs, returns 0 on success and negative
error otherwise. The API can be used by other kernel components to
access system management features.

Eg: hwmon based k10temp driver can be modified to report power metrics

Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: x86-ml <x86@kernel.org>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/amd_nb.h |  40 +++++++
 arch/x86/kernel/amd_nb.c      | 217 ++++++++++++++++++++++++++++++++++
 2 files changed, 257 insertions(+)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index 455066a06f60..2640429114ee 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -66,6 +66,7 @@ struct amd_northbridge {
 	struct pci_dev *link;
 	struct amd_l3_cache l3_cache;
 	struct threshold_bank *bank4;
+	struct semaphore hsmp_sem_lock;
 };
 
 struct amd_northbridge_info {
@@ -77,6 +78,7 @@ struct amd_northbridge_info {
 #define AMD_NB_GART			BIT(0)
 #define AMD_NB_L3_INDEX_DISABLE		BIT(1)
 #define AMD_NB_L3_PARTITIONING		BIT(2)
+#define AMD_NB_HSMP			BIT(3)
 
 #ifdef CONFIG_AMD_NB
 
@@ -123,5 +125,43 @@ static inline bool amd_gart_present(void)
 
 #endif
 
+/*
+ * HSMP Message types supported
+ */
+enum hsmp_message_ids {
+	HSMP_TEST = 1,
+	HSMP_GET_SMU_VER,
+	HSMP_GET_PROTO_VER,
+	HSMP_GET_SOCKET_POWER,
+	HSMP_SET_SOCKET_POWER_LIMIT,
+	HSMP_GET_SOCKET_POWER_LIMIT,
+	HSMP_GET_SOCKET_POWER_LIMIT_MAX,
+	HSMP_SET_BOOST_LIMIT,
+	HSMP_SET_BOOST_LIMIT_SOCKET,
+	HSMP_GET_BOOST_LIMIT,
+	HSMP_GET_PROC_HOT,
+	HSMP_SET_XGMI_LINK_WIDTH,
+	HSMP_SET_DF_PSTATE,
+	HSMP_AUTO_DF_PSTATE,
+	HSMP_GET_FCLK_MCLK,
+	HSMP_GET_CCLK_THROTTLE_LIMIT,
+	HSMP_GET_C0_PERCENT,
+	HSMP_SET_NBIO_DPM_LEVEL,
+	HSMP_RESERVED,
+	HSMP_GET_DDR_BANDWIDTH,
+	HSMP_MSG_ID_MAX,
+};
+
+#define HSMP_MAX_MSG_LEN	8
+
+struct hsmp_message {
+	u32	msg_id;			/* Message ID */
+	u16	num_args;		/* Number of arguments in message */
+	u16	response_sz;		/* Number of expected response words */
+	u32	args[HSMP_MAX_MSG_LEN];	/* Argument(s) */
+	u32	response[HSMP_MAX_MSG_LEN];	/* Response word(s) */
+};
+
+int hsmp_send_message(int socket_id, struct hsmp_message *msg);
 
 #endif /* _ASM_X86_AMD_NB_H */
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index c92c9c774c0e..2bba59c1350e 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -6,6 +6,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/delay.h>
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/init.h>
@@ -29,6 +30,22 @@
 #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F4 0x167d
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
 
+/*
+ * HSMP Status / Error codes
+ */
+#define HSMP_STATUS_NOT_READY	0x00
+#define HSMP_STATUS_OK		0x01
+#define HSMP_ERR_INVALID_MSG	0xFE
+#define HSMP_ERR_INVALID_INPUT	0xFF
+
+/* To access specific HSMP mailbox register, s/w writes the SMN address of HSMP mailbox
+ * register into the SMN_INDEX register, and reads/writes the SMN_DATA reg.
+ * Below are required SMN address for HSMP Mailbox register offsets in SMU address space
+ */
+#define SMN_HSMP_MSG_ID	0x3B10534
+#define SMN_HSMP_MSG_RESP	0x3B10980
+#define SMN_HSMP_MSG_DATA	0x3B109E0
+
 /* Protect the PCI config register pairs used for SMN and DF indirect access. */
 static DEFINE_MUTEX(smn_mutex);
 
@@ -108,6 +125,9 @@ const struct amd_nb_bus_dev_range amd_nb_bus_dev_ranges[] __initconst = {
 
 static struct amd_northbridge_info amd_northbridges;
 
+/* Timeout in millsec */
+#define HSMP_MSG_TIMEOUT	100
+
 u16 amd_nb_num(void)
 {
 	return amd_northbridges.num;
@@ -182,6 +202,194 @@ int amd_smn_write(u16 node, u32 address, u32 value)
 }
 EXPORT_SYMBOL_GPL(amd_smn_write);
 
+#define HSMP_WR true
+#define HSMP_RD false
+
+static int __amd_hsmp_rdwr(struct pci_dev *root, u32 address,
+			   u32 *value, bool write)
+{
+	int err;
+
+	err = pci_write_config_dword(root, 0xc4, address);
+	if (err) {
+		pr_warn("Error programming SMN address 0x%x.\n", address);
+		return err;
+	}
+
+	err = (write ? pci_write_config_dword(root, 0xc8, *value)
+		     : pci_read_config_dword(root, 0xc8, value));
+	if (err)
+		pr_warn("Error %s SMN address 0x%x.\n",
+			(write ? "writing to" : "reading from"), address);
+
+	return err;
+}
+
+/*
+ * Send a message to the HSMP port via PCI-e config space registers.
+ *
+ * The caller is expected to zero out any unused arguments.
+ * If a response is expected, the number of response words should be greater than 0.
+ *
+ * Returns 0 for success and populates the requested number of arguments.
+ * Returns a negative error code for failure.
+ */
+static int __hsmp_send_message(struct pci_dev *root, struct hsmp_message *msg)
+{
+	u64 timeout = HSMP_MSG_TIMEOUT;
+	u32 mbox_status;
+	u32 arg_num;
+	int err;
+
+	/* Clear the status register */
+	mbox_status = HSMP_STATUS_NOT_READY;
+	err = __amd_hsmp_rdwr(root, SMN_HSMP_MSG_RESP, &mbox_status, HSMP_WR);
+	if (err) {
+		pr_err("Error %d clearing mailbox status register.\n", err);
+		return err;
+	}
+
+	arg_num = 0;
+	/* Write any message arguments */
+	while (arg_num < msg->num_args) {
+		err = __amd_hsmp_rdwr(root, SMN_HSMP_MSG_DATA + (arg_num << 2),
+				      &msg->args[arg_num], HSMP_WR);
+		if (err) {
+			pr_err("Error %d writing message argument %d\n",
+			       err, arg_num);
+			return err;
+		}
+		arg_num++;
+	}
+
+	/* Write the message ID which starts the operation */
+	err = __amd_hsmp_rdwr(root, SMN_HSMP_MSG_ID, &msg->msg_id, HSMP_WR);
+	if (err) {
+		pr_err("Error %d writing message ID %u\n", err, msg->msg_id);
+		return err;
+	}
+
+	/*
+	 * Depending on when the trigger write completes relative to the SMU
+	 * firmware 1 ms cycle, the operation may take from tens of us to 1 ms
+	 * to complete. Some operations may take more. Therefore we will try
+	 * a few short duration sleeps and switch to long sleeps if we don't
+	 * succeed quickly.
+	 */
+	do {
+		if (likely(timeout > 90))
+			usleep_range(50, 100);
+		else
+			usleep_range(100, 500);
+
+		err = __amd_hsmp_rdwr(root, SMN_HSMP_MSG_RESP, &mbox_status, HSMP_RD);
+		if (err) {
+			pr_err("Error %d reading mailbox status\n", err);
+			return err;
+		}
+
+		if (mbox_status != HSMP_STATUS_NOT_READY)
+			break;
+
+	} while (--timeout);
+
+	if (unlikely(mbox_status == HSMP_ERR_INVALID_MSG)) {
+		pr_err("Invalid message ID %u\n", msg->msg_id);
+		err = -ENOMSG;
+		return err;
+	} else if (unlikely(mbox_status == HSMP_ERR_INVALID_INPUT)) {
+		pr_err("Invalid arguments for %d\n", msg->msg_id);
+		err = -EINVAL;
+		return err;
+	} else if (unlikely(mbox_status != HSMP_STATUS_OK)) {
+		pr_err("Message ID %u unknown failure (status = 0x%X), timedout\n",
+		       msg->msg_id, mbox_status);
+		err = -ETIMEDOUT;
+		return err;
+	}
+
+	/* SMU has responded OK. Read response data */
+	arg_num = 0;
+	while (arg_num < msg->response_sz) {
+		err = __amd_hsmp_rdwr(root, SMN_HSMP_MSG_DATA + (arg_num << 2),
+				      &msg->response[arg_num], HSMP_RD);
+		if (err) {
+			pr_err("Error %d reading response %u for message ID:%u\n",
+			       err, arg_num, msg->msg_id);
+			break;
+		}
+		arg_num++;
+	}
+
+	return err;
+}
+
+/* Verify the HSMP test message */
+static bool amd_hsmp_support(void)
+{
+	struct hsmp_message msg = { 0 };
+	int err = 0;
+	struct pci_dev *root;
+
+	/*
+	 * Check HSMP support on socket 0. the test message takes one argument
+	 * and returns the value of that argument + 1.
+	 */
+	root = node_to_amd_nb(0)->root;
+	if (!root)
+		return false;
+
+	msg.args[0]     = 0xDEADBEEF;
+	msg.response_sz = 1;
+	msg.msg_id	= HSMP_TEST;
+	msg.num_args	= 1;
+
+	err = __hsmp_send_message(root, &msg);
+	if (err)
+		return false;
+
+	if (msg.response[0] != msg.args[0] + 1)
+		return false;
+
+	return true;
+}
+
+int hsmp_send_message(int node, struct hsmp_message *msg)
+{
+	struct pci_dev *root;
+	int err;
+
+	if (!amd_nb_has_feature(AMD_NB_HSMP))
+		return -ENODEV;
+
+	root = node_to_amd_nb(node)->root;
+	if (!root || !msg)
+		return -ENODEV;
+
+	if (msg->msg_id < HSMP_TEST || msg->msg_id >= HSMP_MSG_ID_MAX)
+		return -EINVAL;
+
+	if (msg->num_args > HSMP_MAX_MSG_LEN || msg->response_sz > HSMP_MAX_MSG_LEN)
+		return -EINVAL;
+
+	/*
+	 * The time taken by smu operation to complete is between
+	 * 10us to 1ms. Sometime it may take more time.
+	 * In SMP system timeout of 100 millisecs should
+	 * be enough for the previous thread to finish the operation
+	 */
+	err = down_timeout(&(node_to_amd_nb(node)->hsmp_sem_lock),
+			   msecs_to_jiffies(HSMP_MSG_TIMEOUT));
+	if (err < 0)
+		return err;
+
+	err = __hsmp_send_message(root, msg);
+	up(&(node_to_amd_nb(node)->hsmp_sem_lock));
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(hsmp_send_message);
+
 /*
  * Data Fabric Indirect Access uses FICAA/FICAD.
  *
@@ -307,6 +515,15 @@ int amd_cache_northbridges(void)
 	if (amd_gart_present())
 		amd_northbridges.flags |= AMD_NB_GART;
 
+	if (boot_cpu_data.x86 >= 0x19 && amd_hsmp_support()) {
+		amd_northbridges.flags |= AMD_NB_HSMP;
+
+		/* Protect the PCI config register pairs used for HSMP mailbox access, */
+		/* by initialising  semaphore for each socket */
+		for (i = 0; i < amd_northbridges.num; i++)
+			sema_init(&(node_to_amd_nb(i)->hsmp_sem_lock), 1);
+	}
+
 	/*
 	 * Check for L3 cache presence.
 	 */
-- 
2.17.1

