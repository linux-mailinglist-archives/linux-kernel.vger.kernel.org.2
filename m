Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE415382F05
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 16:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238763AbhEQOMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 10:12:24 -0400
Received: from mail-eopbgr00085.outbound.protection.outlook.com ([40.107.0.85]:30198
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238140AbhEQOKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 10:10:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqDIlJWWOs8wSSa/7LWFHMvI8apMubwgyAuepOah2ZqdThmURIfeaWHV1uSoCt1NowjQFIsy+6NAMOU4OTR6dFRkqWV0UGk+b79fgNjMZ0aXILY2BPBa81cpaqIoSLlAN2sHU/XcIGepcgfGryHQbyVeFKDEv3YwOyGGL118FvU2aOupKPriQ91tWI7zi26vEb5D6nl0V9VKccupdD26FMRCk6aExE3mEEyyRiyZi2h3W0pt7U5vk7ULMm8EJpd/UMg+YQ2o7642goycPoS97RaS30MUVoyapjzdxzKDGhkImGgUIy0n0Q24n1Qikj0mMPQvnfWTmX6iWt2dCBbeZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnoIYe9jnCgmIKFtt130wSqVM1YRsKv+saUbWMgkT+o=;
 b=AIPJs/X/AGiU3kLkDkcNARFiQLO2lEHDyiLwAUJY8LOB703fEQ7HLriQv8k/iUjKy/O5112mhQ3qk/fgWUTkj/8oRVZEuaxtwKWkZku5PMihS/3wpAZICj97mb/VUWFJ2eV2NlUDfET3ZWu7HpJG6zzg4Oq62qLgeNPI5XGe8UyPxzrP7nPp8Sp7ZyFSSUyYsEnTP2ofdqXLd01OUPkDeLQnpqwcNPJ5z15g4gVBK9WBIiRx6fFEkut30vLbyKsPmznjFk6J84UqjxLV/5uCUR42MCWj5iM1figgQIh3IIpdnz4iFBLm+Ca/WU4wZOFPtdm3zMIggB4g5OL0zV2M4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnoIYe9jnCgmIKFtt130wSqVM1YRsKv+saUbWMgkT+o=;
 b=oAQierWxMEuGjyTgxzvEGbLaFahGx/1p8UQ1kegKbvaKQ2brPknzDPspWwSCbOSwlmPy47IX6GEbG3bkr8xITsb30KLXWszBEAB435N3xxfxIKyGetmouV6FjWFvDIr4wZf89TJxcEUgQ+kzc+If84yvlr3RvFzPkW3b/Z5Seis=
Received: from VI1PR10MB3167.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:12d::15)
 by VI1PR10MB2046.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:3a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 14:08:55 +0000
Received: from VI1PR10MB3167.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d843:6b8b:f783:31c2]) by VI1PR10MB3167.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d843:6b8b:f783:31c2%9]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 14:08:55 +0000
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
CC:     Adam Ward <Adam.Ward.opensource@diasemi.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] regulator: da9121: Return REGULATOR_MODE_INVALID for
 invalid mode
Thread-Topic: [PATCH] regulator: da9121: Return REGULATOR_MODE_INVALID for
 invalid mode
Thread-Index: AQHXSt1WvLxGJ28QUkaYNcYbLRQkzarntaJw
Date:   Mon, 17 May 2021 14:08:54 +0000
Message-ID: <VI1PR10MB316722676183BDD61E1C7AE2EC2D9@VI1PR10MB3167.EURPRD10.PROD.OUTLOOK.COM>
References: <20210517052721.1063375-1-axel.lin@ingics.com>
In-Reply-To: <20210517052721.1063375-1-axel.lin@ingics.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ingics.com; dkim=none (message not signed)
 header.d=none;ingics.com; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [147.161.166.97]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bee1bf1-c11b-47a0-2a56-08d9193d4e82
x-ms-traffictypediagnostic: VI1PR10MB2046:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR10MB2046A31B3D5577E3FBAB1E69CB2D9@VI1PR10MB2046.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ulQ7WdyjJQvPs4vmN+2c+OV2alYnZVTsj90fsdqiPhTwsrd3NjmN0UaNuR0KaBrrNZd7ZptLCiUGChshwgd78LYIP1uuj2Y55DNJ2xZ3s8c1XxJE2LA2UqrAHXxExFJLGcV1jtnRC9EjhFPeNgShxyL0kTUADF93wgbXhyCXV/bRVSqmhlTizlsriTZcvxZv1vePQFtI4EtkSPuDWUAIfH8EgKUWmIRt10Y9QLDNYv03aEX+hsdzoCkTaR0qiQdOkoSoTyygzWFMRqIP6Tes2EDc8gsOLm9okqIQsVztIjq8Yw/Jn0wNKYPYog+3nZ+wJm+winAPYQv/YCBqJupspfaGTg1+tz1FH7SAgx4tPgM9Q7SHUK1oTJRVk9EzWDpXYQfcVUxA/ktUc7ekLl9ZsHAg97HKDASoQ29r81OG1wShGwIYq0ePjZ3HydyxL4CZxRYNWK0+SGYC16xhrC0f6D+REJhlL48e4O/6N2+SwdUcowOeVIYUqPNvt0igMIdIzSWJL2IrmHqBH71yoaF+XNlch/cWU/j/YkB0q88ld9Jm1KAjCGrd6ccedxTLxNRRqtyX20RMvavlZJ0CHtobPGY7oIQfJbvJxRFwan2w1G8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB3167.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(376002)(39850400004)(54906003)(110136005)(71200400001)(122000001)(7696005)(8676002)(66556008)(9686003)(26005)(64756008)(86362001)(66946007)(38100700002)(55016002)(53546011)(76116006)(316002)(558084003)(66446008)(66476007)(6506007)(478600001)(4326008)(33656002)(5660300002)(186003)(52536014)(8936002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MsYj4bDjtwnX2oeY8j31tAtVJ7uivKzvtw/3eJZBVE9o7Um7E9V/ei5XS1aT?=
 =?us-ascii?Q?XXIpoN83KIn47n2m6pOoIhuxV95OnNJo3hQ8Orpit+gzQ+35O5+N2xTiLwL4?=
 =?us-ascii?Q?h68icIesslw1fZgWTunaU2RXUFLBK9aYEeKwhutZ2njsMTGsA7iAds9WvsAY?=
 =?us-ascii?Q?2TcSBkDsjBY1rTK1x4r7pHqTgBD0EszBbMzTc5FKdIpZEI6oYOcOsFOjpZfg?=
 =?us-ascii?Q?bIeoewY+C+b5D5MWbnB6hauULtF+aVHYqyxVxYNPXE1G+OZEVZTVRqxNNU1b?=
 =?us-ascii?Q?oa9CF2aPKMXWArv+3jEIbMll6/+BRCfb+tL1b5iy32jMKn7U5ddGD1r5RazX?=
 =?us-ascii?Q?0hw2XR6DoI/SLM8FazwTmmnxlHb1do8RCqsPxw8pAtArfElu90KzhOKh1m6c?=
 =?us-ascii?Q?987UdcP6nV5Bk8a+aYpc5JwMBzJzzx3TlxELgM0x11MeMzkept2/c/40eZTS?=
 =?us-ascii?Q?Op3nK3IoLFWq/bQThSbPWbd966GFUUD1XuHn1jj5oCGbQqwqTswtS5ps+dMq?=
 =?us-ascii?Q?Buu5aPcwfF7Ldd7FkP78+XnchxQ4vox/aWQfhiYR40BBCVraShSypqNfbY8Z?=
 =?us-ascii?Q?TJPLlksUnuxga5CP0uuDOQIKnDNoAOiMftyDFzIH+YAzNNc4IJt3GDEQ+gOY?=
 =?us-ascii?Q?4O68gzrl2OoY8oHIJ75nJaW1HKsOi7cAxKQf/shANuGU+juYZeSHZYOOhgy/?=
 =?us-ascii?Q?x+RSfIyuufGgShiR3enYamDhCxZ998kSdaNZpP4uvULp431OzYU7UepzYeSa?=
 =?us-ascii?Q?mdGhaaIZMJ0mUSC3JsVUicC1dI3icpvSIq9r4WsiFMlW/Xp3wB2DdJxeGJfY?=
 =?us-ascii?Q?3stTBIgflIeeDLZxiFj6bVGDK6lp0sfva0VlZyILIGy4U7mn0lK11BloZoxh?=
 =?us-ascii?Q?EeZ7BJ9Eqvczt8azb+4lO0R/oxRvNzlrAJKI4v2odsPqvmO5uYFcYmGCcBp9?=
 =?us-ascii?Q?Yc4EaJSpgBJY8U5GlsDy7Aqa441AIgn8Ed7kx7WpvzWV95/ZoKPsps55JWWu?=
 =?us-ascii?Q?/mHDkZ16Qzj+P2kv7ectnVZsO4+OxjnQ5vXuv9OULysiXz+Jerjr7usbHemG?=
 =?us-ascii?Q?XhzR85135fJ1GZBYe0N84vgvcTrb5CjafmSnlio41CadC3gumIflZd7ubfxX?=
 =?us-ascii?Q?uEo9V3kMs/42h1JjRi22g3iiTuwDAQ3WqVQzHEcD0mPBsN6uw+N07wFlAMfa?=
 =?us-ascii?Q?Iq2S9T3vhZFCUPCKG3I1WeH+/06/fQ5zjXDiCADLFm1oxX/54794B3BbcYn5?=
 =?us-ascii?Q?U4qIgAPWnYVr4qO9+g5LVMqtSgDvV2JJXQO1SXJYRx0ARPbFQ1t+3Ew35C9l?=
 =?us-ascii?Q?C8QxDxo/gIDgg5HWTjZsrAng?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB3167.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bee1bf1-c11b-47a0-2a56-08d9193d4e82
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 14:08:54.9343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T7KcW05FhoElvmLcQp1JwyYw2oePio5YrbJPbQ/4pivXc+KcSoVHZLO288NG+XfFlCOvEugkIxqDMB41hBGPsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2046
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 May 2021 06:27, Axel Lin wrote:

> -EINVAL is not a valid return value for .of_map_mode, return
> REGULATOR_MODE_INVALID instead.
>=20
> Fixes: 65ac97042d4e ("regulator: da9121: add mode support")
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---

Acked-by: Adam Ward <Adam.Ward.opensource@diasemi.com>

