Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1BE358B77
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbhDHRg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:36:29 -0400
Received: from mail-eopbgr1400131.outbound.protection.outlook.com ([40.107.140.131]:17379
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231566AbhDHRg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:36:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQq4TdSuK6eq6qNUQKE031qSKFLSdk0W52krNBpeNX7lei6Lh116OOsvnRN+EqbqDcIyjzHzMnUkx/g6pae2hAcphQ83UvlNMZFUAvYUvTjYSg/q7tA/cYiAQlSRwxF34ZKlx1rS8lU8aLufm3+d/Q2+vO0yrWk+c6kNcvxVcKJgfO2IK9lhRJ+STcd12s1ye3vVPDMy740hZ7Bg26gCV8yOjM0gsnqB+nr7tcCzZcsAlba7F9prBZWQAanxDri2Mk4fHcxGeTSqXBsjUNLY5B5WOM1gO2WZtnG9tGnuun7w3LEdEswsh4d1eiNAlhYpjc1aKi03eCaCAgX9IHfG8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1p2pmIEr3WCD0FXovq+ehVKEVWJaMIoc41xcLwWIVZk=;
 b=nHzr5n4+vuFas7Fihb5ZvUCPxUkoBlKdSQYvb8xEzjCcUj9ghd72CmqVFAuAeIQiRhu7oCCQ+pUHlNmp7omBEDm15asHDZ0vuXvf4XUk3AnrG4Bqk+v8KAgOzL+Y2f3LlTZVTPs5USfss26Wet2fFrZ7Usr/ojOa2Eh3ip4XQ04MUYkaFTk9933A0FUnSUFJqOPEcYvG7k74W6n8ls8EWhw6QOQQlvf8e/UP2KyBCJNCg4El0I/p5Tv2otx1rf0khvlW4RMcsWP3Jb5nPKUcfV0nKvlN9JI6nZ8bmvfUDQzIGM0zHao8iRAYmdx2BDtNOL69jX0I87Y1x6g1e8oawQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1p2pmIEr3WCD0FXovq+ehVKEVWJaMIoc41xcLwWIVZk=;
 b=GoehjFJM6AreT9Me/ZMCOG7xnZQZuxzuJbzxOZmgQzAxYlyConpC+rDbfj2aT3GpvA+jXKIgd1z0tRwUT2w1lycjtRjNtFpgEPbZuvU5Dz1e95AOpad2LfQDEOnakpRMLSPiEjQvAMhUKUSKlNQeyLVK8IigEr68gwYkj61RfRE=
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com (2603:1096:604:7a::23)
 by OSZPR01MB6216.jpnprd01.prod.outlook.com (2603:1096:604:ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 8 Apr
 2021 17:36:14 +0000
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433]) by OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433%7]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 17:36:14 +0000
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
Thread-Index: AQHXK9TmRDzfnJqVl0Sq9GK4xidseaqpVacAgAAkN3CAALFwAIAAtcQg
Date:   Thu, 8 Apr 2021 17:36:13 +0000
Message-ID: <OSBPR01MB4773F65136FAE06F275D808CBA749@OSBPR01MB4773.jpnprd01.prod.outlook.com>
References: <1617816815-3785-1-git-send-email-min.li.xe@renesas.com>
 <1617816815-3785-2-git-send-email-min.li.xe@renesas.com>
 <YG3xKlSrOZvrIr3z@kroah.com>
 <OSBPR01MB477360E86A8913D07759C1C8BA759@OSBPR01MB4773.jpnprd01.prod.outlook.com>
 <YG6kZDlCXs4MGHNw@kroah.com>
In-Reply-To: <YG6kZDlCXs4MGHNw@kroah.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e6b9e39-e59a-40c7-5dbc-08d8fab4ce9e
x-ms-traffictypediagnostic: OSZPR01MB6216:
x-microsoft-antispam-prvs: <OSZPR01MB621678811C6BCDF95FC0E045BA749@OSZPR01MB6216.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lv8aAI8rBGXubL4X+I0H8z4PMUvX6IQXP57ZBv8iNp+y9qJVeB9u0BGrDO6V/c3WpuCxCAUXQ1rI9k0+S6hQMMaSquGrm8/dEZYYR5LBww9ytvx/DKgg6W9Y/X3k5ipI4q2aRmutIx6z9EREMjajl2Zvc7sNK76Zdb+V+pppHUGaoxNesZiBUSNUdHgupU24vJW/Yol5Kqgvi7sP6YnqssqKPrjISlmMK4q5WYaEubZFtCVyYpvkBvsBTeXcTR/6MFk0+4NLLw5MERVjEVZK1+HBFq898YL1mhR6kuQNptmXEH5KdMgWiqQimv74RIlNrgGov1BJHPzftxDPRBlNwVOOmV/qUtgSkKqNa4f6zilUAH/kgWBqXLe2+s7Hk6GBIcKvrFrfMNHsllEQKTtNvgtgN83/J+oZMp1VUqeITtUmRnTTP3/Ayv95F0Qn5YvuzOD5PaX5vm4yOMQMDFDN/ynzAjZ4h6ehXJTUrTp6ce1IXo+g2qgxG0sWcrWhCVhfv0BEin1uwjPOKQD0lgGjcLjMiOyo/MotepWNQ2v8bd0IkC4S6MaqLanqKRnFqUABxELsRtLcjoY5bDObDIzcJ/cQWOCGIuQJvhrmsckfRrh5Yb6b70OKMzJV8CvM2N0I4ejseE6jlJyFZZAiTJ9j7PPieBtOcdSxuVAHNWGXyyw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4773.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(66946007)(76116006)(9686003)(26005)(38100700001)(316002)(478600001)(186003)(33656002)(8676002)(66446008)(64756008)(8936002)(66556008)(66476007)(2906002)(54906003)(4326008)(71200400001)(6916009)(55016002)(7696005)(5660300002)(86362001)(6506007)(4744005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fD+Rvsy+glp8VTJAzUd4D+UEc3PeBjUv4yKlucT9RMmW55EGyg8BEY8Z3eAX?=
 =?us-ascii?Q?uZrQhTJtUXcIusvllRbcm/s1BbdYnju2XZIGN1y43UzDdClHHAY2Gns9jfay?=
 =?us-ascii?Q?7fRMOu7R0JGFUXOIVawjHUBUKf/YaSpBfl65l1pCcY13tLr1UqHJeZm/Xhxg?=
 =?us-ascii?Q?slHefPnOeQ5WvGhuFkgXSEEe6NZETDVGn9gh0px/WKDG7FzOUWlHMnqkd+V1?=
 =?us-ascii?Q?Z26J9GnEnyCo4hKiq0oNFjBpjUqN/sZra/pkYd38qRZeYWL46CZ1ZfKcPVOf?=
 =?us-ascii?Q?Tsuzcy3E2ZvFe7egihp9A09MiAXLNZznIN0rTQ+KB2mMw3HvEvmXTsDJ3+q/?=
 =?us-ascii?Q?s/+eJn5IbfvR1Uo8bVhnc+Sxd8pV3iv1TFItSx1Z+ArNxq6ZLZK1TY6NTyUY?=
 =?us-ascii?Q?iuLrPkMoKaOJ7vMwgAfhwYdbUgjPOhyudLiTJVB34FesFiK/mgiIZ66GU5hv?=
 =?us-ascii?Q?PfiVd6i4ns/F6eIPVvjim79WRnNHi2Pha3RnRaJztsv2gzufWDoplSJL9rv+?=
 =?us-ascii?Q?CLci1OK8TIGZtBTk7ZcL49UZoJBOOt88rs5r6vu3Vo2uzOMu64ndZ06jLIeg?=
 =?us-ascii?Q?qCO0ypxMwnqNc3oBcsDWR/gdSnd2TZLtyD0uW1bKC3NvUNRWy5zLMBGPd86b?=
 =?us-ascii?Q?Vhl3kNzCy1zEyg7MX3Au0iHnli1KrmNIBu+ct7BhH1cjncGNP1venypfqJwi?=
 =?us-ascii?Q?CX+LNl5yHXi6xGC2aT/LoMdHpUqjuisM2wo3tQykyulHH014a/a+EfkRgPKh?=
 =?us-ascii?Q?tCBcMRoYjgcQrOriFxJfjazMLSU/XlukH04XZI2aqDtV6Be86o4zgu/Lz0ZO?=
 =?us-ascii?Q?CGqvRBhHH4ngJXAXHpYodUBga55D7QsR4yMhvRzjNEXKVxDF2PXa9oKm5fyh?=
 =?us-ascii?Q?BdJ/MO2Xa2owXQ/yeHShrRYh17O7Lk9rep9pRGQa+U4tz+GNqia+tqZvCaXw?=
 =?us-ascii?Q?YRrVs7CparI2YnFnFuX0FwEa3UtoMnsDvseHzMymTX8AXTGTtawG7uXoLQ2r?=
 =?us-ascii?Q?FG4A6t5PYMZKmtVFaRe06arpA+yx7RBim9/Jhb1Bc5xjBo+b2oA5U1OfBtAq?=
 =?us-ascii?Q?pnjvEHQdVH9cL2++DJJRHij5zqEjdudlb5cRNN7l7A08LyqDPKHGt0CJMBoB?=
 =?us-ascii?Q?4h8nGJE/6pXC/MkGZNVMxhcc5gtLiW11ZJTEbhcqgUr/ZgWtecKCG1J8fJFs?=
 =?us-ascii?Q?1PHkaEeHsMCzkzo3z18SkglQbIlH1AgjLnTXbh+WezKFp+oszUbhuFBULAm8?=
 =?us-ascii?Q?NdPtbPZ5lc5u2NAa7vrpsbiXMPmaL2g+YtHaCxndoQhu7YooexlEiZaxg9F/?=
 =?us-ascii?Q?wBTYcT9Aaaiou8JecqUESo1D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4773.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6b9e39-e59a-40c7-5dbc-08d8fab4ce9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 17:36:13.8698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cieWQpQx1Vj2RrartagwFfQOX1d2WXCwELIBEkUQnPm2OOMrJrsRD7x0g1iPAfJie5UxGDRdqjZkVhC23V5GdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6216
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> Why?
>=20

Because I need to manipulate name by adding the index to it during run time=
 and use it as miscdev's name=20

	snprintf(rsmu->name, sizeof(rsmu->name), "rsmu%d", rsmu->index);
	rsmu->miscdev.name =3D rsmu->name;
>=20
> Then why are you saving it off?
>=20

For things like dev_err(rsmu->dev, "Undefined RSMU IOCTL");

>=20
> Ok, that should be documented a bit, it wasn't obvious :)
>=20

Will do for the next patch

>=20
> So you can just look it up from the name?
>=20

name is based on this index in the first place
