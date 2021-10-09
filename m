Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00E442789B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 11:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244353AbhJIJ4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 05:56:14 -0400
Received: from mail-dm6nam12on2072.outbound.protection.outlook.com ([40.107.243.72]:22464
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232373AbhJIJ4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 05:56:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btost4aDDJO3IRE2i92rzaeWJryVsN66zl59vKFq2u+QFqrPoIVhbgeXViowCv41DgIr+akykVlLsfA7pvVIBskJHuDMdQHTdPu1lty445s8XfWKCC1HjonDNU4NLENGfIRGmvMrRZF9iRyp0/kJfFlgQF7HbT9M/itrKGTBAfDVwXia/vIsyJKpw2uxv8Udx6VmHADm6VccHsb0Ls4O6AgddcRh39kyFsIru9tUNEBbCO2ZzWDgHYlT71ST6I4esasDuWmsj/Du8SY0rXI5Njv7qi98VJIrGg4IXw9Ho9aHn55xeapGIIcGjKopBDzBu5NNkGsDglkh6liUOHRg/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obsup4F7k2J0Bi/FXsUp/lZaHsaBx3TOjUNMEM3TE+s=;
 b=Uftb+uFhnqivs7DTLUuEcoqBtDyRw2+/C3rpWOhITVUg+IWU0eZE+oqo1929vjXGhSa6yNGlIcmOhcF5CVU/o9278w0XRNZsF+ebDg7JGtiXgc8/A3O6t4fBrVxFyUanqleCsc6pIdFPIli0KkvXt3zOiXki1xdC4v5ol5uJPBFyJZIjaUxK4K5kL2o1Q6oIO8ffENUskSETroA8xV/WFyurgpRsW7yM6JFEKCB0QtsK8S6t2OtK5Z7TPydulrBRBitXqZt4HfP2o8WxvlWwN4JYAgd4wq7q9cTnkaDxe3KePTMYBjQrgIQkHBI3sRAaMW3w4nglMwrABy7ETBlHVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obsup4F7k2J0Bi/FXsUp/lZaHsaBx3TOjUNMEM3TE+s=;
 b=p5ta2jT81k19CEiyeIlXCWYZphdv6hyagAc9SJc0tvaxZXT8sHS7ZSXbQ0ONAYCu07cnaIy2Y1M/+diiKWnEn1UAeznGhPi9N/4m3NbhtmyzqQHEoNBf2jWOjjiGoG0O5itJjhVu/+0KSG9bpk4lBQxRrdiO68uvM3dv3m2ZbE0=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (20.176.117.82) by
 DM5PR12MB4679.namprd12.prod.outlook.com (52.132.130.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.17; Sat, 9 Oct 2021 09:54:13 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5%6]) with mapi id 15.20.4566.026; Sat, 9 Oct 2021
 09:54:13 +0000
From:   "Quan, Evan" <Evan.Quan@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Alex Deucher <alexdeucher@gmail.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "Chen, Guchun" <Guchun.Chen@amd.com>
Subject: RE: bf756fb833cb ("drm/amdgpu: add missing cleanups for Polaris12
 UVD/VCE on suspend")
Thread-Topic: bf756fb833cb ("drm/amdgpu: add missing cleanups for Polaris12
 UVD/VCE on suspend")
Thread-Index: AQHXu6U/ZEe6vPjmAkGizCNrJ1mPBavJLxGAgAAFT4CAAAIugIAABoCAgACjCrCAAIEAAIAADb7A
Date:   Sat, 9 Oct 2021 09:54:13 +0000
Message-ID: <DM6PR12MB26195857D2FA0946C9833F19E4B39@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <YV81vidWQLWvATMM@zn.tnic>
 <CADnq5_NjiRM9sF6iAE3=KbzuSVc1MeLe0nUCdJfEpNQ=RDz4Zw@mail.gmail.com>
 <YWBeD7fd2sYSSTyc@zn.tnic>
 <CADnq5_MeEP-PbDp+Js3zEsuj=CvxDAD2qcFSskWhW4b4SkhwEQ@mail.gmail.com>
 <YWBlVzZK35ecQHNZ@zn.tnic>
 <DM6PR12MB2619FD47CD826ADC91F87AFBE4B39@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YWFaUjKEp+5819O/@zn.tnic>
In-Reply-To: <YWFaUjKEp+5819O/@zn.tnic>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-09T09:54:10Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=da5b6e1f-d620-4ab7-8d84-2e3341ffc5c0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 050a5b51-4256-49ad-3249-08d98b0ac01b
x-ms-traffictypediagnostic: DM5PR12MB4679:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB46790DCE06934C8B43EC9912E4B39@DM5PR12MB4679.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nAUjlD+cmMfl4jVF+byLE9dQyCUdcWX/GUUmWN5Ay65IA1By6D7BEF3Fip0QP9J4htS1jvfbtfWy5EPfAUul+HEvfN0mUCEjoAo2rMwrua3jjC6JbCFdAa2USmKwsuxyWumIIUBpD944lK9qTke2Ww4DXMpDDBgKc7n/UB/+YKIS7vJYwxl0aAaXgl7ejUTmvEZ63DXUgS1XOYgmxGvUNG84NNB9K1k/+rkM5BE/jxAOtbCV/3A3v2jlyWGgKYILc1HDaiXb8PtRI/rNOaddxcUG9AOQnOd8rY5ZPXuIbOHm14uvicvXaSSKNYq/nMmF4kP5lyfkxRxDDsmbpp7cTH+Rt/LwHhQUAzn6PYA6arUrV+KUVb+xUSIRZMBxG7FQvnrbM6rEFm8b+DcO4d0NuAtrn6MSlgJelJ9WMK/Zbyz8fn166MaO103QbDOi4l0z65ZgOYQIyij+u+wD+3WflOaq1kufQqujNrlg0rGqgsaiuuTkWOoQUqfl/kshS4lWzRI49kzNrVVFz9AuQsXiAQ3Zp8tKOj9XUtbIA1ZYnyCzr7Vjqtk672tH7eAI/ShFuz8ELJnHUN/VIGCKLFw0Dwd+gOH8C0LWKWWWCpTilPpbUI4GIQ+StadiwK9Db8m6Qqc+34LlQg1jtz3lAwLNdeiIvYZJ5D4QFPBUAgjb4dsQRzmBdzXW3uBJv3tvPSzxDu5Ce3ZA6XYWJOSYI6kbaKJuaOHT/aGGyEy0djFkrMc55Z4AhdgYUOLMxdycDt//Ozg56SW/VcoeaBC2Yfw4oFTijuG18MMruuAYoGSDF4wJty2wTVVUJtphA8uaAFLL700Ymtixf6TLEl8fTnVH5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2619.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(6506007)(6916009)(86362001)(99936003)(9686003)(15650500001)(71200400001)(7696005)(83380400001)(33656002)(54906003)(316002)(53546011)(66556008)(4326008)(508600001)(5660300002)(966005)(2906002)(38100700002)(55016002)(8936002)(45080400002)(66946007)(122000001)(38070700005)(8676002)(52536014)(26005)(66446008)(64756008)(66476007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DWLgpx6QMtUmzBIyrhhBP1c4Fj62SiK+6NkENIuVc4o3x1dM0U8Yd/NNL7pl?=
 =?us-ascii?Q?0+YEO/i4IYomSIexFfgRLXM60SwpxKfeXSm+daeaBdGM9vKWd8kWxOKQSL4f?=
 =?us-ascii?Q?401IxqCqASnvlyKP7jeRxPMLa5hMOZ29u3nXJhhuLmssHdJy7Al2cTHIHdau?=
 =?us-ascii?Q?6g754F7yH5hQ6Y7LJVY6EGYhf7mzBe2bkd1TEZ4bTbY9KAX+4J3Tnxsib49Z?=
 =?us-ascii?Q?tkkRiGGspZJWM3bm3r1J5PRKAvGVvKdGQn0Ch95mK8GXoo1ghuFuO7pBCBkl?=
 =?us-ascii?Q?DFawwr+/LU2Q0CVmRVdBPfbHdoIme98o+tZq8fkFP4OjPW1b19wbnOzb0uEV?=
 =?us-ascii?Q?9k6I4aQ4VyQ0bMK1bxI8FJegNhxS4ed3hBCiZlz50+bCds8hNy+4oSG/TNdG?=
 =?us-ascii?Q?r502AcZ03ZKhFqLRoCV5ekG8wkgbBtQ4EMAKxAA4ovyuGMRwZbv9WxTZVWY6?=
 =?us-ascii?Q?aBoHw+YYi3729hn/WWIYvclso8gZIy17cga5PAL86d5sLDXnlN+RgOoFrrni?=
 =?us-ascii?Q?agEkfNSuXWv0wBE/r0obMhj49qSuM135puOuoGPuS27UTockAffzE10co3bR?=
 =?us-ascii?Q?WykxFaWcQ6PckUma1AdhmzDt9aO5C+k+l3nmtJHkoz4/A8Ow/wxfRM7AKYmU?=
 =?us-ascii?Q?jgQDh7HB2Ys/PEHc68sro5fe3g7gXL3BEiWoxlNuCrds2nD+GtVvrq4ClViu?=
 =?us-ascii?Q?2aH5wAeabQ/ozadD51wne3HlMB8EJ8W7JA1Okae4UTuHOLORJ6s31ok3V/Ub?=
 =?us-ascii?Q?98V3D6NRZRVOry+x8gx6XdHuiEReaYDNNo/KUUleEU3Cp18Qoy2qje8DScLI?=
 =?us-ascii?Q?bLmM+/OfwvLUbv+lH7nz3xysyuprwY11J2rNwCG1SEG6sBdTK+ydA04rZr6n?=
 =?us-ascii?Q?slmRWFvO+VAcIRC2BMgp0UXq65Atr+Oz17M/DrjOLUrWVxPMWDD2CQEK/alW?=
 =?us-ascii?Q?mkLdIblZuZiF3ljXCgDhMe+X7X/JWA9lMIBxEP6Pcjd5yQ7IzuWY009c+RCR?=
 =?us-ascii?Q?ULmqM4J4M3D+oQ1sK7YuuFeEZ9tbBnnSbnAP3RhiqcWb87lSLVw27fm8J+72?=
 =?us-ascii?Q?Y5oXMU0x7Jww9i1r12mdbyy0NUk+xUzRZtuqDL97nJg42PR0iCm/VmxQhnDk?=
 =?us-ascii?Q?7rPHKu0UnXZCLXg/tRA9GQqZAemDjaBreOTncwX1yLSqrkrg36QIKlZqWyt4?=
 =?us-ascii?Q?mhBheAgpmnvA4UmYRSyAGh3VO0cBydwObfAoeB5kDsn5ndg0Wd1C7OuuIDfN?=
 =?us-ascii?Q?PvCN2nP6gO7ZVb+cBZs0SjsbJ5D4NgBxNu4x7mDZYDLmnrG56mYK+hdNUq5h?=
 =?us-ascii?Q?tNcDBGSuscrAOoBXvaVCOiCE?=
Content-Type: multipart/mixed;
        boundary="_002_DM6PR12MB26195857D2FA0946C9833F19E4B39DM6PR12MB2619namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 050a5b51-4256-49ad-3249-08d98b0ac01b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2021 09:54:13.6018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HpsP3AnnZ0SvBEBszm9gQWvs/ajNgRkbQ7AjltNNeEGPLTtGZb8WA2G1Ymdjc3gg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4679
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_DM6PR12MB26195857D2FA0946C9833F19E4B39DM6PR12MB2619namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Oops, I just found some necessary changes are missing from the patch of the=
 link below.
https://lists.freedesktop.org/archives/amd-gfx/2021-September/069006.html

Could you try the patch from the link above + the attached patch?

BR
Evan
> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Saturday, October 9, 2021 5:01 PM
> To: Quan, Evan <Evan.Quan@amd.com>
> Cc: Alex Deucher <alexdeucher@gmail.com>; amd-gfx list <amd-
> gfx@lists.freedesktop.org>; LKML <linux-kernel@vger.kernel.org>; Deucher,
> Alexander <Alexander.Deucher@amd.com>; Pan, Xinhui
> <Xinhui.Pan@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
> Subject: Re: bf756fb833cb ("drm/amdgpu: add missing cleanups for Polaris1=
2
> UVD/VCE on suspend")
>=20
> On Sat, Oct 09, 2021 at 01:20:39AM +0000, Quan, Evan wrote:
> > Maybe the change below can address your issue.
> >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.
> freedesktop.org%2Farchives%2Famd-gfx%2F2021-
> September%2F069006.html&amp;data=3D04%7C01%7CEvan.Quan%40amd.co
> m%7Cd06cae38046c476c6cf808d98b0357c6%7C3dd8961fe4884e608e11a82d9
> 94e183d%7C0%7C0%7C637693668756530302%7CUnknown%7CTWFpbGZsb3d
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> 3D%7C1000&amp;sdata=3D5PR5eUKLrK1FONfNwgXNTw7WNgcu%2F13HOmOc
> oOsEkTI%3D&amp;reserved=3D0
>=20
> Nope, that one doesn't change anything.
>=20
> Thx.
>=20
> --
> Regards/Gruss,
>     Boris.
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeo
> ple.kernel.org%2Ftglx%2Fnotes-about-
> netiquette&amp;data=3D04%7C01%7CEvan.Quan%40amd.com%7Cd06cae3804
> 6c476c6cf808d98b0357c6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C
> 0%7C637693668756530302%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;
> sdata=3DdOzz4cZC0VyM92jwofZ4K0MN4i%2FM%2B9F%2F3vCUj%2Bd%2Bwdw
> %3D&amp;reserved=3D0

--_002_DM6PR12MB26195857D2FA0946C9833F19E4B39DM6PR12MB2619namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-fix-Carrizo-uvd-crash-on-driver-unload.patch"
Content-Description:
 0001-drm-amdgpu-fix-Carrizo-uvd-crash-on-driver-unload.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-fix-Carrizo-uvd-crash-on-driver-unload.patch";
	size=1601; creation-date="Sat, 09 Oct 2021 09:49:47 GMT";
	modification-date="Sat, 09 Oct 2021 09:49:47 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4NjE5NWE5OTdjMzllYTUwYTQzMjBiYmU5YTMwZDJmMGFmNmYwNTNhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgpEYXRlOiBT
YXQsIDkgT2N0IDIwMjEgMTc6MzU6MzYgKzA4MDAKU3ViamVjdDogW1BBVENIXSBkcm0vYW1kZ3B1
OiBmaXggQ2Fycml6byB1dmQgY3Jhc2ggb24gZHJpdmVyIHVubG9hZAoKVGhpcyBpcyBhIHN1cHBs
ZW1lbnQgZm9yIHRoZSBjaGFuZ2UgYmVsb3c6CmNkY2NmMWZmZTFhMyBkcm0vYW1kZ3B1OiBGaXgg
Y3Jhc2ggb24gZGV2aWNlIHJlbW92ZS9kcml2ZXIgdW5sb2FkCgpTaWduZWQtb2ZmLWJ5OiBFdmFu
IFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgpDaGFuZ2UtSWQ6IEllZGMyNWUyZjU3MmYwNDc3MjUx
MWQ1Njc4MWIwMWI0ODFlMjJmZDAwCi0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZk
X3Y2XzAuYyB8IDI0ICsrKysrKysrKysrKystLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEz
IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3V2ZF92Nl8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91
dmRfdjZfMC5jCmluZGV4IGQ1ZDAyM2EyNDI2OS4uMmQ1NThjMmY0MTdkIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjZfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3V2ZF92Nl8wLmMKQEAgLTUzNCw2ICs1MzQsMTkgQEAgc3RhdGljIGludCB1
dmRfdjZfMF9od19maW5pKHZvaWQgKmhhbmRsZSkKIHsKIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqKWhhbmRsZTsKIAorCWNhbmNlbF9kZWxheWVk
X3dvcmtfc3luYygmYWRldi0+dXZkLmlkbGVfd29yayk7CisKKwlpZiAoUlJFRzMyKG1tVVZEX1NU
QVRVUykgIT0gMCkKKwkJdXZkX3Y2XzBfc3RvcChhZGV2KTsKKworCXJldHVybiAwOworfQorCitz
dGF0aWMgaW50IHV2ZF92Nl8wX3N1c3BlbmQodm9pZCAqaGFuZGxlKQoreworCWludCByOworCXN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopaGFuZGxl
OworCiAJLyoKIAkgKiBQcm9wZXIgY2xlYW51cHMgYmVmb3JlIGhhbHRpbmcgdGhlIEhXIGVuZ2lu
ZToKIAkgKiAgIC0gY2FuY2VsIHRoZSBkZWxheWVkIGlkbGUgd29yawpAQCAtNTU4LDE3ICs1NzEs
NiBAQCBzdGF0aWMgaW50IHV2ZF92Nl8wX2h3X2Zpbmkodm9pZCAqaGFuZGxlKQogCQkJCQkJICAg
ICAgIEFNRF9DR19TVEFURV9HQVRFKTsKIAl9CiAKLQlpZiAoUlJFRzMyKG1tVVZEX1NUQVRVUykg
IT0gMCkKLQkJdXZkX3Y2XzBfc3RvcChhZGV2KTsKLQotCXJldHVybiAwOwotfQotCi1zdGF0aWMg
aW50IHV2ZF92Nl8wX3N1c3BlbmQodm9pZCAqaGFuZGxlKQotewotCWludCByOwotCXN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopaGFuZGxlOwotCiAJ
ciA9IHV2ZF92Nl8wX2h3X2ZpbmkoYWRldik7CiAJaWYgKHIpCiAJCXJldHVybiByOwotLSAKMi4y
OS4wCgo=

--_002_DM6PR12MB26195857D2FA0946C9833F19E4B39DM6PR12MB2619namp_--
