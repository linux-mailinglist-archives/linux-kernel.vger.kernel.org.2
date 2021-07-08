Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49F73C19EB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 21:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhGHTji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 15:39:38 -0400
Received: from mail-mw2nam12on2130.outbound.protection.outlook.com ([40.107.244.130]:15456
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229631AbhGHTjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 15:39:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYPMxsHYZmhr/ARXfcJv5wYpQM+31OvoGaWyuhYnASabYV04n0XaO9y/pwMSrEwwXnA392FpxVgFMJ8TidEpwnbKDQ3iLavkgXP35c8nKJxU3KREQHYhQqQ0PcwYqMSwymnxrGXqfPNws8rtI2R7MRzXTTlBQ88PENHJgL3iCfgq/xxTwIVs9SOGuTxFjHvRvXP3oXBcbZiYw309PZRYeFEk3PsKdYrPkLsVljdLRIxoHYEml+ncmAkUe6NKUUrDFzxQTAlKWCM8BdQEwgo4h1r7yfRc/SZsIEMuz5IAOzcljvpQ644NwOwnd23yv+Qg6pXMdg6yHgg0XmLndRfuQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIf5oaErKnLhfi9anqbY0KAoK//p0kHIVE+uGzQwneE=;
 b=TPjdH5NLVXAfigVQcPsou9Y6TwUDwQoKhRgz9JJjy9r09NX6efMJwkRUfLDFsRMNFM14VzHyONVQWxF3R49r3je4Ff4jcv3/kPP1WK5bjxtiEw/yYmK9W55fuEl4D27y1fyf7n7uCB/LWlQsC4rxOagTo7U4C9R32PjywRRr00dJjwItvEkRGvmS0BrrVF9MsTLv131Lu66bnEydjlZuNajl1Naj7xKzFhCBOax2Bf7an2VudrmkbG39jwmCFIlQ2MMtLtzNF6eSA0Fe0bqAo4o1+Y7s3vaMBAbU+fl3UX3vWeyj3+NWcw5DFHdIoDXUXimjBOUU2pXuMA3zz6rIMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIf5oaErKnLhfi9anqbY0KAoK//p0kHIVE+uGzQwneE=;
 b=GfFeTHz2MJBTAnsMGnWo0IWPUXeIpiTZP6G58BXYp2qKBjS/L/gBcwrI+Yvo+m3pJaORKCJVOMZQExBEPF0UrZtHsIE5rfYXdupBsVDG/T4fHdZaedwcSzC8IVSbai/o6ncvSz4fge2yE79ZIvrFriegn8sv+Efuq1bI7Voels0=
Received: from MW4PR21MB2002.namprd21.prod.outlook.com (2603:10b6:303:68::18)
 by MW4PR21MB1906.namprd21.prod.outlook.com (2603:10b6:303:67::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.8; Thu, 8 Jul
 2021 19:36:52 +0000
Received: from MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::f8cc:2c20:d821:355c]) by MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::f8cc:2c20:d821:355c%4]) with mapi id 15.20.4331.012; Thu, 8 Jul 2021
 19:36:52 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 1/1] irqchip/gic-v3-its: Add irq domain and chip for Direct LPI
 without ITS
Thread-Topic: [RFC 1/1] irqchip/gic-v3-its: Add irq domain and chip for Direct
 LPI without ITS
Thread-Index: Add0L2f934gE0okbTBC5z2WK9cOcFQ==
Date:   Thu, 8 Jul 2021 19:36:51 +0000
Message-ID: <MW4PR21MB2002BA20FA4A8DAA1C27F4C6C0199@MW4PR21MB2002.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9975e0e2-66f7-49b7-23e8-08d94247bc66
x-ms-traffictypediagnostic: MW4PR21MB1906:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB1906F3D609C868636614CEB5C0199@MW4PR21MB1906.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fSXiD64b/ijj/d0KiG0ytHj7bvcmBUOSwGPKsxqJakmTKYbH0ohFQaj+ZEheUpuTfH/+qmPOLNT+leqdMbNtS1gk24iDOIuzjKxwBMiFxdjphYuAlrM3/7bNCuLwje1TeLEuDQ9HVpaSZNx1f4wyCoC2pne+a/W3YHzArLhwEb7Fe4ktqbV8OhgffEkJzgngch6sCQhEmHjUHy8COBiW4uR7E/tlFNYkxX6cvJuxyNQ5xYvix5sh9T6I6JMLg66kuTeTIpk1Xs+o7Qtv9CpJO12JPMOSO0KcBryz4V1th2VRvRGyF4cQDELzMnqUxJNhXxMAOY6eRHmkYwiYQC4knMBC3kSCcksICpUDGeeq0eAjdmoAjI46YRiB5DLB2qX4qLKC54C6i/StCMWT1jG9Z6x+yMb191gyk/Pt+xmGUxTcB2iH2gJEosISyKDJSeBnNw++vaP77Ujod/zfn+5E6TMTyd/Q51BE93Dv6YNponOA27KT4KrUcAscAt93NIDS+gOV9zWhzhnsO+JASwrJ1LOVylhh8xSjq6MdssUcvf8D0f2mQMWpo/Qe8+p0tu64z7qwq6ExGNcRZsRs3xRfpvx8zemvwQfuthbj2XO4fBf3b+XsxnsGgahA9DsIEw+l89Y4RiaH9YA6HQ5SuXxgVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB2002.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8990500004)(122000001)(8676002)(86362001)(66556008)(10290500003)(30864003)(186003)(66476007)(33656002)(7696005)(83380400001)(71200400001)(316002)(54906003)(8936002)(38100700002)(2906002)(110136005)(52536014)(64756008)(66446008)(55016002)(5660300002)(4326008)(9686003)(82950400001)(6506007)(82960400001)(76116006)(66946007)(478600001)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UwIgdevapHIOlCwy0RCLIQI36BuKzbagS7/HdcFJE1MdJDfe9B4IDcw4CZUW?=
 =?us-ascii?Q?6kwcTrn9mieRkhWmxMWagoooSur2e9wQNDoCtF1XXRTa0sraiDH1b+IXU60/?=
 =?us-ascii?Q?3jhEL1dlg3ctFjZBfXkJ1JEZAbpLbnZduKcSA3l10T2+b+G3oTOmbd9lzpEe?=
 =?us-ascii?Q?mQ2GDknGWzXfF6etu8VRTpLiRSxXqLAmsraC8dcUFFw7bHm89+ifzdBSIqa8?=
 =?us-ascii?Q?+VQPkxjakrVQxy648oReP6gCsI5P2N9zlrd7kWlZhrNseGBDK0ejzk/vgK9Z?=
 =?us-ascii?Q?BUr4lzwepzxY5MPVSs8tAoGNK3QGteQf20pLHBJQAc8ewliFa41xlxYNvqkp?=
 =?us-ascii?Q?p42bZrJ8Dc2xS+EoBpcPLXxHHoJhoQlxcizL72yUpHvgAN7D5pgjk4RGh3Oh?=
 =?us-ascii?Q?C+mqMwa3Lpw2oG3WPqD5smMEGfjjQDPhVHqR4sVAZW9EVssDxzoTtoSkHOcD?=
 =?us-ascii?Q?TrveXPdA/VGKOcLnFD3pM8CceGw9og6QpmE0YPhWxsVt7ppT5UYd2jfnG06k?=
 =?us-ascii?Q?u6+ukugoBdJqIosM0IrSFS2bBZcUCZhaUJHwR1eym58e82uaJoMOoDGe08t1?=
 =?us-ascii?Q?fANUe71eGSjjKIuupagHXN5fOt8vTTXoe1B/LZzpJYf+nc34Nwp5w2UqQG3X?=
 =?us-ascii?Q?NOwnowKbZFdI8XwgqiuQ6Qos3azPfiwOjSoEXQWQ73ZvORzmr1AYZYOPM+ab?=
 =?us-ascii?Q?fsfgjWvRweowjV1PlQdQXhxgAIHtETl64lY3clju+pASZy82Eiiq55YejhOq?=
 =?us-ascii?Q?ueB8StzWBXuPTAtggSMKwGV3sBURoJtLRmk47j7SlDBz8tMKnkfUdq+4xv5b?=
 =?us-ascii?Q?kldoQAJlQDrf0DkytPn/p4yqjVzWwe37AmVMDSVdhn/VWAETjlNwU04Vey7Q?=
 =?us-ascii?Q?6yM7xleMB1CjWFW+w2F5BsF7WulLZeVpF3q0LnBt7UPWhjSMTQJ1JFLFTyFw?=
 =?us-ascii?Q?kLwjbFEvfxI5kCKfA8tsSX903pp3HEGnl8h7uit4MIk+LZekcmsL8MJzoLkH?=
 =?us-ascii?Q?hU3KMGk30DDXZApaxsvnaKRj79jwnbL1YwePH2hoXLl0EA5IRe0ExkLLPdj1?=
 =?us-ascii?Q?BGEh1mYInahVjIt7fqcJquJi0huoMGXWASc6+hLwR4qdWVAG99tTwdQsz75j?=
 =?us-ascii?Q?byPE6JrgUaB1/zFMFWiE+RZaVIajoQAfIbHfiZfqIUAg76GXeSkTIlkvMk4Q?=
 =?us-ascii?Q?rvBM/LPGNDqrmRdhNm7++vUu6En0qe4gAwi/vgjidGjQWCGouTjSPlcm2AeP?=
 =?us-ascii?Q?lrG45qdq9UFflyyOXX5/eJGB0kiKquZ20nFvM15qPThGNchd7V2g5jYnqb5S?=
 =?us-ascii?Q?oRlSTuaLa00R1dkY1CdoBFJ7V7nONiYCMdn8eq0d5ghUYeeLbahpW1PyJjcC?=
 =?us-ascii?Q?nqa+j9JY4yvMJwlPfynKVGafgFJ7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2002.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9975e0e2-66f7-49b7-23e8-08d94247bc66
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2021 19:36:51.9303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BEuToWBoY1VwyNPqarRI1b6JmAEyEmAeQDWbTYy/Gj482BqG9nOvPQvPTPHr9Z03bQtXN8t8D4mFIG+hzcOj9Pv34JIwPViHcBe2DH62TqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1906
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current GIC v3 driver doesn't support Direct LPI when there is
no ITS. The spec architecturally supports Direct LPI without an ITS.
This patch introduces an IRQ domain and chip to manage Direct LPI
when there is no ITS.

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
---
 drivers/irqchip/Makefile          |   2 +-
 drivers/irqchip/irq-gic-common.h  |  22 +
 drivers/irqchip/irq-gic-v3-dlpi.c | 639 ++++++++++++++++++++++++++++++
 drivers/irqchip/irq-gic-v3-its.c  |  51 ++-
 4 files changed, 694 insertions(+), 20 deletions(-)
 create mode 100644 drivers/irqchip/irq-gic-v3-dlpi.c

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index f88cbf36a9d2..c6ea9620161b 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -32,7 +32,7 @@ obj-$(CONFIG_ARM_GIC_PM)		+=3D irq-gic-pm.o
 obj-$(CONFIG_ARCH_REALVIEW)		+=3D irq-gic-realview.o
 obj-$(CONFIG_ARM_GIC_V2M)		+=3D irq-gic-v2m.o
 obj-$(CONFIG_ARM_GIC_V3)		+=3D irq-gic-v3.o irq-gic-v3-mbi.o irq-gic-commo=
n.o
-obj-$(CONFIG_ARM_GIC_V3_ITS)		+=3D irq-gic-v3-its.o irq-gic-v3-its-platfor=
m-msi.o irq-gic-v4.o
+obj-$(CONFIG_ARM_GIC_V3_ITS)		+=3D irq-gic-v3-its.o irq-gic-v3-its-platfor=
m-msi.o irq-gic-v4.o irq-gic-v3-dlpi.o
 obj-$(CONFIG_ARM_GIC_V3_ITS_PCI)	+=3D irq-gic-v3-its-pci-msi.o
 obj-$(CONFIG_ARM_GIC_V3_ITS_FSL_MC)	+=3D irq-gic-v3-its-fsl-mc-msi.o
 obj-$(CONFIG_PARTITION_PERCPU)		+=3D irq-partition-percpu.o
diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-com=
mon.h
index ccba8b0fe0f5..21e4e8f6ba70 100644
--- a/drivers/irqchip/irq-gic-common.h
+++ b/drivers/irqchip/irq-gic-common.h
@@ -30,4 +30,26 @@ void gic_enable_of_quirks(const struct device_node *np,
=20
 void gic_set_kvm_info(const struct gic_kvm_info *info);
=20
+/* LPI related functionality */
+/*
+ * TODO: Ideally, I think these should be moved to a different file
+ *	 such as irq-gic-v3-lpi-common.h/.c. But, keeping it here
+ *	 for now to get comments from the RFC.
+ */
+DECLARE_PER_CPU(struct cpu_lpi_count, cpu_lpi_count);
+
+__maybe_unused u32 its_read_lpi_count(struct irq_data *d, int cpu);
+void its_inc_lpi_count(struct irq_data *d, int cpu);
+void its_dec_lpi_count(struct irq_data *d, int cpu);
+unsigned int cpumask_pick_least_loaded(struct irq_data *d,
+				       const struct cpumask *cpu_mask);
+int its_irq_gic_domain_alloc(struct irq_domain *domain,
+			     unsigned int virq,
+			     irq_hw_number_t hwirq);
+unsigned long *its_lpi_alloc(int nr_irqs, u32 *base, int *nr_ids);
+void its_lpi_free(unsigned long *bitmap, u32 base, u32 nr_ids);
+
+struct rdists;
+int direct_lpi_init(struct irq_domain *parent, struct rdists *rdists);
+
 #endif /* _IRQ_GIC_COMMON_H */
diff --git a/drivers/irqchip/irq-gic-v3-dlpi.c b/drivers/irqchip/irq-gic-v3=
-dlpi.c
new file mode 100644
index 000000000000..722a0630fced
--- /dev/null
+++ b/drivers/irqchip/irq-gic-v3-dlpi.c
@@ -0,0 +1,639 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Microsoft Corporation.
+ * Author: Sunil Muthuswamy <sunilmut@microsoft.com>
+ *
+ * This file implements an IRQ domain and chip to handle Direct LPI
+ * when there is no ITS, for GIC v3.
+ */
+
+#include <linux/acpi_iort.h>
+#include <linux/bitfield.h>
+#include <linux/bitmap.h>
+#include <linux/cpu.h>
+#include <linux/interrupt.h>
+#include <linux/irqdomain.h>
+#include <linux/list.h>
+#include <linux/msi.h>
+#include <linux/irq.h>
+#include <linux/percpu.h>
+#include <linux/dma-iommu.h>
+
+#include <linux/irqchip.h>
+#include <linux/irqchip/arm-gic-v3.h>
+#include <linux/irqchip/arm-gic-v4.h>
+
+#include "irq-gic-common.h"
+
+static struct rdists *gic_rdists;
+
+#define gic_data_rdist_cpu(cpu)		(per_cpu_ptr(gic_rdists->rdist, cpu))
+
+#define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
+
+/*
+ * Structure that holds most of the infrastructure needed to support
+ * DirectLPI without an ITS.
+ *
+ * dev_alloc_lock has to be taken for device allocations, while the
+ * spinlock must be taken to parse data structures such as the device
+ * list.
+ */
+
+struct direct_lpi {
+	raw_spinlock_t		lock;
+	struct mutex		dev_alloc_lock;
+	struct list_head	entry;
+	struct fwnode_handle	*fwnode_handle;
+	struct list_head	device_list;
+	u64			flags;
+	unsigned int		msi_domain_flags;
+};
+
+struct event_lpi_map {
+	unsigned long		*lpi_map;
+	u16			*col_map;
+	irq_hw_number_t		lpi_base;
+	int			nr_lpis;
+};
+
+struct direct_lpi_device {
+	struct list_head	entry;
+	struct direct_lpi	*dlpi;
+	struct event_lpi_map	event_map;
+	u32			device_id;
+	bool			shared;
+};
+
+static int dlpi_irq_domain_alloc(struct irq_domain *domain, unsigned int v=
irq,
+				unsigned int nr_irqs, void *args);
+
+static void dlpi_irq_domain_free(struct irq_domain *domain, unsigned int v=
irq,
+				unsigned int nr_irqs);
+
+static int dlpi_irq_domain_activate(struct irq_domain *domain,
+				   struct irq_data *d, bool reserve);
+
+static void dlpi_irq_domain_deactivate(struct irq_domain *domain,
+				      struct irq_data *d);
+
+static const struct irq_domain_ops dlpi_domain_ops =3D {
+	.alloc			=3D dlpi_irq_domain_alloc,
+	.free			=3D dlpi_irq_domain_free,
+	.activate		=3D dlpi_irq_domain_activate,
+	.deactivate		=3D dlpi_irq_domain_deactivate,
+};
+
+static int dlpi_msi_prepare(struct irq_domain *domain, struct device *dev,
+			   int nvec, msi_alloc_info_t *info);
+
+static struct msi_domain_ops dlpi_msi_domain_ops =3D {
+	.msi_prepare	=3D dlpi_msi_prepare,
+};
+
+static int dlpi_init_domain(struct fwnode_handle *handle,
+			      struct irq_domain *parent_domain,
+			      struct direct_lpi *dlpi)
+{
+	struct irq_domain *inner_domain;
+	struct msi_domain_info *info;
+
+	info =3D kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	inner_domain =3D irq_domain_create_tree(handle, &dlpi_domain_ops, NULL);
+	if (!inner_domain) {
+		kfree(info);
+		return -ENOMEM;
+	}
+
+	inner_domain->parent =3D parent_domain;
+	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_NEXUS);
+	inner_domain->flags |=3D dlpi->msi_domain_flags;
+	info->ops =3D &dlpi_msi_domain_ops;
+	info->data =3D dlpi;
+	inner_domain->host_data =3D info;
+
+	return 0;
+}
+
+int __init direct_lpi_init(struct irq_domain *parent, struct rdists *rdist=
s)
+{
+	struct fwnode_handle *fwnode;
+	int err;
+	struct direct_lpi *dlpi =3D NULL;
+
+	gic_rdists =3D rdists;
+	fwnode =3D irq_domain_alloc_named_fwnode("Direct LPI");
+	if (!fwnode)
+		return -ENOMEM;
+
+	/*
+	 * Registering with the iort allows other services to query the
+	 * fwnode. But, the registration requires an ITS ID and base address,
+	 * which does not apply here. So, probably best to just export the
+	 * fwnode handle for other services. Keeping it here for comments
+	 * from RFC submission.
+	 */
+	err =3D iort_register_domain_token(0, 0, fwnode);
+	if (err)
+		goto out_free_fwnode;
+
+	dlpi =3D kzalloc(sizeof(*dlpi), GFP_KERNEL);
+	if (!dlpi) {
+		err =3D -ENOMEM;
+		goto out_unregister_fwnode;
+	}
+
+	raw_spin_lock_init(&dlpi->lock);
+	mutex_init(&dlpi->dev_alloc_lock);
+	INIT_LIST_HEAD(&dlpi->entry);
+	INIT_LIST_HEAD(&dlpi->device_list);
+	dlpi->msi_domain_flags =3D IRQ_DOMAIN_FLAG_MSI_REMAP;
+	err =3D dlpi_init_domain(fwnode, parent, dlpi);
+	if (err)
+		goto out_unregister_fwnode;
+
+	return 0;
+
+out_unregister_fwnode:
+	iort_deregister_domain_token(0);
+out_free_fwnode:
+	irq_domain_free_fwnode(fwnode);
+	kfree(dlpi);
+
+	return err;
+
+}
+
+static inline u32 dlpi_get_event_id(struct irq_data *d)
+{
+	struct direct_lpi_device *dlpi_dev =3D irq_data_get_irq_chip_data(d);
+
+	return d->hwirq - dlpi_dev->event_map.lpi_base;
+}
+
+static int dlpi_irq_to_cpuid(struct irq_data *d, unsigned long *flags)
+{
+	int cpu;
+
+	/* Physical LPIs are already locked via the irq_desc lock */
+	struct direct_lpi_device *dlpi_dev =3D
+		irq_data_get_irq_chip_data(d);
+	cpu =3D dlpi_dev->event_map.col_map[dlpi_get_event_id(d)];
+	/* Keep GCC quiet... */
+	*flags =3D 0;
+
+	return cpu;
+}
+
+/*
+ * irqchip functions - assumes MSI, mostly.
+ */
+//TODO: Maybe its::lpi_write_config can call into this routine
+static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
+{
+	irq_hw_number_t hwirq;
+	void *va;
+	u8 *cfg;
+
+	va =3D gic_rdists->prop_table_va;
+	hwirq =3D d->hwirq;
+	cfg =3D va + hwirq - 8192;
+	*cfg &=3D ~clr;
+	*cfg |=3D set | LPI_PROP_GROUP1;
+
+	/*
+	 * Make the above write visible to the redistributors.
+	 * And yes, we're flushing exactly: One. Single. Byte.
+	 * Humpf...
+	 */
+	if (gic_rdists->flags & RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING)
+		gic_flush_dcache_to_poc(cfg, sizeof(*cfg));
+	else
+		dsb(ishst);
+}
+
+static void wait_for_syncr(void __iomem *rdbase)
+{
+	while (readl_relaxed(rdbase + GICR_SYNCR) & 1)
+		cpu_relax();
+}
+
+static void dlpi_direct_lpi_inv(struct irq_data *d)
+{
+	void __iomem *rdbase;
+	unsigned long flags;
+	u64 val;
+	int cpu;
+
+	val =3D d->hwirq;
+
+	/* Target the redistributor this LPI is currently routed to */
+	cpu =3D dlpi_irq_to_cpuid(d, &flags);
+	raw_spin_lock(&gic_data_rdist_cpu(cpu)->rd_lock);
+	rdbase =3D per_cpu_ptr(gic_rdists->rdist, cpu)->rd_base;
+	gic_write_lpir(val, rdbase + GICR_INVLPIR);
+	wait_for_syncr(rdbase);
+	raw_spin_unlock(&gic_data_rdist_cpu(cpu)->rd_lock);
+}
+
+static int dlpi_alloc_device_irq(struct direct_lpi_device *dlpi_dev,
+				 int nvecs, irq_hw_number_t *hwirq)
+{
+	int idx;
+
+	/* Find a free LPI region in lpi_map and allocate them. */
+	idx =3D bitmap_find_free_region(dlpi_dev->event_map.lpi_map,
+				      dlpi_dev->event_map.nr_lpis,
+				      get_count_order(nvecs));
+	if (idx < 0)
+		return -ENOSPC;
+
+	*hwirq =3D dlpi_dev->event_map.lpi_base + idx;
+
+	return 0;
+}
+
+static void no_lpi_update_config(struct irq_data *d, u8 clr, u8 set)
+{
+	lpi_write_config(d, clr, set);
+	dlpi_direct_lpi_inv(d);
+}
+
+static void dlpi_unmask_irq(struct irq_data *d)
+{
+	no_lpi_update_config(d, 0, LPI_PROP_ENABLED);
+}
+
+static void dlpi_mask_irq(struct irq_data *d)
+{
+	no_lpi_update_config(d, LPI_PROP_ENABLED, 0);
+}
+
+static int dlpi_select_cpu(struct irq_data *d,
+			   const struct cpumask *aff_mask)
+{
+	cpumask_var_t tmpmask;
+	int cpu;
+
+	if (!alloc_cpumask_var(&tmpmask, GFP_ATOMIC))
+		return -ENOMEM;
+
+	/* There is no NUMA node affliation */
+	if (!irqd_affinity_is_managed(d)) {
+		/* Try the intersection of the affinity and online masks */
+		cpumask_and(tmpmask, aff_mask, cpu_online_mask);
+
+		/* If that doesn't fly, the online mask is the last resort */
+		if (cpumask_empty(tmpmask))
+			cpumask_copy(tmpmask, cpu_online_mask);
+
+		cpu =3D cpumask_pick_least_loaded(d, tmpmask);
+	} else {
+		cpumask_and(tmpmask, irq_data_get_affinity_mask(d), cpu_online_mask);
+		cpu =3D cpumask_pick_least_loaded(d, tmpmask);
+	}
+
+	free_cpumask_var(tmpmask);
+	pr_debug("IRQ%d -> %*pbl CPU%d\n", d->irq, cpumask_pr_args(aff_mask), cpu=
);
+
+	return cpu;
+}
+
+static int dlpi_set_affinity(struct irq_data *d, const struct cpumask *mas=
k_val,
+			     bool force)
+{
+	struct direct_lpi_device *dlpi_dev =3D irq_data_get_irq_chip_data(d);
+	u32 id =3D dlpi_get_event_id(d);
+	int cpu, prev_cpu;
+
+	/*
+	 * A forwarded interrupt should use irq_set_vcpu_affinity. Anyways,
+	 * vcpu is not supported for Direct LPI, as it requires an ITS.
+	 */
+	if (irqd_is_forwarded_to_vcpu(d))
+		return -EINVAL;
+
+	prev_cpu =3D dlpi_dev->event_map.col_map[id];
+	its_dec_lpi_count(d, prev_cpu);
+
+	if (!force)
+		cpu =3D dlpi_select_cpu(d, mask_val);
+	else
+		cpu =3D cpumask_pick_least_loaded(d, mask_val);
+
+	if (cpu < 0 || cpu >=3D nr_cpu_ids)
+		goto err;
+
+	/* don't set the affinity when the target cpu is same as current one */
+	if (cpu !=3D prev_cpu) {
+		dlpi_dev->event_map.col_map[id] =3D cpu;
+		irq_data_update_effective_affinity(d, cpumask_of(cpu));
+	}
+
+	its_inc_lpi_count(d, cpu);
+
+	return IRQ_SET_MASK_OK_DONE;
+
+err:
+	its_inc_lpi_count(d, prev_cpu);
+	return -EINVAL;
+}
+
+static u64 dlpi_get_msi_base(struct irq_data *d)
+{
+	u64 addr;
+	int cpu;
+	unsigned long flags;
+
+	cpu =3D dlpi_irq_to_cpuid(d, &flags);
+	addr =3D (u64)(per_cpu_ptr(gic_rdists->rdist, cpu)->rd_base +
+		     GICR_SETLPIR);
+
+	return addr;
+}
+
+/*
+ * As per the spec, MSI address is the address of the target processor's
+ * GICR_SETLPIR location.
+ */
+static void dlpi_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *m=
sg)
+{
+	u64 addr;
+
+	addr =3D dlpi_get_msi_base(d);
+
+	msg->address_lo		=3D lower_32_bits(addr);
+	msg->address_hi		=3D upper_32_bits(addr);
+	msg->data		=3D dlpi_get_event_id(d);
+
+	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(d), msg);
+}
+
+static int dlpi_irq_set_irqchip_state(struct irq_data *d,
+				     enum irqchip_irq_state which,
+				     bool state)
+{
+	if (which !=3D IRQCHIP_STATE_PENDING)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int dlpi_irq_retrigger(struct irq_data *d)
+{
+	return !dlpi_irq_set_irqchip_state(d, IRQCHIP_STATE_PENDING, true);
+}
+
+static int dlpi_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
+{
+	/* vCPU support requires an ITS */
+	return -EINVAL;
+}
+
+static struct irq_chip dlpi_irq_chip =3D {
+	.name			=3D "Direct LPI",
+	.irq_mask		=3D dlpi_mask_irq,
+	.irq_unmask		=3D dlpi_unmask_irq,
+	.irq_eoi		=3D irq_chip_eoi_parent,
+	.irq_set_affinity	=3D dlpi_set_affinity,
+	.irq_compose_msi_msg	=3D dlpi_irq_compose_msi_msg,
+	.irq_set_irqchip_state	=3D dlpi_irq_set_irqchip_state,
+	.irq_retrigger		=3D dlpi_irq_retrigger,
+	.irq_set_vcpu_affinity	=3D dlpi_irq_set_vcpu_affinity,
+};
+
+static int dlpi_irq_domain_alloc(struct irq_domain *domain, unsigned int v=
irq,
+				 unsigned int nr_irqs, void *args)
+{
+	msi_alloc_info_t *info =3D args;
+	struct direct_lpi_device *dlpi_dev =3D info->scratchpad[0].ptr;
+	struct irq_data *irqd;
+	irq_hw_number_t hwirq;
+	int err;
+	int i;
+
+	err =3D dlpi_alloc_device_irq(dlpi_dev, nr_irqs, &hwirq);
+	if (err)
+		return err;
+
+	/*
+	 * TODO: Need to call 'iommu_dma_prepare_msi' to prepare for DMA,
+	 *	 but, that requires an MSI address. And, for Direct LPI
+	 *	 the MSI address comes from the Redistributor from
+	 *	 'GICR_SETLPIR', which is per CPU and that is not known
+	 *	 at the moment. Not sure what is the best way to handle
+	 *	 this.
+	 */
+
+	/*
+	err =3D iommu_dma_prepare_msi(info->desc, its->get_msi_base(its_dev));
+	if (err)
+		return err;
+	*/
+
+	for (i =3D 0; i < nr_irqs; i++) {
+		err =3D its_irq_gic_domain_alloc(domain, virq + i, hwirq + i);
+		if (err)
+			return err;
+
+		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
+					      &dlpi_irq_chip, dlpi_dev);
+		irqd =3D irq_get_irq_data(virq + i);
+		irqd_set_single_target(irqd);
+		irqd_set_affinity_on_activate(irqd);
+		pr_debug("ID:%d pID:%d vID:%d\n",
+			 (int)(hwirq + i - dlpi_dev->event_map.lpi_base),
+			 (int)(hwirq + i), virq + i);
+	}
+
+	return 0;
+}
+
+static void dlpi_free_device(struct direct_lpi_device *dlpi_dev)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&dlpi_dev->dlpi->lock, flags);
+	list_del(&dlpi_dev->entry);
+	raw_spin_unlock_irqrestore(&dlpi_dev->dlpi->lock, flags);
+	kfree(dlpi_dev->event_map.col_map);
+	kfree(dlpi_dev->event_map.lpi_map);
+	kfree(dlpi_dev);
+}
+
+static void dlpi_irq_domain_free(struct irq_domain *domain, unsigned int v=
irq,
+				unsigned int nr_irqs)
+{
+	struct irq_data *d =3D irq_domain_get_irq_data(domain, virq);
+	struct direct_lpi_device *dlpi_dev =3D irq_data_get_irq_chip_data(d);
+	int i;
+	struct direct_lpi *dlpi =3D dlpi_dev->dlpi;
+
+	bitmap_release_region(dlpi_dev->event_map.lpi_map,
+			      dlpi_get_event_id(irq_domain_get_irq_data(domain, virq)),
+			      get_count_order(nr_irqs));
+
+	for (i =3D 0; i < nr_irqs; i++) {
+		struct irq_data *data =3D irq_domain_get_irq_data(domain,
+								virq + i);
+		/* Nuke the entry in the domain */
+		irq_domain_reset_irq_data(data);
+	}
+
+	mutex_lock(&dlpi->dev_alloc_lock);
+
+	/*
+	 * If all interrupts have been freed, start mopping the
+	 * floor. This is conditionned on the device not being shared.
+	 */
+	if (!dlpi_dev->shared &&
+	    bitmap_empty(dlpi_dev->event_map.lpi_map,
+			 dlpi_dev->event_map.nr_lpis)) {
+		its_lpi_free(dlpi_dev->event_map.lpi_map,
+			     dlpi_dev->event_map.lpi_base,
+			     dlpi_dev->event_map.nr_lpis);
+
+		dlpi_free_device(dlpi_dev);
+	}
+
+	mutex_unlock(&dlpi->dev_alloc_lock);
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+}
+
+static int dlpi_irq_domain_activate(struct irq_domain *domain,
+				   struct irq_data *d, bool reserve)
+{
+	struct direct_lpi_device *dlpi_dev =3D irq_data_get_irq_chip_data(d);
+	u32 event;
+	int cpu;
+
+	event =3D dlpi_get_event_id(d);
+	cpu =3D dlpi_select_cpu(d, cpu_online_mask);
+	if (cpu < 0 || cpu >=3D nr_cpu_ids)
+		return -EINVAL;
+
+	its_inc_lpi_count(d, cpu);
+	dlpi_dev->event_map.col_map[event] =3D cpu;
+	irq_data_update_effective_affinity(d, cpumask_of(cpu));
+
+	return 0;
+}
+
+static void dlpi_irq_domain_deactivate(struct irq_domain *domain,
+				      struct irq_data *d)
+{
+	struct direct_lpi_device *dlpi_dev =3D irq_data_get_irq_chip_data(d);
+	u32 event =3D dlpi_get_event_id(d);
+
+	its_dec_lpi_count(d, dlpi_dev->event_map.col_map[event]);
+}
+
+static struct direct_lpi_device *dlpi_create_device(struct direct_lpi *dlp=
i,
+					u32 dev_id, int nvecs, bool alloc_lpis)
+{
+	struct direct_lpi_device *dlpi_dev =3D NULL;
+	unsigned long *lpi_map =3D NULL;
+	u16 *col_map =3D NULL;
+	int lpi_base;
+	int nr_lpis;
+	unsigned long flags;
+
+	if (WARN_ON(!is_power_of_2(nvecs)))
+		nvecs =3D roundup_pow_of_two(nvecs);
+
+	dlpi_dev =3D kzalloc(sizeof(*dlpi_dev), GFP_KERNEL);
+	if (!dlpi_dev)
+		return NULL;
+
+	lpi_map =3D its_lpi_alloc(nvecs, &lpi_base, &nr_lpis);
+	if (!lpi_map) {
+		kfree(dlpi_dev);
+		return NULL;
+	}
+
+	col_map =3D kcalloc(nr_lpis, sizeof(*col_map), GFP_KERNEL);
+	if (!col_map) {
+		kfree(dlpi_dev);
+		kfree(lpi_map);
+		return NULL;
+	}
+
+	dlpi_dev->dlpi =3D dlpi;
+	dlpi_dev->event_map.lpi_map =3D lpi_map;
+	dlpi_dev->event_map.col_map =3D col_map;
+	dlpi_dev->event_map.lpi_base =3D lpi_base;
+	dlpi_dev->event_map.nr_lpis =3D nr_lpis;
+	dlpi_dev->device_id =3D dev_id;
+
+	raw_spin_lock_irqsave(&dlpi->lock, flags);
+	list_add(&dlpi_dev->entry, &dlpi->device_list);
+	raw_spin_unlock_irqrestore(&dlpi->lock, flags);
+
+	return dlpi_dev;
+}
+
+static struct direct_lpi_device *dlpi_find_device(struct direct_lpi *dlpi,=
 u32 dev_id)
+{
+	struct direct_lpi_device *dlpi_dev =3D NULL, *tmp;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&dlpi->lock, flags);
+	list_for_each_entry(tmp, &dlpi->device_list, entry) {
+		if (tmp->device_id =3D=3D dev_id) {
+			dlpi_dev =3D tmp;
+			break;
+		}
+	}
+
+	raw_spin_unlock_irqrestore(&dlpi->lock, flags);
+
+	return dlpi_dev;
+}
+
+static int dlpi_msi_prepare(struct irq_domain *domain, struct device *dev,
+			   int nvec, msi_alloc_info_t *info)
+{
+	struct direct_lpi_device *dlpi_dev;
+	struct direct_lpi *dlpi;
+	struct msi_domain_info *msi_info;
+	u32 dev_id;
+	int err =3D 0;
+
+	/*
+	 * We ignore "dev" entirely, and rely on the dev_id that has
+	 * been passed via the scratchpad. This limits this domain's
+	 * usefulness to upper layers that definitely know that they
+	 * are built on top of the ITS.
+	 */
+	dev_id =3D info->scratchpad[0].ul;
+	msi_info =3D msi_get_domain_info(domain);
+	dlpi =3D msi_info->data;
+
+	mutex_lock(&dlpi->dev_alloc_lock);
+	dlpi_dev =3D dlpi_find_device(dlpi, dev_id);
+	if (dlpi_dev) {
+		/*
+		 * We already have seen this ID, probably through
+		 * another alias (PCI bridge of some sort). No need to
+		 * create the device.
+		 */
+		dlpi_dev->shared =3D true;
+		pr_debug("Reusing ITT for devID %x\n", dev_id);
+		goto out;
+	}
+
+	dlpi_dev =3D dlpi_create_device(dlpi, dev_id, nvec, true);
+	if (!dlpi_dev) {
+		err =3D -ENOMEM;
+		goto out;
+	}
+
+out:
+	mutex_unlock(&dlpi->dev_alloc_lock);
+	info->scratchpad[0].ptr =3D dlpi_dev;
+
+	return err;
+}
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-=
its.c
index ba39668c3e08..aa101dfcbbfc 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -178,7 +178,7 @@ struct cpu_lpi_count {
 	atomic_t	unmanaged;
 };
=20
-static DEFINE_PER_CPU(struct cpu_lpi_count, cpu_lpi_count);
+DEFINE_PER_CPU(struct cpu_lpi_count, cpu_lpi_count);
=20
 static LIST_HEAD(its_nodes);
 static DEFINE_RAW_SPINLOCK(its_lock);
@@ -1521,7 +1521,7 @@ static void its_unmask_irq(struct irq_data *d)
 	lpi_update_config(d, 0, LPI_PROP_ENABLED);
 }
=20
-static __maybe_unused u32 its_read_lpi_count(struct irq_data *d, int cpu)
+__maybe_unused u32 its_read_lpi_count(struct irq_data *d, int cpu)
 {
 	if (irqd_affinity_is_managed(d))
 		return atomic_read(&per_cpu_ptr(&cpu_lpi_count, cpu)->managed);
@@ -1529,7 +1529,7 @@ static __maybe_unused u32 its_read_lpi_count(struct i=
rq_data *d, int cpu)
 	return atomic_read(&per_cpu_ptr(&cpu_lpi_count, cpu)->unmanaged);
 }
=20
-static void its_inc_lpi_count(struct irq_data *d, int cpu)
+void its_inc_lpi_count(struct irq_data *d, int cpu)
 {
 	if (irqd_affinity_is_managed(d))
 		atomic_inc(&per_cpu_ptr(&cpu_lpi_count, cpu)->managed);
@@ -1537,7 +1537,7 @@ static void its_inc_lpi_count(struct irq_data *d, int=
 cpu)
 		atomic_inc(&per_cpu_ptr(&cpu_lpi_count, cpu)->unmanaged);
 }
=20
-static void its_dec_lpi_count(struct irq_data *d, int cpu)
+void its_dec_lpi_count(struct irq_data *d, int cpu)
 {
 	if (irqd_affinity_is_managed(d))
 		atomic_dec(&per_cpu_ptr(&cpu_lpi_count, cpu)->managed);
@@ -1545,7 +1545,7 @@ static void its_dec_lpi_count(struct irq_data *d, int=
 cpu)
 		atomic_dec(&per_cpu_ptr(&cpu_lpi_count, cpu)->unmanaged);
 }
=20
-static unsigned int cpumask_pick_least_loaded(struct irq_data *d,
+unsigned int cpumask_pick_least_loaded(struct irq_data *d,
 					      const struct cpumask *cpu_mask)
 {
 	unsigned int cpu =3D nr_cpu_ids, tmp;
@@ -2121,7 +2121,7 @@ static int __init its_lpi_init(u32 id_bits)
 	return err;
 }
=20
-static unsigned long *its_lpi_alloc(int nr_irqs, u32 *base, int *nr_ids)
+unsigned long *its_lpi_alloc(int nr_irqs, u32 *base, int *nr_ids)
 {
 	unsigned long *bitmap =3D NULL;
 	int err =3D 0;
@@ -2153,7 +2153,7 @@ static unsigned long *its_lpi_alloc(int nr_irqs, u32 =
*base, int *nr_ids)
 	return bitmap;
 }
=20
-static void its_lpi_free(unsigned long *bitmap, u32 base, u32 nr_ids)
+void its_lpi_free(unsigned long *bitmap, u32 base, u32 nr_ids)
 {
 	WARN_ON(free_lpi_range(base, nr_ids));
 	kfree(bitmap);
@@ -3506,9 +3506,9 @@ static struct msi_domain_ops its_msi_domain_ops =3D {
 	.msi_prepare	=3D its_msi_prepare,
 };
=20
-static int its_irq_gic_domain_alloc(struct irq_domain *domain,
-				    unsigned int virq,
-				    irq_hw_number_t hwirq)
+int its_irq_gic_domain_alloc(struct irq_domain *domain,
+			     unsigned int virq,
+			     irq_hw_number_t hwirq)
 {
 	struct irq_fwspec fwspec;
=20
@@ -5186,16 +5186,21 @@ static int redist_disable_lpis(void)
=20
 int its_cpu_init(void)
 {
-	if (!list_empty(&its_nodes)) {
-		int ret;
+	int ret;
+
+	/* LPI's can be supported with an ITS or with DirectLPI */
+	if (list_empty(&its_nodes) && !gic_rdists->has_direct_lpi)
+		return 0;
+
+	ret =3D redist_disable_lpis();
+	if (ret)
+		return ret;
=20
-		ret =3D redist_disable_lpis();
-		if (ret)
-			return ret;
+	its_cpu_init_lpis();
=20
-		its_cpu_init_lpis();
+	/* collections require an ITS */
+	if (!list_empty(&its_nodes))
 		its_cpu_init_collections();
-	}
=20
 	return 0;
 }
@@ -5402,8 +5407,16 @@ int __init its_init(struct fwnode_handle *handle, st=
ruct rdists *rdists,
 		its_acpi_probe();
=20
 	if (list_empty(&its_nodes)) {
-		pr_warn("ITS: No ITS available, not enabling LPIs\n");
-		return -ENXIO;
+		/* DirectLPI without ITS is architecturally supported. */
+		if (gic_rdists->has_direct_lpi) {
+			pr_info("Direct LPI with no ITS\n");
+			err =3D direct_lpi_init(parent_domain, rdists);
+			if (err)
+				return err;
+		} else {
+			pr_warn("ITS: No ITS or Direct LPI available, not enabling LPIs\n");
+			return -ENXIO;
+		}
 	}
=20
 	err =3D allocate_lpi_tables();
--=20
2.17.1

