Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243C238D2B4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 02:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhEVA4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 20:56:23 -0400
Received: from mail-eopbgr60047.outbound.protection.outlook.com ([40.107.6.47]:8461
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230280AbhEVA4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 20:56:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPCmZr9sFIXa3L3THMWh3YDIAp67lXfUZIKrNxUOz0DstgsmwAf79fz0t74UxywtCwN0fg7FtDTzOifWHuDXmC0wFgodIdBW7blrfvdtc6Gcz9eUYwPO0UO2tc5m7YTd0icDEwzlMdV207B1hR2wRXgYenzUWJ/HPPUdV6Vwsur5Fu2/7OJmeDq/IrRKjByD3apOialicR/RaHNm0hdGXvGfpogdUW5SoyTvx1uWAq/UHbl4Ht+oX8JxY9rrC7SZpgri4UuZMhZ/vAZ0vnlWFQqbCvRXZJ9gUI+j1GfpIrrQCOXht0SFFAdmKkPzEAhYhTKMy3Cn2z17WInXZF9FhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7RLsnn5/HRHLtJDxI1jvRtrXjk54f/aYp7FFNq9k74=;
 b=iOVg8eksJs9aukO3VBl7cGw2lq9wfxuQ8c5PAQ6TxwOLcEs1zgKms4NISbJhYw3tEc70YlMrzzk7QuKcxEnwsjWg5JAuAh20GiizeSGHH7gkAd1sgd/bpTJAkB2Pn3JpDyBorl0nor8Bjdvzl8/ygFUNBwN4W74jCpFMJ3377VBlJrsQwFFPlhOM4pqjYdjVIkNA7LnuwnTWDBEpCshmDH9nzuPKuFsUrVRIYwOpaRW9e8pStWASB2FYHWSGMakmf5exsccyMe57RF57F57XtK4Dwq2Go6ad33Rshnd0GwEZxNEoaezKdJ2ugzFJrWjKXtSq1gSSxTMTCBao3sDtTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7RLsnn5/HRHLtJDxI1jvRtrXjk54f/aYp7FFNq9k74=;
 b=ZJd24envZTxX+izHU125vg4RRcCo86X0DiYNWHWfqLYVptYhEONbldYi0zJ1OynT73doIHyKMdK28W8VTndcJsKU3gUOYcjAq8yhLgd+YEl9j9oMam+y8HHnchAo+msRjygpknVlT//JPKOTLgrUXX2IkmAc/oTqRjVbKUSXHBQ=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6618.eurprd04.prod.outlook.com (2603:10a6:10:10e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Sat, 22 May
 2021 00:54:56 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4129.036; Sat, 22 May 2021
 00:54:56 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Adam Ford <aford173@gmail.com>,
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
        Marek Vasut <marex@denx.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: RE: [PATCH V5 0/4] soc: imx: add i.MX BLK-CTL support
Thread-Topic: [PATCH V5 0/4] soc: imx: add i.MX BLK-CTL support
Thread-Index: AQHXTivYvjigSv6Ln0ykHSUT474sdqruEhmAgACa4hA=
Date:   Sat, 22 May 2021 00:54:56 +0000
Message-ID: <DB6PR0402MB276010E5B7C2318C8DC2685188289@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20210521105919.20167-1-peng.fan@oss.nxp.com>
 <CAHCN7xJRN3W8pu+eALrv35rsQEDe9We9T5Ej=M0Et_ZuFe7vng@mail.gmail.com>
In-Reply-To: <CAHCN7xJRN3W8pu+eALrv35rsQEDe9We9T5Ej=M0Et_ZuFe7vng@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2cacd605-ec89-4abd-40ec-08d91cbc37d8
x-ms-traffictypediagnostic: DB8PR04MB6618:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB661892FD5C30AF83EF225CB888289@DB8PR04MB6618.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B3pPS+I+6AUlvZvg/XtA/SPRzK4jr8xx3CWckAApAnaTAndOU5zCwPLJfNtuV1gDD3m/vkwG0sXXm9k64fJAs7eDnE+RGYAjkVU9WAwwstm0YDFk9OhDv/qtx8OpfthnhLGLGH93+QDxbCgYrfVeC09uLEsNg9c/uAKK5mmL/AK21hBRvmLxLctGKj44rWmKuXqOUhk9uc05P1mrIkPLWEzY62ZDZF1Jjh70GlOhsmJGAn8pS+4t5/h+TWcrFvDNLMuDeClbG/M3fVOIU+ftHQ5ORSpZ7ePsIAX2T72TDg9ahtCE+by0egjCeoGeDjXufmTgMzuM6l2LqAvtAjeFQrHt8w0dVnR68YzFWZq9lVqO+VHksIx2IeX0s9aEgNV9yUM8u+NChAAhw4G1x3JJhtEgvPnQM0UavtzKiLbi89wZIMkQ+r1tL3uR+UhRjBedN/z12UUuZiuoARQn7HVIF1lMaq8Mge0Gwm0b5RGNiHpPbmUft6m9pZkH8Br8YQhr6AQFO3fcaTgR7LcRxkXFUF5UatKClsQGHWayOkT5VUsOZEcXcuMn4zfhzVrrnTPor3pMTZrbYiDaDqiL2QBNN8VKQ+J3k0B/J/iyMdCc0eU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39850400004)(346002)(396003)(376002)(66946007)(86362001)(44832011)(64756008)(66446008)(66556008)(66476007)(122000001)(7416002)(38100700002)(5660300002)(71200400001)(33656002)(4326008)(478600001)(52536014)(76116006)(8936002)(53546011)(26005)(9686003)(2906002)(186003)(316002)(110136005)(6506007)(83380400001)(7696005)(8676002)(54906003)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dFk3UWhGUEk1Q0wzVFNWQnFBSlFJY0FMTS9pMktIWFJCS0tCVG0rVkI1cFIy?=
 =?utf-8?B?bXZmRGd2WWZPeDVxTStlcEh3eHBiSnlSMnl6dmNYZ2lSZEh2YW1HQVU2KzR0?=
 =?utf-8?B?c2VDQ2c0RzcxYi9mWkJLMzUzUVZmR3ZqUGNWV1FZY3VkT1ZBMG5FeDlXc1Nl?=
 =?utf-8?B?bHhNWG9MVDg1N0VnWWVnSkJNalFVWC9MTDZmY1RWZlgyL3BkZ29qcXNqWC96?=
 =?utf-8?B?bmhpVEMvVnBITTJRRE1pWkIrYjFNVElzQkNnQkJNNzVBMkNuWW5EUWNWTmFp?=
 =?utf-8?B?TmdKdVhmTTA2UkNpajJFK2IwVjJ4MGhiQll2OHIwNWxkQXRiYVBudU44NHQ4?=
 =?utf-8?B?dXdzaVBqMG9iaDU0VFl5T2E1U2lsZkJJc1JEVy9pa05vRzZiaXFsK0dSaThw?=
 =?utf-8?B?Um0vQzNCQUpUNUtjeG9EWHFyalpyNGMrc09SNDhNa1NtcGsxZEpIZjlPZUM2?=
 =?utf-8?B?eW9mMEozUjBHb2NDTDRCaEhzU0J2MjRHbDVINWdFaVZ4QytoQWNmOXdQdCtx?=
 =?utf-8?B?KzBzMG9QMEFZLzhmR3ZLd0c4RlFDMVFjMUtvZmRSdGp4TStVc3k0RU1RSHNW?=
 =?utf-8?B?eWVIVzNWOU54aDNRN2MwS0RBT1o3ek9WR3krNFUyb1B1WFh4ZWlseU95UmJ4?=
 =?utf-8?B?S3B2bE5TV2l0YTMyMmJhaUpIVG5RdW5GQXB4MW5aRm5EbkxuaURaT25vbmQr?=
 =?utf-8?B?NW1FK2ZzK2NURWF1WFh5VmY5bHFPWjVET3JBcnJRN0xmV09DNy9jQ296TlBq?=
 =?utf-8?B?UStuMjkybWNwT0NKYk9MamJoZXNBNmk4YjhFTjFJVG5za0FiYVpkUk9NVHM1?=
 =?utf-8?B?cTlRTVdicnU1ZkoxS2xoanRSWDJhQlM3YUxUT1M0cEZSeW5vdXVzNzE3T1lN?=
 =?utf-8?B?dmpZNWtaMUg0TCtsMEdQdWdhcFpSTGs5RnpsY1lJVUJhM1g3VjJLMmRidUdZ?=
 =?utf-8?B?VW90WXRRVjV1VVVwQ0laOGJKemp1OHQ4UUlSUzRmdUtCUmpZVU4rSFlWMUdT?=
 =?utf-8?B?bTZOaG9PcWp6dUJXNXZLMDV1am1HcVFIZTFoSks0bllxTUNHTG1wVnU4aGZp?=
 =?utf-8?B?KytEYVh2ZzRIWkdYSGgrNEFhTkhvRSt6QUsvQWFsN0JGTWkxdWllc1FGY3da?=
 =?utf-8?B?b1N3c1kyYUR1MG9NRzU4SWU5N2MwcmU1ZGdwemhTdms4dDlKL1UxSEF6d2Za?=
 =?utf-8?B?ZklIWnRwYmNFdVE0R2JReG42T3k1T2ZTWlNtOVE5NWNmQjduRmU2MTNlVmJ5?=
 =?utf-8?B?Y2lTa2lkYVhZYlkzeDJZeGxyOTZ0TGduT0JxNXU5V1RhT1VFTzgrVUVlWjJK?=
 =?utf-8?B?ZGFEcElSR3VSMUd5c3VwK0cvS1dHaEZUTWF3TnBWN1RGWUNPNGowTHg2SnE2?=
 =?utf-8?B?YXFNS1NhT3diYXZZRy9jVkVucTRUYVVzT1ROTFVDb0g0K0FJZTRlMDRZcmt5?=
 =?utf-8?B?NUhGa0x1UUVRdTB4emVnREV1OGFERUF0UDdNdmVHN09BMTh4cmVxS1pNV0c1?=
 =?utf-8?B?ZHR4bXJhUkZXYWdTNWt1Z2NBWW1NL2ZiWG93UUxua0FrRDFXNzk5ZTR0eXd5?=
 =?utf-8?B?blZ4RThsN1JuUU5KRktzb0hOTU9tRU5uWGdROWVCVVJCMG9iVGdXUGZoM2hi?=
 =?utf-8?B?blZ0OUFzKzNzSEs0UHkyRHUrTnpqTkw0dit4ZWtZTFZvWWMzZnk4cTgrL3lr?=
 =?utf-8?B?Q3JWOHRvSjhUMkc1dnlqSHVhU0Q0QWljeDZIS3M5QW0ydzlVdVVOVWNzSVN2?=
 =?utf-8?Q?5J2Jm6KaQ0VAlIQp7P6WaImCe8y2eF804cKmT0I?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cacd605-ec89-4abd-40ec-08d91cbc37d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2021 00:54:56.4565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fLQ8PnRVElEPqbq7JGa4lN+jgfAmGlwcV2nIzVxs0Q6Rp17eeEW/FS+tCOZqnd8ksihfVfyvoXPCwN/nrbjnMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6618
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIFY1IDAvNF0gc29jOiBpbXg6IGFkZCBpLk1YIEJMSy1DVEwg
c3VwcG9ydA0KPiANCj4gT24gRnJpLCBNYXkgMjEsIDIwMjEgYXQgNToyNyBBTSBQZW5nIEZhbiAo
T1NTKSA8cGVuZy5mYW5Ab3NzLm54cC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogUGVu
ZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4NCj4gPiBWNToNCj4gPiAgUmV3b3JrIHRoZSBi
bGstY3RsIGRyaXZlciB0byBsZXQgc3ViLVBHQyB1c2UgYmxrLWN0bCBhcyBwYXJlbnQgcG93ZXIN
Cj4gPiBkb21haW4gdG8gZml4IHRoZSBwb3RlbnRpYWwgaGFuZHNoYWtlIGlzc3VlLg0KPiA+ICBJ
IHN0aWxsIGtlZXAgUi1iL0EtYiB0YWcgZm9yIFBhdGNoIDEsMiw0LCBzaW5jZSB2ZXJ5IG1pbm9y
IGNoYW5nZXMgIEkNCj4gPiBvbmx5IGRyb3AgUi1iIHRhZyBmb3IgUGF0Y2ggMywgc2luY2UgaXQg
aGFzIGJpZyBjaGFuZ2UuDQo+ID4gIEFuIGV4YW1wbGUsIHRoZSBwZ2NfbWlwaSBub3QgdGFrZSBw
Z2NfZGlzcG1peCBhcyBwYXJlbnQ6DQo+ID4NCj4gPiAgICAgICAgIHBnY19kaXNwbWl4OiBwb3dl
ci1kb21haW5AMTAgew0KPiA+ICAgICAgICAgICAgICAgICAjcG93ZXItZG9tYWluLWNlbGxzID0g
PDA+Ow0KPiA+ICAgICAgICAgICAgICAgICByZWcgPSA8SU1YOE1NX1BPV0VSX0RPTUFJTl9ESVNQ
TUlYPjsNCj4gPiAgICAgICAgICAgICAgICAgY2xvY2tzID0gPCZjbGsgSU1YOE1NX0NMS19ESVNQ
X1JPT1Q+LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICA8JmNsayBJTVg4TU1fQ0xLX0RJ
U1BfQVhJX1JPT1Q+LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICA8JmNsayBJTVg4TU1f
Q0xLX0RJU1BfQVBCX1JPT1Q+Ow0KPiA+ICAgICAgICAgfTsNCj4gPg0KPiA+ICAgICAgICAgcGdj
X21pcGk6IHBvd2VyLWRvbWFpbkAxMSB7DQo+ID4gICAgICAgICAgICAgICAgICNwb3dlci1kb21h
aW4tY2VsbHMgPSA8MD47DQo+ID4gICAgICAgICAgICAgICAgIHJlZyA9IDxJTVg4TU1fUE9XRVJf
RE9NQUlOX01JUEk+Ow0KPiA+ICAgICAgICAgICAgICAgICBwb3dlci1kb21haW5zID0gPCZkaXNw
bWl4X2Jsa19jdGwNCj4gPiBJTVg4TU1fQkxLX0NUTF9QRF9ESVNQTUlYX0JVUz47DQo+IA0KPiBX
aXRoIHRoaXMgY2hhbmdlLCBJIGdldCBhIGJ1bmNoIG9mIGVycm9ycyBvbiBib290LiAgVGhlIGxp
c3Qgb2YgcG93ZXItZG9tYWlucw0KPiBhcHBlYXIgY29ycmVjdCBvbiB0aGUgc3VyZmFjZSwgYnV0
IGl0IGFsc28gaGFzIHRyb3VibGUgd2FraW5nIGZyb20gc2xlZXAuDQo+IA0KPiBbICAgIDAuNjk1
OTQ3XSBpbXg4bW0tYmxrLWN0bCBpbXgtZGlzcG1peC1ibGstY3RsLjA6IGludmFsaWQgcmVzb3Vy
Y2UNCj4gWyAgICAwLjcwMjg0OV0gaW14OG1tLWJsay1jdGw6IHByb2JlIG9mIGlteC1kaXNwbWl4
LWJsay1jdGwuMCBmYWlsZWQNCj4gd2l0aCBlcnJvciAtMjINCj4gWyAgICAwLjcxMTI1OV0gaW14
OG1tLWJsay1jdGwgaW14LWRpc3BtaXgtYmxrLWN0bC4xOiBpbnZhbGlkIHJlc291cmNlDQo+IFsg
ICAgMC43MTY0NTFdIGlteDhtbS1ibGstY3RsOiBwcm9iZSBvZiBpbXgtZGlzcG1peC1ibGstY3Rs
LjEgZmFpbGVkDQo+IHdpdGggZXJyb3IgLTIyDQo+IFsgICAgMC43MjQ4NTZdIGlteDhtbS1ibGst
Y3RsIGlteC1kaXNwbWl4LWJsay1jdGwuMjogaW52YWxpZCByZXNvdXJjZQ0KPiBbICAgIDAuNzMw
MDk3XSBpbXg4bW0tYmxrLWN0bDogcHJvYmUgb2YgaW14LWRpc3BtaXgtYmxrLWN0bC4yIGZhaWxl
ZA0KPiB3aXRoIGVycm9yIC0yMg0KPiBbICAgIDAuNzM4Mzk4XSBpbXg4bW0tYmxrLWN0bCBpbXgt
ZGlzcG1peC1ibGstY3RsLjM6IGludmFsaWQgcmVzb3VyY2UNCj4gWyAgICAwLjc0Mzc0N10gaW14
OG1tLWJsay1jdGw6IHByb2JlIG9mIGlteC1kaXNwbWl4LWJsay1jdGwuMyBmYWlsZWQNCj4gd2l0
aCBlcnJvciAtMjINCg0KSXQgaXMganVzdCB0aGUgaW14OG1tLWJsay1jdGwgZHJpdmVyIG1hdGNo
ZXMgd2l0aCB0aGUgbmV3IGNyZWF0ZWQNCmNoaWxkIGRldmljZSwgYmVjYXVzZSB0aGUgY2hpbGQg
ZGV2aWNlIHBvaW50cyB0aGUgb2Zfbm9kZSBvZiB0aGUgcGFyZW50DQpkZXZpY2UuDQpCdXQgdGhp
cyBlcnJvciB3aWxsIG5vdCBhZmZlY3QgZnVuY3Rpb25hbGl0eS4NCkknbGwgcmVzb2x2ZSB0aGlz
IGlzc3VlIGFuZCBzZW5kIG91dCB2Ni4NCj4gDQo+IElmIEkgaGF2ZSBhIHdyb25nIGRldmljZSB0
cmVlIGNvbmZpZ3VyYXRpb24sIGNhbiB5b3UgcGxlYXNlIHBvc3QgYW4gdXBkYXRlZA0KPiBkZXZp
Y2UgdHJlZT8gIEkgZG9uJ3QgdGhpbmsgYW4gb2ZmaWNpYWwgcGF0Y2ggZm9yIG9yaWdpbmFsIHBn
YydzIHdlcmUgcHVzaGVkIGFzDQo+IHBhcnQgb2YgZWl0aGVyIHNlcmllcy4gSSB1c2VkIHRoaXMg
ZS1tYWlsIGFzIHRoZSBwYXRjaCB0byBlbmFibGUgdGhlIGJsay1jdGwuDQoNCkRvIHlvdSBoYXZl
IGFuIGRldmljZSB0cmVlLCBJIGNvdWxkIGdpdmUgYSBsb29rLg0KDQpSZWdhcmRzLA0KUGVuZy4N
Cg0KPiANCj4gdGhhbmtzLA0KPiANCj4gYWRhbQ0KPiANCj4gPiAgICAgICAgIH07DQo+ID4NCj4g
PiAgICAgICAgIGRpc3BtaXhfYmxrX2N0bDogY2xvY2stY29udHJvbGxlckAzMmUyODAwMCB7DQo+
ID4gICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiZnNsLGlteDhtbS1kaXNwbWl4LWJsay1j
dGwiLCAic3lzY29uIjsNCj4gPiAgICAgICAgICAgICAgICAgcmVnID0gPDB4MzJlMjgwMDAgMHgx
MDA+Ow0KPiA+ICAgICAgICAgICAgICAgICAjcG93ZXItZG9tYWluLWNlbGxzID0gPDE+Ow0KPiA+
ICAgICAgICAgICAgICAgICBwb3dlci1kb21haW5zID0gPCZwZ2NfZGlzcG1peD4sIDwmcGdjX21p
cGk+Ow0KPiA+ICAgICAgICAgICAgICAgICBwb3dlci1kb21haW4tbmFtZXMgPSAiZGlzcG1peCIs
ICJtaXBpIjsNCj4gPiAgICAgICAgICAgICAgICAgY2xvY2tzID0gPCZjbGsgSU1YOE1NX0NMS19E
SVNQX1JPT1Q+LCA8JmNsaw0KPiBJTVg4TU1fQ0xLX0RJU1BfQVhJX1JPT1Q+LA0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICA8JmNsayBJTVg4TU1fQ0xLX0RJU1BfQVBCX1JPT1Q+Ow0KPiA+
ICAgICAgICAgfTsNCj4gPg0KPiA+IFY0Og0KPiA+ICBBZGQgUi1iIHRhZw0KPiA+ICBUeXBvIGZp
eA0KPiA+ICBVcGRhdGUgdGhlIHBvd2VyIGRvbWFpbiBtYWNybyBuYW1lcyBQZXIgQWJlbCBhbmQg
RnJpZWRlcg0KPiA+DQo+ID4gVjM6DQo+ID4gIEFkZCBleHBsYWluYXRpb24gZm9yIG5vdCBsaXN0
aW5nIGl0ZW1zIGluIHBhdGNoIDIgY29tbWl0IGxvZyBQZXIgUm9iLg0KPiA+ICBBZGRyZXNzZWQg
Y29tbWVudHMgZnJvbSBMdWNhcyBhbmQgRnJpZWRlciBvbiBwYXRjaCBbMyw0XS4NCj4gPiAgQSBm
ZXcgY29tbWVudHMgZnJvbSBKYWNreSB3YXMgaWdub3JlZCwgYmVjYXVzZSBmb2xsb3dpbmcgZ3Bj
djINCj4gPiBjb2Rpbmcgc3R5bGUuDQo+ID4NCj4gPiBWMjoNCj4gPiAgRml4IHlhbWwgY2hlY2sg
ZmFpbHVyZS4NCj4gPg0KPiA+IFByZXZpb3VzbHkgdGhlcmUgaXMgYW4gZWZmb3J0IGZyb20gQWJl
bCB0aGF0IHRha2UgQkxLLUNUTCBhcyBjbG9jaw0KPiA+IHByb3ZpZGVyLCBidXQgaXQgdHVybnMg
b3V0IHRoYXQgdGhlcmUgaXMgQS9CIGxvY2sgaXNzdWUgYW5kIHdlIGFyZSBub3QNCj4gPiBhYmxl
IHJlc29sdmUgdGhhdC4NCj4gPg0KPiA+IFBlciBkaXNjdXNzIHdpdGggTHVjYXMgYW5kIEphY2t5
LCB3ZSBtYWRlIGFuIGFncmVlbWVudCB0aGF0IHRha2UNCj4gPiBCTEstQ1RMIGFzIGEgcG93ZXIg
ZG9tYWluIHByb3ZpZGVyIGFuZCB1c2UgR1BDJ3MgZG9tYWluIGFzIHBhcmVudCwgdGhlDQo+ID4g
Y29uc3VtZXIgbm9kZSB0YWtlIEJMSy1DVEwgYXMgcG93ZXIgZG9tYWluIGlucHV0Lg0KPiA+DQo+
ID4gVGhpcyBwYXRjaHNldCBoYXMgYmVlbiB0ZXN0ZWQgb24gaS5NWDhNTSBFVksgYm9hcmQsIGJ1
dCBvbmUgaGFjayBpcw0KPiA+IG5vdCBpbmNsdWRlZCBpbiB0aGUgcGF0Y2hzZXQgaXMgdGhhdCB0
aGUgRElTUE1JWCBCTEstQ1RMDQo+ID4gTUlQSV9NL1NfUkVTRVQgbm90IGltcGxlbWVudGVkLiBQ
ZXIgTHVjYXMsIHdlIHdpbGwgZmluYWxseSBoYXZlIGEgTUlQSQ0KPiA+IERQSFkgZHJpdmVyLCBz
byBmaW5lIHRvIGxlYXZlIGl0Lg0KPiA+DQo+ID4gVGhhbmtzIGZvciBMdWNhcydzIHN1Z2dlc3Rp
b24sIEZyaWVkZXIgU2NocmVtcGYgZm9yIGNvbGxlY3RpbmcgYWxsIHRoZQ0KPiA+IHBhdGNoZXMs
IEFiZWwncyBwcmV2aW91cyBCTEstQ1RMIHdvcmssIEphY2t5IEJhaSBvbiBoZWxwIGRlYnVnIGlz
c3Vlcy4NCj4gPg0KPiA+DQo+ID4gUGVuZyBGYW4gKDQpOg0KPiA+ICAgZHQtYmluZGluZ3M6IHBv
d2VyOiBBZGQgZGVmaW5lcyBmb3IgaS5NWDhNTSBCTEstQ1RMIHBvd2VyIGRvbWFpbnMNCj4gPiAg
IERvY3VtZW50YXRpb246IGJpbmRpbmdzOiBjbGs6IEFkZCBiaW5kaW5ncyBmb3IgaS5NWCBCTEtf
Q1RMDQo+ID4gICBzb2M6IGlteDogQWRkIGdlbmVyaWMgYmxrLWN0bCBkcml2ZXINCj4gPiAgIHNv
YzogaW14OiBBZGQgYmxrLWN0bCBkcml2ZXIgZm9yIGkuTVg4TU0NCj4gPg0KPiA+ICAuLi4vYmlu
ZGluZ3Mvc29jL2lteC9mc2wsaW14LWJsay1jdGwueWFtbCAgICAgfCAgNjYgKysrKw0KPiA+ICBk
cml2ZXJzL3NvYy9pbXgvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKy0NCj4g
PiAgZHJpdmVycy9zb2MvaW14L2Jsay1jdGwtaW14OG1tLmMgICAgICAgICAgICAgIHwgMTM5ICsr
KysrKysrDQo+ID4gIGRyaXZlcnMvc29jL2lteC9ibGstY3RsLmMgICAgICAgICAgICAgICAgICAg
ICB8IDMxMQ0KPiArKysrKysrKysrKysrKysrKysNCj4gPiAgZHJpdmVycy9zb2MvaW14L2Jsay1j
dGwuaCAgICAgICAgICAgICAgICAgICAgIHwgIDg1ICsrKysrDQo+ID4gIGluY2x1ZGUvZHQtYmlu
ZGluZ3MvcG93ZXIvaW14OG1tLXBvd2VyLmggICAgICB8ICAxMyArDQo+ID4gIDYgZmlsZXMgY2hh
bmdlZCwgNjE1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkgIGNyZWF0ZSBtb2RlIDEwMDY0
NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvaW14L2ZzbCxpbXgt
YmxrLWN0bC55YW1sDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3NvYy9pbXgvYmxr
LWN0bC1pbXg4bW0uYyAgY3JlYXRlIG1vZGUNCj4gPiAxMDA2NDQgZHJpdmVycy9zb2MvaW14L2Js
ay1jdGwuYyAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gZHJpdmVycy9zb2MvaW14L2Jsay1jdGwu
aA0KPiA+DQo+ID4gLS0NCj4gPiAyLjMwLjANCj4gPg0K
