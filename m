Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D476843980D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbhJYOGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:06:18 -0400
Received: from mail-eopbgr1410119.outbound.protection.outlook.com ([40.107.141.119]:20682
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231468AbhJYOGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:06:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfr1Rri0tHLfGr1Bkn3f0U0Giu3oWbe8Ek7/lmN02iaUcuRp/qOYTKvAHwhh0WyDueu/GHqFsb+AHHJxvOfY/NAciE9i/k+tyz95ZmzvDYQrhu+35pFpz63UZvsFusou0pLb4jahGF51Or3DSEHS43UaUbvywPSy9eBu8ewLR2d/FTNVS8F7u/RVwP3yJ8LPWPtEu8Pf5n2CN5XMMxhk8PQb0/I7AHXPnQ8uLhJOYi6SGFWlWvBz+Jh2xPZY2r42+WxpgGAxLn4AK0gaLRqZo5petwNr1Vhw7Jxunc0DR2MPKFZKKXmBUShe9GwrHXV5UF6K0SSEmJhLSANzE4hJpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=166d/rFAn7dP1yWAorZZgf6xYjLzlKvebeiHNsobTdo=;
 b=TcHX93/bjt7gcsfvjiYdohN7AVXGpev/djny3h+6zLmsceKwW0EFZ4SceuYg55cjtfVqBZ4u8j/C+TZxw+/WhuXiKhSKIcuAPk9ileIgVlwh9PUkCwci22PCf5SjHdFHvGge4SVxE6DCw+NJ8UOvoUjXgrgDzncdmwsNGSeq5rGpako6k3/xHEa37ArUbFAzXzTRpSnH+8cskrYHoCgjfbnhZGTvOFJ8f0+BxSOVmFDuTUt4+WbNLthnLq6xdoK0tmumLiRkEXYibQROkVTBTRNzKxI/gHtrs6YwvcvBUqulBRnvobCcBs7EJOMFs7uQrYDnc2vS4B0ppRkiDuA6lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=166d/rFAn7dP1yWAorZZgf6xYjLzlKvebeiHNsobTdo=;
 b=LXGkX7BSmJ3f11YaHm0ccEY5jpD/pAw/SNOvQjIBrvo8TpjA5Z87Qo0UwI5t0jwo3bEt3pptwVs2r7s/DnCmzpU2q9IJSvuXDQweKwrHUvmiIXQ1ms2TjB9ocUBdbn9sBWlj2xhWI/xYUZ9NLNsB2OFCBP8MymwfVz+dbbni4tE=
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYAP286MB0041.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8032::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 14:03:52 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04%7]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 14:03:52 +0000
From:   YE Chengfeng <cyeaa@connect.ust.hk>
To:     "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: suspected null-pointer-reference problem for to_swnode
Thread-Topic: suspected null-pointer-reference problem for to_swnode
Thread-Index: AdfJqSNMGhrwAA/iSB2KhsgTg2gKFg==
Date:   Mon, 25 Oct 2021 14:03:51 +0000
Message-ID: <TYCP286MB11888DAE6D94FAE6A9F1CB438A839@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none
 header.from=connect.ust.hk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc14a8cb-f64d-4312-8807-08d997c04676
x-ms-traffictypediagnostic: TYAP286MB0041:
x-microsoft-antispam-prvs: <TYAP286MB0041BAA24EFF84153B1A359E8A839@TYAP286MB0041.JPNP286.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2vvXwpKYFE7isPBpJC30PGeo99u4VVULFacH5Irzs1dYbQlVX7orMPGN20Fex1WpnIASFIsgaYqBmFIbsrt++SkI/eYYaYoGBk05TBigKFHdt7S3SdSklirC2cjUx5MAWCCxPYkAOm+O5I2FPPI+lNqnSIJC/v82P9kBJ4j6H5yGY4TVhaZNBENqy5XjWhE4sWgfUj81XgS7aPnbltFS6EngldkACF1WNBJuez3f4pYGNkp1eTveq40mb15qvorfE4LXA0o7oK9tfGRaaH/Adz9PSBjFaMhMoYkM6okxJrxlCR8Nfs9ubwZU3TIPf51dyBUOXW54vux8m3nJBYYxdMpgqF/vw7Z7ICBjj+BFuDHwNyjjaDM+BM8TZZVAF5FHEbO3snfThw6s2a/5gvMKj86VjuEL7CiKc8BpxAi7KiRTPfUViuXUbZGjVStz5JeCS5V+J3N2b/sawX74k8gIhZK70c2LDD1twPU5Yk0Ht8Sxj/DLy4B20nZi716nOH2QlBT5tXT7d7jwBkRLg3RWHTq2G6TRVNOwvYaSXoDkYuua5PTxLD+dzWjBNcljydz23kV4My3hP5eAyYI4sBCyRjtiB3uxeFShgJZo6mHARNLrHC1hiprQCrdxPxXuFZnYQOE1CFw5fjWIIHGco924x0xkTnTr7lqZ62jN1vu2S0gSFIM29cuB2N2fAZ4Jif1z+D5hL4HReO9pRlooDFJDkBK9QjMLOz8/w9F99CFP5e/VOyLZzp7ZROge79N3nGLIo+LPnIM6Rhzdl8LinE1mzpC+2HLeJcACrg4HlOV52WQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(8936002)(508600001)(8676002)(38070700005)(316002)(71200400001)(55016002)(66476007)(786003)(66946007)(110136005)(966005)(76116006)(52536014)(64756008)(122000001)(83380400001)(66446008)(6506007)(26005)(4326008)(186003)(66556008)(2906002)(9686003)(38100700002)(4744005)(5660300002)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pWOAvS72xmxtbGl9PzYUbWHG2ZURxFlOJulFB7LHGpM6y/fxLS6cW1N0fScT?=
 =?us-ascii?Q?KubR7sxHmsiSvt0XxIv1VqEg9Iwqgw7QGnVYxqYbquPr/E9flD1suVEwm53O?=
 =?us-ascii?Q?Uri12MtpvGj3SUTl+vbIezu0xyd37lsEs5aIWUfNKyhQtMJ8qS9tpQwjy0qa?=
 =?us-ascii?Q?ijRluyOEihNBTNdkg97OaXXSEVZ6ntkrImQzm3YST2k32MgrAENbEXcPcQHN?=
 =?us-ascii?Q?lyj99+a5LMP3f49f7THxJokwmpoFlG3mT/Kp5Qh+vCnPKK2XutBtaPAjWX76?=
 =?us-ascii?Q?zcCmXleJaIGr0C3srlXY0tvCGp67ypW1L8vcoUPg6WALWcEJh1oLGeZ+SZT/?=
 =?us-ascii?Q?XaslB7AOwPfT7DWaSzcfsRjBoZewf2270xyoSEovztXjwuhWySgEcq6gTnwV?=
 =?us-ascii?Q?th3wRmfSoDvHRlAx9389eAp80vhyWmVya5ah7dI1N856SWgNWWXbzJ48TUr5?=
 =?us-ascii?Q?ZOQjvZjl+9oVl0+Lk0gl66i/7TMBXqgolzy8j9Tmfyn16rTa5zEnTDf5dWgB?=
 =?us-ascii?Q?tOGL3RZindoXdkVwm9H4WOOr6gV+hwaqAivNrla/NIlBY0PCAG+0jxNo44Uw?=
 =?us-ascii?Q?TDYu/y+dVCa4sFfkMVUwysO6IFtoOeGHRjieoWX2bjLq6mplHGeP/hw6RscH?=
 =?us-ascii?Q?vOe/zNJTVA3MJOU4iXADnHN5vULD3oIjRmRrTusov/GQErA41RNhdyatGXzq?=
 =?us-ascii?Q?JaY3458RiOG7fFNf9N7HSYGEc4cCji7P0nlE4WrnEkAsxlRESRs0QVrXZSYy?=
 =?us-ascii?Q?XG5J8Yy/DIrShOR314Ugoo29Vd7MF6kpq1keN96DXUKT8eOYPWv1y1rmncxW?=
 =?us-ascii?Q?RsIYIbhrPWcBW5Fl8WtxCFQgziD6zJMNjIwW6kdne8BtuCKszO0jiWwg+ORH?=
 =?us-ascii?Q?OM00qF0KpuwNVf/eUvYlOqI5cltQFukR+25syOWS+ZPSWKsIEYTC5lVYf03/?=
 =?us-ascii?Q?ccJSvL5ETxFpWZxU3qoJUbhkv9jOZmq7kuGHD7duF1Qr3SC5vU0WBOi63TJM?=
 =?us-ascii?Q?Tr2+hAKhbxLfIPSS40cseRtPBpQjRfTVHK2M8pgFjmVE9KB7Yei3TZhtk4y5?=
 =?us-ascii?Q?vERjWikrCzDs3M4dTs9Mm7heTo2mAKIrnhW3De7dNro/FpFNeEoJNO6sanc7?=
 =?us-ascii?Q?W1ZWCRpEGkXBIYE4NDtjHHg2vyzE2GShjAPWJRrofWi4DzSpls4BHib1szPE?=
 =?us-ascii?Q?/AW3udl+/BXzC8jhdo5QtxWaq13T6hzPG9X676l73FAAIsXDyreAiPkrgbaz?=
 =?us-ascii?Q?HofzNURYQKrM/Oc0qXSGjZ1WQ90o1m2NshDBwwH9cvZgWzlrxuGIP9YBG20D?=
 =?us-ascii?Q?5QeEswxVj/2grn8k17fvMbK2XANJaKhGq4PiuC3Kwd69ulMkKA9f6MZjkq5W?=
 =?us-ascii?Q?awQi5We4wDPsuKYNGvmCQ16I480kyXQelYfGRQLJpRAqMUCCDDz5MgvhVueW?=
 =?us-ascii?Q?ArIL0yRWOhUx+kKKtM6987rL6LtbOBVC99Mm6YPIlvvHZCtXdJciYcvQkbBQ?=
 =?us-ascii?Q?rYjwyiAokNH8YtKEBZUWeplVyIQkt0Ds7RUUkg482zSCHLgdACCgNtDPd9g9?=
 =?us-ascii?Q?wanoM+nIZ+NUjyXwyXgzvP83nAOLMvyGNtaiHoBFtJmEK0IqW5LLQRNXFXyL?=
 =?us-ascii?Q?QkjTh+SPAOAqS4EXQlj0z3U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bc14a8cb-f64d-4312-8807-08d997c04676
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 14:03:51.9989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fp1rz0M95YwKY5qehtb76zXYrT4+EX8JF3BnFWiYCXVr67il1A640fjeGwiqkjdEckncQbGceZ/vekRA/SGq2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAP286MB0041
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=20

https://github.com/torvalds/linux/blob/master/drivers/base/swnode.c#L405

We notice that the return pointer of to_swnode is null check in some case, =
while in some case is not. For example, at line 416, the return pointer is =
null-check, but in line 405 is not. We want to know whether it would be a p=
otential null pointer dereference problem, in the case that null-check is m=
issing.

This problem is detected by our experimental static analysis tool, we are n=
ot familiar with the source code and it could just be a false positive. We =
send this email in case this is a real problem. Would you like to spare som=
e time to have a look at it?

Thanks so much,
Chengfeng
