Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F4A3C89F1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 19:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239811AbhGNRoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 13:44:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:52442 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239785AbhGNRo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 13:44:29 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16EHVMjB010037;
        Wed, 14 Jul 2021 17:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=p37Z0ywMrzFyDt6rFETqMFNF2UAZUrJTJ5D/Lf9Jms4=;
 b=IEINsmPpIRWTnOvbme/7eCtlh6KzpNnLK+uoTSSHpDzVTbZVJUwaP5foTxwq5tUN9Y5x
 S15dsww2iL3hoDTZVbqdFNsyghe5KKvGalPLzoNFKRKA8nArJtjhalSocAcPXYRXu+rp
 xrjgAO3QPS2jrfeYw7n62jJ4fCDxL2UA+IG7/u7uAaynP4EndUtUU9fN8ZS8Kua9jdmc
 3Mt0nn4tatO2coY+7LpPuPQsrN6+gWJdRLpUCjXq/2YxPZnSDXfMMN9SsJLB2Lk8+ZDv
 fgZ+Y7ng7KxDrVd920NUURY5Z5vnyeBJVqkKZFruCgQyBIIXlNnpFdulUgWqQyjvy9jJ lA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=p37Z0ywMrzFyDt6rFETqMFNF2UAZUrJTJ5D/Lf9Jms4=;
 b=rsGAogjjlZkQYeieZMyA+ilyb/1d9Oi32juFHWcIvZ39+IdA0qhP6S6pmlCtLYEwHsiS
 K3Vo2tSKDtVlUlfYuViwV+0jq9QI1W4+jSQ1T30nEtG2pDAXQ3TmnOm/20+E91AiILaE
 oP5ygT/A2B3pi5ZTLEIqRf+YYCHoCeHAIviLYqKxi3X11g3rGIht8IxzOVm30k/9rTk/
 6c7b3KYeG+F/9I400JBoxTF1Qf+gtUkoWC1vr2r5WcaV+O0hLaZWapBQ2we3QQHq8YQZ
 4y/yk6jSVBmWRrrW0Gb7WxxKm3Jg53mwnLyrRtjua36rHiXsXrqPC1swwIS0KO2DRK64 +A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39rqkb5ct1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jul 2021 17:41:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16EHZ2OI065705;
        Wed, 14 Jul 2021 17:41:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by userp3020.oracle.com with ESMTP id 39qnb3upxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jul 2021 17:41:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6SGB9pLbchV5/M2PmdWoG+UtX338ECk9E1Ycdkdcjzh+C3nVXFpUMsztFhG2J6Ow9rLIfjAADlYwb9iaqnkr8E3IZASK0mvjM2Fne8ABp0FTWYQhkBZZ1D+xgKW8nEDAYW4n1Pcxx2pjybzZ1ATOqAKJ5JL8Gt3nfHtcbAph7uY1BVuvDvvei9NIpKLqYMjzVfQ2LqH9WG52FAjlbGpgl4aKkHZpVCZzGAhTnlUCfqsTgE/Vzm5a8rV86n6u8B0rr80WysZkqMRQp+u8YKdF2h4OUc5GAOB3m8iiASg6mX0lCvSNAl3H4paTPkEGw5QrRkfWT5o+HNdljrw3OSICw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p37Z0ywMrzFyDt6rFETqMFNF2UAZUrJTJ5D/Lf9Jms4=;
 b=QzmYLd7zXFIFPe+c0MMQQPeAxzh9o/AOwHuUuI4KQTXlT8IMeOOu+p06gPt7QT27svB1YKSQgoeQojCurbVaH+3u8KP3TM/nxJ8kRirq5quDcpGNenAApE4aXoyap/3yiTiEKcQ5IZpvW+nTKMlp1LlsKOZKDWaqhItNCNz8gaRZ+qkJm5pJbi7WksixZwAY3cBAYmGjdaYzYn/2wUDxi5faRaOMRZKjP7XJaGJtT3NzX0ZepZuTKOXIWDuoLu505Ht2wXv43TiFnhjvnVBH9G8OxdDIyS+fNGPlLwl7tg4iovzLKMWR/+jRbNp1X7wt+Y56tt97PnmcWckPYPMTsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p37Z0ywMrzFyDt6rFETqMFNF2UAZUrJTJ5D/Lf9Jms4=;
 b=ztLgZ3MyAWqBgDsBHPvn1u9/8XjIE5jQUw6C6K6GAK6RxzTaZtSlgCzqAYMrVU4QVJxxn1sGPe+R3in0ZwBR31tbFsFimTAwa0KiM11xngfEvyGcUqujnWMPKg/R2NzxEwF/I7iIpX/oVnHY92UTzAWJg0IHBvaZbHZNJBCaIPg=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3949.namprd10.prod.outlook.com (2603:10b6:208:186::11)
 by BL0PR10MB3044.namprd10.prod.outlook.com (2603:10b6:208:33::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Wed, 14 Jul
 2021 17:41:17 +0000
Received: from MN2PR10MB3949.namprd10.prod.outlook.com
 ([fe80::cdfd:7130:67a7:ae3c]) by MN2PR10MB3949.namprd10.prod.outlook.com
 ([fe80::cdfd:7130:67a7:ae3c%5]) with mapi id 15.20.4331.022; Wed, 14 Jul 2021
 17:41:16 +0000
From:   Henry Willard <henry.willard@oracle.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <tabba@google.com>,
        <keescook@chromium.org>, <ardb@kernel.org>,
        <samitolvanen@google.com>, <joe@perches.com>,
        <nixiaoming@huawei.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: kexec: add support for kexec with spin-table
Date:   Wed, 14 Jul 2021 10:41:13 -0700
Message-Id: <1626284473-1168-1-git-send-email-henry.willard@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0158.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::13) To MN2PR10MB3949.namprd10.prod.outlook.com
 (2603:10b6:208:186::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-dev-arm29.us.oracle.com (148.87.23.6) by SJ0PR13CA0158.namprd13.prod.outlook.com (2603:10b6:a03:2c7::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.8 via Frontend Transport; Wed, 14 Jul 2021 17:41:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dbf89d1-f022-498f-57a2-08d946ee9506
X-MS-TrafficTypeDiagnostic: BL0PR10MB3044:
X-Microsoft-Antispam-PRVS: <BL0PR10MB304451DC860C5F6A60929CDF8C139@BL0PR10MB3044.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yt7dl72Rsqttox6WgqxjJoe1t6STgQwcp1ikWcl8nBVGq4om+WDPVQBE/anLWWY9MmztD2wIcdZxw/R0eRPYQU3p6xJikPqLq5crmkkIqlNAehZzLV6A7FsfoIU2kN9DgpF2yIkcpUNBMtDjTUJST7KtCgZrOOFQ2wJ6EXhULy3s3BGa1Eppe7wDoR0wSMilg+bLNpLfto4f2riY5BR0cUSITsiaZGzaSaoevwrh+ph43IxtSkhfoA0TgIOPXVfMA10qGvGMmRX8TtvaXgmZG8cQGmT9AQoviJyR/OG/TituAOhl+0a5mh8PpoxqokM6Uxxx866BOI9dBSoxUpVNirfSqBfa2xYYgjtSSXJB6ZlZldyLcDWNzKHsdM/+ohbsjfiZhy4hWJw+6goEC2IkfoqTHLwqnRfREegM6GHyUwy+YleS9wrD51/A2N8rJEOJPgRPHa6wYAspyLPQgCXpKh0cqk98aDbVmp5RHr7O6zzpt/91J5CLde0SzqaHizkes+ezX9x1ZMQK7zLUZstTGJ0HMb9zlNA5PS2YR9jMXengfmFnYDAw7+Fdan9bUgSslC6FJ77SvLsfkA+pF1K47zruM/mD9Pqs7oHTeY7J8kCXxRkIFOP3/KA3PsaJQknT1qTYVceTg23U1GkolCSkcwbVv87yDaPN03p5/WR0yaxZEwSRv1PGEY1+PFPBdLvQDFRlEC4uG7AAbzl/aKagWrip2T5SSSlfHT9zPZcBGps=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3949.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(39860400002)(346002)(366004)(38350700002)(36756003)(26005)(2616005)(44832011)(38100700002)(52116002)(5660300002)(8676002)(86362001)(2906002)(8936002)(110136005)(956004)(478600001)(7696005)(66946007)(186003)(7416002)(66556008)(66476007)(921005)(83380400001)(6486002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lPau621LB9KgmXnzzwLhMU0x5ILxlzoVc4HFgQM1Gn5qcLLwQ9E2Lb9PGyaP?=
 =?us-ascii?Q?3KM5TG2pBONggp4/lWmH20nogWg6Rk8+GAU+NkHe6mfAKdEruAB41b+i18Mp?=
 =?us-ascii?Q?N8esk3TxhvdSYHyqP4sVZa45UG+Tr757BF+ceRfX9tx14HzGPwsQrby/h9/i?=
 =?us-ascii?Q?Pej286Yv7xAwBPnxmrvd4QIifgl3bWEaoob1L6zDcDIVO9mPb97B19OUMnPj?=
 =?us-ascii?Q?c9iLz8EZ53bbMkspSrQHhuYG5SU0O5ISDB/xkdTM1Udfc1CPNHZrrlnmfJYp?=
 =?us-ascii?Q?y1a2RbMbRUWFiglYZnfVhWMRQQrDmwm5h12BD+UcF7eCKvih8HUl75Sbb8oj?=
 =?us-ascii?Q?8KkFoqjz/iOsrHPgKwiCgLubes7NsKWQe9BGgVskMXMyCnNyfzzN7ZyiqBxH?=
 =?us-ascii?Q?C5uLwZita86THy0jp51gpoFRb35Nv6OnwupkF00wRKq80L3nSu6404ZyZSLp?=
 =?us-ascii?Q?DmsGey1u3EEiOqeHKuF8wrzYyZ2pZulMD1j3YjD3RhRZX7sAcclDmPhpiHqy?=
 =?us-ascii?Q?9XJVjI/Ob9kMSDWLdDjfEt8iyboiEfz/CcHBPaNy154rVisQ6u2srp5xCYdn?=
 =?us-ascii?Q?Eo9Y8z7sEUASGRS/LSihxfGNgJuXGqQIacBRFn9Yt+wuNuGpEGBl8zsfvpGV?=
 =?us-ascii?Q?F8lE14MQsjkC2OlTuCInx/y/3fEndxaaVG78QTUlOlTG/Q9g0mNMaZlMbEXo?=
 =?us-ascii?Q?fr3fM+6GHAOg63Kc912iAIIxJ4RzIVsxYndB8fR3k5JfDsro5lessmmSdJGy?=
 =?us-ascii?Q?7MYRuJuqA3AxxaPiPxx7cZ7l/0gCBbEY8aQjdnOT5ZlpdxvgMd7cRev3MhhX?=
 =?us-ascii?Q?bHEfZbPyc0kGQsbXHK1OoBP0xoGuxRmjgIWbpO2dmurzzqfxY8ykddt9APf1?=
 =?us-ascii?Q?kRyPCQiigD/zH74zsYGiopbqey1kU7j3PwkCWC2O3DNSLWnzJ9Zg/dVND7MC?=
 =?us-ascii?Q?C10BWISDyfkenGsKeV1j3DpdIzqJO4E76XGl5cVRYf3rEbIr7lwrfUpBgBPR?=
 =?us-ascii?Q?rAfIZRt/gY4G/mD+VyCZW0BT8OK9eSL7qZYapYlCKsr1gEqEu7J+W2NeYCsO?=
 =?us-ascii?Q?AZWRj7+0niMwQRSMevgNq93fnPCd7xSyauxpvhF0fP9A09qFYtRh6Xi10Dfc?=
 =?us-ascii?Q?eHhaGe9DjnSd73KmpsdYEFV9v2HP0YZ0vBUvbG2Ds6aX4lZ6V3Dk2RoPsKnW?=
 =?us-ascii?Q?Q8mXP/cKLtSy3xij1ZleNxNb85NUniUuaaj5nL5dTnGztBbkemki9hG2ZgHK?=
 =?us-ascii?Q?q9h6x8Tqeex0UCnyCsbzXLzQnxvSr6n40DvvmLEgxJiYfJMwrUzodlkaKjMX?=
 =?us-ascii?Q?iRL+b6WZRcss0c6C95+SdUlN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbf89d1-f022-498f-57a2-08d946ee9506
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3949.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 17:41:16.9225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7DlR35cGnp4hl/SyfcKEzbPKXKlpf4QO5DQR49GLW4J1rnZUGxfRZLv4siy6g5YE3s7G7aKtrX/VHf9ga7LTXj7A+g/d2GJdwNIfN0sc5pM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3044
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10045 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107140105
X-Proofpoint-ORIG-GUID: rZxBCxagCnmkn6TWzhV-Y0vtdYUUxlxx
X-Proofpoint-GUID: rZxBCxagCnmkn6TWzhV-Y0vtdYUUxlxx
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With one special exception kexec is not supported on systems
that use spin-table as the cpu enablement method instead of PSCI.
The spin-table implementation lacks cpu_die() and several other
methods needed by the hotplug framework used by kexec on Arm64.

Some embedded systems may not have a need for the Arm Trusted
Firmware, or they may lack it during early bring-up. Some of
these may have a more primitive version of u-boot that uses a
special device from which to load the kernel. Kexec can be
especially useful for testing new kernels in such an environment.

What is needed to support kexec is some place for cpu_die to park
the secondary CPUs outside the kernel while the primary copies
the new kernel into place and starts it. One possibility is to
use the control-code-page where arm64_relocate_new_kernel_size()
executes, but that requires a complicated and racy dance to get
the secondary CPUs from the control-code-page to the new
kernel after it has been copied.

The spin-table mechanism is setup before the Linux kernel
is entered with details provided in the device tree. The
"release-address" DT variable provides the address of a word the
secondary CPUs are polling. The boot CPU will store the real address
of secondary_holding_pen() at that address, and the secondary CPUs
will branch to that address. secondary_holding_pen() is another
loop where the secondary CPUs wait to be called up by the boot CPU.

This patch uses that mechanism to implement cpu_die(). In modern
versions of u-boot that implement spin-table, the address of the
loop in protected memory can be derived from the "release-address"
value. The patch validates the existence of the loop before
proceeding. smp_spin_table_cpu_die() uses cpu_soft_restart() to
branch to the loop with the MMU and caching turned off where the
CPU waits until released by the new kernel. After that kexec
reboot proceeds normally.

The special exception is the kdump capture kernel, which gets
started even if the secondaries can't be stopped.

Signed-off-by: Henry Willard <henry.willard@oracle.com>
---
 arch/arm64/kernel/smp_spin_table.c | 111 +++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/arch/arm64/kernel/smp_spin_table.c b/arch/arm64/kernel/smp_spin_table.c
index 7e1624ecab3c..35c7fa764476 100644
--- a/arch/arm64/kernel/smp_spin_table.c
+++ b/arch/arm64/kernel/smp_spin_table.c
@@ -13,16 +13,27 @@
 #include <linux/mm.h>
 
 #include <asm/cacheflush.h>
+#include <asm/daifflags.h>
 #include <asm/cpu_ops.h>
 #include <asm/cputype.h>
 #include <asm/io.h>
 #include <asm/smp_plat.h>
+#include <asm/mmu_context.h>
+#include <asm/kexec.h>
+
+#include "cpu-reset.h"
 
 extern void secondary_holding_pen(void);
 volatile unsigned long __section(".mmuoff.data.read")
 secondary_holding_pen_release = INVALID_HWID;
 
 static phys_addr_t cpu_release_addr[NR_CPUS];
+static unsigned int spin_table_loop[4] = {
+	0xd503205f,        /* wfe */
+	0x58000060,        /* ldr  x0, spin_table_cpu_release_addr */
+	0xb4ffffc0,        /* cbnz x0, 0b */
+	0xd61f0000         /* br   x0 */
+};
 
 /*
  * Write secondary_holding_pen_release in a way that is guaranteed to be
@@ -119,9 +130,109 @@ static int smp_spin_table_cpu_boot(unsigned int cpu)
 	return 0;
 }
 
+
+/*
+ * There is a four instruction loop set aside in protected
+ * memory by u-boot where secondary CPUs wait for the kernel to
+ * start.
+ *
+ * 0:       wfe
+ *          ldr    x0, spin_table_cpu_release_addr
+ *          cbz    x0, 0b
+ *          br     x0
+ * spin_table_cpu_release_addr:
+ *          .quad  0
+ *
+ * The address of spin_table_cpu_release_addr is passed in the
+ * "release-address" property in the device table.
+ * smp_spin_table_cpu_prepare() stores the real address of
+ * secondary_holding_pen() where the secondary CPUs loop
+ * until they are released one at a time by smp_spin_table_cpu_boot().
+ * We reuse the spin-table loop by clearing spin_table_cpu_release_addr,
+ * and branching to the beginning of the loop via cpu_soft_restart(),
+ * which turns off the MMU and caching.
+ */
+static void smp_spin_table_cpu_die(unsigned int cpu)
+{
+	__le64 __iomem *release_addr;
+	unsigned int *spin_table_inst;
+	unsigned long spin_table_start;
+
+	if (!cpu_release_addr[cpu])
+		goto spin;
+
+	spin_table_start = (cpu_release_addr[cpu] - sizeof(spin_table_loop));
+
+	/*
+	 * The cpu-release-addr may or may not be inside the linear mapping.
+	 * As ioremap_cache will either give us a new mapping or reuse the
+	 * existing linear mapping, we can use it to cover both cases. In
+	 * either case the memory will be MT_NORMAL.
+	 */
+	release_addr = ioremap_cache(spin_table_start,
+				sizeof(*release_addr) +
+				sizeof(spin_table_loop));
+
+	if (!release_addr)
+		goto spin;
+
+	spin_table_inst = (unsigned int *)release_addr;
+	if (spin_table_inst[0] != spin_table_loop[0] ||
+		spin_table_inst[1] != spin_table_loop[1] ||
+		spin_table_inst[2] != spin_table_loop[2] ||
+		spin_table_inst[3] != spin_table_loop[3])
+		goto spin;
+
+	/*
+	 * Clear the release address, so that we can use it again
+	 */
+	writeq_relaxed(0, release_addr + 2);
+	dcache_clean_inval_poc((__force unsigned long)(release_addr + 2),
+			(__force unsigned long)(release_addr + 2) +
+				    sizeof(*release_addr));
+
+	iounmap(release_addr);
+
+	local_daif_mask();
+	cpu_soft_restart(spin_table_start, 0, 0, 0);
+
+	BUG();  /* Should never get here */
+
+spin:
+	cpu_park_loop();
+
+}
+
+static int smp_spin_table_cpu_kill(unsigned int cpu)
+{
+	unsigned long start, end;
+
+	start = jiffies;
+	end = start + msecs_to_jiffies(100);
+
+	do {
+		if (!cpu_online(cpu)) {
+			pr_info("CPU%d killed\n", cpu);
+			return 0;
+		}
+	} while (time_before(jiffies, end));
+	pr_warn("CPU%d may not have shut down cleanly\n", cpu);
+	return -ETIMEDOUT;
+
+}
+
+/* Nothing to do here */
+static int smp_spin_table_cpu_disable(unsigned int cpu)
+{
+	return 0;
+}
+
 const struct cpu_operations smp_spin_table_ops = {
 	.name		= "spin-table",
 	.cpu_init	= smp_spin_table_cpu_init,
 	.cpu_prepare	= smp_spin_table_cpu_prepare,
 	.cpu_boot	= smp_spin_table_cpu_boot,
+	.cpu_die	= smp_spin_table_cpu_die,
+	.cpu_kill	= smp_spin_table_cpu_kill,
+	.cpu_disable	= smp_spin_table_cpu_disable,
 };
-- 
1.8.3.1

