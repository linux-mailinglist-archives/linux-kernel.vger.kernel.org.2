Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFDD392B80
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 12:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbhE0KMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 06:12:33 -0400
Received: from mail-vi1eur05on2075.outbound.protection.outlook.com ([40.107.21.75]:40704
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236127AbhE0KM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 06:12:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZJX9pTGSUo6nZMzZIk1EZvJwf3AAFD18VVB4ejzcAowAlW1rHYPUl5HYZWqL73cSkt7BfRflHUm4y+hCMw8yUey8U0sqSKagjy8br+/53SlW4jCUOuY4efpR5QUqLHM8TZl4JbEyo5pbuEXHhTXKx8zZr3/za0OjELlZ+bq3/3MUl1UDOVFQZmCu4L7f8jdeeJ+h2Wo2jfCmhjPbRX/KJLgvZPyU5MGQweebt6/hDnnA+p1tcFOI2JrWebfpMtQ8vHXWN/uN/EJla1f6Eu7ybdAVqUyEqQDMY/f1lTAg3b8o2qukSwbt4Yhvq0nmreZjtyOnHGpA9R/DjeiIJTmYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fc0O69zknp/YD80TWS7wnMI6G2wbyP82tiq5k1oFwwo=;
 b=SIMtJon4lygrwVkWRAJm3nhtkW1NvDC/OwiMGsij1oCgOUiMqCtS58EcULpzKC95JCnb/w+EuTjAHl+nteVqSh05hYZrExCXUxYUMQJJZ0iWb7gNPpHNlVwppLcakKk/x8q87fnuZ8diASTGZMt5kmo+RVco6ssGKjPY5+JxG/ZoYkGAXm/pOpOf6C88rxlrKJNerKA5DQQZ6rzgO1o5RPOCXtpZZD7+WZenS408gDln7xqaXTro2SbAcQqJrDWA70JUpz0mJ8ghWiwidbeaYZw7Rkbhda81yCKf6BWR3XXEcOTpuXuuKPM9q5+2ex5zTBkWB2mv4MJM4uSgPXTp8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fc0O69zknp/YD80TWS7wnMI6G2wbyP82tiq5k1oFwwo=;
 b=UlF0IO1VPguJr2kn7U79Dbq3lpapzRB8XZ3YSs+sJFDMKEgd2McBW42CjrGkjWboDZROHDd0XRbElPEpUDfLkcTybkGlac8LHKLv05oVqT+NGdcRe0vvftz2FOL/vedTBmcjxcjiCNwjpreJNR2E5bjZhpr86lCl7PNtunzZi7Q=
Received: from DB6PR03MB3160.eurprd03.prod.outlook.com (2603:10a6:6:37::21) by
 DB6PR03MB3160.eurprd03.prod.outlook.com (2603:10a6:6:37::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20; Thu, 27 May 2021 10:10:55 +0000
Received: from DB6PR03MB3160.eurprd03.prod.outlook.com
 ([fe80::d10a:71a9:656c:7d96]) by DB6PR03MB3160.eurprd03.prod.outlook.com
 ([fe80::d10a:71a9:656c:7d96%3]) with mapi id 15.20.4173.020; Thu, 27 May 2021
 10:10:55 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "zou_wei@huawei.com" <zou_wei@huawei.com>
CC:     linux-power <linux-power@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] regulator: bd71815: fix platform_no_drv_owner.cocci
 warnings
Thread-Topic: [PATCH -next] regulator: bd71815: fix
 platform_no_drv_owner.cocci warnings
Thread-Index: AQHXUtugC74N3vqTXkKQPAq9xWzdY6r3Gy+A
Date:   Thu, 27 May 2021 10:10:54 +0000
Message-ID: <192b23ebcd712ea5b59720e6d0fc32f97317fe32.camel@fi.rohmeurope.com>
References: <1622109244-54739-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1622109244-54739-1-git-send-email-zou_wei@huawei.com>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [2001:14ba:16e2:8300::4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 577c51eb-8287-4405-0d44-08d920f7b716
x-ms-traffictypediagnostic: DB6PR03MB3160:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR03MB31605B55A041315747ACDB85AD239@DB6PR03MB3160.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sr0FR0rokKBCqcEC94Fek0hXOe05wNlk6ek9N9f/5sD3068uMCEB+2scRmM4rY98DRksxWwgjsNEm+RYt8kkw48xDQEU3egugvOsPwZa79ZbUegY+7pY61TW/VBrqZJVFK2FgTv8iE45n/urdZM/WKKFqGpNYoxXkP26CW0nJ8mXrNdVF/N4XHoY0h15nxrBb716rqj264HsY0Oo5QSOhEWA2V6saxoKOAYjusop3APRzf7VvTKV0yIqvSQFDnM0y8S7BTK+61mPmUJa/VScyHrMzBSrjRRBx8qqtx/RuM/R5Kpj51l+wS5XPq7W5+2Yx2RMPALTYecYnlOp3sGIQ6tY7leF64QzYm5Yd4dieb/dzQBxom89dNoDNbDc+krrQyc38i6qEhxEK5h6Lx1fqSiPT3H+1VE0inYpzKRVBry6+FyXCImUbJKKpABA97PnLYUHwv9RmRkJw8Y5ys79ILHiTKaXIjZq0GRY404zrVIx3oan/cqm33XknqGmgnpDHv8YrfaaPMPPOXsJT4vQnNTwr1EPvHeI6q4tLW5wG6bLaNe1n16Xz8gnPfaKEoXG+OBqQFwIKHcoWcaPVKJWg6fc01ZClJnggmzImSc+FFk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR03MB3160.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(136003)(346002)(396003)(366004)(76116006)(66946007)(64756008)(66476007)(91956017)(66556008)(66446008)(2616005)(2906002)(478600001)(38100700002)(4326008)(71200400001)(3450700001)(4744005)(5660300002)(316002)(122000001)(110136005)(6512007)(83380400001)(8676002)(8936002)(186003)(54906003)(6486002)(86362001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UUJrWjFSbU90dWYwLy9yK3BqaHZWOXNUZTVZaklXZTRDZXlKdXNIWXVwbmc3?=
 =?utf-8?B?NCtiVkJ4ZkxPclExNWJ2QVB2akp0K3lWV3JKaytYYmh0VXQ3bTlaM3djOXpO?=
 =?utf-8?B?VXBySzJsdzhxUVJnUTZxcUtIcThIbFl0d09tdTJZTmswRG05QUZwMlllT3FR?=
 =?utf-8?B?OEs5V2FwWmVKYXNRMnlTbGtGei85N1ZyeHFrMXJNZm1QYWpzd3hXbjU5WEdL?=
 =?utf-8?B?UXVoODF6ODYyNm1oOVVUNVNmR05raGhnNngrdzR5Qmt5OXFVYVdSb0s0VDVK?=
 =?utf-8?B?SngvenAxS040ZzBtVVdydDVtcW9HenNKQWlORlJrelhsay9RTWN5RGxqT3BV?=
 =?utf-8?B?T2l5WnlyME5KUTZDQUxKRERhaU9DSWUzTk1HWEJrclprSTJMSVZkUEswaE5F?=
 =?utf-8?B?V2xFR0p5MzNmdlowTXhZSmFEOHZoVnBMQit5SHUyV2cvMmQ3MURKNDF3RHFE?=
 =?utf-8?B?TlBGT2s3WFJJakF3TnRBYlUwczN6ZnRReWFhZ3dNTzNGWUZHQmpVRGRwMWRm?=
 =?utf-8?B?Q2VscWZhU0tuZGMyaitseU90cC9ydzV3QVJ5elRHRm54K1c0WklDTGRzQ3Zz?=
 =?utf-8?B?azZ4L1BqM1g0TGNzZGdJU0ZrY0dxWklyMDR4MUR1bU5JYWtzL240L2V4ZmpK?=
 =?utf-8?B?by9HcFlTYUZYMFZrdHB0bkNRWDZ3NjNYOTNlaEt3cW42QUtWMmRWSkNSd0Jw?=
 =?utf-8?B?dCtxWG1oY3lzU2NHTjRmTUJrb0cxOEUyc0ZRTjRWUU5VcEczdXZYa0RGM1BO?=
 =?utf-8?B?R3dhT2ZIMGVNRWRxTmwwMGRNTmxaK0tWSXJydXI0SmZPSFRvdXlCVlJRRVBY?=
 =?utf-8?B?UnMybmdIeTZxOGptWnNVWlNmd2UreFFOUm5GOXVXbVpOT21ZS1BhYU5BSG1L?=
 =?utf-8?B?Mjd3ZHF2a28vTEhGNElNMzl2RU9BbVF6NUpMNUNaakpRNDNTeWVmenpTb0xk?=
 =?utf-8?B?eHdnMHBQN3hMOFF3TGV5T2Nabm5yUHdHekQ0QitpR0NFRU5QZ0ZXOUQ5Q3I0?=
 =?utf-8?B?ajlFR3BWMzllbGJGY3c1QlkwNTNvK2xvcmZVTG84dDl5UXQ2dzBwTFBOTmRo?=
 =?utf-8?B?RWFYR0VBNDVqRXE4NHhsU0VkelJhZmd0ZldOYkxRYUhTblFMSUhFKzRSa29J?=
 =?utf-8?B?M2JuS2x6N0VxSXJ1V0JRS25kQW1XSU1sdGFtOFY5UE9IbHJWdW1uNCtOTnBv?=
 =?utf-8?B?YklCUERZN1pDd2FIakUzUktOdXIxMFpTU2VYVUlHWTllRml5a1lHbXJkSWw0?=
 =?utf-8?B?VEZack8rajN6dllyNkVkTDdEMERUQlVDaElGbksxRi9Ga3luZkNFc2g5UkdN?=
 =?utf-8?B?d1pRdVhRYTE2MlQ3RGJycXFmY3NlaHdRTlNWQzZzajNnbEJPYkZ4UHdlbCtk?=
 =?utf-8?B?ZUorMVZLb3BXc1pNK2NVcWVHUU0wQi9aa1liWjF3cVJGbnNtbC8ydmoxQ0cz?=
 =?utf-8?B?T0NGcW9ES2lSRmhhWHYzUzRGb3hMQmN4YTNCQVJPbXZtYThsZGh4b1RQQVNq?=
 =?utf-8?B?dTl6L0pkWHgvL0hzdGwzMk1EMFlLbzByeWJnNzYwSzVEMHB5dWlhVnNyYUxM?=
 =?utf-8?B?OTBpRlpXa1FRazB2cGtFNWNhRGFydE03RlU5Z0h2WUxUS1pLTGlCRWFKTm9p?=
 =?utf-8?B?aHlkMWpEZzJzTG5pZFNSZHVSWlFjNm1vRmdyQWlmMUZWMHowMklYQ1o5UEl3?=
 =?utf-8?B?bWt3VXY2VUlXM1FhWmM0SWpEckN2RnpVbkdTVkZkQ1gwZzl2OGh0dmsza0N5?=
 =?utf-8?B?aHVtRnNDYWxZTkFzZVpzOWZHblRHOFVuS1dkc1VpNWc1aXVSei9UeU5KL1F5?=
 =?utf-8?Q?fJJg9KdSeqohjxuNHkQ+DXATMIC8vrHLBpSls=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45B19FC023264E4298265F7405A7839A@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR03MB3160.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 577c51eb-8287-4405-0d44-08d920f7b716
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 10:10:54.9433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k4ILC/rjZYPQj/sK4EOKdnET6fs4nWGTudOMxe3A0aphLZ6fGPaWJdgiVnAu3kcd3nyshp/WWq5yPyeNyBU64tkj4Lh4rnp6uzkcLeGY3c/pbDLQ1bgK2pvtkN36nWRu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR03MB3160
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBUaHUsIDIwMjEtMDUtMjcgYXQgMTc6NTQgKzA4MDAsIFpvdSBXZWkgd3JvdGU6DQo+IC4v
ZHJpdmVycy9yZWd1bGF0b3IvYmQ3MTgxNS1yZWd1bGF0b3IuYzo2NDQ6My04OiBObyBuZWVkIHRv
IHNldA0KPiAub3duZXIgaGVyZS4gVGhlIGNvcmUgd2lsbCBkbyBpdC4NCj4gDQo+ICBSZW1vdmUg
Lm93bmVyIGZpZWxkIGlmIGNhbGxzIGFyZSB1c2VkIHdoaWNoIHNldCBpdCBhdXRvbWF0aWNhbGx5
DQo+IA0KPiBHZW5lcmF0ZWQgYnk6IHNjcmlwdHMvY29jY2luZWxsZS9hcGkvcGxhdGZvcm1fbm9f
ZHJ2X293bmVyLmNvY2NpDQo+IA0KPiBSZXBvcnRlZC1ieTogSHVsayBSb2JvdCA8aHVsa2NpQGh1
YXdlaS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFpvdSBXZWkgPHpvdV93ZWlAaHVhd2VpLmNvbT4N
Cg0KVGhhbmtzIQ0KQWNrZWQtYnk6IE1hdHRpIFZhaXR0aW5lbiA8bWF0dGkudmFpdHRpbmVuQGZp
LnJvaG1ldXJvcGUuY29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9yZWd1bGF0b3IvYmQ3MTgxNS1y
ZWd1bGF0b3IuYyB8IDEgLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3JlZ3VsYXRvci9iZDcxODE1LXJlZ3VsYXRvci5jDQo+IGIv
ZHJpdmVycy9yZWd1bGF0b3IvYmQ3MTgxNS1yZWd1bGF0b3IuYw0KPiBpbmRleCBhMDc5ZWZhLi40
ZGQyMWFjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3JlZ3VsYXRvci9iZDcxODE1LXJlZ3VsYXRv
ci5jDQo+ICsrKyBiL2RyaXZlcnMvcmVndWxhdG9yL2JkNzE4MTUtcmVndWxhdG9yLmMNCj4gQEAg
LTY0MSw3ICs2NDEsNiBAQCBNT0RVTEVfREVWSUNFX1RBQkxFKHBsYXRmb3JtLCBiZDcxODF4X3Bt
aWNfaWQpOw0KPiAgc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgYmQ3MTgxeF9yZWd1bGF0
b3IgPSB7DQo+ICAJLmRyaXZlciA9IHsNCj4gIAkJLm5hbWUgPSAiYmQ3MTgxeC1wbWljIiwNCj4g
LQkJLm93bmVyID0gVEhJU19NT0RVTEUsDQo+ICAJfSwNCj4gIAkucHJvYmUgPSBiZDcxODF4X3By
b2JlLA0KPiAgCS5pZF90YWJsZSA9IGJkNzE4MXhfcG1pY19pZCwNCg0K
