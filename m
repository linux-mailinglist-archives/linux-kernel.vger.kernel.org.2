Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAB6387004
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 04:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346257AbhERCt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 22:49:28 -0400
Received: from mail-eopbgr60072.outbound.protection.outlook.com ([40.107.6.72]:35394
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240178AbhERCtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 22:49:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbkXa81dWeQQCPHAXwvkDkDKax8p9PLWXolTfV/w8xLGxacflfFVOxIF/+Nzgk8OysZqdgO3zbAban6LbELTk9mIc/1XByyxzVL5MlYfXHQ0HaedOnSDvI25dL1ulKsF9a65i7mb6fKLa8GeF/Pq64uTxd4TgTfAdvpo/MnHOtNjzFcAGDpQOfEiCyJOIXeA2c2MuOzHyjObmYcr2bzVmD8OUt/8SFfAJL03fNs2U7rdwZ3DFppnh6DsiREzsIhz2doZ5gWEr4EXH2IphwuVI5vhdlH5leKl5Eju7sBM18m1r9kgUOBZvEk0rHGBGLI2c60qp5vKGMS8MC6NNeAvpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m88twPtAarJOEk/7HLiKHscDbc1J5C21J6in1tUTUKM=;
 b=MOlf5vbJ7wUdhGhxL+sZsMnQepRQhti5YcVZfcUSkhqydNR8ChMLSZkT76zF2+6+tB+7ygD2asrjfwTGHgBkamDBcQFO8t3xsKCWyi6gOUWfY1npwptf/elRCxjqoTgjaUozo6rOp/hJ9N25G9KXpUVVWzaR4ua9brKLhS0WvDgO4j0ZX0zbcj7wZD3gpxR3mkrgyk+idmoEq2zqvYaNJ9ffj5UR4hVS0bqjyc4fXY8/ZqUUQO/on+DjJJXQ6p1OlknbtuJ2IKN7yDtFX2xqg1mzU75Jb71cApVaRyP35180AttWFgo+uG8KpAUc431C5/MZc4U4a9/8/viaetPMSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m88twPtAarJOEk/7HLiKHscDbc1J5C21J6in1tUTUKM=;
 b=NHrWAPrKzgXw2OMvJEjYgvTWiguTF/A36Zt8YTGb99NDskVTKVEaYO9WtILLAENaEshgIjm3iMUOMyf5r9ncFhjWrGQt9LRKSswWjA0vSpzSCGm/YwJCTxdfCvO7iwmf3CcqMFs8cw1lwhpr9CUVqw77DjdYUgKqjg0re3U+pBE=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5815.eurprd04.prod.outlook.com (2603:10a6:20b:b0::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 18 May
 2021 02:48:04 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::b10a:ad0:a6f5:db9b]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::b10a:ad0:a6f5:db9b%2]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 02:48:04 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Yu Zhao <yuzhao@google.com>
CC:     Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "dongas86@gmail.com" <dongas86@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: RE: [PATCH 1/5] mm: correct SECTION_SHIFT name in code comments
Thread-Topic: [PATCH 1/5] mm: correct SECTION_SHIFT name in code comments
Thread-Index: AQHXSw7SPViHYZfhlE+Hr7BWF+5UAKrn6vqAgACbdrA=
Date:   Tue, 18 May 2021 02:48:04 +0000
Message-ID: <AM6PR04MB4966B8259896953F9E4C1078802C9@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <20210517112044.233138-1-aisheng.dong@nxp.com>
 <20210517112044.233138-2-aisheng.dong@nxp.com>
 <CAOUHufabmeUedgOvxWB+Xy_W8rnqZssvjOR+QVt0VxWHuyLq2w@mail.gmail.com>
In-Reply-To: <CAOUHufabmeUedgOvxWB+Xy_W8rnqZssvjOR+QVt0VxWHuyLq2w@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f0cd4e6-259e-4c46-11cf-08d919a75c55
x-ms-traffictypediagnostic: AM6PR04MB5815:
x-microsoft-antispam-prvs: <AM6PR04MB5815083F18A4389A174AB076802C9@AM6PR04MB5815.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rgP5X2ASuqX+jB5gg1txlsHob6bkWPT+k0AGxELMR2ozIpDvNjJJxy0h32REeEvxf9bPMPyYQvxNrN7pyOir2NL6/GTXxp6PpeT+CgIe6Jalo74XRouFsuyY0tVSUkCApZysqNbiqj2WwOAL/XCPZZQLvPdK0nrI45eqDympzXzuwCts9kEdvYWd2IMNps3UeYH5YrIRx3sQ6OGxLX/fxfELeKegOlJbJGOXDJqRhGDGCU8QYmuZJ1bUZGQSSmfvx0H/QzcmvddvB/WXd2rLv2pyoWMIVSv6OseQf0dl8ryD+k9bN4M8zxyNWmq22Ix4+nRNoI2rMIFwJm/lNpvPQxHk88IF4vXG5ajZk2++4OwTQ5kBGPqg5ekcQnU1r9eilLWQKWABc/OoUwfYgVZlBVl72r4qdT09GMN69agOBKTf2NMfeVsvadHN/BJPrSAS6C5X2dZfYpm/lDpBEGtK4aC1l/BDQPye+FT4+miDVrpdNEBreWXqLooKsajxZHBHG+amBnGcmQ2Igq64zCUZHEUkq+nZl2KzjFgaCUCi8W762woxunsnsO/GaT0YWGvragoV7C1T22BK4hR+MFSjkQYT4f9qvY918VL7gVMoTlw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(2906002)(38100700002)(122000001)(83380400001)(26005)(5660300002)(66946007)(6916009)(52536014)(478600001)(54906003)(33656002)(7696005)(44832011)(53546011)(6506007)(71200400001)(4326008)(76116006)(66446008)(64756008)(66556008)(66476007)(316002)(55016002)(186003)(86362001)(9686003)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZnRKVFZldU1zanJVN21OSFF0T0xnNHhDZ1JNTlZaVmJxaEkydG9Da3FHMlpj?=
 =?utf-8?B?QjZKbm9pQ05LZ3dVZ1V0N3lJYTA5TEt6WWlML2xwSWpGZWdrSExkUXJWamJZ?=
 =?utf-8?B?NVBTeHl0REtKdStCaFh5U1lMWVoxWEl5djN6NGpyUklReGFxcWJJVkNXVEVm?=
 =?utf-8?B?cEhyWFh6dTlaak1NWk5LZ1F1YWo1SXlQZHhnN2hGRGVvT0dSMERaMXQ5RmpI?=
 =?utf-8?B?ZS9wT1YwK3M1eGJaUHhnK0IzbjAzS1pJNktkSWFpMDdHWTZMZUdlNkhQRWVV?=
 =?utf-8?B?b3QybHFsNnR3djJlRm5yM2ozOS9sQ2t0akVQTi9zMC84WW9kT0djSnZaZmQy?=
 =?utf-8?B?Vk5aaEl1MVo3cTZZcm9IMzhWSnlWcWVzUGR4WUM3N3dDWGpkZzB0dlJTZFRR?=
 =?utf-8?B?eW5xOVlmejQwcUY4YWZLMFM0QkpTU29PVlg1Z2FSbnBsRlZ5cWc4eklZR1pV?=
 =?utf-8?B?T0FkNkZOYjdhWHZ3aVovYTNXUlpmUzJmRzVZcFNReGJkZUxhbXkzZG5WSWpl?=
 =?utf-8?B?U09TQXUvaERDYW9YM21YSGxNazhzbTl0Mk80U21VZWk4cE1qOWZENlkxcVF6?=
 =?utf-8?B?Q1d3UEVtUURoMjA3TTNYdE5pSEJLTzdlWjhEaHpVVE1XZmRHUUR4MGNFanhv?=
 =?utf-8?B?WEFRU2c4aUM5TVFCckl0bjFnZDlEenBYTW1vMkpDUlQ1akpWNldtTGM1VC94?=
 =?utf-8?B?RXRucVBJalI5THgxTVY3RHBQUWNISnRpak1hYVp4MEF3bGZhZUdZL3hXOG03?=
 =?utf-8?B?VUVUSWErY0liU3ltNVFzT0twSHVoZHlaazRBaEo5VGc5cjBSaElBUFhpeHJi?=
 =?utf-8?B?OHdVempYNmhPUWhsMUZ3ek5lZ3YxaFNWTzg4TjVVR1VtaW1xazhGMTRqYURy?=
 =?utf-8?B?SjNycmkwU3VjbVV5dzhkc2lKOGxNTUpiVzczZmdDZkRxYmQ0cENWVGdodjM1?=
 =?utf-8?B?S3FCSWxCTEVyNkhYd3R4RTBkWXUvaW5IeWkrTUNQek16V2JPcVRVSUpSQXl4?=
 =?utf-8?B?MFd4M2RLelRxZVRKbGd5aUpKb2JsdW1WSVZPVTk4Sm4wSDJmMTBYbUEyTUZK?=
 =?utf-8?B?UlZVUDVZZnY5TkpnQlNDSWh3ZWF0QUdvektRWnZJeFQ4U241ZnJERlZ2Sjlx?=
 =?utf-8?B?UlpWSTVvWmZnQ211QXZXZk96S3cxaUNQTmJVbWNzalNsQTlJelRvblRFVC9G?=
 =?utf-8?B?QW0waWtGY0ozcHp5aDJ0ZjRNVzd4Kzk3VGlydTFGb2V0eXg4eWpIenNScmtE?=
 =?utf-8?B?OXZ2aWhHOERVU00xcjU2NHpFVmlEVWRTcTgzaVBoWmJaOC9KcnZmR1BKdExC?=
 =?utf-8?B?Z1d3dkFFempOMTVxNC8vRVc5MTRTOXM0S1ZtbnMxN0Z1ZTlJcUdPajBoMkY5?=
 =?utf-8?B?Z29mNUgzeDBRc1NBcjMzN04veE0ya2R2S1RjZm1TTkZIS3VCQ2NtUlVZb2JO?=
 =?utf-8?B?cmZITmpOSGxMY0dDSUhSaUFIZENNTXBxN1RjdGdja3JIWUNrQmIwSEJpcnBl?=
 =?utf-8?B?YmRXdlIxQUsrQWZJR0FyS2FYQ1hCTmw4ZFpSSlc5dC9QR2FYejhWblV1Ym53?=
 =?utf-8?B?VU0zS1lIZSsvSnk1TWFnOWJzWWc3WDhtN0VTTXVwNW96Y3F6NWx4UWVIVDhJ?=
 =?utf-8?B?Um1rOXlKM2twVnJiOWtuOXErSy81UWFxZiszNzRYemx2bUY5cXJnVEpaVWxv?=
 =?utf-8?B?clFhbkJTeHdZbU90RWQwL0ZVM2lueDEvWG5CTjdCSzdiUTFSNG0yU3VkZzZO?=
 =?utf-8?Q?GLU6+R8NpELtqJ3fDIXQL8WFLva1CBTrxns9MCw?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0cd4e6-259e-4c46-11cf-08d919a75c55
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2021 02:48:04.8078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dIagyAGk0T0avjpguJAy4zPqNH00b9qPFAHCJ2J1/BWX4jyLuFUn9I3/jmkVQxGYTipUPoEFpH9VeHi5yiA67g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5815
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBZdSBaaGFvIDx5dXpoYW9AZ29vZ2xlLmNvbT4NCj4gU2VudDogVHVlc2RheSwgTWF5
IDE4LCAyMDIxIDE6MTggQU0NCj4gDQo+IE9uIE1vbiwgTWF5IDE3LCAyMDIxIGF0IDU6MjEgQU0g
RG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBB
Y3R1YWxseSBTRUNUSU9OU19TSElGVCBpcyB1c2VkIGluIHRoZSBrZXJuZWwgY29kZSwgZml4ZWQg
dGhlIGNvZGUNCj4gPiBjb21tZW50cy4gQlRXLCBhbHNvIG1vdmVkIHRoZSBjb2RlIGNvbW1lbnQg
dG8gd2hlcmUgaXQncyBkZWZpbmVkLg0KPiA+DQo+ID4gQWxzbyBmaXhlZCBhIGNoZWNrcGF0Y2gg
Y29tcGxhaW4gZGVyaXZlZCBmcm9tIHRoZSBvcmlnaW5hbCBjb2RlOg0KPiA+IFdBUk5JTkc6IHBs
ZWFzZSwgbm8gc3BhY2UgYmVmb3JlIHRhYnMNCj4gPiArICogU0VDVElPTlNfU0hJRlQgICAgXkle
SSNiaXRzIHNwYWNlIHJlcXVpcmVkIHRvIHN0b3JlIGEgc2VjdGlvbiAjJA0KPiA+DQo+ID4gQ2M6
IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+DQo+ID4gQ2M6IFl1IFpo
YW8gPHl1emhhb0Bnb29nbGUuY29tPg0KPiA+IENjOiBBbmRyZXkgS29ub3ZhbG92IDxhbmRyZXlr
bnZsQGdtYWlsLmNvbT4NCj4gPiBDYzogQ2F0YWxpbiBNYXJpbmFzIDxjYXRhbGluLm1hcmluYXNA
YXJtLmNvbT4NCj4gPiBDYzogS2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5vcmc+DQo+ID4g
U2lnbmVkLW9mZi1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCj4gPiAt
LS0NCj4gPiAgaW5jbHVkZS9saW51eC9tbXpvbmUuaCAgICAgICAgICAgIHwgMiAtLQ0KPiA+ICBp
bmNsdWRlL2xpbnV4L3BhZ2UtZmxhZ3MtbGF5b3V0LmggfCAzICsrKw0KPiA+ICAyIGZpbGVzIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L21tem9uZS5oIGIvaW5jbHVkZS9saW51eC9tbXpvbmUuaCBpbmRl
eA0KPiA+IDljZGM4OGQwOWYyYi4uZmMyM2UzNmNiMTY1IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1
ZGUvbGludXgvbW16b25lLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L21tem9uZS5oDQo+ID4g
QEAgLTExOTgsOCArMTE5OCw2IEBAIHN0YXRpYyBpbmxpbmUgc3RydWN0IHpvbmVyZWYNCj4gPiAq
Zmlyc3Rfem9uZXNfem9uZWxpc3Qoc3RydWN0IHpvbmVsaXN0ICp6b25lbGlzdCwgICNpZmRlZg0K
PiA+IENPTkZJR19TUEFSU0VNRU0NCj4gPg0KPiA+ICAvKg0KPiA+IC0gKiBTRUNUSU9OX1NISUZU
ICAgICAgICAgICAgICAgI2JpdHMgc3BhY2UgcmVxdWlyZWQgdG8gc3RvcmUgYSBzZWN0aW9uICMN
Cj4gPiAtICoNCj4gPiAgICogUEFfU0VDVElPTl9TSElGVCAgICAgICAgICAgIHBoeXNpY2FsIGFk
ZHJlc3MgdG8vZnJvbSBzZWN0aW9uDQo+IG51bWJlcg0KPiA+ICAgKiBQRk5fU0VDVElPTl9TSElG
VCAgICAgICAgICAgcGZuIHRvL2Zyb20gc2VjdGlvbiBudW1iZXINCj4gPiAgICovDQo+ID4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvcGFnZS1mbGFncy1sYXlvdXQuaA0KPiA+IGIvaW5jbHVk
ZS9saW51eC9wYWdlLWZsYWdzLWxheW91dC5oDQo+ID4gaW5kZXggZWYxZTNlNzM2ZTE0Li5hZmY2
MTY4NTU0OTIgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9wYWdlLWZsYWdzLWxheW91
dC5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9wYWdlLWZsYWdzLWxheW91dC5oDQo+ID4gQEAg
LTI2LDYgKzI2LDkgQEANCj4gPg0KPiA+ICAjZGVmaW5lIFpPTkVTX1dJRFRIICAgICAgICAgICAg
Wk9ORVNfU0hJRlQNCj4gPg0KPiA+ICsvKg0KPiA+ICsgKiBTRUNUSU9OU19TSElGVCAgICAgICAg
ICAgICAgI2JpdHMgc3BhY2UgcmVxdWlyZWQgdG8gc3RvcmUgYSBzZWN0aW9uICMNCj4gPiArICov
DQo+IA0KPiBJTU8sIHdlIHNob3VsZCBlaXRoZXIgbWFrZSB0aGUgb3JpZ2luYWwgY29tbWVudCBo
ZWxwZnVsIG9yIGp1c3QgcmVtb3ZlIGl0Lg0KPiBNb3ZpbmcgaXQgaGVyZSBkb2Vzbid0IGltcHJv
dmUgcmVhZGFiaWxpdHkgYmVjYXVzZSBpdCdzIHN0YXRpbmcgdGhlIG9idmlvdXMuDQo+IA0KDQpT
b3VuZHMgZ29vZCB0byBtZS4NCklmIG5vdCBvYmplY3Rpb25zLCBJIHdpbGwgcmVtb3ZlIGl0IGlu
IHYyIGxhdGVyLg0KVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbi4NCg0KUmVnYXJkcw0KQWlzaGVu
Zw0KDQo+ID4gICNpZmRlZiBDT05GSUdfU1BBUlNFTUVNDQo+ID4gICNpbmNsdWRlIDxhc20vc3Bh
cnNlbWVtLmg+DQo+ID4gICNkZWZpbmUgU0VDVElPTlNfU0hJRlQgKE1BWF9QSFlTTUVNX0JJVFMg
LSBTRUNUSU9OX1NJWkVfQklUUykNCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+DQo=
