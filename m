Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9811C42ED8A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 11:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237297AbhJOJ1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 05:27:08 -0400
Received: from mail-bn1nam07on2056.outbound.protection.outlook.com ([40.107.212.56]:59367
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236767AbhJOJ1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 05:27:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYcehGnPqQc6vBqjgRfMJgmV1fsn4clPHBkoHkrJel3gZjkvMHpNziR/xhd2ZlzbThBsXi61geqifJWQyfekbeVes9qgw3ynXy8t79UvYPMuGL7w4lH2ywisd0FOE802TJaQtaGq4CVNUc1MfGig2+5nSnTRtYhNKJ/p0Ze295ko2qGr251TMxrUNWF4IcGQITQ3t0um2VPxu6R8oqtjNSbEAB5PImQxOXXVoIxEo4tcmE8FWrRCmVcoVK4OXZOnKyXPllDeWWvQkfez7qg4udnlv1h0GM68SKqMI3wnvF6fTheReUZvJdkmEhhfAu5ayeXFg6rPYVf97TUKOMT23w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZgZXsT96Yaa41/c7zjsAeidZDAoCVx4u3PQHFMrFzg=;
 b=IO1EvNVYaqQffOw7gi/K1HsJDyuXkoRb2Hn3Jgy8ecNNp8OBeeR4OvV2aOXUP4vY5Z7IC3vYtNKvLzZvTBjav2xApvNZVEXC8VrmaERqx0sbULHokXeHJBn8k6vJt8vEfnfSzRkVOyqNwGfcO+yhgJm6LQPl/Hdf4QVz22TW7YqCSLca6xErhhZScW/0GUjAjzV6JEf1YVs8RCYqPp6a24QZ3bEct9lyhdnmFXnft8MiXG4v83qsv2mqQ4XY+RTpwv/cpzBmfYmKlsP9HpWMVDFVOhZzNO8qnZnY7kuMmu8yhqSxsX5O6ihen6Ag+qYVatuOhg+zoZUN67cVissFZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZgZXsT96Yaa41/c7zjsAeidZDAoCVx4u3PQHFMrFzg=;
 b=JTIHLTiaT8V/LkkoW2MHZTPrP/m6LZFlUtdPX9d0E60pYWhZBv7fekEwVTnJTgTqJslkh/BQEOWWbNF3V6FOIMxCEjyQSpisLoK9NJB0NjGOacIUdXsCDqaW6kUJZvbMPGew9u2BsPGj8LlW30C0FU/mP2uLkH2qfWXUtbsbKvw=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16; Fri, 15 Oct 2021 09:24:56 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 09:24:56 +0000
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
Thread-Index: AQHXu6U/ZEe6vPjmAkGizCNrJ1mPBavJLxGAgAAFT4CAAAIugIAABoCAgACjCrCAAIEAAIAADb7AgAAExgCAAv/N0IAAmpGAgAKexJCAAASygIABFY9AgAB1n4CAAZf1QA==
Date:   Fri, 15 Oct 2021 09:24:56 +0000
Message-ID: <DM6PR12MB26197151C642B89A9C824AA0E4B99@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <YWBlVzZK35ecQHNZ@zn.tnic>
 <DM6PR12MB2619FD47CD826ADC91F87AFBE4B39@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YWFaUjKEp+5819O/@zn.tnic>
 <DM6PR12MB26195857D2FA0946C9833F19E4B39@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YWFp2qHwbWHEqxWh@zn.tnic>
 <DM6PR12MB26193B59E0C5971F458E17C9E4B59@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YWRvl6ymevr7+kiB@zn.tnic>
 <BYAPR12MB26152EF8CD43290EBE40C165E4B79@BYAPR12MB2615.namprd12.prod.outlook.com>
 <YWamNaMAxaw+/9Az@zn.tnic>
 <DM6PR12MB26199D9E4AD854A4DCF562B4E4B89@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YWfxtUusQ5w/1agx@zn.tnic>
In-Reply-To: <YWfxtUusQ5w/1agx@zn.tnic>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-15T09:24:54Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=11c4db7d-33ed-4051-b6f3-c9d3b6979e70;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5f61659-b18a-4e0e-ce7c-08d98fbda743
x-ms-traffictypediagnostic: DM5PR12MB2504:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB25045CF283371D5FC71D1447E4B99@DM5PR12MB2504.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wju3ncOBUjg8Wh7+ninQYAnxQ1Crzr+t5n4PGRVEEkgRp/G45x6FsVoFScS7yVtKcdUPEo19rAa9whIsyvknlXkfHErXGsA8SWVmnrQpmpri3sX6ZRyffRTcj15B9Gb+rB0/vWobzOv6X4NNnbMccF1aEPuuwIcQPeOEqqHmaWRKxeB3NNruYrWASJUZ7E+8AxdoPaWBu8pB8Mg8tZgPvK9tS1oyVdJNFVTc1zYfbdj/2UNGvr+b9IU3NE2aWjNY4Numo7Ru9hZUOqRlZe4BMlDtKm0sXSRAsxhCjzZaknd1mi3ZW40704pILx9KnBQ5GnXtkMkUfGWeWkEzkvVwp14pogsMK1Y7mdmP+R2yJosaBZBZ+FMV7iFMnon4q+mBFMliHK0t6PoddL5d1fkl6Ntvs3cbapboyFdGY1imlhlMs9t26z6KkDNU6eaL0WAP2oGn30Mh8oGadgiZUnQwAlAn1KvTQdE3+K9AzpMstxvT+Xw6NJjHrrhaYY3V+VvNZshBPpYUYMO/Fv7Pwy3Y01q7nOhKkH/pzYywLNTgjDNRtjRj5SnLweV0jbvgUm8WaZjrLecxZy8GA4x9F7WEvqMPqXVvWzeoawZhkjDKYoKCCJd0TMiOn9eZe7yTzMj9Qzt0PYTXx6EAWYfUBzhmA5HxsJQaDS53VFZGCVMBjjYylzXbk7nd6m7N3PT7h/eaJAFJ4ITGVd8u5w+5DhLHzRGvmsNCvnRJFZi8Yo5uK+GA4FPKLul97BbpOapMwpudRirdktHTmngrz7srOjjqvLnDZTiPChWKFa07ux8+UGI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2619.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(7696005)(186003)(33656002)(6506007)(53546011)(9686003)(55016002)(86362001)(26005)(122000001)(38100700002)(83380400001)(2906002)(38070700005)(8936002)(66946007)(8676002)(66446008)(64756008)(66556008)(66476007)(54906003)(316002)(71200400001)(45080400002)(508600001)(52536014)(4326008)(76116006)(966005)(15650500001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kWPtamG12HpiUOJ3LmBo8B36dXXzx5mKQyiFpOiG8kZRNRstzm6d0oSNHiE+?=
 =?us-ascii?Q?B+taUJf8rfOIJ8+sY5DvtLgraqLRmG3UkMsrJ40MEo+WZ2J2+1mVupQswiH9?=
 =?us-ascii?Q?hSEI/zeJi6tGHyAuNRvoYrLR37drdSCJCSnmoeZXC/ZeDv39Og2fJGEE2sQU?=
 =?us-ascii?Q?jvCJORmrYWhVRRnU94ECok/y+5AM8kY54HykpGdwxIMTloJY0j2RegXdjJUW?=
 =?us-ascii?Q?3mwR7JyHmtXfPzl+IKfbM5QtoJbJMpwNk/t7bcF9eSr+lYZmzijl3BEbDZGk?=
 =?us-ascii?Q?zDoGVjFVvtKnHIF939vagF6gpRBnCV4uS0p7LYGi60EhGkurUaaeo1sVYtHP?=
 =?us-ascii?Q?xvuXIcwcYS4SXyzxKyooDv2uZMbAUG2hDLnnZNrCTRKQnHTuN9sk3VtIdB6o?=
 =?us-ascii?Q?lfy0stA+O26IiwlOXa2wav5yOX1WO+lSMltuX2XEHw+GJ6zy65uebiqAHgMt?=
 =?us-ascii?Q?wjViSMlHaioA+CUd4yNTgMJ2vrCUF6z2QlIUu7WdCsirDwfS33q/QF2tKg5t?=
 =?us-ascii?Q?VmQOtzi0m0zKSA08ILmyiKpjkuPSmXo57k3cefVuSZVuYb+HP6Ct832FmKzv?=
 =?us-ascii?Q?ytH5hEvm0JUT8wKWFcH/ZjM/inypCJoE7tv0cp2xsxWiOeX+pPWYlU/Gr4rr?=
 =?us-ascii?Q?bRy+eY5VyKbwpKHDy5J4bcaqUkIXJDP7DLeNk8QZfoQj2GznrxNKGYDsk0mb?=
 =?us-ascii?Q?XQ1TzeZ5Zrw9HsenBlgyNdKlLsMEd0xyqIbZiWdZ1jcO3PHmwuz3oGp70oaN?=
 =?us-ascii?Q?7eOWbqB0Ti+qoRxdUlrVxib/1wObeC5pagO8BleNWqyzT7r+apLNPyuDMiL3?=
 =?us-ascii?Q?cGBBiVnf7VZZ11j+xr6DgoR6o5Z59STHbZBr+PrbLI6UertadmcM3Z6rIwoF?=
 =?us-ascii?Q?b8Gj0sz8LlUrEukVU/TXFO9QZLq4FtP9DgP87ryfkr54Wxx4mHDgHtn6tnw4?=
 =?us-ascii?Q?HQCDqSI/njqSaZLttache45J5B6Ty+Q4BSbMK33wo0Et4Xvpc8lec688LvQ6?=
 =?us-ascii?Q?dbFhpgq3Ngy9yP3dQyO2geDPbr6Cni+k8iGyrL2BA5lTVrWzM3QsDfR8XAkm?=
 =?us-ascii?Q?dkJGcR2OPCj9ClPEDjp8LSmobJ0IAXbdOdz9wxFU4ECL5nG0UraYvvp6Cf+H?=
 =?us-ascii?Q?Q5cCmnCuFAyJu2F7NMCoxgtoTCXPdROiMFYcdHQguG2LHL+TEh1CIx2Eg8WV?=
 =?us-ascii?Q?+u+vFTqZmqY48hVIFOztrQA2earIxZULonh1iLkVicOfmR6Q5YVmPcMZj2ua?=
 =?us-ascii?Q?K6YvtxIEYDsVfxy1/SlT/QpmJhTMVogopoP9b2+p0+v1z1WJngAUEOYgpuhQ?=
 =?us-ascii?Q?lhPP/B9s99UE2NkjQ1dEs5pm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f61659-b18a-4e0e-ce7c-08d98fbda743
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2021 09:24:56.6586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sYT+2fEdNqDkeJ+zd8guGTO3QfikrnyqWjObIbOjzqqAwgHjg7a6fhksyXXnA+1E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2504
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only]



> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Thursday, October 14, 2021 5:01 PM
> To: Quan, Evan <Evan.Quan@amd.com>
> Cc: Alex Deucher <alexdeucher@gmail.com>; amd-gfx list <amd-
> gfx@lists.freedesktop.org>; LKML <linux-kernel@vger.kernel.org>; Deucher,
> Alexander <Alexander.Deucher@amd.com>; Pan, Xinhui
> <Xinhui.Pan@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
> Subject: Re: bf756fb833cb ("drm/amdgpu: add missing cleanups for Polaris1=
2
> UVD/VCE on suspend")
>=20
> On Thu, Oct 14, 2021 at 02:02:48AM +0000, Quan, Evan wrote:
> > [Quan, Evan] Yes, but not(apply them) at the same time. One by one as
> you did before.
> > - try the patch1 first
>=20
> Ok, first patch worked fine.
>=20
> > - undo the changes of patch1 and try patch2
>=20
> Did that, worked fine too except after the first resume cycle, the video =
didn't
> continue playing.
>=20
> Then I restarted the video and did a couple more suspend cycles to see if=
 it
> would not continue again. In the subsequent tries it would resume fine an=
d
> the video would continue playing too.
>=20
> So I'm going to chalk that single case of halted video with the second pa=
tch to
> a resume glitch or so.
>=20
> Btw, I don't have pm-suspend on that box but I did suspend to RAM
> assuming this is what you wanted, which is done as root with two
> commands:
>=20
> # echo "suspend" > /sys/power/disk
> # echo "mem" > /sys/power/state
[Quan, Evan] Yes, that also works.
>=20
> If you want me to do more extensive testing, just shoot.
[Quan, Evan] Thanks! That's enough for now. I will prepare an official solu=
tion for the issue.

BR
Evan
>=20
> HTH.
>=20
> --
> Regards/Gruss,
>     Boris.
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeo
> ple.kernel.org%2Ftglx%2Fnotes-about-
> netiquette&amp;data=3D04%7C01%7CEvan.Quan%40amd.com%7C08df3d5453
> d64ad40dfa08d98ef119ec%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C
> 0%7C637697988457790715%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;
> sdata=3DzmFVlmUBv6byoDYyUhSgk9J9Zmvexz5IqG7xBxwiR3M%3D&amp;rese
> rved=3D0
