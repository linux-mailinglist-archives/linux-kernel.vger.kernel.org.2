Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D363DEAF4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbhHCKbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:31:23 -0400
Received: from mail-eopbgr10085.outbound.protection.outlook.com ([40.107.1.85]:56037
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235198AbhHCKbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:31:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SF96PE4gr0uoExjNcSy7z6On91ltnMsxp7iyxADSd92mLMOTyi562etaldBLLYcymA55vkCC4eu94d8u1k0gLMW3KOxN910k3i8sy5Oa66Kkysz4Y2TuasmpYmOKfop9pZe8mDJQDiJgy6Q3gNoYasQcqezyEAoUuEu4w8PDAlLzv+CFLutixkOsuhIcAQ+kzURPl2MGmgxTzrYH0myhE5V+yVd5OGT+vX7X8wjTvlOG3M1k5219a8uTNTBkUx2aZN3v57qB96IHFZVblcPVuaoN5g9fDsG3N+t3Pja1L4/ZYBZjkNW3GMvHTM8MxVHY47c7yLyti8UGiMBXQZsB0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NC8FcralNYtecuCTW627+jlfN+sXQh9pGqkGEkGsReE=;
 b=Xsn/CGvOcdOapik/n2avU0MjXMt26Vdap04NWZsyEdLk2aF3r3bK7v31WyIfSZ4OQu9gAlx9c2f11XM15nFyCeqUYh/jQ7PqqKZLU1r8ICw1Rmevyz0fFI9JoNEGZQ2PtA7zIjr40UvXYXiacJ8z92qyIilsXB3rqbgDYbBVkeXwKXlgwXuM8xlkYn06Eyvbm9iFZDeMkn3Qz52eMXoL4osjG/jYqtfDPYgSQLphej2rUwI2nXQxT3b0Yg1/D54FJRzC03S0FYVpqriWYaK4/F42o8N7klRWCMABdWGVKNqAYJpuMXCnDpCg3RPLgehLRLhAiQsdyMTKalh0aQXfYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NC8FcralNYtecuCTW627+jlfN+sXQh9pGqkGEkGsReE=;
 b=cWXYM+rI5daOZVfREF+QPlZrc/zkLnqXMfLPUYbBiQfj8VDCfDDjgZr5GjB4IgnUb83ahdKEt7J9H+3ltBUeu0YMdh0mh9dN3JyrfOEr1xUuUiP8Gxo/jSKkH17e5ULSqUjfpfkGkhbjYKieppEJ8T/YspUnAfjUYChgQ8/uc2I=
Received: from VI1PR0401MB2495.eurprd04.prod.outlook.com
 (2603:10a6:800:52::15) by VI1PR04MB6800.eurprd04.prod.outlook.com
 (2603:10a6:803:133::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Tue, 3 Aug
 2021 10:31:08 +0000
Received: from VI1PR0401MB2495.eurprd04.prod.outlook.com
 ([fe80::91ec:5d59:ce42:dd5]) by VI1PR0401MB2495.eurprd04.prod.outlook.com
 ([fe80::91ec:5d59:ce42:dd5%10]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 10:31:08 +0000
From:   Mirela Rabulea <mirela.rabulea@nxp.com>
To:     "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] [PATCH 15/15] MAINTAINERS: update nxp,imx8-jpeg.yaml
 reference
Thread-Topic: [EXT] [PATCH 15/15] MAINTAINERS: update nxp,imx8-jpeg.yaml
 reference
Thread-Index: AQHXfuBjr5HS9ZEAQk61KCXEDHTu1athp5QA
Date:   Tue, 3 Aug 2021 10:31:07 +0000
Message-ID: <1eb1b72e3a85d2904b5aebb6a2c128a9314cd4b2.camel@nxp.com>
References: <cover.1626947923.git.mchehab+huawei@kernel.org>
         <25e33e45949ca758c1ab7237989b4f50d67225bb.1626947923.git.mchehab+huawei@kernel.org>
In-Reply-To: <25e33e45949ca758c1ab7237989b4f50d67225bb.1626947923.git.mchehab+huawei@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.4-0ubuntu1 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b940036-8817-4538-219b-08d95669ce40
x-ms-traffictypediagnostic: VI1PR04MB6800:
x-microsoft-antispam-prvs: <VI1PR04MB68004784AB9B5EC0677DFA168FF09@VI1PR04MB6800.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EAsP+l6sacIM3LPv1o8kdYv+6dY315RYem3u8yUTCFcK4KI/ZD/F8Bpw2reASAK/g16BGOm+iH64+LaXVgrHkvt+v48iT6WFDB7zB63w3O2iUEIoyEq3+ZZw7Fnk9HOcmZu7wVqSI10cgZiBelFrOVNWyWOQB57yZVri1Wtn6W892s430rmnie567pltg9HJDHNuFB2eY7qGntuxNclJ88yPPb2l5yUe1KSduJ1+TVdBlud47F62xZFFyYqWVqLy+bQQ1l2rIHtrc6IVCpBKAUNOM5FbAKceSn6LldFpqryaaJc1mjcz4b92WV8S3Gm1AfeEDE11Tk7i2/wq8Fz0QSMVSUi2qJ0q4q1FfLRZVmPmnueYCO9Yl0wsqj7J/ls7zUErZAZ6PSnsxAFQ1AcHBqEcmWkOns4LJGyUBZ1d61lfHkIIX0cYfxyfkKnZS8hkcavdsVYmXYtBnLUcBRCN+Y2/K0PaYbywiKU7fIW/Wk33bp7V4wvxUyXH1NSCf8th67U8ZeVgMF75lWmUV94/rzTuDNBrkk8kQzHCXjtDK0Nbq9MF599TR+gGzPD1eFlvOBmEIPwOk4RXCVF8zecKlcBFRhF6hccSK5o8BiLdQ+kyLIAPXUppDUKS12AZAGlxWC/WUcFIgYl3iZJU7Er7FNdLETrvgYlTYW+D45Tn4Lpiv0ID4ogruiUINvMojBDs2AIfAaY8Qnm70oKq+0IGiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2495.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(366004)(39850400004)(346002)(2616005)(54906003)(26005)(6506007)(66946007)(83380400001)(316002)(2906002)(5660300002)(478600001)(15650500001)(186003)(110136005)(76116006)(71200400001)(38100700002)(8936002)(38070700005)(36756003)(6486002)(122000001)(44832011)(4326008)(64756008)(66556008)(66446008)(86362001)(66476007)(6512007)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXJVZzZENHZraG1vVTZtUlUya0tQOGs3UkdRNkNBWXloRXhJZXFtQXRnKzhq?=
 =?utf-8?B?OGxMK3RkZUJqRmhzU3ZiK0VUTlpjdzFKSnpXNVdPamhjamRIUjdsOGdUS2JB?=
 =?utf-8?B?aCtGWDBycHZ0R2E4MzZzSmJ4SGZ1a0I5ajNjeUlENnZ4RjFlTmdIZ01Cazln?=
 =?utf-8?B?MEtyQ1lhT3l5SDU4dkJjdHVJc1UwZ0J1STVZclo4S3dmT2gvMGp0NUY0Vkdp?=
 =?utf-8?B?dVg2ZzJrY0FTNmd3OFpJR2JJNGZheEdDbzRSMzc5WG5ETVJQTGpOQ2dLei8r?=
 =?utf-8?B?V2lRdkdGR0lYcXdEVC9TaVVhT3A0ZFNhOGZHLy9YUW5xZ3pNVnhsOWd3ZDkz?=
 =?utf-8?B?WitYdWQreUg0K3IrTmJZTzJlZ0hlR1UzY05Rdzl0UTV5ZHRVVXptWmN3cWlS?=
 =?utf-8?B?a3hGK3hGSk93NTVvZzhZNG9mQmdrU3U4VkI2b1JQVENrZWtNUWhJV1FQa0lP?=
 =?utf-8?B?OXBZdTlwTk9haTJEdGdPQi9WUk5oNWNmdFJxZStyMHRNYTdiMm9ITU1DVkI5?=
 =?utf-8?B?OFAxQmNmdlE0eHdkZHZLUXV0VU5EY3ZWNlBTZVRYanpsQVUzUmFveGFLdlMy?=
 =?utf-8?B?KzlGT09rK3N4UTg2MmxCYU5OVy81RmRZaWhrd1MxZjVmbVcwb2d6VmhpOVFI?=
 =?utf-8?B?T3g1Zy92dEdIRmh5TjlNQ3RhUm9IY3EzQmMwaGEyQkJSVzY1dkpIWjNuY1Bm?=
 =?utf-8?B?d0diZUpGY2JHZnVsL0lJQ2ZrTTlENkxrUTlubFVSZGg4SmVFemlIekVseHlx?=
 =?utf-8?B?OFJSRys4UU4zMUpkRWpWald1M1UveUFvTGZSM3hxTmNjWTJsRUZBYzcxWnNR?=
 =?utf-8?B?YnBHSjFiWmw1VGVtOUxEenlXQXRnSENEWVdTbmZ3Q2hQbkoyano5VGJxWjha?=
 =?utf-8?B?RDZYMXdaT285SmVZTjRVTkxTNnBzUHpaUUFETnlabVAwMlRWRHg5ckQyWXI2?=
 =?utf-8?B?ZWNsOUNHaHNJMmE0U0VrTXg5aWxNVG55MnhKNndycVQ4RkhQRlpkVEpLWVlU?=
 =?utf-8?B?YW0rOEVWQk8xU05BQ2xNdG1SUTF0Ukd6MnIvOHYxTDR2Q2Rwa0tRaURtNjBl?=
 =?utf-8?B?MjZ5VWZQRmd1V21RaVlDcXNPK2dFaVFramJhQ1B4d1BBcjhTUlpuRFJiZGI1?=
 =?utf-8?B?aEhJTUJLaDhqMEhkc2VrUUVraHh0bVdTYzRiYjNtY0pUQ3c0YXpFNTN5NmpK?=
 =?utf-8?B?SUVYa0c5REgwMVV2bDdjR2FkN3VPMkhoY3lqQWhmbnU1RDhKeVpGaGhhOWFp?=
 =?utf-8?B?cHg2enVvODN0aWN2S2ROY0NzV05MOXdxQ1dqb1RuVFVmT1k4VS93STZXbGlh?=
 =?utf-8?B?UzZjRmhwV0N1ZTJZZnU4dHZNUDRVemVwZmhKOXNudlByMXhleFlwUFgvTmxK?=
 =?utf-8?B?MUtDTUx3VG9lcDduRVE4WjdYanA1SjVVdi9Ta3ZYOUxlaUpkbUxWQWtabzda?=
 =?utf-8?B?emVuTHYyVE8zejNrT0NlRzIyaDhDNmlIYlByK0VZMzJ4bHQzQ20zZitldXRm?=
 =?utf-8?B?czY3Q2NDM0pQQkVvV1NZaDdraklJMEVicFk3UElDL1paYUMyeEI1UzJkWlRS?=
 =?utf-8?B?QnJqS2RaRm1pSmpBYWQ1YWtFVlRWUWErYVBHSHJQYzN0K1RjWXl0UEZZcW5t?=
 =?utf-8?B?R09EQW0wZkRJdzFuTEFxeUVwdkxxWEVGK1gvaEp1alAxN3E4c083REFQSkFW?=
 =?utf-8?B?aUl5VjdVZFI1aUR5a0Y0ZjZXaDdETEpTb3NxcHRmb2toMGs1d1UyTDQ0WXMx?=
 =?utf-8?Q?uaiVc1Wb5020PgcCkDNqodmZAPESvhgLuDaVM/Y?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BAA8AEBE21008B478E0EB0BA19B12097@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2495.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b940036-8817-4538-219b-08d95669ce40
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 10:31:08.0170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S1uDkvD3wzPSEtkixyu/WOhPa3eZBL1Pg3HoCGy+Sh1EP7taKwP3jvJo1j4TgHI8FVg2/1Y6LBDV64/lPw1fag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6800
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF1cm8sDQoNCk9uIFRodSwgMjAyMS0wNy0yMiBhdCAxMjowMCArMDIwMCwgTWF1cm8gQ2Fy
dmFsaG8gQ2hlaGFiIHdyb3RlOg0KPiBDYXV0aW9uOiBFWFQgRW1haWwNCj4gDQo+IFRoZSBmaWxl
IG5hbWU6IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9pbXg4LWpwZWcu
eWFtbA0KPiBzaG91bGQgYmUsIGluc3RlYWQ6IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9tZWRpYS9ueHAsaW14OC0NCj4ganBlZy55YW1sLg0KPiANCj4gVXBkYXRlIGl0cyBjcm9z
cy1yZWZlcmVuY2UgYWNjb3JkaW5nbHkuDQo+IA0KPiBGaXhlczogYmUxNTdkYjBhM2Q4ICgibWVk
aWE6IEFkZCBtYWludGFpbmVyIGZvciBJTVgganBlZyB2NGwyDQo+IGRyaXZlciIpDQo+IEZpeGVz
OiBiMTZlZDFlNjYwMDggKCJtZWRpYTogZHQtYmluZGluZ3M6IEFkZCBiaW5kaW5ncyBmb3INCj4g
aS5NWDhRWFAvUU0gSlBFRyBkcml2ZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBNYXVybyBDYXJ2YWxo
byBDaGVoYWIgPG1jaGVoYWIraHVhd2VpQGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiAgTUFJTlRBSU5F
UlMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQo+IGluZGV4
IGVmY2QyZDQ2MWZjMC4uNjUzODM4OWM3ZjViIDEwMDY0NA0KPiAtLS0gYS9NQUlOVEFJTkVSUw0K
PiArKysgYi9NQUlOVEFJTkVSUw0KPiBAQCAtMTM0MjksNyArMTM0MjksNyBAQCBNOiAgICAgIE1p
cmVsYSBSYWJ1bGVhIDwNCj4gbWlyZWxhLnJhYnVsZWFAbnhwLmNvbT4NCj4gIFI6ICAgICBOWFAg
TGludXggVGVhbSA8bGludXgtaW14QG54cC5jb20+DQo+ICBMOiAgICAgbGludXgtbWVkaWFAdmdl
ci5rZXJuZWwub3JnDQo+ICBTOiAgICAgTWFpbnRhaW5lZA0KPiAtRjogICAgIERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9pbXg4LWpwZWcueWFtbA0KPiArRjogICAgIERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9ueHAsaW14OC1qcGVnLnlhbWwN
Cg0KVGhhbmtzIGEgbG90IGZvciBmaXhpbmcgdGhpcywgaW5kZWVkLCB0aGlzIGZpbGUgY2hhbmdl
ZCBuYW1lIGR1cmluZw0KcmV2aWV3IHByb2Nlc3MsIGFuZCBJIGZvcmdvdCB0byB1cGRhdGUgdGhl
IE1BSU5UQUlORVJTIGZpbGUuDQoNClBsZWFzZSBub3RlIHRoYXQgdGhlcmUgaXMgYW5vdGhlciBw
YXRjaCBzZXQgd2l0aCBtdWx0aXBsZSBmaXhlcyBpbg0KTUFJTlRBSU5FUlMgZmlsZSBmcm9tIEx1
a2FzIEJ1bHdhaG4gKGp1c3QgYWRkZWQgaGltIHRvIHRoaXMgbWFpbA0KdGhyZWFkKSwgd2hpY2gg
YWxzbyBmaXhlcyB0aGUgcmVmZXJlbmNlIGZvciBpbXg4LWpwZWcsIGFtb25nIG90aGVyDQpmaXhl
cy4NCkkgZG9uJ3Qga25vdyB3aGljaCBwYXRjaCBpcyBiZXN0L2Vhc2llc3QgdG8gYXBwbHkuIEFw
cG9sb2dpZXMgZm9yIG15DQpsYXRlIHJlcGx5LCBhcyBJIHdhcyBvbiBQVE8uDQoNCkZvciB0aGUg
Y29udGVudHMgb2YgdGhpcyBwYXRjaDoNClJldmlld2VkLWJ5OiBNaXJlbGEgUmFidWxlYSA8bWly
ZWxhLnJhYnVsZWFAbnhwLmNvbT4NCg0KUmVnYXJkcywNCk1pcmVsYQ0KDQo+ICBGOiAgICAgZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9pbXgtanBlZw0KPiANCj4gIE5aWFQtS1JBS0VOMiBIQVJEV0FS
RSBNT05JVE9SSU5HIERSSVZFUg0KPiAtLQ0KPiAyLjMxLjENCj4gDQo=
