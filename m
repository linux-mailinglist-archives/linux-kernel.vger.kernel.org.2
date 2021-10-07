Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F31425345
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 14:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241552AbhJGMkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 08:40:05 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:50995 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241548AbhJGMji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633610264; x=1665146264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=YI6W+/n9aAzWP4LzqzPEHrZxCONtaCdEtKPj+E5HvVI=;
  b=gpgllw+gTkPbuvMVyWRH1LBJrQb/vVPeD20N19iZ6cbUDlQd3Ugx3rYL
   wKjAYspXEDh7vp62CsqcMa6I9ZspOHKOYrL96/ejSVZn0UoBfmiFt9z4o
   VEGcG3jZXDBc9shKj1aG7cPu6B4LUsJp9ZAQe4hMy2Qpz06vqJwWxs2UW
   18UYynWjQ39ddDYGWBLvNMBGzEMr8F9LDefgYjhR6xHfsnZrOeD5DKbD8
   nY9zt3fNiSTTBjcpxifusIHOs5M9rkZFWxNMKj9BXZDZMTQd0HaJJNn3B
   /2Trc9iDciLKGyEXTvQDrNZBtBz4wnae8RRhdArw8yFQmbdCumOR+/ttO
   g==;
X-IronPort-AV: E=Sophos;i="5.85,354,1624291200"; 
   d="scan'208";a="186926274"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2021 20:37:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAicOrwxGWcHSzKol4F0euGjGPEAdzSU4O4BOucK5DJni88lqexxeleuYaXsN6WvpcfCFuvR+nthdQavHDrENpXJPaewdjYad82pMrQfCusA5kGs+moudb+9kO+owk0JNAUJgBNA1ursWjCEuRIsu9gxEhbeOzxy/mVOwq7U08bFnFVj5cXObAAKYpWy9/8K7z1K5osnq7GBv4b+Zap1JrNnIP3PwibHBo/M1l/KlE7bgiZ8tTeT3dX9uqeYhnwq1k4hyxs4hAbV3RlHGoZ2x29rqkw18vcmI+hNpVE99/Y14mjVxU5Xsej4tHLp5Oq9BPvDzHaaF3BT5abCGFkqYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEv5oCfdSg/2nOVTlC7u6t7+ljXv5IBn9INTVEpyUxc=;
 b=ZFs3E87bihOo+6JCyDoWvDu43qt8uBQXuATpoHpB0xAnhFJRY6At4LlWpJmmBA0DlXmtCS09GLwIBP8WEjlBP6HnWFt7PzDD0xCemdydYAXWg/8wVwbTR2EVeT7mYlGwIV+Ti2sovt9cVxDV9u1KS4hkSl2hcOSj2rzlJnFfvmkTMF7OqcjpAy3gsqzwxmUogdPZTv4VMdx8kgLT2JyCTBb0c+Rfqr6Uv0XmplOEI6TE+ALsJf9JtgrZFhjz/Tz85gYW8+0u+9rNQ0mA0wQ3ldfrOzMZc0xQtoGviL1tjBwuTV8A/1xlTPxlnntiS/otNyxerewT3ExYv9GzITYHJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEv5oCfdSg/2nOVTlC7u6t7+ljXv5IBn9INTVEpyUxc=;
 b=sk77PDGIw/JcY93KfyjxaayZeadZL423wLl2iNq6YZZChyGYvJRWN0b9QhcZ5as0wKNOp0uVq+RiW0qzFNfNfIiGAzUqIyDdRvlZFrLvAfPvu4rpbDUoBGRywM5nwxyP6WBbC3DCPPDIu4DEgGAd2TVgsEd3X1T7arClBxiftJU=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7892.namprd04.prod.outlook.com (2603:10b6:303:13a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 7 Oct
 2021 12:37:34 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97%9]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 12:37:34 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <anup.patel@wdc.com>,
        Bin Meng <bmeng.cn@gmail.com>
Subject: [RFC PATCH v4 09/10] clocksource: clint: Add support for ACLINT MTIMER device
Date:   Thu,  7 Oct 2021 18:06:31 +0530
Message-Id: <20211007123632.697666-10-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211007123632.697666-1-anup.patel@wdc.com>
References: <20211007123632.697666-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::31) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
Received: from wdc.com (171.61.64.222) by MAXPR0101CA0045.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Thu, 7 Oct 2021 12:37:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3b128a6-2954-48d7-6268-08d9898f3cf4
X-MS-TrafficTypeDiagnostic: CO6PR04MB7892:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB78924A35D4BCCE05784E2F058DB19@CO6PR04MB7892.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZwI8PB7wPyoNzkySgRx7XX9UIcm/tXGyav7ivhMV6ilKcAPfSH71LQfSrrvBB0DZQS5OygvAGayE7Eid0e0j6qFjYqu0X1x0d0gQZvk6xO5hGnZ/GX1vB1cy4mEIf07D8cLuONt0JIzXOlGFoID3hacDk6r0uKSO1JoIh5Z8KA7L83cyOLNeMUcfHGvfMjKiSpcdDIWoyvqQD7GQZSsYrDH3xAalWMvFy2Fby+j0bavleUdNHVA0RdVNSonTH9cSbWxEt5FKkQQJUL2HygQJ56Ko4HXihSK6D7VLc4iSH2YxV8Uv8CtjM5UajT3BBz5cYE/VFRbMGowJJ24nWAro8tnPkFkWGv3/lYG5dhRjr8avMYAHqmzywkpb8bU/RPFOdWk1SXo2uRva5mbqCKhkmU+IGVKkjax9/9YkxqO9SK/NElgP26ZvR3hdugXkBVsmV04bqAQs0H+K2Ot+Mw8n8Cdqb8/5JAVx4zZCle5rA/7He8U+x/IHM7LGWe9rlbrEBXtF31+4HqgQVr9qV+VgWQYQxr0FDk7tjKoDpqCL+MD5ar0vR7PhmO8yzxU15ZbdambIG2NJPD0HMdT2ysiTwiRM0cgY/kQqo3cmKnLFgbG2hqi0hXz/f9T69wXEoOCPPW0nXErJJshsGyH+2XlnMtz9rvsNpA37+aTzYVmt2LSAMuOCB6GBnSxGzlI62oheGjwrPCBD40TUq8TMA4EWAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(5660300002)(8676002)(110136005)(316002)(8936002)(508600001)(8886007)(4326008)(36756003)(186003)(26005)(2906002)(38100700002)(66946007)(44832011)(1076003)(55016002)(956004)(2616005)(52116002)(66476007)(66556008)(7696005)(83380400001)(7416002)(86362001)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XNGiyyP1h5bEmdMxOB0mxI+zGM6GwG/6iIBKLu65KORRQwxu8Cz3u0UosqvJ?=
 =?us-ascii?Q?BmluJADH0NyZ84e6pmpkGK68o+2vGHK5wjjjbMk7V2JDDWrvFw7YGxAuMLkQ?=
 =?us-ascii?Q?UetfyZP3WhokiMXANUG+4mNKy3Qj5XF1bxxMTqADWKmd35qRwhry0vh+1jKX?=
 =?us-ascii?Q?2dl0MvYeyEn53hfuwbnOzsRWToyXuNmmju32WZ8QZabBGhY8YRhntWp1dKK7?=
 =?us-ascii?Q?R5wOlI+TXkxwpa+V0ubJl+Wync3PvtTmGK5V4mAq8c7umbL03GfkeLsJPtv5?=
 =?us-ascii?Q?kwaSJS7iY55ap0GlJleHrzkh7RMPoO3KSxB07WggrTTRf/RgXwlYYEoSBQjn?=
 =?us-ascii?Q?sUSJfXLBMxXELG5EDnDKz7UjvcPAKoQ4mWofuDBmDdiOjy5YUbJh83kwVX3l?=
 =?us-ascii?Q?pE3eH/BCvaEy6Zrbid1GKcKexVnHXTF0oV+tDZaVcdys8iLNE6cO28TgSAzO?=
 =?us-ascii?Q?GZjrlcANrpSOJa48SLtDr8D1daIF4LiCjDKH2+WYvxNUJJI2r5poGU1z5CjM?=
 =?us-ascii?Q?ZStrnCbhU9itoNOWAqcd1n7r2BU3bk/bn2zz+n18YYdiAhMuaGEeqF9mYQBa?=
 =?us-ascii?Q?TmIkuQwJ5Zl2gu82U1TQHlTusaBCL7jTSHne4D1G1CEImkn67xmnkAC7mQ5N?=
 =?us-ascii?Q?qemyFHF4dho1iGuVL7mpbypoO+wjOhbUtK4KtsgaP9d3q+49QCR8uwQA52Cv?=
 =?us-ascii?Q?LeYfCejsgu7acW3NxvP8WxYRpaVKDyX2tA3ABmFknpJTJF9yEaskay/qDT7L?=
 =?us-ascii?Q?b7GCOM9Vea2AgQxt/9IE99zoTwc1NQI3a9xYchOe05OL8BIhbGwxnJ3Lz64T?=
 =?us-ascii?Q?OAWQGanlbrVgYpkfmCHMe6gleahKXZRV0IdeeEPdUKfjfjwoykOPZk2nem9t?=
 =?us-ascii?Q?vigYx0pWWz/my/VchO1cqGxxm4msdrnTP0q957cx7wfo0hsUCgpZEhr7ufhL?=
 =?us-ascii?Q?npd6RvykDr5qIKlkkZiFd0fH5e+swuwb6ISIQU98EaE680lr4ci0yVmhZpQG?=
 =?us-ascii?Q?FfX6izun8/K8hV5gek/N77t6qmO8Gb5CcAeHEwIhX00m7GbjUa9vFYPBmbBb?=
 =?us-ascii?Q?Wl66iJ8z4LU+PkY6rOoY+iZjCwiGf2Rdu7kR7frf6n44hyzmB76IWBC0CLLG?=
 =?us-ascii?Q?gqOVG3hg8kOGS3ZN2PYe/JcN0WxnwA+VeiEGrwDSdIO6od0B4fqKIkdT8q0u?=
 =?us-ascii?Q?CZKZPgt2K5T/d2tMazBTq+1h150eLgaprVhpi2CQrSaUbixXotoJu26LVyez?=
 =?us-ascii?Q?GQCkTdcLvuAzn+A/RZOkbmIdkh5OZ6aspF6mw0zjThnJrETbl2dda3WziYiR?=
 =?us-ascii?Q?Tmo2ftJT/kCtL+Ybo1vXL9nv?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b128a6-2954-48d7-6268-08d9898f3cf4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 12:37:34.6589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u/0sOhnm1cvHQMKKN4K0BwYA1lAmY6vVk09GHQTnK8GgDOH7SqkVajW4z2eLPUH7xdSMMlIEDt4Mlb9S+lJVCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7892
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISC-V ACLINT specification is a modular specification and the
ACLINT MTIMER device is backward compatible with the M-mode timer
functionality of the CLINT device. This patch extends the CLINT
timer driver to support both CLINT device and ACLINT MTIMER device.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---
 drivers/clocksource/timer-clint.c | 59 ++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 12 deletions(-)

diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
index 3b68ed53fe4a..9d38dfce374e 100644
--- a/drivers/clocksource/timer-clint.c
+++ b/drivers/clocksource/timer-clint.c
@@ -2,8 +2,16 @@
 /*
  * Copyright (C) 2020 Western Digital Corporation or its affiliates.
  *
- * Most of the M-mode (i.e. NoMMU) RISC-V systems usually have a
- * CLINT MMIO timer device.
+ * Most of the M-mode (i.e. NoMMU) RISC-V systems usually have a CLINT
+ * MMIO device which is a composite device capable of injecting M-mode
+ * software interrupts and M-mode timer interrupts.
+ *
+ * The RISC-V ACLINT specification is modular in nature and defines
+ * separate devices for M-mode software interrupt (MSWI), M-mode timer
+ * (MTIMER) and S-mode software interrupt (SSWI).
+ *
+ * This is a common timer driver for the CLINT device and the ACLINT
+ * MTIMER device.
  */
 
 #define pr_fmt(fmt) "clint: " fmt
@@ -17,12 +25,16 @@
 #include <linux/sched_clock.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/interrupt.h>
+#include <linux/irqchip/irq-riscv-aclint-swi.h>
 #include <linux/of_irq.h>
 #include <linux/smp.h>
 #include <linux/timex.h>
 
-#ifndef CONFIG_RISCV_M_MODE
+#ifdef CONFIG_RISCV_M_MODE
 #include <asm/clint.h>
+
+u64 __iomem *clint_time_val;
+EXPORT_SYMBOL(clint_time_val);
 #endif
 
 #define CLINT_IPI_OFF		0
@@ -35,11 +47,6 @@ static u64 __iomem *clint_timer_val;
 static unsigned long clint_timer_freq;
 static unsigned int clint_timer_irq;
 
-#ifdef CONFIG_RISCV_M_MODE
-u64 __iomem *clint_time_val;
-EXPORT_SYMBOL(clint_time_val);
-#endif
-
 #ifdef CONFIG_64BIT
 #define clint_get_cycles()	readq_relaxed(clint_timer_val)
 #else
@@ -129,8 +136,10 @@ static int __init clint_timer_init_dt(struct device_node *np)
 {
 	int rc;
 	u32 i, nr_irqs;
-	void __iomem *base;
+	void __iomem *base = NULL;
+	void __iomem *base1 = NULL;
 	struct of_phandle_args oirq;
+	bool is_aclint = of_device_is_compatible(np, "riscv,aclint-mtimer");
 
 	/*
 	 * Ensure that CLINT device interrupts are either RV_IRQ_TIMER or
@@ -170,8 +179,19 @@ static int __init clint_timer_init_dt(struct device_node *np)
 		return -ENODEV;
 	}
 
-	clint_timer_cmp = base + CLINT_TIMER_CMP_OFF;
-	clint_timer_val = base + CLINT_TIMER_VAL_OFF;
+	if (is_aclint) {
+		clint_timer_val = base;
+		base1 = of_iomap(np, 1);
+		if (!base1) {
+			rc = -ENODEV;
+			pr_err("%pOFP: could not map registers\n", np);
+			goto fail_iounmap;
+		}
+		clint_timer_cmp = base1;
+	} else {
+		clint_timer_cmp = base + CLINT_TIMER_CMP_OFF;
+		clint_timer_val = base + CLINT_TIMER_VAL_OFF;
+	}
 	clint_timer_freq = riscv_timebase;
 
 #ifdef CONFIG_RISCV_M_MODE
@@ -208,14 +228,29 @@ static int __init clint_timer_init_dt(struct device_node *np)
 		goto fail_free_irq;
 	}
 
+	if (!is_aclint) {
+		rc = aclint_swi_init(np, base + CLINT_IPI_OFF);
+		if (rc) {
+			pr_err("%pOFP: aclint swi init failed [%d]\n",
+			       np, rc);
+			goto fail_remove_cpuhp;
+		}
+	}
+
 	return 0;
 
+fail_remove_cpuhp:
+	cpuhp_remove_state(CPUHP_AP_CLINT_TIMER_STARTING);
 fail_free_irq:
 	free_irq(clint_timer_irq, &clint_clock_event);
 fail_iounmap:
-	iounmap(base);
+	if (base1)
+		iounmap(base1);
+	if (base)
+		iounmap(base);
 	return rc;
 }
 
 TIMER_OF_DECLARE(clint_timer, "riscv,clint0", clint_timer_init_dt);
 TIMER_OF_DECLARE(clint_timer1, "sifive,clint0", clint_timer_init_dt);
+TIMER_OF_DECLARE(clint_timer2, "riscv,aclint-mtimer", clint_timer_init_dt);
-- 
2.25.1

