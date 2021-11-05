Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C78446050
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 08:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbhKEHzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 03:55:15 -0400
Received: from mail-eopbgr1410123.outbound.protection.outlook.com ([40.107.141.123]:43048
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232068AbhKEHzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 03:55:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2TG5smqQsPRPKWrPFDpFfCyYzW5wZQi+G6KEcRlkPlcdadZn6aa30HxVPUnl54112mQ3G321tkEcqLNLO3nksgsMg7ePSt4VaBPFfJHjxGApmCUCMT9d4M0Rnsgap3Q0nfN7zKRCBejrOrtz9Xt+yJlcdIRIxY49UmwLrAP8Krajwmhe6Nu5dQ9k7gF6Isn+tAiEFz3WaKnk0OgVrsJMbKluQDMgF5LJo3ivj0jycqn4uzkXq0J1OoGJBs46mJDOkZGksXN9sAMq2wGr5TANKk6Ur8vfSCXI6T/G7Vc4nQmF03JDGp9MJBTnO3Z+laCK7xV74oJzW7i5OphqNroSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vufLDtz8aI4UjGcnGGqAZkqtNciKBlszwi9INkVpC0=;
 b=nfBVrqbiMrY5uZ7g4CMXMWZF1QnVfBh2YAAdobSog0IJ7+Q4utLgjRJqS7RtckclGkBB2TmSci4B0cNoGSvn83x36ff/DNzUmRyRgjocLqQDO66mc34De5qbCy3P9RhjXxvsKCBpsSYd3V9WEMvV92pLLfxGYGBfs/FQaMKGnFlvnP2U3k+0i6E9HwH4Iuw+Zu1jU2tid7XIwdF3TsUMPWrcOVVJmTQQJQJodaMXBePiBYv8cOKpfeVj/EfuuXpNjc/iaGiOdDpH5GS5LpbAZpWYG0ou8JaaGopyeUH+81LWa8thjihaIbopKUfx3v2nXWXyqmWwoIgTV6PpWpjE7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vufLDtz8aI4UjGcnGGqAZkqtNciKBlszwi9INkVpC0=;
 b=yn7J/P2EXpEXw8d6VCPr9pdQ2XkdrUNE1lp2iPCjbReMnFdMut8g5z7RC8nWG0oX3Hibo1YOkASpzPXqfOYiiDx6+3VwiRvtlGeAy1G8qsZXJEIm6O+PGkJ9tf26kXsJC5p58hueX0fT++FuTt7TCYgdH/cK94mXay9WoFqjYAw=
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYAP286MB0427.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8040::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Fri, 5 Nov
 2021 07:52:27 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04%6]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 07:52:27 +0000
From:   YE Chengfeng <cyeaa@connect.ust.hk>
To:     "sre@kernel.org" <sre@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: hsi: suspected uaf issue in hsi_core.c
Thread-Topic: hsi: suspected uaf issue in hsi_core.c
Thread-Index: AdfSGfIkdKn+RwG2SYWyfrQGLCAXhw==
Date:   Fri, 5 Nov 2021 07:52:27 +0000
Message-ID: <TYCP286MB1188FCF65D3EA7360DF3DC0A8A8E9@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=connect.ust.hk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1141d622-3125-49d6-8ac8-08d9a0313652
x-ms-traffictypediagnostic: TYAP286MB0427:
x-microsoft-antispam-prvs: <TYAP286MB04270B86ABB97A1BBDCB594A8A8E9@TYAP286MB0427.JPNP286.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G6c2q8nv6Pn01dwCShfQkACw9y4HDFlJUmVIxjc84pBX7WLHMdDHTVMGFgeoOVTS1e6Wo/fW4Jk6WQVMG4xIgSMItBkm0/2jT9BeYkkxke/ZRUGoMS+76wWvJ4UMfDRdGrkuDZFlmbuoZg+8a6sgw/pSH2IlUY5o6FARCWbgx7MtmP8Kz6d/7SnfzETgtzbwji+8t84+JBDSLJKiv/DOmQEeaoRo+3UJ6Z/lpl/9LjQ1zPo34rUS6rKmVi9yEEUbchvFhlF1VQBz/I7wI7scWV8Kn1hFhsRKjqI2CWO/GeGvWx00naRbRGL9jZvxyw6UylwuvvILjwg9NoRdgZFgO8vh6NdBWQCzlJm5fu1Gz48RvKrH4r77vvzYBDuHwf8IsqCuuciEWuXSXN0yOfJVYg0J6bu+hkUxg3Hj1XaJ+9SHTutFfOPCZavFd4OaUuQ4sg4AbDA+DPkKuNnvu4GPR6NnLRcP9JpZPFflxg1tJkGeUcGGHqVg9vUdwuUFQq2CC4hxxva3K89tvJdLfxAJ1sv4Erm7X0AS/RXPo4Ng2l7al3564DJXRqHjCwNyizI4L7aqSnU2uNGaYSHgPv422P9StxsGGVpem7/IFgS1LdL1k0NGNqfEKTEQIz+y/WhFdNtq33EYSEtHWt26X8KjqRGZYbg2gFAyFWwobAsxuhmyAL0ADUXV5BE55OwAbulCQhTqhAu8RvRRP/2E17y2KUL6qtXoFujF7+4Jy/kGozF/tMicNhM+N1Zbkd9hjIAL9PceNmRMwa7bMWdIGy0We03rMTWoiBi5SsCrzk8Luc4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(558084003)(966005)(66946007)(8676002)(4326008)(8936002)(6506007)(7696005)(86362001)(76116006)(2906002)(66446008)(5660300002)(71200400001)(55016002)(786003)(316002)(9686003)(66476007)(52536014)(66556008)(64756008)(38100700002)(26005)(6916009)(508600001)(186003)(122000001)(33656002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xeCeFzVCUil8Rx0ubgRwV+iSwVBadB6kYHd5GBG0zHjfhn3r+cUMgmEBl4Jv?=
 =?us-ascii?Q?3Jxsl8clsuxnaPSg0d3xLh/JaDXlSdKVDsKFNZqKVjaTP+TFoRw+uqSvRrIg?=
 =?us-ascii?Q?0zzRLiakRMDv+nGjq3FDv5PF9JFP4U6bjngEYlEp0MECtCAWr0uQ8JfqwS0I?=
 =?us-ascii?Q?1bKuEOctnUevp7mhbu3zlo8k4wW75mW04FgThDUZq7UohVG5XilDAr58q9bo?=
 =?us-ascii?Q?FgcmYSEqT1m4LQbnQqfO4YCIExZ2RAmJPj6XnjwnrshgSsb2PvrrQ7WL4y/6?=
 =?us-ascii?Q?/mV+cWlDuZKxjDj7wDX+SrUMnQ0J+4sB3uCMmTjlcb5a5XxaTex0GmVKZEh3?=
 =?us-ascii?Q?+Mb7WwRoFNAaQIup4LR4IzY8IMC32QI+emTV8/i5QaASVDxx3oujXkEsHJIg?=
 =?us-ascii?Q?ELRoVld8FpneCQ/q3rAoFNjCsyps6Jl9IJ4QDTe0D469r9fgsxNMlIwmDOip?=
 =?us-ascii?Q?Rhwufov4rcMqcFt8zTIp5ZcImeFtfTSd9ErhX/WnFddOLjWpZ8i7VOfw53no?=
 =?us-ascii?Q?YWoY4wYejSPnRDH7zLM1Qk6WBPR5ZLR0Vc1Iq4O8CSE6O3TakOOX7LF4VhkJ?=
 =?us-ascii?Q?lHNkF4mFsAZV6i4GBMBQ4Mdn1dpQlyF3jVzICJvdkatM6XLX+vd8YHDI7XGe?=
 =?us-ascii?Q?jp8EAww9ZjK9gEb0cjBCVtIf/lOK0D3XXYUaNSYNL50hPOAbeuh6k8OGSd+L?=
 =?us-ascii?Q?UoXVBxtRjmRSB8bqg6a2kzi60mXEvH9O53vFFluZixO8lWCCEmctq9YLpnMe?=
 =?us-ascii?Q?XqBivkCA5tAQ9seDdsAQEb27B58RRaKbB/r1YHasamc01N1gAACt7z1HnWjP?=
 =?us-ascii?Q?xFIZlGYaDlFlTG+ktkR4KjZ61aZYDI1R5aOkeOQLyf0ZpnJPnx7+n58tzNW3?=
 =?us-ascii?Q?Xi9mmWNLjAyVD0H+IEkbJDs07fdQ1U0hYzX39jAqZLXLHy7d6RW9UyotWnMh?=
 =?us-ascii?Q?7y4U2ZV6VvckSXcM00TjFneNKuYIs6LM8W3n3yg2AR9Th6YBOuH4yvxzqLzC?=
 =?us-ascii?Q?/s1m6NNZ2wu4tWWxxdqCOGwHMyJPVCssW+ZBe0yyAJrbmO/Ha+IWEvraKnBD?=
 =?us-ascii?Q?xxVwUbi2V9xR7nYMHiT4QoZJSwby8kQHaD6CwCBRyA6RMmVeTrWfMAmtCVSG?=
 =?us-ascii?Q?/dv68lTgufX3fzAXKqR5vbpIbObIxdVnFEnKerQBrJ85ZHcLv38MfIleI2Sl?=
 =?us-ascii?Q?YBrr4pshs775qFuo1HlQCAnXJRCynrjfGFSm27hek12LxCi6nFFcWEMrTO+v?=
 =?us-ascii?Q?ADJ03pGI/TlrEGaCwXreD7QHGs/jgWG6tGSR+/B9MtkaH9jsyraVh3bjqTTu?=
 =?us-ascii?Q?q9qEQLZG7gnN/YdYLSPqta2TMR49BYOph4bQseK/0nFhnFs89iUim4z2vFH8?=
 =?us-ascii?Q?MHmidbJjWjsCoETnO52uwq0qwNxoEwUUXYTe7foIic/1jHCillstwdYOABK9?=
 =?us-ascii?Q?UFdx4A1PE5OKehBHdkgQsKFGSnpDnxp9TWEYkhrXBsDsd7FjTBEQRpBBjXtD?=
 =?us-ascii?Q?oYqvab1Au17WiTtkxgFDpRlbwZ5QF/P9RWFs4x9xc/sTV5qnTr3dTQ6kajzz?=
 =?us-ascii?Q?MMIbBNTdMEDZm/ZfLGJwRUqJuWoofH/IgB3fRJYPSoESIcz/KtRdfe6Dgybt?=
 =?us-ascii?Q?onr+HW1raJPysfuuegVhB9o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1141d622-3125-49d6-8ac8-08d9a0313652
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2021 07:52:27.2248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aTgB78nx5aCKLMILwOceWp92IS2YhNJULkVULLgToPvcPzceyamx0adyeQO1opfaOpdYDhw4LLyeVqUqJrbDzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAP286MB0427
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems that put_device will free cl, so we are returning a freed object. =
Should we add goto err; in this branch?
https://github.com/torvalds/linux/blob/master/drivers/hsi/hsi_core.c#L102

Best regards,
Chengfeng
