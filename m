Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15E73936B4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 21:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbhE0T4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 15:56:11 -0400
Received: from mail-dm6nam08on2080.outbound.protection.outlook.com ([40.107.102.80]:48032
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235437AbhE0T4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 15:56:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ero7uLqlhbdws6/HqVbA1LBLPylqvDsRrpiCIsi39VxTgQFSw6vyd8QwfcCLaG6W0PQxBop0i3OjduXUTbRicL/U15M2ZbnU1kX6ApOO4i+iH63fx/VbdhqpfnOZPJLMasLpinKxHTY9QbvXr3u7NW5afdmKuEKrZMkcygLOcRBZMv+opy12MaLaiGDvnIYMbCkpL446IcohMojO05jo365S+qPH8DuKryM8Sonuhi0LaPBYYBhHPkK8SUsLCLtCN4T3qm3Hav5Knb0+cDsnSwLCM13s213o16dL7O3K3ccPAPdzr9k3Cqz/rQtpargktodST8BHk2pL66lfVGGadA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2+UPReQp4656urLn5hGbGcgOGaYBuIKWBFHqftsXcs=;
 b=nW7q01FsWD+7nhniweJfQAI2m3yqqDqOp9dafTNu6JcQyQR3nUHlWNuwfvFpxvGn7fR8Jal4vi4f2YLIb/bdKeZI2nJ0BNvWSdimaLeL6BjzO+46QJQmKc0tXhMbXyLoihN2PQcVNihVXW0GQPuqBtbilteoI10MdAuO5vDFQVUwJPkHLaxKClzaHU91EhS/7y5jBNzYEIc9rmP/J1N40BpkYkR/t2pFzNyQ3VDbjjqbGDSaIo5SRG4D2KB3hqQ3gR4xA1Bfh80Ek01Did/TigYVhTgnx5I7ISCICi2F/iFgZztW8e0SxEh+u7XlZ9Gak/kXADozX0hqIGgRVLMbgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2+UPReQp4656urLn5hGbGcgOGaYBuIKWBFHqftsXcs=;
 b=wWNYQJERPpIQhsgDVfMnxExfJXMVgLXZu+B/bJx8eZbHFUjcMLAmqN1TmsBrJNYpY+bg1gzOGd8ZJRKsB165D+CqaZACqcHcBplXnu3y1DdZUifVgikg1H8AGGXh/pBkes4whtOdGVnGYW6DMeIxL5d7qnRLWv2Sr8XIHayacOw=
Received: from DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23)
 by DM4PR12MB5166.namprd12.prod.outlook.com (2603:10b6:5:395::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Thu, 27 May
 2021 19:54:27 +0000
Received: from DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::8ce9:f643:9ce6:af9c]) by DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::8ce9:f643:9ce6:af9c%6]) with mapi id 15.20.4173.022; Thu, 27 May 2021
 19:54:27 +0000
From:   "Joshi, Mukul" <Mukul.Joshi@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Alex Deucher <alexdeucher@gmail.com>, x86-ml <x86@kernel.org>,
        "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
Thread-Topic: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
Thread-Index: AQHXRs6Uco2r7eCCPEW3XTp7lQLNb6rflw+AgACR7NCAAC6FAIAAV7jwgAB+vQCAAEnsgIAAA5mAgAAAloCAAAbygIAAie6ggACEBQCAFURmoA==
Date:   Thu, 27 May 2021 19:54:27 +0000
Message-ID: <DM4PR12MB5263BCFD05993959820430A5EE239@DM4PR12MB5263.namprd12.prod.outlook.com>
References: <YJuhs1WsqtJ7ta1L@zn.tnic>
 <DM4PR12MB5263797EB7B2D37C21427A88EE529@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJxDIhGnZ5XdukiS@zn.tnic>
 <DM4PR12MB52631035F875B77974FA8D21EE519@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJz3CMBFFIDBzVwX@zn.tnic>
 <CADnq5_Or5maEWTZFzS6iksyoFC=q9=y=-YmPTdPuWRKFhdw0yg@mail.gmail.com>
 <YJ04D8a6LaVRMuGH@zn.tnic>
 <CADnq5_NQonmqtFDpfsWygGzA2kv-W-daDSkxkY2ALf9a1eby9g@mail.gmail.com>
 <YJ0+YbwSpxTrghpo@zn.tnic>
 <DM4PR12MB5263A7ABC342C37CE6891707EE519@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJ4g1MagVNQOvyvj@zn.tnic>
In-Reply-To: <YJ4g1MagVNQOvyvj@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-27T19:54:25Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=10bdc818-759b-4e7e-bff9-04b263f96376;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
x-originating-ip: [72.137.116.80]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd1c11ef-dd3d-435d-b1b9-08d921493c13
x-ms-traffictypediagnostic: DM4PR12MB5166:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB516692DB4C3811655C79CBE8EE239@DM4PR12MB5166.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7CsCpCzfgZZtXrdo5aCiu6UiBPcQTwcRGINojLLAhMvX+Kb73oV2bierDJ0XKWLsSWLqBZHoc/m5oK5QYNRokpgnSZ3vGxjenHPJUhGJLEwh2zCNO/0JVXcO195Gso2qWz5BnxoIfkTl9ToFRVSfTflrJKo7F8yIIilCZeWgpTiONIQBQpqcrOfpZm7+6hSI9PJhRH3t0Ubi7Xmia4x814nsAPZwaztOV7xNsB7qI0Q5bnCfenJyBAbyO9j3l7C/RzjKqWsWLFsLwUHoaywwQluhTXX8vRvK2bYitCIjr+TJxxsoSxhFaeTI6g7KM6ETbPX3lkuXv35xDZC4HlP1JvTfBcDZI/QzzvR3Mxz/gD7aL2YKv0hxGno0DtHfSPJB5f0AGby8Dw/ewLJOzE/shjh1RHpD/LHYQENe2Z3UGgW/Ssw4IQEYAqBzlN5+j5HfrCc3zY9PEDVQhjQh33BfpgB6pMQkJ4Vu/lR4Iu+LDzheG6q+BsUOOp11MTxU9fmKvQUumnz7Dv+uFALoT1WJiso4nj3n4J+sA17fqKsdJN7lf1OXybEwMJn9+yADOsDUx0XLY6trMQoqZProEIeb1xVMVqC+oY5CYB3gz6Fk1i3Ha6ut5ICQlucwE8QMxXaeG6lQ1rc1Sx8Tven2RTgQbUhHsOPpCFEA7prcC/qKJOmzmV7OBwq72vnWYvtnwp5JubMDb7yfJoeQzwIGwB+0BPSaoRPExd5oCgrokKVOi2Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5263.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(86362001)(71200400001)(478600001)(45080400002)(33656002)(83380400001)(6916009)(966005)(26005)(66446008)(55016002)(9686003)(66946007)(4326008)(76116006)(186003)(316002)(54906003)(6506007)(8676002)(64756008)(38100700002)(53546011)(2906002)(7696005)(66556008)(8936002)(5660300002)(52536014)(122000001)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?4pt+DV0qFl+hBkkQdNsYU1P4mQzs4T7y/+6OggwxV/D3bZSGHA+EPL0D3L0J?=
 =?us-ascii?Q?W9S7PpnW7qu+3KbHr2WWgpRa98J8nBeXCSe/TfRSpZd/aGTMM/sgfDGiCUH1?=
 =?us-ascii?Q?W65M1J672fwyRTe6uPjA0vDjpaD8rtOx72kZqwawR6yQByHU8G1iSu02KHZv?=
 =?us-ascii?Q?TWRh7aQHpzGxa/vgvbianm2z0DW8YdMovBdbw2du4xZoRjl0qJe4PEKIW2kK?=
 =?us-ascii?Q?7O+ekNAXSEhLdoifUXjhINqkym1TrxtpNgvKxp55pobZdEbwxOwpnVEQyQGb?=
 =?us-ascii?Q?YGiYMr3naWX2oVl2Y9GlbyccT1GDHWkogGTkR7PPrIJcNwbiSM51reHCm/3s?=
 =?us-ascii?Q?gVk2k4JcYAi7dUclsCJq4cxWlq1BVHRG/GWFdh8Swa1GxNgVOvfG9vZ0Vmyd?=
 =?us-ascii?Q?yrDunPSsKd9jl1LaJQUNA+s6AGXOLuD75bFIQS2e6hwVfT8H83k6kIr6TFck?=
 =?us-ascii?Q?60Y/vBdEB5pQPVtGu8cgK6q/ma4OnBrzhH9BsdYdG7tLa7ruRZPZZqei0m4h?=
 =?us-ascii?Q?yCdouoaBeJQ/4o0AsaFIM5kzAvWldwpsr1jlRFfWc6PfdCc5lkD6yyb2cxV6?=
 =?us-ascii?Q?Wm1svURwCUIbZJVFFb9uU5ADppYRt7SaXtqDjwUp71B7T8d9Sdhd92cH9/XZ?=
 =?us-ascii?Q?KhUB/E6gS+7S7S1HPAM1Sz57p+s212Icy+UzVs8/eB3aW+eQnczU+auG9Lu4?=
 =?us-ascii?Q?CQEuSV1n8jWXNN+Ss/UIvBWOq0menNJtxnO+MK9ARq+UhY/J9Lpy69CFQpmK?=
 =?us-ascii?Q?UuvnP/a04BQdYIY/T2Zg7NRoatl+4QN3i+QK9UhdIl4nO/RwioTkJG097K1p?=
 =?us-ascii?Q?pxXdMkTTozvuluxPfnYHIdbGRIWZWAqaPkJkiX3cWzGnJpvzvZten63tGjol?=
 =?us-ascii?Q?77ntic1qfi0eyGEitLY008rfqQz6+ULONOjXOy/AvY0wY5fckJ0umLJrSzXj?=
 =?us-ascii?Q?OkWr03zVFUj6yS6d87WwDMafI7NXpHgVWPHXnd7anONELX4oaLlWDWCEiaXs?=
 =?us-ascii?Q?2K72/d9VjEHWyIGlJqc7KFBYdZUWt0HamwHtP0drveqipDGCybaTLtniTpv7?=
 =?us-ascii?Q?jcvUT5fA42J+jRFbQqgL6I7d9VIvQqhN7Ul+J1x0SGhQumAKxmKv8sOiak0M?=
 =?us-ascii?Q?MGXytNaGKsqZ4L2UcR8LDvkox8Ur9ln987mXM2MzZ9V9gNJYftZP2zFlTZx2?=
 =?us-ascii?Q?ZO5/f1SEOPH3/VR1uHEQR57koFTIFDFLdmHd9U/AB5TBjK7qdrfyvLj7ILFn?=
 =?us-ascii?Q?hqpwASemBqNZzwccbnHheW4LN8XPlAdnMuJkpTpKVTVyQKajPj94Ai0Qnle6?=
 =?us-ascii?Q?GBNhTDXWpIYR8HCT5KRozCpl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5263.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1c11ef-dd3d-435d-b1b9-08d921493c13
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 19:54:27.2594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qd3b8LAsXjmcJYrOrE33jBxK1TgqEURPnUR2oSxb+TFVaRe9cPinJgujq9pnDtMezyfbGe1GTtedbXak9DUsIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5166
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only]



> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Friday, May 14, 2021 3:04 AM
> To: Joshi, Mukul <Mukul.Joshi@amd.com>
> Cc: Alex Deucher <alexdeucher@gmail.com>; x86-ml <x86@kernel.org>;
> Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; lkml <linux-
> kernel@vger.kernel.org>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
>=20
> [CAUTION: External Email]
>=20
> On Thu, May 13, 2021 at 11:14:30PM +0000, Joshi, Mukul wrote:
> > Are you OK with a new MCE priority (MCE_PRIO_ACCEL) or do you want us
> > to use something else?
>=20
> I still don't know why a separate priority is needed. Maybe this still ne=
eds
> answering:
>=20
> > It is a deferred interrupt that generates an MCE.
>=20
> Is that the same deferred interrupt which calls
> amd_deferred_error_interrupt() ?

Sorry picking this up after sometime. I thought I had replied to this email=
.
Yes it is the same deferred interrupt which calls amd_deferred_error_interr=
upt().

Thanks,
Mukul

>=20
> --
> Regards/Gruss,
>     Boris.
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeopl=
e.
> kernel.org%2Ftglx%2Fnotes-about-
> netiquette&amp;data=3D04%7C01%7CMukul.Joshi%40amd.com%7C7e04d0ad3c6
> 147a8dfd008d916a66bbc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0
> %7C637565726326540654%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata
> =3DAWHJvqIbtkGl6OPC86alAtnxsleq6UVe9mcM1MjxpUQ%3D&amp;reserved=3D0
