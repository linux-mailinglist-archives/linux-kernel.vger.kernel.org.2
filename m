Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EB33DB013
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 01:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbhG2X7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 19:59:52 -0400
Received: from mail-bn8nam12on2043.outbound.protection.outlook.com ([40.107.237.43]:57697
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235124AbhG2X7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 19:59:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rk1m7+bbqM6ZZFv9G5LyaQEwGZ/Ncev7wzeHgVl4Vo2RZr6PeG/pEFevEosjD+5TJLDFDcZCa2zw3gGYMP+CPAAow6D2K4XLqLMxFTw0yJqzQykMIuGW4zV5s09LraheCGFHq6BuNoNkiQwgUAcO8ZhG1Cugs1XghGXi1ayPP0SsCdXapwRJhHZ2lLPBMozRfQMf0OuANQK4f8wsH5eMdyQ8igJDHzikqm9HG68878XftqgihfJjyxvt8IH2Zpu/a9SMfRtMsRDXT0EDt5EVVRUd0dPBmouuv8rxW1R+olOykfgaO/GU5TqGRq53nLckwuXw79muoDCecjAQSaMCoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8QhcLvU8bV2Z/vJAbZkd8PlsXWPbrUeIvmBgJG1bGY=;
 b=jJ7vPjnZAJWhojGMKrNRzOzhkBXAqwpK5e4P878IEAYus54spnAFPBJeYJJLYfLhI9xL1OKjj2fZgB8EmiHK885uRu1TZrNdY9S5AYfPKer2BY8LYQ8RyMYjYLG9NQMH4t4hVG6nEjA2aYX+2C28hYffrnZUZE92wm8txa2nHgj2kI6oWy7rz2taY229DYp9WbE0OlZTed55WZXCiRUI7qXbMzPbon6isA6dT0uZJBx0KT8tYww+l7CmmNVTpjZOS1oRbgJE585aVuLsCmeNf0D1F1R+UT69fOu1XmH3+JS6Noj80LIt+ZAJOhfu4HE/XcPYSie4W9l9TKCVF+IE+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8QhcLvU8bV2Z/vJAbZkd8PlsXWPbrUeIvmBgJG1bGY=;
 b=DRo7NEPSoGIHLDH69iL3ybg60Qaz92hV2hjR3GPnAm21iq07qOrXZvChCcFQqd6MA5me6wZk2pcFv6E/FvDw+IOl9d/PLLyFKfXuHsvZD7s5jIW5si0VM8ZKkYm0Ex7wK9ibteIjaEfmnmYYfNqn0D4UAyDT+h+LOXGUdeUiOyI=
Received: from DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23)
 by DM4PR12MB5261.namprd12.prod.outlook.com (2603:10b6:5:398::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Thu, 29 Jul
 2021 23:59:43 +0000
Received: from DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::c449:159d:44fd:1cf0]) by DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::c449:159d:44fd:1cf0%4]) with mapi id 15.20.4373.025; Thu, 29 Jul 2021
 23:59:43 +0000
From:   "Joshi, Mukul" <Mukul.Joshi@amd.com>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Alex Deucher <alexdeucher@gmail.com>, x86-ml <x86@kernel.org>,
        "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
Thread-Topic: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
Thread-Index: AQHXRs6Uco2r7eCCPEW3XTp7lQLNb6rflw+AgACR7NCAAC6FAIAAV7jwgAB+vQCAAEnsgIAAA5mAgAAAloCAAAbygIAAie6ggACEBQCAFURmoIALF48AgFgrUTA=
Date:   Thu, 29 Jul 2021 23:59:43 +0000
Message-ID: <DM4PR12MB5263785A21F34B24A0C7FC89EEEB9@DM4PR12MB5263.namprd12.prod.outlook.com>
References: <YJxDIhGnZ5XdukiS@zn.tnic>
 <DM4PR12MB52631035F875B77974FA8D21EE519@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJz3CMBFFIDBzVwX@zn.tnic>
 <CADnq5_Or5maEWTZFzS6iksyoFC=q9=y=-YmPTdPuWRKFhdw0yg@mail.gmail.com>
 <YJ04D8a6LaVRMuGH@zn.tnic>
 <CADnq5_NQonmqtFDpfsWygGzA2kv-W-daDSkxkY2ALf9a1eby9g@mail.gmail.com>
 <YJ0+YbwSpxTrghpo@zn.tnic>
 <DM4PR12MB5263A7ABC342C37CE6891707EE519@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJ4g1MagVNQOvyvj@zn.tnic>
 <DM4PR12MB5263BCFD05993959820430A5EE239@DM4PR12MB5263.namprd12.prod.outlook.com>
 <20210603211255.GA1410@aus-x-yghannam.amd.com>
In-Reply-To: <20210603211255.GA1410@aus-x-yghannam.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-29T23:59:41Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=4dfaf029-a486-4d97-8833-2349d1adab88;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbd37ec9-811b-4aac-f563-08d952ecef7e
x-ms-traffictypediagnostic: DM4PR12MB5261:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5261E13CA4F55CB743484731EEEB9@DM4PR12MB5261.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U9bnK6XZl97QwL/BoCj2LFpJKKOuAWqITioBU1KecRdN1DwH7+NmC0+qXKJnhgwyEWIpnquNMOsBeVQCT9NuyOhd8WSqtKW95v9ucQu+cV6I72Dc/TBRrA+CzlUAsVegn5QiQb/9JLNy/fMZceqG0/5QPNC3EOHOvnI9J7zMDyNgHzSbJAwvwIOPux0xpVXtOMFGDi4zC4AcMWeUqCuEmD9L33NQvCqQNLCiiLEKwr/RU/EiUc1T2ze9D0o1jfzVtWkrPJc6MQBRNqtXjIH3CcQz5hm+QaSLGTlZIa8Br1lV/sZWwwGrh9gLZ2rL09NbrG0ytknQvZwe9Twsrh0JfPqBjRMXB9xRtP2QjxVuJwHhl/wsbUVvi80Zxa2s9Wr2EU90bFG3CST7VBzJw5inGzzxrhYU0fQol0LAh9EOT0coD/ewz+5/luuaEVrxY6PWQ4py3V6HqVQkoTZteoJK3YSHbb6u/Ma7piwcNe61kr0I46tGNCSHyhC0T42jrEPnTjPKJvLJ877L3tvv8tNU0Mebmw8paFJG/fEtjn089jlAP8Fy6vmZdP+cMinBrXXCh5YLPXmh3HReTjwt6Ojpwi543xdIFLNy9PqjheevJ3TrCkUleRPxV+C4sZKKHXptqVZXC9gKmm85Cacby/MGcQLHnI/5+KdDZTFCOfgGMNVXpVIdNB4obGkq9ePKgD05spPL/kKo0CpCKVvb9z/Fug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5263.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(86362001)(4326008)(55016002)(9686003)(186003)(6862004)(6636002)(26005)(5660300002)(66446008)(64756008)(71200400001)(2906002)(83380400001)(33656002)(53546011)(6506007)(7696005)(8676002)(8936002)(54906003)(52536014)(76116006)(122000001)(66476007)(478600001)(316002)(66556008)(38100700002)(38070700005)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WewRQjJYeEZKB/xYdm5lznEhYB6IEEGlF2fKMJDZkMtXak0s+fqIoYLVyvo9?=
 =?us-ascii?Q?y6PyDwmDJ6620jXkrIglXmLksYIbGiPcay0fFQqksUuBXeBoYlkUZE4s7YUt?=
 =?us-ascii?Q?ouigLSYEnifll4DCP6cMxAdS6UeEDxPpyYol45dvkJ4j6glI10QoCeFa+lCb?=
 =?us-ascii?Q?s0Vn5mU7cgC/XlA/swuNUDVjy9XjsiN4Ayjt3hUiYmsXQoCxtRlA9p8e3oY3?=
 =?us-ascii?Q?2TDuQBeaWEElYm2NRcbPFjz0auudoDmAdhVVB7qItgIJLXwobPiyQ0lRl8HO?=
 =?us-ascii?Q?QkCjaKXdi5CHhr9mVcG3DsvwV2xAYxmiapts6uwhTuBHmRRabzhmCSDBN6BF?=
 =?us-ascii?Q?4qEDqCkkUwdedz9wRCclqgttqDgNnQ3/V8H/q8kwX//Y6ypShr2V89WLpnqr?=
 =?us-ascii?Q?astChz9tAr8qQaPuzoupRIpE9a7zD7V+71yOzVrXYgamDyQDWDipIfYFXWbz?=
 =?us-ascii?Q?PHHzxnFCeIDKpVTRxRRgQhGFFIkRl7MLKx2jxfAQG1WSjNi1bnpk3TtjEd3E?=
 =?us-ascii?Q?i0O+rNcxualHZZ4uLdW5pbvy2Ig0X/OIujj9Pmgg79eRpSL0Ong3ue5x4m0c?=
 =?us-ascii?Q?ZLRCu/1a0KTN1qzNpaT4lvW61cs4CSmKeIT/6VGe8dHIG82uw4jAAavCkzVz?=
 =?us-ascii?Q?fiq53UbcMwhUcxauPtsOtlfLx1S1v7XIrZKjp2x2kX6jf+/MonPc9vGxHnGt?=
 =?us-ascii?Q?q2gjn49AUl7aTT4gmCA1AHr5AzxCBQZG2MaPHXzMAFA67DWpHsbjKVtxLx8U?=
 =?us-ascii?Q?R3jJzqKwwhzv0QEEdI6KkRLczKmUlUfNqZAeYgX3e38TQx/Zx7dFp5k/PsNb?=
 =?us-ascii?Q?BFe+VATZw3oiveEqSnrwbIWFmzaYDxggbwqGclr9qV09EO5HIUIiQ3ZqpjRO?=
 =?us-ascii?Q?wSHvNG9rmqxcGgamJ3hnJK5HXiykaLnsS2D+I8z2WEBy1EAfuzXBc3mKcBPY?=
 =?us-ascii?Q?7Zs/UZ18Dt50LTncuU8hFLkwibtG/9ajOc5YL2ID8FJ8G3WwiZL+BMW9GEC1?=
 =?us-ascii?Q?KGZxM/X9Xe56XvRYqOODfFmfKwyvmF/yuaLMLwbzBO0ySwtVTNOveAgd1xPI?=
 =?us-ascii?Q?c/4V27kyxGCkaeGX0gRl6kkkk9sD0K0UCq6Bt2FULYV2s22R+2uawAaxMQAF?=
 =?us-ascii?Q?/8VuU9WL0X3uPHPTzaGv1ERj20bOs5rF7w6c3bKerEwzpUHCXIznxx44MtpT?=
 =?us-ascii?Q?C1QwllIPw1WC5RshIVHOm+PEMM77XPSqCdT0L7c3GQJIzbo81xxleXILwVa1?=
 =?us-ascii?Q?rNhyFV3VVSQwPm3/xYFUHR2X2vdIqBKiQOhAYu7WgfEuPUvnXs0M87yjtJFZ?=
 =?us-ascii?Q?basBKQBjNCjrhXBAXp25oPlk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5263.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd37ec9-811b-4aac-f563-08d952ecef7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2021 23:59:43.2843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QUSsQZ4yopHmvGJJ1de8QUjhj8RVwBfWL+7DyJp9e/TEilWtzqzYAoYtF6GvSMDdJDwVcpdLiAfEHbhQcOuXaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5261
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only]



> -----Original Message-----
> From: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Sent: Thursday, June 3, 2021 5:13 PM
> To: Joshi, Mukul <Mukul.Joshi@amd.com>
> Cc: Borislav Petkov <bp@alien8.de>; Alex Deucher <alexdeucher@gmail.com>;
> x86-ml <x86@kernel.org>; Kasiviswanathan, Harish
> <Harish.Kasiviswanathan@amd.com>; lkml <linux-kernel@vger.kernel.org>;
> amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
>=20
> On Thu, May 27, 2021 at 03:54:27PM -0400, Joshi, Mukul wrote:
> ...
> > > Is that the same deferred interrupt which calls
> > > amd_deferred_error_interrupt() ?
> >
> > Sorry picking this up after sometime. I thought I had replied to this e=
mail.
> > Yes it is the same deferred interrupt which calls
> amd_deferred_error_interrupt().
> >
>=20
> Mukul,
>=20
> Do you expect that the driver will need to mark pages with high correctab=
le
> error counts as bad? I think the hardware folks may want the GPU memory
> errors to be handled more aggressively than CPU memory errors. The specif=
ic
> threshold may change from product to product, so it may make sense to
> hardcode this in the driver.
>=20

Sorry I missed this email completely. Just saw it so responding now.

At the moment, we don't have a requirement to mark a page "bad" if there is=
 a high correctable error counts.=20
Our previous GPU ASICs which support RAS, also do not have such a feature.
But you make a good point. It might be worthwhile to go and ask the hardwar=
e folks about it.

> We have similar functionality in the Correctable Errors Collector. But en=
terprise
> users may prefer a direct approach done in the driver (based on the hardw=
are
> experts' guidance) instead of configuring the kernel at runtime.
>=20
> So I think having a separate priority may make sense if some special
> functionality, or combination of behaviors, is needed which don't fall un=
der any
> exisiting things. In this case, "special functionality" could be that the=
 GPU
> memory needs to be handled differently than CPU memory.
>=20
> Another thing is that this behavior is similar to the NFIT behavior, i.e.=
 there's a
> memory error on an external device that needs to be handled by the device=
's
> driver. So maybe we can rename MCE_PRIO_NFIT to be generic
> (MCE_PRIO_EXTERNAL?) and use that? Multiple notifiers with the same prior=
ity
> is okay, right?
>=20
With respect to MCE priority, I was thinking of using the MCE_PRIO_EDAC ins=
tead of creating a new priority as the code in the GPU driver is doing erro=
r detection and handling the uncorrectable errors.
Not sure if that aligns with the definition of EDAC device in the kernel.

What do you think?

Regards,
Mukul

> Thanks,
> Yazen
