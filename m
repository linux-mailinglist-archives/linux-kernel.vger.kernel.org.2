Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870D8380A1D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 15:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbhENNHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 09:07:47 -0400
Received: from mail-mw2nam10on2089.outbound.protection.outlook.com ([40.107.94.89]:27424
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231217AbhENNHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 09:07:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a42NgZyoMB2MEH/8evjHXbkSViquLQwCs6QNvxn2p4wug0MTBoLmrGxs3tUFbsRbR++Ui9pTTMD6nGOfZj+VZAeUREspHFoByFCz76511jr9EOiEief77cuVKvwJYFDxDVNP7EzbGVOSr7Yn5ouLqhL2NVlhHpkDO5/fw0tkDZ0bfQE09nSkyHDAa+Z+9zJ8PSKFJkEJMUXMCV9k58ZuEwauzXM3iymLeglyDBB3kUIOPE4d2ULaT4UdY/BBjXGmhad7ySjAHmpMY04X2tzrTNx2iNxCKIFUnx0Icm+SFCLSL9M3/xNruLE5/FxyJFsHHqgEw54a/lZkspoWkaeQ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RnED4RZTArZsIKpniASsDJn8v0g6CTIC//kpRPxSYI=;
 b=VIqn94tiFCPW6a7xW2hiYC9M+6q5Z8w3BAcYQvZ28DUSNIG67r7t/XNDiR0WMX+btUibCbMi8ufTS3SV3GSR6XMHyvdyd6ZNapp1mS+sXait4MIlZlkY3oCXLzA+kzzQ8SmN7mZNff8mYPsbUlNZOQismRFZ/TbgezQzYMZExZhuzra4aihMmsgMBmWOSEEIG9L6IxkOjes8fOBj4X3IAYR8exrJ+RVN1QYREE6lSgrmUnXtJJI5Cg1n0mI0XnB8eAN0x0ShUJUyoanypH112PuVja7G56P5iIyyE1QlIQsjMM9ozllM8VvjUJdkUNeJHeOEQaVLySSSc5RzhM57AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RnED4RZTArZsIKpniASsDJn8v0g6CTIC//kpRPxSYI=;
 b=TXAf+Lpqp3veQumvWdyc7K8vSk+V+4sARHtoYRuuJpVxzmy276CDF+Qa7bLLWpTtM0AmXi3iI27dShR7SPyD3oWHYzKBxe6j4zYh2AJKjaYr1gv5ZSwqh1DoWLWdAfyOa7+fG2jTII317mukj3EoHnAHREqHTP1PDJkX+9LjLQw=
Received: from DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23)
 by DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:39a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Fri, 14 May
 2021 13:06:33 +0000
Received: from DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::8ce9:f643:9ce6:af9c]) by DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::8ce9:f643:9ce6:af9c%6]) with mapi id 15.20.4129.028; Fri, 14 May 2021
 13:06:33 +0000
From:   "Joshi, Mukul" <Mukul.Joshi@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
Thread-Topic: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
Thread-Index: AQHXRs6Uco2r7eCCPEW3XTp7lQLNb6rflw+AgACR7NCAAC6FAIAAV7jwgAB+vQCAAG5mgIAA9SiAgABh6UA=
Date:   Fri, 14 May 2021 13:06:33 +0000
Message-ID: <DM4PR12MB52634855954DCE456D244288EE509@DM4PR12MB5263.namprd12.prod.outlook.com>
References: <20210512013058.6827-1-mukul.joshi@amd.com>
 <YJuhs1WsqtJ7ta1L@zn.tnic>
 <DM4PR12MB5263797EB7B2D37C21427A88EE529@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJxDIhGnZ5XdukiS@zn.tnic>
 <DM4PR12MB52631035F875B77974FA8D21EE519@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJz3CMBFFIDBzVwX@zn.tnic>
 <DM4PR12MB5263A719B11C6DF8EF9F3A4BEE519@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJ4hS/SJYmCC9Rpd@zn.tnic>
In-Reply-To: <YJ4hS/SJYmCC9Rpd@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-14T13:06:13Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e1a5e44a-4d65-48cc-86d0-8c13df91d7e0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: Responding to public review comment.
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
x-originating-ip: [72.137.116.80]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e39e8c4a-585f-4af5-3f89-08d916d91953
x-ms-traffictypediagnostic: DM4PR12MB5390:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5390CEBFE3C1188CF4987847EE509@DM4PR12MB5390.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Ykr5d7EQiGgXERFdvdBeKBxPYcC9bQJ6ieuwB8+YVXvxtL+NjS1jASRMqaWW4WxGddUTygJZCu7dgsskEwPkp5GzGz+u0QR5vjn3Ss7Qx5hxw6kyk/Fd8l1/jN7+KqL0pgCAcQORRGlAsUwCqn7in94C0fKwoRP2LUeVY5SMGjIWYJGO8g51YN5/2QRvrt/RfDr8qX23rnN4DNt4E/tjf8jyfamQ6K3pp8rr/xhwTjM+HV1X4LPxFyXmv9HxATsdIqzq7QBiVgH0FO+vJdiWI5kXF9EqJ/cjyPsfl6q4y7U1Wy/6oSnxMg9NQweov0VeFLBoa8Ncahn3BP+SXaBPxOy1HD5xixsRONt97UGIFM27gXEKld9qo9UpivNnDuWn9XUQvmMVKy2Xxi3hUe3uSzJTjvJOvqzWa/j5qvGqoczvROv3zzH5wKlJh4ws+42OPOxY0uz9OeWmwMZozPLMYp/FasCLZ8ue9fV+n9OGHWnQWA2CyWy7owd7G3BMCGKS41uksscUENCUkM0DL877cWLqJMfg/xnlm5fkzQzfYM9vzk/Z+/OufMyXx54ZZziwifsbHCcWaZTzFegQJ170fjuxjNHyOTF64ljUsCSfTl5dnxkcLRj9T6hyaQYNWsFOyKbdVT+gaE5rg3Wb45aFA5j7n1TsxPSRNP+gy/9QSe3/GqWGOf4dXRM+PSU/7dF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5263.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(7696005)(86362001)(186003)(52536014)(9686003)(316002)(122000001)(54906003)(45080400002)(55016002)(8936002)(966005)(71200400001)(8676002)(76116006)(66556008)(66476007)(38100700002)(66446008)(64756008)(6916009)(4326008)(5660300002)(66946007)(478600001)(83380400001)(2906002)(53546011)(6506007)(33656002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?R3VpnsTxFRvOlT+pvwzmkUeRlcD3t1h/nPKQtSbgXxFdlE0fbNAS3I7CjTj7?=
 =?us-ascii?Q?7s7YkRq8RyHscDEHJM8G9XNxNY5V6Om3yr6UlUksFuEAp++Wa52gTdyl6mBd?=
 =?us-ascii?Q?aRxn9J/Tw8q68PlQ57+Jpe5mOHPp+48G5L27pYngmZEyp967lrnelKBaU18c?=
 =?us-ascii?Q?8Ih2+l4knnj3UUSNXEOD65iHFU9Kp4fWHUtW+EDiMzKgXVkcEzp9gDcjSb1W?=
 =?us-ascii?Q?D3My3JwI1zC0PlAmMOJrXfDYzsW/CEyXr7IRqS84HKfe/54YueNyiOmW4mOd?=
 =?us-ascii?Q?/LQp3YOJYZznxSOlzI4nXhToX3AjbORyDSBmlYK/CxIANSGuvDDX5be4Qs7n?=
 =?us-ascii?Q?saO6BgEfDNRJ8VryPFxebiKn6gW1BMy2o7oVrBgl6TLmeWV+W1s6N41jNWtD?=
 =?us-ascii?Q?nCSiyd9BU8XSHlyvZbit4wAKrjR1+D0EU+uqFSh+E9Qy6REaSViY+dnTzJ0q?=
 =?us-ascii?Q?x7tWnCbiyQk1RGcPvBdwnE9gaex+68zoKLbrUdCrLvqr7GERwY2Hlus5b/cT?=
 =?us-ascii?Q?PPgpHdPHRgUflgG1vA8zuzdubuQQlcglbQ2/p7dB6Mx66CEEKvgZ91VBq7SU?=
 =?us-ascii?Q?UK6K05sXzqSGMgzybw77WlYPdloWyBneuIzzREMHNmY8ACQzyrlaGjxGH0oh?=
 =?us-ascii?Q?cEx+3c+hkhKQ64ZfW57kmd6+5d3r46lNmq3u91AKdH0beiHipX5uQ0r+mB5k?=
 =?us-ascii?Q?fOPrYkRwHrUvDvHHVSa5kEXqMzH19l/hWhqrvBzVPHAx0tXa7dNPoqil+kud?=
 =?us-ascii?Q?vysfTJDqPXE9p7Z52ys69JR8At+xJup1O70XJO/hw9jTL+kZZz2CIy+41rsb?=
 =?us-ascii?Q?5rRV4H6LUUBbaWyZkxqFsOza1Wesa0oMMQSS8fEehfTKlFxixUI4mEQgyioz?=
 =?us-ascii?Q?yz3xN8l+hRSDZLs372kvssGuZqoxlMu/Q18fB/3mFwNs++c93TP8SePBIEer?=
 =?us-ascii?Q?B/kNZVF0+0zc6JNGx/hdXZdjAycxXjIgX1QsIDK9T+TTPbcFbksD17Pb0A8K?=
 =?us-ascii?Q?Lc+Bb1j36Mm0ANRiIf7ho2/Davm43UDeixdoB+ItAAL7U6c3p/SDldrdjjiw?=
 =?us-ascii?Q?QNk+3SsReAGzeqVzVoPJMYavzFdlLlP0WQ+w5D0Vf5F45pqH85IuTnF+Kcr9?=
 =?us-ascii?Q?iALUqTEFKGU0ZXBXDhS+JLdnKxkmm6T1Rw81sePEiOnBs5ttPbZv8zRG31kf?=
 =?us-ascii?Q?6A1DYWZUbU80b7izJTqkatftvt59QZp+YZglX/tzHyMJNkZFyXx/gOE3kznH?=
 =?us-ascii?Q?Ms6vUJoz5OH/smL4kEsIwEO+uJ+EJUIErFvpw5xW9zu2gBbAWhzrelZZwtY0?=
 =?us-ascii?Q?mwt1FPKwgwknkCnOMclDg2kE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5263.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e39e8c4a-585f-4af5-3f89-08d916d91953
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 13:06:33.7509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SwYwJxV4DtafmgnyMBsonxZjIvgLzbPbCremuDE2efna67CpxTAeWvi8Nr+v0yHNF2ZTqWlIAAGkUDKYgooSGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5390
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - Internal Distribution Only]



> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Friday, May 14, 2021 3:06 AM
> To: Joshi, Mukul <Mukul.Joshi@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Kasiviswanathan, Harish
> <Harish.Kasiviswanathan@amd.com>; x86-ml <x86@kernel.org>; lkml <linux-
> kernel@vger.kernel.org>
> Subject: Re: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
>=20
> [CAUTION: External Email]
>=20
> On Thu, May 13, 2021 at 11:10:34PM +0000, Joshi, Mukul wrote:
> > That's probably not the best example to look at.
>=20
> Oh, it is the *perfect* example but...
>=20

I would prefer not to get into an argument of if it is the perfect example =
or not.
I would prefer to get the job done and move forward.

> > smca_get_long_name() is used in drivers/edac/mce_amd.c and this file
> > doesn't get compiled when CONFIG_X86_MCE_AMD is not defined.
> >
> > And amdgpu driver has no dependency on CONFIG_X86_MCE_AMD.
>=20
> ... maybe this will make you see it the right way: how much of the amdgpu=
 RAS
> functionality you're adding, is going to even function without
> CONFIG_X86_MCE_AMD?
>

We have RAS functionality in other ASICs that is not dependent on CONFIG_X8=
6_MCE_AMD.
So, I don't think we would want to do that just for one ASIC.
Maybe Alex D. has an opinion on it.

As I had mentioned in my previous comment, I am fine with wrapping around m=
y code with
#ifdef CONFIG_X86_MCE_AMD and exporting smca_get_bank_type().
I hope we can move forward with this approach.

Thanks,
Mukul
=20
> --
> Regards/Gruss,
>     Boris.
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeopl=
e.
> kernel.org%2Ftglx%2Fnotes-about-
> netiquette&amp;data=3D04%7C01%7CMukul.Joshi%40amd.com%7C7fded9165e6
> 64dde943808d916a6b33f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0
> %7C637565727509040995%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata
> =3D5hNyAEla4H%2BN0kMdCDs6iL0Dr8mVQJNxKA0UXJU7%2F8c%3D&amp;reserv
> ed=3D0
