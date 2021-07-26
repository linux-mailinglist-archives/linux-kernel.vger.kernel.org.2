Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5F13D5D10
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 17:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbhGZOxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 10:53:16 -0400
Received: from mail-bn1nam07on2105.outbound.protection.outlook.com ([40.107.212.105]:62855
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234546AbhGZOxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 10:53:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZV3QAQa3AH9dB28hkgSvBUsPH/ykoBgasmBbYlzUpZgyloPVTjpsIunC7WimCkD9VyKIQhdKgu9Ca8EL9dydQm9X3DkP1kUWPVejY0mH0DfET39tn/GQtu+npOeX2Pi7bZPcT4pFfz4+1h6I8ajsBWyso3LS1Ug4FKI9Wt4p12j5lqF/BNMzlVFRTg+O08pwmIREVma/xF0+2GWTNDKb58UbBlGJOr3m+UPODXL1K3CMYqBS4suoOydEGEUOtwoJCUhn2iurAQ8g+D9BM8LWQALshjCbA4Cc44OwnFWQYsCr12GwkSJQF8ZIaxaJNYJycn8R+1MxYyxpLLnyDkRnTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpHGBcBekL2y1RhLfWHLQTMI9l/JPJSyFEZVKBL6wJk=;
 b=frdokQibLEIPUqQSxO673f1Jyk7/SCwNAgBq+a/o9NMgcWDsyjJdfRWZvdz8LCEG8qTpEzSocZ8WaNArXR3KclL5qfTNinVQ2bhlzqizEoDz5+pOleJk38aTlm/5Sr2h/9u+1xDHPGtC75t3Fm7WDTMdwnZ/xMM7ayOvj9doIf44mKj/ObbdrTeFsvmhAjxeMqEHWloKiKiIX/Li1XZVNy6mpEMsjR3bPcjwHCCs2ny26IGs9mjydLuOZf/5K8Wdn7hLDy3nhd+pMwk/aRIHvlJ4EYV+CGCSUVLsK3hJiUUnYMeKbXvKpE7lp4OKUwTGO2hArV76WPa0+sQ+mZrBOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpHGBcBekL2y1RhLfWHLQTMI9l/JPJSyFEZVKBL6wJk=;
 b=FY9Dyr0ReZL/7Fmkw3RTFCbe6BVHaIR4BY3C2iBZ2Txdtmj5933/2l7rOw4A/st7zYTpsFxF6FqzT44BOOldm5ZwFre1R/vKuMOLMWKieOIapmZ1EfHN5BidkCQpC+fFZS57rVD5iEDFfAflcpMblgD+qRh7KVUN6qsEt8xMFxA=
Received: from MW4PR21MB2002.namprd21.prod.outlook.com (2603:10b6:303:68::18)
 by MWHPR21MB0189.namprd21.prod.outlook.com (2603:10b6:300:79::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.2; Mon, 26 Jul
 2021 15:33:39 +0000
Received: from MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::292a:eeea:ee64:3f51]) by MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::292a:eeea:ee64:3f51%4]) with mapi id 15.20.4394.004; Mon, 26 Jul 2021
 15:33:39 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: RE: [EXTERNAL] Re: [RFC 1/1] irqchip/gic-v3-its: Add irq domain and
 chip for Direct LPI without ITS
Thread-Topic: [EXTERNAL] Re: [RFC 1/1] irqchip/gic-v3-its: Add irq domain and
 chip for Direct LPI without ITS
Thread-Index: Add0L2f934gE0okbTBC5z2WK9cOcFQCFdR6AAvoodNA=
Date:   Mon, 26 Jul 2021 15:33:39 +0000
Message-ID: <MW4PR21MB2002E51429F7E13B61A34FFEC0E89@MW4PR21MB2002.namprd21.prod.outlook.com>
References: <MW4PR21MB2002BA20FA4A8DAA1C27F4C6C0199@MW4PR21MB2002.namprd21.prod.outlook.com>
 <87a6mt2jke.wl-maz@kernel.org>
In-Reply-To: <87a6mt2jke.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb0cbcee-68bc-4bfe-77d2-08d9504abdd8
x-ms-traffictypediagnostic: MWHPR21MB0189:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB0189BDDE52C81F80DB350749C0E89@MWHPR21MB0189.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: znL24Gf9B4von5kK/cIWAG+RqDou9WbY7aYAwaHMfkKBFGCP5ZWKJWeo0D5YyPmbubKNOOr58Q97W37kSsXsaqu5xPR/kHGRJSQUt2GnsiTd3/rQFiKTLMPyeJfaIFmVfaWJJrDqTFGRTyhm+pCtBX1dn4T0zT7BgK0XgFoI4byLkYUAmBRDKDvfWy6IWxikWwt6jMM1cE3+HVqUvD0lO2sqwySfCECP2/Po4lXA788ML6pWikn+FHvjIoL/I/6Ot6ddL3brxhe0lRHGoJ70NbzOZAF/btsx4OvRS06KLzM/+xZxRnV2ZOeJe3vqHVCjx0R+SrwNlxVG9X77322XxxQoGhai8foKjgHbR1kxB5CUpQtVjzveIQ6Iju/stsjCZeDE8CVEAR0xAvqpiHtIM0o8dwbngGnk+5fH0PzzSKxVtdD/2X/Y58bShfmTWTgUdgdBzgCqBX6FVJlJz1VpF06UUeboLJxm1vjbabUOywh0R2q9fvMLvKYX9cENxmtgv5ZrUyuOU500PkZP9rh8sJXpIfn8efymDFN6587F3qvSB4uNIcVRy0zk61g7LYUmiS7APGRNSA31MihyEexSvmuqM5y3YATHGcWr96mnJwvf9FcR46vThfISjmsYrTsESpG4UBLJwSAyBHM0x3lhC6G20QZASl+uh+sSTTBxTWJwZ20SO96RUu7q/d66xP7QJcztMVXdS1NkzBkzqmXZTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB2002.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(8936002)(76116006)(83380400001)(71200400001)(6506007)(55016002)(8676002)(122000001)(2906002)(10290500003)(30864003)(66946007)(66476007)(8990500004)(508600001)(33656002)(316002)(9686003)(54906003)(66556008)(66446008)(86362001)(52536014)(64756008)(186003)(82960400001)(38100700002)(5660300002)(82950400001)(7696005)(6916009)(38070700004)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RmStIscjTdcsJ10dIt8oXsku6HquLnJ/btlC06YZ8ViYK1RkBRoTs4U7HC2a?=
 =?us-ascii?Q?xMnO8wIjPWGtQ2z8Vwsvty3TRo6PYW40rdyqJoKPjumBJqbcogs99s+iJzZt?=
 =?us-ascii?Q?RsrFOQBVvcsNhsjAoXWz62XtdIER9rJ1syczVDJm6mN04j4ph+O870GMr3G/?=
 =?us-ascii?Q?pCh/D0yJGhj38L7beoqeDJleWpBVm45eGObKqQCsMWY4AnzMf/tOWdWVfxUl?=
 =?us-ascii?Q?XHx/N1AD/CBKxbuxIUml9RQwEI4pVfZKSj7dh/vTmiSrJyCpl+/6dZ/+Ah8a?=
 =?us-ascii?Q?ygjaxSCyuZK9lTB+IWxZDNBO6hXvqz8pbh1xlZz2uY98vLdsOKhb8jfG7qMr?=
 =?us-ascii?Q?C1H8ZTw0fLoLlum9mhhzhrlL8QFCpDN3TQfs1N+OiOLBodDqqK85Hd+jLleD?=
 =?us-ascii?Q?R4In9/H9QQiGDB5r+vqpvoxlIfFMm3jJ7Wrdghv7GbSHVBntw9AbLJerYimz?=
 =?us-ascii?Q?a3v6VweyOE3osSv/t9U0T+twE0CZqODyNT3VPDq0oaVHBhYnxJdhyZYPSxdW?=
 =?us-ascii?Q?U49tIlnTYoFJHk3A2XtGoIFjce14JlzTDdRueKNGjDD8z4iZ+PRuo2WPCggU?=
 =?us-ascii?Q?Cn32yfa3ul0kxOalTDSp8JgISfiLd98YOD/O7QB+mwxJmATCHrDdV0P7AuUk?=
 =?us-ascii?Q?kjKUwLb6gIEL7C9SpXcDb9M5gu0ejeWdZJCtGFwPqH1Q1mDKnjQ8ojALVlyP?=
 =?us-ascii?Q?HSo0o+oHxe2NTCYJHBYl3ADqsspcgO6z4IBqAw3T97cTFthKFQdduRqmFKl5?=
 =?us-ascii?Q?KxcgFL0s5aAMtf+UIv833CNBWPutTvX5nrztacttH2remU5vCSJyLF3LXIUx?=
 =?us-ascii?Q?ybS2UZzK2Uey5MugTxjq7o2pPg+0DBiauhx/+Ud54IRSCE5vcBTxM173YDrv?=
 =?us-ascii?Q?lkbRWjFTjY6MGtdCxJLKwroOtyWp365Na2ziJE/GgCSk5OXnSZwIl3jQGCvV?=
 =?us-ascii?Q?RqPF+ALdJPvIP6n+Vt6MrJKXOEzE3EqpUqY9OOeuPghuRKrlN05INYYg+DTo?=
 =?us-ascii?Q?ROYe919oPOEDNbmAAZl7KvyfH5FJ4ndqO9Amcan17EpYiMFIU3mfmCRnIVtt?=
 =?us-ascii?Q?ulLpiSmpnLpu6eYa8ML9EK7CiZL01T2bVoun7X4FjOqgbHuIucAEX3Gb7kjV?=
 =?us-ascii?Q?2Fs52LaHESIMabCQ7c4NvxLAXMeEfuqI5o6MG3cOsgmbcTcxfLilbVODI2vI?=
 =?us-ascii?Q?J9l09Byq+VsH4IYMtECzhTp/NxxaijvAWbnibDlWYv2ZlHXxfGNzrrHJvdqV?=
 =?us-ascii?Q?9bHML2W9bl8YZjzvHcY0PiwJMJUUQWKTBCp8U8oc5wXSK3yI3d0/dq9orApf?=
 =?us-ascii?Q?PSGrBGkuMPZ6lJqVmKgIYIswpNtjfmqKbOzZJzLD1OPTjSEqWGCmOfwyvqKQ?=
 =?us-ascii?Q?0nUS5edlZEc79KrpywpJV75P58Cy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2002.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0cbcee-68bc-4bfe-77d2-08d9504abdd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2021 15:33:39.1562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9UVfUw8s4NoU5LPWw+EUyt+72x+aSOp5aLVyHFG62aBvnqzf8gi05JU4rKEPCg1IJn23ieGaCBmxO5J26bZ3hoVW6FP0PTDpsLVKUSOxDQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0189
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 08 Jul 2021 20:36:51 +0100,
> Sunil Muthuswamy <sunilmut@microsoft.com> wrote:
> >
> > The current GIC v3 driver doesn't support Direct LPI when there is
> > no ITS. The spec architecturally supports Direct LPI without an ITS.
> > This patch introduces an IRQ domain and chip to manage Direct LPI
> > when there is no ITS.
> >
> > Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> > ---
> >  drivers/irqchip/Makefile          |   2 +-
> >  drivers/irqchip/irq-gic-common.h  |  22 +
> >  drivers/irqchip/irq-gic-v3-dlpi.c | 639 ++++++++++++++++++++++++++++++
> >  drivers/irqchip/irq-gic-v3-its.c  |  51 ++-
> >  4 files changed, 694 insertions(+), 20 deletions(-)
> >  create mode 100644 drivers/irqchip/irq-gic-v3-dlpi.c
> >
> > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> > index f88cbf36a9d2..c6ea9620161b 100644
> > --- a/drivers/irqchip/Makefile
> > +++ b/drivers/irqchip/Makefile
> > @@ -32,7 +32,7 @@ obj-$(CONFIG_ARM_GIC_PM)		+=3D irq-gic-pm.o
> >  obj-$(CONFIG_ARCH_REALVIEW)		+=3D irq-gic-realview.o
> >  obj-$(CONFIG_ARM_GIC_V2M)		+=3D irq-gic-v2m.o
> >  obj-$(CONFIG_ARM_GIC_V3)		+=3D irq-gic-v3.o irq-gic-v3-mbi.o irq-gic-c=
ommon.o
> > -obj-$(CONFIG_ARM_GIC_V3_ITS)		+=3D irq-gic-v3-its.o irq-gic-v3-its-pla=
tform-msi.o irq-gic-v4.o
> > +obj-$(CONFIG_ARM_GIC_V3_ITS)		+=3D irq-gic-v3-its.o irq-gic-v3-its-pla=
tform-msi.o irq-gic-v4.o irq-gic-v3-dlpi.o
> >  obj-$(CONFIG_ARM_GIC_V3_ITS_PCI)	+=3D irq-gic-v3-its-pci-msi.o
> >  obj-$(CONFIG_ARM_GIC_V3_ITS_FSL_MC)	+=3D irq-gic-v3-its-fsl-mc-msi.o
> >  obj-$(CONFIG_PARTITION_PERCPU)		+=3D irq-partition-percpu.o
> > diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic=
-common.h
> > index ccba8b0fe0f5..21e4e8f6ba70 100644
> > --- a/drivers/irqchip/irq-gic-common.h
> > +++ b/drivers/irqchip/irq-gic-common.h
> > @@ -30,4 +30,26 @@ void gic_enable_of_quirks(const struct device_node *=
np,
> >
> >  void gic_set_kvm_info(const struct gic_kvm_info *info);
> >
> > +/* LPI related functionality */
> > +/*
> > + * TODO: Ideally, I think these should be moved to a different file
> > + *	 such as irq-gic-v3-lpi-common.h/.c. But, keeping it here
> > + *	 for now to get comments from the RFC.
> > + */
> > +DECLARE_PER_CPU(struct cpu_lpi_count, cpu_lpi_count);
> > +
> > +__maybe_unused u32 its_read_lpi_count(struct irq_data *d, int cpu);
> > +void its_inc_lpi_count(struct irq_data *d, int cpu);
> > +void its_dec_lpi_count(struct irq_data *d, int cpu);
> > +unsigned int cpumask_pick_least_loaded(struct irq_data *d,
> > +				       const struct cpumask *cpu_mask);
>=20
> Ideally, you shouldn't use this at all. At least not until we have
> figured out what you are trying to achieve. At best, this is premature
> optimisation.
>=20
> > +int its_irq_gic_domain_alloc(struct irq_domain *domain,
> > +			     unsigned int virq,
> > +			     irq_hw_number_t hwirq);
> > +unsigned long *its_lpi_alloc(int nr_irqs, u32 *base, int *nr_ids);
> > +void its_lpi_free(unsigned long *bitmap, u32 base, u32 nr_ids);
>=20
> And certainly not use these *ever*.
>=20
> > +
> > +struct rdists;
> > +int direct_lpi_init(struct irq_domain *parent, struct rdists *rdists);
> > +
> >  #endif /* _IRQ_GIC_COMMON_H */
> > diff --git a/drivers/irqchip/irq-gic-v3-dlpi.c b/drivers/irqchip/irq-gi=
c-v3-dlpi.c
> > new file mode 100644
> > index 000000000000..722a0630fced
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-gic-v3-dlpi.c
> > @@ -0,0 +1,639 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) Microsoft Corporation.
> > + * Author: Sunil Muthuswamy <sunilmut@microsoft.com>
> > + *
> > + * This file implements an IRQ domain and chip to handle Direct LPI
> > + * when there is no ITS, for GIC v3.
> > + */
> > +
> > +#include <linux/acpi_iort.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/bitmap.h>
> > +#include <linux/cpu.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/list.h>
> > +#include <linux/msi.h>
> > +#include <linux/irq.h>
> > +#include <linux/percpu.h>
> > +#include <linux/dma-iommu.h>
> > +
> > +#include <linux/irqchip.h>
> > +#include <linux/irqchip/arm-gic-v3.h>
> > +#include <linux/irqchip/arm-gic-v4.h>
> > +
> > +#include "irq-gic-common.h"
> > +
> > +static struct rdists *gic_rdists;
> > +
> > +#define gic_data_rdist_cpu(cpu)		(per_cpu_ptr(gic_rdists->rdist, cpu))
> > +
> > +#define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
> > +
> > +/*
> > + * Structure that holds most of the infrastructure needed to support
> > + * DirectLPI without an ITS.
> > + *
> > + * dev_alloc_lock has to be taken for device allocations, while the
> > + * spinlock must be taken to parse data structures such as the device
> > + * list.
> > + */
> > +
> > +struct direct_lpi {
> > +	raw_spinlock_t		lock;
> > +	struct mutex		dev_alloc_lock;
> > +	struct list_head	entry;
> > +	struct fwnode_handle	*fwnode_handle;
> > +	struct list_head	device_list;
> > +	u64			flags;
> > +	unsigned int		msi_domain_flags;
> > +};
> > +
> > +struct event_lpi_map {
> > +	unsigned long		*lpi_map;
> > +	u16			*col_map;
> > +	irq_hw_number_t		lpi_base;
> > +	int			nr_lpis;
> > +};
>=20
> DirectLPI has no notion of event, collection, or anything like
> this. It deals with LPIs, and that's it.
>=20
> > +
> > +struct direct_lpi_device {
> > +	struct list_head	entry;
> > +	struct direct_lpi	*dlpi;
> > +	struct event_lpi_map	event_map;
> > +	u32			device_id;
> > +	bool			shared;
> > +};
>=20
> Same this here. DirectLPI has no notion of DeviceID.
>=20
> > +
> > +static int dlpi_irq_domain_alloc(struct irq_domain *domain, unsigned i=
nt virq,
> > +				unsigned int nr_irqs, void *args);
> > +
> > +static void dlpi_irq_domain_free(struct irq_domain *domain, unsigned i=
nt virq,
> > +				unsigned int nr_irqs);
> > +
> > +static int dlpi_irq_domain_activate(struct irq_domain *domain,
> > +				   struct irq_data *d, bool reserve);
> > +
> > +static void dlpi_irq_domain_deactivate(struct irq_domain *domain,
> > +				      struct irq_data *d);
> > +
> > +static const struct irq_domain_ops dlpi_domain_ops =3D {
> > +	.alloc			=3D dlpi_irq_domain_alloc,
> > +	.free			=3D dlpi_irq_domain_free,
> > +	.activate		=3D dlpi_irq_domain_activate,
> > +	.deactivate		=3D dlpi_irq_domain_deactivate,
> > +};
> > +
> > +static int dlpi_msi_prepare(struct irq_domain *domain, struct device *=
dev,
> > +			   int nvec, msi_alloc_info_t *info);
> > +
> > +static struct msi_domain_ops dlpi_msi_domain_ops =3D {
> > +	.msi_prepare	=3D dlpi_msi_prepare,
> > +};
> > +
> > +static int dlpi_init_domain(struct fwnode_handle *handle,
> > +			      struct irq_domain *parent_domain,
> > +			      struct direct_lpi *dlpi)
> > +{
> > +	struct irq_domain *inner_domain;
> > +	struct msi_domain_info *info;
> > +
> > +	info =3D kzalloc(sizeof(*info), GFP_KERNEL);
> > +	if (!info)
> > +		return -ENOMEM;
> > +
> > +	inner_domain =3D irq_domain_create_tree(handle, &dlpi_domain_ops, NUL=
L);
> > +	if (!inner_domain) {
> > +		kfree(info);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	inner_domain->parent =3D parent_domain;
> > +	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_NEXUS);
> > +	inner_domain->flags |=3D dlpi->msi_domain_flags;
> > +	info->ops =3D &dlpi_msi_domain_ops;
> > +	info->data =3D dlpi;
> > +	inner_domain->host_data =3D info;
> > +
> > +	return 0;
> > +}
> > +
> > +int __init direct_lpi_init(struct irq_domain *parent, struct rdists *r=
dists)
> > +{
> > +	struct fwnode_handle *fwnode;
> > +	int err;
> > +	struct direct_lpi *dlpi =3D NULL;
> > +
> > +	gic_rdists =3D rdists;
> > +	fwnode =3D irq_domain_alloc_named_fwnode("Direct LPI");
> > +	if (!fwnode)
> > +		return -ENOMEM;
> > +
> > +	/*
> > +	 * Registering with the iort allows other services to query the
> > +	 * fwnode. But, the registration requires an ITS ID and base address,
> > +	 * which does not apply here. So, probably best to just export the
> > +	 * fwnode handle for other services. Keeping it here for comments
> > +	 * from RFC submission.
> > +	 */
> > +	err =3D iort_register_domain_token(0, 0, fwnode);
> > +	if (err)
> > +		goto out_free_fwnode;
>=20
> Please remove this. IORT has no notion of DirectLPI, and doesn't
> describe it at all.
>=20
> > +
> > +	dlpi =3D kzalloc(sizeof(*dlpi), GFP_KERNEL);
> > +	if (!dlpi) {
> > +		err =3D -ENOMEM;
> > +		goto out_unregister_fwnode;
> > +	}
> > +
> > +	raw_spin_lock_init(&dlpi->lock);
> > +	mutex_init(&dlpi->dev_alloc_lock);
> > +	INIT_LIST_HEAD(&dlpi->entry);
> > +	INIT_LIST_HEAD(&dlpi->device_list);
> > +	dlpi->msi_domain_flags =3D IRQ_DOMAIN_FLAG_MSI_REMAP;
>=20
> Remap what? There is nothing to remap at all, since you don't have an
> ITS! From a security/isolation perspective, DirectLPI is a gaping hole.
>=20
> > +	err =3D dlpi_init_domain(fwnode, parent, dlpi);
> > +	if (err)
> > +		goto out_unregister_fwnode;
> > +
> > +	return 0;
> > +
> > +out_unregister_fwnode:
> > +	iort_deregister_domain_token(0);
> > +out_free_fwnode:
> > +	irq_domain_free_fwnode(fwnode);
> > +	kfree(dlpi);
> > +
> > +	return err;
> > +
> > +}
> > +
> > +static inline u32 dlpi_get_event_id(struct irq_data *d)
> > +{
> > +	struct direct_lpi_device *dlpi_dev =3D irq_data_get_irq_chip_data(d);
> > +
> > +	return d->hwirq - dlpi_dev->event_map.lpi_base;
>=20
> This is more and more puzzling. DirectLPI *does not* perform any
> device isolation, so there is no per-device interrupt namespace. You
> are just copy-pasting bits of the ITS code without understanding the
> architecture.
>=20
> > +}
> > +
> > +static int dlpi_irq_to_cpuid(struct irq_data *d, unsigned long *flags)
> > +{
> > +	int cpu;
> > +
> > +	/* Physical LPIs are already locked via the irq_desc lock */
> > +	struct direct_lpi_device *dlpi_dev =3D
> > +		irq_data_get_irq_chip_data(d);
> > +	cpu =3D dlpi_dev->event_map.col_map[dlpi_get_event_id(d)];
> > +	/* Keep GCC quiet... */
> > +	*flags =3D 0;
>=20
> More pointless copy-paste.
>=20
> > +
> > +	return cpu;
> > +}
> > +
> > +/*
> > + * irqchip functions - assumes MSI, mostly.
> > + */
> > +//TODO: Maybe its::lpi_write_config can call into this routine
> > +static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
> > +{
> > +	irq_hw_number_t hwirq;
> > +	void *va;
> > +	u8 *cfg;
> > +
> > +	va =3D gic_rdists->prop_table_va;
> > +	hwirq =3D d->hwirq;
> > +	cfg =3D va + hwirq - 8192;
> > +	*cfg &=3D ~clr;
> > +	*cfg |=3D set | LPI_PROP_GROUP1;
> > +
> > +	/*
> > +	 * Make the above write visible to the redistributors.
> > +	 * And yes, we're flushing exactly: One. Single. Byte.
> > +	 * Humpf...
> > +	 */
> > +	if (gic_rdists->flags & RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING)
> > +		gic_flush_dcache_to_poc(cfg, sizeof(*cfg));
> > +	else
> > +		dsb(ishst);
> > +}
> > +
> > +static void wait_for_syncr(void __iomem *rdbase)
> > +{
> > +	while (readl_relaxed(rdbase + GICR_SYNCR) & 1)
> > +		cpu_relax();
> > +}
> > +
> > +static void dlpi_direct_lpi_inv(struct irq_data *d)
> > +{
> > +	void __iomem *rdbase;
> > +	unsigned long flags;
> > +	u64 val;
> > +	int cpu;
> > +
> > +	val =3D d->hwirq;
> > +
> > +	/* Target the redistributor this LPI is currently routed to */
> > +	cpu =3D dlpi_irq_to_cpuid(d, &flags);
> > +	raw_spin_lock(&gic_data_rdist_cpu(cpu)->rd_lock);
> > +	rdbase =3D per_cpu_ptr(gic_rdists->rdist, cpu)->rd_base;
> > +	gic_write_lpir(val, rdbase + GICR_INVLPIR);
> > +	wait_for_syncr(rdbase);
> > +	raw_spin_unlock(&gic_data_rdist_cpu(cpu)->rd_lock);
> > +}
> > +
> > +static int dlpi_alloc_device_irq(struct direct_lpi_device *dlpi_dev,
> > +				 int nvecs, irq_hw_number_t *hwirq)
> > +{
> > +	int idx;
> > +
> > +	/* Find a free LPI region in lpi_map and allocate them. */
> > +	idx =3D bitmap_find_free_region(dlpi_dev->event_map.lpi_map,
> > +				      dlpi_dev->event_map.nr_lpis,
> > +				      get_count_order(nvecs));
> > +	if (idx < 0)
> > +		return -ENOSPC;
> > +
> > +	*hwirq =3D dlpi_dev->event_map.lpi_base + idx;
> > +
> > +	return 0;
>=20
> Totally pointless, again. Why do you maintain a per-device allocation
> given that there is no per-device HW tracking?
>=20
> > +}
> > +
> > +static void no_lpi_update_config(struct irq_data *d, u8 clr, u8 set)
> > +{
> > +	lpi_write_config(d, clr, set);
> > +	dlpi_direct_lpi_inv(d);
> > +}
> > +
> > +static void dlpi_unmask_irq(struct irq_data *d)
> > +{
> > +	no_lpi_update_config(d, 0, LPI_PROP_ENABLED);
> > +}
> > +
> > +static void dlpi_mask_irq(struct irq_data *d)
> > +{
> > +	no_lpi_update_config(d, LPI_PROP_ENABLED, 0);
> > +}
> > +
> > +static int dlpi_select_cpu(struct irq_data *d,
> > +			   const struct cpumask *aff_mask)
> > +{
> > +	cpumask_var_t tmpmask;
> > +	int cpu;
> > +
> > +	if (!alloc_cpumask_var(&tmpmask, GFP_ATOMIC))
> > +		return -ENOMEM;
> > +
> > +	/* There is no NUMA node affliation */
>=20
> Why?
>=20
> > +	if (!irqd_affinity_is_managed(d)) {
> > +		/* Try the intersection of the affinity and online masks */
> > +		cpumask_and(tmpmask, aff_mask, cpu_online_mask);
> > +
> > +		/* If that doesn't fly, the online mask is the last resort */
> > +		if (cpumask_empty(tmpmask))
> > +			cpumask_copy(tmpmask, cpu_online_mask);
> > +
> > +		cpu =3D cpumask_pick_least_loaded(d, tmpmask);
> > +	} else {
> > +		cpumask_and(tmpmask, irq_data_get_affinity_mask(d), cpu_online_mask)=
;
> > +		cpu =3D cpumask_pick_least_loaded(d, tmpmask);
> > +	}
> > +
> > +	free_cpumask_var(tmpmask);
> > +	pr_debug("IRQ%d -> %*pbl CPU%d\n", d->irq, cpumask_pr_args(aff_mask),=
 cpu);
> > +
> > +	return cpu;
> > +}
> > +
> > +static int dlpi_set_affinity(struct irq_data *d, const struct cpumask =
*mask_val,
> > +			     bool force)
> > +{
> > +	struct direct_lpi_device *dlpi_dev =3D irq_data_get_irq_chip_data(d);
> > +	u32 id =3D dlpi_get_event_id(d);
> > +	int cpu, prev_cpu;
> > +
> > +	/*
> > +	 * A forwarded interrupt should use irq_set_vcpu_affinity. Anyways,
> > +	 * vcpu is not supported for Direct LPI, as it requires an ITS.
> > +	 */
> > +	if (irqd_is_forwarded_to_vcpu(d))
> > +		return -EINVAL;
> > +
> > +	prev_cpu =3D dlpi_dev->event_map.col_map[id];
> > +	its_dec_lpi_count(d, prev_cpu);
> > +
> > +	if (!force)
> > +		cpu =3D dlpi_select_cpu(d, mask_val);
> > +	else
> > +		cpu =3D cpumask_pick_least_loaded(d, mask_val);
> > +
> > +	if (cpu < 0 || cpu >=3D nr_cpu_ids)
> > +		goto err;
> > +
> > +	/* don't set the affinity when the target cpu is same as current one =
*/
> > +	if (cpu !=3D prev_cpu) {
> > +		dlpi_dev->event_map.col_map[id] =3D cpu;
> > +		irq_data_update_effective_affinity(d, cpumask_of(cpu));
> > +	}
> > +
> > +	its_inc_lpi_count(d, cpu);
> > +
> > +	return IRQ_SET_MASK_OK_DONE;
> > +
> > +err:
> > +	its_inc_lpi_count(d, prev_cpu);
> > +	return -EINVAL;
> > +}
> > +
> > +static u64 dlpi_get_msi_base(struct irq_data *d)
> > +{
> > +	u64 addr;
> > +	int cpu;
> > +	unsigned long flags;
> > +
> > +	cpu =3D dlpi_irq_to_cpuid(d, &flags);
> > +	addr =3D (u64)(per_cpu_ptr(gic_rdists->rdist, cpu)->rd_base +
> > +		     GICR_SETLPIR);
> > +
> > +	return addr;
> > +}
> > +
> > +/*
> > + * As per the spec, MSI address is the address of the target processor=
's
> > + * GICR_SETLPIR location.
> > + */
> > +static void dlpi_irq_compose_msi_msg(struct irq_data *d, struct msi_ms=
g *msg)
> > +{
> > +	u64 addr;
> > +
> > +	addr =3D dlpi_get_msi_base(d);
> > +
> > +	msg->address_lo		=3D lower_32_bits(addr);
> > +	msg->address_hi		=3D upper_32_bits(addr);
>=20
> Oh, that's is going to work so well with MultiMSI...
>=20
> > +	msg->data		=3D dlpi_get_event_id(d);
> > +
> > +	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(d), msg);
> > +}
> > +
> > +static int dlpi_irq_set_irqchip_state(struct irq_data *d,
> > +				     enum irqchip_irq_state which,
> > +				     bool state)
> > +{
> > +	if (which !=3D IRQCHIP_STATE_PENDING)
> > +		return -EINVAL;
> > +
> > +	return 0;
>=20
> This is a joke, right?
>=20
> > +}
> > +
> > +static int dlpi_irq_retrigger(struct irq_data *d)
> > +{
> > +	return !dlpi_irq_set_irqchip_state(d, IRQCHIP_STATE_PENDING, true);
> > +}
> > +
> > +static int dlpi_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu_i=
nfo)
> > +{
> > +	/* vCPU support requires an ITS */
> > +	return -EINVAL;
>=20
> Then why are you providing this callback the first place?
>=20
> > +}
> > +
> > +static struct irq_chip dlpi_irq_chip =3D {
> > +	.name			=3D "Direct LPI",
> > +	.irq_mask		=3D dlpi_mask_irq,
> > +	.irq_unmask		=3D dlpi_unmask_irq,
> > +	.irq_eoi		=3D irq_chip_eoi_parent,
> > +	.irq_set_affinity	=3D dlpi_set_affinity,
> > +	.irq_compose_msi_msg	=3D dlpi_irq_compose_msi_msg,
> > +	.irq_set_irqchip_state	=3D dlpi_irq_set_irqchip_state,
> > +	.irq_retrigger		=3D dlpi_irq_retrigger,
> > +	.irq_set_vcpu_affinity	=3D dlpi_irq_set_vcpu_affinity,
> > +};
> > +
> > +static int dlpi_irq_domain_alloc(struct irq_domain *domain, unsigned i=
nt virq,
> > +				 unsigned int nr_irqs, void *args)
> > +{
> > +	msi_alloc_info_t *info =3D args;
> > +	struct direct_lpi_device *dlpi_dev =3D info->scratchpad[0].ptr;
> > +	struct irq_data *irqd;
> > +	irq_hw_number_t hwirq;
> > +	int err;
> > +	int i;
> > +
> > +	err =3D dlpi_alloc_device_irq(dlpi_dev, nr_irqs, &hwirq);
> > +	if (err)
> > +		return err;
> > +
> > +	/*
> > +	 * TODO: Need to call 'iommu_dma_prepare_msi' to prepare for DMA,
> > +	 *	 but, that requires an MSI address. And, for Direct LPI
> > +	 *	 the MSI address comes from the Redistributor from
> > +	 *	 'GICR_SETLPIR', which is per CPU and that is not known
> > +	 *	 at the moment. Not sure what is the best way to handle
> > +	 *	 this.
> > +	 */
> > +
> > +	/*
> > +	err =3D iommu_dma_prepare_msi(info->desc, its->get_msi_base(its_dev))=
;
> > +	if (err)
> > +		return err;
> > +	*/
>=20
> What is the point of this? IORT cannot describe the routing of MSIs to
> redistributors, only to an ITS.
>=20
> > +
> > +	for (i =3D 0; i < nr_irqs; i++) {
> > +		err =3D its_irq_gic_domain_alloc(domain, virq + i, hwirq + i);
> > +		if (err)
> > +			return err;
> > +
> > +		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
> > +					      &dlpi_irq_chip, dlpi_dev);
> > +		irqd =3D irq_get_irq_data(virq + i);
> > +		irqd_set_single_target(irqd);
> > +		irqd_set_affinity_on_activate(irqd);
> > +		pr_debug("ID:%d pID:%d vID:%d\n",
> > +			 (int)(hwirq + i - dlpi_dev->event_map.lpi_base),
> > +			 (int)(hwirq + i), virq + i);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void dlpi_free_device(struct direct_lpi_device *dlpi_dev)
> > +{
> > +	unsigned long flags;
> > +
> > +	raw_spin_lock_irqsave(&dlpi_dev->dlpi->lock, flags);
> > +	list_del(&dlpi_dev->entry);
> > +	raw_spin_unlock_irqrestore(&dlpi_dev->dlpi->lock, flags);
> > +	kfree(dlpi_dev->event_map.col_map);
> > +	kfree(dlpi_dev->event_map.lpi_map);
> > +	kfree(dlpi_dev);
> > +}
> > +
> > +static void dlpi_irq_domain_free(struct irq_domain *domain, unsigned i=
nt virq,
> > +				unsigned int nr_irqs)
> > +{
> > +	struct irq_data *d =3D irq_domain_get_irq_data(domain, virq);
> > +	struct direct_lpi_device *dlpi_dev =3D irq_data_get_irq_chip_data(d);
> > +	int i;
> > +	struct direct_lpi *dlpi =3D dlpi_dev->dlpi;
> > +
> > +	bitmap_release_region(dlpi_dev->event_map.lpi_map,
> > +			      dlpi_get_event_id(irq_domain_get_irq_data(domain, virq)),
> > +			      get_count_order(nr_irqs));
> > +
> > +	for (i =3D 0; i < nr_irqs; i++) {
> > +		struct irq_data *data =3D irq_domain_get_irq_data(domain,
> > +								virq + i);
> > +		/* Nuke the entry in the domain */
> > +		irq_domain_reset_irq_data(data);
> > +	}
> > +
> > +	mutex_lock(&dlpi->dev_alloc_lock);
> > +
> > +	/*
> > +	 * If all interrupts have been freed, start mopping the
> > +	 * floor. This is conditionned on the device not being shared.
> > +	 */
> > +	if (!dlpi_dev->shared &&
> > +	    bitmap_empty(dlpi_dev->event_map.lpi_map,
> > +			 dlpi_dev->event_map.nr_lpis)) {
> > +		its_lpi_free(dlpi_dev->event_map.lpi_map,
> > +			     dlpi_dev->event_map.lpi_base,
> > +			     dlpi_dev->event_map.nr_lpis);
> > +
> > +		dlpi_free_device(dlpi_dev);
> > +	}
> > +
> > +	mutex_unlock(&dlpi->dev_alloc_lock);
> > +	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
> > +}
> > +
> > +static int dlpi_irq_domain_activate(struct irq_domain *domain,
> > +				   struct irq_data *d, bool reserve)
> > +{
> > +	struct direct_lpi_device *dlpi_dev =3D irq_data_get_irq_chip_data(d);
> > +	u32 event;
> > +	int cpu;
> > +
> > +	event =3D dlpi_get_event_id(d);
> > +	cpu =3D dlpi_select_cpu(d, cpu_online_mask);
> > +	if (cpu < 0 || cpu >=3D nr_cpu_ids)
> > +		return -EINVAL;
> > +
> > +	its_inc_lpi_count(d, cpu);
> > +	dlpi_dev->event_map.col_map[event] =3D cpu;
> > +	irq_data_update_effective_affinity(d, cpumask_of(cpu));
> > +
> > +	return 0;
> > +}
> > +
> > +static void dlpi_irq_domain_deactivate(struct irq_domain *domain,
> > +				      struct irq_data *d)
> > +{
> > +	struct direct_lpi_device *dlpi_dev =3D irq_data_get_irq_chip_data(d);
> > +	u32 event =3D dlpi_get_event_id(d);
> > +
> > +	its_dec_lpi_count(d, dlpi_dev->event_map.col_map[event]);
> > +}
> > +
> > +static struct direct_lpi_device *dlpi_create_device(struct direct_lpi =
*dlpi,
> > +					u32 dev_id, int nvecs, bool alloc_lpis)
> > +{
> > +	struct direct_lpi_device *dlpi_dev =3D NULL;
> > +	unsigned long *lpi_map =3D NULL;
> > +	u16 *col_map =3D NULL;
> > +	int lpi_base;
> > +	int nr_lpis;
> > +	unsigned long flags;
> > +
> > +	if (WARN_ON(!is_power_of_2(nvecs)))
> > +		nvecs =3D roundup_pow_of_two(nvecs);
> > +
> > +	dlpi_dev =3D kzalloc(sizeof(*dlpi_dev), GFP_KERNEL);
> > +	if (!dlpi_dev)
> > +		return NULL;
> > +
> > +	lpi_map =3D its_lpi_alloc(nvecs, &lpi_base, &nr_lpis);
> > +	if (!lpi_map) {
> > +		kfree(dlpi_dev);
> > +		return NULL;
> > +	}
> > +
> > +	col_map =3D kcalloc(nr_lpis, sizeof(*col_map), GFP_KERNEL);
> > +	if (!col_map) {
> > +		kfree(dlpi_dev);
> > +		kfree(lpi_map);
> > +		return NULL;
> > +	}
> > +
> > +	dlpi_dev->dlpi =3D dlpi;
> > +	dlpi_dev->event_map.lpi_map =3D lpi_map;
> > +	dlpi_dev->event_map.col_map =3D col_map;
> > +	dlpi_dev->event_map.lpi_base =3D lpi_base;
> > +	dlpi_dev->event_map.nr_lpis =3D nr_lpis;
> > +	dlpi_dev->device_id =3D dev_id;
> > +
> > +	raw_spin_lock_irqsave(&dlpi->lock, flags);
> > +	list_add(&dlpi_dev->entry, &dlpi->device_list);
> > +	raw_spin_unlock_irqrestore(&dlpi->lock, flags);
> > +
> > +	return dlpi_dev;
> > +}
> > +
> > +static struct direct_lpi_device *dlpi_find_device(struct direct_lpi *d=
lpi, u32 dev_id)
> > +{
> > +	struct direct_lpi_device *dlpi_dev =3D NULL, *tmp;
> > +	unsigned long flags;
> > +
> > +	raw_spin_lock_irqsave(&dlpi->lock, flags);
> > +	list_for_each_entry(tmp, &dlpi->device_list, entry) {
> > +		if (tmp->device_id =3D=3D dev_id) {
> > +			dlpi_dev =3D tmp;
> > +			break;
> > +		}
> > +	}
> > +
> > +	raw_spin_unlock_irqrestore(&dlpi->lock, flags);
> > +
> > +	return dlpi_dev;
> > +}
> > +
> > +static int dlpi_msi_prepare(struct irq_domain *domain, struct device *=
dev,
> > +			   int nvec, msi_alloc_info_t *info)
> > +{
> > +	struct direct_lpi_device *dlpi_dev;
> > +	struct direct_lpi *dlpi;
> > +	struct msi_domain_info *msi_info;
> > +	u32 dev_id;
> > +	int err =3D 0;
> > +
> > +	/*
> > +	 * We ignore "dev" entirely, and rely on the dev_id that has
> > +	 * been passed via the scratchpad. This limits this domain's
> > +	 * usefulness to upper layers that definitely know that they
> > +	 * are built on top of the ITS.
> > +	 */
>=20
> This is complete nonsense. You are just copying bits of the ITS code
> and randomly reorganising it. You are trying to reuse the PCI-specific
> front-end of the ITS code, not even realising that it *cannot* work.
> For example, how can MultiMSI be supported?
>=20
> > +	dev_id =3D info->scratchpad[0].ul;
> > +	msi_info =3D msi_get_domain_info(domain);
> > +	dlpi =3D msi_info->data;
> > +
> > +	mutex_lock(&dlpi->dev_alloc_lock);
> > +	dlpi_dev =3D dlpi_find_device(dlpi, dev_id);
> > +	if (dlpi_dev) {
> > +		/*
> > +		 * We already have seen this ID, probably through
> > +		 * another alias (PCI bridge of some sort). No need to
> > +		 * create the device.
> > +		 */
> > +		dlpi_dev->shared =3D true;
> > +		pr_debug("Reusing ITT for devID %x\n", dev_id);
> > +		goto out;
> > +	}
> > +
> > +	dlpi_dev =3D dlpi_create_device(dlpi, dev_id, nvec, true);
> > +	if (!dlpi_dev) {
> > +		err =3D -ENOMEM;
> > +		goto out;
> > +	}
> > +
> > +out:
> > +	mutex_unlock(&dlpi->dev_alloc_lock);
> > +	info->scratchpad[0].ptr =3D dlpi_dev;
> > +
> > +	return err;
> > +}
> > diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic=
-v3-its.c
> > index ba39668c3e08..aa101dfcbbfc 100644
> > --- a/drivers/irqchip/irq-gic-v3-its.c
> > +++ b/drivers/irqchip/irq-gic-v3-its.c
> > @@ -178,7 +178,7 @@ struct cpu_lpi_count {
> >  	atomic_t	unmanaged;
> >  };
> >
> > -static DEFINE_PER_CPU(struct cpu_lpi_count, cpu_lpi_count);
> > +DEFINE_PER_CPU(struct cpu_lpi_count, cpu_lpi_count);
> >
> >  static LIST_HEAD(its_nodes);
> >  static DEFINE_RAW_SPINLOCK(its_lock);
> > @@ -1521,7 +1521,7 @@ static void its_unmask_irq(struct irq_data *d)
> >  	lpi_update_config(d, 0, LPI_PROP_ENABLED);
> >  }
> >
> > -static __maybe_unused u32 its_read_lpi_count(struct irq_data *d, int c=
pu)
> > +__maybe_unused u32 its_read_lpi_count(struct irq_data *d, int cpu)
> >  {
> >  	if (irqd_affinity_is_managed(d))
> >  		return atomic_read(&per_cpu_ptr(&cpu_lpi_count, cpu)->managed);
> > @@ -1529,7 +1529,7 @@ static __maybe_unused u32 its_read_lpi_count(stru=
ct irq_data *d, int cpu)
> >  	return atomic_read(&per_cpu_ptr(&cpu_lpi_count, cpu)->unmanaged);
> >  }
> >
> > -static void its_inc_lpi_count(struct irq_data *d, int cpu)
> > +void its_inc_lpi_count(struct irq_data *d, int cpu)
> >  {
> >  	if (irqd_affinity_is_managed(d))
> >  		atomic_inc(&per_cpu_ptr(&cpu_lpi_count, cpu)->managed);
> > @@ -1537,7 +1537,7 @@ static void its_inc_lpi_count(struct irq_data *d,=
 int cpu)
> >  		atomic_inc(&per_cpu_ptr(&cpu_lpi_count, cpu)->unmanaged);
> >  }
> >
> > -static void its_dec_lpi_count(struct irq_data *d, int cpu)
> > +void its_dec_lpi_count(struct irq_data *d, int cpu)
> >  {
> >  	if (irqd_affinity_is_managed(d))
> >  		atomic_dec(&per_cpu_ptr(&cpu_lpi_count, cpu)->managed);
> > @@ -1545,7 +1545,7 @@ static void its_dec_lpi_count(struct irq_data *d,=
 int cpu)
> >  		atomic_dec(&per_cpu_ptr(&cpu_lpi_count, cpu)->unmanaged);
> >  }
> >
> > -static unsigned int cpumask_pick_least_loaded(struct irq_data *d,
> > +unsigned int cpumask_pick_least_loaded(struct irq_data *d,
> >  					      const struct cpumask *cpu_mask)
> >  {
> >  	unsigned int cpu =3D nr_cpu_ids, tmp;
> > @@ -2121,7 +2121,7 @@ static int __init its_lpi_init(u32 id_bits)
> >  	return err;
> >  }
> >
> > -static unsigned long *its_lpi_alloc(int nr_irqs, u32 *base, int *nr_id=
s)
> > +unsigned long *its_lpi_alloc(int nr_irqs, u32 *base, int *nr_ids)
> >  {
> >  	unsigned long *bitmap =3D NULL;
> >  	int err =3D 0;
> > @@ -2153,7 +2153,7 @@ static unsigned long *its_lpi_alloc(int nr_irqs, =
u32 *base, int *nr_ids)
> >  	return bitmap;
> >  }
> >
> > -static void its_lpi_free(unsigned long *bitmap, u32 base, u32 nr_ids)
> > +void its_lpi_free(unsigned long *bitmap, u32 base, u32 nr_ids)
> >  {
> >  	WARN_ON(free_lpi_range(base, nr_ids));
> >  	kfree(bitmap);
> > @@ -3506,9 +3506,9 @@ static struct msi_domain_ops its_msi_domain_ops =
=3D {
> >  	.msi_prepare	=3D its_msi_prepare,
> >  };
> >
> > -static int its_irq_gic_domain_alloc(struct irq_domain *domain,
> > -				    unsigned int virq,
> > -				    irq_hw_number_t hwirq)
> > +int its_irq_gic_domain_alloc(struct irq_domain *domain,
> > +			     unsigned int virq,
> > +			     irq_hw_number_t hwirq)
> >  {
> >  	struct irq_fwspec fwspec;
>=20
> There is no way you are messing with the ITS driver internals like
> this. The only thing you *may* do is to have a common infrastructure
> to allocate the RD tables, and only that. None of the ITS
> infrastructure makes any sense for DirectLPI anyway.
>=20
> Please rearchitect your code to be fully independent of the ITS, and
> without any of the pointless abstractions that the ITS requires. This
> should be much closer to GICv3-MBI than the ITS. Heck, you could even
> use the MBI driver directly instead of trying to use DirectLPI, as it
> gives you similar functionalities.

Thanks for your feedback, Marc. I am reorganizing the code and incorporatin=
g
the above feedback.

>=20
> I also want to understand *how* you are going to plumb this into both
> ACPI and DT, given that neither understand how to link a PCI endpoint
> to a set of RDs.
>=20
> 	M.

One way to do this for NUMA-aware systems would be to use the NUMA
related information that is available with PCI endpoints or root complex, t=
o
pick a Redistributor/CPU that is in the NUMA node, as specified by the PCI
endpoint/root complex. In DT PCI devices can specify this using
'numa-node-id' and in ACPI using the '_PXM (Proximity)'. For systems that
are not NUMA-aware, we can go with *any* Redistributor/CPU.

Is there any additional information we would be able to gather from ACPI
or DT that's not there currently, that would be useful here?

The other question is, what DT property can be used to instantiate the
PCI-MSI IRQ domain for Direct LPI? As per the DT spec, there is only
'msi-controller' Sub-node for the ITS.=20

- Sunil






