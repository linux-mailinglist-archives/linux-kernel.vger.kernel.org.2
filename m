Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE85E339189
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhCLPjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:39:15 -0500
Received: from mail-mw2nam12on2050.outbound.protection.outlook.com ([40.107.244.50]:32352
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230136AbhCLPjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:39:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCDoaDp9RxbTGHqoBZvEo8l2H2mcQTAQp6ODAR7lL6ATTl7pD5RYXPQiW9uPtzkEPwUWEaO3bmwaQx536I6AUm78cSPNnSxdmzFDdihCmVSadlSLaDHtavHE1bHe8sTVxXhNkBjTHcoTIbe+1QUyG3BUqIN32HyTE9vUfuQj5czJu7f0pnYrvUz5RYhEq6aZlZAAueU3aVzUPTgIKXZmHkRmsvZ0FhYh3BNSbzA957xo+1pPEYXc24xerMAnoIGBIyn8v/xYyz5MDcXID1xd5ctDTcTKmuTEJwnAfETAvFCwK+bRydC1WCv5n+QTzlEyihGEUQXkL9aO1qFYFYSJXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTU+kKDfKBfPC2b2+JAvObgWjoVg/ZCo/MdM460pfpg=;
 b=DDPeK+ariKc36JFpZRLwAAfe6EnONfbYCjyh19VDuzLMZhdZMidGIktqYAkqWfe7fI57ls65fM/SXVjyitcbF4bsk2Nls8gBfUiWRk7WTidQppJxGmZ/5ZvaZ6ns66KJY+gcRhBX3XNjbxqyfod6CzRgJYnEo1VX/e0EEWhTxqN91kOSSohHcZ7uwyT/I1MitgAMKRkqrcSanw4/YaiItyxnW6buTIKRtg/yxZnwqQj/nSsyLUfFAOgx02KwFIl0/sTGpowHYnl6BIrzvpZrgHQ9tRRNMzPM8JY7M+xWJUi4eNe971dWU9ohoMBk9OpPt/agvmQNO3jfPwraYJZ+ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTU+kKDfKBfPC2b2+JAvObgWjoVg/ZCo/MdM460pfpg=;
 b=wYVjfoU9aUT6ZZ5qO224I2CqyZvXmxuJmX2r38FaNXp3ozyDhVE16KDUK1FfZGXUhqkuXlkG+mDGczf/GWZnqvNmq1jUq1JYp4n4oOKBoM5ntTDKCB/i73LagPuB+U80WowpuEhD8SyqcWszXN8nkrm8R16AGXum1Enfp7wVhq0=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2369.namprd12.prod.outlook.com (2603:10b6:207:40::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 12 Mar
 2021 15:39:08 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 15:39:08 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     David Hildenbrand <david@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liang, Liang (Leo)" <Liang.Liang@amd.com>
CC:     "Huang, Ray" <Ray.Huang@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        George Kennedy <george.kennedy@oracle.com>
Subject: RE: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to tail
 in __free_pages_core()")
Thread-Topic: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to tail
 in __free_pages_core()")
Thread-Index: AdcWgujrowoM8ON/Tmy0Tmhi9senVQABLLQAADBH9CAAADxQgAACUAfQ
Date:   Fri, 12 Mar 2021 15:39:08 +0000
Message-ID: <MN2PR12MB44884289499B6B16A0E9017DF76F9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <MN2PR12MB448872F0BE8F49C78AF908F3F7909@MN2PR12MB4488.namprd12.prod.outlook.com>
 <2f7c20ea-888f-65b6-6607-c86aab65acce@redhat.com>
 <MN2PR12MB44886034D18F900F4FE45D8DF76F9@MN2PR12MB4488.namprd12.prod.outlook.com>
 <15faeb97-d031-f70a-adab-f2966e0b1221@redhat.com>
In-Reply-To: <15faeb97-d031-f70a-adab-f2966e0b1221@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Liang.Liang@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-12T15:39:04Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=5da179a6-0073-4910-bc84-9f00ac7b1c29;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3cedc9b4-0f00-4902-f564-08d8e56cf9e9
x-ms-traffictypediagnostic: BL0PR12MB2369:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2369F2ECCCB43717A1D39B2AF76F9@BL0PR12MB2369.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +GupKLnWTYP1Kxn7/oVWaEBHy7I+/EIld03rLncxYnMjsRwN8pD0runf0cP/0yvDULmaXpDqGhMZPj1RxqJRYiZfKHUQTLUUWvLO/9bexuc4Oeywcv0dF+OYi9GtReVB6OAY6BspJehlto+AXoKT3ES94tCH5Ln8uKBsfZ3nB38jUebWHLY/JNLP4FCfPnrmyYFt8+ZFj1n+j5XK/PwvsW75IEyFmKaTeB1M4FVHE/tRic+iR2VJsVZShdpcSLjsbXW0g9gvayHAhcfC7D6N/ZwCJGl0eR/MeY/IJBq/SWK7UrGj7LKtVZtf5m5DcjNBj3qpYMxCMMw4haDJkvkWwDqa1yqhtZvKfvxiWrPESgrxS1r4c3zu5xic0S80IXwVHFkZRrMZJtyHUk9euZSuk/MitF7nJ/m3dVwIYoc9UKJp3SU9eSONgwxVeODcTHOelEzqyCsgNYsr9xctgwEFaEOlicG7HEnQzZM6yzgJovqUQLr1Ofeljq3NLNBtPtM+Dxx8KCGyORQd329sARDhCseTKnX87Tjm7noVCtUz4UloFbxEkjiUS3CyoLZ/pnlRISro6W2CCAuNPpMlOWZP1KtxhoF3QqKXp/z1cpOkHqY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(9686003)(6636002)(66946007)(66446008)(110136005)(52536014)(64756008)(6506007)(83380400001)(7696005)(186003)(8936002)(33656002)(71200400001)(86362001)(66556008)(478600001)(54906003)(66476007)(26005)(53546011)(45080400002)(5660300002)(8676002)(316002)(966005)(4326008)(76116006)(55016002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?BZi8IFVa06d4HodnXw5KhBNNHyReoOhWhN1G+kudH5G1EhIzD6WYV9JXd/sl?=
 =?us-ascii?Q?171xEvbyW3ZlqNFw0aam9RaseapKgCptRr85NEKpwOdW9VUSnE0efPhpI5/F?=
 =?us-ascii?Q?KRV/yI5JBsIVqO2DzRNr7uWftsis9EFunz5xTz0BL4lC5FybI8yuQv6NDxdc?=
 =?us-ascii?Q?ygI7Gl7unFWTZgTYg2oeifmG+5kHsjiQai1x4fMPSWzOOAGXxrW5VIFZCqGC?=
 =?us-ascii?Q?P/DtcQoDyT0p4JRKwNKYwQY21JP4Ix09Oqv3l5RMhlPaSW8bJPejGyiKUe9E?=
 =?us-ascii?Q?PR1ww2yc+TFIYPHhezGCCJbzktvOHym2eMaeUTHUeiS2nTm6oB82DrtfSRcQ?=
 =?us-ascii?Q?AqUc7cYolB9RXOyOi2bkSmFu8iz+VabcWMIvWmY7l9sD6Lhp3DoWORaDMlRO?=
 =?us-ascii?Q?kEk5tJdD1+/OGpsaEMW0oUXxfpIerD7+aXqgclUa86YuBCTOP5UM3ylobPxX?=
 =?us-ascii?Q?26lXqdXTKBSsJ76+ebWhBilgwaFNTVLp6iBzpZivmWomicjbVPk3lARrPqH0?=
 =?us-ascii?Q?41lLKGxR5JkZsqJNq+7Fuya1vGdV+p3p/co+KYNyH4yHItUf5PT5T5IbcaAM?=
 =?us-ascii?Q?plJBibqcfOLhjZ7CX6J8SQx9d4oQoQM7kgwQ/Cn7ysK8oPmg94P63vXa8LPt?=
 =?us-ascii?Q?2vHUZCS5rPlVRS71eCVb8WB22eM3wN8YcOCm1icCkanJfWZS/6kdjY4EkeNY?=
 =?us-ascii?Q?s8diimQP3CVmSqT5xzGn38ZdTrg5EOfsGijjqpUhzs9gBbBDExP4nlnRmMjv?=
 =?us-ascii?Q?dDVWMfFfqPJfJU755OEspZ+Td7OOgjzdo3ybNBK3oQnIGBhp6L16+yGDkGCV?=
 =?us-ascii?Q?RB7o4IqtZsoQsvGW4/m0rXe8c6x9rdzRzmCX9U/E71y8yF6+p2la9iIm21J6?=
 =?us-ascii?Q?GtfiyXbqZcWzzQw5MU/qWJype02QrFQ5PIkEUmS9s6t8Axu2MrBEDdACmBsj?=
 =?us-ascii?Q?duNLvChrxS9XZnr+h/D/55PKZwploCLF1UCRddVNPryk9/vlk/ODtLkV6+rp?=
 =?us-ascii?Q?TaBhwBL46NO2NVxVaPc4jw87U+m73cyWfrvHUZfoQSHzS0yZqKT6J8nYJVj1?=
 =?us-ascii?Q?20In5mTrUxEySQrYYJ/gBNqKKQkoTmZ6uVnG0UeUcArOPAJmIV5lnKx3LhhH?=
 =?us-ascii?Q?08InjOgvSoZVp6/Mujes0CTB8eySnIawLzRKc0MG7cgN04Fq8bz1Ll2uz8Nu?=
 =?us-ascii?Q?wmQ12S9snwQxlPIXFLLHOvO6xY8Get2H8LJaJkENXK3UWcYwk/i0yB2VeJ3k?=
 =?us-ascii?Q?RchztPPLDBZb4xhTmQJvrcjpaigRQ2fs4y06lN4kO26gXsPl6J8/Vu23GxYv?=
 =?us-ascii?Q?dBhAe72+VaQ9e/rKOdTM3ows?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cedc9b4-0f00-4902-f564-08d8e56cf9e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 15:39:08.3539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G5NNp6c3D4AjQ6zRQcDXSFuFhUaNLNW5fduYOicQRby7VpxWT8GFtgjrPhCnYLVy7LUKuQ9DQrqoLcOB6FC52Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2369
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Public Use]

> -----Original Message-----
> From: David Hildenbrand <david@redhat.com>
> Sent: Friday, March 12, 2021 9:12 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; linux-
> kernel@vger.kernel.org; amd-gfx list <amd-gfx@lists.freedesktop.org>;
> Andrew Morton <akpm@linux-foundation.org>
> Cc: Huang, Ray <Ray.Huang@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Liang, Liang (Leo) <Liang.Liang@amd.com>;
> Mike Rapoport <rppt@linux.ibm.com>; Rafael J. Wysocki
> <rafael@kernel.org>; George Kennedy <george.kennedy@oracle.com>
> Subject: Re: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to
> tail in __free_pages_core()")
>=20
> On 12.03.21 15:06, Deucher, Alexander wrote:
> > [AMD Public Use]
> >
> >> -----Original Message-----
> >> From: David Hildenbrand <david@redhat.com>
> >> Sent: Thursday, March 11, 2021 10:03 AM
> >> To: Deucher, Alexander <Alexander.Deucher@amd.com>; linux-
> >> kernel@vger.kernel.org; amd-gfx list <amd-gfx@lists.freedesktop.org>;
> >> Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Huang, Ray <Ray.Huang@amd.com>; Koenig, Christian
> >> <Christian.Koenig@amd.com>; Liang, Liang (Leo)
> <Liang.Liang@amd.com>;
> >> Mike Rapoport <rppt@linux.ibm.com>; Rafael J. Wysocki
> >> <rafael@kernel.org>; George Kennedy <george.kennedy@oracle.com>
> >> Subject: Re: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages
> >> to tail in __free_pages_core()")
> >>
> >> On 11.03.21 15:41, Deucher, Alexander wrote:
> >>> [AMD Public Use]
> >>>
> >>> Booting kernels on certain AMD platforms takes 2-3 minutes with the
> >>> patch
> >> in the subject.  Reverting it restores quick boot times (few
> >> seconds).  Any ideas?
> >>>
> >>
> >> Hi,
> >>
> >> We just discovered latent BUGs in ACPI code whereby ACPI tables are
> >> exposed to the page allocator as ordinary, free system RAM. With the
> >> patch you mention, the order in which pages get allocated from the
> >> page allocator are changed - which makes the BUG trigger more easily.
> >>
> >> I could imagine that someone allocates and uses that memory on your
> >> platform, and I could imagine that such accesses are very slow.
> >>
> >> I cannot tell if that is the root cause, but at least it would make se=
nse.
> >>
> >> See
> >>
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> >>
> kernel.org%2Fpatchwork%2Fpatch%2F1389314%2F&amp;data=3D04%7C01%7C
> >>
> alexander.deucher%40amd.com%7Cd1533aaddccd464c59f308d8e49ec563%7
> >>
> C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637510717893096801%
> >>
> 7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLC
> >>
> JBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3Dxpty77D54Z5S%2FKK
> >> JO5SsVQaNsHoojWMR73whpu8VT%2B4%3D&amp;reserved=3D0
> >>
> >> You might want to give that patch a try (not sure if it's the latest
> >> version). CCing George
> >
> > Thanks for the patch.  Unfortunately it didn't help.  Any other ideas? =
 Is
> there a newer version of that patch?
> >
>=20
> @George?
>=20
> It's interesting that this only applies to these special AMD systems so f=
ar. Is
> there anything particular about these systems? How much memory do these
> systems have?

8G (with some carve out for the integrated GPU).
[    0.044181] Memory: 6858688K/7200304K available (14345K kernel code, 965=
9K rwdata, 4980K rodata, 2484K init, 12292K bss, 341360K reserved, 0K cma-r=
eserved)

Nothing particularly special about these systems that I am aware of.  I'll =
see if we can repro this issue on any other platforms, but so far, not one =
has noticed any problems.

>=20
> Increasing the boot time from a few seconds to 2-3 minutes does not smell
> like some corner case cache effects we might be hitting in this particula=
r
> instance - there have been minor reports that it either slightly increase=
d or
> slightly decreases initial system performance, but that was about it.
>=20
> Either, yet another latent BUG (but why? why should memory access
> suddenly be that slow? I could only guess that we are now making sooner
> use of very slow memory), or there is really something else weird going o=
n.

Looks like pretty much everything is slower based on the timestamps in the =
dmesg output.  There is a big jump here:

> [    3.758596] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> [    3.759372] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
> [   16.177983] ACPI: 13 ACPI AML tables successfully acquired and loaded
> [   17.099316] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
> [   18.969959] ACPI: EC: EC started

And here:

> [   36.566608] PCI: CLS 64 bytes, default 64
> [   36.575383] Trying to unpack rootfs image as initramfs...
> [   44.594348] Initramfs unpacking failed: Decoding failed
> [   44.765141] Freeing initrd memory: 46348K

Also seeing soft lockups:
> [  124.588634] watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [swapper=
/1:0]

@Liang, Liang (Leo) can you attach the dmesg outputs with 7fef431be9c9 reve=
rted and without?

Alex

>=20
> Cheers!
>=20
> > Alex
>=20
>=20
> --
> Thanks,
>=20
> David / dhildenb
