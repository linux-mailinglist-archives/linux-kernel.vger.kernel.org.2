Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1FA3E2FBB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 21:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243840AbhHFTOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 15:14:46 -0400
Received: from mail-dm6nam10on2106.outbound.protection.outlook.com ([40.107.93.106]:61281
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243828AbhHFTOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 15:14:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fj0kuhAncAVdjHpUlVEO0A6O5g6w0Kdg7iuXZY/YoPFAgSflvI8kdGfvN4c/HwFE2Sg/IC3yMl/xckWkPXh1Qm0IQNIfEqSJkZHPyEiMprCE009/Ax4XludmbUUnQU2r0Ds+HEzXxcObw5lcLNGmTA835TTNc9DuBEjgzYE922RmTWQAejS4ebLTS9GSM0qITzLfOYXF/oZnxK93z/M7PNgpD3r3iW5gjWto9e70TofdJb8gJLgqFgBy4B0YOGnkYFkkkmBMAOBbDOyOui71G4cH5a6TRLPkEhqMUgPlTTRXJ7TXn2ZIhIVoBRbNm2Ut9GxNR0mikxawgn6qksXXdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abtKQPZ6Z3zfM8jjZELQ8U3+aC7fiMCzCIW4kIH7V1E=;
 b=j5DtvpVu9G/CzPqKxY3Ek02Qcn80Qm4mnKkA0ywM5QxPPTAMP41XcKSATMptZGJNdq+8IQ5C2XiSnP5GaRqf7MEhermwk+oTqnuavIi8isHMUGD9oDCSORIaLpIjVsgUJET49KxaV5lhjarmfNtcO2vZZPYvOGJmz7x+buPrnuU++zdTnKL6dNK1Eog5cOl7Hm7JtHvvuHN7qeS0aRi/QrFCxbesiy9OWsE6462A5QVKCFbdI4+H1kQwhYiwV8D0Bvv7o6GWvDHQDbPEWRcEhnDlG18NRx2fQGVtdaOiO9SfAJ65iGvKQbwLhKzpdbwUtglmu6gkc+qge+IEgdIxrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abtKQPZ6Z3zfM8jjZELQ8U3+aC7fiMCzCIW4kIH7V1E=;
 b=DYc9OXXQrsMZbrtIVD9fKX/I9KQoSHIB5ByFOO1h8rzSmtyxcW7AP9tLtVm6PMFu2ubgfOxHVH+3K9grJMk0v4012BegxQYNukBsJqxETSMqtt8mXeTUOxrvpE7l3VzW8+btdhZ9f2GOYxhOBe/ojjhvMoRkL399Z7izsVy6btI=
Received: from MW4PR21MB2002.namprd21.prod.outlook.com (2603:10b6:303:68::18)
 by MWHPR21MB0174.namprd21.prod.outlook.com (2603:10b6:300:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.2; Fri, 6 Aug
 2021 19:14:13 +0000
Received: from MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::601a:d59b:f64e:5433]) by MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::601a:d59b:f64e:5433%6]) with mapi id 15.20.4415.009; Fri, 6 Aug 2021
 19:14:13 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Thread-Index: Add0L2f934gE0okbTBC5z2WK9cOcFQCFdR6AAvoodNAA8PnXAACGZfqQAA3HAwAAM+eEgAAWMdVAABp8m4AAR9tVAA==
Date:   Fri, 6 Aug 2021 19:14:13 +0000
Message-ID: <MW4PR21MB2002ABD170CC9786CDF5D493C0F39@MW4PR21MB2002.namprd21.prod.outlook.com>
References: <MW4PR21MB2002BA20FA4A8DAA1C27F4C6C0199@MW4PR21MB2002.namprd21.prod.outlook.com>
        <87a6mt2jke.wl-maz@kernel.org>
        <MW4PR21MB2002E51429F7E13B61A34FFEC0E89@MW4PR21MB2002.namprd21.prod.outlook.com>
        <87tuka24kj.wl-maz@kernel.org>
        <MW4PR21MB20027EAC23E8053210364E2BC0F09@MW4PR21MB2002.namprd21.prod.outlook.com>
        <b2dea108-9166-dc9d-abd0-d22491f78568@arm.com>  <87r1f9wooc.wl-maz@kernel.org>
        <MW4PR21MB2002860BAED850B2B52D6E2BC0F19@MW4PR21MB2002.namprd21.prod.outlook.com>
 <87wnp0b86y.wl-maz@kernel.org>
In-Reply-To: <87wnp0b86y.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 807ebc16-877d-4520-2611-08d9590e6082
x-ms-traffictypediagnostic: MWHPR21MB0174:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB017447867E43F50D3B40541BC0F39@MWHPR21MB0174.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1LcZ1ljuXBl8JpnxgxG+Tl0ydnetrREiM5tH2K6Sd0A3vBtfVRPqjVb+iYKpYjW7Mxz7Fe5nqjh8/PNFzUhrp+rhXEVQp/H641vbjkcREDWnDXdi10sGCBJ+7VIl378HTXbQUSBjSy+KZGdwizWu+SRyWqhxkXDi9M4SRoPMVkrM/F7cLXHmSPtEV+tia1LoMre+dKjNriOilDwdnjJdjHGr5q/t3u/S1bI1uxJcssZx8RHhPOrHIuvmKC9P2D2GtuhQrz/YXekJT6stKoggHcXxHi38UYzJsp8Qv2cMXLezdogLgQXcbBdBdPhQhMSQRKdtE7JhafTJ194e8ZoQi2bdGRc2FarKk8yWy5YZivj0SDlhazcAK9/84aW7ZAYE3SsQ3NDJWw6IKfgT1LsIDxF0enUKr4oXlVd6cTkfDSvEzFhczHYB0HIqESdnXr7soYQKr+8HEWeWGvkhdP1M7Z24Sz68DFNHYswik6s4OB8KweyJpp5bc8ILLUGFOO3JB97zhvW/1fg4zm3hm3Tb1VJEwBWqsUlng0KcoviY/o1UPpnAk2Neg11hcBC1UM2eSdPUUIkvKP65ytkaIW+VImNz1j0zGdi4NzSts/Qk3gtkQinvNoq0p4MgtvQ8B0kN/BSFkSxiCO6QUxtPhmlvFF8x9V3dLzCZB2RuxXlXC+6oOTRvAKxNZfQqPnH/Q+VWzscvZm/Sf3FuLPY2hXfDig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB2002.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(8936002)(33656002)(6506007)(10290500003)(53546011)(86362001)(82960400001)(55016002)(83380400001)(52536014)(71200400001)(82950400001)(8990500004)(6916009)(8676002)(38070700005)(66446008)(76116006)(186003)(2906002)(66556008)(64756008)(54906003)(66946007)(9686003)(7696005)(5660300002)(122000001)(38100700002)(316002)(66476007)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eAC9rTZg2AqeZ+RCK5jqpQZt2Fhy6rKc0G7u0xQsWrpzU2XN+VQAClBiory4?=
 =?us-ascii?Q?Uh5ICxcYDUhS1Wha9EJAIERWe5eEW4yQ5cVK7PW4CB03jJAek4lQa4ZS8XMi?=
 =?us-ascii?Q?zbUEblJPwKEy1tgwWDRUj/AUmmGpg1H4aigaDy1L/mI43DJthtubS1q6Asz9?=
 =?us-ascii?Q?Z5EXlR/8hyKYtLHNXlhWz5B2VupBRLbIIOzi2raDsF9eLrX/uciP/0jinNNW?=
 =?us-ascii?Q?7eJQBoPAQGD0w62Mrb6tJ3X8g6mAGBBM3CEnfaGDE88fM4OJhy7+XFify1Gr?=
 =?us-ascii?Q?Szb8FpQLS/XN8p0mE2qgMER55mOk06JlXt91k3cByz6eOGPsO7av4cwyhWeG?=
 =?us-ascii?Q?CgjSfmEvCoNGM0wK8GMkZNJeQwDMUcwb6/VOkzCLMCtN+r9z5dA/PnpzTkSk?=
 =?us-ascii?Q?YtsdqCSm8TWK1w+UMLBbrTzJcYPeqtoli5EGIsUyGCetfX+pUbbTZHC+KBhD?=
 =?us-ascii?Q?7l2wA9UR2q5I2m0SKz/O/7rf8uGcaM4e7dB3OpJiqTxNYVzzNcuOLeu/LkDw?=
 =?us-ascii?Q?63dekEuYL6yQ6C/InmS2AdwYVFNODBpRvBnIRndGkQmImWXYRHWV0VsUri0H?=
 =?us-ascii?Q?SkCr58xSHFITCOtkQacef+L9xPnjfmYOCzgXzSeUXX5fIj92jQIUm4gVfeJF?=
 =?us-ascii?Q?MbU8yEEhpGuB6hhWiQEuvosML6vEtdJcsIdnplAoPw3ZC5AVGD8XjdaudH0+?=
 =?us-ascii?Q?O8ipCR8aZFRjdaX5VpNlzK9WC9qJRgYiea/igG6NyMsXTHIabvrSaDcLnuWX?=
 =?us-ascii?Q?yujZk94MV1BMahdiIHE5UZJmCl9WS1s06SD6wuqAwylsjvPppuNi6OAk3ngt?=
 =?us-ascii?Q?qV5F9jxC9xKzMRdKywwGCeZYRV1evS4Stgd0wH3+bDWFUdBTF2G6n/STaI6A?=
 =?us-ascii?Q?sYVepsAcn+z9hmAHeQRkuG/8OJeoEwILghX0GgJQe+upHljrYDt6HgAWrPoz?=
 =?us-ascii?Q?bOgZBH8D73pijYa1lpl2wSc57R3GHlb6KvfCZtSqCTAmkohXfzCamWYxYoQU?=
 =?us-ascii?Q?mgRh+gXR9j60njpMjp0rDMW0Io8QdAI8858KaTv+lXjV/fqzynj+vTKOopdK?=
 =?us-ascii?Q?DgVZ9E9V0jzG7++4UG7fIeVHlWsxGp7EQW00jVGbU+3+0iyyDIy6cDY4htZg?=
 =?us-ascii?Q?FcVUdTAAjzfezNhyh3lJAbFXAJB89jHyf2sqspCPhT0y9/WF4lc/EcaQB4jG?=
 =?us-ascii?Q?UlQeJ2YJCCH3eL4Z4VZCA70IN78N+dP7dj3aPrXi5RgRo35cbYZ2sgOUVz6T?=
 =?us-ascii?Q?/6VDprbfyitmWoMQo2r0qCn1OpwksE1LjrKnxdAaDuEARE5fWdaKdEGzJ78I?=
 =?us-ascii?Q?qmIjCXg+M6X9LuaL+xaVHkWayR2+Xh+YcVU6q/9szH1gMqPWebwHklXpBOwp?=
 =?us-ascii?Q?GB7iuSOBsRaB3fpEutmvbmodAcLg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2002.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 807ebc16-877d-4520-2611-08d9590e6082
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2021 19:14:13.2724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a9zej/3DRDTG8/Mffyi72stS7ifDSV/hkMZD7kv865j49C4YJqmglndJud9Brur30ka/24TU47dgFK/VYtugifXEvTqhtw71K5NoRVnn1NE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0174
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 5, 2021 1:35 AM,
Marc Zyngier <maz@kernel.org> wrote:
[...]
> > Hey Mark
>=20
> I assume this is for me?
>=20
Yes, sorry.

> > would you be willing to consider a scoped down implementation of GIC
> > Direct LPI with just an IRQ chip implementation and no Direct LPI
> > PCI-MSI IRQ chip.
>=20
> Could you please clarify? If you are not implementing MSIs, how can a
> device signal LPIs? At the end of the day, something has to write into
> the RD, and it isn't going to happen by sheer magic.
>=20
> > This will allow a MSI provider (such as Hyper-V vPCI) to provide a
> > PCI-MSI IRQ chip on top of the Direct LPI IRQ chip and enable
> > PCI-MSI scenarios, and avoid building in assumptions in other cases
> > (like PCI) where firmware specification is not available.
>=20
> I really don't get what you are suggesting. Could you please describe
> what you have in mind?
>=20
The suggestion was to *not* implement the PCI-MSI IRQ chip in the
Direct LPI GIC implementation, but let the endpoint/specific
implementation provide for the MSI IRQ chip.

For example, the Hyper-V vPCI module does implement a PCI-MSI IRQ
chip (refer to 'hv_pcie_init_irq_domain'). Microsoft Hypervisor
provides/virtualizes the MSI address to be used for Hyper-V vPCI. The
Hypervisor might be using the ITS in the background, but it expects
the device to be programmed with the MSI address that it provides.
And, the Hypervisor takes care of routing the interrupt to the guest.
This is done by the Hyper-V vPCI MSI IRQ chip (refer to
hv_msi_irq_chip) compose MSI message.

Today, for X64, Hyper-V vPCI PCI-MSI irq chip parents itself to the
architectural 'x86_vector_domain'. The suggestion here was to see
if we can support a similar setup for ARM, where the Hyper-V vPCI
PCI-MSI irq chip can parent itself to the 'Direct LPI arch IRQ chip'
(to be implemented).

The arch Direct LPI arch IRQ chip is needed to enable LPIs, invalidate
the LPI configuration (GICR_INVLPIR et. al. ) and allocate LPI IRQs from
the LPI interrupt namespace (i.e. 8192-<num LPIS>).

Happy to expand on this further, if the above is not clear.

Thanks,
Sunil

