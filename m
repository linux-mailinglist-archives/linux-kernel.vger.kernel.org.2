Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE963ACB34
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbhFRMmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:42:21 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59264 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbhFRMmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624020004; x=1655556004;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=c8/hbVoTzSjTBkRASUPN42Zq6fdqrTRmRNdTUO0cOSo=;
  b=Yg6+uqxLcB1w2ELXifLoztDZpE7uDhKSHzBj7Bu4H5SgfJqNPFkf9yST
   HmeuThgqsY31qHYEjBfO49JQ4xn6w5eLvxrzn1fyUR+UPX6xu1mnGxuwB
   zcCpZIb9BXugopxfQRVW3eG0H34FWfoE7SBMpR7iorlGFDOJg/tTCmae9
   /m9teq8XTvasp0bYnVTW/EQFaVEG+gsK0f069K5H0Ts53YAY4IxSJHxvZ
   6aQmCnYortbHsieuwzvXfif8eXSyXw+JkNJ2+JlTR0YPEmrDLjvowja12
   twnPzrWQbWtXCE6t8Ii0YrTug0flT+1uxk4//mDrxT8IHiOsAhNRb8NUm
   A==;
IronPort-SDR: v7FDZHz+Mtb/p9F4I2KQIHTiI8MW0MIPtPBk9/vwjpqkEFKOMhXCt6wPjR6bj3/upLaK6RrKsg
 roReHHfc+JK6p7gsTybb0DXcvsqZ38gN1qcwPxlQjRCusRN9eqVSkJN0tTgLEAzYhTD8Vy0yQe
 BGqXAAGL83mTUqiTxMZisb+vwjSxX7bXU5Fdg2hDQRMTrcgseyYfTk5ZbrlGg8Kvh7n9A10kSt
 dTo7U20oUeoy0ZwQH/JF59mniQTTfhumWt5bN37XlO3m2yehiErr7nH8kVTczp2HMyMfyFPqc+
 jgk=
X-IronPort-AV: E=Sophos;i="5.83,283,1616428800"; 
   d="scan'208";a="171563529"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2021 20:40:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4w3KpkEzskNbb4tUix+RnVjJDdxM0UIIXR5QKhxG+/7zwA57UHxocHPzp7ujvWw3n5MlAEWE38tf9k3FLhFnIvmKc6mABZ3zzRqUcrouj00MuGT5HzcrO6dKS9hl8fn9O+pCbkUq0iUThZDPkAfJ7uNkPcgFekTKAdAPdrSac2NREvW8dhaLrgChLmJUThu+AC1mkVQo5TqDmCP93ZmTu5h8JTMCw3GISTSJhw8ApZ40sYgnm4PWTU/tVD9N+2nfnJk9GNJ0cLK30wykNV/ULtVWvaES+UV2ihm+XBTHghLYpC/2OdGslRsl2tp4N1/LiJaEsS3reiZ9HSBdNcZJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkIF8ZYp+p1N5WGgy3ELu0b50Hty/aCwdTSyvtKemWU=;
 b=c5CBaU2n/aypjQ8kD39s3zBhzPDTlv8uAjjfm3acH/q7x5+Y37pvu2IDFVpFZsieqpOk1l/cHjee/ls5u262wYxb2lwr63IvIrnZs8rPnnLxENY/SvgIwXYmXKS8f8Z6AIAglwKbdzBFBxw5VwtB+bXaboJRyx8ko6yJl6+KxuXaRvvq16g0LqjJMOl9L7mRKIRJwENyrGwYNoQ63u6wI0RwduCkcQ/mBrRjrrOofFBD8tciS3j3jbSPWyhrRvVZVVdcG32A8qeeXSTBCbZORDjw/ghNm1sxq94Ha9ew9CXwzyriMNZ5jTUWwbJqY5L4FHZYjeeSW9XzArZzceCQfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkIF8ZYp+p1N5WGgy3ELu0b50Hty/aCwdTSyvtKemWU=;
 b=FY3aOjnZm+EBrHlzUBwDgZ/jPg3URxDq8IgYTAevTjBnoGb/R3IpBFL90Kd1O0YSep0x8JyZxv8NKYm9XcIFxNfHiCVpi/etvT2B0aYnU5LXVNob9jk+0hSfG8zQeU5w08v4jlh/nVaLdwNHfemAJEF68XueaRCYjG95SzsZZBI=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7857.namprd04.prod.outlook.com (2603:10b6:5:35f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Fri, 18 Jun
 2021 12:40:01 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%9]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 12:40:01 +0000
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
Subject: [RFC PATCH v2 10/11] clocksource: clint: Add support for ACLINT MTIMER device
Date:   Fri, 18 Jun 2021 18:08:50 +0530
Message-Id: <20210618123851.1344518-11-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210618123851.1344518-1-anup.patel@wdc.com>
References: <20210618123851.1344518-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.171.164.186]
X-ClientProxiedBy: MA1PR0101CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::11) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.171.164.186) by MA1PR0101CA0025.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend Transport; Fri, 18 Jun 2021 12:39:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4618a406-46f4-4fbe-87c8-08d932563069
X-MS-TrafficTypeDiagnostic: CO6PR04MB7857:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB78573FCCFBA42441F819F34E8D0D9@CO6PR04MB7857.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pXSormVHrk/MSPEiAQ8Wy13b/uu2ik7PK8WMZz0H8BzFT5OoXRLtOAIg0XK950WU4d5H9Wq4ypR6zpO+Z9/YHCjy9GoiU+Jwq66UQWg9EG3vgBg7Duno/KB4EtgJ+4+PmIH/cXX6U5jrK/zH+xVwgGjS9/bJri95rykWH2XbgXpn8UBs6hJi/zES/fL4m9DrpRJXkS3jc7BczoJd0DzB7xjoyJMf6PILRB/bTVSliZ7oc35AM3RJRqKPBJzIHs2xx66S/k/pKnmj5BrTWBT41Fat4B7givdFfObPaMY7B9J6YbumZThGaoxcB0ZDGPc7KBemKJXFSEVHXJdyhjavfnkjpPp9QgiAPSlOkFEf+hrnelreAHhdvjS/b8r6UQoXMPmbGfnrd3SB0MWx4bXAkp8NbRahAHdS++qXsZ7XagatkI7eptWAwhvLluRokiLjcvNtFMXx//t5U7kS8SIeETGOnwHuJie92twcfnHYkMXs+/CnHe2N3lAFd4TZZBnVnexrBC3hQXDJ34b3bKRlC9q0YvMQcMwFv/26VqZzTFDklfAx8kiuUs+7UexOr/oxmgEKOeAI9nVueB6ul60w/JVdgU+OxIsnR4GQwvBD4XftaGlaCNevcEpA8FbmPPjgEkNRww+bqBfDAqn/Bf2Fcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39850400004)(376002)(136003)(956004)(2906002)(478600001)(316002)(86362001)(52116002)(8936002)(44832011)(2616005)(8676002)(4326008)(186003)(36756003)(5660300002)(55016002)(83380400001)(6666004)(7416002)(7696005)(110136005)(66556008)(54906003)(66476007)(66946007)(8886007)(38100700002)(1076003)(38350700002)(26005)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DUe/4wu3OnUVtvsarVzxgL8+DfhZ4JmID2/Q4zBiqQpCnBQ0xHJCBLDvrpl1?=
 =?us-ascii?Q?O59EgaVb9tgKt/pVweRfVfZjGW8O1dyhTpHRPzR9Dqj15TZEz0b3FFgiu7FY?=
 =?us-ascii?Q?P6rLxFXAIuGIRlnwk01B7ao//cuVmwHf8R+iGFjbZRwCpGpVzmr8Rk5hH1XW?=
 =?us-ascii?Q?Hn4O7wzAC6qwENDs3mq4y5Ylil+hRmJnUJqDtwCEswN8WkvMW5EbKjFgJG3R?=
 =?us-ascii?Q?mrHNNGuemmmCULiILyDxBRkxJ7b5uW6EMTmuUzpigBiJU/O4QJcUf2qYuMpu?=
 =?us-ascii?Q?H+l71iniBk6wMkioxhhdM6neHlVYr6fnp2QdNr3nmPgks9wrkvCKCHBmdNVH?=
 =?us-ascii?Q?JNCwsiHicMTCKK+onUT9W6fOHIkib8m4PEJG/rx91Kcup7X9+gkr92uZ4Znn?=
 =?us-ascii?Q?8fGFJcC5j0LajZ353B1BxKRXdT83Ls6Lh8dSKzh7sgoXkQHijMHX0GwERYuh?=
 =?us-ascii?Q?eQGXoWkUa3zrVT4altmc0sbva/nS3kOUE2cnaVcHbLEbpIeEciYcrueHap8x?=
 =?us-ascii?Q?JcArmxgX7H9shYVzVI8q0fjmTbwWDbjQ7F6kYtpmT5LEHXYwYfP9CkUj0IFr?=
 =?us-ascii?Q?o3h6pHjZGEM4VWll9gaPWmX2HZ1sSwT+9AY7+8+s9KH+S+kAQmKYAgT1z5sz?=
 =?us-ascii?Q?8uHSptJ0mbhtdLcCIDP1kZIz3+hmTIo+AAH6fW1C0k4wKsePM7DZvcDXOfJB?=
 =?us-ascii?Q?0+b8TN54EsUiPvDGHBFMc/rLK03EZ5T5/fY4BxrrvhJ9ls61Hfh6rLocK339?=
 =?us-ascii?Q?nuqYxrB4H6HhkWD9gWIx+adBbs1XZ00leqDr9QvnoSblDDIXO0fkWmbH/15Y?=
 =?us-ascii?Q?zpsU7b0YxWQzKhENgQp71eZcxYMGGlMaAFlOePqx72RW5IBTvUJ2ETflMvT8?=
 =?us-ascii?Q?pyMK2g7mafMIM0SetBsLzzHw/JVa97WbKnOyfAR7xgWZo8bSrBpgh1HJ4+ze?=
 =?us-ascii?Q?FaZtUkmBrK68QwdHQtsuw+ZkWgCTsGKTaKl05yB5ly1mE44WZeeGYEzsLF/c?=
 =?us-ascii?Q?dqfFoRZO3U5SE2HWBNrFH1Rm/M5Kv9Cm6iMRUPW4EcxtQKsUwdQbCMsYpH14?=
 =?us-ascii?Q?/77RSZWN533oxxeB6UTnt9/e5cV/+362BY1UhQo5kG+DlGGAuwBBxCbg2XSU?=
 =?us-ascii?Q?VDez8LS53u9NG3zdzPz4OnMIoOzdJ2knKK1HBbGllHkPEyOI2f29hQ7zser7?=
 =?us-ascii?Q?0l3S1WtdpKuTFYEKp2yBFdV09Cr5nSgwDkWEfAV6+YGT0UDD6exYpIY/FLSj?=
 =?us-ascii?Q?b85+kY5/ngOOFz6YmkJAMxjeC1Sh5WWctFFXo6lLTsbK/h/73v1SaU042AXU?=
 =?us-ascii?Q?OgFGqrGOEiVTfilKTA2FUuj2?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4618a406-46f4-4fbe-87c8-08d932563069
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 12:40:01.1977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9c7UUw8W1i7X4mPH5CGWasMZuuI3LproeBW1Psx4x/nyJyNJmr7d4kE85QD4RDaYeXT43rMG8xsLwsSTCQgJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7857
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
 drivers/clocksource/timer-clint.c | 35 ++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
index 3b68ed53fe4a..bf89744cd12a 100644
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
@@ -21,25 +29,26 @@
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
 #define CLINT_TIMER_CMP_OFF	0x4000
 #define CLINT_TIMER_VAL_OFF	0xbff8
 
+#define ACLINT_MTIMER_CMP_OFF	0x0000
+#define ACLINT_MTIMER_VAL_OFF	0x7ff8
+
 /* CLINT manages IPI and Timer for RISC-V M-mode  */
 static u64 __iomem *clint_timer_cmp;
 static u64 __iomem *clint_timer_val;
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
@@ -170,8 +179,13 @@ static int __init clint_timer_init_dt(struct device_node *np)
 		return -ENODEV;
 	}
 
-	clint_timer_cmp = base + CLINT_TIMER_CMP_OFF;
-	clint_timer_val = base + CLINT_TIMER_VAL_OFF;
+	if (of_device_is_compatible(np, "riscv,aclint-mtimer")) {
+		clint_timer_cmp = base + ACLINT_MTIMER_CMP_OFF;
+		clint_timer_val = base + ACLINT_MTIMER_VAL_OFF;
+	} else {
+		clint_timer_cmp = base + CLINT_TIMER_CMP_OFF;
+		clint_timer_val = base + CLINT_TIMER_VAL_OFF;
+	}
 	clint_timer_freq = riscv_timebase;
 
 #ifdef CONFIG_RISCV_M_MODE
@@ -219,3 +233,4 @@ static int __init clint_timer_init_dt(struct device_node *np)
 
 TIMER_OF_DECLARE(clint_timer, "riscv,clint0", clint_timer_init_dt);
 TIMER_OF_DECLARE(clint_timer1, "sifive,clint0", clint_timer_init_dt);
+TIMER_OF_DECLARE(clint_timer2, "riscv,aclint-mtimer", clint_timer_init_dt);
-- 
2.25.1

