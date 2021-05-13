Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6277A37FFBC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 23:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbhEMVTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 17:19:32 -0400
Received: from mail-mw2nam08on2071.outbound.protection.outlook.com ([40.107.101.71]:18785
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233360AbhEMVTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 17:19:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivyA7oqvPjZoDyD4wGCcKVqwwvcNC3A+UgRzoBW450N6oq2HDA/hFx8PsKzku+Cy+mDwS723aGTaIYAVzWALhFDKbQWOIYntQY845v0C/dphWF9II8n4dYHNpnCI6fAGgYh02tOluxeimv9RusqkDSNG5N+iBcGF7D3T27Xd8GN7X7VUwuZ0l3LQLbqVjhe8XyZOhaSvZ0YqTCJJFReishCUa/UrS2GSFjWa/mfpz2AMxFjnziRj/GjZzwf7aO/Eeu4UGYbBBWAL8VNkwVVxDgfFhaJRTGYTmFA30EDbU11c3SC15X2AWB6TWnuDEd529PKD0jTBJe1LavfaTD1TKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Yy8EVXsj92so+/FKwr4k+5zDhimh1pjhUk/zuk8Ua4=;
 b=WlKC1e7155vaWdgpaNejJxwpyunnumod9JiUrwEoJuDjri0IblRs8sy4JCyoyse21RawmoQVtWlL8vVSME1Nrjbq6JdqIrPl7BjxxXGebOnnfgN7b3hj3CPT0c0YCdvMMEoiyxRPPRt1ews7H6zA0qwnw88OTqt3pjeaSyQwgjh/V42npRFYLOrZXm8FNieHjoIqxRU9223qzOwLBhE2R6YfAgc5CxfMOHRRnJLLIYNmUfE/rQ4f0gBbz+yTuNxCwxnt4VbHchFELqIBCJGmazUn2ykIj9dbUYqlLbc/iIKx7vE8XoZf4rFBIiocaZzVYHoOu18zvc1V85OHo+b7GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Yy8EVXsj92so+/FKwr4k+5zDhimh1pjhUk/zuk8Ua4=;
 b=otDc8gGkJ7JEO0xgMkyJQLeUlAJHCQENPXPgyBn7fMqk8mxoMiYo35+nu9jG5ciDk+5L35Bqj9sa98F/wPCizYD4LWQ7J+wF9Og88j8X/q/P48t7dhXeYStiBljIeS6cu8c8JfBu1WslbqtESKgtII9bhhQ3fIwB8PiB2c+HTbQ=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 13 May
 2021 21:18:18 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 21:18:18 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     =?Windows-1252?Q?Thomas_=93illwieckz=93_Debesse?= 
        <dev@illwieckz.net>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: On disabling AGP without working alternative (PCI and PCIe are
 also affected)
Thread-Topic: On disabling AGP without working alternative (PCI and PCIe are
 also affected)
Thread-Index: AQHXSCf9oieY1dTgdUez1KCkWnvsiarhwpAggAAfMACAAANj0A==
Date:   Thu, 13 May 2021 21:18:18 +0000
Message-ID: <MN2PR12MB4488FB8A53CA95D1C788FD5EF7519@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <6941f046-d9a6-7603-0338-e7831917a540@illwieckz.net>
 <MN2PR12MB448814C93AA0664284E1DA32F7EA0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <0ce2f491-ab60-8965-0292-4da44ebf7fc7@illwieckz.net>
 <488fd133-fcae-2fdb-5b7a-86131f97efdf@illwieckz.net>
 <MN2PR12MB4488D3F9625D8F48F9832502F7519@MN2PR12MB4488.namprd12.prod.outlook.com>
 <99519074-041f-df69-d09b-a4b71402dde0@illwieckz.net>
In-Reply-To: <99519074-041f-df69-d09b-a4b71402dde0@illwieckz.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-13T21:18:15Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=6ee4b5a0-c040-4890-9214-a2acb065b3e5;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: illwieckz.net; dkim=none (message not signed)
 header.d=none;illwieckz.net; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.11.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47b61046-d58d-47f1-41ad-08d91654a138
x-ms-traffictypediagnostic: MN2PR12MB4376:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4376070A50A1C1EE02C2CCF8F7519@MN2PR12MB4376.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t6z8CXrLrXdAnD+Px/q6fCrFTBK23kgJSpa5IQilc4nsY8TBvrGE4y+o8DrY//iNjGoHT/cNRzeEEBeZKD2Q44NNYTZlmM8VVbeCF5VBtDa0huMVPPJeLGvj297q+Fk8GrYbNN14SASlBCHMnLasLK8XkwrrfDrGE47ITcrU4YSBUI4Zra7bY0g+hGgKI2z/HNGCLZHSAEEvgsIvkfEOM1djGT331pQtk/k9AIjYkgQlFiA/qDr9JrlWrlfye/0HwYW/WdL3ygnzPHp21Q4Eym2sbGRqQQ5Y/T0e9PNA3jIfE1DXhmMUO4ngfLyxXM/6VDc0PsQcbR/loUMkPBbLPqRJN37xERvEkXET0lc1v+EJjT64Dwa3B0kxyaovOXJDSxJCaR9thbc3ik7VucbnK5ozk5O+D7myEthuSpBs6f1VhOwxkqPn5fdsldUU7SB8CCa3Oc9qDFUCPvpNVlR9BOPBOzY2UEpSYo7HKDJsVKJdUwXvGjJ7+h9XlHGFgmq1unCNmY0rITsQguparbVQYV1ShJOFM+TC3gIl98L9X03Pqnaq8ymMwqdh0dIzI+FKoKeWTY/qTRfPZRdQS/OmfcW2CWd3EW/ReDO3KNCZGCSQvlGnER4QMZGca5CHxia8LUf0pXfLbW2ArXUTQfejy6KiDBs6t26M9tWDPTkt7DPWPYaxjZqs6PhkOvS3f1JYNomS2GDE1EMH2A43srV5wJL3tctKglpGr1Pxm3/5Amk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(55016002)(66446008)(64756008)(66556008)(8676002)(86362001)(66946007)(45080400002)(66476007)(52536014)(38100700002)(966005)(478600001)(9686003)(76116006)(33656002)(71200400001)(5660300002)(26005)(2906002)(316002)(53546011)(66574015)(83380400001)(186003)(110136005)(7696005)(6506007)(122000001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?XwmPVB+l67Wi5qityY2fRsqjk8ckM9fOTHBFvOwTrQ8n6SlMki8lqF4R?=
 =?Windows-1252?Q?fMhvokViESM3h/1nxQudZ2Qev7dk337h5j2y4z96Zu1Y/E49HJmQ7tjg?=
 =?Windows-1252?Q?DE2Qd2xTKndNz+Zdhbjn1Lhlz1BfwabR4XflzBlQjel+K0E4cQYhMoSA?=
 =?Windows-1252?Q?+YXKXk+L69dl73rachEd17JOsU91qFy7oqwVGZA99xi7ZHfbrNEoWHr2?=
 =?Windows-1252?Q?oPOodkjuFa4O7t+3xNaX6L1YMYRkg/4CIRLRuTs3TEYyc0Fbb5pThzmH?=
 =?Windows-1252?Q?/bLELl+rq4lc/hKp3Vvla5jnZ+HMeJYwiWIsbcF2Mk/LOEP673YQVFOi?=
 =?Windows-1252?Q?f/S62lGf7lI9JaFLAAl5SV74yog5mqP73lntvJGJQI2HWT0wO2b5fzl0?=
 =?Windows-1252?Q?6hIQ0etQC1xbg+EuONtQoFQgvFqAx4MgRFie7q+tfrRSGN6ZhaDy++bs?=
 =?Windows-1252?Q?OB/BZLHftGaGEzLXwbleJ8MkZnlb4E77YY8zp1m7yMaeY99t2qVOp5En?=
 =?Windows-1252?Q?/6yLWq4FGuPTjJjTM/4OkUxYQG7rXLyudozZe+ClJQ+1mogxrzgr553w?=
 =?Windows-1252?Q?ZsmDZMlPVdCmDjEs02BQnIpqKRYQA7kHT3rqBqfFEZg9pphSvMocQVPM?=
 =?Windows-1252?Q?RWO9gONwAtJwVCZX+e3Ac13qPfw5pesEbpVFhNc3xAZkPdqqzo+3Shq2?=
 =?Windows-1252?Q?X6nrj0/SeAt+leXK+e7hROI1AoIRpLnFR25/s3x42QZL6Ot9dhpzHtI0?=
 =?Windows-1252?Q?hPUmj0+NzuYIE2zf20T5qmKmperSpTBhfOTJ+gKz/VeVYL0wpthrBX0x?=
 =?Windows-1252?Q?S7Q+iXefzn3kGL1t2OY5mYomgisW7A9OTzpv8qIxjBBB6057XT9YDEkc?=
 =?Windows-1252?Q?EHHOn6HaQuzTLjM8z5KVW8OVrA1DQTBY+7Tn57K12+H8XGau+5FfmvIc?=
 =?Windows-1252?Q?GKd7D4iWu9fi18zIb82d4usPG0ImSHZZoZ7DpR6FOYsKtQ5JAvAmR0en?=
 =?Windows-1252?Q?sHH6q3Dj/X0EJB3BzPhaf0/YfmfwZ5ifSIH+KOnfmBvtXTAubs4XpVSf?=
 =?Windows-1252?Q?OxP/MMYZ53eRXMAhaKttVce1ycnTck02tNwzOUhfkbw2S4irdukLdn9B?=
 =?Windows-1252?Q?AVfHid5bIU5kUVq6RxyxNd6Hx5Vow4gAmDwJgFxY5e1QHP030CBcgIKa?=
 =?Windows-1252?Q?Ej6AcMR2CreFz8Tgfh8dU6Ux4+LG4q5+4/9Dfb70iKte0rZ53S9/hd+S?=
 =?Windows-1252?Q?8SelzdKclGgndus4RTx41t9R1iSJMXS3rQPultSvFpTBubiZvOMF73w/?=
 =?Windows-1252?Q?NuFhbJCyttBCHbdbEZZeSipAGClcmJrRvW+BdUQX+b5X0MZb5ZIfqadM?=
 =?Windows-1252?Q?TsA9LykTezq/ZiiRrg9mjqijc517OoNZTzh0h1+6iQYEiy1Ki07XF4cU?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b61046-d58d-47f1-41ad-08d91654a138
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 21:18:18.5118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EmlnpPTcstK0EfnD1S0tWUvmgfcjgN0Doofo3br2Ma/+K+brgaowjI58CWN3uAEFkhJLck0jfEwc3fqykMdNqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Public Use]

> -----Original Message-----
> From: Thomas =93illwieckz=93 Debesse <dev@illwieckz.net>
> Sent: Thursday, May 13, 2021 4:46 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; LKML <linux-kernel@vger.kernel.org>
> Subject: Re: On disabling AGP without working alternative (PCI and PCIe a=
re
> also affected)
>=20
> Le 13/05/2021 =E0 21:02, Deucher, Alexander a =E9crit=A0:
> > [AMD Public Use]
> >
> > I don't think I have a functional AGP system anymore, but I do have PCI=
e
> capable systems and they work fine.
> > Does this patch[1], help by any chance?  The change to add support for
> > root ports with addressing limitations seemed to break a lot of old sys=
tems,
> but never really got resolved.  If not, your best bet is probably to try =
and
> bisect if something broke your system(s).
> >
> > Alex
> >
> > [1] -
> >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fww
> w.
> > spinics.net%2Flists%2Famd-
> gfx%2Fmsg52961.html&amp;data=3D04%7C01%7CAlexa
> >
> nder.Deucher%40amd.com%7Cec9ae4ac2229473707a708d916502bf7%7C3dd
> 8961fe4
> >
> 884e608e11a82d994e183d%7C0%7C0%7C637565356504234517%7CUnknown
> %7CTWFpbG
> >
> Zsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> Mn0%
> >
> 3D%7C3000&amp;sdata=3DPcvPmesLXI26VqPct8hdPxQzxC%2BqY4wFtbTYvwjw
> 6eM%3D&a
> > mp;reserved=3D0
>=20
> The more modern PCIe systems seems to not be affected when running
> PCIe cards. I would not be surprised if modern PCIe hosts rely on feature=
s
> that were supported in the past and then, the old features are not really
> tested.
>=20
> For example while reading the Linux code in October I noticed the code wa=
s
> referencing different mask lenght, what if only the implementation for th=
e
> newer length works or something like that?
>=20
> But well, the patch you linked is touching the exact code that made me
> wondering about it:
>=20
> ```
> 	dma_bits =3D 40;
> 	if (rdev->flags & RADEON_IS_AGP)
> 		dma_bits =3D 32;
> 	if ((rdev->flags & RADEON_IS_PCI) &&
> 	    (rdev->family <=3D CHIP_RS740))
> 		dma_bits =3D 32;
> ```
>=20
> If I'm right this code sets this value to 40 by default, then sets it to
> 32 if GPU is AGP or if GPU is PCI and identifier is smaller or equal to R=
S740.
>=20
> I see no RADEON_IS_PCIE so I assume both PCIe and AGP cards running with
> radeon.agpmode -1 with identifiers greater than RS740 are probably keepin=
g
> this value as 40.
>=20
> It's interesting to notice the PCI HD 4350 (RV710) will use 40 bits, give=
n it is
> after RS740 in drivers/gpu/drm/radeon/radeon_family.h
>=20
> If an AGP card is running with radeon.agpmode =3D -1, how is it reported,
> RADEON_IS_AGP or RADEON_IS_PCI?

It depends on the asic.  See radeon_agp_disable(), but it doesn't really ma=
tter.  The driver doesn't really care, it's all PCI at the end of the day.
The only thing the driver really cares about is whether it will be using th=
e AGP remapper in the chipset for accessing system memory, or whether it wi=
ll be
using its own built in remapper on the GPU itself.

>=20
> If RADEON_IS_PCI, the AGP Radeon HD4670 (RV730) will use 40 bits, given i=
t
> is after RS740 in drivers/gpu/drm/radeon/radeon_family.h
>=20
> I had some memories of having tried to force everything to 32 in that par=
t of
> the code, but then, I still got problems but different ones.

The bits here refer to the addressing capabilities of the device.  How many=
 address bits can they handle for DMA.  It's baked into the hardware.  Devi=
ce drivers
report the address limits of the device to the kernel so that DMA API will =
give them memory within the range of addresses they can access.

>=20
> From
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flkml.
> org%2Flkml%2F2020%2F11%2F9%2F1054&amp;data=3D04%7C01%7CAlexander.
> Deucher%40amd.com%7Cec9ae4ac2229473707a708d916502bf7%7C3dd8961f
> e4884e608e11a82d994e183d%7C0%7C0%7C637565356504234517%7CUnknow
> n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> WwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DBUZ8dBLzzltv0N2RTSwdz%2BlT5
> cQgopYgdropej2FINE%3D&amp;reserved=3D0:
>=20
> > ## drm/radeon: make all PCI GPUs use 32 bits DMA bit mask
> >
> >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flkml
> >
> .org%2Flkml%2F2020%2F11%2F5%2F307&amp;data=3D04%7C01%7CAlexander.
> Deucher
> >
> %40amd.com%7Cec9ae4ac2229473707a708d916502bf7%7C3dd8961fe4884e6
> 08e11a8
> >
> 2d994e183d%7C0%7C0%7C637565356504234517%7CUnknown%7CTWFpbGZs
> b3d8eyJWIj
> >
> oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3
> 000&am
> >
> p;sdata=3D1ihVkGgLeFq9IXWzXMMxQHGFhllG5RvgPQ%2BOkZY6dq8%3D&amp
> ;reserved=3D
> > 0
> >
> > This one is not enough to fix PCI GPUs but it is enough to prevent to
> > fail r600_ring_test on ATI PCI devices. Note that Nvidia PCI GPUs
> > can't be fixed by this, and this uncovers other bug with AGP GPUs when
> > AGP is disabled at build time. Also, this patch may makes PCI GPUs
> > working on a non-optimal way on platform that accepts them with 40-bit
> > DMA bit mask (like Intel-based computers that already work without any
> > patch).
>=20
> So I was wondering if there was a similar issue elsewhere in the code.

Note that platforms can also impose limitations on DMA even if a device may=
 be more capable.  That is what Christoph's patch attempted to address.
The patch you proposed above more or less a partial revert of the same patc=
h I referenced in my last reply. =20

Alex

>=20
> I see the patch at
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fww
> w.spinics.net%2Flists%2Famd-
> gfx%2Fmsg52961.html&amp;data=3D04%7C01%7CAlexander.Deucher%40amd.
> com%7Cec9ae4ac2229473707a708d916502bf7%7C3dd8961fe4884e608e11a82
> d994e183d%7C0%7C0%7C637565356504234517%7CUnknown%7CTWFpbGZsb
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%7C3000&amp;sdata=3DPcvPmesLXI26VqPct8hdPxQzxC%2BqY4wFtbTYvwj
> w6eM%3D&amp;reserved=3D0
> is also setting in that code another variable I haven't touched:
> rdev->need_dma32
>=20
> I'll try to set both dma_bits to 32 and rdev->need_dma32 unconditionally =
and
> see if I notice a difference with this or that GPU.
>=20
> Note that the issue with the PCI HD 4350 (RV710) does not need an AGP hos=
t
> to be tested, only an AMD host (reproduced from K8 to Piledriver), but
> unfortunately now the PCI variant of this card seems to be very hard to f=
ind
> (I doubt the PCIe one is affected).
>=20
> Thank you for your answer and you attention!
>=20
> --
> Thomas =93illwieckz=94 Debesse
> I wish to be personally CC'ed the answers/comments posted to the list in
> response to my posting.
