Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F79931ADF8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 21:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhBMUdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 15:33:37 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55820 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhBMUdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 15:33:13 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11DKVUUm193125;
        Sat, 13 Feb 2021 20:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=JoyTEj+PrV7SCZoc0XxHEWisGhFJH5HLqLZz48p92DY=;
 b=UnOGK7eeUTuixN7BI1T4umAaqi9PGFI57jgV2dR+WbVqFS2FEyaemEcVX9spNISwoe55
 hUdH26HtaM53gtxciqk01SirhCpov5KsNocIXJTknfGWhisDAZuq9wokfMedZVwkhYDH
 HWtzz5YIvHGkdnJvfxCM6zLziqDhk0IlaCpkY75AagpUMNXmuasdY9QOptCyybh8gGxF
 zJDJ3L20g69/Qc/LGrDMIqSWEz1afaT2oxA5b+nOj//0gALs4hrgAhpEg44ezB4XtNwn
 1PVjqiljDliagd3O57gGH9rKexMpAbE+Eep97gndXW8SKMiTd01rcRgPg+xHQ3AvtOtP CQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 36p7dn8yah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Feb 2021 20:32:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11DKTuqA093977;
        Sat, 13 Feb 2021 20:32:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by aserp3020.oracle.com with ESMTP id 36p6k0226r-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Feb 2021 20:32:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnmJihcMo89dVd/HVtRyPV7iBe+J1948F77LpNk0B0TjRNwAJSQivSvniVNvwyehjTdsLzNp1JR9Z0NCEslNV4hd7FWL224c9xC1Ss8JaraCp/srvfMO+EHVCcp8uPqzuAGMqbz3/q0BwKk47S3EH9G5STJx+contHK/QCLnLITlkry7XgkDNM+QMKXIRzvsrvlBAJk2KFR4TeKB0bqhMUbqixZcrjvt+LpAJQp1FmTwInZBZdf21GtcRYHdjo3xZleodCmJwwVkBEOKN262Spf/o/NaJKi9UguFAgGNItqPOYj33CFeB77+MUjDygS8+BNUwsQ6FilpOme6rnktPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoyTEj+PrV7SCZoc0XxHEWisGhFJH5HLqLZz48p92DY=;
 b=Gv9K1giLo8C7d0DV3yJOQ23fV/8f7/NK2Oclf/+G+JU2n4QyvNT4kwtdVxIccCFn9lI0m05+NK2snPh/mh91gxvXeM9pULhL7Ebpw1zaDdO6PQR6gMRS3iYnQaSkQqGm+rBRdb7MaSJTMqlDdq/Sl0RfTXgXjmCwSx15bWOuTzEADqZusIBJ6rE55oakhxCBDRpug0Ua7goVaLYikvyoS1Hj0T53Jx4FdOAnaO+w4x5L4Q+yM+wuiFu704S/1FxfFfsn0lfNIytNd9PuoGcXRfJkhJcwlst7Weewom/6hBQxou/nP3vdSgf2E5+bG7vYi8VYMSa+AeCvR95TaJwaNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoyTEj+PrV7SCZoc0XxHEWisGhFJH5HLqLZz48p92DY=;
 b=I0YXw+YHygTytTIzL/QvmRzXRufjKbkRMnlHHUJAmO8EXKHP+GrO3BE33IgkZWcgocppcaKBrAYJzfYP6cBQ2OBeDBu6utXjFCnl4qcp43X4yRfjwjp2jJPQZkupE6rZtra5wF5tO53aop0TIoxe4DV09W7AJARLwcXWHcF6mKA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by MWHPR1001MB2286.namprd10.prod.outlook.com
 (2603:10b6:301:2d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Sat, 13 Feb
 2021 20:32:06 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::f48a:d4cb:d74c:48ba]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::f48a:d4cb:d74c:48ba%6]) with mapi id 15.20.3846.038; Sat, 13 Feb 2021
 20:32:06 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de, rdunlap@infradead.org,
        bobo.shaobowang@huawei.com,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH v4 3/3] misc/pvpanic: add PCI driver
Date:   Sat, 13 Feb 2021 21:44:07 +0200
Message-Id: <1613245447-21495-4-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1613245447-21495-1-git-send-email-mihai.carabas@oracle.com>
References: <1613245447-21495-1-git-send-email-mihai.carabas@oracle.com>
Content-Type: text/plain
X-Originating-IP: [138.3.200.25]
X-ClientProxiedBy: SJ0PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::18) To MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mihai.localdomain (138.3.200.25) by SJ0PR13CA0013.namprd13.prod.outlook.com (2603:10b6:a03:2c0::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.12 via Frontend Transport; Sat, 13 Feb 2021 20:32:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6415fff1-b83b-4a68-718c-08d8d05e6df4
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2286:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB228683E1F0AA5848E093CF40888A9@MWHPR1001MB2286.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OUMsd8+s/bbrJkSuEkSxBHzXqrhwUkfd8K38cPPdYvW50Cse3DzCL2CNCJ2v+NDUJo8ZC9uAPoQ12WTkutK2lNpT2CDFBTgPSMiAPjIP8zAmHH9ylTx4czKSh03NNtK4Z4HBb0GQ6FJvuEVAG6INen+qk9bvMrriy04rlsSNViUMiC/wVk/uPN8WGQXhg8zFJNzMEqlNsxOgcvtTqmlxKtDC6hytgDePmbIMa+wTtJbZH9y9K0VpyVv05+4Z63kKs2xPZJ6KrMajEHmINugYAeq23MKJNc8LjCrLDYuxsY5dfmboGe4oCahefOyygUm2LFMg4jMguyhcBcQjPKbUSCCXUO7G/MWCbEWJpq061FH/bORIVLg1+4o0toqWlwUfoau+hgsz1ikX++igdWLlolwihR1N6p+C5lwjqRHjPcg6/vhlH+sGpZxua4StgkhWF/j/QjV+BtOjMcs7DvFy1O4FOfdiaEfgiT+0XR3MdWHaZ4AC7Y97glUEe0KxFQpfj7+Ia5JkVDjxSgTeEJbiz8kQFWt16+uMLxG6+x69/FLL5DZdu0af6XSYq/PoxXJqU9v+GaUoql9gGB+G11pCA7rijj0pRG9RQwZoHti+zI8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(376002)(346002)(39860400002)(6916009)(66556008)(66476007)(52116002)(478600001)(966005)(86362001)(66946007)(8936002)(4326008)(36756003)(16526019)(26005)(186003)(6512007)(6506007)(5660300002)(316002)(107886003)(8676002)(6486002)(2906002)(956004)(44832011)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?icak2iomhxwtGksKoMle2rMXh3tNYo8XDZNuDln5tt9NJAesAPty2FJueMMa?=
 =?us-ascii?Q?FC97Cj0lopIoKM0Bzrj+Pof6nCF4XX1Ubxsc75rUgVEUzxvaZH2RbXWWaah2?=
 =?us-ascii?Q?iN03sVrMwGRhcB4kG5w+fTEs2WLCKPVM++aW9w2I1RDBbf2p71pf0z90F1n4?=
 =?us-ascii?Q?9Q2UVgCWIyW2MVveZy+a4BFCSaIJjL/G9exdQ6FoOFlx+FKy5AlV9bN7y48j?=
 =?us-ascii?Q?QVVV1h/mwjZUazKFRf/9CpQ0iKMl7jaC/IlxL32aHbl4++8cthvyC2+9z26q?=
 =?us-ascii?Q?pfWNMaFpmTDKt2ajpAC7zWV4iNMU1clzVYyGtIkZFDcH1sNGx+kMt5U5uwTn?=
 =?us-ascii?Q?8iZUblMggUV+QKLpXR3WxG7yD1V6lgNmjl/kJaspACO+0GZ+Pfj96LpKBEBb?=
 =?us-ascii?Q?ew6yVfTD2Gyd66qw1gH8k/YfV8Vabh107J4I7BXLMdLwmGmauH8D/RT+NfQu?=
 =?us-ascii?Q?qO2Pf9HcfPCedez+IDzh8z17/YHYPnJ4LVQoTu8XiK/0kt/wpADSCc6WpKp7?=
 =?us-ascii?Q?05yBnTQWdppEZyFMQaVIu6zs2VV1w55ypAEXDd/HoaNhYKYVeviLdOphTH4G?=
 =?us-ascii?Q?9nZEnFBPD1LXdQfkdohAmJXpVgQH/gZJ3VJZVBAmaY7P2ZA8CqydT89vmXmH?=
 =?us-ascii?Q?WRVi3ZKtQamfVwdofH1D/wcy8fG6vnp8kq55LfvYNNz2V46xy8tBiOp57fgP?=
 =?us-ascii?Q?EobVlq58fkP91MJ9Xs9BTGRUJQ5DG4K/GBBJW60+aOUQfrggsKCi17HQTZkI?=
 =?us-ascii?Q?P0G/9NJCZiud7TV9c1ytEfJkFdV42U1A/Hc0jnPC7UuNeCDM2qf/QW97ufFa?=
 =?us-ascii?Q?2wszcjRgt2P6k+dktFM2wVxQmuE1aJGz7j4ylGrGcNW4rQTLzE1469jDwBxU?=
 =?us-ascii?Q?ODQp1HohpCESgCeyYdQwcCLOBhJVoEkPvqw/tZyb3WUYb/sLd6F+JRP6PoTO?=
 =?us-ascii?Q?lEcrbPB2RWH6tiVrPOM4r4Lu+sVlaDleDPyb8Ozzqkw6FJzN+ztADHYNgYdO?=
 =?us-ascii?Q?5B59AOSgl97SJjvl/bITkq8uet5V6FvgOW+yJh/F7KQpKeG1H126RjJnNf6u?=
 =?us-ascii?Q?Tt3Q3pwgXacWBypBkSmPACVhj3JgJuHGDwSb/onT2CHZoqr9SU+NDsGLgaPm?=
 =?us-ascii?Q?EuKVe9s5cb9NEplI7rcypc17FCAtr/8cDFv3+VSutxkbcttyBbl7Q4ZnlYYK?=
 =?us-ascii?Q?iyuegSmXzG+MPDLZdQ4QuuUoXNp8G1LQfrVJ5W1YPOj7hgii3O/H+r1qkp2E?=
 =?us-ascii?Q?bzM5wSSuWiNeabfDa0J8hPoXMmYBOv9d++yVlaUns1u7e8O4580X7dhT5fbX?=
 =?us-ascii?Q?UddnsVDShxFBxTIgfntY1QGw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6415fff1-b83b-4a68-718c-08d8d05e6df4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2021 20:32:06.5463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 327mHsP7wy4Ff2kyqnr6oNjMqWxPm93Be06ZwcLbmNz9Cc6SDy+VKlL2FIEwPs/iHwkGP/Jm05eyuVlKW8KXMvLr4DHpqLldkNisScqqeUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2286
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9894 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102130190
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9894 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102130190
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for pvpanic PCI device added in qemu [1]. At probe time, obtain the
address where to read/write pvpanic events and pass it to the generic handling
code. Will follow the same logic as pvpanic MMIO device driver. At remove time,
unmap base address and disable PCI device.

[1] https://github.com/qemu/qemu/commit/9df52f58e76e904fb141b10318362d718f470db2

Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 drivers/misc/pvpanic/Kconfig       |  6 +++++
 drivers/misc/pvpanic/Makefile      |  1 +
 drivers/misc/pvpanic/pvpanic-pci.c | 54 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)
 create mode 100644 drivers/misc/pvpanic/pvpanic-pci.c

diff --git a/drivers/misc/pvpanic/Kconfig b/drivers/misc/pvpanic/Kconfig
index 454f1ee..9a081ed 100644
--- a/drivers/misc/pvpanic/Kconfig
+++ b/drivers/misc/pvpanic/Kconfig
@@ -17,3 +17,9 @@ config PVPANIC_MMIO
 	depends on HAS_IOMEM && (ACPI || OF) && PVPANIC
 	help
 	  This driver provides support for the MMIO pvpanic device.
+
+config PVPANIC_PCI
+	tristate "pvpanic PCI device support"
+	depends on PCI && PVPANIC
+	help
+	  This driver provides support for the PCI pvpanic device.
diff --git a/drivers/misc/pvpanic/Makefile b/drivers/misc/pvpanic/Makefile
index e12a2dc..9471df7 100644
--- a/drivers/misc/pvpanic/Makefile
+++ b/drivers/misc/pvpanic/Makefile
@@ -5,3 +5,4 @@
 # Copyright (C) 2021 Oracle.
 #
 obj-$(CONFIG_PVPANIC_MMIO)	+= pvpanic.o pvpanic-mmio.o
+obj-$(CONFIG_PVPANIC_PCI)	+= pvpanic.o pvpanic-pci.o
diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
new file mode 100644
index 00000000..af94ab8
--- /dev/null
+++ b/drivers/misc/pvpanic/pvpanic-pci.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Pvpanic PCI Device Support
+ *
+ *  Copyright (C) 2021 Oracle.
+*/
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+#include "pvpanic.h"
+
+#define PCI_VENDOR_ID_REDHAT             0x1b36
+#define PCI_DEVICE_ID_REDHAT_PVPANIC     0x0011
+
+static void __iomem *base;
+static const struct pci_device_id pvpanic_pci_id_tbl[]  = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT, PCI_DEVICE_ID_REDHAT_PVPANIC),},
+	{}
+};
+
+static int pvpanic_pci_probe(struct pci_dev *pdev,
+			     const struct pci_device_id *ent)
+{
+	int ret;
+	struct resource res;
+
+	ret = pci_enable_device(pdev);
+	if (ret < 0)
+		return ret;
+
+	base = pci_iomap(pdev, 0, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	return pvpanic_probe(base);
+}
+
+static void pvpanic_pci_remove(struct pci_dev *pdev)
+{
+	pvpanic_remove(base);
+	iounmap(base);
+	pci_disable_device(pdev);
+}
+
+static struct pci_driver pvpanic_pci_driver = {
+	.name =         "pvpanic-pci",
+	.id_table =     pvpanic_pci_id_tbl,
+	.probe =        pvpanic_pci_probe,
+	.remove =       pvpanic_pci_remove,
+};
+
+module_pci_driver(pvpanic_pci_driver);
-- 
1.8.3.1

