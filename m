Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B3F43C8FC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 13:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241744AbhJ0L6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 07:58:22 -0400
Received: from mail-eopbgr1400118.outbound.protection.outlook.com ([40.107.140.118]:37312
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241747AbhJ0L6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 07:58:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldNyckFDDyIzI5Bu7wTjsdhql+l3lpjk1TH641buW6BxIkbk/VBz4kjt8B6UUR57ewdcw5cI1CeyvnmPUZ9HF4Dr7FPPSEhy9XwaF5sMS1+DlnTAYLNqUjhQwhJf+sry1xfDn8wV2g5EHtY+dpHLticSCIfBS8BqeJL+gMwJGumbmxElU8sOtF9EQMfZNJPEiT7Fgo9xmSU1HonIF182CS1SrQ9hK0DNqf7aX+sdyh7XvY+HobMUCHehoe3ys7SG0bgZnea/m6S/8PXqWS3Hudr0AXxqNW8OzirtWpsv0UzLfZHQC7ZA3I42l7QWhVql1XaXp2pqBFph/DTp6ED7NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHpPbJXXg0xHylAt61GTkBvWfOD1010i3GJcs+gs/Bs=;
 b=a0fE5+mK4HGFc9ysE8v8IyvVt3baQqQ59e1kg8kzZPX/5uyvrwnFh/dC5MfuwNtdYcA3EoI3Q4qlaDSpGkbY07vda96MVbzXZUX02FfF6ROAzo1mogjtRN6FNxXnkqFsNG6ga0DuJmrQQl+hp/qJKbegZnkLFUVTsHVSUXaRw6a8PtjJjQ3hTczVYnZKzY67EonbMYcHZQenN9U9DXHUSB8ueqj5pEnmi43k3UcW6n874tffmtB3CgfeUbtJ/2zR9nEdqEWv4GKcdrmUgz+weCcsSaiY2GlniI3E+RhjfVoQYApfs+6I4J3SzMuBGApoqc08g9/LFUj1ZrEKTSoOnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHpPbJXXg0xHylAt61GTkBvWfOD1010i3GJcs+gs/Bs=;
 b=pA21ZAjctdrdNUr+96C3nC4tj0iNpDvDTN1quPq91o3P4rM7/MRokyu4GKFwit8uwmVcsJC7fZfDbweX/5kSpUeuOmdcTI7iWOo4ikRRMBpXvIps/QQJBDqETxKsb3N5ZQZzcKZkE9TVTsN25/n1ssyIqilrvxjUeZ0QaBWmqd4=
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYCP286MB1121.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b0::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18; Wed, 27 Oct 2021 11:55:44 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04%8]) with mapi id 15.20.4649.014; Wed, 27 Oct 2021
 11:55:44 +0000
From:   YE Chengfeng <cyeaa@connect.ust.hk>
To:     "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: drivers/dma: suspected missing null-check issue in
 dw-axi-dmac/dw-axi-dmac-platform.c
Thread-Topic: drivers/dma: suspected missing null-check issue in
 dw-axi-dmac/dw-axi-dmac-platform.c
Thread-Index: AdfLKYuMRGfCkdCWRqyym5iP0Dmdrg==
Date:   Wed, 27 Oct 2021 11:55:44 +0000
Message-ID: <TYCP286MB11889A4564B880D4E75FDAE08A859@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none
 header.from=connect.ust.hk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04caafb0-f3e6-4516-1aa4-08d99940b51b
x-ms-traffictypediagnostic: TYCP286MB1121:
x-microsoft-antispam-prvs: <TYCP286MB11211F7A7AD8CC51BFA01D358A859@TYCP286MB1121.JPNP286.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kL93Dw934y8P8gXbupBqGxdgyLzGUdQ8DgOK5QBq3DxqRqAXhKVkbGQgqQ1+mLXKnVTFFNeo5J95EQ6BTrr5Id3GOqPCTOvoRykAy7JAbCX8OWX3cp8+qKSY/kJhc5fYybpJ5Dtrhj32JhirvkQtqm17K6lrsXN7ju115IwIDLAEvIIY5zfx2joVYRQWBneD+T8T+MN6iCFQO5xhXjTZz7UMajjzX03Fc35PCw5+2OjuFXGv0UNHbv6iJ2C0xsZi0f8SaX2927wZB5IK8pQPkt4h9mTp0GScIWF2mq6afCOgyVJuMbcpWYKUwJtpIUBXrmNWP803QyT6/3fKAf0NKlujhpmeih+/hVjBO4jftBwkhCXQU2CKG0NP48fxWMRxpDgBw6YVEqsgKjg/4FWeeFSOa16ofkBX4Uce8fX4qgWGL5JtwdxD1y0zSlabN+qG/hqrGuh0/sTwLQkOrTyhxMCIJOQjN/+geRSc57TBJDENEIIfJDMbzXT1IuFKG5NsLYTgQLGGigP0Hdd/ObZMgsLuhGphxm64A4pnTjEmhZUvgBUW5t5AP+h1QL5c0IwPQmgd7YvWzCxXeLl83TDCht3snQTbq1AG6BVt/9+FSEpSlV6wmDql7E7DXo9k1Oe6rGhdj8lGvA4ksltyZRfnIODnxj4c8CBffVfZUrESBHWmzZ2fDCado2lVJurJO9MeOfCrx/jEjg050c5ajsrsGD7ew1XG2eKM6S5QU5T49I6vbAHMhQaQQ85RPptfG7AffJKIdhfZiNSPSqiQzejob3CEwMAYyhD6xny7naZjmI0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016002)(6506007)(83380400001)(86362001)(122000001)(508600001)(786003)(52536014)(38100700002)(71200400001)(7696005)(8936002)(9686003)(26005)(110136005)(186003)(4744005)(64756008)(76116006)(33656002)(66556008)(4326008)(8676002)(966005)(38070700005)(66476007)(2906002)(66946007)(66446008)(316002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AKSgdNDX8Fpn62BZfevyyZIWW5+t8tS2b+o48JpmTvCbCMWar6DfKQQPSe+z?=
 =?us-ascii?Q?wv57Yd/m5jMX6e0H/F0gVr22u9bdJZC3+MFtlmtIiB9+t1HNjRDtFcPzJmgv?=
 =?us-ascii?Q?fbbvI90UcibLTIBFiVyJnmh0sSmfVAfOOL0jyuDry+DYH+bK+YXxMrNgibKT?=
 =?us-ascii?Q?vfKWryP8FXaec0GD7k7kfkJWF/douunOlpRAJfbzuG6YtkfbWxYh9Lvlvih2?=
 =?us-ascii?Q?9vY0kSFcJChno67FL+ZpOEG914ECZ2TQUO4w3RcFkxfHkmfNVY935EmlUms9?=
 =?us-ascii?Q?uz9mK7rwA5f0et+uKrkdfx0Tvo3qBYMhYO/jua5H0TAHPyN9xqQ9SrV/B6sD?=
 =?us-ascii?Q?FRiop9/8rZdVim4/3q8Xb2cebntpS88iOZhAXQQZL54VYJJsV6Zb1xQo9Iq4?=
 =?us-ascii?Q?yp5pOF3gme+CLw8Kk8KpeBxpsuLysEDUQpw6vAMATHBoh3SxSeT+juxvJsp/?=
 =?us-ascii?Q?UWzSSyQ/RpGP1l3F/8QXEWbpLYg91H/8DdIbuwOMLwRLIxrRnrgWPhexS8Cs?=
 =?us-ascii?Q?oRaZBseeCjjKQGbczht49wxOon1WsAHBAtZ1a3M6n08WLcHoD7j97f3nmMLD?=
 =?us-ascii?Q?3ZUiOrwJGJS95ec4o+iIIZTPtLgKmmPmnmxjClgFSnlXgZPcNkjBXlPZYgTX?=
 =?us-ascii?Q?Ri/8orytuIH5meLx20MiwmwdJz7/PLKnCAxDvbGZSE92MWREor7PancM9HsS?=
 =?us-ascii?Q?eiRIhJaBU/KF2CUH5oCNwnWaD8Wj3f4TpYcw26qWzN1qUs4gnkUeh/JAi6/u?=
 =?us-ascii?Q?wDVJAYYhwMbHdyayb6nCHleb62iIRhwnfwHVXlLMv8M4bfsFPKARfarDxRl/?=
 =?us-ascii?Q?/6PANC+UeFoePn4G0oNHoI/eASTN+6/yNHJX9KQZ2cTckhW1DR53btVTAkKp?=
 =?us-ascii?Q?ZrdMU0QlgXUgWYNX/Opua5wl8Lw+x0IdGwIzBNEgUEi4kwRWNNzb1vtHLILl?=
 =?us-ascii?Q?pZnvfJuE48j7V+/bsZA06Pd6cqzp9Kcw8dvSN1DRrgNAE6nxwnE27Ivk5ibi?=
 =?us-ascii?Q?N3WG73UbWt9wEG06i+Yw3va292zOjTGRDlooUQW/Sf3/SzpfIADUJw4uPBUO?=
 =?us-ascii?Q?rLru/DPDE58e1oEEij5qyISQ2gzVf95g9sMJVCCC30BYseVGy9zmXqgSC+qw?=
 =?us-ascii?Q?jG9g4xW5qKW6icIoLtby6pJXg0HCVn+jsUbmUGRH4ukTtvEIXLHXCxl6aJ9S?=
 =?us-ascii?Q?xuHaChJH0/fdoybt+09bqCLN+Nb1jek99zcFKgZN1AtEzSdnAujXyWUYkOc9?=
 =?us-ascii?Q?hwop7MNnq3EcgQCSJCZ91AOTS69wiMN9BzthaJJH4TEhNZ6K/Ys+71bgs16W?=
 =?us-ascii?Q?jXm0MQ9OjUzDnjFr7DxvDYgYlROWvajckMWhJ/mznXot0qf0wiKM2CUU2EDK?=
 =?us-ascii?Q?yioif3BgSalUO23lYYxL8O5jOuKtiMcV1h8TjRkoWEBaBMbFm3f5Y6bgfZfc?=
 =?us-ascii?Q?am5eQtCg4YMngQZ+0EiOCjcbVa8wQqUVm+fljRs2Y5t/1GJXxMSs6f06XlMn?=
 =?us-ascii?Q?l0Os5eNvz6aSoEwQrsA1b8OjIXpFZQC9oJLBWPRD7u1z73mq4NIho3YKt2aN?=
 =?us-ascii?Q?EmbyrIngxjQRzRXIlwwTucpIB7pDH5hspeyDRgd9r7GameS5AfmxSsUfzeyC?=
 =?us-ascii?Q?HRBoOfRe0Vl1a9oJXe89EQo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 04caafb0-f3e6-4516-1aa4-08d99940b51b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 11:55:44.3212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YmQs/10bfNI6GnHjVVADrsnXCb1w6oontgMBFYe61S00f91wClCFoBo0QneiCfK1Q+Pcxbd6NYbddUSEl9gKqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1121
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

https://github.com/torvalds/linux/blob/9840cfcb97fc8b6aa7b36cec3cc3fd763f14=
052e/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c#L982

We notice that null-check for the return pointer of vchan_next_desc exsits =
at #line 395, but is missing at #line 982 and #line 1018. Could it be a pot=
ential null-pointer-dereference pointer?

This is detected by our experimental static analysis tool, it could be fals=
e positive, we manually check and report those we think may be true issues.=
 Would you like to have a look at them?

Thanks so much,
Chengfeng

