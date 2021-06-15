Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C11D3A86A5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 18:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhFOQkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 12:40:23 -0400
Received: from mail-eopbgr1400121.outbound.protection.outlook.com ([40.107.140.121]:4101
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229689AbhFOQkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:40:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qgx/vhvWO0rckqUcBZbSKX1e9Xw+cLiZqIqLpjVW8wwcsLx+DVIuanXCOdfS3H5A4SLSMp/nfE/4LqmtwwJqlVrQlKurlqLWwjhi/aiTmAyrqq2tlS0iNQsjB0B4GQHvu41O7fGUMMrTWjyF/GJ4BbzG5YHzBavizggp1RZxKppiOrzqBBSivFfV7YR/5gw3Cv0DpfB06Wm0gedfp2IWklKQFg7WUqZayz7Ae/CzGKEBO7Gdex1AdvKrZD5+eNCsrPTKMmlPbB4K37AsdlFG3Iyagtlyw09KZhDQ6sqAp2F8t2wK4S9amSZ0B4ru34AXNKc3pKEgm+ZKaHwoiYPPKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilONpmBAkAtoVkOabzR9MM8Lvb6EV3QOS3wNyQgzP1M=;
 b=D+KLStHAS3Nawuio+TQuZ2BDBGQFM4jRB4JHJbSEfOz4rYCtpzMwg/dU7GP7zBw1bzD7IObZhe7g8jJqlCoH2biJ6wDtdhffSTdnVpbWA4wZQFAgdXTLlllDE4Rv4B4wQBNVs2LcynANzeyYXr4aJnAo9qujzoZ2bTA6vHkjeFdT5jC9+xgKYHwGZ++d3LWaohuV+LWHaty2Ab604LzoeyNQscRe71o9uZQ39JWH2lKD+sjOUf+9kD9X56FHRZGfaNNF1rkCU4u211uZtyb1lI1NhWIR/jSUL40xPM8CiqyTGGvCr+y4ki1bOmUYIP1S0z3lAnPOk0ECpw4GmavQ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilONpmBAkAtoVkOabzR9MM8Lvb6EV3QOS3wNyQgzP1M=;
 b=CEEkttPYy9ppgKdUBw7hcglEZ8RBP+3bRVw8HOLyxMbCAAjy+ksHFvF/gVxyyY2eYe5Y/0sRIXPYe28TWuGh7sq4HnArX9Tm/JNzI28eWsfexkmTxZisuJMyd9Cqd7DUtwSLQwNTcZClVwE9JiVnKUcwx1ZmIP/CSOrQAz+lavc=
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com (2603:1096:604:101::7)
 by OS3PR01MB5672.jpnprd01.prod.outlook.com (2603:1096:604:b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Tue, 15 Jun
 2021 16:38:15 +0000
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::a53c:198f:9145:903b]) by OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::a53c:198f:9145:903b%8]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 16:38:14 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "grant.likely@linaro.org" <grant.likely@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH mfd v2] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Thread-Topic: [PATCH mfd v2] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Thread-Index: AQHXV86EpPNANrzU4UCJO/Td0zuOkKsVKxiAgAAsQzA=
Date:   Tue, 15 Jun 2021 16:38:14 +0000
Message-ID: <OS3PR01MB65939641C36B650A3B69DAADBA309@OS3PR01MB6593.jpnprd01.prod.outlook.com>
References: <1622652224-19103-1-git-send-email-min.li.xe@renesas.com>
 <YMiwEYLkbKocs8ux@dell>
In-Reply-To: <YMiwEYLkbKocs8ux@dell>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8d0c5f0-1baf-4bd8-09f2-08d9301bf906
x-ms-traffictypediagnostic: OS3PR01MB5672:
x-microsoft-antispam-prvs: <OS3PR01MB5672BB31C5E2B7C849999E3ABA309@OS3PR01MB5672.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Gem5U7qe6mJAYcQP+yjixIUNACybO44/AlACfS7n7o/xufjRnCBa8dUZBuzdowu3SeEApsVsnJUb6sPsgysEwPQZwzccD6qLazw7IX+ikmNCxaw4wC0p66PbjYLkXKIfigsIB+AcujKu7+sgXoBCtKU5gKt8UuZjHYNVIMHMa4R4eqmA6kx0dppJH1z/gp0KhQSjtNGRWNo7LnEk4kxe2/PIV6Cidvj/tM6nkzw2hgOrx3+239Kz/xlNfCagapfESUfyzvIOubV5WmIVJ5Iv8bvePMBj8p1pcM5fzkzrx/qEDJgEEl/oq5ZEoTHMisBC945K637sTXOOZJpNiB43zTWxRVpFYSqgh7xErNl2iaySdw0JIky3SVgtIATrLhdb06NlbQpQsXwZ9axlrL7NfiP61xctwpuolksOs2OC4SVpZ0u4Wt+MCahxzNI99NkW6yC09JFvs3pviOzvKMg4fGRYuqKHd2DjGub3bxgM2ea389LK37Rf9JcCXvpHLQuR+RbJpMCL3pilhxt65ga8oFQiVDHznnnFSWGaDADKdIkhE+/rrmiEaq7l582LA+gQPem6CdcW7O65QxEJuNmAzsrspJ3Tj2YGK19daz63rg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6593.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39840400004)(136003)(376002)(366004)(346002)(4744005)(6506007)(478600001)(5660300002)(83380400001)(8676002)(186003)(66446008)(4326008)(38100700002)(64756008)(8936002)(26005)(6916009)(7696005)(54906003)(122000001)(2906002)(66476007)(66556008)(66946007)(55016002)(76116006)(9686003)(316002)(71200400001)(86362001)(33656002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H/Bk3UG4xtsMtRS3vJ22RJGdr3i6h7JqeHrY6i/Hl/MKsfU9Wl9tkso6xxPY?=
 =?us-ascii?Q?evblh5svx2hbjRDd5yLRGAsl6Cl1ilBykBbkwRXpyxaDqU7MH0ICDN72iT+O?=
 =?us-ascii?Q?jNdJzc0YhbotjO+Q3Bxc3yWsPUGjfx3HYUWcVzbr9yclHtpegJKuI7w/Bh9B?=
 =?us-ascii?Q?6zmELxFJZNSTCIV63Sv/x5kjHdZOKHDmJ9TghRtW8ABdCp3nXK3q7qHoMzl+?=
 =?us-ascii?Q?1wm1ORP/+B+oShd5UE7Z6YJHHB0DSMWuwXLMQbH8kPh5bIXR5WZFscKbLkIy?=
 =?us-ascii?Q?cDiH/zCbZM3YQesLpVacizKu7dK9N/cIFrOFUXA5mxNNNUWUTDz9UZNuIcgs?=
 =?us-ascii?Q?pJOuT8ivCRI3tQRZvJpfTXfe6+7bQmKS1n7ydYGZJ2+c2bd2D+4M0l4kjGk9?=
 =?us-ascii?Q?B7M4DsS4aTbepzqjSosHUu4ZMS555400pAVaAu9xt7YARwTFvX3crQ1UYq3U?=
 =?us-ascii?Q?OVHkAiIp38V/hPBEMAemeeM/KAIrXEMS+NauLhetbr2rklLPm7FuJT+Ydn8Z?=
 =?us-ascii?Q?lzKLRrSuUn7IhZdPIzID2t8IUVCvHi/yEYjgpOyej8reifhjs8UW0VWRLc8c?=
 =?us-ascii?Q?TfWArILJA5b2bxT1bdntzu9kW5YBcdyVeu0u9EBOyxG4DGQFuQ8HwvTLFgTK?=
 =?us-ascii?Q?iF4uluR2ANrKS1CIJw6bJh3vV+xpYwu/UHTWKjq2NtUJilfK8Tb9iglOiQXR?=
 =?us-ascii?Q?9fo5fAcnrrn5dLIs9Q7cPrIfJqca0NfHu1/gEVdtzH1MtyTp5+Ff6aeblpaJ?=
 =?us-ascii?Q?/Svvf8TTWSg+stjgkvNu/Ih9aijZLeDs8+E6lfJtNUe8GCZnNJYdAzeuxnl/?=
 =?us-ascii?Q?1dg9/UJcPScBnZcC/uFJDAfyve+wSzgbW5VKZcHrmn9+yMCMDfKzTOPwebAh?=
 =?us-ascii?Q?vQ6FHs4acRYfE1m9NdX9AGCA/Qy2XapoCgh/PBgnlpsB7YVU1IsEGQWaDvIq?=
 =?us-ascii?Q?57EL9yI1dQhaQ7F5AHTHNywO02bmT58tuJ0fezd865/sustCBz58bfV493jA?=
 =?us-ascii?Q?n2Q4bozzfBnPdQYEkTUGcJaqY/GX/fdsTkhtiopcytlTZFFxB0jFX1SOA2kj?=
 =?us-ascii?Q?Y/OsxwGuc/uvBCize1BooVxl9VGWGhGzufJxpnSg1ZO1nkhZQoEmoPYWyML5?=
 =?us-ascii?Q?LpE6E6mc+L3nuxpGltxgqjYUCeRJYUh35at5lBFsjZfPJo7PTy0UE3NBv85C?=
 =?us-ascii?Q?5nTHyyQcEU6B6HufbAtyX4GMyxZx+sbjQdM1fTpd8C8CKgCImhAVZglnDOPv?=
 =?us-ascii?Q?dzRPCPEnk1P4+0yPAG9sjpVUmGHCQscQpxwDCP+uhxC8Ene6lSx3fXByrfN8?=
 =?us-ascii?Q?PbMfd6EJQ0zzNG7oa8f7NDuX?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6593.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d0c5f0-1baf-4bd8-09f2-08d9301bf906
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 16:38:14.6901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +xw1FOYEAuPciwVuZG6zJILwbot+xwyezn4dzcbvgfXLsiE04YaQyG6PGge3+WqEP41Gb1TW1cX65iIIRLGZ0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5672
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> > +static struct mfd_cell rsmu_cm_devs[] =3D {
> > +	[RSMU_PHC] =3D {
> > +		.name =3D "idtcm-phc",
>=20
> Can't you have a nicer name?
>=20
Hi Lee

I wonder which part of the name that you don't like? PHC stands from PTP Ha=
rdware Clock.=20
I was following the name convention like tps65912-regulator.
Do you accept "8a3400-phc"?

Thanks

Min
