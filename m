Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6962436E36D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 04:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236582AbhD2Cy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 22:54:58 -0400
Received: from mail-dm6nam11on2060.outbound.protection.outlook.com ([40.107.223.60]:27361
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229718AbhD2Cy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 22:54:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzAigfDUhh0c3MZnkIuGLqyxtBCgWd9pAYNMkABi9gaAo8jpyZlnyBXHPpmO6Zird4m6igw82zTt2Ad9x+GegXszs1ecEeFit5Lo6NynCBkO/2qQ4TRfZ+xpwINLitjPT12h5ZJzJOscb1eF/rrO6KYB424Wdx9L78oWkkqyhddgR0eLecAKSL2RDQlJsbqH3lbEMUeQkiIrT56ufWZnLCToJo+V4n+xbZM78J4i+0GmzWgkP3OsGaEr9ACuf/qr9wKmmlR1m5pvQC8LV1Pugz+9YSshCaEAkClyWMVfOjfcXz2UAiNnbk86+moLrnlDDzB9D3HQ7Gd91hVk4pogLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cR2FEsVHpBLBoczf0YaqYgki8lguMzmek0oV/d6Wv3k=;
 b=dg4I1q0f2z1wI6b1/D2KHVlhIDjLamRaGZfYwUqQfJjm2hK9Eubo860RFLgzDn4dyMVKEyWwnyYXyfQBQiNP322/3j81vQcm0/MOcjG1u2TY9y0jsjfCHzEiVgKCe3E0Yrfs4L+ZihDbeBChWDKq3ZvXG02Q215V9pM/m/p1VrlGe5ZYP8/4UpCgc+X3BBCL0HzaTJvV7r5GX77ke6Ph6RJvK74Lw45U/g7EqU6O+C9zopVgIf00Jf9Rmgy7tBKzmxqjmZ9mvKoDKA5N7/dZyLpkoTRi4/FR5rfyLC0MP76rYFNwlIvkKjKJL+Wx5d3ZvIPiytnX/j9qY7C2XBFUHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cR2FEsVHpBLBoczf0YaqYgki8lguMzmek0oV/d6Wv3k=;
 b=CpYjxSmagfaX4jSXV6kqMfrvjS+Z7UVNtPLW6PLFIHFExcES0o2AFgr3f87i1UmWilubDOiA2N7nlPEw2oBbFrC57Xuob6R7Udk1VWL91mJ5DVu2pxf+OmQHcC2vbAay/BAsc596rNNmsyr9EdOHp5UGKYoung0k4/d+EHU4wao=
Received: from CO1PR11MB4882.namprd11.prod.outlook.com (2603:10b6:303:97::8)
 by MWHPR1101MB2125.namprd11.prod.outlook.com (2603:10b6:301:4d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 29 Apr
 2021 02:54:09 +0000
Received: from CO1PR11MB4882.namprd11.prod.outlook.com
 ([fe80::b5f9:c24e:b517:1ebe]) by CO1PR11MB4882.namprd11.prod.outlook.com
 ([fe80::b5f9:c24e:b517:1ebe%6]) with mapi id 15.20.4065.029; Thu, 29 Apr 2021
 02:54:09 +0000
From:   Tung Pham <Tung.Pham@silabs.com>
To:     Johan Hovold <johan@kernel.org>
CC:     Pho Tran <photranvan0712@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hung Nguyen <Hung.Nguyen@silabs.com>,
        Pho Tran <Pho.Tran@silabs.com>
Subject: RE: [PATCH v9] USB: serial: cp210x: Add support for GPIOs on CP2108
Thread-Topic: [PATCH v9] USB: serial: cp210x: Add support for GPIOs on CP2108
Thread-Index: AQHXLGMGgD5ujxjcJE2fqPf1pL8/T6q/IwwAgAd+plCAAyljgIABG1ag
Date:   Thu, 29 Apr 2021 02:54:09 +0000
Message-ID: <CO1PR11MB4882A90461E033F8EA301C07815F9@CO1PR11MB4882.namprd11.prod.outlook.com>
References: <20210408103607.2077-1-photranvan0712@gmail.com>
 <YIA8HD0S6C+x5ZC9@hovoldconsulting.com>
 <CO1PR11MB48829DEA0747C1B19278868E81429@CO1PR11MB4882.namprd11.prod.outlook.com>
 <YIksjb9IjOwSpPgw@hovoldconsulting.com>
In-Reply-To: <YIksjb9IjOwSpPgw@hovoldconsulting.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=silabs.com;
x-originating-ip: [1.55.242.165]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cad23a9e-895b-440c-a941-08d90aba0fa0
x-ms-traffictypediagnostic: MWHPR1101MB2125:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB21258F4A0F82C0F879EADBF6815F9@MWHPR1101MB2125.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DsDHhNoAorJXH68GLqjCErOYD5beF/1b8knEGGnB4VewryGB+Ms0GJ/nZD/8TPFDczzSWx/mzl1Kq6ycQ5TnrfF8N2Gj7BnXnrBtJ4rBFTqC9nMhEzni3JfMCS9P1GtcSgWKjr06qd3xQgQYazYhnMRpqGz//KC4nfyQl3B9Q7E06zRDyuIba7bfojaEXrRJ4nR90P47TBSAqbWXVbd0pIhNCrWtYbBi9HnPkT056JAtPuPRb8B9X11AjKdHGullPP615NqNcRYAobLqNX4eD9d4lMW2F3Utld/z6rIgKJxIl0IV5B+zgOGTXJYw5m9bA9gXENRDK4wjYsG2mm+601CF7Lnfx/CMlFE8GBHHC+LGtJtsphoCi6TAvS4acoYhbaax1EHH5guECR2LxVuAv5wxo2B9mm75qx9tgZDXLOQ4+bv3hqxBV0lVl/ioc3U7vQDRYMjqkLo3sU4Y9WPt/MHJRC0ao489BfzYL1LQOb6Srm043KmYuZldOO7qaJnuB0jZ5/i/GltCkTYBOgGF2deRr2lxN4wi6O1ujFlv6WuqS8r0UgjrqxZA+wXz5Q6gWdJUoxWVb28YObHAM/ZtvBVEgJDDp0Im7lJOEMKEYrzQrJoaftGzGOlaH2UfIL+EcJWQ9pm0A+f+dOjZLET9aNR/Lc0U/mp6x/ua9zsdzYm3V14IUB+K9m2i1D4bBzIJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4882.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(39850400004)(136003)(396003)(71200400001)(55016002)(9686003)(122000001)(38100700002)(26005)(4326008)(6506007)(7696005)(6916009)(966005)(186003)(66446008)(33656002)(83380400001)(66556008)(66476007)(66946007)(2906002)(76116006)(64756008)(5660300002)(8936002)(8676002)(54906003)(52536014)(107886003)(316002)(478600001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?rFcF2SX6OCgi/kCQexhgCPMMA6kvp1e7cFOwOVMqxJ92RXwzN08dCeKyKMdg?=
 =?us-ascii?Q?K2RcKOvtwzEQdKT4185GgRB4moLN9041+YLJipkiKLTxfLSnynks+mbbnwOJ?=
 =?us-ascii?Q?3jO3R3XwSaN5OXRPCC6X6lqAqp2cOf/qSrJwDCankoJqAZwqLW8k2nMlQX/a?=
 =?us-ascii?Q?jFCZu5pn+DkOC9Cd/d2lvZvRFKft0bINjimpskQ25FShyHfN+Lw8mbfGlebW?=
 =?us-ascii?Q?Q5jatyGz3GEozHRSk+UrHlqfL/nbuHQGkF+iqQTNJ+1PjfasPBgQ/P8/AWWq?=
 =?us-ascii?Q?VMl9EMaUB5oJ+9x9EqAN1H3Uf3XI6vXYn3Z06atatYhJVoayRaQCvQWii6Q9?=
 =?us-ascii?Q?SioEeheyAjio5bQd0HaIIukG2dLth5YYT5YyAyofW0g2Aody9NiPLTuveQFX?=
 =?us-ascii?Q?4vgIqHNMR2qUVKOHKeivHOSKhoi1g1WGIidIi4AzQvtWdNrpuFnx5l91jke6?=
 =?us-ascii?Q?vXmkZzx/LcmcV2aiPrgVHBOyDwALOo+qrHKN6gyEubhBaIoEB1zrgiF7BLem?=
 =?us-ascii?Q?WfEPabM1vvIovdOHS9WRzs6h6f6YWft6NocIo61X8FxsQOcsLo1ateN/Zph+?=
 =?us-ascii?Q?W+yo3Tb8J6Zx5XgfnaDVvHkSScVfqnMbPu7swUUe0jXlSpQpFnG25Dc4pV5I?=
 =?us-ascii?Q?QnxbFkFFH/RWirjAA4Y8pUaFr+Vz4ykuJpDjxCGlzhLVdoF0J98lEdm6+SCe?=
 =?us-ascii?Q?RhD4PBVaiBj9bzqhrinnYams5MzTnmxUdUP8AL9Z4KDT1+X+A3R2BlmH2Kuu?=
 =?us-ascii?Q?BvZO/Z00R1ffvMg/b4KUn2CDbNxDU9AOyGONCgu6NbrFFO7RV3YehM36YPBj?=
 =?us-ascii?Q?gdttz0cfehjwMHjjLEZAwpyjTpmA4I0XNFah9DbfA56gT4/GkUwCMKGkzn3I?=
 =?us-ascii?Q?e33f7jZgDPOhUvPNbKCkkdVrzEBlxr6eEuguawlGbqCi/PvrubPZEd+bA4P+?=
 =?us-ascii?Q?MZQ58zgJNPc5NzrNfGgzxBmwlHkKLWcksp4KuVmLeqr74JN+srg7UTdt8aAJ?=
 =?us-ascii?Q?xVm2Uscvix3NMxaVxKw0kD18Az8mqqFHiv1qsHuFzCRpA9v0QeUtbhpU6Ny+?=
 =?us-ascii?Q?kzeDsrDSVKaKh7be78VaH7c2XRWF/7iQXFcHLCrProIvJZsCssGxXAsFQj5g?=
 =?us-ascii?Q?T2uxdut1Yxfb/60DlDSlG4BaZ8+mnrF1E7wpuZfrlDexcQmng5jLlGn26X+U?=
 =?us-ascii?Q?OJV9DZdepnkr/4sRnB0bePlmvpr1srscmRwh8cgah5Q5VRv5SDdlkTP5mVjA?=
 =?us-ascii?Q?dHKN6exb8VQt1SdpB9ArbYNY2zRLb6F5DzOPWAw9PewLEJdKOjJLqYO//8D2?=
 =?us-ascii?Q?nOA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4882.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cad23a9e-895b-440c-a941-08d90aba0fa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 02:54:09.0902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SKUxQ37klAmHaDTIAJr6+yKI1XrMs9PmBIzTaPvk0+zoBR9wv0S7n79ZO7HHY/Ncd5WLUHqHo2yZ6LBnVBiHxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2125
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Johan.
Thanks for your review of my code.
You can find my answer below in Tung Pham mark:

On Mon, Apr 26, 2021 at 09:49:37AM +0000, Tung Pham wrote:
> Dear Johan Hovold.
> Thanks for your review.
> I read you comment and answer you as following:
>
> On Thu, Apr 08, 2021 at 05:36:07PM +0700, Pho Tran wrote:
> > From: Pho Tran <pho.tran@silabs.com>
> >
> > Similar to other CP210x devices, GPIO interfaces (gpiochip) should=20
> > be supported for CP2108.
>
> > +/*
> > + * Quad Port Config definitions
> > + * Refer to
> > +https://www.silabs.com/documents/public/application-notes/an978-cp2
> > +10 x-usb-to-uart-api-specification.pdf
> > + * for more information.
> > + * CP210X_VENDOR_SPECIFIC, CP210X_GET_PORTCONFIG call reads these
> > +0x49 bytes
> > + * on a CP2108 chip.
> > + * CP2108 Quad Port State structure(used in Quad Port Config
> > +structure)  */ struct cp210x_quad_port_state {
> > +     __le16 gpio_mode_PB0;
> > +     __le16 gpio_mode_PB1;
> > +     __le16 gpio_mode_PB2;
> > +     __le16 gpio_mode_PB3;
> > +     __le16 gpio_mode_PB4;
> > +
> > +
> > +     __le16 gpio_lowpower_PB0;
> > +     __le16 gpio_lowpower_PB1;
> > +     __le16 gpio_lowpower_PB2;
> > +     __le16 gpio_lowpower_PB3;
> > +     __le16 gpio_lowpower_PB4;
> > +
> > +     __le16 gpio_latch_PB0;
> > +     __le16 gpio_latch_PB1;
> > +     __le16 gpio_latch_PB2;
> > +     __le16 gpio_latch_PB3;
> > +     __le16 gpio_latch_PB4;
> > +};
> > +
> > +// Cp2108 Quad Port Config structure struct cp210x_quad_port_config=20
> > +{
> > +     struct cp210x_quad_port_state reset_state;
> > +     struct cp210x_quad_port_state suspend_state;
> > +     u8 ipdelay_IFC[4];
> > +     u8 enhancedfxn_IFC[4];
> > +     u8 enhancedfxn_device;
> > +     u8 extclkfreq[4];
> > +} __packed;
>
> One more thing; I noticed that the layout of the other port-config=20
> structures do not match the ones used by your library API, which is=20
> what the above pdf documents (e.g. they have additional padding).
>
> Tung Pham: the layout is correct, the document add padding bit to
> align data to 8 or 16 bit, we already use      __le16, so the data is
> aligned to 16 bit.

Not sure I understand what you're saying here.

My point was simply that the layout of the other structures as expected by =
the device doesn't match the layout described in you library API documentat=
ion.

It doesn't appear to have anything to do with member alignment, it just loo=
ks like random unused bits in the structures. Take the single-port config, =
for example:

        struct cp210x_single_port_config {
                __le16  gpio_mode;
                u8      __pad0[2];
                __le16  reset_state;
                u8      __pad1[4];
                __le16  suspend_state;
                u8      device_cfg;
        } __packed;

You library API has this as:

        typedef struct _PORT_CONFIG
        {
                uint16_t Mode;
                uint16_t Reset_Latch;
                uint16_t Suspend_Latch;
                unsigned char EnhancedFxn;
        } PORT_CONFIG, *PPORT_CONFIG;

which simply doesn't match up (and there's no implicit padding between memb=
ers, only after EnhancedFxn).

So my questions again are:

 1) Have you verified that the struct cp210x_quad_port_config above
    actually matches what the device uses?

 2) Do you have any documentation of the structures as expected by the
    device firmware (not your library)?


Tung Pham: the device return some unused bytes, and manufacturing library a=
lready discard these byte to assign value to PORT_CONFIG, so you don't see =
padding byte on PORT_CONFIG structure.   you can find the structure  of por=
t setting in this code:=20

https://www.silabs.com/documents/public/software/USBXpressHostSDK-Linux.tar


\USBXpressHostSDK-Linux\USBXpressHostSDK\CP210x\srcpkg\cp210xmanufacturing_=
1.0.tar\cp210xmanufacturing_1.0\cp210xmanufacturing\cp210xmanufacturing\src=
\CP2104Device.cpp

CP210x_STATUS CCP2104Device::GetPortConfig(PORT_CONFIG* PortConfig)


> Did you verify that the above layout is actually correct? And did you=20
> try changing the pin functions in EEPROM and make sure that your code=20
> handles it as expected?
>
> Tung Pham: we have tested to toggle GPIO pin in normal case, we will=20
> test the case that the gpio have alternative function in the future.

Great, this could be one way of verifying the above. Please do that and let=
 me know the result.

That part of the code has already been found broken twice during review so =
you really should have tested this before submitting.

> Is there any corresponding document for the actual device protocol?
> Tung Pham:
> You can refer to
> https://www.silabs.com/documents/public/data-sheets/cp2108-datasheet.p
> df for understanding the functionality of cp2108.
> And
> https://www.silabs.com/documents/public/application-notes/AN721.pdf
> for use simplicity software to configure the GPIO pin alternative functio=
n of cp2108.

Ok, but those do not document the layout of these structures either (e.g. c=
p210x_single_port_config with the __pad0 and __pad1 members).

Johan

Tung Pham
