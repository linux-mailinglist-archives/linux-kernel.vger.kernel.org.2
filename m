Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7EB42D02A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 04:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbhJNCEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 22:04:55 -0400
Received: from mail-co1nam11on2061.outbound.protection.outlook.com ([40.107.220.61]:21596
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229660AbhJNCEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 22:04:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLAazEM91IE/S2eoqBHXgwIT/wC+fJSYIaUWDeTOnVR4aTqxLofzc4rjcnr2AonUJcASNlXpg8By+CN8+96NaU32m/sqxzmye/WIrRvUbVL1qDZgb7O0jUQXobcgTWdqR11aF0+X13EVMLb9ebe5K8oDMFfgqMOg4joSUYhlf71xuVFhf6ZfhDbfUiryGepj6wnemB2f5aooMhpKVT3GExphKOEnTQ6fb5iRXkXRm9AtQP0vvOjPMBY+ULnBgQRGNR5mg/Y1wileYzxWIuXlJ9v4yug1RX3w39Mr6XKGahQ2hI7Q2NvDYuRBpxMGb3veWsqR59r0+bY0fcQAVbRicg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHuyrTMShwy+3L1wP5ZNz2+qdzB239OPx5HdYu9oXGY=;
 b=ExTc1rNjUNoOCHEVYsJt49stpQ7bPtjXsHACM/r8t1UrSVtD9Q2xGwF2LYU9rhnvb5lrPSO/n2l2z6512gkti0rsr8NfRKRCaXqJShfGiqhlf8NhrgNq/QgMY/DNeqT65V+cIHtsj83cyRz7QtXIdt4OwBVUFRxrcmOleMEk2sd2Rj6ZP24Ykx4SRmLNTMnVFTaQz9MpWedCatDX95b3PWu6K2iITweOAUNCwUe9VVLnhyRf1Jw6dswQVQ6IOH023tgZWgVFRr9TRsHQyKe9euZGDIHkoAH6QMpOpuPS2vg3TTev8KFWeQH3bP+usY/eOh1kc5Z38gGWxQBK1quO6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHuyrTMShwy+3L1wP5ZNz2+qdzB239OPx5HdYu9oXGY=;
 b=lIjk05NO8ad6FizIetZ64WqS3iko8d+o6kFfIA/j90hcWgO0hppXzn4/WTQfVkuYjzBXAWUM0AVSKcWFvkNGI4Xf0K0hMBoOXMBK/X7snmAS+sv86rsm8R67WYF3qkGQ/O4R73mB1zZ7Ja8l558jqhlvbbJ1U31eSfxc8+jZ+Go=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0217.namprd12.prod.outlook.com (2603:10b6:4:54::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.19; Thu, 14 Oct 2021 02:02:48 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5%6]) with mapi id 15.20.4608.016; Thu, 14 Oct 2021
 02:02:48 +0000
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
Thread-Index: AQHXu6U/ZEe6vPjmAkGizCNrJ1mPBavJLxGAgAAFT4CAAAIugIAABoCAgACjCrCAAIEAAIAADb7AgAAExgCAAv/N0IAAmpGAgAKexJCAAASygIABFY9A
Date:   Thu, 14 Oct 2021 02:02:48 +0000
Message-ID: <DM6PR12MB26199D9E4AD854A4DCF562B4E4B89@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <YWBeD7fd2sYSSTyc@zn.tnic>
 <CADnq5_MeEP-PbDp+Js3zEsuj=CvxDAD2qcFSskWhW4b4SkhwEQ@mail.gmail.com>
 <YWBlVzZK35ecQHNZ@zn.tnic>
 <DM6PR12MB2619FD47CD826ADC91F87AFBE4B39@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YWFaUjKEp+5819O/@zn.tnic>
 <DM6PR12MB26195857D2FA0946C9833F19E4B39@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YWFp2qHwbWHEqxWh@zn.tnic>
 <DM6PR12MB26193B59E0C5971F458E17C9E4B59@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YWRvl6ymevr7+kiB@zn.tnic>
 <BYAPR12MB26152EF8CD43290EBE40C165E4B79@BYAPR12MB2615.namprd12.prod.outlook.com>
 <YWamNaMAxaw+/9Az@zn.tnic>
In-Reply-To: <YWamNaMAxaw+/9Az@zn.tnic>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-14T02:02:46Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=4ef14b78-f75f-419e-b280-b69d5fa4c621;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ffbe10d-9f6d-4639-cb96-08d98eb6b8de
x-ms-traffictypediagnostic: DM5PR1201MB0217:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0217BF1D6E13A2482C08484EE4B89@DM5PR1201MB0217.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hvrNDnuxRPVnnE0j6GxEBij+6LobNC7vvrdry3dRI16/NkIeqMfjc2xtdiyxnSSJoW0sdn/xBnxX4+ZDLHE4HUSSxpTvhUMDEShIUbIpB+ddre4bsWRdd2m7UgjWI2k1Y5p9GnPKaCNKjwmlKQ6VC2YZIjGiakY49W318z16bSWcRBQWj+NMUfhVmpAPl30nHRmB/CLUbS3UHmJKd3BAVXMWaSDs1YZILIg7C4UxHb3zLbYi6jJiTDvTP2aH1WyuhLvqlQIiwyGivCp/log9VOeX3bXH+MD/3XhsBKLIMnyx4vb9CX5/RLqCYjvI6/2XI9XOsUzimsn0uCHFQwTdCpFzL3uIAbKgdPPIA+vs5wzzbMzlypKzuh8FdFw33GvkXOnHokFutyqV2TXnYASHdF949zF98vyZrQoAW5eQSl/78mK2jWH9wxIt9gJi1Sfub6p3JHFFcF71bFOpisgSJyo+c4sgOvUmOQe/F46tTGTnPMa1zUCYLuNUkQ47QHOhlVCufDlBy6sKU5ndfYNrwb00SF2MJk5cJlP1c5Me7yCszaUWf81xkV9vhWBweTVi61v2TBs7fT42dHfj5rbrN6az78r+QtmKfkB6zyYj4M4nR4KpNNnbBD4O6ifKIW+nIuhNSXJ5xACsa0ageZFcvRpwMFwtAVdWvjk3DYoPR3bsQltIhWMcYy/XOOix07W4sy17o+i0MXXY8gkk3XrkPOF/fMR6s4b/hZdLqLrBq3CasslgzM03KcNNA59VeE0j7R3ZXC5zu0FY3Tw4oYOzYPd3rmzzlbt/C9FmbEsaxiU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2619.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(84040400005)(66556008)(66476007)(66946007)(66446008)(122000001)(76116006)(64756008)(38100700002)(71200400001)(33656002)(83380400001)(9686003)(38070700005)(5660300002)(52536014)(26005)(15650500001)(186003)(55016002)(53546011)(508600001)(8676002)(966005)(7696005)(86362001)(45080400002)(4326008)(316002)(6506007)(8936002)(6916009)(2906002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Sz12KFyJFyiaTXeunqAlBXMZkxLpyNU9IH+YHyv+FYfJY7ywzbY+HJ3xmeJY?=
 =?us-ascii?Q?Z6CiFxudzTdKId0KBvUs2PdPCy/C2+NVodeRjqAIfJe4I75Hij71D24hh4h2?=
 =?us-ascii?Q?cF4PSwwtsdQUjy2KkHRMjRnzqRPgvObikeVsCvSuoGnYTZk4KdgvySkA4D18?=
 =?us-ascii?Q?XDOiCILymJcZMNkoxGnpc7h2VHFigRzEL8kfrE4UAC6JvCjFSK4BMS19C7h7?=
 =?us-ascii?Q?5T0wCvA9zpaCRjX5Yhwag7DlRCguvsS+ceiXPXzoJeo68U/kVaIzefyOah0N?=
 =?us-ascii?Q?gaPNsIuE7IiWeVPu4zGoiadfBIH3B5CQEY9yo+oJ+S6HD4KOFOk7rexgmyuw?=
 =?us-ascii?Q?tMH6GtH1pamOuXDZalJtQaYUomeykcTfD5m+Us635o74JriKhNGs1cCO5nQC?=
 =?us-ascii?Q?t5R69HN3qwUzVsamVrmOHniy/4JBpn0wO6B85obQx/6h4NnIPLG83dWSE23X?=
 =?us-ascii?Q?E5pUoWOT7z3najIol9XnEq680HsjUDxgdlUZ+LJ1vgjLIaW9jNLRrEfDMwSC?=
 =?us-ascii?Q?LzZSWJTf3dStkkjsuL+H/lfNCfGoisqcAiUMRlzpAkNZxHV9OzSs8tva1Sno?=
 =?us-ascii?Q?8TES01V2SCodL/GoRkcR7Nl61HiSPQalcZBXiSDjITOw1l9imBh2IPxJxW/O?=
 =?us-ascii?Q?TCPO8ortfh/tf7rdoesI7omPfE2C2dDhx/meCBQSStkSHSN91LJ0644DCEd2?=
 =?us-ascii?Q?bLNJ/wGvw7pczvWIkiaTmgoX/Vys4ry4IS8oEG9TJ4sayBdxvBIZ/ulF1hoR?=
 =?us-ascii?Q?MF2AkVM8U1jLlflmMVIINNsYPobaFOKqMr/WDID/iMuIKgOtQxXcGzds8yuE?=
 =?us-ascii?Q?kedsHi6JCiLZe2hih61X5zOEKYLxYuGRwTpjN+Hw429KSuTXw5lJ79Q/l85v?=
 =?us-ascii?Q?7dleoIr0s+7OOOveQZGNdgvlvv0da5DksUXecsRx6e+R9ccx8lQxszp9uZP/?=
 =?us-ascii?Q?jB/zezh8oWJTUz2A+VHI/Rw9RxosLceanA41UUM6pXO9U0YMytkAJTtZqvmc?=
 =?us-ascii?Q?QkaT97LKTjzr7paZRX/4PueBDIINnJ8o1+jh15kmZ0xDFmydgx0uiGzAGqHQ?=
 =?us-ascii?Q?138Yn6eUstycMAHeo7KXBwgG6JVF/e3hBh04TEfxu1KyFrgNloDwsDZmYRL+?=
 =?us-ascii?Q?vjt90GzLSBhZaINflVrBfKQWr9YkTYrD2S4A0oOneYUskKxCPyelG8q7V37t?=
 =?us-ascii?Q?lmIbBM4HYGP8Z6E8kd9pyvoMPrCQuBwxRl3zgu6oimZ2rTrWDaFZfYl7Ecp8?=
 =?us-ascii?Q?PUnvZviLn1Ay+4g+YBKuXaMaaIdoyRPz4Uim2M/wzi6ApFAjZE6bTE46N9f4?=
 =?us-ascii?Q?CUTGuAPSp0pSfyRwIZD9F6Lb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffbe10d-9f6d-4639-cb96-08d98eb6b8de
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2021 02:02:48.5457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2AX1CHDRXfOSq+ZqMnqOAOhDn9YHy6p9VCOcmHxY3QPAbLwlvbJOZS33Nvydu3Rv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0217
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only]



> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Wednesday, October 13, 2021 5:26 PM
> To: Quan, Evan <Evan.Quan@amd.com>
> Cc: Alex Deucher <alexdeucher@gmail.com>; amd-gfx list <amd-
> gfx@lists.freedesktop.org>; LKML <linux-kernel@vger.kernel.org>; Deucher,
> Alexander <Alexander.Deucher@amd.com>; Pan, Xinhui
> <Xinhui.Pan@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
> Subject: Re: bf756fb833cb ("drm/amdgpu: add missing cleanups for Polaris1=
2
> UVD/VCE on suspend")
>=20
> On Wed, Oct 13, 2021 at 09:19:45AM +0000, Quan, Evan wrote:
> > So, I need your help to confirm the last two patches(I sent you) do not
> affect the fix for the bug above.
> > Please follow the steps below to verify it:
> > 1. Launch a video playing
> > 2. open another terminal and issue "sudo pm-suspend" command to force
> > suspending 3. verify the system can suspend and resume back correctly
> > without errors or hangs
>=20
> Just to confirm: you want me to do that with the last two patches applied=
?
[Quan, Evan] Yes, but not(apply them) at the same time. One by one as you d=
id before.
- try the patch1 first
- undo the changes of patch1 and try patch2

BR
Evan
>=20
> --
> Regards/Gruss,
>     Boris.
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeo
> ple.kernel.org%2Ftglx%2Fnotes-about-
> netiquette&amp;data=3D04%7C01%7CEvan.Quan%40amd.com%7Cbcabc6c3a5
> 07426172a308d98e2b8235%7C3dd8961fe4884e608e11a82d994e183d%7C0%7
> C0%7C637697139813202149%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w
> LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&am
> p;sdata=3D7%2F3TXqlIld%2BdSocRyLsgZBeaFcsEDiI5GEwJ5AHaLSk%3D&amp;re
> served=3D0
