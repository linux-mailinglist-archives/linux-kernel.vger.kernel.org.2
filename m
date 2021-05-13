Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF12B3800B8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 01:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhEMXLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 19:11:49 -0400
Received: from mail-bn8nam11on2083.outbound.protection.outlook.com ([40.107.236.83]:64782
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229544AbhEMXLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 19:11:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=graS0vm8xTyIHGgTfZy1LJjQpXQgNNxrWSPr5GxxHj/L9jkybdUCAcYC09su3DYM+Qw7tf7gwRFosM2SRV9bjO256H2wCzSecCjn+kRusXW3Bv7rVrLTJlrVhqlzANFLXdm0TvWM0EP/MX3qW/ySIxwhtWGWFtk3pcj3QJoPeapgq6aTLw2gdvhxyLMLB685yQ46Mu9Gex45j959AWgwXnHRiMygr13pWR/K1rifG5XeNfdTDDQSNMovZ8Ie/PTxVaQNlh0U4j0+c0LkpFCuNRpP/u57fFziHLjUn9gjADKuFlCye0C5y7G4AeiQf0CfANKCN3nr+CRHPOMCtvBULg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VScB/0IM0kBvyO1wiucMX48uW6ahgoi81nzkDESBcUA=;
 b=Mhh4kDGdOfAZIWEbGIP1DGk/O11osXqL5ONg2DHlyM6A/xCTAw10gzOeK0gKlyMcYq5Btsqt1l9VtgIXu+GAB9+MyKGFK1Ho0DihHmvrU9czlD62YPVRMKXaz93UvOmihtM6L+xQTAi3XyjBGPTqoRg8z39eSDh7XnIGJkWTUkPR33C1jaCIH/IfV8NZhmWaxZkg8FiWc95g+FFJUqMqsRRvfLG8MuNogM8hPqsVqOdVEEMyCaqGp0BWdzdo8cXykiMYU1hQ21KWYzlMocnK1UIGlvy+slNEbxICtRZpIRN7NC1zvNYDPvP8FrSfDMKjVpU6Nwk7ssKZGxIzOjNgoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VScB/0IM0kBvyO1wiucMX48uW6ahgoi81nzkDESBcUA=;
 b=XXPshpYJe+DoCVhnVNZCuES0aLAd+dZux7Hu9xhe7pf3dXOkCjsss1K2mmHDSFVp26gEY0dbw+b5OLGB07dWc0K9h+fUMn+1CdmfHwSyJIQRXnmZh6mqZUDsiM4fg2lvLiaA1H5oeZY0HJdrxClAYbFErYdumL6gaXJKXg3/eKM=
Received: from DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23)
 by DM4PR12MB5133.namprd12.prod.outlook.com (2603:10b6:5:390::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 13 May
 2021 23:10:35 +0000
Received: from DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::8ce9:f643:9ce6:af9c]) by DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::8ce9:f643:9ce6:af9c%6]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 23:10:35 +0000
From:   "Joshi, Mukul" <Mukul.Joshi@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
Thread-Topic: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
Thread-Index: AQHXRs6Uco2r7eCCPEW3XTp7lQLNb6rflw+AgACR7NCAAC6FAIAAV7jwgAB+vQCAAG5mgA==
Date:   Thu, 13 May 2021 23:10:34 +0000
Message-ID: <DM4PR12MB5263A719B11C6DF8EF9F3A4BEE519@DM4PR12MB5263.namprd12.prod.outlook.com>
References: <20210512013058.6827-1-mukul.joshi@amd.com>
 <YJuhs1WsqtJ7ta1L@zn.tnic>
 <DM4PR12MB5263797EB7B2D37C21427A88EE529@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJxDIhGnZ5XdukiS@zn.tnic>
 <DM4PR12MB52631035F875B77974FA8D21EE519@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJz3CMBFFIDBzVwX@zn.tnic>
In-Reply-To: <YJz3CMBFFIDBzVwX@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-13T23:10:20Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=a2a024fc-2f86-4fbb-a0b4-9ae78dbeb349;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: Responding to public review comments
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
x-originating-ip: [72.137.116.80]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b6495cc-8e29-4b16-a8a1-08d916645074
x-ms-traffictypediagnostic: DM4PR12MB5133:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5133BD1E5DC6DDC4F0F0A1ECEE519@DM4PR12MB5133.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pZ50IzXO/Xp43cSHdBZodDkWsGyLHhlR+eqNNgDnxX4xd7J2tiSDKozVmYywe54F0ViL6v/pjQiCsIL74PkYlrtkDxZP3yG7GKIrhx3N428Z1HBPhxKCRF8Snr0zsl99/r2Nb5SfwdnAg6bXMMQebTLmKbNgh7utkncF3Ho5tdA3NnVZlyf5aUVdFUwU8wesbXFvcBNAcXkf9RyENPwdj5bkZvQltbDJ9Uvxgi4wl2D2iVYBSBBrjSMdjZuZrI3JLDZSOn8wrKnWL2cx6h7Y5YAPYv8LxPHvzlZOluT1GSUuXx6MMN8GP/4C7GqeC+ctMClPxYhbljFNReuqd3xuSulV6VPAiMWiKgfx7MVMW8eUaTHsiQdU25WCzIGo60ttsOrz+GXY1F5l5EK56WFaFzfzHY2yT2iYgcA8TpNgIcgOTSlM5JVJLr9FUt2O062E/TOb3+X2zSjQqnzAN1tEqg689U6BQjqqZIsTSxemoqV7LoE3ySUwuHES6nKJviPwBMJ5npCoyD/JWipOA+dOZJ3tzN4zV/Lionh0V7oLKLXcqhRvWONx+1Z9y+qqUm7y0vZuibhaqtndNyrqQwBjyz0o1vi/9YbcAs4r4NO4DW7/7OLeEfAfaN81CvhKmPKAZb/lMyuhaGDc8ZUJ87dyo42Hn1IPxZ5L0wfME26ZvglSG9DdtPQnokKvQagr0A2I
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5263.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(5660300002)(966005)(66556008)(76116006)(33656002)(66946007)(53546011)(7696005)(186003)(2906002)(8936002)(316002)(52536014)(122000001)(83380400001)(4326008)(45080400002)(26005)(9686003)(71200400001)(38100700002)(478600001)(66476007)(6916009)(8676002)(66446008)(6506007)(64756008)(55016002)(86362001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ipF+1fUNTzzrsCiOhfZAyukMsytjygsDUhBp8Ga8H+Sr5uty0xpoAsh6t7Mj?=
 =?us-ascii?Q?DWGr5KpRkssdEx0LNztvEIF9cXuUF0yzMMk9AZiSt8DegCgItnmfy5YrPOKC?=
 =?us-ascii?Q?A3orhbEfmFzbFcqEoeiVrE3XdxpxtuHlOcwROu0k2CrNq1mbP1uSZansz2X0?=
 =?us-ascii?Q?btn3v5lYzc2p9pVwnMviXUfvwWS+mrhg3FdqqzrumnEOJ0EcD/x5b0KNivIw?=
 =?us-ascii?Q?OEpCoI9JXDZFSS5rNf0IImUWOv8MAPwhXWzKQDTyOFIzYCPxmQ8UQ1z8bo2C?=
 =?us-ascii?Q?pzczgJIIymK+MVnYmWGhjAFd7xO5LHiISAcUjm8Pvu+dCEG+azZXsYRTtLA9?=
 =?us-ascii?Q?QrBWJJFNiqVw+UnCotERjFgi6z+tehvc1AqzZsWwBG9vQt5pIBe9wOeK2Nbu?=
 =?us-ascii?Q?OSzQ2RGfQ/U3PPH8W0Ij75XPjmckKcdktJAUN/byPdAYSMsczlpmVD5l5Nvt?=
 =?us-ascii?Q?1rlhARWZkXwwN+3msqe1jxM+zTYIr2TiI3azKlOuFWZcm4Fi/ZFOy1KY3mV7?=
 =?us-ascii?Q?AqJFT9zst7q6JjgbX3f9NaxOzE2cnTWLvd7wticbkWyvPQphMP/atE6Gr73U?=
 =?us-ascii?Q?kyR8kKnsvc7eimdXz3if+SGJwX0/4Vnj0HPLyJFeToM1rLdn23mZexs0HWxd?=
 =?us-ascii?Q?Io8LinwAEb9Zs3Vfnq36jpHZ2JLq9+CMVZJZnZUWuPjEJQy+CNE/sGhN2YfX?=
 =?us-ascii?Q?AU46+Yz025HJEf99nlM1+5ukuo7xBbnu+yW0ss3bepMrPFPAzpjUJOvME0KK?=
 =?us-ascii?Q?WVorSbdOoww7lKrxzxalxLmPQVSvM9C39WoPwljb7c6a88GJKsFfJaempHVp?=
 =?us-ascii?Q?ip6s8od+lhqnLpE3GT7qRMHx6PKXRUaNR/qeg8UdSnsWPNZxs9h65bxVIwzO?=
 =?us-ascii?Q?RU6nCBImpFTaEfDRW0OwnkqbpgTvxHxjn3QnPv7th0g0NGA7oZ5v+CHTbRPP?=
 =?us-ascii?Q?Y3trS3ls2oHwfsXjGVgY3xGIqZI0CKqK4blif/wTKbGqNuBxMJzGXPBD5PX+?=
 =?us-ascii?Q?8CvzfHjQv9L2J4V95hVzf8E39Lr5cYQFzGTIjQIsdQsHhK7EDCtauwCTBhhT?=
 =?us-ascii?Q?GEverCg4DMGdzTMjO7DB//eTBOS8ikWKvuMqDFbtzU8p5tenbXbug+heENG9?=
 =?us-ascii?Q?Uzepac25IRwWkxw4++GRLB2rImpJOQRLwnK9gYPwgTA/TYLjjQGzSvM/KD6F?=
 =?us-ascii?Q?FT7e8aE/O2+VtrUblUek47H/J7ORvsrD044VWr6+4Z1cUswdryw9mdhVVixK?=
 =?us-ascii?Q?U8gjyxXDTo8wzrMTZw5eYk7N022/KrviEuM0bDxwz70stzF0CweDjTe399g2?=
 =?us-ascii?Q?i/U98/cuDeIILT09ibDgtyuG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5263.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b6495cc-8e29-4b16-a8a1-08d916645074
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 23:10:35.0057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V0C3ZKQtkcbwHszo9VKwQo0ZzGMdmbuQMFoVrPfkDPnNEpKB/CX00dIOYz1kNhCy6ZeyCj+X1EFEQ79pHKWCIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5133
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - Internal Distribution Only]



> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Thursday, May 13, 2021 5:53 AM
> To: Joshi, Mukul <Mukul.Joshi@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Kasiviswanathan, Harish
> <Harish.Kasiviswanathan@amd.com>; x86-ml <x86@kernel.org>; lkml <linux-
> kernel@vger.kernel.org>
> Subject: Re: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
>=20
> [CAUTION: External Email]
>=20
> On Thu, May 13, 2021 at 03:20:36AM +0000, Joshi, Mukul wrote:
> > Exporting smca_get_bank_type() works fine when CONFIG_X86_MCE_AMD is
> defined.
> > I would need to put #ifdef CONFIG_X86_MCE_AMD in my code to compile
> > the amdgpu driver when CONFIG_X86_MCE_AMD is not defined.
> > I can avoid all that by using is_smca_umc_v2().
> > I think it would be cleaner with using is_smca_umc_v2().
>=20
> See how smca_get_long_name() is exported and export that function the sam=
e
> way.
>=20

That's probably not the best example to look at.
smca_get_long_name() is used in drivers/edac/mce_amd.c and this file doesn'=
t
get compiled when CONFIG_X86_MCE_AMD is not defined.

And amdgpu driver has no dependency on CONFIG_X86_MCE_AMD.

So here is one option that we can try:
1. Export smca_get_bank_type().
2. I wrap my entire code in GPU driver with #ifdef CONFIG_X86_MCE_AMD

Will that work for you?

Thanks,
Mukul

> To save you some energy: is_smca_umc_v2() is not going to happen.


>=20
> > You can think of GPU device as a EDAC device here. It is mainly
> > interested in handling uncorrectable errors.
>=20
> An EDAC "device", as you call it, is not interested in handling UEs. If a=
nything, it
> counts them.
>=20
> > It is a deferred interrupt that generates an MCE.
>=20
> Is that the same deferred interrupt which calls amd_deferred_error_interr=
upt() ?
>=20
> > When an uncorrectable error is detected on the GPU UMC, all we are
> > doing is determining the physical address where the error occurred and
> > then "retiring" the page that address belongs to.
>=20
> What page is that? Normal DRAM page or a page in some special GPU memory?
>=20
> > By retiring, we mean we reserve the page so that it is not available
> > for allocations to any applications.
>=20
> We do that for normal DRAM memory pages by poisoning them. I hope you
> don't mean that.
>=20
> Looking at
>=20
> amdgpu_ras_add_bad_pages
> |-> amdgpu_vram_mgr_reserve_range
>=20
> that's some VRAM thing so I'm guessing special memory on the GPU.
>=20
> If so, what happens with all those "retired" pages when you reboot?
> They're getting used again and potentially trigger the same UEs and the s=
ame
> retiring happens?
>=20
> > We are providing information to the user by storing all the
> > information about the retired pages in EEPROM. This can be accessed
> > through sysfs.
>=20
> Ok, I'm a user and I can access that information through sysfs. What can =
I do
> with it?
>=20
> > Hope it clears what "bad page retirement" is achieving.
>=20
> It is getting there.
>=20
> Thx.
>=20
> --
> Regards/Gruss,
>     Boris.
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeopl=
e.
> kernel.org%2Ftglx%2Fnotes-about-
> netiquette&amp;data=3D04%7C01%7CMukul.Joshi%40amd.com%7Cd8c660fce3a2
> 4ce3c6d408d915f4efa6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%
> 7C637564964013263414%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D
> %2BnJ%2B99N%2FRljoHGALimZHZG%2Bmf9jL5zP2eA44I6pbzFY%3D&amp;reser
> ved=3D0
