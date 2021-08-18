Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED53A3EFE4A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 09:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239148AbhHRHym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 03:54:42 -0400
Received: from mail-db8eur05on2086.outbound.protection.outlook.com ([40.107.20.86]:16199
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238014AbhHRHyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 03:54:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wv/7CLZ6zMQV4p6ChuAQ8q+lz5pQqOYmNeYTojZNKHqtHABW87++L9hAHV/c1XT+OYv0Bu3cG+IzvPKQk5FEnddseAq42eD9FILZzWyUsY5/6rFdDbJflytO68Umb1f45EkoOvFana/lWMuvgJnrdLWf7T7Azuq9600rap0LiqM7xR24gUGyO619zRKy46bq0E1q7WnnlMeQ4PgYLIX2NWL2RbqGCypPt39vmspz3sihN3t498M2jP1vdW95BjujfOC3I6hGqMMNgazRbEiwOGvQifGWfwAMo27IAaIuA7fVbjDWc4vLmiESj/U63YnAHc2e+4QMAR9PJtEkbfyGfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PYC0+SVCSqr/cX/a5ZDRHVRosoh7vtbIlyZUtjSEq8=;
 b=XVBCB1FD8xS1tI62EdVF1c3Tu3beUsPWye+JNat4F5XLomf7eUEHKddIbRfCVAiclX4gNSvPyYzI+MPx8sMxQxoyihEj2zERL9dtCVXr5pfSyi1DIyh4/9BUOnOaGJVqw2VKoEBKxT3SWj/Kyn55cjDkA+tn0QMnNUKyBY4MQt3QvmEP04aVepakVQS/H0IsISqP2zcaRjEuaiEUMU1YVT2Nga2TWZltbZQCcNzAwweMxhlmOOBJc6PD02PrzrJ7rr9HgeHE1+biQ8x/ipZ2okkmyeF1ti39PSUbCSgdIcoyXWd/UtQjmqKXye4OAF0cKDrtt8rpcE/HEMeUrGi8+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PYC0+SVCSqr/cX/a5ZDRHVRosoh7vtbIlyZUtjSEq8=;
 b=FMte/mPkOKb/mG6G43hhdShjvEaETGNneisRNgZNbXUKb20myoBe8dvaGwEDXZc+0+XQBakOio8arziXJmQwMjL6nOzmXN6wrNg+UrItvFAq/xr2njm07OSvA6REmVepvDbaz3GEuh0OSMVVeyeLElu5khmYEorGfHb749ZYy9U=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB7PR04MB3961.eurprd04.prod.outlook.com (2603:10a6:5:25::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Wed, 18 Aug
 2021 07:54:04 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::6969:eadc:6001:c0d]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::6969:eadc:6001:c0d%6]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 07:54:04 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V1 1/4] bindings: nvmem: introduce "reverse-data" property
Thread-Topic: [PATCH V1 1/4] bindings: nvmem: introduce "reverse-data"
 property
Thread-Index: AQHXjbpIBwDJH2bCBk6a1JjgGNijp6tuGImAgAoQXgCAAMcfEA==
Date:   Wed, 18 Aug 2021 07:54:04 +0000
Message-ID: <DB8PR04MB67951E2312CFD69808B4502BE6FF9@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20210810073510.18218-1-qiangqing.zhang@nxp.com>
 <20210810073510.18218-2-qiangqing.zhang@nxp.com>
 <6e3f6881-929d-1663-58f1-39bf35069175@linaro.org>
 <YRwUyLsvoSpFI9X8@robh.at.kernel.org>
In-Reply-To: <YRwUyLsvoSpFI9X8@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d335986c-89ea-45dd-745d-08d9621d5964
x-ms-traffictypediagnostic: DB7PR04MB3961:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB3961FECBF29630E05A688A36E6FF9@DB7PR04MB3961.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PMhD1V31q0nT96b6XWt5vWOMfxTR9dnHzuVPiy2v6ks38GiAm+D2ksYCjgpINWVTSbLOq4JOMebdWtkWRRHIqqtIyTas2wfodKcPa+uP+pvEYfjzzDrXoPuIOUPXzF8DTJ+itwDbWGbzLghM41fSlYIJI3Qg5srn5BvdWwly48qRQZJMQVs6Nr9un8AYpjP/q6jvf7v6pdv7RU2kFzNv/Dc9374HYD7fMw0iUmnVoGxhXH2HC+6KIFDPLMj3E1206wUugaSdyFT8Dm72gVrPdPdSP1Nr/aoahhSk9rtnecGCzF65euoAgJx7dKum1aDoq5CELB/s8a6dKd9Prghah2Ifh+eFfyWkis+gZpJ1jd1uKE769elerZSkGsGIhEKpB6UWpLpV6Gh76QGsC8RisYRE1oKnyVIJ9j3NsQNskOWQHLaBnkeM+3vnrWETbpULTy1Y6TfaHnrClz4fwyJM+DBuw5hrbI2sZ3lhskIjk24Kqq8rgk1c/nFlpU/ZeTitz0G05SiU+zvFt88ATaCXXnkoyQivDJsLD0Eunjrd8/IWzMOHqJaF96jy8kJlxtMDqqlv/8zaTcoJMBX7rYI2t5NU/3Z/LfmbOzmVjt5kU1PHiGC3eEoyKj1d2g25M/2Ou5JElqU/G/WpMET+DlbTzu5AoITVS5FetwGF3lXWKMyXi6Xvnf62JJNUc6eUVpMG3x8ajDgWUtqbDlA5ssuQMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(66476007)(64756008)(66446008)(38070700005)(26005)(76116006)(66556008)(9686003)(66946007)(53546011)(186003)(8676002)(7696005)(4326008)(8936002)(5660300002)(2906002)(6506007)(52536014)(55016002)(122000001)(110136005)(316002)(38100700002)(478600001)(71200400001)(83380400001)(54906003)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?RGMwQlplSFNKZEhLKzQybEJqeXpIVHhWdTNUejhLOHpDaFA1K3Z4dTA2YnIv?=
 =?gb2312?B?MWcwTm1qcHF2blpjei9LZnNOWlRyekxXMEdUNjJac3o5VUNoZG1WQkwwTFlS?=
 =?gb2312?B?M1NqcDdGUktFZUlsb1JGVVg4SmNLaENsZytUS1pDdHhsVGNNdVd4V0lYbGNp?=
 =?gb2312?B?RTlPZVV3Q3pESmJ6NkVFN3Zrc2pTNm56MXp5dG5oaDEzVmlaV3pHYlc3K0hV?=
 =?gb2312?B?c0cxeW1nQis2em42RGFlTHoyRkN5dzNnSC9OT3pyY3ZpTGR3MmdtWGR2eEdp?=
 =?gb2312?B?Z2FlUVRzUjVlcjI4UlFlL2JEeXZIb3ZDODZaMUpFU1k1dmpLdDBhbG54VFho?=
 =?gb2312?B?YUp2ajlaNFZmTGpGUGlSZ1N0bHhUQzc4MTlnQ05rZzI3OU1uWjZHOEEwN010?=
 =?gb2312?B?MXlJWGJPSjBKQnJWWjJGU29oVnhsL095RnJmK2R5MGN5OFdTUitmQmVVd09r?=
 =?gb2312?B?RDllbGJ3Y2oxSHMxMlpFb1BjRmJpWmEvLy95WG10bXFEZ21PMUxWYVJUOUNi?=
 =?gb2312?B?a2Q0YjBWbnJUcGtpRW9qSzhnRmd2b2tXSjZSVmpHNDh4U3M4R0R0cG9tUklM?=
 =?gb2312?B?c2tLWVN5WHNCK0VNVEEzTVFoakhJSUVoRFc0eENoN0UrVE5jMVdlWEc3SmRp?=
 =?gb2312?B?dXJqNHdleXM4Z0Jna1hoVjhEOXBMeC9UYktMQ0gyR25RR1IrRUthNm5NUlRJ?=
 =?gb2312?B?eTh1dFVNZFJJMmpjVi8rcHlzeTJ6SkI0SC9HSng3QjA4V2NlUENsSlI2TDBJ?=
 =?gb2312?B?dTBnYXA2YURLNmJEV20yTlhDZE54dlBBQ3BUc3Bad25sKzhURGxNMmN6M2hO?=
 =?gb2312?B?S24yYWVXSmRjQXh2QzBWeGZ5SXVSektBYjlkckRzcGlhaVMwUWtLclRVVnBw?=
 =?gb2312?B?TktrVEtvUDh0K0paSnVzV29hMm9HQ3ViU0lkMUVIbzNuQkxYbzdFQmkrVDNl?=
 =?gb2312?B?WityOE5VQWYwWElYZUNCUGF2dy9BQmRoQWFqTC83djBtREUxTkhBYXJqaGd0?=
 =?gb2312?B?b2drU2JCNUlnSG9tWFYxNDZMSkZvN1ZZUVRja0RDZkViODlHRlJqM3owV1BH?=
 =?gb2312?B?WXMvNHg0Qk9RMHZLTWZzTG1ZWkdDeTYyNitSVVJxNEpndXJuaTUwT0ZaYUVt?=
 =?gb2312?B?VGFVbWlLTDcrbXJPTUhnamlDYmhjS2ZUc0xSSk1sTlZNU0EraFlQb3JtNXdK?=
 =?gb2312?B?WkI2RkFMSFpGZVNqcmZ3WEFab2RiR2hySzY2VjdHZVdYWWVSWVJEWjZJYWFD?=
 =?gb2312?B?Rk1GeUJwTGFBWUVnd203SGl6Y0gxc3JNbUpPcFlLVEswZ0kyU1plOWxMaFdz?=
 =?gb2312?B?TmxDL3F6SFdGNi9HMEYxTnJRa0NhSC93Y1hPQXlzaVJ2YnE5WDJVc1lKZVNz?=
 =?gb2312?B?YXpEd0NjUkVHYWNLaFpVT0ZGVDVhTVYxM3Nhd0cySFM1bXB4T1czNVczeVNq?=
 =?gb2312?B?S29UUGVtUE80eEtZcGZhdUxQd3VsWStkcmJzei9qWklKRlNUVzFYTFFDL24z?=
 =?gb2312?B?RHBSeW9IZCswVFRENkRFRUoxU0w2R2NNSGNFWUg2S2FXem4rckNPQitZdzRZ?=
 =?gb2312?B?VDdXWXM3a1pxRFk4Y2JzSVRqRHNGekxzd3pVSjNIdzhRSm5DWUphbElHQ1Fp?=
 =?gb2312?B?cHVFcGhlWHpadHlwMnhUNkZJb2ZMMmtQbHFGUVVhM0UrS0VlbzFlZHVPQUs5?=
 =?gb2312?B?Nk5PUXFuZS8vTmlNN002d1AyNkZIQVRLR3JYcXRQWWFTZkM4bnRKNkRFcFpi?=
 =?gb2312?Q?UgYXgROdca3z7l3QZrWAZgEC8oFvJvIdleXucmo?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d335986c-89ea-45dd-745d-08d9621d5964
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 07:54:04.2238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6DsdGAZjxCHNffIidnwpf500DszzeEJmDlEby4Qay2MBwaL7zN7vKJzNlHoEICq0p/MDdYE1+XHAXysuuJmmYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB3961
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJyaW5nIDxyb2Jo
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjHE6jjUwjE4yNUgMzo1OA0KPiBUbzogU3Jpbml2YXMg
S2FuZGFnYXRsYSA8c3Jpbml2YXMua2FuZGFnYXRsYUBsaW5hcm8ub3JnPg0KPiBDYzogSm9ha2lt
IFpoYW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT47IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+
IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47
DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjEgMS80XSBiaW5kaW5nczogbnZtZW06IGludHJv
ZHVjZSAicmV2ZXJzZS1kYXRhIg0KPiBwcm9wZXJ0eQ0KPiANCj4gT24gV2VkLCBBdWcgMTEsIDIw
MjEgYXQgMTE6MTY6NDlBTSArMDEwMCwgU3Jpbml2YXMgS2FuZGFnYXRsYSB3cm90ZToNCj4gPg0K
PiA+DQo+ID4gT24gMTAvMDgvMjAyMSAwODozNSwgSm9ha2ltIFpoYW5nIHdyb3RlOg0KPiA+ID4g
SW50cm9kdWNlICJyZXZlcnNlLWRhdGEiIHByb3BlcnR5IGZvciBudm1lbSBwcm92aWRlciB0byBy
ZXZlcnNlIGJ1ZmZlci4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKb2FraW0gWmhhbmcg
PHFpYW5ncWluZy56aGFuZ0BueHAuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgIERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9udm1lbS9udm1lbS55YW1sIHwgNSArKysrKw0KPiA+ID4g
ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9udm1lbS9udm1lbS55YW1sDQo+
ID4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9udm1lbS9udm1lbS55YW1s
DQo+ID4gPiBpbmRleCBiOGRjM2QyYjZlOTIuLmJjNzQ1MDgzZmM2NCAxMDA2NDQNCj4gPiA+IC0t
LSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9udm1lbS9udm1lbS55YW1sDQo+
ID4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbnZtZW0vbnZtZW0u
eWFtbA0KPiA+ID4gQEAgLTYxLDYgKzYxLDExIEBAIHBhdHRlcm5Qcm9wZXJ0aWVzOg0KPiA+ID4g
ICAgICAgICAgICAgICAgIGRlc2NyaXB0aW9uOg0KPiA+ID4gICAgICAgICAgICAgICAgICAgU2l6
ZSBpbiBiaXQgd2l0aGluIHRoZSBhZGRyZXNzIHJhbmdlIHNwZWNpZmllZCBieSByZWcuDQo+ID4g
PiArICAgICAgcmV2ZXJzZS1kYXRhOg0KPiA+ID4gKyAgICAgICAgJHJlZjogL3NjaGVtYXMvdHlw
ZXMueWFtbCMvZGVmaW5pdGlvbnMvZmxhZw0KPiA+ID4gKyAgICAgICAgZGVzY3JpcHRpb246DQo+
ID4gPiArICAgICAgICAgIFJldmVyc2UgdGhlIGRhdGEgdGhhdCByZWFkIGZyb20gdGhlIHN0b3Jh
Z2UgZGV2aWNlLg0KPiA+ID4gKw0KPiA+DQo+ID4gVGhpcyBuZXcgcHJvcGVydHkgaXMgb25seSBn
b2luZyB0byBzb2x2ZSBvbmUgb2YgdGhlIHJldmVyc2Ugb3JkZXINCj4gPiBpc3N1ZSBoZXJlLg0K
PiA+IElmIEkgcmVtZW1iZXIgY29ycmVjdGx5IHdlIGhhdmUgbWFjLWFkZHJlc3Mgc3RvcmVkIGlu
IHZhcmlvdXMgZm9ybWF0cyBleDoNCj4gPiBmcm9tIG9sZCB0aHJlYWQgSSBjYW4gc2VlDQo+ID4N
Cj4gPiBUeXBlIDE6IE9jdGV0cyBpbiBBU0NJSSB3aXRob3V0IGRlbGltaXRlcnMuIChTd2FwcGVk
L25vbi1Td2FwcGVkKSBUeXBlDQo+ID4gMjogT2N0ZXRzIGluIEFTQ0lJIHdpdGggZGVsaW1pdGVy
cyBsaWtlICgiOiIsICIsIiwgIi4iLCAiLSIuLi4gc28gb24pDQo+ID4gKFN3YXBwZWQvbm9uLVN3
YXBwZWQpDQo+ID4gVHlwZSAzOiBJcyB0aGUgb25lIHdoaWNoIHN0b3JlcyBtYWMgYWRkcmVzcyBp
biBUeXBlMS8yIGJ1dCB0aGlzIGhhcyB0bw0KPiA+IGJlIGluY3JlbWVudGVkIHRvIGJlIHVzZWQg
b24gb3RoZXIgaW5zdGFuY2VzIG9mIGV0aC4NCj4gPiBUeXBlIDQ6IE9jdGV0cyBhcyBieXRlcy91
OCwgc3dhcHBlZC9ub24tc3dhcHBlZA0KPiA+DQo+ID4gSSB0aGluayBpdHMgcmlnaHQgdGltZSB0
byBjb25zaWRlciBhZGRpbmcgY29tcGF0aWJsZXMgdG8gbnZtZW0tY2VsbHMNCj4gPiB0byBiZSBh
YmxlIHRvIHNwZWNpZnkgZW5jb2RpbmcgaW5mb3JtYXRpb24gYW5kIGhhbmRsZSBwb3N0IHByb2Nl
c3NpbmcuDQo+IA0KPiBZZXMuIFRyeWluZyB0byBoYW5kbGUgdGhpcyB3aXRoIG5ldmVyIGVuZGlu
ZyBuZXcgcHJvcGVydGllcyB3aWxsIGVuZCB1cCB3aXRoIGENCj4gbWVzcy4gQXQgc29tZSBwb2lu
dCwgeW91IGp1c3QgbmVlZCBjb2RlIHRvIHBhcnNlIHRoZSBkYXRhLg0KDQpUaGFua3MsIFJvYi4N
Cg0KSGkgU3Jpbml2YXMsDQoNCkRvIHlvdSBwbGFuIHRvIGltcGxlbWVudCBpdD8NCg0KT3IgbmVl
ZCBtZSBmb2xsb3cgdXA/IElmIHllcywgcGxlYXNlIGlucHV0IHlvdXIgaW5zaWdodHMgdG8gcG9p
bnQgbWUgaG93IHRvIHdvcmsgZm9yIGl0Lg0KDQpUaGFua3MuDQoNCkJlc3QgUmVnYXJkcywNCkpv
YWtpbSBaaGFuZw0KPiBSb2INCg==
