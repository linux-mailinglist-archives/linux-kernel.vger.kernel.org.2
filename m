Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204C040828D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 03:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236830AbhIMBcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 21:32:54 -0400
Received: from mail-dm3nam07on2084.outbound.protection.outlook.com ([40.107.95.84]:60604
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233133AbhIMBct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 21:32:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6+ns2jgVyYVl/ZKKX2UwKtSsSJ0qi/4R6nLeeot2mHfjEdURS3gQM0jPSzMMznIg3iQy3+xhoZGAZ9DEc9a//KvrDJITKop9VzCaqbjoiVrjfFJx/yDZTE+9GNML3xjtj6kAIvuRKOkcoYVbodtmqvxpntAr9w0YaQdPtR42NQigC5RvqMKZEVsUt6PS7q0FpGmOitzNnH1J934gbnE/IE9Myi1ZtR0QmCxS5ZHLOsRIh6H2hQqVMm7l+sj3HHiv5sA6PprDDDtTDJZEVjwX94yKSTteO5sZF9m7uBbmlp4pq/TyCsSd0uzLUMvc/WyIUfE9avMhfkObJd4zuepqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=iT2oUwDr19TJUfXIKq72kdxXPCrWQBfMWChZRZEjBuY=;
 b=P0lqJJIWgkZWM8FiVAPO+6b2FqeBTVvp6jGVAVPFY/NVSUtKOvAuBPQDYliq6TibySrEty3DHZmvjWmlObdxo4y8km1oL6aWFfC0wT45I16IdtH92jr12UXV6EzektN7O7Bq58dXDxGKrujroRWOJhASx8x7zNLmY4isBu1J76QlUVq+LBObg9JrE3c/7WE+JvD9XugYUDqM9qf2gCxBGHtAUX9+rszOvo0J+JOObHm+d0WfRoPRprJq8UtKq0gBUBxFFsK6n+dGK18u/sxkDJI7lClTOYHBX/wC4gUsfMDdzDWOb9QxnTshFgv2Vqp6k4mjVpGljBp83JbRTL41YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iT2oUwDr19TJUfXIKq72kdxXPCrWQBfMWChZRZEjBuY=;
 b=WkIml3nn9VUG6CAe15mMnpNHtCVmG7CNj0bi5/buh5Rpkwk9xYdPY25cp/j8PrCbOAQsG12110elldLJvn+6tr7uoFkDcBQj0goX5t6XX6WiKiWaWhNh4iIzORma0v4sCrAkZ8OWoS8s54H/ddkICvSaJvUBWqRsinAWxAqEjhk=
Received: from DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23)
 by DM4PR12MB5264.namprd12.prod.outlook.com (2603:10b6:5:39c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Mon, 13 Sep
 2021 01:31:31 +0000
Received: from DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::90b2:e7f6:c5e5:c80f]) by DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::90b2:e7f6:c5e5:c80f%7]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 01:31:31 +0000
From:   "Joshi, Mukul" <Mukul.Joshi@amd.com>
To:     "Joshi, Mukul" <Mukul.Joshi@amd.com>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
CC:     x86-ml <x86@kernel.org>,
        "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Borislav Petkov <bp@alien8.de>,
        Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
Thread-Topic: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
Thread-Index: AQHXRs6Uco2r7eCCPEW3XTp7lQLNb6rflw+AgACR7NCAAC6FAIAAV7jwgAB+vQCAAEnsgIAAA5mAgAAAloCAAAbygIAAie6ggACEBQCAFURmoIALF48AgFgrUTCARtd2UA==
Date:   Mon, 13 Sep 2021 01:31:31 +0000
Message-ID: <DM4PR12MB5263161FCF60F73D66EADFDEEED99@DM4PR12MB5263.namprd12.prod.outlook.com>
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
 <DM4PR12MB5263785A21F34B24A0C7FC89EEEB9@DM4PR12MB5263.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5263785A21F34B24A0C7FC89EEEB9@DM4PR12MB5263.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-13T01:31:29Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=4dfaf029-a486-4d97-8833-2349d1adab88;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97b6c636-88e4-4095-0d3d-08d97656375e
x-ms-traffictypediagnostic: DM4PR12MB5264:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB526477A8DC111BA5ED8A6232EED99@DM4PR12MB5264.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DF0NGSVwfC9YNsZuB8aLB4YQF0V3RMkwHaDHOut19qmTQZOPd/KxAyAzHGl8Uy/fMt/GzZlyerRiAM3+fHNalHWQ84CYiEtrBbJZKBXB94wSotQ/pDecOS3k+36mRiZhKdu2aC3JfQgEJMxt3nc+30M9rrRRUZOk4lP3lQSGc9Az0kxpAsrua1l9QgUpyPtk3ixWo8WeC2wqrlTHt69kHhY9Ej+wl2Mi02+zqucAsv+yzpIGSDlFwvqttuBg1lszr/5lH1j+f01FhiosgoR4mX1/spTqrxzSAQTQNeXI+IdCvlIXE3TwhNOTCu5UtCMRDf8jN+EKdc6j6VYvPRYm8eGFjCpCTyb5dIvQcXiyKmJqyFXulQqD8CyY9mfFgsjF8tM8GreDDoqapP5/hPRtTQ/KqEP/YbOa37lFqXs1+7hZ56XLvy16uQJ177k3GDC0NRenxkhIHxrRCpTBSUlPS2VaL3LH417oZw2cU7/DlOQYqdFcfBDONz/6eWLIqJgaF6p2PyzsxL2TvDq1Kc4uGYU70JEC2NKs1Z18n0Q66avGROiENwas9mqh3JUDeaS5pOApxYaZF7QRVxWdb0BKgPcYu7PDW/7Cds5jRTHRC8RIYQKpzBVKD290HBsbesgrPvwS1XW1m67ztOzQvg8Ne6AM0ybxVojyEY45h2ahUJVLLnKyP/CZOj4xMu8lHLJW6HDIIbmzEyiFEB8R2f8dmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5263.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(71200400001)(6636002)(76116006)(53546011)(66556008)(66446008)(66476007)(64756008)(66946007)(7696005)(8676002)(4326008)(6506007)(316002)(83380400001)(33656002)(86362001)(122000001)(2906002)(186003)(110136005)(54906003)(26005)(38070700005)(38100700002)(478600001)(55016002)(45080400002)(8936002)(966005)(9686003)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?36xyzjR6FCvk1+/kuu+bC59nlte+ljIXD7oIFUxKAz3kroGgNQfc74oU6qE8?=
 =?us-ascii?Q?2+8HgXp+mh1cGdtgZEEgoD97fX0SNzKK51Cy7HgIpReBHvnbwbEkBvhl7C+X?=
 =?us-ascii?Q?X8lZMNgsnw2KiZOU29AshYLaa/j+kgqT5pbWxdlU5BxPnbKEesZP009OEZXU?=
 =?us-ascii?Q?Wled4dKSa0cZvj3+DfQIA2fq4tnuZswIQajDrZx9JMOSLRwGz5EM2CTDaCnR?=
 =?us-ascii?Q?QJxpQfnIXMmi3LowvcZK5+Jgfc4qaOYOyO08dWbD/ifwWW4nEdYOKUyd+aPU?=
 =?us-ascii?Q?kgHQgtikVJLeVpb2AqTWnIzbQmlQvTNcPo+4NBly9UPjRb409Fq2+rcjUuoV?=
 =?us-ascii?Q?NtPltrqJU4gYbCTGBg/059dcQ/cjgHGftiJa+/DE8iCtCHGP6m5g7CZtcmZU?=
 =?us-ascii?Q?MUJGL9xcg+/3AJF25/9+HHYQ3Sv62hpVGGVgcFAirruLerBG2qFnW+aalaGM?=
 =?us-ascii?Q?K5YgbwePzNr0wXD2Yh1z7AlXzLW/WGmRYCNBk6Fdsx10LKdQn6WbarKAhv4Q?=
 =?us-ascii?Q?3uny9u93/1hIOqjnK7WrFE6LpKaPa7WOWXRyYbC2kPZTZAVdREYQECYUyC5c?=
 =?us-ascii?Q?Bo6wikiWzuiRaTBAkOlAWRnZttdio1jhweh0bgXGRNvtfdB6ZfiVzvOzLJ+9?=
 =?us-ascii?Q?BYT2lS0SAYbhsYTUxAPOgoMthRa6bo6FgFzTRsK4EBWueFUnJ0h0N/4I1mMi?=
 =?us-ascii?Q?YMu+q32jfitq6ellee7hhBh/3sbLSVYSS71RenYguDiGTh0QqjGRT9om8Ytw?=
 =?us-ascii?Q?ojKfwaOL1U0w6CQR4oE2Baa1dzYKvDzgLN+XFNoUcs4rycmpNlaowqUopGFX?=
 =?us-ascii?Q?Q+at1nG9sSqkQD3g3rUXLESvCP2JQJfEVHKVHbop+D4zBnrUtNgTCfoNiFuC?=
 =?us-ascii?Q?rVcuT/kHOfqzII6uNs8tAmQnga8mE4JuFl2UI3Hl1sTDt8LvEJIPPo37ImHs?=
 =?us-ascii?Q?fXaBDLTD0AQmuXWDN6h98fS5Ve85fqx2vpWJgvEGaqnIuf4ELVVvn9amf0Up?=
 =?us-ascii?Q?2p3r7mCJzCqldFg+NvvVbovg0ilWbeQ7ZuWnQiBdP98srsoJ7ZJ0GGg5iwOj?=
 =?us-ascii?Q?ip6UnFtJ6hNg1v0Nk8ANVEBmaU8vUo2a53zJ6itEquvL5C54XPlevAqhrXZI?=
 =?us-ascii?Q?I8aDMCEJr3yuRiI4fEhqSdbv1L386+6UwDlD4eYXgzGVSJKSm8edTFCOK6MY?=
 =?us-ascii?Q?Erx1anQGVU+Astn3Rm3ZJ3JVB4HK7evbHwKjNGBL53KDZXC8R/Za62BxP4NU?=
 =?us-ascii?Q?0XXte+Jfng1KQZRgDtGHHPqZySHZrT7RM1XkgEnuCoWHQsrEIZcD2ok552Fb?=
 =?us-ascii?Q?Ieo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5263.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b6c636-88e4-4095-0d3d-08d97656375e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2021 01:31:31.6288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LVCqWftLOJMwhe1ylCJj8mPAKr4HLU8vTjKQHFwM53zSFoMmFjtqSyICLE40wwEnEytqLx2mxjhu4zCIlMiWHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5264
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only]



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Joshi,
> Mukul
> Sent: Thursday, July 29, 2021 8:00 PM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: x86-ml <x86@kernel.org>; Kasiviswanathan, Harish
> <Harish.Kasiviswanathan@amd.com>; lkml <linux-kernel@vger.kernel.org>;
> amd-gfx@lists.freedesktop.org; Borislav Petkov <bp@alien8.de>; Alex Deuch=
er
> <alexdeucher@gmail.com>
> Subject: RE: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
>=20
> [CAUTION: External Email]
>=20
> [AMD Official Use Only]
>=20
>=20
>=20
> > -----Original Message-----
> > From: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> > Sent: Thursday, June 3, 2021 5:13 PM
> > To: Joshi, Mukul <Mukul.Joshi@amd.com>
> > Cc: Borislav Petkov <bp@alien8.de>; Alex Deucher
> > <alexdeucher@gmail.com>; x86-ml <x86@kernel.org>; Kasiviswanathan,
> > Harish <Harish.Kasiviswanathan@amd.com>; lkml
> > <linux-kernel@vger.kernel.org>; amd-gfx@lists.freedesktop.org
> > Subject: Re: [PATCH] drm/amdgpu: Register bad page handler for
> > Aldebaran
> >
> > On Thu, May 27, 2021 at 03:54:27PM -0400, Joshi, Mukul wrote:
> > ...
> > > > Is that the same deferred interrupt which calls
> > > > amd_deferred_error_interrupt() ?
> > >
> > > Sorry picking this up after sometime. I thought I had replied to this=
 email.
> > > Yes it is the same deferred interrupt which calls
> > amd_deferred_error_interrupt().
> > >
> >
> > Mukul,
> >
> > Do you expect that the driver will need to mark pages with high
> > correctable error counts as bad? I think the hardware folks may want
> > the GPU memory errors to be handled more aggressively than CPU memory
> > errors. The specific threshold may change from product to product, so
> > it may make sense to hardcode this in the driver.
> >
>=20
> Sorry I missed this email completely. Just saw it so responding now.
>=20
> At the moment, we don't have a requirement to mark a page "bad" if there =
is a
> high correctable error counts.
> Our previous GPU ASICs which support RAS, also do not have such a feature=
.
> But you make a good point. It might be worthwhile to go and ask the hardw=
are
> folks about it.
>=20
> > We have similar functionality in the Correctable Errors Collector. But
> > enterprise users may prefer a direct approach done in the driver
> > (based on the hardware experts' guidance) instead of configuring the ke=
rnel at
> runtime.
> >
> > So I think having a separate priority may make sense if some special
> > functionality, or combination of behaviors, is needed which don't fall
> > under any exisiting things. In this case, "special functionality"
> > could be that the GPU memory needs to be handled differently than CPU
> memory.
> >
> > Another thing is that this behavior is similar to the NFIT behavior,
> > i.e. there's a memory error on an external device that needs to be
> > handled by the device's driver. So maybe we can rename MCE_PRIO_NFIT
> > to be generic
> > (MCE_PRIO_EXTERNAL?) and use that? Multiple notifiers with the same
> > priority is okay, right?
> >
> With respect to MCE priority, I was thinking of using the MCE_PRIO_EDAC
> instead of creating a new priority as the code in the GPU driver is doing=
 error
> detection and handling the uncorrectable errors.
> Not sure if that aligns with the definition of EDAC device in the kernel.
>=20
> What do you think?
>=20
> Regards,
> Mukul
>=20

After talking to Yazen, MCE_PRIO_UC might be a better choice for the MCE pr=
iority as we are dealing
only with uncorrectable errors.
I will be sending out a v2 patch with changes to use the MCE_PRIO_UC and dr=
op the MCE_PRIO_ACCEL and see what the feedback is.

Thanks,
Mukul

> > Thanks,
> > Yazen
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.fre
> edesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=3D04%7C01%7Cmukul.joshi%40amd.com%7C7d32897fddef448ab0
> aa08d952ecf41f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6376
> 31999953383488%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ
> QIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DYWZz9
> OYTMOhBl4183kV5ZYj01yw0xwNj%2BjTdXejFKH8%3D&amp;reserved=3D0
