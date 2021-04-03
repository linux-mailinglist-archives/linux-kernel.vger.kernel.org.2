Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E3A35359E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 00:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbhDCWGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 18:06:52 -0400
Received: from mail-eopbgr1410133.outbound.protection.outlook.com ([40.107.141.133]:31462
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236672AbhDCWGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 18:06:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1ttBz1eg6ELdeOkOxX0vjXP1njLcjI49TqlM7UKbnVwZJNr2fvK7pnihrfO5PaMhUi7kqJexWqarUZ3juAc8/twWMXFXPdqMOyadqrddDepZmUW6p82pfcohWqYIbAo7xJdsRD0/XVhxT7MwVQFTIfSvUZr93m6PJhD3zIXp+6jrwfBGrKPJVOWLfZsQLvtnGKaUmEi2fOYBjfRyleGkd6HdIhIoSozL3VcQjwVEQIv5Slt6EvpN4MAJuFtqL3iQmei/CbMW+3vZG4VHvZncSd+BNJSbBik10sOzBFMfYRJ707fFSZOdr/ST92wbm6gy6xGfpgAKvHGiBGNfZWuLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNinq2tFmoOA2zkpoqRraF7CkfOrx5eeCyEFAAPGvUI=;
 b=UDfectcRpZi2BUlQ8L4Qeu77eKh5P9KZ2uIenNcNw046JtD6u6kaCi9rplJZCvS/mpc/JeIkJiEJMo/Ss3Epb13l3H59t08QhgqDeRaOFG1WhwvYi7esG9SPrslWPvhKlhDZqby2I4/vl4oxIcW6yerY3jtM1FYgjvP7MIOJHZV33a5iIFg/Oed7uUwOp+A2nt15Y9UGRreeWGUNtbVT7cwIp3PNj18kXmniPIr3S0EPXZikQUlG1yiDO6G3pR1eNXr9eDcgdqbOT/XDgUDkBQJjmzCmSn3jhHZ3IDm21yoxjaT6hLbJSlLNC7pjWyJbUZSMSMMXkyDPUZrJ8EXW3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNinq2tFmoOA2zkpoqRraF7CkfOrx5eeCyEFAAPGvUI=;
 b=ab5p97S2r5SPI5TWYVGQo2XbIsfYsEVTYxbNFdhQN50U4CMjm/On4LE0md0rCP2tM27VoGAlZPViIAm5LPcki3+tBYH65eZlGKd7y8IqhxlWAYbQbUQ76s31QxxFU9JrYFL38CrUd/C7tspvLTK2jfO+JsEl5Y43XneLudcTGHY=
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com (2603:1096:604:7a::23)
 by OSAPR01MB3555.jpnprd01.prod.outlook.com (2603:1096:604:58::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Sat, 3 Apr
 2021 22:06:45 +0000
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433]) by OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433%7]) with mapi id 15.20.3999.032; Sat, 3 Apr 2021
 22:06:44 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH next 2/2] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Thread-Topic: [PATCH next 2/2] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Thread-Index: AQHXIldpsgrgRGdFvEWwVoG1azV+EqqZUrkAgAHjPBCABhysAIACEyYg
Date:   Sat, 3 Apr 2021 22:06:43 +0000
Message-ID: <OSBPR01MB4773E81EFDC20F555DC0CB70BA799@OSBPR01MB4773.jpnprd01.prod.outlook.com>
References: <1616772851-29774-1-git-send-email-min.li.xe@renesas.com>
 <YGBy0LfM5z+8GCpU@kroah.com>
 <OSBPR01MB4773E0C511E724307E7A2C0DBA7E9@OSBPR01MB4773.jpnprd01.prod.outlook.com>
 <YGcouOYV/FlROZJv@kroah.com>
In-Reply-To: <YGcouOYV/FlROZJv@kroah.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41a52e4f-4fdb-4870-4d51-08d8f6ecc47b
x-ms-traffictypediagnostic: OSAPR01MB3555:
x-microsoft-antispam-prvs: <OSAPR01MB35556E53238B9C21AB806DA8BA799@OSAPR01MB3555.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PXDD5gfQEt08Alknn4sDdciSiuB7EAK/2RRS3C+lY1mdGHAXzAcssDvAjoOaL5didAx3j82vaawXbxDcrRYvkneoRXEx9K+YQx/GiGFVf2/IplVoGM6ATuiCfil1hDluvUx0rl2LSiEAKcU1kPQKV8Tb21yeI+2ucb9SpUQ7YwciRudoxSzFSUJ9iwZjaTu5ygluJKzq4YcUaPpiha051ItVKUfglcs+s+LB1LjGy9rpSO55RA0aYyWcPD0k0WunVmx23y3glJPugbDBdJDGgtpfige4mN9Fdql+3PzcOAi1JjoCK138SoGtyudgY0xus/ELylk1JG4eRwK5CTLeWZpWGINJKwfWJYwwgLfPeXCuvSNhnbSR79QeEkdPi0HlQAQGzUE1iQWM9vFFWQ5Ms3cpMnC7fi1bWxcYU/J7Ce/BqklSAFpoLFCqv7x1AY3gIPfTw5yhQKWcAbfFlvyGB2PbOMdoeIZCnp4FhnVTofH+BOCRMhL4e3v7jQzJKyrjoORwyOC0diH/rSeRPyAv78Wx73RFGaTUIyPP7hmdLbOD72EyMwxtl9ySepQljDl3FBvmFu4pyifgrx2I4wVydWepp0ABfxMFAMLsdYM5uGkm+HlhjPxcGLj9XkA1cBhXSF8vVe+4sEXxj90FgLgrjL8r2GuOmRq+OPbCdNkzDVE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4773.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(52536014)(4744005)(478600001)(7696005)(55016002)(9686003)(71200400001)(86362001)(6506007)(5660300002)(186003)(66946007)(8936002)(33656002)(76116006)(26005)(6916009)(66476007)(38100700001)(2906002)(66556008)(4326008)(64756008)(66446008)(8676002)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?aL+H4v9CGdNwvvU+K6nzpaQg8xwiN0Islx57O8i1Zun6I+A4liYSYg+aMsCS?=
 =?us-ascii?Q?AEGlid/mYXe6w58Syo+9e9+JIpkpUykqBgqb7s5uAH1vt743p9ktH4HhPpJV?=
 =?us-ascii?Q?BJmTrBvEMOghizQXj9D+eURMRpm3Ipwo7JgCk37Wi87bUoLEBG3JySUq9n1S?=
 =?us-ascii?Q?6X5odhD2HXAS9WweDTEjGeb6bU445tJtB2ulNnzbXRPYFBHWCI1CY5cLNdeW?=
 =?us-ascii?Q?gVJF9yDoGtpUfPuWUHAMSbXdYHoqSXF9LvP+ClnHq7NR5HB8WdhqiwcovXYl?=
 =?us-ascii?Q?283hymAqIAiQM3TsekrUq8rfreiI5p0w/BBysY+tZlIaKPK684o1H6Gzgl4p?=
 =?us-ascii?Q?IP0MFenzpEiG2Kyu09KYw9Jvghzf8XQ7CSK+uCyAHDsmD69lRIVVPaEM07kD?=
 =?us-ascii?Q?Yrehzy1ugtWzD7W176XXExY0dlVPoaOzoJwl8jQNDuSAPqkL0tGUz31asFPw?=
 =?us-ascii?Q?POQU7O0jX9B2kCDIUehCfSF55iEuQ9qWMHOSl3IWQs7f6hOviJ5zTTZtVo+o?=
 =?us-ascii?Q?egK+PPzu+UNFdn34/XUGvBUWSh7P5n3B2BJ1t9Mixoh1kVfYVzoaFLrTu6C5?=
 =?us-ascii?Q?VgWGrfVdTZF9SZjZBde3dwIIC5Rslu1gQ+O9n3Erfl7grR775T6llqwvyaZH?=
 =?us-ascii?Q?mjDYvxRS68F84AaLYjHGjj95aI9LuaVVMRDbZd1F9eHrGDNyy2ewCut3ZF3H?=
 =?us-ascii?Q?c9hBhSYVm+hLicHGEpOUq40+mYyJ4HWruorrHPDnVbhtE7gTuinVbNMhxqJh?=
 =?us-ascii?Q?LXBPmy9oJk8co+lAGPZ5JINnUrlQTk98UjTYPcTRUutm/eGmkGcc+jUHubTU?=
 =?us-ascii?Q?HQTcad0yjRSR6eFBkyoa8yAflzY0lkXi1KMmmPGeSpXwzhS2JERndSh7WdID?=
 =?us-ascii?Q?ZyW4lFxid3UjtvNt65STeMbqe5HT/SO5JblZJjJ/iPpPejCSQtVcn1p3Vl6/?=
 =?us-ascii?Q?uBmYi0ojL2ID09BP13uvBOsouebCuhSipgXgW+Dw8LqYUDrnJtoCT2ra5mXk?=
 =?us-ascii?Q?FycqDUDceuuK3TRt3CTda1z6Y9lwSKs3O0QQ99JpDySjLpMfAHczjkP4dyCN?=
 =?us-ascii?Q?3fpnlBMaJyPHur70TwHaj1FTVpsbA3/Djs2Lmaq/8HKh0ISmGoMJiW5mLa1q?=
 =?us-ascii?Q?xrb2M8IcLPWHctyzwZebojxpzrQmca/CYwg8ZHffTKJxIZm+fbhKXAeVMVbd?=
 =?us-ascii?Q?l+2YaXtj1UN9x0CbVbFPQJC4WsEMgmcoingByMuH/JOPUF4l2AwVBrRoSoKL?=
 =?us-ascii?Q?vBQU815dpMMYL7Hy4zfcrHajdrJzJ8ndV8ZTvFVcpm5IFsllIgcrjIdNGMXt?=
 =?us-ascii?Q?sLC90dA9QATcsttaQ2Rhk+Mb?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4773.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a52e4f-4fdb-4870-4d51-08d8f6ecc47b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2021 22:06:43.7577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lv1nNlhfoVwR69u7/dS8qrdJdyVMd/ivYNNrirHrWYUX7VY+15VI7qH/u9GVLIbA161fQ3TUxrXvTWk09U4Tlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3555
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>=20
> Then the patches are independant and they should be sent as such,
> otherwise it causes confusion and our tools get messed up when trying to
> grab the whole "series" of patches.
>=20
> Can you please fix this up and just send two independant patches?
>=20

Hi Greg

These 2 patches are not independent. Patch 2/2 depends on patch 1/2 to buil=
d and work successfully.
They just belong to different domain, patch 1/2 belongs to MFD while patch =
2/2 belongs to MISC.
That is why I wasn't sure if I should send both patches to you in the first=
 place. Anyways, I just sent both patches again.

Thanks

Min
