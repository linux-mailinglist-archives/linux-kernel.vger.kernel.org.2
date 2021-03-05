Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A0532E9C3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 13:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhCEMem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 07:34:42 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:13707 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbhCEMdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 07:33:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614947630; x=1646483630;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=o5rSwHjFKop/zmxE7WEuaIKoEQpInnV3S8pgJDjjelg=;
  b=q/FvC0c+0ktGToEj9lKwF0F0eP/0axE8DQ1DnyrE6Uax0/x+O+KKMyXu
   /AJdA+0qAABAe3Jhby3qu7EHbdu2jWyGf/KlBPjPexQz6zXZhZ+Tr+bBf
   4jrdbeUxuaek/pApru9GE9i4Q61J7hGotXsyidsXG9U7Sw76LDkdlRUMP
   5BmVBCYgYTHD22Ks0IKFkcBOJVkpK0JyFXegIALN8JglMT2jX85N5Nuea
   WtmhO15YMNnR0gh86LgE6axrbpmdfaOZFBGpJ0u0PGGSolCmRpC50pj4z
   ztUCZDR8s5ollFaiJkhQOpeGh2YOURyGNOiTquXSYFc1y0MrFdW0ILFmY
   A==;
IronPort-SDR: F0Kb4FP3W2C5ae1XyAEAWsfUeCmtmjH7lyK/it7/pjHvXFkJ3L9HBWZLoUxwrPiemlo2+2RBpQ
 c/OnYPkAcZNKSbUbuQlZPNseemjE78eQDdwvAJRnE3VcUT9FB9xX4Akpi4COTzodbRCWBMA0tp
 MAR7a15P0PWumRk8EMNrvmMKrQAcbi2/Mr/eT4K5v8E1c0fVwA5EuOHPqoNMVmAsT/NHzPDwms
 zDXz2gr0+MvBD7tENnLTbwznfiYN/EtIK1chGigmcJ+KUGqn1PgH5E7iY9acSBoRwk8rz6SAZq
 4iE=
X-IronPort-AV: E=Sophos;i="5.81,224,1610380800"; 
   d="scan'208";a="272083929"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 05 Mar 2021 20:33:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnBOhElm9ZnA0QrbVCb7bGTtu2xRbSGIlz56FQp3HMp95OpfJbjMd3scz9dXv0cySTX+hTeQiqS7zF5K0ujn8BNds6nM2Vb8ymOAtA8TR5YeHmeIRIGtbEl4IsNROq+Gkt1hw1ur6Ta6ff88nkF7/7M/UfEbZJyTudLkr7StwEp//R8asQRQ5cryLVxDSYM6iNeK+Ip7MOz6qY6yk9F2++uAZCCK4GKOinxb3yN6UPOY1HY5OfS9Rn7KnJS06Is6QnUXhpixHNNzQNQAXyvK2JVvKiuitEeR/5BHAtJGsW4M5nOu/gQpZZMxBDDjrDoD9qouh5ik2C4QEoYI2OIObg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=av1ijqhLSrLbLxC8Krc7tNG9Kd7R7xxJYgSu6G5iOtM=;
 b=i/9zGOvYh1qGbppaACIxbzQooZiQVSZJcSd5OdYAJgVwiYFXbeAEXFKn/h4QdtYtxPkj/FzwdJ0it2rUBCR4fbtyjdnxnTJPEvmWHUwr54YteEdGL7OzSrNXC3oNJrUte34tokmKVJUxksS1A3hQOKBdxBLwXMCvCxANcCKTRAQxQrLr7ep357AWzBta9bmpNsXRn08QzaSA4y+h2PQaC70AdffNjUW0GL2Rkml53X2aZzv4fep3LNzxf/8Qr+F6zOKKFVqmo8UJUll7WrZNZovl7D5QQZ3V+TqxPlpnryDBZFM7VB2d8x7ZfNYyXmEMKP65fP4VilbJvHPtrv+c4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=av1ijqhLSrLbLxC8Krc7tNG9Kd7R7xxJYgSu6G5iOtM=;
 b=bH0mZslWw+DNxd7Ebuw/9uYT/4GfE7hlb4mVa+MLrIz8Yh0XsQEYRiuHUFzX3yAPXC0+Sb5J5iMZ9g32+gcCyxzMwiy5B99WH9foieYcuslBhVQmH2UwReE97KfYLw9SGdJ9pkRSs4f0ji0Eaw1+IHv4tEy0LPMVAxive57bf0M=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB4460.namprd04.prod.outlook.com (2603:10b6:5:26::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Fri, 5 Mar
 2021 12:33:47 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868%7]) with mapi id 15.20.3912.022; Fri, 5 Mar 2021
 12:33:47 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup.patel@wdc.com>
Subject: [PATCH v5] RISC-V: Use SBI SRST extension when available
Date:   Fri,  5 Mar 2021 18:03:21 +0530
Message-Id: <20210305123321.544483-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.179.67.166]
X-ClientProxiedBy: MA1PR01CA0147.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::17) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.179.67.166) by MA1PR01CA0147.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 12:33:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a733a61c-93cb-47a9-cebe-08d8dfd2ec27
X-MS-TrafficTypeDiagnostic: DM6PR04MB4460:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB4460A6C35D9948B969AAFAED8D969@DM6PR04MB4460.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hPuHyOKZS/EZYZ8jkMkhBVka8R3r8Yd765/yj/+VvtqBazzZTlUTUUfVZEhiM55Jr6CaapmO7xV1lDbu5AEebDdEH3hl7yO/oQDy5aqx8ps7wQO7aOCPh/BIashx5RScyykaNI4ZakB+KAL+d13vHtqPuvg9aO+w+/oztPej1Qtu4J9bvjH8BU4xKPSvfM/4AEwxkGPolTW8gDikErmRpvA42T5B+z/9BwZShv7ShGsS1coxKM9Wp194O7HGZ1VA1E6/t1iW2kN1fjSf59X2jx3ZpT8LlOH40uETSbcAz5WoR0yQcvyrvebRja4ysSLKAzHPwL5yTHFVBsuh50XHe81LZNNkeAIR2Cqxd4+NYSR61rdYVZH8+b8pRojEWmMNvzEuXxLd971vpuXGeRTnEHxxyWytRX8XMURopirHEWCpr27mZs/JwxViZgSJiHTtdOLVRCeCkJoNo8i92hD9StDLKH3/Fz6yLsepWrV0nDgauGtwVY7VFeeCdTOQ2ugOQ8sLHFwpQjh66vEKNEW/oWxpvxvMQQp0n4DpDIktxzoAI4cpa3MWhmAV3s6ummv5ae2DF7H2RefRCb5BAJ+M3l8vN63V5DitPBQhyhvGsOA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(956004)(8936002)(110136005)(2616005)(316002)(54906003)(44832011)(4326008)(1076003)(26005)(66476007)(186003)(66946007)(66556008)(7696005)(83380400001)(8676002)(478600001)(86362001)(966005)(16526019)(8886007)(6666004)(55016002)(52116002)(2906002)(5660300002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6SyiZKRRCJdi83YKO1cOT+pdRh4ooyrc+CxdidlKIVJGLRxzk7sWeV6o2kQd?=
 =?us-ascii?Q?mqIDyF7W2irZGoTeK2H2FM3wHJQIn8581oIJjtp0ys13T9zRhjyNz6/2+fwD?=
 =?us-ascii?Q?dBlIVY43ifofp1zOGRXvnNEsB6UqcTKahbVZbGEsyhav+FJCV+h+LLUjO0x+?=
 =?us-ascii?Q?kIE+jc6PYJFp1gI446SrQBOkgjosaG/iaN5/ukMwVSCk9xgLu3Yas/FniiGD?=
 =?us-ascii?Q?RanpXEwp/csc9E1EA8+V8UXZDO/u9DUIU7a9E9TgY8tXdrxv+zeE1ThKFuwj?=
 =?us-ascii?Q?+Lx2pCWhBLxIgZ43vh4ABroYxTLDYG5W4Cs626msC+fH/4CaOr7x12dhtv5Q?=
 =?us-ascii?Q?uNWlBkKieJru5QvoAK9i94K0PqMYib0qUsQIrlx9l67N2bdCHIPJlxXUvjLG?=
 =?us-ascii?Q?Uit4ptaIHcINpep6/g2OKkvU8ZLundEc3pTMHE0WWwg8Acc0NlIiykuHAsCG?=
 =?us-ascii?Q?VMmgfF7sGhRwc7IL0SUtjVlBCvPYgdgEXSrg/5AyNxcUOk6+EHDqCnSPQzJn?=
 =?us-ascii?Q?rC20sS7eUfkBbW7RcghkkaQNgbnS2EMaWAW728H8uuOTYm8B35JR0Fu9l1rp?=
 =?us-ascii?Q?nxec+pLPRWYGENVuXK6aAYF1RyaOPZ5UrYIaNJP/tG27kpvC73tRNfotzj5f?=
 =?us-ascii?Q?uy47UR2wCKNHrqLFZPMnLGU6CSwad1b2m2EfpJN5eekVb5EdYgl2LQNT+X+k?=
 =?us-ascii?Q?ynS+xGSnspSC/QDq+W+B0ejYlp4D/sQoOO9uMFelGlLGdl2CyG3RplQKky/A?=
 =?us-ascii?Q?R+S2CH7INY3xFu75FF4YZrjsrRCgwpzCtR+2MGnT1CoA5+LdxrYUQ/5nzrBE?=
 =?us-ascii?Q?EX+FbN0/yL9Nu44qWsYnSV02LfUCvYcaBvtv07B3d+tgWsEZf9ZFGowrWz0l?=
 =?us-ascii?Q?3WOSot0KM8+9zXI6eBadVyju0WiV717XPI/Z2oX/m1NvttzvLPwxsfmPirAi?=
 =?us-ascii?Q?fh5oUR0O2VoG17+we6DrNjtOY+dFqdeyADan182UuECf9GGD2owjhCSx3Ren?=
 =?us-ascii?Q?L/mwcZ2btq06y7Y18SynClwhTPFoj/n0yqsetBBZlA3yvRHYOn6zWM5H/v2N?=
 =?us-ascii?Q?tf6MAlIn03TsafLWoo5LYQYnCiQTlRFOMJEjXZ+EhHfK4FxPQV3U6YHKHd0Y?=
 =?us-ascii?Q?1roSqdqkdtVbgHoGQw/1f0dZ3YVQ1ln8TnHYgp477+wQWAf5QNCwaMrYW+7e?=
 =?us-ascii?Q?Yc53n2j7R2rfK3VYFa/3nkzUOuMvvf0//FajwlcCSnJbbjZP57muKdUXjcSA?=
 =?us-ascii?Q?7JKxsHlWz8/L3hjPYZ0H+HUPxfc51JCi1+Awk5PHx9RGX1r4d3UCbnhS1sMd?=
 =?us-ascii?Q?bOscQYs2weWt1URq773SDDlM?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a733a61c-93cb-47a9-cebe-08d8dfd2ec27
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 12:33:47.6469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a6aNUfscsmbgPYhY2un52pNXKCZ+9HWlB6BtOZ4fIsyEaQYGJ6jw9a8J/5CZ3FnAOBexvRaT2PJmo8SMgXd0Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4460
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SBI SRST extension provides a standard way to poweroff and
reboot the system irrespective to whether Linux RISC-V S-mode
is running natively (HS-mode) or inside Guest/VM (VS-mode).

The SBI SRST extension is available in latest SBI v0.3-draft
specification at: https://github.com/riscv/riscv-sbi-doc.

This patch extends Linux RISC-V SBI implementation to detect
and use SBI SRST extension.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
---
Changes since v4:
 - We should compare both major and minor number to ensure that
   SBI spec version is 0.3 (or above) for detecting SRST extension.
Changes since v3:
 - Rebased on Linux-5.12-rc1
 - Check SBI spec version when probing for SRST extension
Changes since v2:
 - Rebased on Linux-5.10-rc5
 - Updated patch as-per SBI SRST extension available in the latest
   SBI v0.3-draft specification
Changes since v1:
 - Updated patch as-per latest SBI SRST extension draft spec where
   we have only one SBI call with "reset_type" parameter
---
 arch/riscv/include/asm/sbi.h | 24 +++++++++++++++++++++
 arch/riscv/kernel/sbi.c      | 41 +++++++++++++++++++++++++++++++++---
 2 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 99895d9c3bdd..79fa9f28b786 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -27,6 +27,7 @@ enum sbi_ext_id {
 	SBI_EXT_IPI = 0x735049,
 	SBI_EXT_RFENCE = 0x52464E43,
 	SBI_EXT_HSM = 0x48534D,
+	SBI_EXT_SRST = 0x53525354,
 };
 
 enum sbi_ext_base_fid {
@@ -70,6 +71,21 @@ enum sbi_hsm_hart_status {
 	SBI_HSM_HART_STATUS_STOP_PENDING,
 };
 
+enum sbi_ext_srst_fid {
+	SBI_EXT_SRST_RESET = 0,
+};
+
+enum sbi_srst_reset_type {
+	SBI_SRST_RESET_TYPE_SHUTDOWN = 0,
+	SBI_SRST_RESET_TYPE_COLD_REBOOT,
+	SBI_SRST_RESET_TYPE_WARM_REBOOT,
+};
+
+enum sbi_srst_reset_reason {
+	SBI_SRST_RESET_REASON_NONE = 0,
+	SBI_SRST_RESET_REASON_SYS_FAILURE,
+};
+
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
 #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
@@ -145,6 +161,14 @@ static inline unsigned long sbi_minor_version(void)
 	return sbi_spec_version & SBI_SPEC_VERSION_MINOR_MASK;
 }
 
+/* Make SBI version */
+static inline unsigned long sbi_mk_version(unsigned long major,
+					    unsigned long minor)
+{
+	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) <<
+		SBI_SPEC_VERSION_MAJOR_SHIFT) | minor;
+}
+
 int sbi_err_map_linux_errno(int err);
 #else /* CONFIG_RISCV_SBI */
 static inline int sbi_remote_fence_i(const unsigned long *hart_mask) { return -1; }
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index f4a7db3d309e..e94ea8053984 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -7,6 +7,7 @@
 
 #include <linux/init.h>
 #include <linux/pm.h>
+#include <linux/reboot.h>
 #include <asm/sbi.h>
 #include <asm/smp.h>
 
@@ -501,6 +502,32 @@ int sbi_remote_hfence_vvma_asid(const unsigned long *hart_mask,
 }
 EXPORT_SYMBOL(sbi_remote_hfence_vvma_asid);
 
+static void sbi_srst_reset(unsigned long type, unsigned long reason)
+{
+	sbi_ecall(SBI_EXT_SRST, SBI_EXT_SRST_RESET, type, reason,
+		  0, 0, 0, 0);
+	pr_warn("%s: type=0x%lx reason=0x%lx failed\n",
+		__func__, type, reason);
+}
+
+static int sbi_srst_reboot(struct notifier_block *this,
+			   unsigned long mode, void *cmd)
+{
+	sbi_srst_reset((mode == REBOOT_WARM || mode == REBOOT_SOFT) ?
+		       SBI_SRST_RESET_TYPE_WARM_REBOOT :
+		       SBI_SRST_RESET_TYPE_COLD_REBOOT,
+		       SBI_SRST_RESET_REASON_NONE);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block sbi_srst_reboot_nb;
+
+static void sbi_srst_power_off(void)
+{
+	sbi_srst_reset(SBI_SRST_RESET_TYPE_SHUTDOWN,
+		       SBI_SRST_RESET_REASON_NONE);
+}
+
 /**
  * sbi_probe_extension() - Check if an SBI extension ID is supported or not.
  * @extid: The extension ID to be probed.
@@ -577,22 +604,30 @@ void __init sbi_init(void)
 			sbi_get_firmware_id(), sbi_get_firmware_version());
 		if (sbi_probe_extension(SBI_EXT_TIME) > 0) {
 			__sbi_set_timer = __sbi_set_timer_v02;
-			pr_info("SBI v0.2 TIME extension detected\n");
+			pr_info("SBI TIME extension detected\n");
 		} else {
 			__sbi_set_timer = __sbi_set_timer_v01;
 		}
 		if (sbi_probe_extension(SBI_EXT_IPI) > 0) {
 			__sbi_send_ipi	= __sbi_send_ipi_v02;
-			pr_info("SBI v0.2 IPI extension detected\n");
+			pr_info("SBI IPI extension detected\n");
 		} else {
 			__sbi_send_ipi	= __sbi_send_ipi_v01;
 		}
 		if (sbi_probe_extension(SBI_EXT_RFENCE) > 0) {
 			__sbi_rfence	= __sbi_rfence_v02;
-			pr_info("SBI v0.2 RFENCE extension detected\n");
+			pr_info("SBI RFENCE extension detected\n");
 		} else {
 			__sbi_rfence	= __sbi_rfence_v01;
 		}
+		if ((sbi_spec_version >= sbi_mk_version(0, 3)) &&
+		    (sbi_probe_extension(SBI_EXT_SRST) > 0)) {
+			pr_info("SBI SRST extension detected\n");
+			pm_power_off = sbi_srst_power_off;
+			sbi_srst_reboot_nb.notifier_call = sbi_srst_reboot;
+			sbi_srst_reboot_nb.priority = 192;
+			register_restart_handler(&sbi_srst_reboot_nb);
+		}
 	} else {
 		__sbi_set_timer = __sbi_set_timer_v01;
 		__sbi_send_ipi	= __sbi_send_ipi_v01;
-- 
2.25.1

