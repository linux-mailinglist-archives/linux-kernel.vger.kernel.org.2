Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF1945B76C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 10:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbhKXJct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 04:32:49 -0500
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:5858
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234162AbhKXJcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 04:32:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iy0jxjFmX0prS8quYTsABw502qd4/REDPROg2+l9hOp9w7790/ek5qdmd72nAnfL02q+ZI8H5Qd/XhNcdfr6gd2jZaDHBoLdFhV0w8/ZCS348o0CC5URLNCXzmCw7DzW5E7kHy72sQESsMQoyh3IaUsyJVsC0JaU4ZfYJpBBu77RKl7IqQT2H4AP6qoZ7kD1US3HK31FSvXgZ5Mw8hw05YyAze5xiMtd1gQFuL9hN2vL37ZiLd9WRnaQibfQjAK/WziRkCw/f68jzQZWcjN7S7kXY5g8s2r3ZHp3r9+VKO9NejQZEVFlrQklWvODHCrFVMNORo8Wdeqhd8PbMvwmVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HybfJPAxXalIZ6lK0Rfnp8Wyy25/dq4oJnyyQIcHGzs=;
 b=FKs/dm7PV861Jpy1GXYfwwqeFDuZHzacLbYO4JwjOK9XuHPN2LSePZTRnzNy1utvSBytCnP7IvcEylKXUc8jXpl24rR1+sz9LJKMzfwn4Jozp6NslrgkoCMhnH8uz+WntCQ08cIgTLxwKZdgaQi4w3En6QkCtIkDFaxZwgk8DFCDmkbhm1OuBv3s97JbF0Jdj/eYBu1PGuvighofG7jLrqyLBS5mJ+wm3yGXf5VwJ6T1yLBhgjRFdtNXHCWobwl0JuqNTvyMp7rw1YGnuLfAJf/GuX9/OBIMH16NOorsWuCMBWmg4pkXh/eQdDa+QS6kGq9Ws9fBD6tU70vEgdDU7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HybfJPAxXalIZ6lK0Rfnp8Wyy25/dq4oJnyyQIcHGzs=;
 b=lpYG0UEl0OaQ1HI0oL3RYmVySDsTUPtKk4lzJqZMoAQu2oPceyXiXaPDLybp7FpRNjINttH5auGL8lTgjBHeaUTUPSMleV3Gv/dffcdBuy9ATOZa0ukSDCHHxgzOIJ7f/uipGKp6cE8sXsDHOHkCJMrWczkrz5f5V29O1DOR6rQ=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB9PR10MB4847.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 24 Nov
 2021 09:29:34 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276%3]) with mapi id 15.20.4734.020; Wed, 24 Nov 2021
 09:29:34 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Andrej Picej <andrej.picej@norik.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mfd: da9062: support SMBus and I2C mode
Thread-Topic: [PATCH] mfd: da9062: support SMBus and I2C mode
Thread-Index: AQHX4P+4418yiCfgqU6JR0rlSMaXYawSaU4Q
Date:   Wed, 24 Nov 2021 09:29:34 +0000
Message-ID: <DB9PR10MB4652104D30E34113D35CB09B80619@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20211124065119.2514872-1-andrej.picej@norik.com>
In-Reply-To: <20211124065119.2514872-1-andrej.picej@norik.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f0df6ce-e92d-4486-740f-08d9af2ced83
x-ms-traffictypediagnostic: DB9PR10MB4847:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <DB9PR10MB484754BEE639D52D7380F037A7619@DB9PR10MB4847.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:142;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aJsv4eNrHhn+M2eUuUcR81WUlKaLw+dE44oKGVMk1QP6oN1URWIavWnCs+qOUjxBDGS2U8c7YFohzbhilEtxsUbOaEfpMBlaplRs/v/eWuN3pFJMPieQV4rsoL6wtwQnrSaRyVA1PGey/5hArLnb4AToCfwyGbvESQ8LpcqkZeZRQO2kzJ2J11+rXv09sRpdnHv/MwsC/1FO5hRcHTkFgu5ltvJnrHfkzs1ymUUVrGE05ZTzpyu49cU2FrJec5MNj2GpvlD1zMK5IkQwk8YQDR3iMQKEFD+Lwaufu9fiyAMAhDfJh9dAlG/RyHuuf9i4yn18Theyw2PQYQNGFHFC2hc0swRJg1RGsf6r/oLrNfJqOV+mzblPYRJB+8Af/nnh0s7NtWIIm4a6uEQjDxvS/JnYuz9FDeJrXMZr41t3KL49w+d9VEsbhb0Xw5alRdyZZbU8h4shyTwiGqXn+IbMuDU7Vli09XE7msBJPrAfS6Meq1MCmLC4N0s1gl1yR9KZV0qTw9DVk+UdW6NmDd91C3tm9akdV84fn0uCJV6zFEbJ5Z/2252ikyvYem3TnmEtpphRz9R1F5MNVDFo+ar5ynYwwEqLLswESeyK1hpjQKuV5TSXrTzms3hHEQff0tRRrYyRAcsted++M6q/H7QJy+5bXJrDuK0MbLlHjc089RPq/5jIl6eJAUiFPhJWLaVCOV7sYqf09MyekjLZ6+D2xA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(2906002)(4326008)(6506007)(9686003)(38070700005)(26005)(186003)(66476007)(66446008)(64756008)(52536014)(86362001)(508600001)(71200400001)(66946007)(558084003)(8676002)(8936002)(7696005)(316002)(122000001)(55016003)(76116006)(5660300002)(110136005)(53546011)(66556008)(38100700002)(55236004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AoGhPrPtriX+vfQgvkSs24ujLWB6Tc3eLx2NV7D9eIN+HyNQDnA2haOM9shj?=
 =?us-ascii?Q?wO9b7l43nsNo6vPPqjLTaK90YNHbRvLligiIBRoTRAGi/93iycOh7WKjtrzF?=
 =?us-ascii?Q?pPoUQ1000BHU3q6vLHFJok6wp42H3NSf6xNiWXKDgyYOyq0WlDh03iwVHtOn?=
 =?us-ascii?Q?vvFNGhmfAFN/kv07E+7DECrkJ3YB6uGJCFv6NdBYKOuRxcRBASotYu6bAeYA?=
 =?us-ascii?Q?es2p1DM2tR/2LFF8cpwTYTMUmNOal27+IFAspuIKn1TYKELVQkFBD/NGsFTg?=
 =?us-ascii?Q?6MlMeWD3uwvrc2Jq+So6MCW04PY60fJohBjl5S8BmOOwQJJD3nNAKh6qEQvR?=
 =?us-ascii?Q?GJTe9UK/p9oYmlFqoiwvVJgc5YY9XMsxrNJSRt6zeLeR+f+tSkpfTsEReJ1u?=
 =?us-ascii?Q?dv1jtj+/L9Qn4/l7g3xR5E+w9Aoon0AOjT2PhcoDnf/YLUD55Xcnlrg/wsws?=
 =?us-ascii?Q?8qfO0Hpq1etciqe/zuHcIFhEuWG7l1CdvbR1/xKussCsLOhNL25Ye/WIATrq?=
 =?us-ascii?Q?7GjFdDSpp3vfLgted7dtm0j2AovtIyyKATsjGdYMlbTX4oYc5NSMA5bJo6s8?=
 =?us-ascii?Q?lgyHgRh4wqT5Jyo6kC6Y21XJlHjf/EXEtSxJZ68dUTo2KPG3e7ZAxbTSRhkr?=
 =?us-ascii?Q?a6BBJvf5PjU611UsQeaM1Fb7GwvtEn7+Ah/ixgl8zTW8doNjaH7Gcb27lvF1?=
 =?us-ascii?Q?CF9jKPXyMVXP1c9d4LYSeUJ7pcWPL5tZssiWiVvTYHaYvYc8T7mh4oOkOLNN?=
 =?us-ascii?Q?iRcybsibNbD8P7oF4pREA+Sy9nAk1JzA7UK0+jmE/AkjAKjwKg46LoPZGR7j?=
 =?us-ascii?Q?UR7SqtbTydKg6eL9nWRP7lxLoP9BeTiwbDAtiaU+J/sSYIt/7598fQzuQ8oK?=
 =?us-ascii?Q?lLyhAOM4BaKo4d12mzZ533kP8OivoydavFj2rPUIPhx2QXeIdT9K3irZ2LZm?=
 =?us-ascii?Q?/5m41VF8LLax2yvXGmGYW77fJp3UAgT7ULGiM8SJzxYA9g9avzfIHtyhAV1q?=
 =?us-ascii?Q?X2haK8MK0sEzLTyURe/8URCwH9ccOjz+EblITDxEej/0pHjoMR1kx3Kc5tcM?=
 =?us-ascii?Q?oRgRE/PeOGG7bmgdmIPuP4HcJPUTOc4xOOE/7c6FYjCB+ppt5OCeeXvDZkOZ?=
 =?us-ascii?Q?4XIP/8yRrkLQY1NtQbpNKhOnyf92KFhrr7WHU6ufB4bBW3tRlx7liwoniE5B?=
 =?us-ascii?Q?mGPq4A9lP7eEUDIWR/bGEWrHF25zRv8cgHdQnnfhYxXc+c+Q8GShYwhOBdso?=
 =?us-ascii?Q?6yOhgplqYtWo+LFyHilpyeMc6v3BbhewxRxMiUn85ibmtXNk4stfjUTHtgxw?=
 =?us-ascii?Q?2Czp0mRs4M5pqXe32mDfBhIhYP0rII6nUuB3fuTrJbpfVWm5kbXcaw/T7Al/?=
 =?us-ascii?Q?rcnqM1sHo0XSIoyZC+qFAY6wqe18QdysU62KPn0/eq8hvaCJcOuRb9wnLxRt?=
 =?us-ascii?Q?/9v7k58VE2DTINUkiThW7pZ8Dz4tDY4gAJnCFWf2kUEICToWJWvAiJw+l6mq?=
 =?us-ascii?Q?ODWgHa1CoiD3cnL0Ixvj9CAKjMnW3kh6N2yTvHrK+LwKXEKP+t/kVMQSoVew?=
 =?us-ascii?Q?cnLuktuZGmsdKENpr0b42s/zoMCl5jbMqEer75pE17Q3DJXRfKuBuUITmhxS?=
 =?us-ascii?Q?hZWuM/Qkt6L1afP8308z0t1hT+UoJyjub/9YiNWP/SVYXqNKSDTDhBf+gDOk?=
 =?us-ascii?Q?Mf4A+g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0df6ce-e92d-4486-740f-08d9af2ced83
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2021 09:29:34.7096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zc4Ty557f2FdY6/20bwWUVCUbp3qhV5ptNmzklCcHiyJyrRiPRsVtSgiszy8P1RvV9DJOP8z8vOCyV1u/vBj6slFrlEsXJQIUQEXPId4G2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB4847
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 November 2021 06:51, Andrej Picej wrote:

> Enable the I2C bus mode if I2C_FUNC_I2C is set. Based on da6093 commit:
> "586478bfc9f7 mfd: da9063: Support SMBus and I2C mode"
>=20
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
