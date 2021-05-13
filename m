Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B308037F19F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 05:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhEMDV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 23:21:57 -0400
Received: from mail-mw2nam08on2071.outbound.protection.outlook.com ([40.107.101.71]:46848
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231167AbhEMDVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 23:21:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HoWRx8c5Ng/cI60rauGGw3AiHsVm26YbFvKr+b+sdORbBCbFWzVt6/jpPpWFvKGhuBh2q0dOO7xYmej3qFUVD4gj7+Pl4Jh8t17+bAB6KWJg/+LK/Q3JfJnX87Jtra4oHTkr0cYsOzjpYO8k+T/WNnUVG1qBAGoQAAyZ0gQq0B0krVhHhXbkTOZLaQegh7aGuPdLrr7fpwc7j0uGuHQ92VxaUFRuW2Pguby95Xs5ysPFWDJpj1Ow8UuhCLFiZhVBEy6IhhvgIyzF1JikyDW+zlxJbZjeHPds8Z27Ude+7tjNGWlDbhInrfqeld3jc5Pxn6uv3nHX7tB7yhcmnX6KgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Alo3RxbRYIgYopajod5wXQe3YOY+VbX6ZDE8zZO17Rg=;
 b=mAYwUVeEvbBKhUhejQg3t8e7QXVHDheq9SUjX8gitzVJl/1N5Kh49nH/Uf2/cX80AzI0jUOkfkALlrGnmx5+nKpSWoZUwh40XC8K8J04IQv9+gkpoH/IXrrUupuZxMqHHbv3xG0PTZ0dQJ15u5FCtx/ZzvGRINnrJiimTFFwE2KY09O6vFh75uTrZIoMLDq42+XNFm0eLVQDOjiaPRDu9MwMoa1ZmuURcicFoviMAror2+G1mEeZTorzI/npZSj1FX6zjdlq+vNMLAhaj3EDxEyV3woOd/krJu7e/YWdrQZBo/oVqNboRsIXANZcM8fcZte6QPAf/eY6roZF4R+Hgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Alo3RxbRYIgYopajod5wXQe3YOY+VbX6ZDE8zZO17Rg=;
 b=SqLy7KRRv0AMboym1WZjgYvgWIJ53hqEBBJeZ7KVifT+Q1xF+vgbLthwLnwf82VGLQoTAfgS695lh2U71kTXxFoGLcSwoiUgZN28Ad+/TOlvEKUpE34/CKUUa6GEXxZctipaogcRXyLhUQ9fk1ZH4sMAxjtgpUKOqYwZxQnaOKo=
Received: from DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23)
 by DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 13 May
 2021 03:20:36 +0000
Received: from DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::8ce9:f643:9ce6:af9c]) by DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::8ce9:f643:9ce6:af9c%6]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 03:20:36 +0000
From:   "Joshi, Mukul" <Mukul.Joshi@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
Thread-Topic: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
Thread-Index: AQHXRs6Uco2r7eCCPEW3XTp7lQLNb6rflw+AgACR7NCAAC6FAIAAV7jw
Date:   Thu, 13 May 2021 03:20:36 +0000
Message-ID: <DM4PR12MB52631035F875B77974FA8D21EE519@DM4PR12MB5263.namprd12.prod.outlook.com>
References: <20210512013058.6827-1-mukul.joshi@amd.com>
 <YJuhs1WsqtJ7ta1L@zn.tnic>
 <DM4PR12MB5263797EB7B2D37C21427A88EE529@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJxDIhGnZ5XdukiS@zn.tnic>
In-Reply-To: <YJxDIhGnZ5XdukiS@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-13T03:20:21Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=9419c14c-4c22-454f-9d1c-86609d15e564;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: Responding to public review comments.
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
x-originating-ip: [72.137.116.80]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb478399-0eb8-42be-9f3e-08d915be137d
x-ms-traffictypediagnostic: DM8PR12MB5400:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR12MB5400539BD31E79878121CE25EE519@DM8PR12MB5400.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dl1s+lLqiwSRZnSmZWkjhCp90oYklFBBO5YlGq3xDTad0C72I4naFnoZ4eo/FBrjWLz6Gs5smgC4GOKlgV2VULXjQYdNjQssMZCpCuX1uebBPlt3+Yk46Muq//fTmyapC8B4i75NmdiyQvYTu6x0a2RvPZhIok42gx7W7BU/i3bLI9As7gzqT+7NHA31njbh6rTOhuNSQvVtI9451MW3e/exsMbEUGwCwftTm1hXfD5VxHSqKzwZq7sbpZ3VSIqB3Esg+Cq9EXxysNnH2oPju6wUGlvNmZbbSDCMqIH/ubDj3taq5XCeYh2YOYExpFp2RAV6dqQCBgN1VSk8uGj/XzCqQ+0F2y6FqP9N74gUem+CdkMp1bjMVId1VvuB5e2rFWmRh2t1WElTIZcIKDlRh1h8DX0eLRo430FkgEovgNguedxbC4J2Y87xgLcAVn6716IkrvuimSN6wX1dHJrmaAR3axDkJEfvr/HZL6flEFk8QKflPAuKWEhYcazruTesyzjcIf7Ti+5JL7k21tlFV670dqyOYqHKyGIlkP8ZI7QWt/r+a0Ss38EyHnqfwW6KVC4sgeVhIHRR3kDOVJCxqp8Eruj8lVkOiu9q5ltFAUe7JAbYFbo/tIeUAROb1lQwTYq8gjMXMk4ZnyDffH/Ks6Te1sBiJEOUPBta29hk4hiN4wjSWVF8yDNKevRonWJ2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5263.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(33656002)(122000001)(53546011)(6506007)(9686003)(26005)(66476007)(38100700002)(7696005)(86362001)(4326008)(76116006)(316002)(64756008)(71200400001)(66946007)(8676002)(66446008)(66556008)(5660300002)(54906003)(2906002)(6916009)(45080400002)(52536014)(8936002)(966005)(83380400001)(478600001)(55016002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?isNRjxpHVZqGgO7viPO2Bumv2JW7Pbs/bQqfHL62dOJdCH0hbxf9SCSV5Dno?=
 =?us-ascii?Q?oI9aBTHzwtWhqWKg54V9duoqoqYlDBXyVCeiVf3uKvAjg0QIiqaS6RtRpevY?=
 =?us-ascii?Q?RYsg/sLeH+re3eZ4VHBbhWlUJs6ey3hF9+/hJzVw4/kTj2Ie/I53Nwte5ffc?=
 =?us-ascii?Q?0PjeNu5ZOVERUJ+rhgIqEED9Omx3QEmb6g1DCjeu3uJl0mWjhqJk3COpWx+H?=
 =?us-ascii?Q?vVzPgz+jqila+TUld8r6zr7tcYbVVfxhSgolsdWB1Li5h6FqKWqViLwE346Y?=
 =?us-ascii?Q?iCK4Le36p31Xf7crsuE+b7eUhRoJmFq6cIwv+C6G6+E+xhO1wcFlPM4sMicS?=
 =?us-ascii?Q?ehz5sUGkl8E2IobzLC8ELuNdBsD7inCJSso+OGl/nmtGqdk5fyHbH1ePa45z?=
 =?us-ascii?Q?5buGBrfkt/g/ml4xrpgZJUIvqAJcwqG1MIiLd92nyGNSQkTG5uV0sl4QUGi0?=
 =?us-ascii?Q?30LVPZeoqaof8XXVEUKTigZ3xVIVnKfetjIIMqBHAnGSuECpE5NAq9u8loQQ?=
 =?us-ascii?Q?ioVz3SekCTXMQRdMQwHrNZi0Bacnt+PYf2wxaxODsTnumsSk2MYwstuCs8fM?=
 =?us-ascii?Q?Vbb6dyoLquX9UniGt8qoM8w7Odj7UEv3iIzuB/jBjhFZvUk9N6OoKGgKqZPm?=
 =?us-ascii?Q?gA6dAjBAY3MNNERwGdJFcvQjrcGEQ3KSdwv5ZR2FzBUR0s7g1Rb8YVNS8lWK?=
 =?us-ascii?Q?sAHAHyIrdVkQnI76Fd8UMTDlXLn0mTL0H4s34J6QWD4iYBwTN76fc3MwB5Ad?=
 =?us-ascii?Q?IqT1efryOdaH9xeZOp+OfDLL2O6+6Hwsk9LZewgjkJezprwXgs2rZGDg04rx?=
 =?us-ascii?Q?bSILx20VKjFaFbYSRdAhnbFQLgYUY/kNcyG4t9emhQshHQ9QB9i26HZsmc/k?=
 =?us-ascii?Q?9NLzTLuTjG4gJDvJneWkXR/D/6NIBH1OU7EAWo23kT46t6+SHSavR+YQMXUd?=
 =?us-ascii?Q?Js26Mw5YgmPEiBso2i0rokaylIWcI8Jk6DwHEbcc/hEeF2One0eQRDexUmfY?=
 =?us-ascii?Q?llsvwV04bwAsvd3oILzRg+rUFA8+LdA/doeD7a+UFXoli5gjEDbZvgriVgUL?=
 =?us-ascii?Q?lYW9fFtfYcVefV6qLHK9gO/UcnweBOP6Dj+0Aen+h0h6Tjb5Cv09zinzy+nc?=
 =?us-ascii?Q?HIBFcH3AJ046sZUYKy/uI8iDHUGe1P5Q9yc5MAdOa10CWax3YJctWlEO9XIJ?=
 =?us-ascii?Q?tX8qWIcSWaZ9HwUuXtyMJp2/LHVQTwLrqtTNdvzM8n2ckXJxJXA0qs8/hk9s?=
 =?us-ascii?Q?cBtZE/wQJtIF9jEsXo3epOxJTd6/DWCTeXZKpsmaQ93m/oxGsFfSypa6LdAm?=
 =?us-ascii?Q?K/Eoe6j2fdCSTehHZoAdE2E3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5263.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb478399-0eb8-42be-9f3e-08d915be137d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 03:20:36.2544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tWT8X+cT+ZgYqpPS12041Rcctn1lUwLEc/FDm2+tPcDbKRtMt4ZJ+s7QfytwfEPe+FIBIgUtLKEZIYoIbfLbuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5400
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - Internal Distribution Only]



> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Wednesday, May 12, 2021 5:06 PM
> To: Joshi, Mukul <Mukul.Joshi@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Kasiviswanathan, Harish
> <Harish.Kasiviswanathan@amd.com>; x86-ml <x86@kernel.org>; lkml <linux-
> kernel@vger.kernel.org>
> Subject: Re: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
>=20
> [CAUTION: External Email]
>=20
> On Wed, May 12, 2021 at 07:00:58PM +0000, Joshi, Mukul wrote:
> > SMCA UMCv2 corresponds to GPU's UMC MCA bank and the GPU driver is
> > only interested in errors on GPU UMC.
>=20
> So that thing should be called SMCA_GPU_UMC not SMCA_UMC_V2.
>=20
> > We cannot know this without is_smca_umc_v2.
>=20
> You don't need it - just export smca_get_bank_type() and test the bank ty=
pe at
> the call site.

Exporting smca_get_bank_type() works fine when CONFIG_X86_MCE_AMD is define=
d.
I would need to put #ifdef CONFIG_X86_MCE_AMD in my code to compile the amd=
gpu
driver when CONFIG_X86_MCE_AMD is not defined.
I can avoid all that by using is_smca_umc_v2().
I think it would be cleaner with using is_smca_umc_v2().

>=20
> > Maybe. I hope its not too much of a concern if it stays the way it is.
>=20
> That was just a suggestion anyway - it is not code I maintain so not my c=
all.
>=20
> > I wasn't really sure if I should use the EDAC priority here or create a=
 new one
> for Accelerator devices.
> > I thought using EDAC priority might not be accepted by the maintainers
> > as EDAC and GPU (Accelerator) devices are two different class of device=
s.
> > That is the reason I create a new one.
> > I am OK to use EDAC priority if that is acceptable.
>=20
> I don't know what's acceptable because I still am unclear as to what that=
 thing is
> supposed to do. It seems you are interested only in uncorrectable errors.
>=20

You can think of GPU device as a EDAC device here. It is mainly interested =
in
handling uncorrectable errors.

> How are those errors reported? #MC exception, deferred interrupt, simply
> logged in the bank and we find them by polling?
>=20

It is a deferred interrupt that generates an MCE.

> Then, the commit message is talking about some "bad page retirement".
> What does that do? What can the user do when she sees the
>=20
> "Uncorrectable error detected in UMC..."
>=20
> message?
>=20
> It depends on what "retiring" of GPU pages means...
>=20
> In any case, dmesg should issue a human-understandable message about the
> recovery action being done and what that means for the user: should she
> replace the GPU, should she ignore, etc, etc.
>

When an uncorrectable error is detected on the GPU UMC, all we are doing is=
=20
determining the physical address where the error occurred and then "retirin=
g"
the page that address belongs to.
By retiring, we mean we reserve the page so that it is not available for al=
locations
to any applications.
We are providing information to the user by storing all the information abo=
ut the
retired pages in EEPROM. This can be accessed through sysfs.

Hope it clears what "bad page retirement" is achieving.

Thanks,
Mukul

> > A system can have multiple GPUs and we only want a single notifier
> > registered. I will change the comment to explicitly state this.
>=20
> Actually, the notifier registration should be able to return a different =
retval to
> state that a callback has already been registered but that warns only cur=
rently so
> I'm guessing we're stuck with such ugly "workarounds" for their shortcomi=
ngs.
>=20
> I'm gonna take a look whether they can be fixed though so that you don't =
have
> to do this notifier_registered thing.
>=20
> --
> Regards/Gruss,
>     Boris.
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeopl=
e.
> kernel.org%2Ftglx%2Fnotes-about-
> netiquette&amp;data=3D04%7C01%7CMukul.Joshi%40amd.com%7C5e305845504
> 14bc53c3008d91589b50b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0
> %7C637564503481206042%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata
> =3DfF2iaSQxAREAV2OwLi%2F8cN9uRuqNNKim2FpWJUBQS98%3D&amp;reserved=3D
> 0
