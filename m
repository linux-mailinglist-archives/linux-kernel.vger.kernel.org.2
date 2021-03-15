Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB2933B09D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 12:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhCOLGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 07:06:02 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:18328 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhCOLFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 07:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615806341; x=1647342341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=VZDGJHELxc/n0w1YeJQb8xI0tWC1a0JU7XIaRnsnBE0=;
  b=pMqmJpNNdNaPROu7CtOmROk5CqbZsUbnYV7U+ckIraj3oY6SPXS8EALD
   9orQyiJC8L8S0S2Zurd//yRGbNXUAox6Akq2Z0v2+xFwQsOkwl7TZtx8a
   pdeI+zkVtFCa0cWeyKN1AVefGLO4mF6BjVcroXE9t/8nJDvwl1QK+pSmQ
   29gRRAfWCbHJv+BRgG3Nbrx5UvvHG/b9mdlopR3gsB33deJidGGaTsVD6
   yITy1VVZreIP6t/Aiv4P4XQ4cyIGddYOlw040dQBdkodXE7mWiGI1dq4k
   uSyxFVC2VC2bptlr0G/8O4RM+rdrAc02DLA6L2e5j01+YAu0fgcjb3qlC
   w==;
IronPort-SDR: 1riDs+MmEhEF8cpADASo5HQVptE/ZQSREWy/jLxM0u95G5xkHD2DmuDsmzYgDJHaDaALUL70C1
 psnvYOUo3nwPtbuzlOQZLKOXI900VI5ZV+VvdGWumAXimlC2kLRBioFL+eOsTiFLYlfw4Smf/9
 w5PmgzDmsbRRBCmqJ2eW5TUGAWBdYzzEjISuPRLk2Jx1sNZ1PObmBOMcoZj4qx07Brn+hcTyzP
 8m9RvuL+96tN598SoRljAJyMATaj6kk20qy0UBoLIERvzrO1YQ6abQ+H5GxKnh4W2x7cAAL3dQ
 PoU=
X-IronPort-AV: E=Sophos;i="5.81,249,1610380800"; 
   d="scan'208";a="272873360"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2021 19:05:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7QcwKAqXAUu07apqrPnb+NkZYaSPgHYmRbtS8t2Ves2/pmHB5JSzNN+toUHLfsBAbevMDQPLWpNn2rn0/hT0qwGm0fveSRDwD6BknwNR+EL2Or28BVXgOTYl7bTWOtyO/EYUDRHDb0crgsOnPab//gVaqWgUtdtKNEHHFj7JqLsw0xWtw2uoiQy1cfWmLcJVF3Utrq7EP+EbDNIJT4t2DrlnUqjXc6wCZRa+5fgPyTeS4hpuh3+3lngXGkYg8g2s9mmHMfA1G3k5bUqKX/2nN7W7FzwesEXJqQwbUZL4y/aaUxYzmq6lQshGdnJfRQz6uFe/BfH16tkl1UIAym7bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNZcfE0XdA5Ur+OaLCYm8cL6uqQSxV4+/W10Q491sQA=;
 b=VN16JMAKqLY4mCDrZmpWcwUROzPaVjHgmdwoCT7r/4GgbIYWxefI5me7Wo+n7GXHx62oB9hVIQKRiYe60yDKfkcwIsVYAPLgadJRFzRo2X3LcLcK2AO/mjeCfMqVm8udmHDH0zvMQiuLTwHYVmvIC5E4tCdBJs4lWW3t+c+nk+pMhyjaoOuGVbRkzJnnjPPVzP+vK4QXCbAN0PXpn4SdLYWy7TUkkdRGWUVZeNCig+lz0pzu7aMR4h2yneybV64fRi6uhTpwkUsoTitRbplKo0GoFo19T9J/FnxeJXtuee+4W0wHzxf6jeNLC4SOiBQMqIZ5ZXTkXa/EmJaI9R7Pfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNZcfE0XdA5Ur+OaLCYm8cL6uqQSxV4+/W10Q491sQA=;
 b=fUVsdz05grz7Bp/suGRaKYC+vWVZYHfmxAnE5TGif+YvmPsmeK7dM1S7UErohCpLSnXmaJp2FFD/lsk+CCv0zsCH9uXxxf3Ozm/sCI7veyWyLr6kIvc6bJh33QK8NK08lHrRfOxlXc1brYH+c1ahP4UGET4sqn2JtKckwsd1u0U=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB5547.namprd04.prod.outlook.com (2603:10b6:5:121::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 11:05:40 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 11:05:40 +0000
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
Subject: [PATCH v6 2/2] RISC-V: Use SBI SRST extension when available
Date:   Mon, 15 Mar 2021 16:35:00 +0530
Message-Id: <20210315110500.802897-3-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210315110500.802897-1-anup.patel@wdc.com>
References: <20210315110500.802897-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.167.33.244]
X-ClientProxiedBy: MAXPR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::15) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.167.33.244) by MAXPR01CA0097.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Mon, 15 Mar 2021 11:05:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0cf8705a-079e-487c-482a-08d8e7a244ea
X-MS-TrafficTypeDiagnostic: DM6PR04MB5547:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB55473BA03ACFC69F21BC1F8D8D6C9@DM6PR04MB5547.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KMi0gkjLZuSodfwKqNZdlJWgkgkiiT9VcBRT820h8h6dDegq9JrGP+hhbca7lixrzNpsLbE3dBfbmErRGI71kshMdD60Zs3aMBV97HUFXyN4FbBSeDLW6JekJ3S4YhG8Xg3gIGAhSjiB6QNevv4ZAhoQdd+woJWThJJQ2Jn003ouQp1oMECIuZ+J6cfgjbzT2wWX6AZ2db99apaRbuxJxpsBvkoGrDDJcf6qvoDf9Q0rhtPpZfcicWoTJf2we8JutTP71cfzS2d33qcsJTm9vyb+lJJPwk/J2H8ug4SHav77zwbha7u5N595ECP3k8WOwzYdxTS0heOxf/JM3VxMUjnV7YEBzyUqUpEWzCeyhCD9qHI1hk8W33cAYgg/CErMIbWCE+jOi2DgJYD9IWmcIIYXLsnB0sDz9+n5o9aA10JlvzhH4aqnyRoPrtxKcwYT7zaaIylpucoCM/A1E5mgVaNpLWIYZIIcB91hpX6rJeHDMholXconwuV7Ddq/RSouLYmZLOAT9KDQrRIo/oodzypql3JFocbh7b96COKFhioQ7IQHPAJYkrbZ6xepmP1Vuc/dyQqncLwvBxB5wG/uHMjYTVmTNVI/lE5e7Hb1dA22Y12kvvRnJobPY3ul+TPAI7wvHIPbytSvldryGl3swQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(52116002)(4326008)(5660300002)(2906002)(8886007)(83380400001)(66556008)(966005)(66476007)(86362001)(54906003)(956004)(478600001)(2616005)(316002)(110136005)(26005)(16526019)(186003)(1076003)(8676002)(7696005)(8936002)(6666004)(55016002)(44832011)(66946007)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?KsobzXqER6fDih9ho7sGjT0o4qaeLkByV6RzoM56n0OFZPcbno0Vphc4WmnJ?=
 =?us-ascii?Q?ilJpPx8/Hs9xCgrvnFUiT/ssx8DdaCIimIBNo2itK8PL6EXQDkwd76vcHhZp?=
 =?us-ascii?Q?4cTv2PFBcO+YfnMnVGQRIsLQPbH7WQuqvz3D3NU5uQC2IvRiFX/ne++QOxVx?=
 =?us-ascii?Q?Kja5H6yfYZcPC9Yle5bY5RKcW+IW5Q333SKussjiPuE6Wc/6wr9MXEb/FjVM?=
 =?us-ascii?Q?PdsQ/zZ9Dg7PUbhOkip7r2PI4F+Xs5zqqn9OmCHzG8tyN6dbe0c8r1yvm/lJ?=
 =?us-ascii?Q?RwUh7rzEJp4XhQuaGP4axsz8/gjqVcQWLmlzi/8/1wwu2p+oXVKL1wPLq+wX?=
 =?us-ascii?Q?+vbXE0qWDH0OSMYTu4ccjuj0BzfJ5HL/ewp/YdY0dMNHYuxRvBHuU0BZprVX?=
 =?us-ascii?Q?QDo7KqFcc7t0bJ7Kogp4dcI1CWuEWVjfId+PIsY70LEri7gEgDi6JiY6s+Yy?=
 =?us-ascii?Q?FhIzW2RbRp3YllOb8whmL4khQUH3lKRoTOXz+uXEpXLBUdADi7/sCiQUQ29q?=
 =?us-ascii?Q?kq+pgCJ0uveMScgfXY0csMw9C115Y4BnAVfCXGCbPLlmycMpbDtBsWU3+AGc?=
 =?us-ascii?Q?MAOa5Ik0jAPrVfsNf3S2zQWMuQaxJmNMBWc+eBqvCFpQJpe8yhoUDM165Ieh?=
 =?us-ascii?Q?KMP/3tcfQS8Ze9NSQ5CjlFXYixgH1Ew7NC3+gewe50WTUHg8YT+A6oUqFiEU?=
 =?us-ascii?Q?N7LYup3dIIEb3FLrcvH569ykiJrEpSId3gXE6Hiuw5LJLzij3luEl/BVI+Fj?=
 =?us-ascii?Q?cshPzOhIAOR8vW+XrsmpapzVdIYlEfdzMk9Uvh5laVPZnN96YYGQGKh2btzd?=
 =?us-ascii?Q?B+0xHeYmQ3cdBGS0NTnxYmpUJXWr4F+gt7bh/3i6DuvO8e8yRjH+3t/ueSEG?=
 =?us-ascii?Q?y73tk7GI5IOVQbA0oEwWS94yANr0m5rgvwx0+Df78VhdU4EohmP2OBKvW+17?=
 =?us-ascii?Q?WVH++i0dQo9+7sZm4rxkd5C3gOzUXo97rWOVlTsYi2rFiPK9cidg+gF4OK12?=
 =?us-ascii?Q?wKyLAqtrZEMcLz6ZUP769IEWtJ1qxqeMNklWo6ICT7psVhbwTYTPMCrEfq01?=
 =?us-ascii?Q?0niCkjYdn7cN0ecP7ss9w4ABrZSQgelRL/rzM7jGDOI79l/sMdVJLxTkr1Hp?=
 =?us-ascii?Q?kVU2ztAroEvnPE2a1hV+LCdzUVl0qLr+yUzaxEBDPFCrNk69TRO/nCeL3jBY?=
 =?us-ascii?Q?HuqTVM0MIpiAllJRnV2O+lcwA002UlXoYVx8MZpkSH1r9tBt/ba5AGrF6NU0?=
 =?us-ascii?Q?vl6EhLEr++jqePQQG4dnYZfd3iQMhB7TdlMOxVkVRRqG5YLTq2rE3OwakUwC?=
 =?us-ascii?Q?VHjt4ORgbGpoeV9MaLO8qyYO?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf8705a-079e-487c-482a-08d8e7a244ea
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 11:05:40.1866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhyQPNgM7eeCVCZeyeRRHwUD3L2lyFflyUKc/AOaneYBN8KNeiFMvuyM2EnbMVHsCVBcmfgTvl8VfpVrpMgJaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5547
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
 arch/riscv/include/asm/sbi.h | 24 ++++++++++++++++++++++++
 arch/riscv/kernel/sbi.c      | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

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
index c0dcebdd30ec..e94ea8053984 100644
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
@@ -593,6 +620,14 @@ void __init sbi_init(void)
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

