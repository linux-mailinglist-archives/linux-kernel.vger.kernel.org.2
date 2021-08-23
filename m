Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683DB3F4331
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 03:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbhHWBxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 21:53:44 -0400
Received: from mail-eopbgr70079.outbound.protection.outlook.com ([40.107.7.79]:61951
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234583AbhHWBxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 21:53:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWCA6o4DBdsf0Epiy2dCLAb50nBkx/lui/zK4q07cFKQ4IPmBFVq1nNOvPFX2gM1Cgpok1EYP8riNzn5vcZuGdFMQZfp4nzNculGG5gt/xpOXJfZeoQ1uZPD4pzWwH9aMbvUccclbWJd13S+z8O6PbLoxbbUVegillbE9pmhZDMgOpGc1Ve/s2lcI99L1/rA+olnZoFD3wehEwJU3FVUlGRJSLBFg5Zb+ZhOysfDB4tBvHHt7rTKp8uLB1LlSFGvmt9ACu1fWACJN9CFt9yU/a5f7+UNNBH4urweb/gLgRYdLDfmUqSr+wz6KcJQpEbsH8B6jdt6Ul7lX/bkZ6UvRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pnu52SX0O50LAinky/oXblyKrK0HvdrWYp6EUgq4MaM=;
 b=SkQsfn35oK5g0/OmU1bEfFcH3IZeOOLUQC+OEVNY7YtYoroObS6KceJq0eL49/KmUm7ZejImb+A/3+XBT8IeVDXrfATWzpxWh5IcgFY2Sl/acAIxXFNcNpqrj5thAHlBQo3D6Asv4efc/1zMpRh4KKxZIsgnXegtSnm8+mMXbl6kE3BYlLIuP5gva5zSJAfm+wJgdpfraC7vF8XCUCoNENqMfORmTl4nkDgo0L0fUYYw3V5Dyxp3MYCj/gUcrBINy7kp2b+ck3Tr0HBHIItJCOjxazBTr0nMv9GrE16Vf0uYtAN7lK3tZ1yhazRk1IGn4KwI8rcz0dHEuzdKFtQ5GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pnu52SX0O50LAinky/oXblyKrK0HvdrWYp6EUgq4MaM=;
 b=pAMe1WyDN2kKy6dSPHmXD9amEHViW1uhDgTu49nncHaeYmlMNfBuniK1Okp/1PIZF+AFvDRPD8/0zQUVoIiwU6XT1NKlPOQGBoZ3FNxR6JGc7KYAqDjRFL2c9ii6HPnPmcQzLRiq2f+wxiHoXrVQyvLmGGBuM/Xv9ZXMTOYh/IA=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VE1PR04MB7325.eurprd04.prod.outlook.com (2603:10a6:800:1af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Mon, 23 Aug
 2021 01:52:58 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::d010:8002:44b8:117b]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::d010:8002:44b8:117b%7]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 01:52:57 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "robh@kernel.org" <robh@kernel.org>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v1 2/3] arm: dts: imx: fix the schema check errors
Thread-Topic: [PATCH v1 2/3] arm: dts: imx: fix the schema check errors
Thread-Index: AQHXlMnw7oweqEOZQ0uRq7btk3u33at6rBuAgAWtADA=
Date:   Mon, 23 Aug 2021 01:52:57 +0000
Message-ID: <VI1PR04MB585360C501595D8EAE9F0E468CC49@VI1PR04MB5853.eurprd04.prod.outlook.com>
References: <20210819071408.3856475-1-hongxing.zhu@nxp.com>
         <20210819071408.3856475-3-hongxing.zhu@nxp.com>
 <cbd278b1828d4b8fbfd885e56731d82355d2112b.camel@pengutronix.de>
In-Reply-To: <cbd278b1828d4b8fbfd885e56731d82355d2112b.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 255e5aed-65d1-45d4-5bce-08d965d8bb44
x-ms-traffictypediagnostic: VE1PR04MB7325:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB732560D6674142E6448D11A28CC49@VE1PR04MB7325.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sfMQyksFhDxezQIL7W3W/w5s0GNxwhd9BDckyJRDfV1C7fxJDboMWbhCrF7qu/cNVLeh//m+0R28Qz+DQsJUsnYimZ36nOR451oPygL9MOGvN+7nDYJijjrb91eIneuw6m5gV4/8KXmN0WmNQHkqhdyvyynPuOVMR3+fmp2vqIt8wuYUMr0imD+CqOc3i9hgJYsLJB58+y9NXE8Vvrvqh7Kl8dVFoOiBqTpdFTILNlz0neV3ZIrF+GqQWiIFllMLMhH9NJvBYELRz68GJ55numkc5LrXApsabvsUWTwrz4FSOgmyYzzZHY1jantpbJvp2KTP8ktcZwphZZibO4KcZ6q8DtOsXei8O5Ajz/NtDQZu6hDFAbiMV76uW+rSZbiofJvn6lvNuuzG+FZd7qLaYYfkiP8xtr3cLu6VH4YCBNIHEc9HEla3VbbUIdG4tYQpcUDVMbJnf2ZAdeeGhHiE6dGF0VTthAd0emqJMFYZyMSe0U8oLLZ/PMB9rzIymea3t6Ud4Gw5h7ZoT04uJ4aBM8lh+BjzTOe+xy5i4Tn23EGRBq/jUebN4i1J5QfnCqf0lJgob5ZzUlp24kMoy5zDYPdd0PutLIWBD4PV6SdZomLgLRMEmP1M69mlwnLjvm8a0b6gbag2xJNesc6Qlfom483ft9g5IpjfznNesIX70zswhs8PiGudLYkB2cC6uKUZToBNLHmYTUB3W6fg87JmYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(53546011)(33656002)(66556008)(316002)(8936002)(186003)(5660300002)(38070700005)(55016002)(86362001)(54906003)(8676002)(26005)(478600001)(6506007)(7696005)(4326008)(122000001)(52536014)(66446008)(66946007)(66476007)(71200400001)(64756008)(110136005)(9686003)(38100700002)(2906002)(83380400001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmdueWgyajNxVklkMUZzZWNXRENwM05GSnRLUEZSendjY2ZMaFBpSHVUOVd1?=
 =?utf-8?B?aFJaY0NGSFd3NE5lV29aS3pCVERpMzdJVmQwUE82THlscEJlOEhGR2FPenIx?=
 =?utf-8?B?cXNzQjhtVEhvbXhtTFhCbDBqeko0TTFHbmlVS2Z6Y0NpajBDSHpYTVVYY0NB?=
 =?utf-8?B?NGszTlVFcmc1QlZMVkhTQlNvK25Gcmxnd2Q0bW1yRGc1dWFLRkt6ak1oYS9r?=
 =?utf-8?B?MTNya3JzUENOcWp4bmNYTW5lTEJQc3RiRjhaNnlMckFlRDVySlFsc0YxTTJ5?=
 =?utf-8?B?cXArQlpKUk1BNVUvVkJKakVRaXg3d29UMTlWMEViaVdkVWhtK3NHMndHRHdD?=
 =?utf-8?B?WnBNS3RqZlVHaGF0NGttNVY1WGtHbkhML2wvWEhrTDBBaGd2ZkFyZExkRTdL?=
 =?utf-8?B?M29mWWxmTXR1WE1kc08yRGg5SzkxRjVTUXBLS1A1eFZuak9CcW9QazJNTHVz?=
 =?utf-8?B?R2F0eThORFlaNk9DMmM4V0g3aVpwVTROZUt5bUg1cVh2Z3BCYVhBZVVneFNC?=
 =?utf-8?B?MlJZV2lnMHBYMFhwSFRLTmFMUGpzMHA2M2RCZHhldW1uTHZyeVI2dWhHcDJk?=
 =?utf-8?B?cHpPR2FLVnRtYnNHTmhIU0IvVHgvamlsUDB2dGdUYnpMalhBcG85SkxNcUp0?=
 =?utf-8?B?T1Qza2V6S1N5enE0ZUZ4RTNCbGMrbnZ0amdsZ2JjeS9VbkxncXpZWEZYL3Uy?=
 =?utf-8?B?SGh5ZDdyVytUSkhCbC9NOUpGNjJsUngvbUNFUGNmVmpBQTdvMERjZTVqeVRQ?=
 =?utf-8?B?SC9UdEUrdElUR3Z0SXlMTmJJbWphZTQxWDRXQmxkVGVUZTJpMzBuWE5UVTJy?=
 =?utf-8?B?V0ptaDhlR3VGZDhqZnpRYWtIM25TMmxHQ0dRa0kyd1hDWXlvdUtudStIWnor?=
 =?utf-8?B?NUNpL3JYck5LZ25KV2JqM0VDS3NraitDSVZwMGxFSEhSUVFVY1BsZ3lHM1ZO?=
 =?utf-8?B?RjZBcWZGREVJcjAxL3l5RHFyeWpYMDBvdncvSkQ1b3d1dVhJalF3bk4vNVhY?=
 =?utf-8?B?WGQ2dWd2NzFiYmxOeVM2RkJwRE5MaHZ1TmhlMmd0L054VEFMVXZkdGw3dHAx?=
 =?utf-8?B?aitObEJmcU1XQmczQldIWHlCOHpQdS9WeVpuRzcySEUvaVlOem54RWNRNmJj?=
 =?utf-8?B?U2J1QkMxdVl1UmlPNlAyWFZRRlI0dS9YdjhpOU1Tazc5NTBnK0JiaHQ4TDlm?=
 =?utf-8?B?MHR2d3I4dHRMUlZzOWl3MDNreThjV3IyNVhldndFdjFTdjFUYVJtRkFSbEpJ?=
 =?utf-8?B?RW9reFRtbE5YTTlHN1RWWC9CNExONyt3aElLdUg1QytGbVQxbmZXWk9sQzdu?=
 =?utf-8?B?Z1ZTVExtUXdVMmtSeUhmSEhZdGxMVnVidFlNOGxyUFlldXlEUEhTSnZEN1M4?=
 =?utf-8?B?K05tbFJrV0ZHWjd0aXhXb1JQWlVDWVp2SE83OWtCK2hnZG5YNTAzSGJxd1FZ?=
 =?utf-8?B?Q0RLeE1mUXJMa0F3clFWajc2bUFUdVQvcnh1SXdySTFXT3dURGgybjdaSWVI?=
 =?utf-8?B?c0xJOUE0TmZ4Zm91ZkV0WEtWREpYUlpZSUg4K1JoUDVqOWk3bjEvYk44ZUcv?=
 =?utf-8?B?Q3ZwVkg1VFRHQ2Y4TG5iRGNST2ZKQlRaVExzR3hJS1VSWk5RSW4rN1l5RitC?=
 =?utf-8?B?V1p0aUNneXY5Vzk1YmhFRUE5aDIxck9WZUNUYi94N1puTXphT0xDbkhBVDQ5?=
 =?utf-8?B?bktUL1o4RHNIaW95QnFNb3BiUks1SllxakpkSmJMdUlqZ3RLMmxMaFBUUU5E?=
 =?utf-8?Q?eaIzy/pNRfaQaiOcxe5Vx1/ucOTiUR5buwvG61N?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 255e5aed-65d1-45d4-5bce-08d965d8bb44
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2021 01:52:57.7197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GWoLLWMSn/0DXpbp4Qdq3RtS5WitZtrzbodsNg+ERuEdXgHceO5McuKh9Y7Ni+bEro+hU0IXSBzXPQJoKul/7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7325
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCAxOSwgMjAyMSA3OjEx
IFBNDQo+IFRvOiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyByb2JoQGtlcm5l
bC5vcmc7DQo+IGdhbGFrQGtlcm5lbC5jcmFzaGluZy5vcmc7IHNoYXduZ3VvQGtlcm5lbC5vcmcN
Cj4gQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBkbC1saW51eC1pbXgNCj4gPGxpbnV4LWlteEBueHAuY29tPjsga2VybmVsQHBlbmd1
dHJvbml4LmRlOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MSAyLzNdIGFybTogZHRzOiBpbXg6IGZpeCB0aGUgc2NoZW1hIGNo
ZWNrIGVycm9ycw0KPiANCj4gSGkgUmljaGFyZCwNCj4gDQo+IEFtIERvbm5lcnN0YWcsIGRlbSAx
OS4wOC4yMDIxIHVtIDE1OjE0ICswODAwIHNjaHJpZWIgUmljaGFyZCBaaHU6DQo+ID4gLSB0aGUg
cmFuZ2VzIHNob3VsZCBiZSBhbGlnbmVkIHRvICRyZWY6IC9zY2hlbWFzL3BjaS9wY2ktYnVzLnlh
bWwjDQo+IA0KPiBJIGZhaWxlZCB0byBwYXJzZSB0aGlzIHBhcnQgb2YgdGhlIGNvbW1pdCBtZXNz
YWdlIGFuZCBleHBlY3RlZCB0byBzZWUgYW4NCj4gYWN0dWFsIGNoYW5nZSBpbiB0aGUgYWRkcmVz
c2VzIG9mIHRoZSByYW5nZXMgb3Igc29tZXRoaW5nLiBJIHRoaW5rIGl0IHdvdWxkIGJlDQo+IGJl
dHRlciB0byBwaHJhc2UgdGhpcyBzb21ldGhpbmcgbGlrZTogImdyb3VwIHJhbmdlcyBwcm9wZXJ0
eSBieSByZWdpb24iIG9yDQo+IHNvbWV0aGluZyB0byBtYWtlIGl0IGNsZWFyIHRoYXQgdGhpcyBp
cyBwdXJlbHkgYSBEVFMgcmVwcmVzZW50YXRpb24gY2hhbmdlLA0KPiB3aXRoIG5vIGZ1bmN0aW9u
YWwgY2hhbmdlLg0KPiANCltSaWNoYXJkIFpodV0gSGkgTHVjYXM6DQpUaGFua3MuDQpXb3VsZCBj
aGFuZ2UgYXMgImdyb3VwIHJhbmdlcyBwcm9wZXJ0eSBieSByZWdpb24iIHJlZmVyIHRvIHlvdXIg
cmV2aWV3IGNvbW1lbnRzLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQoNCj4gPiAtIG51
bS12aWV3cG9ydCBpcyByZXF1aXJlZCwgYWRkIGl0IGluIGlteDZzeC5kdHNpLg0KPiA+IC0gb25s
eSBvbmUgcHJvcGVydCBpcyBhbGxvd2VkIGluIHRoZSBjb21wYXRpYmxlIHN0cmluZywgcmVtb3Zl
DQo+ID4gICAic25wcyxkdy1wY2llIi4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQg
Wmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gDQo+IE90aGVyIHRoYW4gdGhlIG5pdCBhYm92
ZSwgdGhpcyBpczoNCj4gUmV2aWV3ZWQtYnk6IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJv
bml4LmRlPg0KPiANCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC5kdHNp
IHwgNiArKystLS0NCj4gPiBhcmNoL2FybS9ib290L2R0cy9pbXg2cXAuZHRzaSAgfCAyICstICBh
cmNoL2FybS9ib290L2R0cy9pbXg2c3guZHRzaQ0KPiA+IHwgNyArKysrLS0tDQo+ID4gIGFyY2gv
YXJtL2Jvb3QvZHRzL2lteDdkLmR0c2kgICB8IDYgKysrLS0tDQo+ID4gIDQgZmlsZXMgY2hhbmdl
ZCwgMTEgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC5kdHNpDQo+ID4gYi9hcmNoL2FybS9ib290L2R0
cy9pbXg2cWRsLmR0c2kgaW5kZXggODJlMDFjZTAyNmVhLi5jYjQzYzcyODA2YTENCj4gPiAxMDA2
NDQNCj4gPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLmR0c2kNCj4gPiArKysgYi9h
cmNoL2FybS9ib290L2R0cy9pbXg2cWRsLmR0c2kNCj4gPiBAQCAtMjY0LDcgKzI2NCw3IEBAIEwy
OiBjYWNoZS1jb250cm9sbGVyQGEwMjAwMCB7DQo+ID4gIAkJfTsNCj4gPg0KPiA+ICAJCXBjaWU6
IHBjaWVAMWZmYzAwMCB7DQo+ID4gLQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDZxLXBjaWUiLCAi
c25wcyxkdy1wY2llIjsNCj4gPiArCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14NnEtcGNpZSI7DQo+
ID4gIAkJCXJlZyA9IDwweDAxZmZjMDAwIDB4MDQwMDA+LA0KPiA+ICAJCQkgICAgICA8MHgwMWYw
MDAwMCAweDgwMDAwPjsNCj4gPiAgCQkJcmVnLW5hbWVzID0gImRiaSIsICJjb25maWciOw0KPiA+
IEBAIC0yNzIsOCArMjcyLDggQEAgcGNpZTogcGNpZUAxZmZjMDAwIHsNCj4gPiAgCQkJI3NpemUt
Y2VsbHMgPSA8Mj47DQo+ID4gIAkJCWRldmljZV90eXBlID0gInBjaSI7DQo+ID4gIAkJCWJ1cy1y
YW5nZSA9IDwweDAwIDB4ZmY+Ow0KPiA+IC0JCQlyYW5nZXMgPSA8MHg4MTAwMDAwMCAwIDAgICAg
ICAgICAgMHgwMWY4MDAwMCAwDQo+IDB4MDAwMTAwMDAgLyogZG93bnN0cmVhbSBJL08gKi8NCj4g
PiAtCQkJCSAgMHg4MjAwMDAwMCAwIDB4MDEwMDAwMDAgMHgwMTAwMDAwMCAwIDB4MDBmMDAwMDA+
Ow0KPiAvKiBub24tcHJlZmV0Y2hhYmxlIG1lbW9yeSAqLw0KPiA+ICsJCQlyYW5nZXMgPSA8MHg4
MTAwMDAwMCAwIDAgICAgICAgICAgMHgwMWY4MDAwMCAwDQo+IDB4MDAwMTAwMDA+LCAvKiBkb3du
c3RyZWFtIEkvTyAqLw0KPiA+ICsJCQkJIDwweDgyMDAwMDAwIDAgMHgwMTAwMDAwMCAweDAxMDAw
MDAwIDAgMHgwMGYwMDAwMD47DQo+IC8qDQo+ID4gK25vbi1wcmVmZXRjaGFibGUgbWVtb3J5ICov
DQo+ID4gIAkJCW51bS1sYW5lcyA9IDwxPjsNCj4gPiAgCQkJbnVtLXZpZXdwb3J0ID0gPDQ+Ow0K
PiA+ICAJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTIwIElSUV9UWVBFX0xFVkVMX0hJR0g+OyBk
aWZmIC0tZ2l0DQo+ID4gYS9hcmNoL2FybS9ib290L2R0cy9pbXg2cXAuZHRzaSBiL2FyY2gvYXJt
L2Jvb3QvZHRzL2lteDZxcC5kdHNpIGluZGV4DQo+ID4gYjMxMGYxM2E1M2YyLi4wNTAzNjU1MTM4
MzYgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFwLmR0c2kNCj4gPiAr
KysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2cXAuZHRzaQ0KPiA+IEBAIC0xMTAsNSArMTEwLDUg
QEAgJm1tZGMwIHsNCj4gPiAgfTsNCj4gPg0KPiA+ICAmcGNpZSB7DQo+ID4gLQljb21wYXRpYmxl
ID0gImZzbCxpbXg2cXAtcGNpZSIsICJzbnBzLGR3LXBjaWUiOw0KPiA+ICsJY29tcGF0aWJsZSA9
ICJmc2wsaW14NnFwLXBjaWUiOw0KPiA+ICB9Ow0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9i
b290L2R0cy9pbXg2c3guZHRzaQ0KPiA+IGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnN4LmR0c2kg
aW5kZXggODUxNjczMDc3OGRmLi4wMzI0ZjllMTczODkNCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9h
cmNoL2FybS9ib290L2R0cy9pbXg2c3guZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRz
L2lteDZzeC5kdHNpDQo+ID4gQEAgLTEzOTUsMTYgKzEzOTUsMTcgQEAgcHdtODogcHdtQDIyYjAw
MDAgew0KPiA+ICAJCX07DQo+ID4NCj4gPiAgCQlwY2llOiBwY2llQDhmZmMwMDAgew0KPiA+IC0J
CQljb21wYXRpYmxlID0gImZzbCxpbXg2c3gtcGNpZSIsICJzbnBzLGR3LXBjaWUiOw0KPiA+ICsJ
CQljb21wYXRpYmxlID0gImZzbCxpbXg2c3gtcGNpZSI7DQo+ID4gIAkJCXJlZyA9IDwweDA4ZmZj
MDAwIDB4MDQwMDA+LCA8MHgwOGYwMDAwMCAweDgwMDAwPjsNCj4gPiAgCQkJcmVnLW5hbWVzID0g
ImRiaSIsICJjb25maWciOw0KPiA+ICAJCQkjYWRkcmVzcy1jZWxscyA9IDwzPjsNCj4gPiAgCQkJ
I3NpemUtY2VsbHMgPSA8Mj47DQo+ID4gIAkJCWRldmljZV90eXBlID0gInBjaSI7DQo+ID4gIAkJ
CWJ1cy1yYW5nZSA9IDwweDAwIDB4ZmY+Ow0KPiA+IC0JCQlyYW5nZXMgPSA8MHg4MTAwMDAwMCAw
IDAgICAgICAgICAgMHgwOGY4MDAwMCAwDQo+IDB4MDAwMTAwMDAgLyogZG93bnN0cmVhbSBJL08g
Ki8NCj4gPiAtCQkJCSAgMHg4MjAwMDAwMCAwIDB4MDgwMDAwMDAgMHgwODAwMDAwMCAwIDB4MDBm
MDAwMDA+Ow0KPiAvKiBub24tcHJlZmV0Y2hhYmxlIG1lbW9yeSAqLw0KPiA+ICsJCQlyYW5nZXMg
PSA8MHg4MTAwMDAwMCAwIDAgICAgICAgICAgMHgwOGY4MDAwMCAwDQo+IDB4MDAwMTAwMDA+LCAv
KiBkb3duc3RyZWFtIEkvTyAqLw0KPiA+ICsJCQkJIDwweDgyMDAwMDAwIDAgMHgwODAwMDAwMCAw
eDA4MDAwMDAwIDAgMHgwMGYwMDAwMD47DQo+IC8qDQo+ID4gK25vbi1wcmVmZXRjaGFibGUgbWVt
b3J5ICovDQo+ID4gIAkJCW51bS1sYW5lcyA9IDwxPjsNCj4gPiArCQkJbnVtLXZpZXdwb3J0ID0g
PDQ+Ow0KPiA+ICAJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTIwIElSUV9UWVBFX0xFVkVMX0hJ
R0g+Ow0KPiA+ICAJCQlpbnRlcnJ1cHQtbmFtZXMgPSAibXNpIjsNCj4gPiAgCQkJI2ludGVycnVw
dC1jZWxscyA9IDwxPjsNCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14N2Qu
ZHRzaQ0KPiA+IGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14N2QuZHRzaSBpbmRleCBiMGJjZmE5MDk0
YTMuLjBjYjhjOGRmODdlZg0KPiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9p
bXg3ZC5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14N2QuZHRzaQ0KPiA+IEBA
IC0xNjQsNyArMTY0LDcgQEAgZmVjMjogZXRoZXJuZXRAMzBiZjAwMDAgew0KPiA+ICAJfTsNCj4g
Pg0KPiA+ICAJcGNpZTogcGNpZUAzMzgwMDAwMCB7DQo+ID4gLQkJY29tcGF0aWJsZSA9ICJmc2ws
aW14N2QtcGNpZSIsICJzbnBzLGR3LXBjaWUiOw0KPiA+ICsJCWNvbXBhdGlibGUgPSAiZnNsLGlt
eDdkLXBjaWUiOw0KPiA+ICAJCXJlZyA9IDwweDMzODAwMDAwIDB4NDAwMD4sDQo+ID4gIAkJICAg
ICAgPDB4NGZmMDAwMDAgMHg4MDAwMD47DQo+ID4gIAkJcmVnLW5hbWVzID0gImRiaSIsICJjb25m
aWciOw0KPiA+IEBAIC0xNzIsOCArMTcyLDggQEAgcGNpZTogcGNpZUAzMzgwMDAwMCB7DQo+ID4g
IAkJI3NpemUtY2VsbHMgPSA8Mj47DQo+ID4gIAkJZGV2aWNlX3R5cGUgPSAicGNpIjsNCj4gPiAg
CQlidXMtcmFuZ2UgPSA8MHgwMCAweGZmPjsNCj4gPiAtCQlyYW5nZXMgPSA8MHg4MTAwMDAwMCAw
IDAgICAgICAgICAgMHg0ZmY4MDAwMCAwIDB4MDAwMTAwMDANCj4gLyogZG93bnN0cmVhbSBJL08g
Ki8NCj4gPiAtCQkJICAweDgyMDAwMDAwIDAgMHg0MDAwMDAwMCAweDQwMDAwMDAwIDAgMHgwZmYw
MDAwMD47IC8qDQo+IG5vbi1wcmVmZXRjaGFibGUgbWVtb3J5ICovDQo+ID4gKwkJcmFuZ2VzID0g
PDB4ODEwMDAwMDAgMCAwICAgICAgICAgIDB4NGZmODAwMDAgMCAweDAwMDEwMDAwPiwNCj4gLyog
ZG93bnN0cmVhbSBJL08gKi8NCj4gPiArCQkJIDwweDgyMDAwMDAwIDAgMHg0MDAwMDAwMCAweDQw
MDAwMDAwIDAgMHgwZmYwMDAwMD47IC8qDQo+ID4gK25vbi1wcmVmZXRjaGFibGUgbWVtb3J5ICov
DQo+ID4gIAkJbnVtLWxhbmVzID0gPDE+Ow0KPiA+ICAJCW51bS12aWV3cG9ydCA9IDw0PjsNCj4g
PiAgCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTIyIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiAN
Cg0K
