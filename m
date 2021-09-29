Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76A241C047
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 10:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244572AbhI2IJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 04:09:32 -0400
Received: from mail-eopbgr150055.outbound.protection.outlook.com ([40.107.15.55]:3953
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244389AbhI2IJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 04:09:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZSqJmcqKs2mfs/RB/k6O1hOlU6WMhmIdKlDxxI50QO5FCoBT+waVCVToZq5D1zZYOIZYNEbnisbjSQ4SGjoMeE+c9fq89mtdMxfIADmgtjv1z228l9EetBuSd3mQH+ueH0zBm072dUyteAsV73kzPAk709zIeJQCxxZkm/WtaVRGFFM8ixFmRd9ldN0f1JgkyQV0btEhgTcI+2NaJf/l86rfXlhtQhv+ouseH9LlzH76BsGlVozIu62fhGaELJ0dLGLLWSQNgPrLpKeLf8nDOTNFtmNPeRId1iN3nWoKM5n3q9AaG1ydK7gC1zHnh1TR3SivgkGD16mBHYns3NJkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=veigPUWwfEW6k/IjL675jVjlX2KFzCdbWH8kJhGDu4o=;
 b=dNVvorw9oE3HAtUY1Eyro+dCGSSuKKd2psNPO0eeCwJi7ID4KHN6Qqx93xx6uwccHBPt5AVVS2Q28Ty+gze+McSrU78i2Xwu1Lw+pp5vAV2IqMtiankVPz5x6gegBIbBeS9tEMpQSupUf1YbBVdidlGsUQYpW7pPTCm5CZFpWHykLI4iHeCYTRVfegg5NLt66ww5x87i0UT/OmJdJbxRRg1S1HGLLbEQMQ/y7vW0fG2e9G41xeNhBR+GK/AcMbfkNpeDXvdTipxvC3VXXDZMluUEMOMjSHH93KtLo7CJv8jxBwYCKP13VvWBR7H/r2QodMh9KNIDuZAOEvO1hEzTOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=veigPUWwfEW6k/IjL675jVjlX2KFzCdbWH8kJhGDu4o=;
 b=Y27IRUWY7Pfz225RCgwW6OwYPsbfGu4mn8e+4zaQMgiRdK26Syc25rYr+XqcHyOBXe+lvmsuCd35yUovkiZaaAGoqYydeM6If6t7D7B3DpU+TJobRoHF21hXWA2hLJzV+TPNi5TbIhTEFYEK+/JjW2lLg38m9dIx45eD2mtTgLc=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB3PR0402MB3769.eurprd04.prod.outlook.com (2603:10a6:8:f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 29 Sep
 2021 08:07:48 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f%9]) with mapi id 15.20.4544.021; Wed, 29 Sep 2021
 08:07:48 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 0/6] nvmem: add "cell-type" property to support
 mac-address
Thread-Topic: [PATCH V2 0/6] nvmem: add "cell-type" property to support
 mac-address
Thread-Index: AQHXsGpO9wlWVM6iQUu6fwLoCMj4wKu5jc6AgAED9MA=
Date:   Wed, 29 Sep 2021 08:07:48 +0000
Message-ID: <DB8PR04MB67952C0FC44A1481230DB90BE6A99@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20210923110109.29785-1-qiangqing.zhang@nxp.com>
 <2194172f-a362-a328-993b-45ebec539f9d@linaro.org>
In-Reply-To: <2194172f-a362-a328-993b-45ebec539f9d@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c869fa0-0c35-44a2-c88f-08d9832039da
x-ms-traffictypediagnostic: DB3PR0402MB3769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3769C0DC5B09770EE8DB5077E6A99@DB3PR0402MB3769.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kCw1u6T+MAdE3h2OR44Rjqf660d7uXjBMjBeggmFnTt1DEbE4ZXhg7d20RSCM29FGeFpYvGAC9lGz30+vYrNFpYx9fHzZBYVYuEBLouXtyKNUSS3dLU26tqFqTRW81GOGaZRq9q5p68nJ4CbOPIU3gah7tKxgJjB9UcV5Rf59jPqPJgleSwBIDUFyf7uShkrET72JdalzDJiz9WJRF72qHNgu4BGK3csdYaKQnyrOpuI0ado5PDSwQLby4KmzK4q4KYJNiiCnA4WM1TZnfNh1VOVsxkuzSZYn9zZr0ilo/r3yVnlMpyOPrc8uo1lqKy9yv9w2vAuUuSrmxKz8URDOTrSWa9UetcD/T79h6nmhRJwQuCFgXZCvLSCb/vRtXGHhZJo7MZjO1ODkGN1uo6oFrZWhpmqz7tWjinQXeFR6hqLc6yFmvx2cJCZqv30TKDuanPABelL3U+4m8AKO7oWIJNDCijJmllkRDQrHvZBe3aimzr9JjLFQ9OiWvoCtTj4Z+dDI3CdrYJa5WpRWasE22tLwuAubCcnTK1isLqMHgHZ3V2G9u+lWk5VLzXiartpUAy9Qq/X6u1oyq6nVYMb5szGIFhfFsmTyf2UFmCruDUeKKu3iuqgzCuvepswGImrYhoFcBIVBY2psWkJDq1UFVGNb4vUiyEALHK1zzD7AawiELpK28ESrREedomaHMTqPmu2925X+8m8PoR1xjrs5pOzm2IDPDcVYOoUndfwqmW7RJW1+OhGFk0Ed6U60y5q4nfutnpf8APJtM77ijcySNFxsOPCUqOO3SE0k9MBXo8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66446008)(7696005)(66946007)(508600001)(66476007)(45080400002)(9686003)(2906002)(33656002)(966005)(186003)(38070700005)(66556008)(5660300002)(64756008)(55016002)(110136005)(8936002)(76116006)(38100700002)(52536014)(71200400001)(316002)(86362001)(54906003)(4326008)(8676002)(26005)(53546011)(6506007)(83380400001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Wkd0d3hXbEFiU3RpMUcyaDhUaThmdnA0WTlKbXZFNWhiRU1vaWc1U3BLVkNh?=
 =?gb2312?B?WmdIczhLajB5ak40QmIyb1JHN3pDZXp0OG1QbDVxQmxDVWV6OXdxdmdUdFh6?=
 =?gb2312?B?c0F6cGYyMnUxbTNJR1EwSGFHVmZnUCthanRGcDE2NnNjTDZMaU9oR2pjc0Zt?=
 =?gb2312?B?L2REQTVtaVVIcGczTksxZmVSMFAyL2g5amJHREtJVTFMOG5yWXZMdncxcXdj?=
 =?gb2312?B?YXY2U3ZkOEUzaldQZFZWSGFtcXo3UlA4OHNQYWVVT0NLU0VGUHdTdW14dmNi?=
 =?gb2312?B?YXJrQ1RWOVdpWTRBTTVEdFh5OWV5TExxM2ZRdWJSVkdHOW9ra29oamJqOXg3?=
 =?gb2312?B?VE5YY0R5KzFxTWNIUXlGZFNTOW9lYnNINHhtbHBGcXF1d3BBUWdkZkdIZTJJ?=
 =?gb2312?B?MlRHV0xRWEN0UnhpbExwazNxRUN5WGRVSnh1ZGprbmt2MFo0OW4xa3MvSkZB?=
 =?gb2312?B?cDhsSWVuQ25MSnVqd1dJU1lVbENReWI1czNoMXNMUWdsUXl1KzdwWG9aTzFy?=
 =?gb2312?B?Zms5ejBkUDJZQjkrNDU4TGxVRzFkVVZrQnVLQ1hlREd0UHplM2ZqeUZkSkE4?=
 =?gb2312?B?cHd5bk1XbGtKdlpJMEt2d2tmK2J5S2lSL1BveDRzaVc1cXJsMmRTbmlNMDZk?=
 =?gb2312?B?c1M0RElSOHRKQTJnT0Z1WmYrNTZYcEx3ak93WDlWNG4wS0ozVWk1SjJaUVBP?=
 =?gb2312?B?dWt0QnpBV2prT29jdEJ2NTFLdUtzNDRFK1YrVjRTVlJIVllSY3VhSFFoS3I0?=
 =?gb2312?B?ckZ1ZnN5MWdrbU9TZis3N3ZCWG5vWXppUHJBOVI4K2tZNjNkbWFSZk4rYkN2?=
 =?gb2312?B?VWNHMEZWY2V0TmVZU1ZtK0swQ3hBa0QrTXBIaHdJR2t3YkZOMWcyMjRSVGlF?=
 =?gb2312?B?U2NWOFg3OGZpMjZRZmF0a3oxb2h6OFoweHNtUFo4VDc1TUFZdUIyc3BmczRK?=
 =?gb2312?B?SFJ6WW4zb2lLMWZ6MVdUcFN3d0JMblFFcFVKdGJZbkZ2VVllVitXdHZleGt1?=
 =?gb2312?B?RUFuVmNnOHpkajZxSVRtQ3lFS1VaSmJReS9KcG1ZdlNha0wvWGRTZVRuMHJK?=
 =?gb2312?B?SWlxR0xKZ1VYVDdTSEFPb21QTFdBakluTGF5T2p3UGpSK3p1dE55TGFTYmVz?=
 =?gb2312?B?TTZ6ZUlPN3BocFlob2h1T3VEbkcramV5UW9TTzFxdlVsT3BXdjZOaDRLSTYz?=
 =?gb2312?B?SjYyUFg3YWs5YW1PZm9TQVFWUk1zRGUvU0wwcXhqcmRJaDVWTkptNmtSNUhy?=
 =?gb2312?B?OXZPRG1RWVlYaFljZ25wbUZ1Vm8veW85aWM0WE1BSjJiZWl3U2ZxaXB5azE4?=
 =?gb2312?B?WStvOWZ4WXZYYmZBTHgxZy95a3M3bEpzY3FGOWRNcG1OSVFqRkR5T21COFEx?=
 =?gb2312?B?cU5QTUNyaU15bFdZbTN4UDFQb2FmMWZmayt4elZ3MzRPMUhFTmpDNDdLb1BE?=
 =?gb2312?B?aGs2cjhicUIxREM2djlLMnJ3aDJJVmtVSlVOZHNSalJhQ21TTFEyZUg1b1Z0?=
 =?gb2312?B?c3JNYXhwajZIK3BqQ0VmWitWaEs5R2c3ci84cHk3d1JKRy9DUGZkMVJubWpJ?=
 =?gb2312?B?bkxRUGhEdUNXc3ltcEVHcFZkZWVoR1E4TG5HbWF0UmdsN1JUNG5sQ01QYytZ?=
 =?gb2312?B?clkvaTlWSmxOaVMyejBVak9lWWUrcGc0dmJFSVFrSXZZTDNTRWcrSmtNclpF?=
 =?gb2312?B?VytaaWJyM1VTUlNCeDBkOVpiNDJTa0pkQnJKdFBtVUJQd3h2N1ptUVR5VEl2?=
 =?gb2312?Q?Jws6Slx+bz6A0j20lg=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c869fa0-0c35-44a2-c88f-08d9832039da
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 08:07:48.1641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /J6BDNPyvOW5K97W/ZgcGlq+cDx54B/wCJ6IAJDRyxaIAm5bUA9JkE/vvg+/SA8whennERIngRLWgguclSQ/ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3769
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBTcmluaXZhcywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBT
cmluaXZhcyBLYW5kYWdhdGxhIDxzcmluaXZhcy5rYW5kYWdhdGxhQGxpbmFyby5vcmc+DQo+IFNl
bnQ6IDIwMjHE6jnUwjI4yNUgMjI6NDQNCj4gVG86IEpvYWtpbSBaaGFuZyA8cWlhbmdxaW5nLnpo
YW5nQG54cC5jb20+OyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7
IGEuZmF0b3VtQHBlbmd1dHJvbml4LmRlDQo+IENjOiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IFYyIDAvNl0gbnZtZW06IGFkZCAiY2VsbC10eXBlIiBwcm9wZXJ0eSB0byBzdXBwb3J0DQo+IG1h
Yy1hZGRyZXNzDQo+IA0KPiBIaSBKb2FraW0sDQo+IA0KPiANCj4gSSBwdXNoZWQgc29tZSBXSVAg
Y2hhbmdlcyB0bw0KPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2su
Y29tLz91cmw9aHR0cHMlM0ElMkYlMkZnaXQua2Vybg0KPiBlbC5vcmclMkZwdWIlMkZzY20lMkZs
aW51eCUyRmtlcm5lbCUyRmdpdCUyRnNyaW5pJTJGbnZtZW0uZ2l0JTJGbG9nJQ0KPiAyRiUzRmgl
M0R0b3BpYyUyRnBvc3QtcHJvY2Vzc2luZyZhbXA7ZGF0YT0wNCU3QzAxJTdDcWlhbmdxaW5nLnpo
YW4NCj4gZyU0MG54cC5jb20lN0NmZjkzYjQyOWJkZTg0YTQ1ZWVkZDA4ZDk4MjhlNzU4YiU3QzY4
NmVhMWQzYmMyYjRjDQo+IDZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM3Njg0MzcwNjM2
MzU4ODYzJTdDVW5rbm93biU3Q1QNCj4gV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxD
SlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKDQo+IFhWQ0k2TW4wJTNEJTdDMTAwMCZh
bXA7c2RhdGE9aCUyQlpvM25rSjJRdU84Nk45M285dDN1VVB2QW9mbGgNCj4gUU9CS2ZTbmZBa0x2
OCUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiB3aXRoIFJvYidzIGZlZWRiYWNrLA0KPiANCj4gRG8geW91
IHRoaW5rIHlvdSBjb3VsZCB0cnkgaXQgb3V0IGFuZCBzZWUgaWYgdGhpcyB3b3JrcyBmb3IgeW91
Pw0KDQpUaGFuayB5b3UgdmVyeSBtdWNoISENCg0KSSBkbyBhIHF1aWNrIHRlc3QsIGFuZCB0aGUg
cmVzdWx0IGlzIGFzIHlvdSBleHBlY3RlZC4gRmVlbCBmcmVlIHRvIGFkZCBteSB0ZXN0IHRhZzog
VGVzdGVkLWJ5OiBKb2FraW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAuY29tPg0KU2luY2Ug
bm8gZXh0cmEgd29yayBuZWVkZWQgZm9yIGkuTVggZHRzLCBzbyBjb3VsZCB5b3UgcGxlYXNlIHRh
a2UgY2FyZSBvZiB0aGlzIHBhdGNoIHNldD8NCkFueSB0ZXN0IHJlcXVlc3QgbGF0ZXIgY291bGQg
YmUgZGVsYXllZCwgc29ycnksIGFzIEkgYW0gb24gdmFjYXRpb24gc3RhcnRzIHRvbW9ycm93LiBJ
IHdpbGwgaGFuZGxlIGl0IEFTQVAgd2hlbiBJIGNvbWUgYmFjayBvbiBvZmZpY2UgaWYgeW91IGhh
dmUgcmVxdWVzdC4NCg0KQmVzdCBSZWdhcmRzLA0KSm9ha2ltIFpoYW5nDQo=
