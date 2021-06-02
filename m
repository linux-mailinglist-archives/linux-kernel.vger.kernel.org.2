Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263A4398465
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 10:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbhFBIlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 04:41:20 -0400
Received: from mail-eopbgr140054.outbound.protection.outlook.com ([40.107.14.54]:31848
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229826AbhFBIlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 04:41:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmAodpfgXiOynsRfNUc+2hJHSzvdgeCE939WawUXfS+B03mnHIdUR3A0/rJb7Lc1W8bjBfkJ0KQwnVi02v+27d2VKKMrp1TYeysYdLtGPqq6pIB0UzG8D1uwGoxooB29mgpQEyNrQu8e7b7Qka5RPY1j2cJiBDuineVbWwQB+E1OQJJFOsb7YMdOHH8RYXRzgwZkAnCpOWB/3l5wCY+Cmuw/YD0C4NBupUdVTiloTQETc1PCE1o1Es3WeiFnOHdx/Q8Ji7hwz+nbpp2AsYNL6QnQ7kAUhU8C/ae72x/w3ONM17H92Zupzs2K58FVzmiDvbBLRWFf5pgRJ3KDmp6PuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvK8gRPs6StteZHM20/2w5CwDzRgakfqyIMYcP6cxE8=;
 b=TxsaVAqlfspTtH+aysQRW+X6egW9SER4q7hS35QJ+hSR+W28cKa9FeROBwfuql5EUi7gAYMOq8PlZw0qIMDamoaETl1YVrxjlr51qr1Jb6MA7Q8k5kjsVtpBg39FEJ9jWa6ypB11/vRf+ItPb0K/5Qq/rS4nFcMYR8nRWZhzfOAHHFlP2JRr+z3Aux806NzAHwdpZW2jTMvQ1xLkqkp+lDSAXUUyz9ttMscqzxzJ4w1KEWLd5YvAxpYHuSRp+9voWab3S87ZOUcsQciEfduTbEm/fil0nmF8P9gilaB5lylZ2XJZ1bhb0kQm1tgVZfRoZC90EDSr79jfBB5oDpFB/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvK8gRPs6StteZHM20/2w5CwDzRgakfqyIMYcP6cxE8=;
 b=R/UNGCIbsrWKn45SkbZ/JgU69rHWbSDVgX7HjMRL2H+2sQZ9we77KUVmrYZFFfrSDMCbZqgcORgNTQFBmtS6mLOwQA2ntKt6CiegxFavz/F/wH2y1Dnb6ztDgcZfROQLa8Oi5ks2SczlBEloDnLxbAwALV5xs6xalc8liGQJ7i8=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6617.eurprd04.prod.outlook.com (2603:10a6:10:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Wed, 2 Jun
 2021 08:39:30 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 08:39:30 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: RE: [PATCH 0/3] clk: support regmap
Thread-Topic: [PATCH 0/3] clk: support regmap
Thread-Index: AQHXU7DDzP95mW1iZUWgmMnWU2SzTKsAaGwAgAAEuOA=
Date:   Wed, 2 Jun 2021 08:39:30 +0000
Message-ID: <DB6PR0402MB2760408DD6B17DF30EFDACD2883D9@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20210528113403.5374-1-peng.fan@oss.nxp.com>
 <162262192433.4130789.1017942859005253343@swboyd.mtv.corp.google.com>
In-Reply-To: <162262192433.4130789.1017942859005253343@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65263544-3fc2-4662-8c58-08d925a1f0b9
x-ms-traffictypediagnostic: DB8PR04MB6617:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB6617A5427A0B18DFA697E937883D9@DB8PR04MB6617.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ybE0aHY56IiVpIUpswpSAnkseDFQWQQea/8LD37tHLE5QhJ+uKBMYDt5h1VPry8ZM2n6a1IllIULMewOV9C5KLh2VSCFRnpiHHKqMuD3fwR0B50d9abbjjFYXI6rxp5m7CKJcpe8hNivtKx05b4LtsxnGOosYBbe39RaxYmcjWw5hVEJWCXAIJlgJ0+lhgcfkXdGTG84M6pr/S8fp8hZ1CdkEe/X4JqVntXNRuWME7QEDphmcjWw/Tl8pt1BmVyUggmQ0IEncsD84E2UCL0bWFVrHbzj8OSBCuMXs+/nA+VPN/TY8XjYjmZSUs1I+QhhRQKv/7/16Dr3G3PQJ0t/DXigqN6fTskODstW6BNFu90qXpkWhi0CEizZLqPKJMe1dXTpV1XZhQScBenYb82sBjF0GdboLQy3mF8LQs96FZiOAz5VG+DKbvC8V1uaby9USJCnvD0UW8/gLEeUj6YMhERDh7oXYyJh4MpS1uic1jxx09bY/5tE0pUaDUx40GgXhWWBHOJ7S5eqQjiappwtFHfOqW6jvP4pF3ezzLxBqTlFhXVX4XSuvtLO5FgDDwn9bQ3ZBCkIu5QlRCt8CM0djxglh4fFSjQ9DDZzvW1iP78=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(71200400001)(55016002)(38100700002)(122000001)(86362001)(478600001)(7696005)(9686003)(8936002)(66946007)(2906002)(44832011)(186003)(110136005)(64756008)(66476007)(66446008)(76116006)(66556008)(8676002)(5660300002)(52536014)(316002)(26005)(6506007)(4326008)(83380400001)(54906003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Yk1uTk90Q0xiWE5VeG1HdTFLcXdTZ1NpOVFjbnZrczNpdTlueUxiS01LcERr?=
 =?utf-8?B?YVdqc21sTzRuc2cwdW5aUkRZdHhPTHJWZlp6RmFtekFQU2VzT2VhNlk4c3Qx?=
 =?utf-8?B?WTczZ0JxU1RFVS9GZzVwME1hWHhQVkFoZTZqZThxelVmQXBPQ0JCSWw4WUVz?=
 =?utf-8?B?OGFFUVV0ZTZIeU1oMENQZlJRcXVTd1BuSHJmRmJjbDJENmN5dkY0TVVvWG9C?=
 =?utf-8?B?MWQwZDFBK1dFNWNrOXVBR1lQc3RNeVJrZHJTeDRrc0FOSVlkOUZzV2JWN1hR?=
 =?utf-8?B?ald4aCtndHk4Y25rcjYvMklsNHRERFIxYUd1T1BtWFh5N1JmSzY2c0FjMndX?=
 =?utf-8?B?eVhXMFArMktwV2pXZ3RuWG9DWUk4Vld0dnNSRXlsUEpGdVJ1U1ZIVmJrYXQ2?=
 =?utf-8?B?RHpIWlJSZGtOSlJJdFRGdC9vZktzNjFzVnh4SW9EZG45cEZ6bjc2YWJRUG5B?=
 =?utf-8?B?RHFBWVhvT3BneUtDL21MNmhoczRNZkxZS0V0cmlRUVFsL2hBMTlQamlnaWJk?=
 =?utf-8?B?dFAyYkVhc3M5TVc1ZkphRTloSWgzeEVNNldUaUFTbTc2cytSQkpldUxkL1hY?=
 =?utf-8?B?eittZ3FDckdodUZBYVNXWjZrUVB6RkM4WHFIaFNzSDl5MG1YNGI2bTFJTWZQ?=
 =?utf-8?B?TTE3S0MyQWEzQkRVOGQyNG05a1lycDluRXdxekU0Q1MzbmlwcC9SaFdHVVFP?=
 =?utf-8?B?TkxYWi9kVSt5TW1NUXErN2t1Wko5ZllDOHBmN0hzRHFQVmFsdlJDWkpDL0sr?=
 =?utf-8?B?aDJDaG9kMzhicFNIbzB3WFpEL1U0a050V0Q2ZldwRlhoQmpuOFBIVXBKYWJ2?=
 =?utf-8?B?SU43ejZ3eEZndnNJeVk4Yy9Nck5uNWVQK09FMVhvL2FJb2ZNSlhUK3JMQjVV?=
 =?utf-8?B?djVCSUkzRFd0YzdlOTVPbkJiTDhGcGZmUlMyQnkxcksxZUQrdGMvTVd4UWxh?=
 =?utf-8?B?SS9sK3Z1V3NBTXhZd1NQQVQ4dGxmUnVQOVorVHhBdmV1VU9WTkdTY3RucnBZ?=
 =?utf-8?B?RG11bTRuUGdVdlFtZEZpUzlieVk3L3F3UWx0bG4wekdJSkNqeUZHV1p5eFZL?=
 =?utf-8?B?ajQ3cFJRQ0NqNlN5dFNIYktOZDcwZXhtVExsNEVGbjlJK1JUN0hyRHhoditx?=
 =?utf-8?B?Rks0V3Rwd3UzeHgyVWhJVjBtY2NzVXNpMGRzdFNWU0VEVnkvUlhTSWcrNXR0?=
 =?utf-8?B?U3VYN0orK1NkamhWSDVoQ2ZPeFBkdnBEbk8yS2pHS3oxV1dyS1dIbXRjZ2lU?=
 =?utf-8?B?Mk8wUittWFYwZUZuaHdjNHdEOXBrbE4ycVNWU3NKbGN0WVJ6T2dvVUxJdjJU?=
 =?utf-8?B?dCtxNldqc2VGanFwT3dXYXMyUG5ONVJ5ZjJSUWlCV3RObHRIYTBQRVQxMVZM?=
 =?utf-8?B?c1BGR1h3VGFTdDY4eHlEWGYvVStnYmYrK3Y4c1pIc3ZRSU4wOUF1c3lJT3JN?=
 =?utf-8?B?eXVGS0taODUwaFAzSEIwMEtuUkhDdS8xVVpYdWpmTWpmNGYwOVlXeFhIYW9H?=
 =?utf-8?B?RzVodFUxWnZXUTlGR1h1VTJlOHVBTXBQR0xiWjBzeG9LblFBcFNSUEdyU21Z?=
 =?utf-8?B?Mk5UK2JRVFVkV0kxZ1pKYlZ6a3VwaFNzZ3RJQW4rUHVvaVNtSHlnamZMdVc2?=
 =?utf-8?B?aWVoSWJqUHQvOWNwS2xGK0U4MWYrTHhabm5uMWx6ZjlUQnNZT1JTTkxDOTlz?=
 =?utf-8?B?aGFpWWRGV2ZRT294ZFF1OFBFem9xQkNkYUNNTzJBWlQ5R1FFODVuMWFyajdl?=
 =?utf-8?Q?+QEm9s9WHZemT8DI2m79HH1zErQH5Xy9O4bUG9Y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65263544-3fc2-4662-8c58-08d925a1f0b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2021 08:39:30.7450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zGqOjYtyDkR9fqNf/zje1QCGTBMJ+/jMoBQGXX040nRtmB8agTq4Q88zhk8ikwEiPx5TnC0iEqDawkBi626VbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6617
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDAvM10gY2xrOiBzdXBwb3J0IHJlZ21hcA0KPiANCj4gUXVv
dGluZyBQZW5nIEZhbiAoT1NTKSAoMjAyMS0wNS0yOCAwNDozNDowMCkNCj4gPiBGcm9tOiBQZW5n
IEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPg0KPiA+IFRvIGkuTVg4VUxQLCBhIFBDQyByZWdp
c3RlciBwcm92aWRlcyBjbGsobXV4LCBnYXRlLCBkaXZpZGVyKSBhbmQNCj4gPiBwZXJpcGhlcmFs
IHJlc2V0IGZ1bmN0aW9uYWxpdHksIHNvIHdlIG5lZWQgbWFrZSBzdXJlIHRoZSBhY2Nlc3MgdG8g
dGhlDQo+ID4gUENDIHJlZ2lzdGVyIGJlIHByb3RlY3RlZCB0byBhdm9pZCBjb25jdXJyZW50IGFj
Y2VzcyBmcm9tIGNsayBhbmQgcmVzZXQNCj4gc3Vic3lzdGVtLg0KPiA+DQo+ID4gU28gbGV0J3Mg
dXNlIHJlZ21hcCBoZXJlLg0KPiA+DQo+ID4gVGhlIGkuTVggc3BlY2lmaWMgY29kZSB3aWxsIGJl
IHBvc3RlZCBpZiB0aGlzIHBhdGNoc2V0IGlzIG9rIGZvciB5b3UuDQo+IA0KPiBXZSBoYXZlIGEg
Y291cGxlIHJlZ21hcCBjbGsgZHJpdmVycyBpbiB0aGUgdHJlZS4gRWl0aGVyIGNvbWJpbmUgdGhl
IGRpZmZlcmVudA0KPiByZWdtYXAgY2xrIGRyaXZlcnMgb3IgZHVwbGljYXRlIGl0IGludG8gdGhl
IGlteCBkaXJlY3RvcnkuIEknZCBwcmVmZXIgd2UgY29tYmluZQ0KPiB0aGVtIGJ1dCBsYXN0IHRp
bWUgSSBjb3VsZG4ndCBhZ3JlZSBvbiB0aGUgYXBwcm9hY2ggd2hlbiBKZXJvbWUgd2FudGVkIHRv
DQo+IGRvIGl0Lg0KDQpZb3UgbWVhbiBKZXJvbWUgaGFzIHNvbWUgd29yayB0byBjb21iaW5lIHRo
ZW0gYWxsIGludG8gb25lIGNvbW1vbj8NCkNvdWxkIHlvdSBwbGVhc2Ugc2hhcmUgbWUgdGhlIHBh
dGNoIGxpbms/DQoNCiBNYXliZSBub3cgaXMgdGhlIHRpbWUgdG8gY29tYmluZSB0aGVtIGFsbCBp
bnRvIG9uZSBjb21tb24gcGllY2Ugb2YNCj4gY29kZS4NCg0Kb2ssIEkgc2VlLg0KDQpUaGFua3Ms
DQpQZW5nLg0KDQo+IA0KPiA+DQo+ID4gUGVuZyBGYW4gKDMpOg0KPiA+ICAgY2xrOiBtdXg6IHN1
cHBvcnQgcmVnbWFwDQo+ID4gICBjbGs6IGZyYWN0aW9uYWwtZGl2aWRlcjogc3VwcG9ydCByZWdt
YXANCj4gPiAgIGNsazogZ2F0ZTogc3VwcG9ydCByZWdtYXANCg==
