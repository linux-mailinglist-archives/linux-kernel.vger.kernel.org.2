Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0662B40B963
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 22:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbhINUpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 16:45:16 -0400
Received: from mail-eopbgr1410109.outbound.protection.outlook.com ([40.107.141.109]:12005
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233145AbhINUpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 16:45:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkLuziaZaMBe7RiDCJYH8xBVcJiuOz8A3Ih9OvRcf3DBuJOc4RnRohRiHD6/WGD2XLP8sDYMkSN5DqS3uj8xSS346du9Tr/No/u6UBPaW2fI12bKqJJgQzNz9wsdL534/2vfE6SNt1jdY1feX1tcfrWmdJ/EPiRYchzOlLp3QqW7mnLXmkBR3a0ORKULQNhUfANlHnmuWIImJRrF+j+RF6YCQbXVYLyTabuCk6B5gUevbqS7VG+gclLuBljva+2DJv7EtwXYvsT6+AB6juXuvHnK2EQ0EGoGS/ZYhiva/DGIfl8pMYr1Kd3bHy+VX5T+LoWK6V3aEhtM/vcbBHdAYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=LbOkYA3NOywxDgwQstGEBv8OB6EgGTLy1r2gD7/KDvY=;
 b=AljZgAvH+2cBitM6sFcN1B0dr9Vvln2L0NFaGEP3KV3O4ITwbpp3kF7EI5xIQmvqjxZdkY0YVAN+q4LPAHo8tt4/5XTxAty+9zILvYuv8S4crZQFsVHWdZLDC2i88Y7YuHFZ2MOeF4poon273qxAdQRAfBkdqtvSDlvnzwW2V2N0Vm1Ihyz4+IQb+9YVGLS869qwiPBwDEoWRZ7KkfjAIkpdZT0ZAxA63Ex5CzopGD0cr/6Hts0B1jy3m7AdTY9RApXEck2vW/tXCNnurSdH//MRrasP8TXueQIa1w/rc/hzI36VqZCPaPOpJ/V0ylArj9TrxsYq5mrsA8cUmR/LMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbOkYA3NOywxDgwQstGEBv8OB6EgGTLy1r2gD7/KDvY=;
 b=OM9ce+XuUu/1j+D1sk5IpkMepgkvaOzP5P645Yo8hHAdUQFGnpO4rWDuDO3su5L1fcFTqW7NrmFwzuPF5/L0rgh2q5Q5M1FO2mJiyYQ5dXIh+Y5zYY0Q9h6Ft+u/oAWXOJL5IeZMPL45KteoXQvHX75nYQ+gs1nCH43i4VM54Fo=
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com (2603:1096:604:101::7)
 by OSBPR01MB4534.jpnprd01.prod.outlook.com (2603:1096:604:78::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.19; Tue, 14 Sep
 2021 20:43:45 +0000
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::84ad:ad49:6f8:1312]) by OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::84ad:ad49:6f8:1312%5]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 20:43:45 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH misc] misc: Add Renesas Synchronization Management Unit
 (SMU) support
Thread-Topic: [PATCH misc] misc: Add Renesas Synchronization Management Unit
 (SMU) support
Thread-Index: AQHXoCrWcPCOZLcVpEOu9zHAf9JJVKujT1SAgAC5dCA=
Date:   Tue, 14 Sep 2021 20:43:44 +0000
Message-ID: <OS3PR01MB6593057EA6257006C7228542BADA9@OS3PR01MB6593.jpnprd01.prod.outlook.com>
References: <1630608353-7606-1-git-send-email-min.li.xe@renesas.com>
 <YUBmIWU6HwIjjeXa@kroah.com>
In-Reply-To: <YUBmIWU6HwIjjeXa@kroah.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16585984-c254-4d27-8678-08d977c05889
x-ms-traffictypediagnostic: OSBPR01MB4534:
x-microsoft-antispam-prvs: <OSBPR01MB453477B5CEF82979B6BE32DBBADA9@OSBPR01MB4534.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rYPMp3Bz6qBjUlBH2b5Z2xv4LJUSCR8s3q6v05NvtRdypB3Oc2yiIGPRvzWoMx0TwjATc6vwdcFPNTscLguCRzYowkh6Oc/GdBIshhrPfA84ts+Yrnp2F/9a+JmjGvlz3Ilq++Gu6Vf2aC0gMvY/IEXgjK+lpHURh3+vHvCRZTGalrLsntDZGchsRVgWzjpABKf6OwFh/nss5sFGfHOcVne/8oRphv1kZ2IvfJjn1ajR6gr4ShVkxydwaY6vlhNc2IEdJzu5Fccj1hQgrS90/Z4etBjF8jWCNv0kejJRN9ZJ3razRIFDuEYoVYPXVkpbt+z0+Oluc5s5JiZ6Nbh3WdVm3pm6o9EvuGI3Fog3LWyiMSmXCR3Ptjo9AEuJ3tH1acHhZngIS73zePkh0WdQPjktLjXN2KSjI8gGy4E6UvwF9oZ52z9GMnSDTKEIqp13TdNLFU+vc29B3FTOvXlnhd7z24ZX/arOflo4kRHNYve4JKb0TKW+zSq9uot3jCKH8xqGiR08jLDl4tDxA7JQTIa57OHZuzAk2bmu4Zvbnzu45A6JlAve0s/cVal1Rf7erR8/jYJ2XU5gra6T3U5G3fW5ZerGtaipV90vKqWQMnGl+JesQLU6nmL8FAnnHvyPBoHzcpGeVsrvp0TnRZ2tpjCzXfHYuydXwvUASfvL1Tn+rDioQ7iMYiR8ij4Y1PSEyzKRzdSahlA8AMrPjwTMaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6593.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(9686003)(55016002)(86362001)(2906002)(478600001)(33656002)(8676002)(66446008)(64756008)(66556008)(26005)(4326008)(7696005)(38070700005)(186003)(66476007)(54906003)(8936002)(52536014)(6916009)(122000001)(316002)(38100700002)(83380400001)(5660300002)(76116006)(66946007)(71200400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?17GMFEWdhHLAsXTr3E+NOXA/sOhGJYE9sJvOq+ILI0SlGjmymixTsQw+rquj?=
 =?us-ascii?Q?y40Gsd11D43nZ/29Uzc3KnVBY922AW6KFdLXg8csZZIRjeWNf6pTgthSQUOJ?=
 =?us-ascii?Q?BCNL0EbMNPdtNX1b2tEBCET0kA0Vc00jpOBI5KQtjPPJDpdYU1OCQyxIutDJ?=
 =?us-ascii?Q?BquUBHYv/AnoZNcdGjxowLnQyKDTS22Cjn/k1XtIaN1eXW9WDQoyxAUSURCo?=
 =?us-ascii?Q?iCfTVu7hCHQrRUGkvoZal1mQCoEyBFsL9qZLniXjBpl2o060/3+zvDCY77Cm?=
 =?us-ascii?Q?NkPjZymbm35XY8CWLEE8zNGRrngbK0TAroY7gxqZfOmuUZN6TXjzm1p2J0Yh?=
 =?us-ascii?Q?vE4Bi2R5AuXcTwE2mVcYojggITHJPnrQdFM2LSU1tEyvVSw0MgUY9LSPVJ1Y?=
 =?us-ascii?Q?4+v7wxj05CFY5DsZdRqW9QJO5Yku0LW5TUm4NV+OLb40i9u2qi0cKGTLt02+?=
 =?us-ascii?Q?AsMIsohoVf0J5jDJGpjTuAbq9Lx1WDq+5sti8bwFNQLtrimz/PSBY0gR3+pi?=
 =?us-ascii?Q?2Km/5qfmJQN1WRZ/v12LOKbAhUFWxFBti5dlNatsWve26N4/Mc8Zbkdr0jOz?=
 =?us-ascii?Q?jLK46GOpzCQCQLw6ajj6gaKXep5SLdxP1gxU/zNJ4wd2gWU4FJGeYrjuN+Ok?=
 =?us-ascii?Q?ZmMrUkASXqKv+ahnN7xtisUtEuUN+KovoMbaCfz4iisnQZEpV37/uD+o8QII?=
 =?us-ascii?Q?ounSCIpi3yS96eqp8Hafwv9Ivrj3ur8m40wztUsAQJi542G9MYMPQFE2F0oK?=
 =?us-ascii?Q?MQetN++V7jcB8p+fXGPQ/7adH30sjNZ2wPCUKahy1ta1bMU8fi5GrrKMOVA1?=
 =?us-ascii?Q?UnK0MrDKnRma7VaYMn5c7jc7gv+X/UYI2pnaCfyjaDlUxBWO8Y5aYin0CYhk?=
 =?us-ascii?Q?AAX4HnOKDD7VHE6h2zQ19WFj5eOTo9aHDHOscDFJx/Gq3KRgLKgp3mWlJYCu?=
 =?us-ascii?Q?EAME9VXXOEITsmN3NjYUQ3wNuIlhxUZHkDwxpcGQTnbZl0AKoAIMuyKPuVCA?=
 =?us-ascii?Q?u0RLH6GAVOMRCRqZx3g1CtE6sUFtpQlKkzZK1MwW7iG8NS5+ma3kh/6lPC+s?=
 =?us-ascii?Q?QI7Jad6WSQCUNTXopzQ5ybWPn8VBEh0EChkL4tWBRBSVjI+lFjMFI7zqMI16?=
 =?us-ascii?Q?OHGgwWUZ4Ubx8leG/PP01BYbDPB/sDS8rryxFb0f5kfoeO6EDf0DtZ1PR08r?=
 =?us-ascii?Q?Busc+Mg6XB1s5IXIvVX40mMjFX404Klz+veaRgKKHFMQ4HfwMpGtAGkAGTrT?=
 =?us-ascii?Q?lRfl24tHsXlEslY6AndgZqqlggEPmcr/FhV+ubMdHF1WFZorF5KSModI1ChV?=
 =?us-ascii?Q?77ntRJ8APFoDmVTDsAjDD4AK?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6593.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16585984-c254-4d27-8678-08d977c05889
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2021 20:43:44.9094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cDtElfKbklf3YfqUWyPGCpGtnoZ0MVfK6OY4K0sueLfStaVc9Nyxqe3AzoeoaoMWs6uEWyGTz7vEZw3df3qcXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4534
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

Thanks for the review

> >  drivers/misc/Kconfig      |   9 ++
> >  drivers/misc/Makefile     |   2 +
> >  drivers/misc/rsmu_cdev.c  | 239
> > ++++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/misc/rsmu_cdev.h  |  77 +++++++++++++++
> >  drivers/misc/rsmu_cm.c    | 164 +++++++++++++++++++++++++++++++
> >  drivers/misc/rsmu_sabre.c | 133 ++++++++++++++++++++++++++
>=20
> If you make this all one .c file, the .h file can go away and it will be =
much
> simpler in the end.  And will get rid of the global symbols.
>=20

That is doable. But <linux/mfd/idt8a340_reg.h> and <linux/mfd/idt82p33_reg.=
h> have naming confliction.
To make this change one file, I have to include both of them and therefore =
I have to change them to resolve
Conflicts. Can I include this=20

> >
> > +config RSMU
> > +	tristate "Renesas Synchronization Management Unit (SMU)"
> > +	help
> > +	  This option enables support for the IDT ClockMatrix(TM) and
> 82P33xxx
> > +	  families of timing and synchronization devices. It will be used by
> > +	  Renesas PTP Clock Manager for Linux (pcm4l) software to provide
> support
> > +	  for GNSS assisted partial timing support (APTS) and other
> networking
> > +	  timing functions.
>=20
> No driver name listed?

Sorry, what do you mean by driver name in this context?

>=20
> > diff --git a/drivers/misc/rsmu_cdev.c b/drivers/misc/rsmu_cdev.c new
> > file mode 100644 index 0000000..8e856a6
> > --- /dev/null
> > +++ b/drivers/misc/rsmu_cdev.c
> > @@ -0,0 +1,239 @@
> > +// SPDX-License-Identifier: GPL-2.0+
>=20
> Are you sure about "+"?  I have to ask.

All of our Linux kernel code have this license. I don't know what is the ca=
tch here.

> > +
> > +/**
> > + * struct rsmu_cdev - Driver data for RSMU character device
> > + * @name: rsmu device name as rsmu[index]
> > + * @dev: pointer to device
> > + * @mfd: pointer to MFD device
> > + * @miscdev: character device handle
> > + * @regmap: I2C/SPI regmap handle
> > + * @lock: mutex to protect operations from being interrupted
> > + * @type: rsmu device type, passed through platform data
> > + * @ops: rsmu device methods
> > + * @index: rsmu device index
> > + */
> > +struct rsmu_cdev {
> > +	char name[16];
> > +	struct device *dev;
>=20
> What device is this pointing to?

It is the platform device from rsmu_probe(struct platform_device *pdev)

>=20
> > +	struct device *mfd;
>=20
> What is this for?

It is the multi-functional device from driver/mfd/rsmu_core.c
The mfd driver is responsible for spawn this platform device and spi/i2c
bus access

> > +/*
> > + * RSMU IOCTL List
> > + */
> > +#define RSMU_MAGIC '?'
>=20
> Where did you get this value from?
>=20
> Where did you reserve it?

No I didn't reserve it. I checked other code and they all seem to use a ran=
dom character

>=20
> > +
> > +/**
> > + * @Description
>=20
> What is this format?  It is not kernel-doc :(
>=20
> > + * ioctl to set SMU combo mode.Combo mode provides physical layer
> > + frequency
> > + * support from the Ethernet Equipment Clock to the PTP clock
> > + *
> > + * @Parameters
>=20
> Same here and elsewhere in this file.

I was copying the format from xilinx_sdfec.h

Is there a place that tells me how to properly document ioctl or can you gi=
ve me an code example?

Thanks

Min
