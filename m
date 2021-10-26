Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D32B43AEA6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 11:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbhJZJKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 05:10:36 -0400
Received: from mail-eopbgr1410120.outbound.protection.outlook.com ([40.107.141.120]:6115
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234711AbhJZJKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 05:10:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHyFPrfP1QenIZtnvW0j0SV7Zv9+lcI15pAAwWduEmuvtHGm/afEbCt5YD8CZXsWDSDkpriJ2KctWDAsSPhb6DeOIxs7O0TsAoxsUN1djN8CHHmiw4DiNm2Hl6oObrzEDe9Xw0BJTzl6GWsPLaSZqihvWxSOF+i+PZp0Gm6ePetPnH66wgAHR18IVyM+Fl5YRx72mueZURKnGcSJpx+tbearWrjnFbbDKGpx+bjHYV775jOol+pUAtZw5vucbEokHOOlpThJ8lhMUOizHI6B+GZDNr4JrxbxrQyDFBpnD5ET3RAsOniIchh9i4lB+sL6f4V5gt/WS+itg3CYdjfijA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Fhw+5VRXze/NVTjpHMfVVp/i3u5M+uCYswpTxN47JQ=;
 b=hWrTxz09fIH2XwCxXq0kY3eFfSOkQaI33I4R5TSMwvFrmwlMeYGo9e2cKv/jxpKY4XscHu0w6sPEnJSPegqJbPZX21EQeEB7L+AJaGWqimY1bLPb4JZmAAJX8hCnZal5EcEQmRD1Y8JXFForU5TGk8gNp9TvAuPMm1un9HHa71f0dXiXYyo1sAelkwA5MQIxtjDlEDp8QH+wDEz+LOgJqLvlsjgnyiqTqTqQtMydY9QnCMoS73ELlC7tBISkjEDQ8Ak05t9Izvy8DOuUX7zpE3tunF7Z5gbWX03+zLtyK1PKjdwGxPxRxVyYmLq1qbO0OG5eGROEUVfmiQmCqyP5TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Fhw+5VRXze/NVTjpHMfVVp/i3u5M+uCYswpTxN47JQ=;
 b=AjTsewQgEkQOlDzEho/5UPmE/tJjiODC2fArzdaaEMET2vze2aQS73cgLjpeYQF3ZOQbKqIlI7hnWECXK1B+CME5+nHlGELfWozpX3aVUmAfsfZIw0o9gxelKD0jmcgqD4NBnKPvoC4Jd9HLm/hqyoEb5A9LPirDby+R4rA7JFA=
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYCP286MB1329.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:bc::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.15; Tue, 26 Oct 2021 09:07:43 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04%7]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 09:07:43 +0000
From:   YE Chengfeng <cyeaa@connect.ust.hk>
To:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "ludovic.desroches@microchip.com" <ludovic.desroches@microchip.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: drivers/crypto: suspected null-pointer dereference at atmel_sha_init
Thread-Topic: drivers/crypto: suspected null-pointer dereference at
 atmel_sha_init
Thread-Index: AdfKR7vq5R/dtMzJSi6usciaQ4LR+w==
Date:   Tue, 26 Oct 2021 09:07:43 +0000
Message-ID: <TYCP286MB1188BC12CA1BEF68F5E90A7A8A849@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gondor.apana.org.au; dkim=none (message not signed)
 header.d=none;gondor.apana.org.au; dmarc=none action=none
 header.from=connect.ust.hk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77ab3ebe-5ecb-4245-abf0-08d9986011e1
x-ms-traffictypediagnostic: TYCP286MB1329:
x-microsoft-antispam-prvs: <TYCP286MB1329FE69AA7EE77ED56F051D8A849@TYCP286MB1329.JPNP286.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lTmyNcFSD/0IOx4tGRjPuXfoA/x2tCDDWGz0Kj0StZPLu8nfBEjLCs8thMMq0rYDk6lNYmZAxyIfbxvbXgNAOcqWJwZQIfoqqfVviz9vdoySW2o906mbFUR/aDdnucMHcX0yIA0YANPIMh2hKG9xvVJz5q5XaPqO+YrgfjhFa6nscMoF1vB7lb8fs021Q9A4zioveS6q6b4vyZ+gwVO8D8hdjvO0etO6sbheMvfJcHCmncvSaKCyu2j0IvEPrh/X+80URsB8CIgAJ1kp0l9UnNIyP8AGRpsfqzPKl+HgIEycO7mrR/aBIpruas1Lys9i8nhJtGm2hZgHlh4R+4DDUVnge2aH5Rf4xEhvLc9dJv5wTyEnum2Z26LaulzNzXFdur+Szqq04v1/N3tOROIE3PHjcZKOitl8DD7J+QaFOLRGmvjcO4BN62jSgTM6ChePvvHOvw6bsD+6esVnMhlIEshUBlSVGYtBiXy5mCQqdmODmNjJwuXf3MBueyCAdPBBhWc6i3EYTJw4gPO2S6Uap/bspyjyJ1/NVgcsJYCaobyAdv6m+R1xMguKCfYzp/shxt9X/V1gJm9sjiUFtRt/05GmNbJytXhHtnneTqbpM94ltyxIavQrn2VbDRjc8vN+Culpaol4PZv5LJZ+ndoyt8Kn/qD17SvA240Tw44HQxSzI3BgvVOu6dYt+LPtq4o5RQzqfswZE9AQ8SK+POKR6+VpX2AYYhXlVgvdZ81J9KsBtWVoIGds/L6I2fAd8vbory+UtYX3rcWmarG49wxgVvffcZJyoSzatw7elRZd0yQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(8676002)(4326008)(66446008)(71200400001)(9686003)(122000001)(508600001)(786003)(8936002)(5660300002)(110136005)(55016002)(52536014)(38100700002)(38070700005)(33656002)(26005)(66556008)(7696005)(83380400001)(86362001)(66946007)(966005)(76116006)(2906002)(64756008)(4744005)(66476007)(6506007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+ma83R7kJ2eawIy8HH8wLKRCRW+9ov/zQ5PT0c9Ojg7p/7WRbem4mTrGssWk?=
 =?us-ascii?Q?5wXYR2lMKmh5bna2cIt20snIKW8jhxr1m2OuLWx28vgjolznLY13SOnjefKZ?=
 =?us-ascii?Q?epbp1lXLyN2xNdH2Xq4Cra8hSZn+oTdsEsqnJqXsRT2Qoxuv/1YFBJuamRvr?=
 =?us-ascii?Q?BNrI385S0ihspSYJ3ZDJN3c9S7kKZZx8532jWaUpP4xvrT7kL8G3SDwVXYFc?=
 =?us-ascii?Q?7Dl7GOyv1hHmBnCOoKfnsnu8Z4fqgfxIj3KEVSRyjwQjsAFDurzX5QFaF4BU?=
 =?us-ascii?Q?/6updr60VHOszWJQ0iThMSve0aJZPx8PlApWlK7rVUdVMNDnlSnYxztSbpg8?=
 =?us-ascii?Q?4j5LHWbRo1nPBuJtHuD3+yJosSI18ytu/BTbvJCdKt7+DkrtMQcrW4rP90Bu?=
 =?us-ascii?Q?auq8if+ipf1RylDreQMlO2iC1Q3Sly4nts9Z5tuJt7vrCj8ySCgFQqNvz2fl?=
 =?us-ascii?Q?X0G8u1LGTCJATHUOweqLm/OXB9rJcyhK4+6L7DT/ZdsrrCDBEs8e7144Jied?=
 =?us-ascii?Q?AOIEqWxib++al9T5UUFetD72OyCAoFpLrWIcfJy+/K+jU6YlZjICCcVv+ilK?=
 =?us-ascii?Q?Q9wYtpY2G8GxqNFW4ha3XmKVL6orE5nyPgHBa+4dvk3My+HLGgYEEexadC7H?=
 =?us-ascii?Q?HKQzCxDQhBgteMPY8FssK/qmoMcMPSvjheLFxZegmaGFrfJeS+hJLvz+tg4q?=
 =?us-ascii?Q?XhMGxqFG+jh1r6zFSFb+kBPk9Lb9hXK/wo+xNG5II0V0gLE+w7kbd7bhlJY/?=
 =?us-ascii?Q?3Zw/LoBU/QFcINJlWrmIySEqiN9kzAFD2KY7fhAN1JCacKT/UcvVvwUsG9/o?=
 =?us-ascii?Q?lRHACwuhSPxz64Ub3o7QcXZ3rZasBCxP7tzHgZldhuanyoBz82qoi/Knr6yL?=
 =?us-ascii?Q?nghpeDXe6G8kJ0up2wR+SHYsqLRGM2mf3XeGZfbDl888UGz8aswrDhO69oyz?=
 =?us-ascii?Q?KMMUOhimgzizFqxq/bekjTlz5MqHC3Q+B6Lpt1YXGtIF7wpSCiz9Yfg7MwM3?=
 =?us-ascii?Q?6I8lh/YWr4nhy10l42qfxy5nmy/LixY2khGMvJLPi018vtW67zNxctiw8i3R?=
 =?us-ascii?Q?nn7X1Nr0pgVmlO8xoeSQJE6SYExq2HGV2A7bQtsPvLhN4oKffccLa5l8EnyQ?=
 =?us-ascii?Q?T+Og5YxIZEp+dkxGlcDCHAN/G7zlRVRXLisMbjkSow2o9WEmbsftuMxOTtu1?=
 =?us-ascii?Q?3VtQYlDHRsNuEBFFvUZw3ITS7bsNjL3pS0LbiijU9MDIiJrICoJBMU3/eMLi?=
 =?us-ascii?Q?ymVk8i1wYZifNMHK51Mz+bVz0RVhHihypV2JnwV1CiElKziE4rfEbJl66XLE?=
 =?us-ascii?Q?g6hfXfvBLr3+h8ekFrSzNuAi1/LWdTaCZyvRWVnr86fhwlHTTJMiqT0D9dc5?=
 =?us-ascii?Q?W+454QLQFTP9oaXKz8K38rnjSI6G8nsdGyB5TJYUOsaFh3SiJHwgYw7ve1Nv?=
 =?us-ascii?Q?B5KvoFnnhyKiF4SeqHR4pPas6O7q8OZcrzdroe7zSQlY91XD8g9JamL3rQeu?=
 =?us-ascii?Q?YnExsJ9CrUM84OAYgktVBk77iS8RlQkqeEnhuqbWu+49c7u/gHuOxQ3DIPEx?=
 =?us-ascii?Q?3zB+vuk+rGv/JWwTfvQ6SoW3Bh5KrnrFZi2WtCITe0OOtrTA6SoEX/hMyqSK?=
 =?us-ascii?Q?N50pq2uviw++FwV2GLldrjI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ab3ebe-5ecb-4245-abf0-08d9986011e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 09:07:43.3572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5/2Q/gOaLrtKZVIfysuGgEWZ/yL0bW6m0AQu0XjCluFy/cXeQ7MYKvy6UO8B7w0XpdEc8wiVE/Hrg1T+/6vnqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1329
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

https://github.com/torvalds/linux/blob/master/drivers/crypto/atmel-sha.c#L4=
31

We notice that the return pointer of atmel_sha_find_dev could be null, and =
it seems that null-check is missing at #line 431. If it returns null pointe=
r, there will be a null pointer dereference problem at #line 437. We check =
that other call sites of this interface perform null-check, while this does=
n't, so we suspect that this could be a problem.

This is detected by our experimental static analysis tool, it could be fals=
e positive, so we manually check and report those we think may be true bugs=
. Would you like to have a look at them?

Thanks so much,
Chengfeng
