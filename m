Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87471399C57
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 10:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhFCITy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 04:19:54 -0400
Received: from mail-db8eur05on2050.outbound.protection.outlook.com ([40.107.20.50]:55264
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229576AbhFCITx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 04:19:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXLnkXPrgqlb8jSYqJ6IDdu3tTPxe5DadwH91pbaUiyvIkB3iLq7sEv67NuwniyPLZzYoS1eNe6ybqewgjtG9ODxAii70Z4tSEdzONQ8TdjVHar54Y4I4r87HpDVhGPrguWwRAm0uSiL2I9M76YhMXsEXYYsXSg1Y15JY4dQYnJmg7p2pwNGFhBDctPhN8zllc5ycrdUHE1GL8BgCtABLURxy6B/wuQjbWG5pbDD2VDVRTENFwsdSijtD9Dhd+c9cVatoytT/QZ/WlQU0Ycmf2r6OigQaisbb4TR7Dh8c+iWYnO5j7bUQiGX37Z/b5w2qOUgKRLrNrfFSWYxNmuNug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVI+hd67LYDCSfcd2VDFQ57quKzHWMEcsgrtjE3NClI=;
 b=ZJ97MISazWLWg6hd7Qv037J28BrpjpQ5rMa+2FetU38j4sQW8Hn7SZUZgMET8g6tARUkYeg7uuCOVm0Kj0ZFnO1vPVdyETHCdHbocdRWd9RFdsDbMShZRt7Ql8zfwWlXhR6BVH5N+4iVNcQBohLgDZWkrIueOgC3HIFuZUlprs/NgGNd9no2id3OfOb3JQwjqekX7vHPxeeqbKmcAAvvJS/ImZuBLcURbwdcuZTzuXSILOknc/iH1SXlYVt/D4OKNtjtvEfwOcCqtC6MdMoPvRWkjxzhDh351KH+YnsL7UaqGrgdgN1cC74tJ5ouipBWxbhIRThqi5X8/ZgoScpocQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVI+hd67LYDCSfcd2VDFQ57quKzHWMEcsgrtjE3NClI=;
 b=DRsqydZnF1D/9bVe70kLHvcQpuMrkaXrIZ5fdq3mW/ffQMzUs2zC/LB3YW9m4inTLRdsBEDILJBn76YbpFVWe/hg+8VyZ3MS7JMDnddAv+T0ZdAqVBHinoIIsXtH99Y5PthIewMi2p4kPLzQiOZrpmVpM/ShCUefpvCrRcPaADc=
Received: from AM5PR04MB3137.eurprd04.prod.outlook.com (2603:10a6:206:c::18)
 by AM6PR04MB5367.eurprd04.prod.outlook.com (2603:10a6:20b:2a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Thu, 3 Jun
 2021 08:18:07 +0000
Received: from AM5PR04MB3137.eurprd04.prod.outlook.com
 ([fe80::31a9:4de7:806f:93eb]) by AM5PR04MB3137.eurprd04.prod.outlook.com
 ([fe80::31a9:4de7:806f:93eb%5]) with mapi id 15.20.4195.023; Thu, 3 Jun 2021
 08:18:07 +0000
From:   Mirela Rabulea <mirela.rabulea@nxp.com>
To:     "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
Subject: Re: [EXT] [PATCH 12/12] MAINTAINERS: update nxp,imx8-jpeg.yaml
 reference
Thread-Topic: [EXT] [PATCH 12/12] MAINTAINERS: update nxp,imx8-jpeg.yaml
 reference
Thread-Index: AQHXV8YGQr+txLqE7U6Tz+JLTnqoGqsB8mkA
Date:   Thu, 3 Jun 2021 08:18:07 +0000
Message-ID: <2b30a7723ddf6ef53d4bbbbbe846b3efac5eda1f.camel@nxp.com>
References: <cover.1622648507.git.mchehab+huawei@kernel.org>
         <7b6df64c2c5af0990b9644acad18d4a4b700cce3.1622648507.git.mchehab+huawei@kernel.org>
In-Reply-To: <7b6df64c2c5af0990b9644acad18d4a4b700cce3.1622648507.git.mchehab+huawei@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [86.124.171.30]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3270f8cc-f46f-4b34-6d53-08d926681e53
x-ms-traffictypediagnostic: AM6PR04MB5367:
x-microsoft-antispam-prvs: <AM6PR04MB5367C0D805BF27603CB256578F3C9@AM6PR04MB5367.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s6DlMv5WVotgIn2aXLHwraBxNJxzAWKibWUNOuHtMrBFTNlAfjSQ1bBEma8sar2CYNGnlWAfvA5gIqUdczwrpm+pDy9yUB2wSiI7D6nBMRw7v3zI5272sAeKQNW6x276HKR9m4CCxML0b7W0Q1soRdliSi36YGmi4SlUVBIzZ2MUMByRZ95iAMNbpFfrQ0t2XwM80q1QB5rIauH7DNxA8qTmhYJxIegxPBDJJAUzvl5mGCfmepzQCVh8lBd8M2UvaZTDzXqzGrku45E3t89Zzu9oRZZIwegFG36VfSEO2cDYY5Taw90AhI3olWWI89iPDelO5K9IBPPwKqDhS9RDRaXkOw/1hIJgDyfaLwUq7fOqd43utGjIf+251SjZap/f16mP+USVyDPUjJ7lk7bLSMKBubMB9CAHOTAfOHpDOgrbKfVov98vo4VadUUoiU7HlOosrQgx09eXVrIG9VZXYC+5VtQ/05hPwmFl77WMFQrSUepCnv+EcH834Cz5pJMknEId5kqnygwXUO35Q3uRedzPLArDT8+ATinhguU5+HorbnfJildpUpKeJwXTcyOwL/sIhPLHziAgvy/tF2Eql8SdNy/yo/P6zz9MDZG/3Vs+IpAdTf0/QFQC2Io489fGZe5BXW0bo936bhOYv9ee/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3137.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(110136005)(26005)(54906003)(8936002)(86362001)(15650500001)(76116006)(91956017)(5660300002)(64756008)(66446008)(66476007)(66556008)(44832011)(6506007)(36756003)(478600001)(6486002)(38100700002)(4326008)(83380400001)(2906002)(122000001)(66946007)(316002)(6512007)(8676002)(186003)(71200400001)(2616005)(99106002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Z28rMkNEMVFyUzVrczJlaFFuTmdjYis1TWdKbGFsMGNFUytRemF1NEFCRzJt?=
 =?utf-8?B?VmJCaTUxbVVtMmRSbWdsRExMUjVIQ1U0MENlMnFIQk9PUEk1YnowcWFIbENV?=
 =?utf-8?B?RmNaODZtNFdXRnk1TkwzZHhlZDZvaU1NTlNyOEhHbC9ES0FJZ3VNYXdXWDl5?=
 =?utf-8?B?bnpqeDkyM1Bta1RCQnhKandhRzRuZWE3THR5NE1LQnJRRE1uYUo2MEFOYUJZ?=
 =?utf-8?B?MFRzWFpqdVlCWGFXNnZHdFo2NnRJNGZuTUxnRVFwTUpmMzVyL0RoRHIxN0JB?=
 =?utf-8?B?QU1tOWVoSW5leEVEdFgwL1ZvU05KeVhuaXozQStQUFVzYkFiRzAyeTRGVzJW?=
 =?utf-8?B?VDNudGZaRlNvWGQ5QzVrMGJMcWxkZDh3V0VIY3lNUlkrVXU5YjlxaVh3MFBj?=
 =?utf-8?B?Zk5Sc2hRaEx2dmVQVjlydUJKSmVXajBNekhTMzlZa09BTTFpWnk2OTl2WjBH?=
 =?utf-8?B?VVBwTDdKYXFWdXJGOTkzQmdGbkEvSWRHK3Y3Y0p4eFJYQWQ3R3lQMFZjZEF4?=
 =?utf-8?B?RUNiMVh1bkxGM0hPb1ZKRWYxS3VIazlhbmFrT3BlOFV3Nlh3Mit3M0phK1ZT?=
 =?utf-8?B?N042clVDRFo4dFdwSG1lcURGYzV0eCtEeFRxM2VFMzQzQlY3ZWpoVmNjZlFu?=
 =?utf-8?B?eVl1TkE5RjVoZTh0Rkw5UFlVOWZKMkRwZW9LQ3RLMnFaV1NvcTNBdlN4RzdY?=
 =?utf-8?B?QU1tbThZYTNQNjg0QW9Pcmx5R1AvWVRHN3RUcVdqbW56Z0dxNVRLd3o4MEYy?=
 =?utf-8?B?NkpsREMraldTZWx0YzNZbXpSOVRMWVg4Y3V0Z1d2QWVnRG1mMENSSXRhWTRn?=
 =?utf-8?B?YjhzZldDVXNhYkVUVU15VEYzK3AzSXNCd0k5czkvT0VadE9LODdEMmpydGlK?=
 =?utf-8?B?VEREUHBOZy9mYS9XWDZzMWlMNGZOaXVTcllWcjRzQ2RUVkl5WWpmemJOMXpx?=
 =?utf-8?B?a0hQZ2o5NUF0OTQyNDJ0dExQU2Noc1cvaEhyNGE1c2lEbU9sb2tEem85SDlr?=
 =?utf-8?B?LzdUOEt0b0x4TjRRM05Vbm51Y3d4R29GZkM5akNoV0M1bHViQi90bVNmSGhH?=
 =?utf-8?B?NzlhbDZ1TTlQLy9DVzkrbnhZQmEzZUx3cUF4TVJWQjB4dXZTUjgyYjVlUG9z?=
 =?utf-8?B?RVI4SWs5dVAya1ZtZWZTdUQyeHFqVlIxZmRBZExOSUtaNFFPL2EvZzE2Njgx?=
 =?utf-8?B?MTZydEpuVWtaYS9URE1mNVI3cTdDbUpVZ2pJZm1welZxZXZrdzY5ZGhDcWFJ?=
 =?utf-8?B?RWpFYzJtL2xaK0FQRVpxbFp4VFhnNlplOWJkZEgxdXRVSGRGdjU5K1d5R2lv?=
 =?utf-8?B?U2V2Z09xSWRCc1N4Y2htWmhJbUpFVU1MOGlFUW9KRU4zYXk3NWI5NjFhZDNK?=
 =?utf-8?B?ZkJCV1hKb0dhZGdoNlgrOGhidTJyTXpLalVyTEtIQS9tRmQ3RHJyV2FydDNB?=
 =?utf-8?B?NzQ0NTU4UjNDd2RGYzRhZCs5YUFodUZpZG1VWk55Z1JCQWd6bjdxMlBmT2gr?=
 =?utf-8?B?OC9RL091R3gvQlUwcktPcVQrZ2xyQWFoVGFMbTY2c3luZlA3M2tTZmdieml3?=
 =?utf-8?B?bmllWmpNZ3pzcWRZTGluclJhQjRrMmdrRW1aZkpGeXNyenVvWnMrS2R4cm52?=
 =?utf-8?B?bi9KQnBGOEFad0xPWDlLdEdLVkRCYzBGenVDY3E0ckV3bTdZbjAwbkJLS3hT?=
 =?utf-8?B?OHpiNktIQzdGWnFPSzJWOTZtamkrMnlsNDFVMUpIZkxuM3I1SDZUcnFZZUpK?=
 =?utf-8?Q?4d3gwQuYEkNnwu/+EffvxdQ9w5zgRTGjz0xpIzx?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C364DE4B8EC56944AC7481A846D41853@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3137.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3270f8cc-f46f-4b34-6d53-08d926681e53
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 08:18:07.5524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tcrEDFKr0NgPiUnwuqw35OTyKb0xRtwws/fhx8NPydNS4ODiwG4/FCWkdCwdZsTjnbSTL73k2xIaiDfA08spfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5367
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTA2LTAyIGF0IDE3OjQzICswMjAwLCBNYXVybyBDYXJ2YWxobyBDaGVoYWIg
d3JvdGU6DQo+IA0KPiBUaGUgZmlsZSBuYW1lOiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbWVkaWEvaW14OC1qcGVnLnlhbWwNCj4gc2hvdWxkIGJlLCBpbnN0ZWFkOiBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEvbnhwLGlteDgtDQo+IGpwZWcueWFtbC4N
Cj4gDQo+IFVwZGF0ZSBpdHMgY3Jvc3MtcmVmZXJlbmNlIGFjY29yZGluZ2x5Lg0KPiANCj4gRml4
ZXM6IGJlMTU3ZGIwYTNkOCAoIm1lZGlhOiBBZGQgbWFpbnRhaW5lciBmb3IgSU1YIGpwZWcgdjRs
Mg0KPiBkcml2ZXIiKQ0KPiBGaXhlczogYjE2ZWQxZTY2MDA4ICgibWVkaWE6IGR0LWJpbmRpbmdz
OiBBZGQgYmluZGluZ3MgZm9yDQo+IGkuTVg4UVhQL1FNIEpQRUcgZHJpdmVyIikNCj4gU2lnbmVk
LW9mZi1ieTogTWF1cm8gQ2FydmFsaG8gQ2hlaGFiIDxtY2hlaGFiK2h1YXdlaUBrZXJuZWwub3Jn
Pg0KPiAtLS0NCj4gIE1BSU5UQUlORVJTIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMg
Yi9NQUlOVEFJTkVSUw0KPiBpbmRleCBhNzM3YmEyNmJkY2QuLjM3YmFhYmIxZTdhNSAxMDA2NDQN
Cj4gLS0tIGEvTUFJTlRBSU5FUlMNCj4gKysrIGIvTUFJTlRBSU5FUlMNCj4gQEAgLTEzMzAzLDcg
KzEzMzAzLDcgQEAgTTogICAgICBNaXJlbGEgUmFidWxlYSA8DQo+IG1pcmVsYS5yYWJ1bGVhQG54
cC5jb20+DQo+ICBSOiAgICAgTlhQIExpbnV4IFRlYW0gPGxpbnV4LWlteEBueHAuY29tPg0KPiAg
TDogICAgIGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZw0KPiAgUzogICAgIE1haW50YWluZWQN
Cj4gLUY6ICAgICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEvaW14OC1q
cGVnLnlhbWwNCj4gK0Y6ICAgICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVk
aWEvbnhwLGlteDgtanBlZy55YW1sDQo+ICBGOiAgICAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9p
bXgtanBlZw0KPiANCj4gIE5aWFQtS1JBS0VOMiBIQVJEV0FSRSBNT05JVE9SSU5HIERSSVZFUg0K
PiAtLQ0KPiAyLjMxLjENCj4gDQoNCkhpLA0KdGhhbmtzIGZvciBjYXRjaGluZyB0aGlzIHVwLg0K
DQpSZXZpZXdlZC1ieTogTWlyZWxhIFJhYnVsZWEgPG1pcmVsYS5yYWJ1bGVhQG54cC5jb20+DQoN
ClJlZ2FyZHMsDQpNaXJlbGENCg==
