Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651D83800BC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 01:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhEMXPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 19:15:45 -0400
Received: from mail-dm6nam08on2052.outbound.protection.outlook.com ([40.107.102.52]:36490
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229544AbhEMXPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 19:15:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMSByd95Xd1b3UbD/ntF8Obqwj6fd8LwDfAVQPP5YpwM/qo2Jtq0hIEUMyHLdqFgmlko0yk6XcHtdoixDuCuavB99FyESIqqwf+Oxwi2OWP6XYH3CdG9qDdnFLxkc4oIR4iIIabfXBMSbi0tsAjX4xylsSZJZLboPOYdDR9ijXN3bdpnVX8VnySpiJbaD5BU0AAcAW744YcOfi7uhV9O4qM9xBHCj47BC/f1Ar8sZIgZC2WemzALkZ0uizMJM03BFfr4BztOC7p9xjyI0+3Eq+Q2Y1S5UUvxuHFDQR3guMJXayHJ7RSav/fyUEuodJEwDFOpt0xSxaxCe1Kht5Qy9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ih4S/wPlp+rwt8fSw4XlZWxCpHRrXXCRExYqGuT+/4=;
 b=GbC7+QR4N7UCyMhPDSUBm6POG5qxwbZR2/rg34j8BuyXD2VdiS1MEiXZ5WRlRtv3p9hcV5WkH1a6iNixHxvQMGnqOSooK0yeAGBsvI+wwdMhYV8UstCKDYxzZmy9y5dZs6ykLsyRiB1XiTpbptgCaB/x06jyP9WD3/dnmBuGS+SHgbVPdAStU4IpPVYl7+3Gel+FiLs0GZElepuKqFyPJkpBCbJjIBVv+vvzocO+FM+/Di8nAl2j7is7ahwJUuyg32otD7SOq8DC3v/GRiwYrlwnkL75YGAK1vxVt6fxkNz5HZBWIcW4DOultQSHtbSgeAx6+N+/un5xtL6X2jGb4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ih4S/wPlp+rwt8fSw4XlZWxCpHRrXXCRExYqGuT+/4=;
 b=T9T31GpWPjRjo4lOgU8yUa8kHXWcWOXZ5fv8MQ1ArEUDSuXIrXLBcz5sbybypH/C5KKvoawAaTSS1C7mH7V0E11lZ9Ij6ztMFTm4RPdcBQg2yPEa7nHx5dQIvo3gAql6nJG9LHOvf7/PGI//OQyqG8kgZR/XvW3FF2ixQ+USdME=
Received: from DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23)
 by DM6PR12MB5567.namprd12.prod.outlook.com (2603:10b6:5:1ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 13 May
 2021 23:14:31 +0000
Received: from DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::8ce9:f643:9ce6:af9c]) by DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::8ce9:f643:9ce6:af9c%6]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 23:14:31 +0000
From:   "Joshi, Mukul" <Mukul.Joshi@amd.com>
To:     Borislav Petkov <bp@alien8.de>,
        Alex Deucher <alexdeucher@gmail.com>
CC:     x86-ml <x86@kernel.org>,
        "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
Thread-Topic: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
Thread-Index: AQHXRs6Uco2r7eCCPEW3XTp7lQLNb6rflw+AgACR7NCAAC6FAIAAV7jwgAB+vQCAAEnsgIAAA5mAgAAAloCAAAbygIAAie6g
Date:   Thu, 13 May 2021 23:14:30 +0000
Message-ID: <DM4PR12MB5263A7ABC342C37CE6891707EE519@DM4PR12MB5263.namprd12.prod.outlook.com>
References: <20210512013058.6827-1-mukul.joshi@amd.com>
 <YJuhs1WsqtJ7ta1L@zn.tnic>
 <DM4PR12MB5263797EB7B2D37C21427A88EE529@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJxDIhGnZ5XdukiS@zn.tnic>
 <DM4PR12MB52631035F875B77974FA8D21EE519@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJz3CMBFFIDBzVwX@zn.tnic>
 <CADnq5_Or5maEWTZFzS6iksyoFC=q9=y=-YmPTdPuWRKFhdw0yg@mail.gmail.com>
 <YJ04D8a6LaVRMuGH@zn.tnic>
 <CADnq5_NQonmqtFDpfsWygGzA2kv-W-daDSkxkY2ALf9a1eby9g@mail.gmail.com>
 <YJ0+YbwSpxTrghpo@zn.tnic>
In-Reply-To: <YJ0+YbwSpxTrghpo@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-13T23:14:17Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c700ed78-249b-45e1-ba1a-1e69aa51f0c0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: Responding to review comments
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
x-originating-ip: [72.137.116.80]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a3a3bab-03b4-41e0-3a10-08d91664dd03
x-ms-traffictypediagnostic: DM6PR12MB5567:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB5567FF4FECB559A70FEB1712EE519@DM6PR12MB5567.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TRLsOy9bu7VDeHrs+5lW9DgtSJHV2MbX4ZmAaQnkKNGCMBhB8qeYziVrBe04jtly6N0H6xkZko6L7RnIJwn+f1ku/gTXTi1QbY3+CmHK19WW1xYtrq4PzNzjEV/VRL3tJY/NISRJiSjDcDpzr1d0OBqDwm8cF4eKbamLtHmMjAnhSD0VAmUCMlUvkCaa68XrSlP1nzrDpQLmdTbSOyCMUu1J8p9NLaPIjMpF766dO8ZOYIUU7DeC8dVFfupFMaD5kIz5EtMSZYS8HjNJaw0FSXPoVTiiQmmKevPuAzhV3CLXh0U2cWSwxGE2+CvxAkyVpJTlV8nD8YW8mu5iWEVRAC/3LgpUSyAzgTZqxvvSmawj115cuv2IPkhsbj3rQ7VmogKssCz0sF2bNWbtSYeiR3YZDh0SF7DuwVTpKUQx3rq6DNs0ABKS6tDoA7miUIwverDgoEoV5GmOTQq6CvbiKa6AyM0EczZY5Hzfm222EDWQ33+WnpAevOXHy3CZAhOXV/mdKQleeTCBiBQduWHm8c1SPBFYFLWbpLy2Kh+SVgd9si60m1emuiAcfMYMhNT+X1d9sFsFjnwMn3rmckfkOp8+QCWkypqmtQ6pNpG19jCjArqHRryuHlgorv+q1b24c9IDwU765TvSfmlIrxp4MCroo406cwHOgGWdHAdy9E8zBLY01pqbGKjq/gX+uEdN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5263.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(33656002)(76116006)(86362001)(122000001)(38100700002)(26005)(83380400001)(66446008)(66946007)(66556008)(64756008)(71200400001)(2906002)(966005)(4326008)(110136005)(55016002)(316002)(54906003)(8676002)(186003)(9686003)(478600001)(66476007)(8936002)(53546011)(6506007)(7696005)(5660300002)(45080400002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2R0Gtqs0qXYkwav0t825G7T0vW5B4VFg4uiWdag592EJLrdAe/XypWXNJ0Zm?=
 =?us-ascii?Q?21+RoW+TkxzfMlSJX8FKd8RsebrnuQGimZIo7JNmOvAwzc0dRYFPB46qcMGb?=
 =?us-ascii?Q?K4XIHoZiju4m0IcYEtMdAAKaCEl0u252gw9RxaJsVM2K42c6uEaw630WpvTt?=
 =?us-ascii?Q?+u6a8HU4tXGLdppu6hsnCMxUaeS8nIu6ldxDcEuAjC6q3PcyzWn1yt4wfEbQ?=
 =?us-ascii?Q?g957bSh+Nb2sZ7k0TJ17ATJ31xTGvguIolzNWDOuEZti2OLZ6fCexd8s3801?=
 =?us-ascii?Q?EY8VdrF1rxb8Ot0xqBM2VkGimMyupMzwPfQnQQaDN+QSYKBitvGj47xyR5VK?=
 =?us-ascii?Q?k70rbpicSBOHRKAqwjNWH2BwBkklidSVYUkyognjpt65Ho+TwDZNOFVS6BwU?=
 =?us-ascii?Q?mbQbQ6cI0GEnsvMw/llNh/t/xlKyADM7jLTPZ8YAVbFWL8js0X7SZHrgrw32?=
 =?us-ascii?Q?jS/dgqHRDTQKRBkH3EhX0TmtW/WvEizdd2mf0qTayhwNbMW/AlrecsqyuxqQ?=
 =?us-ascii?Q?LpV6XGyDHCbeiQGEJEu/MYINinE7FIkrzUJDt+M92qHEnRFmDrTqi3c4tMrz?=
 =?us-ascii?Q?JwrBLd+t8pd3DUBMO4jHRlPHFDQGwESDwl0aAk/vyj5nH2IQvqK1eFYxHWKy?=
 =?us-ascii?Q?HrqjTx7XgafELz2mGcLTytSXuZP+Xi2ohRATFawEnGotx8DXSylV2iMTWrZf?=
 =?us-ascii?Q?AGByvDHDxhTOuw0Sr8MppKQY+oVIMISahhrrh9lsyNNtQVv18PnBXbO6SwAq?=
 =?us-ascii?Q?jzc83/nfBLnhCloslqW8DiUh9jOKGh9CaWp70Mcg6Gol7lHSAK+n6vU3IwhF?=
 =?us-ascii?Q?aiA713S45TueTjVJZRHy83FP5H0wLEKzlacJNe6kyL6wy7jxe9JlftiUM5/l?=
 =?us-ascii?Q?V0/gdCtv6mDTDWigYtQYlyp3IkThMCnJDaSgBb/zD3XHvI/UarOUIfrx5ULr?=
 =?us-ascii?Q?f/fKhwUq+hkVm3rsUppAs6q0bJ2JY2CRMfspvjgXt6r9lHg9J9RVOFozGKYR?=
 =?us-ascii?Q?XTM3UIAI38rygi7kE+fpAq3Cyuc3LYeZXMgb04dE2qCmxYd1MrmlF9g8onEZ?=
 =?us-ascii?Q?/qPUiKB+8m9+W2VQRfwNLgrZZnSfbEuxoNIStmpfN5itTenAiEyfxgQbm5oh?=
 =?us-ascii?Q?kYjZhcACGIBZOuRxAcuzh/XMPGGx62s09E9wJtCCmYlrFFhsk09V0oweMjU4?=
 =?us-ascii?Q?W2OS5VPXEGVKUX+pAPTj+OwNE9pgUNhmhtTD/5T/wq39qLrVM5/G8kYgfsgW?=
 =?us-ascii?Q?TKv3CH2fje3+Iyljc4scb/ZePQRlSalbbxHX/LSvRqsJBbXaMCiWtJipFn+z?=
 =?us-ascii?Q?AlmkLRzzvpW6LyHnCr24FDP9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5263.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3a3bab-03b4-41e0-3a10-08d91664dd03
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 23:14:30.8908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TJB2gb3aq4k3KFplDeT47+trA83ntRm41N4zNr/t61tifUSAet2RmZ24sVD2WJHdmLpZjog3yXroN3CMvMZLVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5567
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - Internal Distribution Only]



> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Thursday, May 13, 2021 10:58 AM
> To: Alex Deucher <alexdeucher@gmail.com>
> Cc: Joshi, Mukul <Mukul.Joshi@amd.com>; x86-ml <x86@kernel.org>;
> Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; lkml <linux-
> kernel@vger.kernel.org>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
>=20
> [CAUTION: External Email]
>=20
> On Thu, May 13, 2021 at 10:32:45AM -0400, Alex Deucher wrote:
> > Right.  The sys admin can query the bad page count and decide when to
> > retire the card.
>=20
> Yap, although the driver should actively "tell" the sysadmin when some cr=
itical
> counts of retired VRAM pages are reached because I doubt all admins would=
 go
> look at those counts on their own.
>=20
> Btw, you say "admin" - am I to understand that those are some high end GP=
U
> cards with ECC memory? If consumer grade stuff has this too, then the dri=
ver
> should very much warn on such levels on its own because normal users won'=
t
> know what and where to look.
>=20
> Other than that, the big picture sounds good to me.
>=20

Since now you are OK with how page retirement works, lets revisit the origi=
nal=20
question.

Are you OK with a new MCE priority (MCE_PRIO_ACCEL) or do you want us to us=
e
something else?

Thanks,
Mukul

> Thx.
>=20
> --
> Regards/Gruss,
>     Boris.
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeopl=
e.
> kernel.org%2Ftglx%2Fnotes-about-
> netiquette&amp;data=3D04%7C01%7CMukul.Joshi%40amd.com%7C50588f11ed5
> 3456b03e008d9161f765c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0
> %7C637565146658376385%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata
> =3DEs0FMDNzNEKgxvFiqe1kOo9aEPK6%2BOXrhI5aWs3QH9Q%3D&amp;reserved=3D
> 0
