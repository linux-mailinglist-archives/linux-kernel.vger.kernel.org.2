Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2EFC42BB61
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 11:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239073AbhJMJVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 05:21:51 -0400
Received: from mail-mw2nam10on2071.outbound.protection.outlook.com ([40.107.94.71]:1761
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230045AbhJMJVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 05:21:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jk3pDPNWUs3vheN7WiUjYBPCkCpu7mcjkcpveFQAQmEV7jaY6UpmD+7Cw6cTIkcASfLNVGdZgl9UiAokQfaJ+O57Ln83gnCJyElAroTpdHe2gArnaEAw9wmvSj7gJeOUzj6AE3BaBh9vATuA0O1pk8/61pcm6rkOkhOKNhvp4igPtwn2UE53ShpXPglM74NviOahBrQaCo9DurMACg0bCyq/94sF+lo5POZ4cMEh/rvBUcG7S8Y63H4WBIcaPEUAkKYzouyE5PxNgsJL6YPxTlUQFDmU7kpLBtqOC2Zto5JXN9V+P0RVyqO2E4KwocAMXWOcSAgJHrfYkvTHNFsCOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rrBJJLmyrhVtqFQWLu4ggFPnKzu5Rypz+YMS324PBI=;
 b=hMuTanYk/nRjlhPK9Iw6kb7Z31xe0QT0BOjsdncmjXQ/c2zKq03Dqm1MlER4IcMJJe1trv5bkRn8rdcLw4X981mYnL7pRUaHvM3jq6Rxe8ZX28qF5thj+pZ7HGcmxuDu6LB0djo0rZB/ivD6szZFz5Yrkhxm2PQFvPFHWVB78zUMqDPR0dtUYhnuqd0qgnRJBMG2puQEng0hXbBkEfxAKEBwmfpgLwZUNAimbXgpvkEVqZCswbyLxoPdvNuE9UqNEoeRYEj9efJhj4Gxsx6Tcg2mGUukG9FIpJdDpXBntxPhqqVWOfD4MXpkj50cM3XucGSVgDaLo4qDtU3uu8ScMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rrBJJLmyrhVtqFQWLu4ggFPnKzu5Rypz+YMS324PBI=;
 b=jkP3FCOg8TfK34a6g9E1aFfsj0RPbIoGTBvWqv9qaIX8toR8hNgJMpaOV9VtHv4Pc3beoF68SO4ryL/DVwLomvGnVhtSUgugmC/Olre1nrHZpCOO4lpLB9FvfywW+0nn+ZNb334ctaki1q6AGfdDnxkmv/NcdsKu6LgshKqRFZk=
Received: from BYAPR12MB2615.namprd12.prod.outlook.com (2603:10b6:a03:61::29)
 by BYAPR12MB3542.namprd12.prod.outlook.com (2603:10b6:a03:135::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Wed, 13 Oct
 2021 09:19:45 +0000
Received: from BYAPR12MB2615.namprd12.prod.outlook.com
 ([fe80::2d0e:85ce:8d1d:3b89]) by BYAPR12MB2615.namprd12.prod.outlook.com
 ([fe80::2d0e:85ce:8d1d:3b89%7]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 09:19:45 +0000
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
Thread-Index: AQHXu6U/ZEe6vPjmAkGizCNrJ1mPBavJLxGAgAAFT4CAAAIugIAABoCAgACjCrCAAIEAAIAADb7AgAAExgCAAv/N0IAAmpGAgAKexJA=
Date:   Wed, 13 Oct 2021 09:19:45 +0000
Message-ID: <BYAPR12MB26152EF8CD43290EBE40C165E4B79@BYAPR12MB2615.namprd12.prod.outlook.com>
References: <YV81vidWQLWvATMM@zn.tnic>
 <CADnq5_NjiRM9sF6iAE3=KbzuSVc1MeLe0nUCdJfEpNQ=RDz4Zw@mail.gmail.com>
 <YWBeD7fd2sYSSTyc@zn.tnic>
 <CADnq5_MeEP-PbDp+Js3zEsuj=CvxDAD2qcFSskWhW4b4SkhwEQ@mail.gmail.com>
 <YWBlVzZK35ecQHNZ@zn.tnic>
 <DM6PR12MB2619FD47CD826ADC91F87AFBE4B39@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YWFaUjKEp+5819O/@zn.tnic>
 <DM6PR12MB26195857D2FA0946C9833F19E4B39@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YWFp2qHwbWHEqxWh@zn.tnic>
 <DM6PR12MB26193B59E0C5971F458E17C9E4B59@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YWRvl6ymevr7+kiB@zn.tnic>
In-Reply-To: <YWRvl6ymevr7+kiB@zn.tnic>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-13T09:19:41Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=5121ce3e-8260-4c09-898a-ad46979ba6d0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5789a57-764c-4161-96ee-08d98e2a98d6
x-ms-traffictypediagnostic: BYAPR12MB3542:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3542B933B7F34E3E8B936CA2E4B79@BYAPR12MB3542.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 21iDusZH56sDICAYEhq1plYxb0y27y4YupCOYsvZCVKK4WDLSltlo/6RIdsjWcaU0BNTsk5erRNdj5Or+YZIsBDVk8WKW5VkOWeAGAN/QFdif1V8B1mcAkFLzDQO+ZdFP1tynBZzAdPxi8j7KttFbB3crI4TSz4IIogIPfHolqBWgdIHeacSLv1guZbFX5hQwBx/DXJSpP9w9YarGb3nCJOVVL6nOSbXbgJ5ry3J+Awu5fa8Ec8HPrOyW01ttFMQhruVzRUV4Egym1BsUE+dSTcznLvWy95XOT48Uusfrvo+b+F5G263zgN40VxZ9mYKozSpq4dDOiGO0dPRAPzQChNWxr8a+CW1ANQ+YPYHJ49LcJvCK85tMod3pKjVt5mFT7lPLuWBlFKXG0Rj59uWAaAq1IJBxQUo4+bhOlNztTYSGYwF37m/B0/13VRewZEmN5CbqrLrxXjF7+LwFpYy3xjYheYU0W+qYNAaR+TYFJ+NMMfMpuWzQuZEhrH39vgEV/LfZMXFTTHZxvgbhQRp4HpE1xYMSMnmLKhD3YQpNWSE0skInnTnqbSL7eTvRoZvTIl/7ZZGlkCoP6Y/dzGYKNOLOuIEZuj5JAM/j2E0P6ZzzKnVP7JPUSGpVTV6b9bzMdXFL0gAxeMJvwq4TIvKTjwOv30UDPyruZCw29YsMXhcIy6iVf/QSVN7DkTu36BQqSXGnJprSCP2I1KbfUZcEAeZWck1sFqMxF+DrU5yQ/RONN3XL4gC3S7CWhM3c2TiWjV+P+k8a37JjYY+Bk1R8yTCCRiCzrdQ+LT+p0iL0Ks=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(84040400005)(38100700002)(15650500001)(7696005)(45080400002)(71200400001)(33656002)(55016002)(186003)(9686003)(508600001)(5660300002)(2906002)(54906003)(38070700005)(66556008)(966005)(66946007)(64756008)(76116006)(52536014)(122000001)(86362001)(6916009)(4326008)(66446008)(66476007)(83380400001)(8936002)(316002)(26005)(8676002)(53546011)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x20133aZaZpGQi5qTqao1H00oHsLihUXZHwzGktIrO2D+4L2LeTrAtPgumd0?=
 =?us-ascii?Q?n9x91TDgP5dKrQZKNWVe1v4IOeD4AICdWyQ6Mt0+uy+UIHyBlr/yDkXBEnXZ?=
 =?us-ascii?Q?gqdmgozQjKsalj7n71P+gR/pwMmAjhC+dGh7XNw/luDzSQDuDgjGLwTXJsiQ?=
 =?us-ascii?Q?1Ja2FT801MBBO1JEtrWeLqU1ut1+cKuLHwDcvtPogspMr/MhmmaRDeSzV9br?=
 =?us-ascii?Q?xDQpefJGuKvamU+EpdCh3WIn0B3wY3n/CVduUb4xg0QAU1wLOqMNv3SaVdT3?=
 =?us-ascii?Q?Vc9xkzmfe7PjDHJbVIOqeTOv71pPxz4uGGDYRwRNypNkFgl15wadNaQbNRho?=
 =?us-ascii?Q?utN3OIdJvrntLndt9HP1H9WzRoAUtzR4vrdUxoFNjT5cPzE8DlgF+3/rhcgo?=
 =?us-ascii?Q?bctPkMzA5WnMhhqgfJS0c207b/kpGnobgYT0TZJaoKwV5LvQewoAHSqocIXr?=
 =?us-ascii?Q?xsdD8WCFsgem9wnTJqZ28THopbAYjxTagdh8S6ju4HcFOHQYorKkpUeIyUid?=
 =?us-ascii?Q?3OdLsBA1sm1SbYnxcMcRjTJ5EwAKObIIdpd5kbTKNSxU0Ht8uWNVqpi7YZCa?=
 =?us-ascii?Q?U8x4KIIwemOgsA4FBWF9k1YA17D3GdiNQIkurdaljOOcjaHMgWvkbFsKm4Qu?=
 =?us-ascii?Q?XLD8KujMCsZrEHZU+FzYGYL995ChVollPgoQWzxeafhsyJ16uMd+wGOP26ks?=
 =?us-ascii?Q?b06x1ReacU2gGYD4Q3DjNtgpkx/QfBFohATfAmWSb5S5QXQdh+tW17xuTcqJ?=
 =?us-ascii?Q?aBy5svq+nAxbGvb5l753CI8xYqHSPgWsd+nV6cC/BM71rf6M5dDW5keUkvhS?=
 =?us-ascii?Q?aa65CS2LTfcFPW7fqtcSHKn2tRSbPtTuSZ03OdQWq+PBr3ZHKT+gR3fRr3p6?=
 =?us-ascii?Q?alxdiKrJc92DcWXKe/mgeff13fomfvkAAlQvvOWG0DiOeJhfIYdLBaeJ13Na?=
 =?us-ascii?Q?uGAuL75b0+863mwd9A/O+whgTtLtHaxPYxCiSrq+REA3Y+sQWwYUXSHT9G16?=
 =?us-ascii?Q?xU2GseqdgV1eXuSnUj+ZCoq/VaiKRj+kdWLm3yHD1nv/UfmtUNz7eMm0r9ld?=
 =?us-ascii?Q?eBu9TUbtEQePDuENwjjzldcy6T7/NRaNOz6oUWQ0oMlHZpGwPYuhbiDv1svQ?=
 =?us-ascii?Q?Bd9W1Q64ujyWidiCo06V4xpmGZl5GYq3xYdcxCR0xtkbEHhcYRIN2LplWdsG?=
 =?us-ascii?Q?7bdUncF/wni5Fr3HJiQyqYZbvjLZw3BOcWKD3L3Pcz7E3npyATQObqh/kqt6?=
 =?us-ascii?Q?LMt8F5OHaJ9j9dgp01RCAszkODkr8xpjeW0oH8aMu/bCHVKWcGs8xkKMgZm1?=
 =?us-ascii?Q?JZIyABv7Im99tjHJuWdWDChM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5789a57-764c-4161-96ee-08d98e2a98d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 09:19:45.2167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V+ctyODqOxC0g8jenK7Jl10HLQfw79QsDbsQ+ZiDRKbuFLZWVlYZk0jbijk1ihSi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3542
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only]

Thanks Boris.
There is another thing which needs your help.
The change of bf756fb833cb was introduced to fix the bug below:
"some hangs observed on suspending when UVD/VCE still using".

So, I need your help to confirm the last two patches(I sent you) do not aff=
ect the fix for the bug above.
Please follow the steps below to verify it:
1. Launch a video playing
2. open another terminal and issue "sudo pm-suspend" command to force suspe=
nding
3. verify the system can suspend and resume back correctly without errors o=
r hangs

BR
Evan
> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Tuesday, October 12, 2021 1:09 AM
> To: Quan, Evan <Evan.Quan@amd.com>
> Cc: Alex Deucher <alexdeucher@gmail.com>; amd-gfx list <amd-
> gfx@lists.freedesktop.org>; LKML <linux-kernel@vger.kernel.org>; Deucher,
> Alexander <Alexander.Deucher@amd.com>; Pan, Xinhui
> <Xinhui.Pan@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
> Subject: Re: bf756fb833cb ("drm/amdgpu: add missing cleanups for Polaris1=
2
> UVD/VCE on suspend")
>=20
> On Mon, Oct 11, 2021 at 08:03:51AM +0000, Quan, Evan wrote:
> > OK... Then forget about previous patches. Let's try to narrow down the
> > issue first. Please try the attached patch1 first. If it works,
>=20
> It does.
>=20
> > please undo the changes of patch1 and try patch2 to narrow down further=
.
>=20
> It does too.
>=20
> :-)
>=20
> Thx.
>=20
> --
> Regards/Gruss,
>     Boris.
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeo
> ple.kernel.org%2Ftglx%2Fnotes-about-
> netiquette&amp;data=3D04%7C01%7CEvan.Quan%40amd.com%7C7d523770cb
> a84f8d23a108d98cd9c5c0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C
> 0%7C637695689245101874%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;
> sdata=3DTVYDHI74dYSJl68Z3ZjypBhr6jDYAIUgsMQcoreQrhk%3D&amp;reserve
> d=3D0
