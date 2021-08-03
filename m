Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957D83DE43E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 04:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbhHCCL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 22:11:28 -0400
Received: from mail-bn8nam12on2103.outbound.protection.outlook.com ([40.107.237.103]:62891
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233270AbhHCCL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 22:11:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1sSnGiH3MSV8KifYcU1ok8v7uDqEPj1NBypUDODY9/wU5GWaBRyjnvi/6o3Cimf0W5JuI0jjNqkjuMrv/MnObn0kaVgzHueqcdkBPeKvR5aERbXXJPQu3R5fJWlnY1Mbzr4vbgsundEcLOjA7PX6q1uoFQnSHX5AW3eJre8J/06DTTrxFSF7R98eLRlkoI+k50vqVIcpKYCYGx5QgSUaURmgb4MUBDwr+TmclUD6akVcAeYTw3lN3FHyJXls/jFa9PZ0x9DZ9Z5MUiSb5fOZ8K29m+FF4P+B8ca1tIfWM+tu9BEfdDR8oEkJEh8SHBcWrDM5lDnFP7CGJkZQEbYKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EygcjhMvY9gbZwrTumpc6vLwb3bngi8k9tAu9QBhqk=;
 b=HTXl8JzD8S4CNGqzYa3h+JvLnCku/Oa0POLiP1X+A0LaLJ5kLO12W2QSljgALayZ3ZVXngnZRgCF/Y6U8aH5OgvU2UQ3uQ7IXey0fRY4rbMM72VWstkvq0RHbkd8Il9am/OBSJz8V7au59gHHLalxbww7EnCfQ8vptzIPC1QJjwzzJCDFPO2Ep/ciw6N5DF/1zdZidUz900PgPEZHJNeho++dycwVjQJIAoVZRgcAK5TzRKWCvAckZ3nlJ3syMj4jlXNWrV9noT+6RdZwuAkKjWLLROOA8VXEo4NqtB7ecS2QnIKCubIj7G1/b6j4awpBv5ALBRdQ/56xzrjb1Dswg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EygcjhMvY9gbZwrTumpc6vLwb3bngi8k9tAu9QBhqk=;
 b=eii+zYoibTou4GbkJWf2zkqrVMXaVC9BZt8SR/lV0Bv4uZl3mnMsrOW+ezw8vqlzAPsIullXDFALsg3ksTzbiz+ERs8+KIeBxwTc6CjtzTgFJQ02R0VZw43K0FjLehnCrT5M2F3HseMgyjbogVP8YpLc7Fh3hhCgPzQKIGVfvnM=
Received: from MW4PR21MB2002.namprd21.prod.outlook.com (2603:10b6:303:68::18)
 by MW4PR21MB2059.namprd21.prod.outlook.com (2603:10b6:303:11e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.11; Tue, 3 Aug
 2021 02:11:14 +0000
Received: from MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::601a:d59b:f64e:5433]) by MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::601a:d59b:f64e:5433%7]) with mapi id 15.20.4415.002; Tue, 3 Aug 2021
 02:11:13 +0000
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
Thread-Index: Add0L2f934gE0okbTBC5z2WK9cOcFQCFdR6AAvoodNAA8PnXAACGZfqQ
Date:   Tue, 3 Aug 2021 02:11:13 +0000
Message-ID: <MW4PR21MB20027EAC23E8053210364E2BC0F09@MW4PR21MB2002.namprd21.prod.outlook.com>
References: <MW4PR21MB2002BA20FA4A8DAA1C27F4C6C0199@MW4PR21MB2002.namprd21.prod.outlook.com>
        <87a6mt2jke.wl-maz@kernel.org>
        <MW4PR21MB2002E51429F7E13B61A34FFEC0E89@MW4PR21MB2002.namprd21.prod.outlook.com>
 <87tuka24kj.wl-maz@kernel.org>
In-Reply-To: <87tuka24kj.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 982f5a16-7bd3-492e-3bc5-08d95623f848
x-ms-traffictypediagnostic: MW4PR21MB2059:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB20599C8E377481470791A994C0F09@MW4PR21MB2059.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m/TiifTAD0Dvi4gBNtjOUglamMd6gNbK6GBMLxkPXVhXH8xvSFcQdRXwTqIlUlcZayZwa2pWB0yAvkafb2h6IoT54eQ0JmeP5JQ+m1fuyfC1tkUafDClQMF96goyZJEP225Hu603qYOE+DWwIi/yIbDsmmL1cVJxPO7/JEFG6jHQcwQ9+sWAjU+9FI5YUx5sJlBd1JXZZY9FY4xsRXP9TTemAQKVcbac/TSwTDBf4SFV4TpdAP5Indqhry2TZWSVoRhv8qrT9IPsKjJ5cgM16aJugIIKgmqEUIgAtbVeJT+1UL26D2KktvwUN9dchA90RjWnjKQyg4v+/CVASFq+gqgbaGr0ejJP/THaAljQ0iWSDKNP+ZKiuI3WYyDS2szle5jtb3n0gkFmGM4MHx+BtqvW136EKNEu3tTSIBGOUUwGIW7LHTHXl3t15QDFsvKgGBs1lO/NIBQsxRybz5KUYhrKO6wcl0ERd0VLE9csDvnOhqvvKBoc6jqsiLcMnB6Z2ZlgMYoTCOC0Yze9oRFQ7+bnp2IMdE853XPMBI0qZveRRqMWaXMxynlvgMKPrhTtbEj18y6XEBTSNc5+JUbPoNkwR0KY15fvEz4cHgP/n7mJJ2H5U4PTLm8kAwbZtSwah2r79jD0LZHqcrGRexS/5BRkplIVfTH6i4Q6G9njZtGG/XGQm1l0BUuHt1o6TJQJu20794sw1u6ptt7lufxW6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB2002.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(38100700002)(8676002)(122000001)(52536014)(186003)(66476007)(66556008)(66946007)(8936002)(64756008)(10290500003)(38070700005)(2906002)(76116006)(5660300002)(66446008)(508600001)(33656002)(4326008)(6506007)(71200400001)(53546011)(82950400001)(82960400001)(7696005)(54906003)(83380400001)(316002)(8990500004)(9686003)(55016002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GmLXTB3oP83mW73mfkx84B9b2wgCd+88iiGuLCPRJ0D1LLaDXmLMd1jmxbM7?=
 =?us-ascii?Q?5O1NOYBq0CiE6Yii+llkZxCd2Bs9AWH2D4/Mipn05g7/8VJ+K03DFfg8njpK?=
 =?us-ascii?Q?R1jKCGyRlk3zziOIFqDGtAJXtMTayrlGKcAUBkVbj06Uj6PEs0eSOoUBwAQF?=
 =?us-ascii?Q?oabHkMz5sN+f8p54Hr7+QgKETSu1TkVJAQ0wXsxFvt1EfbSmIZ9KJLc8p+06?=
 =?us-ascii?Q?QELBzkbP9s1dWB1xOKsysGpEZUwqgMtbd87r4F8x+3N5NQKloGJF5s6Pvtn2?=
 =?us-ascii?Q?kkNiIk7fLpPZVxP0o4SGIcppSAy4OdIRhD/KA0j8WZiAHqodTdY+yFAGGqFp?=
 =?us-ascii?Q?hj1hDjE/4EAju/tnvaKGj6+fm/qS3inm5362J3oK0bcHb27ZCDslUftkGBSu?=
 =?us-ascii?Q?4n/Ib5Khp2+0ee2DtSw8y7JFPUdywYoIXavsDClOF37DZe5tkOmlEACj+8Hr?=
 =?us-ascii?Q?NLIh0hbgwWsstRTN6RNDwac2RXLaY3qK+/Y7TGE+eUtrYmoP1fyXWc5Khom2?=
 =?us-ascii?Q?MQlrqt0KON3pZD6VW58aaIrZc8OORQ9h70FhUG2HdPBGPkluXQh+ewDHZ5wF?=
 =?us-ascii?Q?Aag/DiBs8DPIQh8Lcw9jzZ8f0mq5cWWw6OkeXn+zWYt9APQXu7dDlaqJReYu?=
 =?us-ascii?Q?xuOzm6CEGeimbCQcYHkDx9ZYSzZ7/9idxY1zaa3PUwdXvIVUhkfQsQ1daCrb?=
 =?us-ascii?Q?skPrdDlAoD397opWU8bIviRT9HFnUO0OYnH+Z8BaPo5FvYeo+2Pe/2fhzzSq?=
 =?us-ascii?Q?lQ4G+6JnjWJ4rlDaKWjqmSncxTxD+RDpnpSwaeoBtw2VhsFNX5bHGDjZ2Xf7?=
 =?us-ascii?Q?37HGZq+noOdm2OMwBhc5fOMPhnMGwzi8Ps5xedVYdtWT1hYJadyR5cOFdnQv?=
 =?us-ascii?Q?x8YJZDYaMwHfzwQaHcY7+MfY8cK5R2/vDr/nlQqFq/xK3QnHfEWCQz3/t7NP?=
 =?us-ascii?Q?KYq9DlitNOEz4k3Nz6cGg3sucOPoeZ0WXd13/uk3Q/7qAEZJvtqwCZuP6mpt?=
 =?us-ascii?Q?SxPz82got0ezFqoOioB8NnUvNikXz5X1yEdS99SojpRjkfONvK6w+uR0lwNd?=
 =?us-ascii?Q?5zmjONtuX3fP5SaOiFwEffSw/m5d3mTiqRHKGGqlRar5vZIQiLrpaOhp+RKA?=
 =?us-ascii?Q?HnTblJYPaGl3bzihTiahccBhsqjpx4FqsrLwdGYo8iwL87OK+kSDGbo2enxD?=
 =?us-ascii?Q?PCcU6+WmQiQTr3JZD+Sgc5NAchxQY5CgJm6k+uilB/KGCMHueu6fcsLfiJJZ?=
 =?us-ascii?Q?ClyxgzgCcCRMHHW9ViaqTbUHqQSL7x8NIBCTaQzOFs2OJdU45baNL9R2ureR?=
 =?us-ascii?Q?hlppsoR8iHNyDlrIDemDRnhoVjf+aMLh/cmsD6svUrAnBjZ9Y6pMC6xbH+Zt?=
 =?us-ascii?Q?qrvNtbJ9N0kp+82J/yFvBk2I6NWb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2002.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 982f5a16-7bd3-492e-3bc5-08d95623f848
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 02:11:13.7519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1X18Obb1G4acn/sp0nR3pO5nzwNBvU3sXZ4NThrXoNIIdyW00Id+baKdhId/Emk3zsf63+g+8mrxhuqWUbSW1f1HOqIHWbSq/+r/ItcJa4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2059
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 On Saturday, July 31, 2021 2:52 AM,
 Marc Zyngier <maz@kernel.org> wrote:
>=20
> [...]
>=20
> > > I also want to understand *how* you are going to plumb this into both
> > > ACPI and DT, given that neither understand how to link a PCI endpoint
> > > to a set of RDs.
> > >
> > > 	M.
> >
> > One way to do this for NUMA-aware systems would be to use the NUMA
> > related information that is available with PCI endpoints or root comple=
x, to
> > pick a Redistributor/CPU that is in the NUMA node, as specified by the =
PCI
> > endpoint/root complex. In DT PCI devices can specify this using
> > 'numa-node-id' and in ACPI using the '_PXM (Proximity)'. For systems th=
at
> > are not NUMA-aware, we can go with *any* Redistributor/CPU.
>=20
> This makes zero sense. From the point of view of a device, all the RDs
> should be reachable, and firmware has no say in it. Dealing with
> interrupt affinity is the responsibility of the endpoint driver, and
> NUMA affinity is only a performance optimisation.
>=20
> > Is there any additional information we would be able to gather from ACP=
I
> > or DT that's not there currently, that would be useful here?
>=20
> You will need some firmware information describing that a given set of
> devices must use the RDs for their MSIs. Just like we currently
> describe it in IORT for the ITS. You cannot /assume/ things. At the
> moment, there is nothing at all, because no-one (including Microsoft)
> thought it would be a good idea not to have an ITS, which is also why
> ACPI doesn't describe MBIs as a potential MSI provider.
>=20
I am a little bit confused by your above comment. Maybe you can help me
understand the ask. You indicate that from the point of the view of the
device, all the RDs should be reachable. But, then if we define a mapping
between PCI endpoint and RD in the firmware, we would be doing exactly
the opposite. i.e. restricting the RDs that are reachable by the device. Ca=
n
you please clarify?

Is your concern that the device should be able to only DMA to a subset of
GIC Redistributor, for the MSIs? If so, in the IORT, there is "memory addre=
ss
size limit" for both device and root complex nodes. In the implementation,
we can enforce that the GICR is within that range. And, if a device deviate=
s
further than that (ex: by having accessibility gaps within the GICR range),
then that is out of scope for support.

- Sunil
