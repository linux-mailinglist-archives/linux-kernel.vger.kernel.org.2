Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D89327DC3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 13:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbhCAMAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 07:00:16 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:15098 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbhCAMAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 07:00:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614600008; x=1646136008;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=MmOfVbyBMNouM0u0R5TqshV/taZnLCuuS7KZ80fyvsQ=;
  b=ocZI/MYUFeH9Y0TUhOsRPgqC9SK8cayqLh9jECO636UnMcxrJ0nGr5lI
   th4s+8q5I+OQiFf0lwfMDi+68QFH9jV6mDR4X8ud9zgnhwIVShX0lQlLT
   ps5JQjNc+AQjnXNQSmdKyFI9zv0ia4cKigWjZRGcobOHD4IlvTYf9DZzS
   epvGliKtyHHWknTWvuJh4u/aYqTcETDtJgxwxBhH2JhnvO/Okn+uoznMw
   3p330ZORtkb/UV65t9KvByAirgN37mdi3cUiueGX/5F5EnJfoWtCCXARY
   NIqg4XHjwemJQzyZhizz4RE6yro7pEI/PadM7xfK6chbUjriJLdaXVsLk
   g==;
IronPort-SDR: TqZ63/8i48z26AJOWZPWQ4q9dHhj+aNXaZNff7UgImjJArvrJBy0YLxOsu9kdRKYTWJsyUsIhm
 A/jzdBUXQOMGW7nzm5LUHhyqLPZmZCG3kgKm0biWESpc1p9z+iPvCAZcjiCDwUz6uhA4ikeWbD
 72RraVVXzs5B9S31E88hlxnsrXtMOipmm0wXOB7zyVTTHpmvaCUkdyUDFNPSxjXP/aIjRlcbet
 R8FDeZ79BoI/3+4PaKqzGxU0gHnft3BLR3nF0S00V7SJVgxtAY5RueV6HbMHTurw/7FXf6onBF
 Rrw=
X-IronPort-AV: E=Sophos;i="5.81,215,1610380800"; 
   d="scan'208";a="271656927"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2021 19:59:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgIVVUPzEv2EDPkMlvX+WVC2sVdZfrq8aEGDGlOLw+aw0mYgfU2wGf15tzz713KiLlu8ui2B+5ZdqvQZT8aQsiidB3L3IDbWekMz94MHNb5dBL/E1JdYFsXwaBc6IqbxWt24demE5cJ/mk/fYiNRG+kwbgufNdDQW8+Ep7mFekDWXuImlxltM8mn43TgIyWFaPu9ph8GjxcYkhAB10Dk8o6PJMDc9d9u6PLBxUwIZryMGNQZx0f303bJK0Ws2BbIQtZvbG2d8NMgC5VorzMLQzso79IL6enydz0ZOaEjx09XV/D7otRJ1iW79hy8KGiYYD8Oe5MzEVYTu1bSufBi1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGxkxvvXkkIvji7ApwCtffWmhzeE5KjyCaZYElDEak0=;
 b=UABiYNowf7tkPshk8nzTKNnNqhinAfCg/n4o8PIKt0MaSo7UzKkqe9SQjhWY0G4m2SdKr09eay3a4MI2Evaixkp967kVrw0SegMHUr09M5s/kf6zBNV0SbDantPsWm2+RyjiTSlmPwGMfHi0eac+4klKLGZwiwQrxj8WbkNmO3E5m2UIa/YBck8xCOzRKyL72dVE8XUUJpE8LqFpBYkX0gjEGuwWIrJV98+4lcc/eeWmj0ejYaPWgudB6dbJiTMykqWVjfoU+0c48AtrgHmQQJ89bdFU7sh5tUwB/y4zo13MY2qixu0nZZvtIuDjG7misbk/Tm8F5KakcbC8KUcXvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGxkxvvXkkIvji7ApwCtffWmhzeE5KjyCaZYElDEak0=;
 b=FULwKc+CwF0wNhUGUbEymSCX1/RZ5DYU20qi9fDqL5QR7gP5YpOvC5r0ZTW196K0HhlGLz6mZSVAaowHW8n/jcW4576ptqajnmQ4EZw5sYhB1Le+FDNFiNpozFWzvUK2fi2g3Qg79N8hUc+p8iKA2mKVUGKgM+YnXBXikv4NapE=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB5835.namprd04.prod.outlook.com (2603:10b6:5:163::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Mon, 1 Mar
 2021 11:58:59 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868%7]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 11:58:59 +0000
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
Subject: [PATCH v4] RISC-V: Use SBI SRST extension when available
Date:   Mon,  1 Mar 2021 17:28:33 +0530
Message-Id: <20210301115833.382364-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.171.192.176]
X-ClientProxiedBy: MAXPR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::21) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.171.192.176) by MAXPR01CA0079.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Mon, 1 Mar 2021 11:58:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d34d5cd8-e7c6-4209-bd62-08d8dca965d6
X-MS-TrafficTypeDiagnostic: DM6PR04MB5835:
X-MS-Exchange-MinimumUrlDomainAge: github.com#4892
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB58358691CB05D77B530F97A58D9A9@DM6PR04MB5835.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AuSChSA5aF3l7luwbakoZotNdx16lcRVgf2visLZENmuwQWbbKRZQc3PB7IeRTh57vRNeXl7YyvwxF5lsep9Ot0a8rmfzENj8isW8Ru3C4T9cCnUbkwguHEKBvvCaPI+5YYD1kozmbkEJoUKUudzjXehB+zVAAU7nnuw7oYCk17QsHq36MVPeSK2SqBzXaDxqaUPeb75me6DWPxYtbWuhjNH/qkw7NlnyxK9zb53/zkLiMjC42acYwxc9HNG/oCtHHlvY/ay9HUtEhgQJBpo0nLm+5R/IDit1mpcqjCe4tO5s311jk6mE/9AgwUGXuPg1Hfv01jHj4vO8AsXRxJJLoi8VFGEI0y524pGhNkXm1D3LGqFETHQqcmwt3NoDuWN480ln7LdQffx6ky6cl+xVfl2TiOWDNOKPNZLS2DJdJWbt57IINsJi/9R9DjUkP/OnKnuumR8DbFnf59p4GGirKdjjwNxLAbXcTzlRQr1ti+mR47dSUIIjiCGjlq148VcxLNwCf7xbFmJFbUAu65DfZ9BXst/qlHI9QbELBKm0R45T/Tl9GOVouH7a+fVQab/6V9QYmbN+VHr0FDlXc+nOp+qlt9px8ETVDzQvq8XTuM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(110136005)(478600001)(8936002)(54906003)(8676002)(5660300002)(316002)(36756003)(52116002)(966005)(83380400001)(26005)(16526019)(86362001)(44832011)(186003)(7696005)(956004)(4326008)(1076003)(55016002)(2616005)(66556008)(6666004)(66946007)(66476007)(2906002)(8886007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?c5wCc/x3rrQbK9/X19ReP6ApZGLIrOceNXzhWgybl/5mPetZ/eah+Nn4zisK?=
 =?us-ascii?Q?b5NUFUq4cjeR5FaXNBLHyIduyoFXMFDO3DhW5XlP6EN6reRAM9C95zPh/If/?=
 =?us-ascii?Q?+YWD9s7z4irgoD4Pu++lvo+6JzHcETjFDMgNaU8j5QrffCRIsYOpaAbsGkMB?=
 =?us-ascii?Q?UVeT3P/j3/yCQCMPnJsPHp7YwE6VhlGMOE707+z7Q5trYb63QI+mD6LQ0iHT?=
 =?us-ascii?Q?k8mFWTeDVIHRzXo0UjelcXPIylWYXoq8Ckib82t1gxkh6UjKUzBTGtq1byA+?=
 =?us-ascii?Q?kSReGhtFiFdg3JnArAFF70wfEZmj1zwHMaS8jvNKlWTQ2+NPJyWfzUMmb5mG?=
 =?us-ascii?Q?cFB58yMK1vjLkSchoUwlRArWiVcY+FO6lnvy1c2/DlVAsKHKpmHfnHWCa2gX?=
 =?us-ascii?Q?Er+4YeAZCxwp+4n10vjksUmXgLvvaAVvGULw2gZVtIps5VcXHNladaw4w8Bc?=
 =?us-ascii?Q?I8+57iEX4q0BtH9c1CGU2SIAuGyeKy1nPo/GMb1n9PmxSiTQTGeqgOWnWjEP?=
 =?us-ascii?Q?pLk2hjbbf/blvWWtQatVIzhPw/KI0DUHltPMvMW3lxcPzGjwakd40gXPtb8F?=
 =?us-ascii?Q?sd2iPQOl9PoGt+i9TPwNtu5ixSWSLWEu6NdBLf81EULbTrQHJGXy3TEJGB7n?=
 =?us-ascii?Q?KZiUUudyl/8zZiQpV5lUEMBTt4dJgux+aNlAqwvZjBsweCLZSNxKei4BB86f?=
 =?us-ascii?Q?qxpWouz4e/aNYfJMtLRhCZQlbjbVEjL0lo0btcV+RRToyLv/AqryOLXM3m8z?=
 =?us-ascii?Q?VoDAf7CfkbgkaVkBLOmlna7c2yIDCjZ/7flgGcAgEZ35KvNV5QUmxzE0xGxi?=
 =?us-ascii?Q?qPhCfUiKS1cOJmpv8OkUC/S/NpfKu7/S3cNnotXYPXRkr+PfCC7yBQaxd80P?=
 =?us-ascii?Q?pVV2oTNaLDCyZfL8UG3RRzZiH/zZsuoLICSGIWVr6nwUXBzNI8nVeHrFrafI?=
 =?us-ascii?Q?37weT1zfST6QraAKMYB/uOaNI1GzJcWlSGoVO2cyJYDSXTGxgpyUf4UXtWAM?=
 =?us-ascii?Q?g2AnopZ+znix35Ee7G3+OvU5eMPNOqg9rvOoeOsWXIVf0Uc1TEeRFZuo040v?=
 =?us-ascii?Q?UgwwnU1QAW7n+7raEvv/Kizl/dOO1JYHpROeWjVMoAli87GYogQhH5INapJT?=
 =?us-ascii?Q?XFit0W/ATe3PCW8/6dr0d5V/p7zYOtuW05jmbrx1JlaCf2xZcL5GS2xrhGLF?=
 =?us-ascii?Q?g6yrZnE5wfLsuazATIp3/IIxKbaWP/zyz0Xchx96W0WUB2Bol0Bcwkdo/Iwk?=
 =?us-ascii?Q?FOMxfZRVyo4t1AsfWR81Njru6TrQRmJn07R6TWyOWg14NVtKyhpJLTnxaPqZ?=
 =?us-ascii?Q?AdabtFZNmGDje9LvNdPmVJ7r?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d34d5cd8-e7c6-4209-bd62-08d8dca965d6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 11:58:59.1079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: idCp7LXoVPRmtJbbwNU7OL/xSwTV9F0zk9j0a5DtD9x9bJnMNW7yQ2LIzisBejl3qqipmiA7QaKEqSyfXj0y6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5835
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
---
 arch/riscv/include/asm/sbi.h | 16 ++++++++++++++
 arch/riscv/kernel/sbi.c      | 41 +++++++++++++++++++++++++++++++++---
 2 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 99895d9c3bdd..8add0209c9c7 100644
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
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index f4a7db3d309e..49155588e56c 100644
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
+		if (sbi_probe_extension(SBI_EXT_SRST) > 0 &&
+		    sbi_minor_version() >= 3) {
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

