Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFEC40DE18
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 17:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238632AbhIPPek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 11:34:40 -0400
Received: from mail-eopbgr1410138.outbound.protection.outlook.com ([40.107.141.138]:64398
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239727AbhIPPea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 11:34:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HI9n1eaB9QoQRZnmrenbt1GNznCCPKSkTYM8wj66n5i7IT9oysW3GVS7ZURbUkU5eITwk+6sA0O+AsviitVYF7NCyeYzaqsC9Z5PW2axSSKhQddiLLrAp76/XjG2DqKagQkTktZj+xDNyxRZl0UnDIzBpY6wScgbtDWR0iH601Mcf0l6Qxpsx8TDpH+iOipt51iVeDufl3SIAO8GR3H+Lv62mpa6kuCUJl7A/h/ftfuBgOhXF3tJcFPUR1prdaJDYLTWpQs8qQ1vo8NPOcbdqFS26sPm0sMLE/+ggvWESAmjOpZESronxX8KiN9C3z8bCgbUXPhpxXimAKoNsg6gpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=g9DB2Ve4nxMPfLhzQCj1gHdaGfmJ2clG5SL/NVHCZwo=;
 b=Vg9xmEkaMu0bOZ2lHeTzEsG/G9nB9f1JKE4D0mf7EDoknVmqhiVOj1JaZkAb3XVrA5MBn5Klwj/mYKmWYcXD7dml531oaHpHUpY3aWBDwwdk/FGBBMrhI3b5XU7+9fdylzlkl14jQxX/Y70Ycu1ErN79Zk8miNkjoCpVOJcRyViQsEcUJAA5ozBxc/a00HbnuXPuYjtlbrzfDq/SO/RsBMKDSifSQ0yb+wSgBokYUTDGKzF19DJOP3pDHqhVpbzTmqC4ylcYRfMIBCG0sCHKoqbQScmKZKfJZ2BEa+eJialSxRYudvMUOBZj4rX0g5BTJPNg1VBgyKOH4eqqqcU+mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9DB2Ve4nxMPfLhzQCj1gHdaGfmJ2clG5SL/NVHCZwo=;
 b=kRD48CKMKXISihRy9/J2oUHDVneXrDynuJeQ3UolfWjjrCtD7eR5DH4GZKaKF0oKrPKBOVeWerLObVoFPXFKIhDIcaiX7g2nCkCkojn443cInpG/SMbnbxnsUq8oSPhlK9yPLFXdAIU/tBNyYn9wt3c/3QI85IwPyuKtNu7euJQ=
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com (2603:1096:604:101::7)
 by OS0PR01MB5299.jpnprd01.prod.outlook.com (2603:1096:604:a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Thu, 16 Sep
 2021 15:33:07 +0000
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::84ad:ad49:6f8:1312]) by OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::84ad:ad49:6f8:1312%5]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 15:33:07 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lee.jones@linaro.or" <lee.jones@linaro.or>
Subject: RE: [PATCH misc v2 2/2] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Thread-Topic: [PATCH misc v2 2/2] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Thread-Index: AQHXqmIqGzfEPA/ASUKU/78egiaTO6umId8AgACkSYA=
Date:   Thu, 16 Sep 2021 15:33:06 +0000
Message-ID: <OS3PR01MB659340151F61C6ABA2D9043BBADC9@OS3PR01MB6593.jpnprd01.prod.outlook.com>
References: <1631731629-20862-1-git-send-email-min.li.xe@renesas.com>
 <1631731629-20862-2-git-send-email-min.li.xe@renesas.com>
 <YULVYrvUM+JQils9@kroah.com>
In-Reply-To: <YULVYrvUM+JQils9@kroah.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5233c2ac-9033-4c10-58ae-08d97927481e
x-ms-traffictypediagnostic: OS0PR01MB5299:
x-microsoft-antispam-prvs: <OS0PR01MB5299A62480BCB48FF20FCA8BBADC9@OS0PR01MB5299.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: au1qh9CAXznZTtMZfR/KL11i3yHFFVJeyiX9v36gCUv/te0ndPIpzAAiJ0NRt2rE1L5VQkhHbuSgjh2TT0fHRWO/aLunJj50rtfc885riE4R53xn/bYR8rzKLuS2z1wcO6wlX8RcdI1FMsCOukpT5c7o6ahg9RT3TrpgvkTDnFc/tqpURimYOHAfWziIx8cXuHTXvdpqh6wjneNNijiOc/H5R8cwOeFxwJ6dezLgTSeR15maWMrepnnpgCWqAegIeAzv7UJY5InAjESNPyyaqsJgDUYk3+sUyfZ28cJstnePwYnsSC4MejJEw1YVvDxx9ibZhI1IHjruM6mnIDQol3/yEKATBlldT4WwIcOuSPGPjMogpfVubZQy1whaAGOrwQHD6FSnuhJHBaue29EM6EXq8sbOC9id3uixDRpwBqueSSH+/YH12S/EAqklpNRLyfoV+IEVnsWe76EAoBNFmtxtyutxqIDUEXNFXWzykj/APKGGuQHlrgOq53rofjlBWT5tL+W20/7DoSE8HPWB2WrYSFCMWtys/dtvCOx1YNso/o/aaXPbC8vX1DlFm29uN/JaS0zvO2Pmvlm2WKSnB8Ot9aCMlK0nI5SjPOCn2WYE3lP3Pt1XyPcKWdefSIpsdh+Wy2bZCds/57+s+xGNswLjlvERkRPIwwDAC8/7Wid6NrN3YSCLQfUtwr3As0iCuzfGHLbMZfmidzLu5wK9gwIVdq2EOEPg8o9vmXDNDHzv5J1g48/LYoV0EIRo6ZGvm0VfeXJMnQDTOqjRRvLdCB/4R/Jsf9M/QWte7CcqehQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6593.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(966005)(83380400001)(2906002)(8936002)(4326008)(8676002)(38100700002)(54906003)(122000001)(55016002)(9686003)(38070700005)(316002)(6916009)(53546011)(6506007)(7696005)(26005)(33656002)(76116006)(64756008)(5660300002)(86362001)(52536014)(66946007)(66476007)(66446008)(66556008)(186003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nz8ZfnkoKIxhbqT3B1O9ubyqI2Fe5TIKXZNvabREyZhh6CtvosF9PjPF0G2q?=
 =?us-ascii?Q?z/x1IkFn9wOpfL5EOMBCuHOU+T0IcNFZljBXom3wXzxTjQBon+yr4RpjKqGu?=
 =?us-ascii?Q?SyPPukrzdlC5tpuSdjqhzXbtvUs+md7jlbc3RDQoSaSUEZFMi3HK8aMWxh06?=
 =?us-ascii?Q?C1V3WILjIU2PsKM5xHwRYqZNu9rgrtPRMYgKnBYOA447mN9xDQmkOhJEA3Z1?=
 =?us-ascii?Q?9HiM4bsnkLuFFnduMEmlEcFGShiU3gvKJ4d8M8zAI54roB0W1c0vdFgKPvuL?=
 =?us-ascii?Q?K9QQm4M6sWJ50ixQqVXnTNclydeSEEob2xYm16u/SIIQRznT5mXwi916tm8f?=
 =?us-ascii?Q?5w0W1+gDG7uRo+dXk8QJ3FdAPFnl2k3DdLIBt+xVSCce4/1WVSTxtezSYRFz?=
 =?us-ascii?Q?g4mikuE5q9g+Su1Emsrw07LCPe9qJgrT9Ih0oh8OUWhczxdCAYkAwp+I1A8J?=
 =?us-ascii?Q?OFAWWY5+LFS7btEUwxID9eFmsENk9ZmiwVM2Q3nkosixwEZzHKtjw32ud2sd?=
 =?us-ascii?Q?XCvBKCiRCKZNkFpdtNHXfv7BhwJTFyNiy5tsVu7WS2gopI39BaIK7rGkhdwP?=
 =?us-ascii?Q?XUKslEzfmJY9gkSHeDoQO/wCT0mLLmB/WXLN4aynLmbgOFdXMtvooYQB/fNG?=
 =?us-ascii?Q?R82OTJj99kBk5sIjGEJQ8rJBlbEMbdCRBp1wOJqHgOnkXyTlVy0nuRoe7AzB?=
 =?us-ascii?Q?H5nwmjCCnoBCD6ajcmPUAmuTDtEOydMHtG4714SHSR9XnqgHwv8QpnzDl82J?=
 =?us-ascii?Q?rq3q6nGFjkI5oPXTl0AfTyhRLTflpS1R1py5VDxNMbJHWUwgqLNj38aTk+eZ?=
 =?us-ascii?Q?C1xd2qHZ7gTcxqcVcgVduOlV2e8tZkqhpTGoi9893lv6vd6Y9UCKI5kCtYKJ?=
 =?us-ascii?Q?Nl3fnIwSk1iIcKQIKu2TBtcqeBaSDbQN84bPB8dVM21wTLh8vgSOEf1CSb+7?=
 =?us-ascii?Q?FTkzm1NOZETDzKm2S0Q04FJ9aOamk52qcUiXIdB8DscL+w6LJBXTKxpXYXrS?=
 =?us-ascii?Q?74gX9ZW02hHqbrNL/dHZMlznQiqevvGnCgGN03w5/XJ7iHce5vwJzzwhL6LB?=
 =?us-ascii?Q?VyfUDvzkfjLZLk3KMA7yEsbxcpOi9CTD/dD8GFr/XLmWr/iEnmvIsfPQtyde?=
 =?us-ascii?Q?XEfW7EMC7Ts29xhzpl7QGwAbGwDjyZlnaVuqK1r4BXRMsFzrReqZj+usXzmT?=
 =?us-ascii?Q?8HFoJSAx4d+lYctGaPcO023599Dn3VSdegzQPPdvddmJjy8NHN8oGZCqULi2?=
 =?us-ascii?Q?/0tyCfCnMIxJeW5S8avKhyQCim4s4A1mFsWGMtJLlpeEwRqQCrNMzlewO823?=
 =?us-ascii?Q?rpVBfNIHU0r3vUiAVAgjN2lM?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6593.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5233c2ac-9033-4c10-58ae-08d97927481e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 15:33:06.6993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: efAE6YIhF3kikqPt920WIvsk0sPjpbKjxQKjsoBNS6D6rfAbWH8cc6pDtEJb3Pe7borKedaRCN23maWEHQcaxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5299
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: September 16, 2021 1:26 AM
> To: Min Li <min.li.xe@renesas.com>
> Cc: arnd@arndb.de; derek.kiernan@xilinx.com; dragan.cvetic@xilinx.com;
> linux-kernel@vger.kernel.org; lee.jones@linaro.or
> Subject: Re: [PATCH misc v2 2/2] misc: Add Renesas Synchronization
> Management Unit (SMU) support
>=20
> On Wed, Sep 15, 2021 at 02:47:09PM -0400, min.li.xe@renesas.com wrote:
> > From: Min Li <min.li.xe@renesas.com>
> >
> > This driver is developed for the IDT ClockMatrix(TM) and 82P33xxx
> > families of timing and synchronization devices.It will be used by
> > Renesas PTP Clock Manager for Linux (pcm4l) software to provide
> > support to GNSS assisted partial timing support (APTS) and other
> networking timing functions.
>=20
> Where is that software?

https://www.renesas.com/us/en/software-tool/ptp-clock-manager-linux

>=20
> Why is this new api not a standard one?
>=20

There is no actual standard for the GNSS assisted partial timing support (A=
PTS)
In terms of Linux kernel API

> What is the standard here?
>=20
> What do other devices do and why is this a new api?
>=20

There is really no standard for APTS and different company has its own hw/s=
w solutions

> > Current version provides kernel API's to support the following
> > functions -set combomode to enable SYNCE clock support -read dpll's
> > state to determine if the dpll is locked to the GNSS channel -read
> > dpll's ffo (fractional frequency offset) in ppqt
>=20
> Why do all of these have to be in the kernel at all?
>=20

Because all these API's need spi/i2c accesses to the RSMU card and spi/i2c =
accesses have been
abstracted to the MFD driver in kernel

> thanks,
>=20
> greg k-h
