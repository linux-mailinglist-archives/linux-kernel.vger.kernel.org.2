Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8151B43AD3B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 09:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbhJZHfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 03:35:21 -0400
Received: from mail-eopbgr1410124.outbound.protection.outlook.com ([40.107.141.124]:1680
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231284AbhJZHfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 03:35:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HK9/EPVKQIDy7d+wKjCEE2IHjFtduHOMYp1Me8nlmDdmtiaFlbBR9j3wGQFFalmgp/LwmQDS6i+P0W/1wL4z8QAefPxjhsJTyzOADlFDGjb6qY3LkX8+3w31HLvT05vNDnjV7MRJ1ExoPk4B+FZZRxYHO/hT91RqS9Wu8qjtGiyZjQ1EV61iFY5fcbXVO8jZ+gTmSpQKhi9tTuHcYsdQ95jtDnO4hm6IpFbMCYbRrNaaauXQxU+unlWMkZtDHqHIP9n86IWzBp2F7M0tk0DBtaPkiteIw5ikDfF/USQE1KSSeXyXvHDy1ULVdF/snMR+Bnckly1xH//pp9WIZW5LWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9G9LvAA8+LUJyRJNt8RXJfXCRXJ5Eyj7uKnD2gPHNw=;
 b=gCAydGCbjd18ZF/5mml2GTCFz5n6YO6z0zutWMv1xOr3v4VlJx8V6ZFtC/+AWzF/TkIZ31C4MehS0Qvt4pEpi6XSQP4PKQg3+omJGrwukMPvtD4GQ2bpA0oxUd2FKYFQOqa9Ydel7kGk/FxQzEppbuPgbZ0X8FUxdIOqRrT/FnOchyAJkTxxFaDEJu7s87Pj7+mO50/aqlZiClbzUXf+JtLnQV7c3+sbIdpKnM6avbRWAttK+52Ecog+cfq56CCQORRvUNUsswTIlkZg2P2Zo6zpSNV3EUK/RXhlOVBQEqgPzket4pGd1nyZk6lfN0vz0JEiwp0Wh8//zkfSdk4ruw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9G9LvAA8+LUJyRJNt8RXJfXCRXJ5Eyj7uKnD2gPHNw=;
 b=E7yTpfAYRfuNMjS9Xq3xrdUOlW0Ad25IT9Hb7KvPcU7mkvcuxryuenNtcevgGXtvJHA0Ho7Hf12popPaNv5WaVo4k8uiHx42brCyHEKKElRci0YrHThGK0LJMkucp3wMDxcDAbbtGJeN4knOySHKLNdYOdKpdX+VU6L4lXZyhcs=
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYYP286MB1148.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:cf::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18; Tue, 26 Oct 2021 07:32:55 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04%7]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 07:32:55 +0000
From:   YE Chengfeng <cyeaa@connect.ust.hk>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: drivers/clk/mediatek: 4 more suspected missing null check for return
 pointer of mtk_alloc_clk_data
Thread-Topic: drivers/clk/mediatek: 4 more suspected missing null check for
 return pointer of mtk_alloc_clk_data
Thread-Index: AdfKO4LDtO5NoLjsTVGcj28fDWnBPQ==
Date:   Tue, 26 Oct 2021 07:32:54 +0000
Message-ID: <TYCP286MB11881F70BD0E5A1F25EC2A808A849@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=none action=none
 header.from=connect.ust.hk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b92478d-4ea7-4fd8-1a09-08d99852d35a
x-ms-traffictypediagnostic: TYYP286MB1148:
x-microsoft-antispam-prvs: <TYYP286MB11484A6A605352E1F8056CD68A849@TYYP286MB1148.JPNP286.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EW3bqCVnwUP2jkenZcZ2NHGrQoGr2EbrM+g2ZeKKNcfZ0pa29om1cSlzrY3JnAWlAJ9VRATLt3D75/WI6DCTsji1aP0YE43A3TbGQlR4WCGVEhf6+RUhenmOSvqqarK5gYf/jkgNyFKEcshTWKoVWqJxTku6eNrB32Y6CGGG4en1pEpWmn7CJNjMwvI0DjWeNwsL8N00IL8B122GEWLqDtZPxYAXAJXBN+uT6W1uz5/fzVQ4qzzDY484JVD0ZNgXrubLH1miMzf9INZ4dsxR3Zw0sAUGh5OTstmOeELR1aBBw5FS8mz9j8n2GuxCsU5iNpHDyZBnKrNaE2BCzZRS1U3GsbcChj/tuEx9v9RovpgjAH75ttaFs/3IrYmN9K8Krn7PlC+8DtioX9VfusJcFvFxFrG25zaePjJ0VQb5muWz3qlYXFi1PP18eCU26tuhFIbN5LelKs7mvY09UPhTgb8H2LA9hbRppdYN6odnuo8fsorCsjLSsXMQZvlkAR/TTucc/Hpot7WCWWL2IL6jcgapMecopKpWMgWkoXTYxA9Ou8DDiiAQwmbKoc1kcG9F4hm6Qc3M3sYkedIn5FsUH6wMc5HRGAhfXL2d/08OvR5JYjcaeOECDQURQQR1PcwMicJlu8TyytQCnLZ+6tfIG/KrtJGiH2DTA4kqM+kSsrQNoUqe9C4QzYpir6hb7I72apPP8MLDNnwfgFkQ8ngdwAsyFbAJw2u6wq4BBzbbheit3ccdFwrGXE4txi170Br4X1uDxbll4+BbxrXJ0QPCjwTTXGJA6Evo0HHfUVA6BN2VV4UVAULAFDozMUudF76/CUwfGwCKx/hi0iOuYBAVyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(52536014)(122000001)(38100700002)(71200400001)(186003)(4744005)(7696005)(38070700005)(316002)(86362001)(76116006)(2906002)(64756008)(33656002)(66556008)(66476007)(110136005)(966005)(26005)(508600001)(786003)(5660300002)(66946007)(9686003)(4326008)(6506007)(8936002)(55016002)(66446008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G+cFnW+VDkpG85Usn2SQNEGopWWZmEdc9Zv3VF6uX8IE4ewV9fn+EmUe//co?=
 =?us-ascii?Q?Bpten7NNzf4k38Fn4mLKGvO0ACyAv7iPnVb2kiBr7KdJcPFxkLXg0aY/A7fk?=
 =?us-ascii?Q?oQvuN0+n1bsrovUAjHhlqUw4DXxNTLnMHzmtoaVz4aMhSq/kdxF1EuZMtrS+?=
 =?us-ascii?Q?udgD05Bs6kQbhIdmT38GXTHsWmTWBbFcQkPOBwqzeq+t5aV2RL6Vx5+9Td0z?=
 =?us-ascii?Q?9Q80NnCiVj1+cDjEjkwHs44qYSfKOzTG6e8fuNv5RYmhHMS2/V5abliFaOH0?=
 =?us-ascii?Q?D4kUlkVogZb+fPcIbRKspoXLb4tFTaZN2M0P3ItkuroNlVW8xHxCAj+EzG+H?=
 =?us-ascii?Q?WxDviUg57RpxxR0d0Zos3MJoVinQdiwomZ57fCg7fI3IB2uB6Um4hZMHynJs?=
 =?us-ascii?Q?+IoSrUqlQ8m0oS1IPJsK1E/KD6rIjdmur3YYtuIFh4W/U5UYFnB0qR6Y/P2X?=
 =?us-ascii?Q?/VIsV/2Teml6K/dWknQM4shbgjU1LYCOX/rVYDnHfTz2HB6WUiJWXZip5BUr?=
 =?us-ascii?Q?YmJeOxkPzdbQzNCiEYn6c4N+lbj/2xp2X/v6JrWwQZJbozfPTFqFsyyT+oo6?=
 =?us-ascii?Q?zg54hNbq9cLTZuP0k7eeVj9Ir5HlopxatZr+VYaFQzIwzjbM/BWqb5Hcr5wC?=
 =?us-ascii?Q?oChDFvYIdMBbxlihdv6nfg8td/0Ap2IuF6L8SHxWu/1UC5KlDImOcNxQ4LwD?=
 =?us-ascii?Q?LDksRndjY3PoeKHJCOnWMYmu7+So40BNDzH0OtXJRanW/YiWz8bGu63EYY8k?=
 =?us-ascii?Q?XanxM2JouJqtpLr4Ou5tEIjEsxgMzVxk87zdRM6MBkWjHnkFtI7CsPYr5S2l?=
 =?us-ascii?Q?Ni6E/JYestGnOC9BfAPA0zXzUcddjf6zjfQ3+OpaEaKGP106ZafsaDD9I74t?=
 =?us-ascii?Q?5auqN/QbfaiZV8ehXvxr6sgJbiOnTAm3qlqQ0dbr5H8cfZz3mo2ODo5IGsbp?=
 =?us-ascii?Q?WBEfMOpVzMJjtxbSllT8XAfaShlKrBX1IY2/wqW4eiegoo0xJumpPmkD1OwA?=
 =?us-ascii?Q?Xf/ixJ3LteEm6anwe3cSXuhlE5+F96uLLwZwvnGSbpIMDe60ir8f3eyzZ0qQ?=
 =?us-ascii?Q?YRrCJyUePuyRij6+BRVHMxMLsHPDEOaE1KoprBv2MkvuwlWsfTeS2szOO/zF?=
 =?us-ascii?Q?1MfOzcuJ5+dNEaQeqztp7GWrKvSJVQxaKWVBBRqBqm5syRSB2/zdhEe3sIYx?=
 =?us-ascii?Q?X95fJu3TD2XHrGmt9c/azR8VxejZiuS3cOTBJqGZnzdBm6iaFGnCrmbrwsUP?=
 =?us-ascii?Q?Y4GwhEHbeSxWoQSIrzsMhQymID8MdC2i10vZRaFqN4f0c1TrKrk4ajqeASu3?=
 =?us-ascii?Q?SDOS2D0gxJYgVsG+IJCYZBYCp9LxsUu2bbWkZDHJ/qZ+O8NZR6DiQ/peBsQn?=
 =?us-ascii?Q?4153GAieYuz4y/dVa0i56J/kJLvftAyjfPRTOSHb7Y00E3neC6wTaYNra9Yq?=
 =?us-ascii?Q?5fzfENr88RJg8tGNkObikA2o2ttc4Prz7pkZDXUY9+tg7N/N8OmfSfYY/g41?=
 =?us-ascii?Q?XQLhK1tNJU9ETZ9v2DLz8TAdGRTTy51zpux4P+f2JtOJmaSUO1GGgChciB3E?=
 =?us-ascii?Q?/Uf6ktkSEsgb9izzj5k4om+6XlC6NF7wdUrVc/ob9B78yZf/QRAdSSQ1bB4C?=
 =?us-ascii?Q?zspQKOPIgya3lyY/x8YXTxM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b92478d-4ea7-4fd8-1a09-08d99852d35a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 07:32:54.9218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PZ2plwfrpUNE5ATjuy9vDZ5FY9GqniHI4rEAPOjrE8pHxwpHnw5Fwz0J0h1TyMqHWCfmrfwjP+OhTTRglr1eXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1148
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These are 4 more missing null check for the return pointer of mtk_alloc_clk=
_data found by our static analysis tool. We manually check them and we thin=
k they are true problem. Would you like to have a look at them?

https://github.com/torvalds/linux/blob/master/drivers/clk/mediatek/clk-mt81=
35.c#L528
Missing null check at #line 528, potential null-pointer-dereference at #lin=
e 535.

https://github.com/torvalds/linux/blob/master/drivers/clk/mediatek/clk-mt81=
35.c#L549
Missing null check at #line 549, potential null-pointer-dereference at #lin=
e 554

https://github.com/torvalds/linux/blob/master/drivers/clk/mediatek/clk-mt76=
29.c#L605
Missing null check at #line 605, potential null-pointer-dereference at #lin=
e 610 (mtk_clk_register_cpumuxes will dereference the pointer clk_data)

https://github.com/torvalds/linux/blob/master/drivers/clk/mediatek/clk-mt76=
29.c#L582
Missing null check at #line 582, potential null-pointer-dereference at #lin=
e 593

Thanks so much,
Chengfeng
