Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC393B9AFF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 05:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbhGBD1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 23:27:18 -0400
Received: from mail-eopbgr70050.outbound.protection.outlook.com ([40.107.7.50]:44355
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234731AbhGBD1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 23:27:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U30pPRAq6tZSJTaNDrdUkY99GZULGk6SD4wnO4syCxcXumvxrIqXKJeQHxmRQUwrxkoC3jcvc7f9R2c6X5Y/rm217klxrBknoDJl+OHE+lSMMwqLu+65m+WDGDYvqj5jihUcO/Vdka8mINfyk2Tgl5EkaMaxOE5s3rih5H3XgV+phxsSWqX2gONatKEVGe6+rvkuby40zX2vQWodTLQ8MPkKF+3sog0+Z6Z150dd1BcEf+xcNVfdGxxqHFRlOGGYjRMIb6ypqYDVy+ImtbHH3UwtwJv1U7T2yYNLSWsRo3oS5CIa4ekbbUaUQiZKFT9uv73QFGXwXrVkU4kjZcwlcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hALIzNVXP2fU1tG9WXn5dvHDoVVVtA/tBcJ8vrYtpzI=;
 b=hxjG9KPPbEV5uM7AlTAel0EtLUMKIZOQzip/pKbdykLL0kBxiuri8YorqLSe9stgbUtCZ/zNnqJaNtdr/e+uzViiPOfhT83WhQG44oI7kRxIp4S+4Y8B7UpVdH6pBikzYRvbjaeOVQ1T7sSTEoB98xWs4PIDULrcTUC9FPNBX915Y6Qs6uDVkjX5pJ+Xx3QnPHUrE3Oaq7v8mnbcsf/VWbT3EhU/ui8fh/bQigGln2ojIdu4J5vq794hzYuily+3ttauW9shU8heC+Hd1uvS6c4L+xTqsgqFKYhS+OhYfsCPMUNGas5jgp2L5ChIpkPMwOgOQ76eFxLcO2vWthzGfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hALIzNVXP2fU1tG9WXn5dvHDoVVVtA/tBcJ8vrYtpzI=;
 b=Z8NZer8rdJdsSKNwkXtO3If1FUhNaIQkmHXX2jB6KUvqQoQWXw2EIZv3T2VzryQS/P+kL7ns9BNm8IFSw4R9gqKghyE7aNs31PC2AIKNYFmqbbdHyMyaaI24Q6NucLPSHsS9+dZA81SEwDR9QfHpHNUd75yTKSIKdJLNoBLQvms=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4937.eurprd04.prod.outlook.com (2603:10a6:10:18::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.26; Fri, 2 Jul
 2021 03:24:41 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd%9]) with mapi id 15.20.4264.026; Fri, 2 Jul 2021
 03:24:40 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Marek Vasut <marex@denx.de>, Adam Ford <aford173@gmail.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?utf-8?B?R3VpZG8gR8O8bnRoZXI=?= <agx@sigxcpu.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: RE: [PATCH V8 0/4] soc: imx: add i.MX BLK-CTL support
Thread-Topic: [PATCH V8 0/4] soc: imx: add i.MX BLK-CTL support
Thread-Index: AQHXbLPhaqB7oWkKdU+X3YAn8YaA5Ksq+0kAgAFQ7QCAACvagIAAK9gAgAAceACAAA6qgIAA7hIAgAFMgtA=
Date:   Fri, 2 Jul 2021 03:24:40 +0000
Message-ID: <DB6PR0402MB2760EEED61EC337A2C51629C881F9@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20210629072941.7980-1-peng.fan@oss.nxp.com>
 <CAHCN7xJgqRfg1sHNbcpdEFaLHUwhYxe7_r5SEMDqSaCPFXX7UQ@mail.gmail.com>
 <DB6PR0402MB2760B05081D54D775B8949CA88019@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <CAHCN7xL6Rr41fHaaPwi6OA5Du8x09EHcE-bWyiGpz0pVn74jeQ@mail.gmail.com>
 <c6a00f74-6c34-4208-0b17-7fa15835eb3a@kontron.de>
 <181ac373-7701-361e-6364-6fc74b2d71fe@denx.de>
 <fc7fd710-a834-8273-62e7-6a151de03036@kontron.de>
 <a760483d-4607-1e48-6695-df64b3c4bbf2@kontron.de>
In-Reply-To: <a760483d-4607-1e48-6695-df64b3c4bbf2@kontron.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kontron.de; dkim=none (message not signed)
 header.d=none;kontron.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b712b932-3bad-4402-c75d-08d93d08edcd
x-ms-traffictypediagnostic: DB7PR04MB4937:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB49377F8C24DFC8CCBD035694881F9@DB7PR04MB4937.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xmSg91+Mj3f7eWAkZHkE2ZDtlt8MiiqGK3qTxIPpFX9Y5ZrXWikeHyTsulF3i0siseRyh/gRktErIYu0oxlLkVN4dlBZP3uVMUdhRP2GlwfDpjNp85T+KMCymGBknnw7plVo8MfjdVnoO4TEoqt5ZQF/OpaDiI4tO92ukHU3kRBGmWZrbwx24aPn4lWu1toBL3ZqtTvM8AnDYdekPH3YwYva4h8qDjI4JdZgy7Y8UweD/icAjSracMdMOI224qm/Eddqo9us9yvtGcuoNAyVoGsJ1hZyMmP9O2tmMBV+MPrIXoZ914kcGIXOrG/mGYE+039y2JO5yvsx5wp7n8KmlCzRzmwD38Kd30kfz/TV/Wms48FyWO4moMOrhQu0ltcPQgIzVPJyVdha3rN0E/7fxUiLk/p+7a2RxcHmqjdIVTvmKa+h6LPFhrZEPrcxAOxTLaQUCW48MH27SmuGGwwQyG89P2KORUuLLELUdqcnXOfaUDIoBsR+Bx4D9nABSwSOlxPI5gfkN8XUyQlgl+damikAYiIMmzay0S5ldcWsDrNXyfvmrhe1ammdb+pkK7WpNt/drk9B3aZ0xxx91tB9M4Cz4d4uFHuR4JjLySy9YzwQHdjoi8nPXtQ0Oi5q3VD7+Cq9J273qmElmWxsOAK/r+l/kfk9SvGBaFKYym/xOzfKuuaCsKv1e0nQw6QrhU3+RVk2mzucKboN6eKWJ/6/28o0cK6QjPonrfyRTZxuG9eaIOqJPUr0j3JnlT7nTgxkH/dWu/xWXI84Xqpvr4wtMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52536014)(71200400001)(5660300002)(498600001)(8676002)(76116006)(44832011)(26005)(8936002)(54906003)(110136005)(83380400001)(38100700002)(122000001)(2906002)(4326008)(7416002)(33656002)(9686003)(186003)(55016002)(66556008)(86362001)(7696005)(966005)(66476007)(66446008)(6506007)(64756008)(53546011)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFdnazFOdFJVaFVVY3paZnNmcG5WOXhBYm1yK04vaHcwRGMwL1BNbUxsZFhK?=
 =?utf-8?B?bzJEUm8wOURKZ3BiOS9QYXFTb2dFbjJ3RzV2OG5vd3hCYWZaSk95aXI0TURo?=
 =?utf-8?B?c3ZLaEpwNVhRTGpQQzVlbUp1amdaZkhPLy9HQ0RWRDJRMi9LT0ZuSEJXSVlU?=
 =?utf-8?B?TlplMEhPT3VpS1kxcm85TVlXV2NCS2VQMk1jb0dHemwzaU1XUnZjdDFnVWJK?=
 =?utf-8?B?NSs5Q0xWQzBlUldTcy8yRjlLbXF5RURUanF5QnAwR2NJYmNwUE91c2xhVkU3?=
 =?utf-8?B?RVpITy8xM0lEMEpZSFBGcW9nZThQSVJWblllUlluZy9jUEJ2bys0VVBCMDhR?=
 =?utf-8?B?eUFJU1FTTmVSSkxRNmRaZUJHY2lsTCtwcmo3QWNrOXZ6YnVyVWMwVWlDc1FM?=
 =?utf-8?B?b0NrRXorM05XUXdjRlhkcVlHazYwdlFyaGNHM3FVRW1ab2ZER1hPQldPdUZT?=
 =?utf-8?B?ZXY0bEJ6T2FHMGpET1gvTWJ2ZVI5MXlRT3RNR3BvaHA4RHZhYURrVmtwT3Ju?=
 =?utf-8?B?dmNWekxVOURoZjk1dzNhTTFhWVMwcG1MZE4wdk9WK2dXWVo1ZFdYOUgrdTFV?=
 =?utf-8?B?bzBNd3V5RWFIV0JxOW5ZRnMwWFMwOXVSV0c1RjBDbGZQZDJVSU5hT1lJR0VQ?=
 =?utf-8?B?MzNCZkYvVjA4dDFsSkxMWnMvcHpTemF5YmVPRFNQOG52ZkpwSjc2QTVWcWF2?=
 =?utf-8?B?UUFTOStzMzV3MXRxWmNTSVFnZUxXK1Zmc1o5cmFuUXBDNnVuN0FkTEVBalA0?=
 =?utf-8?B?STBzMUwxdHBXSHh2bXAyVTdmcExvSGJyUnF5QWpiVWpxcFMvV2RmV3krVFBI?=
 =?utf-8?B?anQ2NUdiZHJTWmxsejJWcTI3ekwrRHdwKzRCK1hoMTNuKzBnaWNRZWF6cGh6?=
 =?utf-8?B?Yk5nbnlTVFZ0S2tURmllaHZ4K1dlTFMra0l2UXFmRWtlVmlRQUN3bjAzUlJU?=
 =?utf-8?B?YnBpZmYwZXdHbHdsT2h0ME1BK0gxdDBhOGp1eFlJVS9nOW5WckVDd2Z3OXFt?=
 =?utf-8?B?M0ZqVzBsT3JtaExKcDhUZ2hNVGNJbGE1MzBjY0NUcHhjZnBWOGVjRHUrNDJN?=
 =?utf-8?B?N21mRHJqWHU1Y1JRd3JiYzNhNko1WGJFVThjeWx3L2VrS3kyT2VlcjlPMzlD?=
 =?utf-8?B?bFpNNTVDZ0RHNHZxVEkzazhIR1h4MWxvc1VhMmxKVjdrUkZkMlJicGl2Zkl1?=
 =?utf-8?B?VHMrNU5GbUxpcVlROWxYTHRMcmw2Qm5JUG4yM3RFL1ZST3hmQ0htcEVObFhP?=
 =?utf-8?B?bVgyWWhlNHViTEtyMWNVSDlJeVFnZWFMMG85S2taYnU1bUlvNmJma1Q1QitF?=
 =?utf-8?B?VHR6YWh4OG53VENldVF5WTZ1bUhsbk9GcVRNYjVxYWhMWFB2QW54TnJLamJU?=
 =?utf-8?B?ZTVJMWgyNW5nOVZBRW14Q3lsemtEUnR6bVFEK3ZWRzlBUWEyVEZ4VFMvaURK?=
 =?utf-8?B?ME9hdjQ2WExubDhjNjJzOFMrcXo3b01nQmNyYUZjZUsybjR1SU9CdTN3UDBF?=
 =?utf-8?B?dDI2YzV0SGgrb05Jb1RjN0RsSlE0VTByZmU1c25sOUw0dDduVzJoSlc5V2ll?=
 =?utf-8?B?dmpkK2VRWkI1NjUyMEN4UUp0a3B3d2xmR25YS1luSlJ4aUs3TVNkT01Ic2h5?=
 =?utf-8?B?WEhwaWg3ZURjWHVBS1U1a08vRDNJS0dISTBSYVAvVEFwdWxIL0NXbGg2Y3kv?=
 =?utf-8?B?eitzczFTbGlQeXZ3OW03U05Yd0huRGJPbW1XN1o3VWJackdUZ1dlbllvZjY1?=
 =?utf-8?Q?enfRLDPV2tlVHYjxHa30d2qf6vFk2aCy8zEWyyQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b712b932-3bad-4402-c75d-08d93d08edcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2021 03:24:40.6565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U1spLN0QMt90dl1He+T//ua9oPrSGtDuZD8GapVy/4n2OZtYMTcgcP1fXUIeGdLjV78UqyIURAxC1vuK+DhhTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4937
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWxsLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjggMC80XSBzb2M6IGlteDogYWRkIGkuTVgg
QkxLLUNUTCBzdXBwb3J0DQo+IA0KPiBPbiAzMC4wNi4yMSAxOToyMCwgRnJpZWRlciBTY2hyZW1w
ZiB3cm90ZToNCj4gPiBPbiAzMC4wNi4yMSAxODoyOCwgTWFyZWsgVmFzdXQgd3JvdGU6DQo+ID4+
IE9uIDYvMzAvMjEgNDo0NiBQTSwgRnJpZWRlciBTY2hyZW1wZiB3cm90ZToNCj4gPj4+IE9uIDMw
LjA2LjIxIDE0OjA5LCBBZGFtIEZvcmQgd3JvdGU6DQo+ID4+Pj4gT24gV2VkLCBKdW4gMzAsIDIw
MjEgYXQgNDozNCBBTSBQZW5nIEZhbiAoT1NTKQ0KPiA8cGVuZy5mYW5Ab3NzLm54cC5jb20+IHdy
b3RlOg0KPiA+Pj4+Pg0KPiA+Pj4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCBWOCAwLzRdIHNvYzog
aW14OiBhZGQgaS5NWCBCTEstQ1RMIHN1cHBvcnQNCj4gPj4+Pj4+DQo+ID4+Pj4+PiBPbiBUdWUs
IEp1biAyOSwgMjAyMSBhdCAxOjU2IEFNIFBlbmcgRmFuIChPU1MpDQo+ID4+Pj4+PiA8cGVuZy5m
YW5Ab3NzLm54cC5jb20+DQo+ID4+Pj4+PiB3cm90ZToNCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+IEZy
b206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4gVjg6
DQo+ID4+Pj4+Pj4gUmV2ZXJ0IG9uZSBjaGFuZ2UgaW4gdjcsIGZvcmNlIGdvdG8gZGlzYWJsZV9j
bGsgZm9yIGhhbmRzaGFrZQ0KPiA+Pj4+Pj4+IHdoZW4gcG93ZXIgb24gaW4gcGF0Y2ggMyBPbmUg
bWlub3IgdXBkYXRlIHRvIHVzZSBpZnt9IGVsc2Uge30sDQo+ID4+Pj4+Pj4gbm90IGlme307IGlm
e307IGluIHBhdGNoIDMgVHlwbyBIYW5rc2hha2UtPkhhbmRzaGFrZQ0KPiA+Pj4+Pj4+DQo+ID4+
Pj4+PiBJIGFtIHVzaW5nIEFURiwgYnJhbmNoIGxmX3YyLjQsIGZyb20gdGhlIE5YUCBjb2RlIGF1
cm9yYSByZXBvDQo+ID4+Pj4+PiB3aXRoIFUtQm9vdA0KPiA+Pj4+Pj4gdjIwMjEuMDctcmM1DQo+
ID4+Pj4+Pg0KPiA+Pj4+Pj4gSSBhcHBsaWVkIHRoaXMgcGF0Y2ggYWdhaW5zdCBsaW51eC1uZXh0
LCBJIGFwcGxpZWQgdGhlIHBnYw0KPiA+Pj4+Pj4gcGF0Y2hlcyBbMV0sIGFuZCB0aGUgc3VnZ2Vz
dGVkIHBvd2VyLWRvbWFpbnMgdG8gdGhlIG90ZzEgYW5kIG90ZzINCj4gbm9kZXMuDQo+ID4+Pj4+
PiBJIGFtIGFibGUgdG8gYm9vdCB0aGUgZGV2aWNlIGFuZCB1c2UgVVNCLCBidXQgd2l0aCB0aGlz
IGFwcGxpZWQsDQo+ID4+Pj4+PiBJIGNhbm5vdCB3YWtlIGZyb20gc2xlZXAuwqAgSWYgSSByZXZl
cnQgdGhpcywgdGhlIHN5c3RlbSB3YWtlcyBmcm9tDQo+IHNsZWVwIGFnYWluLg0KPiA+Pj4+Pg0K
PiA+Pj4+PiBJIGp1c3QgdHJpZWQgbGludXgtbmV4dCB3aXRob3V0IHRoaXMgcGF0Y2ggb24gaU1Y
OE1NIEVWSywNCj4gPj4+Pj4gc3VzcGVuZC9yZXN1bWUgbm90IHdvcmsuIFBlciBteSBsYXN0IHRl
c3QsIGl0IHdvcmtzIGJlZm9yZS4gTm90IHN1cmUNCj4gd2hhdCBjaGFuZ2VkIGluIGtlcm5lbC4N
Cj4gPj4+Pj4NCj4gPj4+Pj4gV2hpY2gga2VybmVsIGFyZSB5b3UgdXNpbmcsIGFueSBjb21taXQg
b3IgZ2l0IHJlcG8/IEkgY291bGQgdHJ5IG9uDQo+ID4+Pj4+IGlteDhtbSBldmsgYW5kIGRlYnVn
IHRoZSBpc3N1ZSB5b3Ugc2VlLg0KPiA+Pj4+DQo+ID4+Pj4gSSB1c2VkIGtlcm5lbC1uZXh0LA0K
PiA+Pj4+IGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXh0
L2xpbnV4LW5leHQuZ2l0DQo+ID4+Pj4gY29tbWl0IDg4OWJhYjRjMzY3YTBlZjU4MjA4ZmQ4MGZh
ZmE3NGJiNmUyZGNhMjYgKHRhZzoNCj4gPj4+PiBuZXh0LTIwMjEwNjIxKQ0KPiA+Pj4+DQo+ID4+
Pj4gSSB0aGVuIGFwcGxpZWQgdGhlIEdQQ3YyIHBhdGNoIHRoYXQgTWFyZWsgc2VudC7CoCBZb3Ug
d2VyZSBDQydkIG9uDQo+ID4+Pj4gdGhlIGUtbWFpbCBmcm9tIE1hcmVrLCBidXQgSSBjYW4gZm9y
d2FyZCB0aGUgcGF0Y2ggdG8geW91IGlmIHlvdQ0KPiA+Pj4+IGNhbid0IGZpbmQgaXQuDQo+ID4+
Pj4gSSB0ZXN0ZWQgaGlzIHBhdGNoIGFuZCBJIHdhcyBhYmxlIHRvIHN1c3BlbmQtdG8tUkFNIGFu
ZCByZXN1bWUuDQo+ID4+Pj4gT25jZSBJIHdhcyBjb21mb3J0YWJsZSB0aGF0IGl0IHdvcmtlZCwg
SSB0aGVuIGFwcGxpZWQgeW91ciBwYXRjaA0KPiA+Pj4+IHNlcmllcyBmb3IgdGhlIGJsay1jdGwu
DQo+ID4+Pj4gV2l0aCB0aGUgYmxrLWN0bCBzZXJpZXMgYXBwbGllZCwgdGhlIHN1c3BlbmQtcmVz
dW1lIHN0b3BwZWQgd29ya2luZy4NCj4gPj4+DQo+ID4+PiBTYW1lIGhlcmUuIEkgdGVzdGVkIHdp
dGggbGludXgtbmV4dC0yMDIxMDYyOSBhbmQgYXMgc29vbiBhcyBJIGFkZCB0aGUNCj4gQkxLLUNU
TCBkcml2ZXIgYW5kIGRldmljZXRyZWUgbm9kZXMsIHRoZSByZXN1bWUgYWZ0ZXIgc3VzcGVuZCBj
YXVzZXMgYQ0KPiBsb2NrdXAgZWFjaCB0aW1lLg0KPiA+Pg0KPiA+PiBidHcgZG8geW91IGhhdmUg
ZXRuYXZpdiBlbmFibGVkID8NCj4gPg0KPiA+IHllcywgYnV0IEkgY2FuIHRyeSB3aXRob3V0IGFu
ZCBzZWUgaWYgaXQncyByZWxhdGVkLg0KPiANCj4gSXQgbG9va3MgbGlrZSB0aGUgaXNzdWUgaXMg
bm90IEdQVS1yZWxhdGVkLiBJdCBhcHBlYXJzIG9uY2UgSSBhZGQgdGhlDQo+IHBnY19kaXNwbWl4
LCBwZ2NfbWlwaSBhbmQgZGlzcG1peF9ibGtfY3RsIG5vZGVzIHRvIHRoZSBkdCAoZXZlbiB3aXRo
b3V0IGFueQ0KPiB1c2Vycywgc28gbGNkaWYgYW5kIGRzaW0gYXJlIGRpc2FibGVkKS4gT25jZSBJ
IHJlbW92ZSB0aGUgdGhyZWUgbm9kZXMgdGhlDQo+IGlzc3VlIGlzIGdvbmUuDQoNCg0KSSBoYXZl
IGFuIHVwZGF0ZWQgY29kZSBoZXJlOg0KaHR0cHM6Ly9naXRodWIuY29tL01yVmFuL2xpbnV4L3Ry
ZWUvbGludXgtbmV4dC1tYXN0ZXItNjI4LWJsay1jdGwtdGVzdA0KDQpPbmx5IGhhdmUgYmxrLWN0
bCxncGMscGQgdXBkYXRlLiBQbGVhc2UgaGVscCB0ZXN0IHdpdGggYXBwbHlpbmcgeW91cg0KbG9j
YWwgcGF0Y2hlcyB3aXRoIHNvbWUgcGVyaXBoZXJhbHMgZW5hYmxlZC4NCg0KSSB0ZXN0ZWQgdGhl
IHVwcGVyIGNvZGUgd2l0aCBzdXNwZW5kL3Jlc3VtZSB3aXRoIHVhcnQgd2FrZXVwLA0KaXQgbm90
IGhhbmcgYW55bW9yZS4NCg0KVGhhbmtzLA0KUGVuZy4NCg==
