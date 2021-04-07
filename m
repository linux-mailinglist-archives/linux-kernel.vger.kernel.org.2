Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5DD357596
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349187AbhDGUM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:12:27 -0400
Received: from mail-eopbgr1400099.outbound.protection.outlook.com ([40.107.140.99]:7808
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232431AbhDGUM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:12:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1TByRk+h5b1Lii5HronqNt/v2nOLEN9mv7OPB5di7YUhMxIMpy3ndyWlY2yu+ir9qp9Ga35YE0wW9mczj+J+0jY/E2eYD74YgqphLErPooB6SAbQeDDT0XpSqQybXLWtcFg/YjAUMkwZx/98LjqbiozA+zqHuhjTbkXlmol2h/2z881lzWJ9w8EjQxlzTOzx2+7nbEEhUKCXZt4mS74j1DOIQ41iwHI2FY1jKzQYMMe3eNFqyBXQLcYL/610r8UfCJnlfD2iR4Vv0TQzBfn2dJZ+zYB6+3hUDDNN5zfWIqk4r5rLKtysUACKUFEse2eJUJEjGcggws/fgxtTnFKBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/555MhVvMhhI76T9UsiHpXOemPjfQi+FHZXq/ivJDk=;
 b=X5pDhcevqa7PSmTivbcnNx5JMiL80diVIvcOk8QhQdDukLmz6GyyJJkl8z+9O+8sicHLUUk29IGbho4kB2wGrlTcAusFVKH41TO4+jNgFC1YSZJD7kRrKeB43zYOlm8EcValzTOry3ZoJqRtH1quyucFIkN86WbKMaVfqh4peiAENbbAHKFZIOy3UoKwQshb1XRk3oRDvlhRgPdxPHqp1/rNErz7RMOlo5WMznMRoRVfvctu9BgDHPtOV5Z9WzZMvaB7x9ToMaA2G/DLZyBC4D4zDTCHJVSDLBKPlRBOp7K1U7xnUfJU3APa3ZSmMqf7fy8ZrqE5QtilAyFFcX4XDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/555MhVvMhhI76T9UsiHpXOemPjfQi+FHZXq/ivJDk=;
 b=iZFcBthVlgkzdET6nyFjw6r6YPqL/miCoK45vOM5h+ckyQINLR0v196BuR+M8nZoCD/vTOcKXhdBCxF6npctneGKG3SFwdBOcqMyV1hDyiPfuW+E+T0jTs9dXAQ5QLa8tQdmtZTq6zz4K761kaCzndyBIga739bHM8R8B+8FzU8=
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com (2603:1096:604:7a::23)
 by OSAPR01MB5267.jpnprd01.prod.outlook.com (2603:1096:604:33::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Wed, 7 Apr
 2021 20:12:11 +0000
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433]) by OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433%7]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 20:12:11 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2 2/2] misc: Add Renesas Synchronization
 Management Unit (SMU) support
Thread-Topic: [PATCH net-next v2 2/2] misc: Add Renesas Synchronization
 Management Unit (SMU) support
Thread-Index: AQHXK9TmRDzfnJqVl0Sq9GK4xidseaqpVacAgAAkN3A=
Date:   Wed, 7 Apr 2021 20:12:10 +0000
Message-ID: <OSBPR01MB477360E86A8913D07759C1C8BA759@OSBPR01MB4773.jpnprd01.prod.outlook.com>
References: <1617816815-3785-1-git-send-email-min.li.xe@renesas.com>
 <1617816815-3785-2-git-send-email-min.li.xe@renesas.com>
 <YG3xKlSrOZvrIr3z@kroah.com>
In-Reply-To: <YG3xKlSrOZvrIr3z@kroah.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9d57727-119f-49bf-870d-08d8fa016d75
x-ms-traffictypediagnostic: OSAPR01MB5267:
x-microsoft-antispam-prvs: <OSAPR01MB52678B05ED7366D35AA2ED61BA759@OSAPR01MB5267.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ngNnWii49NMkE6jMobYVmAOn6Hk4hc4s2z3zZZKl1imfTHRd0tDTUH9RVg6ZnW6fVu1U5U7BZvYqLrE2Y3bYx20394KFzK6Tvpi6c0/93Pau5DNEaPatd8jr4wvdJV2feoWnXuhSyV2ou/6F81WVc4MQjB9JdYf1KKDTTlz5LbcvIr4EAT5GOUFafLgX7T8MTMwpxwCtkjlW/zth6WHJUqt07ccxsZzgrAeX6jzI/Jsm+vO8dHSm7JXHbLlzAlIaBXnoM5gXNV9UVQHZJBnq3QEoQrhhOrFgSDaySXcCOkWdN4tVcGZ7NCkH+CuQlmQzOQFwSSGwFUQV5yaTrWjTE2gDsFNlOZ7T+pOiHg8GQkx0AXXs59mlTb3CReM6ayRATynX0p8CmdFxmulan+qkbvi3EojbXvGrCnrhH65Gb/Y22SXsO28xXrm+yzhARRsD0lvr0cvxd286f2YjZTKXCH0T3YMZaIwVeUvell01M1oG+eTMQx47c2cSTHNz+mhOip3NL844ARKwZ5boJIm85M2VkmjNy+kEbe+pIEZn+p5mfmc5RasH7WkCBVeg/5HPaoanODLpQ9tsrI58OX3cTqhzyef8nOzEFg4CWiDQ+6fTLj0BoUURFkJJ2wwbY94zPrgmQFMIAJbj2tbYsamYEm0nqJPLDmWk/8qcJiFB2Tk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4773.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(4744005)(52536014)(5660300002)(316002)(6916009)(478600001)(33656002)(8936002)(4326008)(9686003)(54906003)(8676002)(55016002)(71200400001)(186003)(86362001)(26005)(2906002)(38100700001)(7696005)(76116006)(66446008)(66946007)(64756008)(83380400001)(66556008)(66476007)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?30boVJKt92HIqQalSvh+ATKDmA8blwqNwXydCwatRpmeVo565j1Oxr+rJR7G?=
 =?us-ascii?Q?OOEbnG06a4oRSpJXI4L40UnWkg7MbuzEjBde66h+byBsMi/8uSQ1oieYWhBi?=
 =?us-ascii?Q?IaVVv1LPDGfbHiYC6m28DJa188ZyhZUhhQ6AvVxFmufEntBZ99O3EQm3T/mk?=
 =?us-ascii?Q?1I7JTWSwUdbKQaPG7TS78JULg+xbadG5CfoKwdPm0rAq417TgzT0qOFStRN6?=
 =?us-ascii?Q?rVlc4uz6R/hUu4y3Zh9xOF+ej0pSSVm6nifvCfV5wbN7MJDtxdb1Bt6PynYd?=
 =?us-ascii?Q?AAr0zAQ9Jo++4FHRWeqnvYvfMN6kpx5Fvn7wDAJ70tvArHGFFpGbcuuC1Bdl?=
 =?us-ascii?Q?h07vgSmyz7T641qo3xnqFJ3ZKifOFUmJ3whjOsNruM+RQ8ByqY50w70cMd/z?=
 =?us-ascii?Q?C3QMBI8KSPmr3CD2mMO6prU+6i2/ZPRa++rThmNxnRpy2pLNSHZnsX/1OH/F?=
 =?us-ascii?Q?ZrVS0MzuD0YjonvEu2s3P57EVBuKDI0EXxKFIDMZOc4vZ3cxy5+9BwMJKgm6?=
 =?us-ascii?Q?fJrEOrSmLPeP9dyF5+Mn9v99j3rsq4EINbsPrngWq3vI/6U3BPJs3bGyrNRw?=
 =?us-ascii?Q?dR5BiF36w+vR2Qkv+v8YBVE5EZyoG6ga1w27eNJkqgfP43AKy58trjqP40Ni?=
 =?us-ascii?Q?pY5LPQnPlga/veLlli7MVeKVXIqXQDbNmL8g2qQ4lXJmpe92dNL2CGasLf5R?=
 =?us-ascii?Q?hjkFyRn3Fbr8omFIgWO0EXFOtNSFJb8lSARkRFwQq2jlSpfJKJ9tQWtV2Fth?=
 =?us-ascii?Q?GBsLcdWklw50rZp5l/rJPzf8ubbBzu/MuC4/c9l2h5GN4cU2eYcN4nEOup6O?=
 =?us-ascii?Q?MYGuMGioWABoXhSobBOpeDl/CGDTD15arExfq/Y3kHhK8mYFX7iXi90XlXWe?=
 =?us-ascii?Q?w4k51ndbn1WrzP56PAFixeH0H+Ao2givmFtE2CAexE8MKEU8VPRck6Lhepm3?=
 =?us-ascii?Q?cVzXUhjCEr1q+LtuJ4jSb+t7tlEUQeWyF87ztscI6T7rQRa17cc6h3UIxM6v?=
 =?us-ascii?Q?uDaucsKDd2ny1CTTnCxekzNkPEzHrKG/5P8ezLoDhgHn6SBxmDjNV/ao9GiE?=
 =?us-ascii?Q?rDcG6ulpyqWacj6e9hB+Yls+bTSt1icvrVRbFsLIWTr8ia3DGrgpWi0ZK1hm?=
 =?us-ascii?Q?aWBVcnlME6n6+aRJA1SpQw5PnRiTIo6hjko6piBjzCB1Jvm8riHWJRnexAXf?=
 =?us-ascii?Q?Q36r5EXgBzd+NNDZBwVa2DVIAC4CKKInuv5Ype0rXFZbYws+vbn4WbvgvRbj?=
 =?us-ascii?Q?Ww4os+Rj+Xjr6eC8+cx4PVfDVvE27x76VCxHejl4KpCaX2qLxSap8r06C4cA?=
 =?us-ascii?Q?fHSdFJnOD70zinliFB/eZ+/y?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4773.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d57727-119f-49bf-870d-08d8fa016d75
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 20:12:10.9456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FRzWLNh04CMhRQ+NjG6+9PyJCuq6iK5ftmbb5pV/cXSwyDiTnUWgOSZS0yhz9wI02WHl4XaaEQj2ar12PFWsRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB5267
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> Why not use the miscdev name field?
>=20
miscdev name field is just a char pointer and I need an static array to man=
ipulate the name with index

>=20
> So it's a parent?  Why not make this a real platform_device pointer and n=
ot
> a device pointer?
>=20

It is not parent and mfd field is the parent

>=20
> What operations?
>=20

The MFD driver will create 2 devices, one is for phc driver and another one=
 is this driver.
The lock is to make sure these 2 driver's operations are synchronized.=20

>=20
> Index into what?
>=20

index is passed by mfd driver and will be used as part of device name such =
as "rsmu0"
