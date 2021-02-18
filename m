Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE5F31E65A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 07:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhBRG36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 01:29:58 -0500
Received: from mail-db8eur05on2067.outbound.protection.outlook.com ([40.107.20.67]:30688
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229765AbhBRGL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 01:11:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PuLZfPOJfXsSakM1dqgC/9NscgC0QO9ZyZK702BUJmDYzw6dAQdJMMY7ovDm8e7ZTYzVR7KvDGoXc2Ie96iGROVP6zQGxnNOdDPsdWrHXr0ZFiHlhehZ8Boe5pofCXh+4kCWnQnVz93+3tTrVCgQhkSQRbMVDYXDJ3+y2XI/qomqWmi1QT4+KCAf8P8ZeDVNGt33iHog/fyyklPR5qSzNvkMiAuP3srGsbmYELMZhNwOxKlepGTPlXym+yj/KRFbYt/nuu5/H54L70E88n9SzLzXyrmEAt8GtCKmLHcUM1DDSoYtU5cXFaLgc25Fe1c3ajXxHD8vogdI7TcxO2vdPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mzN9pdBf0bK+NywaWi8F9rWyuRSe4EUufh++IQjj2U=;
 b=Mw3K7RognenYAXrOcPJQywAaBoFw1Egu7dfUDwdb+DkhS0gOlJVtaa4+j3Em84rBdTNeOvOSsSz+jDjf+y2QV8RK2ufoM2fdvqeuEGl5rVN2qWJTYMiNRW2xaijFI0RY375rWuJHuMP40Gc4sLhpaW8Bvhm99fk2HOAM81l91DzP35nYdBXitug028aAHUqOh5szn9w3Zoj5J4YeEbrHx2rW1OnCM7qLKip49Wbgl5jQFOXM9SVk/yXdBc6LPwtuALolbKc1gmrVi6cybYCjRpM5+G+aOC2BI2gRFWqLDumwhIJRx8m74xz9SIRDGQBPcgyyTN3xS9SXh02xsBv5yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mzN9pdBf0bK+NywaWi8F9rWyuRSe4EUufh++IQjj2U=;
 b=sNOuED9fTJqj37poUcyB72HPz29WQNmtfRBZqW+C3NfTXYHOTzZhZ3Gt3DNfR64E1H5cVgR5a4AKL/Hr2+L59uSvbUKZAB3wPtUR5tHDLvOdnV0NajrXXr3Xg2ZXRvht3Y6UZsxkCBkLqJlI303rREf5pkB3gosQFJaSgcW/dNw=
Received: from DBBPR04MB7930.eurprd04.prod.outlook.com (2603:10a6:10:1ea::12)
 by DB3PR0402MB3660.eurprd04.prod.outlook.com (2603:10a6:8:c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.38; Thu, 18 Feb
 2021 06:10:36 +0000
Received: from DBBPR04MB7930.eurprd04.prod.outlook.com
 ([fe80::d4c5:ce2e:d24d:ac92]) by DBBPR04MB7930.eurprd04.prod.outlook.com
 ([fe80::d4c5:ce2e:d24d:ac92%5]) with mapi id 15.20.3846.041; Thu, 18 Feb 2021
 06:10:36 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: RE: [PATCH] clk: imx8mp: Remove the none exist pcie clocks
Thread-Topic: [PATCH] clk: imx8mp: Remove the none exist pcie clocks
Thread-Index: AQHXBbwiq2vhk3rxB06ZCsyn6/vzeapdbUUw
Date:   Thu, 18 Feb 2021 06:10:36 +0000
Message-ID: <DBBPR04MB79308A7CE1800FCEC4042CCD87859@DBBPR04MB7930.eurprd04.prod.outlook.com>
References: <1613627654-29801-1-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1613627654-29801-1-git-send-email-hongxing.zhu@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 595ab29b-a52f-4f84-92c1-08d8d3d3e88a
x-ms-traffictypediagnostic: DB3PR0402MB3660:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB36602D92083B8AB79B537B2287859@DB3PR0402MB3660.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u6AnBhqJxmgfw1Qpv4nt0wyiUR6jfpScjqcFP3/z3FXPw/WVaPg7QROhSmPifBlcFzZj8QwcMo3/QFPa2+pdCLqzaLWwhB3nb+fsFQ1YphBUflctnVyE2YilGIVCFslj+OJbY8j0eTQ//NDoGrA2wIlkhVvZ1s9cP+4OYW15q+g2mmPHJG8zM+dYYd7oCCaEf7RYYnOgKiWKaAa4KinD9b3ecZ0JHhdxNpogzmUMETA0YXYze9Zc6WSdg5Wyx2X+D8LfnMjSaEme6acNQwpkiyywIe2FdOxf9axc54lm5IvCrX17aTllaa1isIkd/VNhuPJzNTCDfmJCzWiA1rBfEExdUE399SVz5bvKVwZkMIVr6Rs8rdtwPQlo/Haf+lyKY9BvZiHppfQpK2qiXjX1hU4hjNxdEwvDsIwZq2pG/B49rzUXVdnKfwDLgivUsPXL/YgDOaYP+PjXqW/dQgAPzkwFsUSDfTVwOtSA598KovgZ8gnLj3Z3Hkcy4zLQfdJM/CxmXdzfghACTc7FovmbGXWGUYl0CQxRRhJ9x+GDMtXfpND6+LAqegtgRutxUfsn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7930.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(26005)(33656002)(83380400001)(55016002)(66946007)(7696005)(54906003)(110136005)(6506007)(52536014)(66446008)(53546011)(478600001)(316002)(71200400001)(2906002)(86362001)(8936002)(5660300002)(8676002)(66476007)(4326008)(76116006)(186003)(9686003)(64756008)(66556008)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Zko0QU9rZW8wRGJrZFJHelBkMlZHUjl0VXZ0bTZVaWU4Y0tWSEpzbGw3RlVN?=
 =?utf-8?B?MzlXY3gwejFsSmJHWVduVVZiTittZkpGV1hjUC9TZnVtdmhpTis4Z05GajZz?=
 =?utf-8?B?aFM1UlE0Um1nakhhTzBnS0dtUERWaVFjVXhBZmFGeGxjYXNLa25mdDd5MTdG?=
 =?utf-8?B?QmdkQml3WW8yYzJ2d2x5TzRpSjcyeVN1WmNiUUhsUEtsVmdyOXBqMlMxbERW?=
 =?utf-8?B?T3I4TGwwd2doL0trMTJMblR2aEUrQ2dLTmUvZGUzd3FJSEFvdmE5UVJ1dFk2?=
 =?utf-8?B?THljQ3JCT3hDc3FsWW02REJsSzhxL2pmNmlmZG5PRExFQ2FrV2YvUVVHZWVS?=
 =?utf-8?B?a1QyM0RXUUdiYUZ2blREKzd6dWxKeTZRNEswOHkrNS9oOU5wOVlONU9xNHpu?=
 =?utf-8?B?cklqREtyeWZReE9vaTZEcWRtUWFRdzRLUno3NXBwbU81MUFjZ2RHaFYwU2lY?=
 =?utf-8?B?MjQ1dU5pQWtXSlhKdHdwTTVQaFhiSmxFQi93ZmQ0Q25OMC9tOFN3elArZ0hE?=
 =?utf-8?B?dFI1dnZLZnZSVndYWHR1OERwZkYyV3BrRnkxbGN1enpFZFIvelJFRjVlY0VY?=
 =?utf-8?B?c1VDZjloenBqbmkrZTc0andsQmRrVmZJbGpVd3haQ3FTeThmMTdmaGJZUExE?=
 =?utf-8?B?R2g4TURvOEs0eUNZaitrTFNUQnVZTERKU0dlcE1QSGRlSjU3eXlERTNXRHVB?=
 =?utf-8?B?UFAyUTQrVTUxUm1lbEc0L1VMNjZEZUxQM21idHgyc24zZTNNdStRbmZsOE4x?=
 =?utf-8?B?Rm44dFpzUmhMQnh2YkFkQUxLQUlFakN2NWtleHFUZzQvWEpuNmtPTTNIL0Q4?=
 =?utf-8?B?ODFHWFhwdzZNWTU3N29iZ3JIcWhwcjFpeUpTQW5DZTBPV0pKZHVQWU9ISEVu?=
 =?utf-8?B?ajluTzhKMHkvNnI2Z2thNmFYdHRuekMrRmJPcmJ4bC83MG13d3BuK2hwbHlJ?=
 =?utf-8?B?NzlpZmR5ekRMMWswTXdzZ0ViT1pEK1NOR2U5WWJmUTJqZ0RHZEl5cEpjVU0z?=
 =?utf-8?B?RmpCejhSZjVSNkZ3UmNrcHRIbjBkNDRNY1lhTXN6NWM1R21acFRra0pFLzBy?=
 =?utf-8?B?RXpVN3FHYlk1NG5WQVNWdVNiU3JlSXZPTVVMeVlRZWJZSHd6MTRRbE4weERW?=
 =?utf-8?B?TFNmTmxkV0ZZRUpIeEdiTU9wek1pcUEwZXlWZVVkdHJnN0JtQXJ4dkdqQmtE?=
 =?utf-8?B?b2JkaWZCc1pOZnhhenhKZ3lXYzJOTklGU1UxNVo4SWh1VjdUTkVMTllHZkg3?=
 =?utf-8?B?VDVFcGpKSnlyT1FSMjFtanZhUWNaNk1HUHFadDVuMGY5YUFPN3U4dDI2MnJR?=
 =?utf-8?B?YkpBUUVNT3BTMzZwZXNyNGd4Z3BualM3Mys4RnRacW1aRjByZWdCRGlkWmNG?=
 =?utf-8?B?VWZmaUxKQlE5UVUrR0JLR3dRbmhqRmNnQXVyMjZBYStqRkZEYzE0dEpPUTJq?=
 =?utf-8?B?dXFxQmw0N2NKRjhveFh5RnoweFYwWmhkYlFkRVlaUzlSOUZpcXFvSGZzQzE2?=
 =?utf-8?B?TFRYdDlwWDJxR1Uya1oxdVZsc0wxd2JwS0dZc3VLN1drQWhic1lYQzFpZUpJ?=
 =?utf-8?B?WkRCN3VTK2RmVnN2NHNTNjVyR1BaaFFhSFRxMEd6dEhlbWxEV0c3c0FoemVS?=
 =?utf-8?B?alhyS0pnTmVyY0NRM1VxT1BKb3N6d1lkcWZ4TUVBV0ZKN2I4YXZEOFpwbXlF?=
 =?utf-8?B?MTZFeW1uZ1l2QXNBY2JVb3lGOTRNU3ROUWMxdDE2RDJpQzNCbyt3TS9tTmFF?=
 =?utf-8?Q?By0gtu8X1IfRXSf17e54HuaUxND3qdMSyhLjYB4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7930.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 595ab29b-a52f-4f84-92c1-08d8d3d3e88a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2021 06:10:36.4467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IXlUrFmkfybMbsq+VFYmr6z6VMX/PXOfYzAQxRpUjg5L+8XOqH7HnrrUkh7T/3D3JVCUlo+cbIKHAMx7yzgnGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3660
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSaWNoYXJkIFpodSBbbWFpbHRv
Omhvbmd4aW5nLnpodUBueHAuY29tXQ0KPiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgMTgsIDIw
MjEgMTo1NCBQTQ0KPiBUbzogc2hhd25ndW9Aa2VybmVsLm9yZzsgSmFja3kgQmFpIDxwaW5nLmJh
aUBueHAuY29tPg0KPiBDYzogZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IGxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBTdWJqZWN0OiBb
UEFUQ0hdIGNsazogaW14OG1wOiBSZW1vdmUgdGhlIG5vbmUgZXhpc3QgcGNpZSBjbG9ja3MNCj4g
DQo+IEluIHRoZSBpLk1YOE1QIFBDSWUgZGVzaWduLCB0aGUgUENJZSBQSFkgUkVGIGNsb2NrIGNv
bWVzIGZyb20gZXh0ZXJuYWwgT1NDDQo+IG9yIGludGVybmFsIHN5c3RlbSBQTEwuIEl0IGlzIGNv
bmZpZ3VyZWQgaW4gdGhlIElPTVVYX0dQUjE0IHJlZ2lzdGVyIGRpcmVjdGx5LA0KPiBhbmQgY2Fu
J3QgYmUgY29udG9sbGVkIGJ5IENDTSBhdCBhbGwuDQo+IFJlbW92ZSB0aGUgUENJRSBQSFkgY2xv
Y2sgZnJvbSBjbG9jayBkcml2ZXIgdG8gY2xlYW4gdXAgY29kZXMuDQo+IFRoZXJlIGlzIG9ubHkg
b25lIFBDSWUgaW4gaS5NWDhNUCwgcmVtb3ZlIHRoZSBub25lIGV4aXN0IHNlY29uZCBQQ0llIHJl
bGF0ZWQNCj4gY2xvY2tzLg0KPiANCg0KQXMgU2hhd24gc3VnZ2VzdGVkIGJlZm9yZSwgaXQgaXMg
YmV0dGVyIHRvIHJlbW92ZSB0aGUgY29ycmVzcG9uZGluZyBjbG9jayBJRCBpbiBpbmNsdWRlL2R0
LWJpbmRpbmdzL2Nsb2NrL2lteDhtcC1jbG9jay5oDQoNCkJSDQpKYWNreSBCYWkNCg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IFJldmlld2Vk
LWJ5OiBKYXNvbiBMaXUgPGphc29uLmh1aS5saXVAbnhwLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L2Nsay9pbXgvY2xrLWlteDhtcC5jIHwgMTUgLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMTUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14
L2Nsay1pbXg4bXAuYyBiL2RyaXZlcnMvY2xrL2lteC9jbGstaW14OG1wLmMNCj4gaW5kZXggMmY0
ZTFkNjc0ZTFjLi5hZmJlYjZiZjE5MDkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xrL2lteC9j
bGstaW14OG1wLmMNCj4gKysrIGIvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bXAuYw0KPiBAQCAt
MTUyLDEwICsxNTIsNiBAQCBzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IGlteDhtcF9jYW4yX3Nl
bHNbXSA9DQo+IHsib3NjXzI0bSIsICJzeXNfcGxsMl8yMDBtIiwgInN5cw0KPiAgCQkJCQkJInN5
c19wbGwxXzE2MG0iLCAic3lzX3BsbDFfODAwbSIsDQo+ICJzeXNfcGxsM19vdXQiLA0KPiAgCQkJ
CQkJInN5c19wbGwyXzI1MG0iLCAiYXVkaW9fcGxsMl9vdXQiLCB9Ow0KPiANCj4gLXN0YXRpYyBj
b25zdCBjaGFyICogY29uc3QgaW14OG1wX3BjaWVfcGh5X3NlbHNbXSA9IHsib3NjXzI0bSIsDQo+
ICJzeXNfcGxsMl8xMDBtIiwgInN5c19wbGwyXzUwMG0iLA0KPiAtCQkJCQkJICAgICJjbGtfZXh0
MSIsICJjbGtfZXh0MiIsICJjbGtfZXh0MyIsDQo+IC0JCQkJCQkgICAgImNsa19leHQ0IiwgInN5
c19wbGwxXzQwMG0iLCB9Ow0KPiAtDQo+ICBzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IGlteDht
cF9wY2llX2F1eF9zZWxzW10gPSB7Im9zY18yNG0iLA0KPiAic3lzX3BsbDJfMjAwbSIsICJzeXNf
cGxsMl81MG0iLA0KPiAgCQkJCQkJICAgICJzeXNfcGxsM19vdXQiLCAic3lzX3BsbDJfMTAwbSIs
DQo+ICJzeXNfcGxsMV84MG0iLA0KPiAgCQkJCQkJICAgICJzeXNfcGxsMV8xNjBtIiwgInN5c19w
bGwxXzIwMG0iLCB9OyBAQA0KPiAtMzgwLDE0ICszNzYsNiBAQCBzdGF0aWMgY29uc3QgY2hhciAq
IGNvbnN0IGlteDhtcF9tZW1yZXBhaXJfc2Vsc1tdID0NCj4geyJvc2NfMjRtIiwgInN5c19wbGwy
XzEwMG0iLA0KPiAgCQkJCQkJCSJzeXNfcGxsMV84MDBtIiwgInN5c19wbGwyXzEwMDBtIiwNCj4g
InN5c19wbGwzX291dCIsDQo+ICAJCQkJCQkJImNsa19leHQzIiwgImF1ZGlvX3BsbDJfb3V0Iiwg
fTsNCj4gDQo+IC1zdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IGlteDhtcF9wY2llMl9jdHJsX3Nl
bHNbXSA9IHsib3NjXzI0bSIsDQo+ICJzeXNfcGxsMl8yNTBtIiwgInN5c19wbGwyXzIwMG0iLA0K
PiAtCQkJCQkJICAgICAgInN5c19wbGwxXzI2Nm0iLCAic3lzX3BsbDFfODAwbSIsDQo+ICJzeXNf
cGxsMl81MDBtIiwNCj4gLQkJCQkJCSAgICAgICJzeXNfcGxsMl8zMzNtIiwgInN5c19wbGwzX291
dCIsIH07DQo+IC0NCj4gLXN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgaW14OG1wX3BjaWUyX3Bo
eV9zZWxzW10gPSB7Im9zY18yNG0iLA0KPiAic3lzX3BsbDJfMTAwbSIsICJzeXNfcGxsMl81MDBt
IiwNCj4gLQkJCQkJCSAgICAgImNsa19leHQxIiwgImNsa19leHQyIiwgImNsa19leHQzIiwNCj4g
LQkJCQkJCSAgICAgImNsa19leHQ0IiwgInN5c19wbGwxXzQwMG0iLCB9Ow0KPiAtDQo+ICBzdGF0
aWMgY29uc3QgY2hhciAqIGNvbnN0IGlteDhtcF9tZWRpYV9taXBpX3Rlc3RfYnl0ZV9zZWxzW10g
PQ0KPiB7Im9zY18yNG0iLCAic3lzX3BsbDJfMjAwbSIsICJzeXNfcGxsMl81MG0iLA0KPiAgCQkJ
CQkJCQkic3lzX3BsbDNfb3V0IiwgInN5c19wbGwyXzEwMG0iLA0KPiAgCQkJCQkJCQkic3lzX3Bs
bDFfODBtIiwgInN5c19wbGwxXzE2MG0iLCBAQA0KPiAtNTg1LDcgKzU3Myw2IEBAIHN0YXRpYyBp
bnQgaW14OG1wX2Nsb2Nrc19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0K
PiAgCWh3c1tJTVg4TVBfQ0xLX1ZQVV9HMl0gPSBpbXg4bV9jbGtfaHdfY29tcG9zaXRlKCJ2cHVf
ZzIiLA0KPiBpbXg4bXBfdnB1X2cyX3NlbHMsIGNjbV9iYXNlICsgMHhhMTgwKTsNCj4gIAlod3Nb
SU1YOE1QX0NMS19DQU4xXSA9IGlteDhtX2Nsa19od19jb21wb3NpdGUoImNhbjEiLA0KPiBpbXg4
bXBfY2FuMV9zZWxzLCBjY21fYmFzZSArIDB4YTIwMCk7DQo+ICAJaHdzW0lNWDhNUF9DTEtfQ0FO
Ml0gPSBpbXg4bV9jbGtfaHdfY29tcG9zaXRlKCJjYW4yIiwNCj4gaW14OG1wX2NhbjJfc2Vscywg
Y2NtX2Jhc2UgKyAweGEyODApOw0KPiAtCWh3c1tJTVg4TVBfQ0xLX1BDSUVfUEhZXSA9IGlteDht
X2Nsa19od19jb21wb3NpdGUoInBjaWVfcGh5IiwNCj4gaW14OG1wX3BjaWVfcGh5X3NlbHMsIGNj
bV9iYXNlICsgMHhhMzgwKTsNCj4gIAlod3NbSU1YOE1QX0NMS19QQ0lFX0FVWF0gPSBpbXg4bV9j
bGtfaHdfY29tcG9zaXRlKCJwY2llX2F1eCIsDQo+IGlteDhtcF9wY2llX2F1eF9zZWxzLCBjY21f
YmFzZSArIDB4YTQwMCk7DQo+ICAJaHdzW0lNWDhNUF9DTEtfSTJDNV0gPSBpbXg4bV9jbGtfaHdf
Y29tcG9zaXRlKCJpMmM1IiwNCj4gaW14OG1wX2kyYzVfc2VscywgY2NtX2Jhc2UgKyAweGE0ODAp
Ow0KPiAgCWh3c1tJTVg4TVBfQ0xLX0kyQzZdID0gaW14OG1fY2xrX2h3X2NvbXBvc2l0ZSgiaTJj
NiIsDQo+IGlteDhtcF9pMmM2X3NlbHMsIGNjbV9iYXNlICsgMHhhNTAwKTsgQEAgLTY0Myw4ICs2
MzAsNiBAQCBzdGF0aWMgaW50DQo+IGlteDhtcF9jbG9ja3NfcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikNCj4gIAlod3NbSU1YOE1QX0NMS19NRURJQV9DQU0yX1BJWF0gPQ0KPiBp
bXg4bV9jbGtfaHdfY29tcG9zaXRlKCJtZWRpYV9jYW0yX3BpeCIsDQo+IGlteDhtcF9tZWRpYV9j
YW0yX3BpeF9zZWxzLCBjY21fYmFzZSArIDB4YmU4MCk7DQo+ICAJaHdzW0lNWDhNUF9DTEtfTUVE
SUFfTERCXSA9DQo+IGlteDhtX2Nsa19od19jb21wb3NpdGUoIm1lZGlhX2xkYiIsIGlteDhtcF9t
ZWRpYV9sZGJfc2VscywgY2NtX2Jhc2UNCj4gKyAweGJmMDApOw0KPiAgCWh3c1tJTVg4TVBfQ0xL
X01FTVJFUEFJUl0gPQ0KPiBpbXg4bV9jbGtfaHdfY29tcG9zaXRlX2NyaXRpY2FsKCJtZW1fcmVw
YWlyIiwgaW14OG1wX21lbXJlcGFpcl9zZWxzLA0KPiBjY21fYmFzZSArIDB4YmY4MCk7DQo+IC0J
aHdzW0lNWDhNUF9DTEtfUENJRTJfQ1RSTF0gPQ0KPiBpbXg4bV9jbGtfaHdfY29tcG9zaXRlKCJw
Y2llMl9jdHJsIiwgaW14OG1wX3BjaWUyX2N0cmxfc2VscywgY2NtX2Jhc2UgKw0KPiAweGMwMDAp
Ow0KPiAtCWh3c1tJTVg4TVBfQ0xLX1BDSUUyX1BIWV0gPQ0KPiBpbXg4bV9jbGtfaHdfY29tcG9z
aXRlKCJwY2llMl9waHkiLCBpbXg4bXBfcGNpZTJfcGh5X3NlbHMsIGNjbV9iYXNlDQo+ICsgMHhj
MDgwKTsNCj4gIAlod3NbSU1YOE1QX0NMS19NRURJQV9NSVBJX1RFU1RfQllURV0gPQ0KPiBpbXg4
bV9jbGtfaHdfY29tcG9zaXRlKCJtZWRpYV9taXBpX3Rlc3RfYnl0ZSIsDQo+IGlteDhtcF9tZWRp
YV9taXBpX3Rlc3RfYnl0ZV9zZWxzLCBjY21fYmFzZSArIDB4YzEwMCk7DQo+ICAJaHdzW0lNWDhN
UF9DTEtfRUNTUEkzXSA9IGlteDhtX2Nsa19od19jb21wb3NpdGUoImVjc3BpMyIsDQo+IGlteDht
cF9lY3NwaTNfc2VscywgY2NtX2Jhc2UgKyAweGMxODApOw0KPiAgCWh3c1tJTVg4TVBfQ0xLX1BE
TV0gPSBpbXg4bV9jbGtfaHdfY29tcG9zaXRlKCJwZG0iLA0KPiBpbXg4bXBfcGRtX3NlbHMsIGNj
bV9iYXNlICsgMHhjMjAwKTsNCj4gLS0NCj4gMi4xNy4xDQoNCg==
