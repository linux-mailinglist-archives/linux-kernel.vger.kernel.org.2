Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7223631A1F9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 16:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhBLPpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 10:45:45 -0500
Received: from mail-eopbgr1400138.outbound.protection.outlook.com ([40.107.140.138]:53249
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229574AbhBLPpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 10:45:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6uElf7FdIlJWNrzYvXiYUmgwT5P2QeEoylZzJahqLtN1/5eRoUEO5PvPrlU7hFbpydym1GGsKp3JszGje6hGvbmLtGWWo++NKshejwZVzjsqQZVI2E8ZuWeGpBJpDhUcWGUX38TSmVkZEqevkhDhmHQzbsn0mIt29HBdpnSA2aNEZpZGwCRUTNYVv6VdKUogwmfOV5eSw81ukwc3vmKRc0Y2dxKzgB/4aJ6+ldY4i2Hbmrghe4BZJHD/P6D9JAK10liUlcmdHobfMN3NWVJEVHP2sWY5rKgyQLGZfihGsWX+hiLNnPhIWKwzNHXuZMenpE4qzvVk5qpxjvkBBD+sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9eROCzeRRIKGowf7pzVTK3IshMUazFgIrUZ1vFtn0E=;
 b=kQAFuutOmVVfumnfRBY3eShojbSAEgP42l/72eXXi4M6SYPhBO+dzHovVJY56yUH93azpy4XHnE1Fd67qmBcl/mrfFa/IYl0EK2LjPuqxdycQ6+/iPPGaKFa2lzsU5EkISx6K7ySnS909kWn7sHxhGwDkU2V4lGYK73tWga2M6527L9qs9Q7LJVkMFIDSsFiC5zP2Rbf4VwHNVaqYcc5BUglYcuwdBxo5zxlImdJPHxg/JLTMSIx21Dyg4CUruiN6iVDlfei0gs5vWWPqKvEMSQTJH4xGjlBzs8gjt4eSoCoQstr9JpEoY45ERSEymtk7Up9XsU+Q7TXNIasLd2CYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9eROCzeRRIKGowf7pzVTK3IshMUazFgIrUZ1vFtn0E=;
 b=oNG69vwZuswUaYZBr88+AxvWMiLytPSPxUeTm8yg23kqymxA15NsHzCwRoSb5/us6OXTkJEqxDAGf7uxrpEES3aV9AxKxANwBq3yozOh9papCaRaTSEI4hNy7MKe6SiX0RmaVzScI+FMIxDlWGDlrEEx/fJ2mCCTLY9FINaGq/I=
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com (2603:1096:604:7a::23)
 by OSAPR01MB2580.jpnprd01.prod.outlook.com (2603:1096:603:3c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.31; Fri, 12 Feb
 2021 15:44:52 +0000
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::1971:336c:e4c0:8c5]) by OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::1971:336c:e4c0:8c5%3]) with mapi id 15.20.3846.029; Fri, 12 Feb 2021
 15:44:52 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Thread-Topic: [PATCH net-next v2] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Thread-Index: AQHXANy3Kc3xxVsbt0Wl/bCSqSMNqapUIuqAgACGZWA=
Date:   Fri, 12 Feb 2021 15:44:52 +0000
Message-ID: <OSBPR01MB4773472EE0C8D34456C79121BA8B9@OSBPR01MB4773.jpnprd01.prod.outlook.com>
References: <1613092575-17311-1-git-send-email-min.li.xe@renesas.com>
 <YCYw5xXe16fSj6eI@kroah.com>
In-Reply-To: <YCYw5xXe16fSj6eI@kroah.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1f592421-a80d-40a8-bb2e-08d8cf6d2382
x-ms-traffictypediagnostic: OSAPR01MB2580:
x-microsoft-antispam-prvs: <OSAPR01MB2580F260827CB3C878C40906BA8B9@OSAPR01MB2580.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wF4dR2cg5CpwqiyjpIjd4x1OVPPwCyMQY+Xb+sZ7AKccURp9UiYmjlBdLl3awR9yaULpYv4JoJPrvECmRF3YqtjQHp7BUPoG7vHb6Nd49IJSMS1Oh94qI0hEoFMPrBesvh9VckNp4leZ0u/nhLgXz6OQUkB5xFdZ6v3HkRGlQ2KZZZOygKdRltDLQYcYy+WLgHhPOdwquoZ1PARliwIVhvrh2+Ek8Q0eBKAX8mGGKDwtzI90RhKnnj8tGv63N1YOWRE2T8yBXdzQ4qnAakrEe9QG1mOetmX3o2PwVEkIJRoO0RoU09tKbn8iQz0t1FdCnVsnqaYeYHfa5ihgl0Ut4qPmbHbheLruHGn4I6bYkXacW40nV2QumEArBlAl9dcUFjJ6Zl6lzBfKAsBHv0gj59OvoyUsSY39Aa38u5wLf0zeHYUkZppbyOpiaLDVtx92RjLQuG3yOP/W2JZk35m4bhfugS6yhpMUE+BwYsZmBQeRfeLdDdni3EoZSie/odWUVhlgPsRSgj8xghV+DtRAUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4773.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(396003)(346002)(39850400004)(76116006)(2906002)(4744005)(6916009)(83380400001)(86362001)(478600001)(66476007)(71200400001)(33656002)(4326008)(52536014)(66446008)(8936002)(26005)(8676002)(186003)(6506007)(7696005)(9686003)(66556008)(54906003)(316002)(5660300002)(64756008)(55016002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?hm+H33HL5L9Ov7LY83fnv8tpLa8jchyU/aGhdm/3jWHXJvv9gjP5r5bhEHEQ?=
 =?us-ascii?Q?QV33pWdobuuv9TdIYMyZ0eflH+AO3NSeMeK2dN6gtzcdEPNjqiZiedFEZYLo?=
 =?us-ascii?Q?yY+7sts5IFep2qneyoBA4VZukBP8WjUKD4PAMa20V5Gs4E93UTpJlyqe88vf?=
 =?us-ascii?Q?PMTdTN7IdZjXVD9Gkug9dNZzDlSDa3tF6Y+t0KvXZONzN3Dqm/g2RaGfM7KI?=
 =?us-ascii?Q?gSwflYZ1HXr3zxcu3rnm7DG7Dyvl+GeDnr+9EBlDgYIaUGDmZaAyEanlYOWM?=
 =?us-ascii?Q?Ech6c0FUID7IQ2V8+Ct3yy4IrSywgVYi8vehUT825vJHXr7KiPY58wdzn1oq?=
 =?us-ascii?Q?wBrpFkXl13MI6T4HOOxZmFXSaRciJAs138BR5UtySDjTOffA4C8aVzfAg0H5?=
 =?us-ascii?Q?FR73f/eGtwh17AcS0Hl/qubksEaxKtQnrjbA9vjaZkSMS+FUnbnbBYIVi65r?=
 =?us-ascii?Q?H3WmfblDRM4WIWmM3AzUWbwMMJ0Oc24GxBqcY9TVdIOE3OI3nbT4WBcqw7ia?=
 =?us-ascii?Q?jC+Kc+RzSvYdzn1USe9OTaJKCMMw1Jrp/+uosG7qpv6KBY2riYqSHFyJ8Cgl?=
 =?us-ascii?Q?yKBAtk+JhccAgbMuFKCGhaqFV25BfTS/yzWcvXJdo9rTuNivpQVdgyqEiGN+?=
 =?us-ascii?Q?U8xjJN7dqA6ZJxK06IiBs7+IETvBbpbvJ8NUhRo+3cd+e95wIw4ea9NxGTJ+?=
 =?us-ascii?Q?ERQ60TBj01l5kXfADzLksa7ojyn290CLoWvLLlHEjgHiiuQhAHDI66AbWkEg?=
 =?us-ascii?Q?r7uZyZ/JGColm6SKiSFoQhHpmBI2izBYcEP8cFzrM3ubg6FQQmLE4PbfVVze?=
 =?us-ascii?Q?C8Z73KIaOmGJ4AFrsVGGLFkTPlgMVwjoKOw5Tbpx2lSHrfQTUEf035yFf9VJ?=
 =?us-ascii?Q?8PI9c66BhtuV9UYOlPiQXF7SyBgrb1VjO6RLVdz1Cj25GlrYeX7zFoMt4woI?=
 =?us-ascii?Q?JMYAkknIwVekikhJg7d9QtSzz6wRkLjt+NkQzOrzNBXsjRPHMglD6hj06+dw?=
 =?us-ascii?Q?qRWDaQXI1UNzQ0wnE0Dc3Eh7qfoX+At/z0ck0nblq9wRVqlPgUZUfFJNCAb1?=
 =?us-ascii?Q?JqImFw+1a2ddBvCvr6aSKD4qbFxF+JVApyRGrDvOULDJTInnAeuRpaahPRqA?=
 =?us-ascii?Q?SDTs9Z/Uzgv18uG6V6eeaG+mLANfAlI3S3sRTGgSnDE/PvKKXD+xQ1JdAxKV?=
 =?us-ascii?Q?ygSCCZJolzA3M1ANtLnw0nnEaJ9oyACtmN653RpVdLWis9XutSyoN2jmbSTC?=
 =?us-ascii?Q?XSzSz0LdhRqkeHVeF5kvgLmPzV0LjJ6+8EiQj2jzKTAyD4kmTSxqN7kPtbBY?=
 =?us-ascii?Q?PBPvVh3vNLvqgclmpkeovQob?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4773.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f592421-a80d-40a8-bb2e-08d8cf6d2382
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2021 15:44:52.6080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LIwY96fXhYNcvES3R/G+8m8taeMpzemlqzeryqaF2Zmefa+Y1izY4lqaF29X/2Qh6o2CbllgdTga/e19A/G+sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2580
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > -set combomode
> > -get dpll's state
> > -get dpll's ffo
> >
> > This driver must work with Renesas MFD driver to access SMU through
> > I2C/SPI.
> >
> > Changes since v1:
> > -Provide more background for purpose of the change.
> > -Provide compat_ioctl support
> > -Fix ioctl cmd definition
>=20
> This "changes" list goes below the --- line.
>=20

Sorry, is this a problem that you are requesting me to address? I am bit co=
nfused...

> And you seem to have ignored my review, especially about documenting the
> sysfs files here, please do that as I can not accept this patch as-is.
>=20

If I come up with an rsmu.rst under Documentation/driver-api, is that somet=
hing you are looking for?
