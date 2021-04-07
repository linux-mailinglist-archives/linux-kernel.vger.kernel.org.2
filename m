Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9709C357547
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 21:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348913AbhDGT4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 15:56:43 -0400
Received: from mail-eopbgr1400093.outbound.protection.outlook.com ([40.107.140.93]:4832
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1355788AbhDGT4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 15:56:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkXvaHv+zRbeHDMRfITzcO4gNbRO3OAEJWGGQoO1BMphoSrQYQFnPzoUYAJDnYfJR5KmQftBAzcJDkZKcARrYwhXH0c9i3vRLGFu/Ln5s0q87ijML71evLiRvWkt/007/KXb+Xph3p9xpMSgqP/KUfH9kua7cL+w6sJywQL0oYBwG4eOTALlEBzssRIgRAIjimm1hdQeSzYCIyoC83wjiIgUY48X49fqd8bN/OxiyH7XiJkbhkCLUQlBc2QTQcOLYh/zAKMk4EO7pyLstiV0jyWaixDMEfFLNpAjyi9hMrVQngcnOmS6DjAkuwBH9TiAFwb7utx62vWmA21fkb+/fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIuQVznldcD7e7XDzDtiMOk4HJyOiUb1RyVMK5T/Hgk=;
 b=SmIc6hy+a6AU7/g9DW+LwdMc/CKj4TZZSi5tB5VD3w7gLrHazKN9lJJEfbyjdGuOFbyuez03WEpx0EAceUmqFHKAWboG+kriY2nNYVIZ6B5Q0rfoUv+RELWT4fhnPhH+e933q/6T+sE1dzY4b7ujTvNxGC5FU1fhiOHEzk9AlPgUlVqA8iQYRBdn441aTfR7RbzJfANybL6kwonP4Hajx5lexCzBvr42EpzbRdkoV30e+eUumrbyLsTH+Jh98P8a8CPWA+oRG2jldqe5tVAByCVhZ5xoF78WeKpLG60Ur4+posa5jnrXYKHfA4oci+HkGnFsbYrHnL8e1FQSxJhLgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIuQVznldcD7e7XDzDtiMOk4HJyOiUb1RyVMK5T/Hgk=;
 b=VHd2KWHb8TlfxF3rqE7QFVjhwZgNkd3jMEsZVKLBWvTdGk2WDmMaGYNE52BrpG6/NxIT/XDS2HDAZnj7pmOwiC/ApjGPpZ936LSTp0lI4LvqJsKO+FD+X4/X4AzQgY5pvriMi9+/hnDqcGkUcxW+hBb6T5a0JS1bC5avJKDp+r8=
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com (2603:1096:604:7a::23)
 by OS0PR01MB5778.jpnprd01.prod.outlook.com (2603:1096:604:ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Wed, 7 Apr
 2021 19:56:22 +0000
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433]) by OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433%7]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 19:56:22 +0000
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
Thread-Index: AQHXK9TmRDzfnJqVl0Sq9GK4xidseaqpVNIAgAAjCeA=
Date:   Wed, 7 Apr 2021 19:56:22 +0000
Message-ID: <OSBPR01MB4773EA0F8CB5D7ADB62CC370BA759@OSBPR01MB4773.jpnprd01.prod.outlook.com>
References: <1617816815-3785-1-git-send-email-min.li.xe@renesas.com>
 <1617816815-3785-2-git-send-email-min.li.xe@renesas.com>
 <YG3weJsOd2IZ5jRQ@kroah.com>
In-Reply-To: <YG3weJsOd2IZ5jRQ@kroah.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f85469b9-380e-493d-86c0-08d8f9ff3808
x-ms-traffictypediagnostic: OS0PR01MB5778:
x-microsoft-antispam-prvs: <OS0PR01MB57787FEAB597317A6AA8765EBA759@OS0PR01MB5778.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YRPc1piN6H8APotDRMy4cY2EwiAkPXZsUNl2L3IgNHN8dsKlVSXmcT/vbqS3SgfAfiUJsTJ+gD4XuplwzGnTADwA/eC4A53tIp8O70ImyPx+Qk0piK/folZRzTkZnmxG+3rKwM1I5QWA0/cJ3+vZY0C5c95yzF8dApFrUyzS/jrcmRcq7qJn6VfXgt7evKDUZ+QKq5Hixe49L04VqcW7hUwC753a5ixMQJwOgRIC2kiGfjuz6HGpYrNvDhkX1q0PHN9cekqMzjeL+hPOQA9s3JC+Gp8SQzAu/XnPSXX0A2MlSdsGeV2TxhGqvSEZ9g6C9oixSKCO4+i2Z0gl1DbdnqQDJFRCy/suhDOHYfFr5iuEriFH6lJ3KH84s6CrfM58toMK3AIYxx71ehA6TbvifCEqRqnJ8k2heS4Y4XzkMkr69Z0aHEH9Lp6XF4pC4Udc17znuppvfBdoCWJAxKh7SwzHg29lfzvVC+Wh35+Vr5wFsfFxFcwxjbZJQou7PYK3dgN8HQfF4I2pIOtAtt2YG6FNbKEDN8ouS9a4zIy0ASm5DnXFF0uZHf/whApclurWRukdffjqgEVcdA5gb2hODv+B9Kd3ErsScxwN5Ng1WUfqq6UgKzmP2/yWPNtj1I63neI0qtRAcBSQuV7rxwN7xXs2zxbjwQ2est14ltsME7s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4773.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(4326008)(66446008)(558084003)(54906003)(52536014)(5660300002)(66476007)(64756008)(66556008)(66946007)(76116006)(2906002)(9686003)(316002)(38100700001)(55016002)(478600001)(71200400001)(86362001)(6916009)(6506007)(7696005)(8676002)(186003)(26005)(8936002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?aHqNlbPew+4z0Ur35XDHlVHoD07cLifwVHpN8teZVqGWaJKgqT261XSA+YYm?=
 =?us-ascii?Q?SFZpxRU8+fvsMbdnDGvZe9AgqVfNEmIngKSTPqyQ00+f0FgVW2LxUIjYcSwI?=
 =?us-ascii?Q?RjrmK8u5Azj9XhNxguKOpDJaz0pQGrhNz+79BG5ymWFrJoROfueFp6nAdpn3?=
 =?us-ascii?Q?jrs90zIsdwoqaiqkAEY41RoacDCyOW9FfpH4cMYUimdALw+BnhEJ/JWkb8ib?=
 =?us-ascii?Q?H038vtre27oY3PMA9DSWn6hyk6oNhSo50qQzaYbuD7KmkhWJbPZaSt7PK5YI?=
 =?us-ascii?Q?B0zAQjjXR35IbcvevC8IaBto/aA7Fl48UZbmgfZKKAuF+qhGrOuyzYZFpVuf?=
 =?us-ascii?Q?meT9HA/KnOqtJnmNcbBXYAYUFoXZARNiHDDVbkZZHKidIzF1q1lNjwORaKSc?=
 =?us-ascii?Q?AzWQNz1TPcb3yBSEV3Ab44AGkXNs/kzBysmIjvJu1xVB+RBErU0mnT3cXW8W?=
 =?us-ascii?Q?3y5xht3jiiaS3dDVZv9goPN+B1UG0nPm7JvC9+C+PHUcrYJnvopg/jt4A4rr?=
 =?us-ascii?Q?Xe66lxO6gkMJwqZAFEmBdq1I3cES/i8liTxV8cYTG2kgXZssxV/ELILVRTjh?=
 =?us-ascii?Q?jE0DitgY2YKJKl6XZXZ6UrUM2ZwOpliU/9h9N3N/31GvQyxoUjiZXIVDWdot?=
 =?us-ascii?Q?30nxvBIPU+nNyWdFoP3hkLpSsrsfHwFxw2gYEOEsSjrpGL6/AQ21RkYUou0m?=
 =?us-ascii?Q?+OmtwPiM8X7a1YHISSg2sGwrG+6jHpkx55Ev+GEPhLYUBGftNyzDC1hBcJj6?=
 =?us-ascii?Q?EA+O3zAlZUxIQnJmi628jxO4H0nA7/OxvHYXdRgAk5wM6aYKOHe0DVKT/GyS?=
 =?us-ascii?Q?x9TtpNjXHj9+pjUWfFGnZsjJJVEhKfcdKzUtysQ5IFqwnqksNHKtUphPnz+V?=
 =?us-ascii?Q?1aH/Q3IOWF5cNEINPQ9loYIG940ISyMEf3+D4mIoJw5BUmMVu+aNf0DWO/ze?=
 =?us-ascii?Q?oTP4/2xBNlHj+/R3DXxESWLDUnTj8ViHFbPhahbbCP4Y1pL4FV2IMHPc8aQ/?=
 =?us-ascii?Q?Cy7XVKx8kM5Cd8juIgwW769cATJQxJ2ZLmJ04vz+kMmnztnFDb4tLsy5L833?=
 =?us-ascii?Q?0DMq9nNYIiGgtImg89lTmA08VTSBZ4GHaHNxskwayPSg1m+TSJpAVXpjpGxB?=
 =?us-ascii?Q?0ZI86aOP21DtlSC4YE3GeVCuLgFztiHlGYzG8LZVlGp8tc2qdT8AJyMAGfqM?=
 =?us-ascii?Q?WZJp7io1blic4APWG+egyHdl1UyjNveIqImpvuyAbl/FVwYiwytHYrOMUmUa?=
 =?us-ascii?Q?u89585aS0jxQe+dH77ltDDAP8WfgGj+QKEQOIz/Sqpsu1PufUkYjZP2H50e6?=
 =?us-ascii?Q?RKVgHbH7AY6s/dvqpSSO9KOf?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4773.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85469b9-380e-493d-86c0-08d8f9ff3808
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 19:56:22.3185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G4fQJ8DdG+2cfD9xQH7K/e2/mpghF1Jeyn91H57M78QCxHbeb8oNmuXjv13Ah8U4dBCMGt6lo6PELNlB0C50RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5778
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> If you do nothing in an open/release function, then there is no need to h=
ave
> them at all, you can remove them.
>=20
> But this feels odd, how do you know what device you are using in your ioc=
tl
> command?
>=20

The type of board is passed by mfd driver through platform data

rsmu->type =3D pdata->type;
