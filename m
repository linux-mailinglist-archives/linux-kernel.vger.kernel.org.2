Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA00C428849
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 10:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbhJKIFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 04:05:54 -0400
Received: from mail-mw2nam10on2042.outbound.protection.outlook.com ([40.107.94.42]:25440
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234645AbhJKIFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 04:05:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFZkXrFX04W2l74A/xB8SRcTchQ2ONrT3btI35q8SxmX/Q+b80WFU3fUuNj9srvA8srCztqiknx+lE0Qp9W5KsZPNmVXp9Ix5LVFewPLQMWlDy5XSOaB/Qkee9l/jmSnUsZoCJirByPd4XZ5+YgqPNkCV9RkjyyYUuJaVrmzsiE5MWcAkohM5eDBGa/fwfNnz9BKXw9SQ+zUdQrfVkLRZcRIuu1yayC5QXifVEXY3Ccbf2zAx0bBoq92l4l1nc1vEn5ANMx0Qqajwq1Hkf/n0FruIrgq7Lc47iE4hDdeow6clnKFamr6gF9hdJn+C9rChDlahrHQnqg3F/AdjI/vUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGaPghD+B+RLvrJfs5neJDtX07wqzlRIbsHxpIaQZRc=;
 b=kRmK0UcACjhGjsed8U/EIcd3rCA0dh1i+K4+0Op+hpPlDSZ4WCNWibskclLWLFpaBVhelC46NWHGOQ58FpC4r/T3c1YRidn9cnjXhF6eLtkguHvFnaQTIrkh2U0MRCeDKeHNM0BaTZmLoit22v5Gpl0md5mi+ePSysrvOlGHf06Ctgd1A6bWJohouBemr3RRy3srCzjphQ5sWJ0KPIE0Se4zd/G8j/O5BPZBII1F1XtELKZghuLiPGGrd+IxfyHwWPC0hl8V/frcxCQsut7xMDp1NG+FVBKiOM5zNUQo1vlz6WPchNzRuHggzYcYCh126lNlmbpW5K/PtSnRfl6Rzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGaPghD+B+RLvrJfs5neJDtX07wqzlRIbsHxpIaQZRc=;
 b=3CRQWhp3QOvuEAwH44FgCikSbb4AA3LNtexMpDi3JV+C8ro2nNeNu17g7JC3GO1Z1qOL8wUp916wg66kIPWkZqAeer9FlpODHekPrwnax8I3faNowAQ5r12zfirjAUemiH4EFDJTfQd1Dcl67x/L5i1Ix6HokwnmsB2ZZltoosg=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2617.namprd12.prod.outlook.com (2603:10b6:5:4a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18; Mon, 11 Oct 2021 08:03:51 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5%6]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 08:03:51 +0000
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
Thread-Index: AQHXu6U/ZEe6vPjmAkGizCNrJ1mPBavJLxGAgAAFT4CAAAIugIAABoCAgACjCrCAAIEAAIAADb7AgAAExgCAAv/N0A==
Date:   Mon, 11 Oct 2021 08:03:51 +0000
Message-ID: <DM6PR12MB26193B59E0C5971F458E17C9E4B59@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <YV81vidWQLWvATMM@zn.tnic>
 <CADnq5_NjiRM9sF6iAE3=KbzuSVc1MeLe0nUCdJfEpNQ=RDz4Zw@mail.gmail.com>
 <YWBeD7fd2sYSSTyc@zn.tnic>
 <CADnq5_MeEP-PbDp+Js3zEsuj=CvxDAD2qcFSskWhW4b4SkhwEQ@mail.gmail.com>
 <YWBlVzZK35ecQHNZ@zn.tnic>
 <DM6PR12MB2619FD47CD826ADC91F87AFBE4B39@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YWFaUjKEp+5819O/@zn.tnic>
 <DM6PR12MB26195857D2FA0946C9833F19E4B39@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YWFp2qHwbWHEqxWh@zn.tnic>
In-Reply-To: <YWFp2qHwbWHEqxWh@zn.tnic>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-11T08:03:45Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=13c0190c-7d7b-4129-81d6-717a4be4df88;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce6cd6b3-4725-4dc7-42fa-08d98c8da9b1
x-ms-traffictypediagnostic: DM6PR12MB2617:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2617E06C6488512E0E162576E4B59@DM6PR12MB2617.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LcfPKVNGGVZvNiOoPMcfpbLeCsnOp4h/7Bs/UP5J3wndgYbHS2vQRojVm41MW2mEWYG9hoHD1PtjPhAvrZ27TWwuP5R/wfOwri3i3XsLkRC9j3uqdJ/Hb6wzcgEcGEzMFlKd50imGa4AE8eAYPwz/zgWKz/hts9gCudZu9sCbEhaa3Ys9nga7iQ8erDBLhCtrHI00r5lXL7jTTyAI55R3DeuUBav5RGcQORABiXP9Qr5Z8sDZIM2Q5EP8G91BC32adZ8y1lf+V0ORjFxSvcd3GzNXy1dCQpzKxkoHDx3RQqTumqgUzrNUKph7qVc/NkJGpriizRe0yRSo3fZq5Dzuhy1X7DDdIwiddonV2XszxOyLsKbF7qlrBRPCCUrvV9Wl3PGiDmqIAr3fCTozFKhwOjj2kjwNsNMHfvAlZrKUUHwv2EPz5oG/4KOY1j6K6xk8/7vbrZGzGxezOm8NjeHyQI7raz5W5CLyaHiEotIaPgAX+eHmeXiy0oCtl59X2+sU15LxaEkRWFkMbhgcZGX8+dwK0spyvOzHfYLGX7FuHbnQAl1K66sl0gjEFzOTTaZzU38r+lStzu7lfuNaryMWXzqD2pgsKfub415EVrq+FvBqL7SD27X8hqJspPxN7jH/td+tmbjWamE9fBFO0KUzAv/J+2elPanB0Uw7zWullHgLsKPLOPEo5Fp1Mcp6xD03gUCC0VFRYpqwrzTe+/OIEWBQmcB4pisnKb9F6cnEV/MAalWwnK0cw5YJTjsTFqmiyr2tVb8Yh9EMovtnamH63RoMA24eKSMATxSZq4Z+CMRq0sJ8PbBqxlRUXFFlTysEn1UOCE1E21+zvc9wEYi9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2619.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(5660300002)(52536014)(99936003)(54906003)(45080400002)(9686003)(6506007)(66946007)(966005)(4326008)(66476007)(55016002)(64756008)(38070700005)(66446008)(66556008)(76116006)(53546011)(186003)(26005)(8936002)(8676002)(316002)(7696005)(122000001)(38100700002)(33656002)(2906002)(15650500001)(86362001)(6916009)(71200400001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u4RZ8EBdZbSujgA0s2p2oQJqNKKhrQo+Qv5aCaMzE+Fvya/4OP0cSrOx45CO?=
 =?us-ascii?Q?rlFR0q8ps0yB0NuEakPh4Ph50pbEm2HUOcO5orRXynGH28knAf+B925EzsGK?=
 =?us-ascii?Q?Guw4oMoUphsflDIstmlw+PwXvqJBq6NeCkmnfm6GL89kxDnJ3SrsgyWPcsPG?=
 =?us-ascii?Q?HIIHjK8d0UOrfA5wDw755iMRvWbNeQ2oRmpGz+dMU2xfJWmIBZWSb6MgOaS1?=
 =?us-ascii?Q?zrR1WPa5Xtt1z/bCgmEOpG+KDwpjvN0fp90eukVocr9dxgs8VPArGixq7+O2?=
 =?us-ascii?Q?MkPU+vuDs58iZLbdumJlM8n8f0IY6Z6c2/qNljZ8X+GxxAIF7IeI7lwhGCKT?=
 =?us-ascii?Q?9LH8vbtLNGj5CHwW1pq1OITF14//kHkvSbz6W2AcXpjYmZJYztFfmVljL7oR?=
 =?us-ascii?Q?noSC/BKrNG8egCzM5iyZXD/ZtHp4cEFTILhjRKWCh3s/oTwCkQDTrImbhB4U?=
 =?us-ascii?Q?R7W6yOXoMrWpipEL7iMxnn5RshxvCoNzUHaIAn7rZE0Ug+w0IHH3LO4smNH/?=
 =?us-ascii?Q?4t/UJg4fSCX2CpLQ730KJrGNhG9uZiAdpeI2U/7YLnR0yCqXAgJLu/NEnRVm?=
 =?us-ascii?Q?457TVZuPGVMOlkf/J5+8LTOVjTWLkPIzItWbwOUmITCDLbhOQ3ppLfyWxERj?=
 =?us-ascii?Q?tDW68J4o238VdfOeHBU62ZJhpjeAsTjQhLRM7jT5ZrcGesZ/oa8SC4PFcfQ0?=
 =?us-ascii?Q?YVEu2BWIYPr/oJXolXdHVP1gwbGeV1uTGAHV/BZ6aNjEviJvMIZF4LYvlntS?=
 =?us-ascii?Q?yCisvm4G75N8REeKz2EesdcelzjcneNrFYqrdla7dsHFo3n6QQ6Qlb5/GW7R?=
 =?us-ascii?Q?LF/wE4N0sh0gci8KzLQFyn7Bt4F7MjSO/duchVVEJc26KLHrXv68Tbl1mxMZ?=
 =?us-ascii?Q?VU/Mh1uM8KTLMFcCJ1Drq5gJTdYaZAGboZ4xPbfSTmS2qId6Wgg+5fJLYM0o?=
 =?us-ascii?Q?dUN5XMuT3Z/VsFU2gMmQUIIOXk8exgg1N7ikNtvhXAgptlnVbvawdpZiKfIo?=
 =?us-ascii?Q?aQ5aAVsrhOEkYRq6TBx6pPy6942k/eVzNw1F6b1TTc4CBZobrRBF3o14zFSu?=
 =?us-ascii?Q?imN/3FxuwmCjg5h3aK9syxW+p26JAqCNc7QVSc2GkBZ4ZsYHeCUVScJJjaHF?=
 =?us-ascii?Q?EGNBZIDW8Nwy/jFdgpCMm27egV4V47BXpmRVmbdR3Q2gPtmq/YZneETdPGr4?=
 =?us-ascii?Q?iAYqp7mh1hgTR5lVeSjID9WTJx+yNWGcQLsqTm6EApjsGE7CWWTt3hLjLK+X?=
 =?us-ascii?Q?rCVaIrEiVRMYeURpLYAD3Zl1JrFlpA1P/UldLELxygNu1FfgKuLzQQ4n7Jij?=
 =?us-ascii?Q?ug2ViCt9bIm4ndy3KHYyl9Ek?=
Content-Type: multipart/mixed;
        boundary="_003_DM6PR12MB26193B59E0C5971F458E17C9E4B59DM6PR12MB2619namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6cd6b3-4725-4dc7-42fa-08d98c8da9b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2021 08:03:51.3470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PLp0stGjOJIzzlGhuIsNOwWRbaHP6ADqkBuhqYIaThkEouOTgQWjfrNbOnHX7K0f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2617
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_003_DM6PR12MB26193B59E0C5971F458E17C9E4B59DM6PR12MB2619namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

OK... Then forget about previous patches. Let's try to narrow down the issu=
e first.
Please try the attached patch1 first. If it works, please undo the changes =
of patch1 and try patch2 to narrow down further.

BR
Evan
> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Saturday, October 9, 2021 6:07 PM
> To: Quan, Evan <Evan.Quan@amd.com>
> Cc: Alex Deucher <alexdeucher@gmail.com>; amd-gfx list <amd-
> gfx@lists.freedesktop.org>; LKML <linux-kernel@vger.kernel.org>; Deucher,
> Alexander <Alexander.Deucher@amd.com>; Pan, Xinhui
> <Xinhui.Pan@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
> Subject: Re: bf756fb833cb ("drm/amdgpu: add missing cleanups for Polaris1=
2
> UVD/VCE on suspend")
>=20
> On Sat, Oct 09, 2021 at 09:54:13AM +0000, Quan, Evan wrote:
> > Oops, I just found some necessary changes are missing from the patch of
> the link below.
> >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.
> freedesktop.org%2Farchives%2Famd-gfx%2F2021-
> September%2F069006.html&amp;data=3D04%7C01%7CEvan.Quan%40amd.co
> m%7Ce528679b6b6e4da74ec408d98b0c98df%7C3dd8961fe4884e608e11a82d
> 994e183d%7C0%7C0%7C637693708504533267%7CUnknown%7CTWFpbGZsb3
> d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%7C1000&amp;sdata=3DHAmBuuX%2BvMex3Rxw%2FZrV8d21ygSMS3xrW
> HWeTMzLObg%3D&amp;reserved=3D0
> >
> > Could you try the patch from the link above + the attached patch?
>=20
> Nope, still no joy. ;-\
>=20
> --
> Regards/Gruss,
>     Boris.
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeo
> ple.kernel.org%2Ftglx%2Fnotes-about-
> netiquette&amp;data=3D04%7C01%7CEvan.Quan%40amd.com%7Ce528679b6b
> 6e4da74ec408d98b0c98df%7C3dd8961fe4884e608e11a82d994e183d%7C0%7
> C0%7C637693708504543261%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w
> LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&am
> p;sdata=3DQVTW41SGsMuwq0qeZ9LtQs%2BQ2zw6gxhW5Ttt1iM%2Fu0M%3D
> &amp;reserved=3D0

--_003_DM6PR12MB26193B59E0C5971F458E17C9E4B59DM6PR12MB2619namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-no-UVD-VCE-dpm-disablment-on-suspend-for-.patch"
Content-Description:
 0001-drm-amdgpu-no-UVD-VCE-dpm-disablment-on-suspend-for-.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-no-UVD-VCE-dpm-disablment-on-suspend-for-.patch";
	size=1839; creation-date="Mon, 11 Oct 2021 07:54:07 GMT";
	modification-date="Mon, 11 Oct 2021 07:54:07 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5ZGI3NzAyNzRhYjJlNzQwZDE2M2VlM2FiM2I5MzFmMmNiOWM5YTBlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgpEYXRlOiBN
b24sIDExIE9jdCAyMDIxIDE1OjQ4OjM1ICswODAwClN1YmplY3Q6IFtQQVRDSCAxLzJdIGRybS9h
bWRncHU6IG5vIFVWRC9WQ0UgZHBtIGRpc2FibG1lbnQgb24gc3VzcGVuZCBmb3IKIENhcnJpem8K
CkRlYnVnIHVzZSBwdXJwb3NlIGZvciByZWJvb3QgZmFpbHVyZSBvbiBDYXJyaXpvIHBsYXRmb3Jt
LgoKU2lnbmVkLW9mZi1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KQ2hhbmdlLUlk
OiBJYzNjMDgzODc5MTdjZWQ4MzY1MDUxZDJhNTIzNWRmNWQ2MzczZjQ4YwotLS0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92Nl8wLmMgfCAyICsrCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS92Y2VfdjNfMC5jIHwgMiArKwogMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjZfMC5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y2XzAuYwppbmRleCBkNWQwMjNhMjQyNjku
LjUzZGY5MjhlMGU4ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZk
X3Y2XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjZfMC5jCkBAIC01
NDcsNiArNTQ3LDcgQEAgc3RhdGljIGludCB1dmRfdjZfMF9od19maW5pKHZvaWQgKmhhbmRsZSkK
IAkgKi8KIAljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmFkZXYtPnV2ZC5pZGxlX3dvcmspOwog
CisjaWYgMAogCWlmIChhZGV2LT5wbS5kcG1fZW5hYmxlZCkgewogCQlhbWRncHVfZHBtX2VuYWJs
ZV91dmQoYWRldiwgZmFsc2UpOwogCX0gZWxzZSB7CkBAIC01NTcsNiArNTU4LDcgQEAgc3RhdGlj
IGludCB1dmRfdjZfMF9od19maW5pKHZvaWQgKmhhbmRsZSkKIAkJYW1kZ3B1X2RldmljZV9pcF9z
ZXRfY2xvY2tnYXRpbmdfc3RhdGUoYWRldiwgQU1EX0lQX0JMT0NLX1RZUEVfVVZELAogCQkJCQkJ
ICAgICAgIEFNRF9DR19TVEFURV9HQVRFKTsKIAl9CisjZW5kaWYKIAogCWlmIChSUkVHMzIobW1V
VkRfU1RBVFVTKSAhPSAwKQogCQl1dmRfdjZfMF9zdG9wKGFkZXYpOwpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNlX3YzXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3ZjZV92M18wLmMKaW5kZXggMTQyZTI5MTk4M2I0Li4wY2YzOGM0OTQ3YmEgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZjZV92M18wLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvdmNlX3YzXzAuYwpAQCAtNTIwLDYgKzUyMCw3IEBAIHN0YXRp
YyBpbnQgdmNlX3YzXzBfc3VzcGVuZCh2b2lkICpoYW5kbGUpCiAJICovCiAJY2FuY2VsX2RlbGF5
ZWRfd29ya19zeW5jKCZhZGV2LT52Y2UuaWRsZV93b3JrKTsKIAorI2lmIDAKIAlpZiAoYWRldi0+
cG0uZHBtX2VuYWJsZWQpIHsKIAkJYW1kZ3B1X2RwbV9lbmFibGVfdmNlKGFkZXYsIGZhbHNlKTsK
IAl9IGVsc2UgewpAQCAtNTI5LDYgKzUzMCw3IEBAIHN0YXRpYyBpbnQgdmNlX3YzXzBfc3VzcGVu
ZCh2b2lkICpoYW5kbGUpCiAJCWFtZGdwdV9kZXZpY2VfaXBfc2V0X2Nsb2NrZ2F0aW5nX3N0YXRl
KGFkZXYsIEFNRF9JUF9CTE9DS19UWVBFX1ZDRSwKIAkJCQkJCSAgICAgICBBTURfQ0dfU1RBVEVf
R0FURSk7CiAJfQorI2VuZGlmCiAKIAlyID0gdmNlX3YzXzBfaHdfZmluaShhZGV2KTsKIAlpZiAo
cikKLS0gCjIuMjkuMAoK

--_003_DM6PR12MB26193B59E0C5971F458E17C9E4B59DM6PR12MB2619namp_
Content-Type: application/octet-stream;
	name="0002-drm-amd-pm-no-UVD-VCE-power-off-during-early-phase-o.patch"
Content-Description:
 0002-drm-amd-pm-no-UVD-VCE-power-off-during-early-phase-o.patch
Content-Disposition: attachment;
	filename="0002-drm-amd-pm-no-UVD-VCE-power-off-during-early-phase-o.patch";
	size=1496; creation-date="Mon, 11 Oct 2021 07:54:07 GMT";
	modification-date="Mon, 11 Oct 2021 07:54:07 GMT"
Content-Transfer-Encoding: base64

RnJvbSAzYWIzNzM3ZjExZDc4MmI3NTBkOWEzMTk4MGY5MzNhMzZlMTE0M2IzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgpEYXRlOiBN
b24sIDExIE9jdCAyMDIxIDE1OjUyOjEyICswODAwClN1YmplY3Q6IFtQQVRDSCAyLzJdIGRybS9h
bWQvcG06IG5vIFVWRC9WQ0UgcG93ZXIgb2ZmIGR1cmluZyBlYXJseSBwaGFzZSBvZgogc3VzcGVu
ZGluZyBvbiBDYXJyaXpvCgpEZWJ1ZyBwdXJwb3NlIG9ubHkgZm9yIHJlYm9vdCBmYWlsdXJlIG9u
IENhcnJpem8uCgpTaWduZWQtb2ZmLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgpD
aGFuZ2UtSWQ6IEk2NTQ1Y2JlM2ZlOTk4MjhlMDU1NDMwZmNlZjY5YmQyOWQyZjg2MDkyCi0tLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3Ivc211OF9od21nci5jIHwgNCAr
Ky0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3NtdThfaHdt
Z3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3NtdThfaHdtZ3Iu
YwppbmRleCBiOTRhNzdlNGU3MTQuLjljYTZmZmFiYjdlYyAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3Ivc211OF9od21nci5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3NtdThfaHdtZ3IuYwpAQCAtMTk2NCw3ICsx
OTY0LDcgQEAgc3RhdGljIHZvaWQgc211OF9kcG1fcG93ZXJnYXRlX3V2ZChzdHJ1Y3QgcHBfaHdt
Z3IgKmh3bWdyLCBib29sIGJnYXRlKQogCQkJCQkJQU1EX0lQX0JMT0NLX1RZUEVfVVZELAogCQkJ
CQkJQU1EX0NHX1NUQVRFX0dBVEUpOwogCQlzbXU4X2RwbV91cGRhdGVfdXZkX2RwbShod21nciwg
dHJ1ZSk7Ci0JCXNtdThfZHBtX3Bvd2VyZG93bl91dmQoaHdtZ3IpOworCQkvL3NtdThfZHBtX3Bv
d2VyZG93bl91dmQoaHdtZ3IpOwogCX0gZWxzZSB7CiAJCXNtdThfZHBtX3Bvd2VydXBfdXZkKGh3
bWdyKTsKIAkJYW1kZ3B1X2RldmljZV9pcF9zZXRfY2xvY2tnYXRpbmdfc3RhdGUoaHdtZ3ItPmFk
ZXYsCkBAIC0xOTkwLDcgKzE5OTAsNyBAQCBzdGF0aWMgdm9pZCBzbXU4X2RwbV9wb3dlcmdhdGVf
dmNlKHN0cnVjdCBwcF9od21nciAqaHdtZ3IsIGJvb2wgYmdhdGUpCiAJCQkJCUFNRF9JUF9CTE9D
S19UWVBFX1ZDRSwKIAkJCQkJQU1EX0NHX1NUQVRFX0dBVEUpOwogCQlzbXU4X2VuYWJsZV9kaXNh
YmxlX3ZjZV9kcG0oaHdtZ3IsIGZhbHNlKTsKLQkJc211OF9kcG1fcG93ZXJkb3duX3ZjZShod21n
cik7CisJCS8vc211OF9kcG1fcG93ZXJkb3duX3ZjZShod21ncik7CiAJCWRhdGEtPnZjZV9wb3dl
cl9nYXRlZCA9IHRydWU7CiAJfSBlbHNlIHsKIAkJc211OF9kcG1fcG93ZXJ1cF92Y2UoaHdtZ3Ip
OwotLSAKMi4yOS4wCgo=

--_003_DM6PR12MB26193B59E0C5971F458E17C9E4B59DM6PR12MB2619namp_--
