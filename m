Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096A33F764F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 15:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240708AbhHYNvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 09:51:42 -0400
Received: from mail-bn8nam12on2076.outbound.protection.outlook.com ([40.107.237.76]:12512
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240646AbhHYNvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 09:51:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiYGllf/5gcC42c6GA1ye93CM1JYlqF3xICifzNK/OnEWp5+dxJ562PT3eCmtk6MCJ2t2IPjKPU23mtRydGDimtgX705Iz8eknvT2rwSS6jNixBkdb6dDskMP8nF9OD6OnM9T3P5zD4jGFkTBc109UMuzcAU5P4oXRB24R5im1Et0iGG3YdZasw21vSHh0NaPjyu2RtJqlxric+8PmpWPZqc5AEhe+cP74rdMfPw+87OmEp5eoIXs5YA2z3gKZel4xa+mbn586SZn1lqbwnqaVdt/KSxs3AYPfgjh0QbNQ39wQMxGOdozflUmbtf+I0HQXWSZ2tu3RJGJvCLtv+KsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7o9qmJbDtrj5n3bgt1Sugx9z8Df8TU1jOVwqBjU+CeY=;
 b=WopsUGD9v3Ik9bKOvoI74zr4GpYAD09iTejspIT0qzbBYwJGoLakXSkU/fw4qOE2jE4nuHYtkO8grsWkWA+uFkok6TXuCB7SNC2J9NF6T+1+G5KY5c5wjEGdmRA6Uu4zzAbb0hf4QwF0xy79f27mPi0yqxTWUpkpt8LvXutoaSCzECBpPAs2Ujfunqqr46yyULhyGK/2ihsO8cz25RKkEMVVBXvHy7IpDDt7L+FmC0hTk+8uiD4UVSnftRBbABCpurwj+0NVSFaBBv7TxUMMFZhC9Uwn5b+1MOdcvjKTLbdQ6zie5UFzmMRHpgQG+Vvok0d/S5s+LwAUuBUsQ2D3Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7o9qmJbDtrj5n3bgt1Sugx9z8Df8TU1jOVwqBjU+CeY=;
 b=aTuhZrmPE1Yk8oT4G8S8e/9FT1igF9BWsIw69E8rNOl4Oco2vNOuI7ejsxJHdNxQZf+ZGYdrUdtHkbb+9gapAja7pxmwokd5qvZNHGtEhwRJQjPVdC+UAASDHM3533cwvC+UBNqUXIvFAguTtnd/1XTrCs8qgvCMn7tHhbzv+zg=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Wed, 25 Aug
 2021 13:50:48 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5%4]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 13:50:48 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>
CC:     "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liu, Kun" <Kun.Liu2@amd.com>
Subject: RE: [RESEND PATCH 2/2] usb: dwc3: pci add property to allow user
 space role switch
Thread-Topic: [RESEND PATCH 2/2] usb: dwc3: pci add property to allow user
 space role switch
Thread-Index: AQHXmR2YdRDA9Lmp5UiDkYimjN6dIauDuXCAgAASRoCAAAcAAIAAanig
Date:   Wed, 25 Aug 2021 13:50:48 +0000
Message-ID: <BL1PR12MB51443C94208DDE0AEBCB91A6F7C69@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20210824192337.3100288-1-Nehal-Bakulchandra.shah@amd.com>
 <87ilzu5ap0.fsf@kernel.org> <YSXqsXmuom2fFiKN@kuha.fi.intel.com>
 <YSXwkKJ53d/uwnhy@kuha.fi.intel.com>
In-Reply-To: <YSXwkKJ53d/uwnhy@kuha.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-25T13:50:42Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=178e2769-45e8-4a5f-9478-47c20cbe0fc9;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3654468-1a41-4f4e-aae4-08d967cf580d
x-ms-traffictypediagnostic: BL1PR12MB5269:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5269AA6E3F751022858D1A11F7C69@BL1PR12MB5269.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hiRPHo9ZaRdpVlnQCAXaubh+mL0bW9MvA/ZOHcDSyJ0oPHe/aR92iZnYDUzB0LnonN4WVW50CFScEEJZR1CNubiGzQF7hTIEi8xlDNgO6WzkKIKsZU5gh2z8GRbDEYDfbV6ZtOGz/18XRUTDjGuRU0Or02KVY/ARcB90QJOmwJWHBM3gaiHCm18of/JwOSZbx50nls3mNKi4Ew4yHV0948XHb/3d8qM0BacGrwHqSND5ajvw0AI7YMd3RhhMG3vghe9/LomxBzXyO5ZYOG0Sm3CVqUhEdQ/JfGvqEJfMwQmwRjG/hW5fER7hUN+RB6w1hv+sOKqlpJOwKIoj3H/PByxtu3zlsMklfu00vZsuTUuV0/9OMEueS+kQ5+UraFix4W6vkeGxLji1DHNTj9RIOdOtKDuasIg+cLOuGWJkBtkaNCecJ0jM67YFHvjjnyhjpd4UAp1OiSdpPMTXeqSyttw2pA5ecVRQseFd+lIMnBCjFjyksFNOOPnJoqlHH3gak7cl9FxUcjrlplOnIAT4/hcTGnqJ6Cq2RNjihjg5mZv2YebFZxOHOyq9IsNpTuQQlAlYfffG5CivhU8yLIKDYA7ewnnkPGg3UjLZE9H0c1IWq+AaqQAuaxxwhu0VUFSnWpPv34/yZ9k0M34++KzViPtxhX0/YoqotDNepibDMqtTWuLfz6r3a1fj0bIIu09zTw0v3ri/5uU5wakI5r6S+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(6506007)(83380400001)(76116006)(55016002)(66946007)(9686003)(64756008)(122000001)(53546011)(26005)(66476007)(2906002)(66446008)(38100700002)(66556008)(54906003)(86362001)(8676002)(71200400001)(33656002)(4326008)(186003)(316002)(478600001)(8936002)(38070700005)(5660300002)(7696005)(110136005)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6B7EaWZ1PPzjqe4KC7EEZOlTJ4AiV0DJrFOu8rrifMeivJPrCSik+gsyBhcK?=
 =?us-ascii?Q?emcvUrKSvOxsh8jTi3rai/CZ2MA3wS+FEqbeurKvZVPAk7M7cVIRP2VcXVfS?=
 =?us-ascii?Q?7Gv6R1rR9b1M2kPypkmDJW1TZdaS7yejiD/Tx127q8K6Qy+BliPck0LcBQDY?=
 =?us-ascii?Q?uwWuQ55JaxPaEC8Li6hFtbUlJfnfFmLTGgiRhxrdeRI5fxtLMQmCr52Gd4Uh?=
 =?us-ascii?Q?bxAx5DK4jtS/GY+AihtAwcW+Ate4pVVfzzagG3NAKL22otllqAUVcMG1/dTJ?=
 =?us-ascii?Q?OMgPchwWNraUryRm2OGPgKx/w4JkmOOpkcfvB5szzJhU1xnp/81xM1m13vdS?=
 =?us-ascii?Q?568GzCK2lWQWoH9uVZU6A5xJ1O1UwB6B6gwjNp9iat5PhN/5tU8e/7B8Bmq1?=
 =?us-ascii?Q?Dysh9FGs9efCiS/dvlcxJYRg496ffuHvNGp8g0lE+vbhm2GJ9aI4v+HTI7eK?=
 =?us-ascii?Q?CRrIUCLrIqlVmisItoO39VM8HR5tePOniDvfNq+dIXc77i8nr7pFcgIfmIND?=
 =?us-ascii?Q?/1Xvk0BBQVbvBy9ax/uk2TubmXcthY3H1md/RgSS/Bzlgksp8lvDTUJMmku2?=
 =?us-ascii?Q?uGzoq4v6+vtNVSgOpcSz+Qwh/vwb/q2NpZwvaMA6GTnSEAvJmhYrhRkmahlT?=
 =?us-ascii?Q?X526LOrNIvSLDl+RgHkjNphnj20s+UYBtOgv6z/kunVZWqfw4ewG5M3vt8sk?=
 =?us-ascii?Q?i6Q7X8UhHdwef4VhDjiJDMxbmIPCMNVQT3znp+T7Jugj0/2RQVA61XAkkS0s?=
 =?us-ascii?Q?KhMX3CNnkpof16G91k3P6SEkivJSxNeGdlbQ88+g14GLZRD/IskGqyUI5XUV?=
 =?us-ascii?Q?ft0EHESsDyp/xkiU4/zqatkq229kRy7HaA6O5oS4QDkzQ6O3jFrKD3wS5K8N?=
 =?us-ascii?Q?tNXymLif4F2vCQZatuPIW6C/LsIcPDhX/ccIvEvyBxritpDRUN0ofTD46tCS?=
 =?us-ascii?Q?gO99W9e2hGYJVD9f9B1ea4RlD1QRexZGLthKgRgcmrwNeOCR2ioMcRR6Sr00?=
 =?us-ascii?Q?lpDXOy0OyRTXYgcxUa3gcu+33lDrSyeISDhIF6SKZ7JfZVvMWsh90Ho9Zw0m?=
 =?us-ascii?Q?eMDlbqjpse8lv9w8pn9b43S4R5fKhk6oxc2lsZM0j+Q8y/KugMqqA0+yVVL5?=
 =?us-ascii?Q?O+WKGPA5SL5jAvOhcL7c/Hve/qXDghSLNpvs2FMEUfq61diCoHoy5avDZJQX?=
 =?us-ascii?Q?07Dbb47xs9UqZkyhWPwT1AHoaVaq6lxiuDU7ut/QcVkorcCnjN+x5J1+Xxte?=
 =?us-ascii?Q?+/iW071cX0sYE1B+mof/sKDcrMH5UQDmBj9/GTWJ5pOzEVATbYROWKoJUM5D?=
 =?us-ascii?Q?M4TiOENLRDnw79gKQBQ+0ftq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3654468-1a41-4f4e-aae4-08d967cf580d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 13:50:48.1075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O0tNeFl8A1Yqp+8vYsVRgjQQCVEL4xK+zmREi7M6Ge3duOyRH5j2KKXG9vNPxUtXD2aD84F2EIu7yC1m2BwQOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5269
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]

> -----Original Message-----
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Sent: Wednesday, August 25, 2021 3:26 AM
> To: Felipe Balbi <balbi@kernel.org>
> Cc: Shah, Nehal-bakulchandra <Nehal-bakulchandra.Shah@amd.com>;
> gregkh@linuxfoundation.org; linux-usb@vger.kernel.org; linux-
> kernel@vger.kernel.org; Liu, Kun <Kun.Liu2@amd.com>; Deucher,
> Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [RESEND PATCH 2/2] usb: dwc3: pci add property to allow user
> space role switch
>=20
> On Wed, Aug 25, 2021 at 10:01:05AM +0300, Heikki Krogerus wrote:
> > On Wed, Aug 25, 2021 at 08:55:41AM +0300, Felipe Balbi wrote:
> > >
> > > Hi,
> > >
> > > Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com> writes:
> > >
> > > > For AMD platform there is a requirement to enable user space role
> > > > switch from host to device and device to host as customer platform
> > > > is not completely capable of OTG i.e. with type C controller it
> > > > does not have PD to support role switching. Hence, based ACPI/EC
> > > > interrupt role switch is triggered by the usemode script running in
> background.
> > >                    usermode ?
> >
> > Couldn't you capture that ACPI/EC interrupt in kernel?
> >
> > > > Signed-off-by: Nehal Bakulchandra Shah
> > > > <Nehal-Bakulchandra.shah@amd.com>
> > >
> > > I'm okay with this, just wondering if we need to Document the
> > > property somewhere.
> > >
> > > @Heikki, is there a place to document these private properties
> > > that's not on DT binding document?
> >
> > The build-in properties are not documented separately. I've always
> > tried to supply DT bindings for all new properties I've proposed.
> >
> > In this case though, do we need the new property at all? Why not just
> > register a normal USB role switch on this platform? It can be either a
> > dummy role switch that only passes the user space input to dwc3, or,
> > perhaps ideally, it would also be a driver that captures that ACPI/EC
> > event/notification and then passes the information from it to dwc3.
>=20
> Please ignore the above question. Sorry. Let me try again...
>=20
> The question is: why not just capture that ACPI/EC "interrupt" in kernel =
and
> then just use that information to set the dwc3 role switch?
> No extra properties needed.

I'm not a USB expert, but I think the idea was to pop up a message asking t=
he user what role they wanted when they plugged in USB cable?  Then based o=
n their input, the role could be changed.

Alex
