Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894D53FEAF7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 11:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244932AbhIBJLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 05:11:15 -0400
Received: from mail-eopbgr30056.outbound.protection.outlook.com ([40.107.3.56]:13134
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233656AbhIBJLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 05:11:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0kCHpPOOL3dNqM1Er9IK8svbjCrXH6iIVAplB2JhO0qfNmr/MUIl16pufhzuy9LCpR4bcjF6TC/rfyapLQv+0Fex4EDUvsP4tp3keFCheWpKv481xfKYTeMbJh5eKcsJ6o8teBdPkh650X0m5lg5AlgvGb36O0z2JB9DEeKs1WUX+Dl3SHvqKOrLaTt7XFT6dqxqBWCCbQsIiUFwxvBbkIH+leScieC6jOm+GrZGJFgcP6Q+YmJVD65yQCRu2k/8a7G+rvVcDKXY30M4nL/C7wxHRl6cyUt64/VkWnOAq1tClJMW7s/WzpmbBlJwVNu8lSoK279c2IvBJkM+0WwZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WCjtCYTJfV48qY3xCKHSKblYz8OYhntV+jtDSy1meEU=;
 b=iX1P1Hemgj+08OXwMEey1oZWRLQxalNiisa3dcv0YEtDS4QL88MkF+/qsOjrDem2uuyxCyGmkBTBIn4KM4ka7Cjv1zXFsjqyaN2T5TODw5Uh9WjEn1lgRy095mdK+4dCyACqpS6WHVBp5OYtXIZQAvl5kkZHt0wvCqYFRpnvds0HPrVlRY/0+zSe9c7esIRm4724e8hRjvsQHEL5zcyYlB8PhksNqy6vRGZmpe4kcNkG9lItLvj/31Tm/yd4G2QGGRiGV4m3U9UZDwOrUKT39xIlJdNOj69QmxdYagBlWwSVWYJUOglFOIpj3y2uYWdqsZRbL6FNIpzrRI11hUNbPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCjtCYTJfV48qY3xCKHSKblYz8OYhntV+jtDSy1meEU=;
 b=K9MbGnLH1F93Av2M9QbG4pFFx9OR5o8serMwvbu4XQywFcivsegwp+c89MpjXsVkrydiRzcDU+lWJJu5pG5Yjjc4GfsRx8heoLlIgnqd4fmt1unN9kM9jDAaaFrJrH2YWP1rTeibdNihOupy9xCtiTonam04OOBBRMS3aIzOZL0=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB6PR10MB1750.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:6:3b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Thu, 2 Sep
 2021 09:10:13 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc0f:9e52:6dbb:1144]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc0f:9e52:6dbb:1144%7]) with mapi id 15.20.4478.021; Thu, 2 Sep 2021
 09:10:12 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Carlos de Paula <me@carlosedp.com>
CC:     Support Opensource <Support.Opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mfd: da9063: Add support for latest EA silicon revision
Thread-Topic: [PATCH] mfd: da9063: Add support for latest EA silicon revision
Thread-Index: AQHXndkb/hVG8n2v10q1oab93VM1fquQd/uA
Date:   Thu, 2 Sep 2021 09:10:12 +0000
Message-ID: <DB9PR10MB4652CCDA7C49C115167AC42580CE9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20210830195345.71853-1-me@carlosedp.com>
In-Reply-To: <20210830195345.71853-1-me@carlosedp.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: carlosedp.com; dkim=none (message not signed)
 header.d=none;carlosedp.com; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76f75e4f-d90a-4633-245a-08d96df178bf
x-ms-traffictypediagnostic: DB6PR10MB1750:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR10MB17503AA0B3B25012936E0DEEA7CE9@DB6PR10MB1750.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hXXihyOhf7ZoOJg/n4OBnvNXQSEWDs6gpPyDoNyQjUfvWOPSMTNWW5iCcGd0xE+k3QJfSHaSOLmJzFyhyPpF07PIc1QBV45m8NdODgJGuoi8xaifm4iNQkjtQ586jATn487cbuftn+eQVySiqQ+Wn8QsWIkjauHiNERV14D5lk4NfDspsdB0pcwdLMY/Gaa4HVcmyoLHPm9vlaFMEmCKtzIXfsoyXqonT6mJmXD9VUqtTdbgvQuVcg7sArSRyIQN7zE3QViXX6OvvrAUaGvYAHHD6EDD8flpbfJJqVkwwN2CPuVo00cClxcHcyrfDclq/Ak59jiFj8kO8zSE+4okNUL864GuD2bPWQNF0J/farhwfHY55JMcC3PpdljfxaRWvfIl27DVHU8lWewPB734ebKMg2XAso1TYPI3jiQky13FAW+aq8GMOCUmaWFD5LYTyjP6Y6JvF1G4vv7MZ/mfPE0OkDMbQT6hjKkJbDHyCI8BkuYxWWsWPKx9/1iX8ugrRYnYmtob8fMzqW3oKnQdXCVH6nLXfJYOcLuZ+aNCCARbCXE5gFdraduBaIVPzxkGKXDHZ01jNfBq9ns65dUbydYBUXoFdTMLILCG2CgXECuM0x6/0CMa6aXtasZT+qc7jAaHqhGrX6zAyMDmW66V/rhWaWi++eXAD2SFfn5QTPxHDYbi83mkf+tCVTvDTZIZBv4JwWkaypp0U7R4Qzi8wA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(6916009)(478600001)(26005)(38100700002)(5660300002)(55016002)(52536014)(9686003)(6506007)(71200400001)(53546011)(122000001)(4326008)(38070700005)(7696005)(66556008)(316002)(66946007)(76116006)(558084003)(8936002)(66446008)(86362001)(64756008)(2906002)(33656002)(186003)(83380400001)(8676002)(66476007)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jIsEevXIwapb9jgsG8ZM3gDHx8Y6qpqmWlraM8mgOVLlkz5NTARyHk6xpIyu?=
 =?us-ascii?Q?jhYDyKlkrfcxAi4KAs/TtXUuwkLjE3xYc2aGU48TE9BIVNekwueFBfI42yf0?=
 =?us-ascii?Q?1n7ONgCvKxLWIJGP/9hGSNDeohM5ReHcZtoj3pEiVGG7qTT1kCoKu7vqGoMh?=
 =?us-ascii?Q?pyHynzBB0sUOIj3WuV8AZYgvymCKseh5+k4jRGfg5RnTH5NaOa2bnRuGBq6A?=
 =?us-ascii?Q?F2Ud1MdZhLuBuKn70ZIlcM3uKa6IRrtFjUzJj/t04QsTYvr8CuDuE2BGCyp0?=
 =?us-ascii?Q?69DiZ68AbbFUAIlKnIzzSJKhn0XnCmzwvXogWLu96PdvWtZmH87svvvON8cR?=
 =?us-ascii?Q?RKGoFbD1PhCnnm/jElfIwUx39xApiO7o6i7ZnqtIh29KnmPpD4HWh++r3CtT?=
 =?us-ascii?Q?PEbiU74aNLVRQxbcbEOsBfQxa8hpTRd4GALi/BUVKQctzv57I3eAGEG4ziFj?=
 =?us-ascii?Q?AKOZUceK9jlcjPe8mAmGocjmDBugmtnkMt2uOZKLpF9dhq3Ith8YWQqvViUz?=
 =?us-ascii?Q?hSHGygju/iO4CqiO9IVy2s9dFqIncd2aYshpjqi0TUQ6aubxN7goHxXUjrAH?=
 =?us-ascii?Q?QfnCyiSOyI1ec73KgTJX1k60yzqoS6HNmvLDiwipEBH2Duz9Gypa/q1xfpjN?=
 =?us-ascii?Q?NWmsqa3poBL5f5Zh5P3+ZnE81a1k1X0sZJASNJgcQL6RGR/Vq503+W2AHhLh?=
 =?us-ascii?Q?bmUb9MpsEJXzKtlwFFxG4N46LaIvH2hCHLlieOSXuiyaF1tgFvLLiiPKC/n+?=
 =?us-ascii?Q?WynBgUZjHyizBxSrGuHdgDD/NUQiLtXp/uyUw2TOoNTYAYX2LDpyKeBpmpCv?=
 =?us-ascii?Q?u8TOc0faWZqCVByLFknZt0n/w+p04A6eEEDyIByfNtzBTTufkgRrZdkLlwsx?=
 =?us-ascii?Q?xp2DVCymWa+1DjjL8KLtNi+Cdz9nPCTDvNoXRrqbd/sJopvIVdYxrrxqdhke?=
 =?us-ascii?Q?RyPmZJ7qVRAQz1M8abKfRE4u2yBrh2bDLlwkmRCN4vWpojvKx/fs5iyGwyoM?=
 =?us-ascii?Q?M/PEUsDSmJiTyniZxEt//yyijhjgkQikmJbiGXuqLtyl0b+p0JJuC7H2Qgg6?=
 =?us-ascii?Q?8yTE3gKk5zR/d5wN1qDE2A1TMbGSFyEJP6A7AQz3+wIskVGlPen8s7abuBUg?=
 =?us-ascii?Q?+q24wutZaVH5mDgezH5BdJDXgta+oJXbzoAQC2xVziRf8afJNhm5/Yz0Xl3R?=
 =?us-ascii?Q?JJniBYTgKPt8BPYqWxEM3YsM4GIQCRyjQ1m4gmgfzZ0ubkhjPHJO920bJT5t?=
 =?us-ascii?Q?mhAdNq+bmSSHXexuX4XIMu32VUmOpeGU3Ws12xlFnPJZWkCodfuZtPN2k1Vv?=
 =?us-ascii?Q?eLNKEilg+MYnMJUZ9aAoGco9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f75e4f-d90a-4633-245a-08d96df178bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2021 09:10:12.9456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e8CvAYQgZ3iRM7eVlxciM8nHCIsYxR+Fa8KEhhuO69k2P3BcUQPH789hjcj63Tn0tqQ4H1vknkJ01qYpdkNH2e6B66eiTRawQjpz+uClmk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR10MB1750
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 August 2021 20:54, Carlos de Paula wrote:

> This update adds new regmap to support the latest EA silicon
> which will be selected based on the chip and variant
> information read from the device.
>=20
> Signed-off-by: Carlos de Paula <me@carlosedp.com>

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
