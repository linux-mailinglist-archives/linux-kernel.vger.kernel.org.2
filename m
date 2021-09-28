Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8505741A59A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 04:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238746AbhI1CkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 22:40:13 -0400
Received: from mail-eopbgr50052.outbound.protection.outlook.com ([40.107.5.52]:30278
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238711AbhI1CkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 22:40:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSoXZZGB1gJCsTfAHSCrqeYQo66bV60A4i7tyZVm4DV7NyUS+ZhBMCVR22wNZkvGCIOf8994xeM5plyKvdmc+Foo7ihCXpzoWtgry22HzMPxvzw3fUQx2R9AtdxYlVlv79IK9mnX8huX4ore6Ou8/hVEJKXa8DQTTRN95LVMXrcwZgS5W2tWXiBlamGk1fUaDO/sN+40Wkz8ZCHDTqOaSho1nfxNI7RNFUIHgoo/FF65yNQk4uPJWUA9aK6qBNjuhN3DmPQcuNkGOriQA6nxvRCXmKiWcvjVoA0c2XhoUTCrnRehd2yfipoJlcKcCby2h+yO1zVdTo7GzvowaPXCww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=IQUHOEfySLtWyD7Cl3YTLQMqm57Nz+/24DKq9fxMTqs=;
 b=oR7dtRzGiD9VQiB/gM/UWnQHuTLcHb59Kywavk7ODcnZpTwRi6VCBoW6puwwx/4Vztji72eTrrgkWMrBLWzJvg/pJcxEDhk4UZnRnsjBmDTMGwp1c+rX8EjgcSfmMbSbexQYe9uS9+9YtLTDy0GLjuSETCMiRs4iv81zIvOr5AxTxsEVKG0YMuiZeSe6fZJE9bHdpyHU5kvf1CoHBOMLP3fTwkapU6tqXvDOMVmOG0yvkuOzXtdO51COl9mIrq9UKqXvfU+EUfbrKtSsoGCdsJUZ7CAbjRE3PEiOxG6aDZA86Ek8vgAUpXB0dOrN6u+lvoeebKA2rpKsFs/Y9Ho+4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQUHOEfySLtWyD7Cl3YTLQMqm57Nz+/24DKq9fxMTqs=;
 b=cj3hbsRr2QpmopAg3dcTTHqUod51+eXIGp7sQFIJLI9xNz2BYgNCa2O3APrwMGCbQkOWsn6NlEmFhmAHzn9n303Wvc59Ek1wXH5PZzvyNCHljcCYdEBBVAknu3bEMZYjGgPCJvWQZJK799/tIfzSmFIJXOpFijVFqNNZNnoR8ck=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8546.eurprd04.prod.outlook.com (2603:10a6:20b:421::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 28 Sep
 2021 02:38:30 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::c5ef:f538:c3e0:c4c2]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::c5ef:f538:c3e0:c4c2%9]) with mapi id 15.20.4544.022; Tue, 28 Sep 2021
 02:38:30 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v2 3/4] arm64: dts: imx8mm: add the pcie phy support
Thread-Topic: [PATCH v2 3/4] arm64: dts: imx8mm: add the pcie phy support
Thread-Index: AQHXsq0Fli4oS7cQWUSBBUQ6eND1Pqu3j8+AgAEua4A=
Date:   Tue, 28 Sep 2021 02:38:30 +0000
Message-ID: <AS8PR04MB86769FBC49DCB29D557CA5CB8CA89@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1632641983-1455-1-git-send-email-hongxing.zhu@nxp.com>
         <1632641983-1455-4-git-send-email-hongxing.zhu@nxp.com>
 <b7604aa25a5d6746025fadeea42a7cc4b5f884ff.camel@pengutronix.de>
In-Reply-To: <b7604aa25a5d6746025fadeea42a7cc4b5f884ff.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d988bd63-08ab-45bd-c355-08d982290f1c
x-ms-traffictypediagnostic: AS8PR04MB8546:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB8546BFFBD2566FC3C44E9D868CA89@AS8PR04MB8546.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k3P6pbH0LMNnr/1i1va70L1ChEJ2G/nbHs8s31uWk23LvikSaBMaaCeCS2LfpEne0Nmg1rHAhH+PbMcVgH8oCaVKqEpNk2i6bBUCI27/z7Uk5z6urv3SSDbPvSVvpTaJ3nJ3/5jYuQJQgBIo+s3p27BpF+mi6jk1oSQ/k5TkWnmRueGvok8Tbw0P0FOhOdrdp3ymdgbsTTw7XlC8LPh2AXig0Opjx9u0aw/kW91e5QsxV60Ccu6kth0Zg7oG1NHJb6hpMtSE904kgaiEB3tWr90R2Nu3Bmw5GQ8t/1yldDZ1Ji4xa4feA8WFKJgLewFDJpIOxbXchttlkq9PlzZcg8ryAws4AEOSd1+0c1EjP7nFziqAflGyvgvNi7dlMFlD27mhwH8OVow40hjJbnW/daU9GvAfXfyTISYOVae9kCwi1aQR1xvrewRonL4PUPf6vE5OjgoY3bX7ZawW+z0l948xJ56D3NEwkAjjbsFz/PU0zOeObkIvkseKBSxJExEPMDNY/8KI6U2GVcxvTJwYKAR5yl/zbLZKkM6N1EXUzEXkEd0gzSl4z3dHg0AOPJbZctIZLtUhJyToSSOzmFSX/bQz83k+RbLPtRxjs8ewyos4wiB5TLctE+ueiPxQ1EmcOcQN9i4AdkmnHmWHdZhxLDWnBg9J2/vB4R5Imoze89OO282kBylqifAENS9tPsV9GekoXrVySIMaR+BgvjgkkuOp6j2mqy5IRI5b2PAfYKE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(53546011)(52536014)(9686003)(6506007)(55016002)(66946007)(4326008)(66476007)(66446008)(316002)(64756008)(66556008)(8676002)(2906002)(7416002)(7696005)(33656002)(38100700002)(122000001)(5660300002)(86362001)(110136005)(54906003)(26005)(186003)(83380400001)(71200400001)(38070700005)(508600001)(8936002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXhoOTdmbEVwYnZIZjBlaDlTaXd1Mm5Vc3IwMDVTcTZRTk5JZnhCK1pxazBG?=
 =?utf-8?B?djZETUFDN0NUZjhLMlFpcFhVRUFiY0ZwVFlMOXg1SEY3aGxLbktDRlU4WW5k?=
 =?utf-8?B?WDAySUx0Ti83YlhxdnZ5OFlMSUlBYWFCLzJkYnZtVy9KNWJFS1ZjRFFjT1JE?=
 =?utf-8?B?TCtvU0lhRVBCSmVOSnNYRUw3UlNjM3VCS2M3Z3M0UGZSVDA0OE1qTWt3ODh0?=
 =?utf-8?B?Uk5RY2gvVHdOeGZZMDQ3a2RKbXorT2tkaW5xMS9vMlg4Vm9NcXlDWUFkYkVv?=
 =?utf-8?B?VVhWdVovWmZRSEN1OFBwSGZqWlN2UUNvUkUrR3VsVnJpRnduSzJHMi9tODFu?=
 =?utf-8?B?aUpIM2MxTXV5enhsa0VtN3JISGRrai9VaktHdldCdXdmaFZZc25UakVrR1lH?=
 =?utf-8?B?MUNpdDZQRnh6TkVRU2YxZVBrZFZnUHhpZXRqbnBNV1JsT0RsYXZxc0hNWXQ0?=
 =?utf-8?B?bTk2UE1yb2h4dlRvS3p1bmNka09qQm5WVXFoanIyQ0pvQjBtWXN0cDhTcWty?=
 =?utf-8?B?N3JYYVFuVkR0bm1IcFc1bXV6Qm5nTGUwelprZDBJV05KdDllT3NMaDNaT1l5?=
 =?utf-8?B?dXFiZzg0UisxNXhFN3l3VTdSamxSUlJsYnVDUkZvZ2ZqL1k0d2dUTlF3dGZD?=
 =?utf-8?B?U0xIekZEcm5WUHUwUURCUVJmTGpObEhzNXFMUk0zOEtIYjFoMjFhV2VGMDBH?=
 =?utf-8?B?S002OHc0NHZhM042aC9mR2Nvay9xanE3VytaWDYrWW9oczk4aldYaGFMZTRp?=
 =?utf-8?B?MXhJVjVmRjU3aU9YcTZaNVp0RGpBa1RIZ3JDMEhkVDlJeUtpUmtETWZ3VEp1?=
 =?utf-8?B?NXZwV2ZFaGhzNUVTZWdmcXkyc1JCajlUZ0lJOE9LQnZIVHpCU0w4dHZ4aXZL?=
 =?utf-8?B?MWp5eHk3Z2I4RURUQjJtWjdQMkRqc3NXNWdFWitqZnNFYmdTY1k3VitOTDAx?=
 =?utf-8?B?WFVudHhrZlZ1aWplRzFjM0p3Q0k1UW1PQzRrNzBzaWkzL2hrN0tEVXM0NU9y?=
 =?utf-8?B?VFdnTGxEWkp5U05IUkdpV295YlVQQUZrLzY2ZWQxRHY5dkdvcGxTaTN0NXR0?=
 =?utf-8?B?dVJYM253QkpVd2NMaTRnb2oxdVppOE4vRDAweFA1QXVtOUN5WmhOTjFLaTRV?=
 =?utf-8?B?WVk5NEo5NmxNRXEybkVrd3ZSVGdaNHJ6T0tGWm5ZbHdOSVFTdy9yWC82QnVX?=
 =?utf-8?B?OCtiRjNJVTI4eThTdnNETlNEOVkrRmJXQjlDM1lSWHQwRHFjam95QUNvOFB1?=
 =?utf-8?B?ZjZBc1NySXUxSmxiakUyN0I2Z1BYcnRYa2YzbjVUSTArZnRFMy9BY1Mwa2ZZ?=
 =?utf-8?B?eXM0NGpCU0p4U1g0ZlA1VmFnR0o5a0M0OFdoUzhxMVFXMUVYLzlibXRjOC9Y?=
 =?utf-8?B?Y2d3SktHNEJ3aWp0L1prcXpNU2pmeXBJN3BYN3JpRmowUWJFMENDa2dnVS93?=
 =?utf-8?B?a3RPWVJxQyt0N2l1dUNCeU9oUEFQRGl3VHRVeitaLzVwQWdyVmtMbzV3bCtp?=
 =?utf-8?B?UTJVMnVrOTNpREhhQ2s5RW4ydU02YjRlL3pGVjV6UjNxeXFFVk9uT3krNE5o?=
 =?utf-8?B?WWdDT2ptRVA5QkFHYWxvNmJsckNXQWNvUHYrQVdWb1pJRm5jUEd6amlEOXZ5?=
 =?utf-8?B?WXN6NHZhWWczUDc2dXRTRm9LbkNPTGdwbE5ib0t5ditEcDhmaEI1SnV6UE03?=
 =?utf-8?B?aG45eHg3WkFKZHRxS2wySHJPbmY1emhBSVd2SFpLRUxseVc4S2VoZmZITWND?=
 =?utf-8?Q?g77ZrZiOI6zjdo/lNqWyUGj518gBuywrofsNMK4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d988bd63-08ab-45bd-c355-08d982290f1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2021 02:38:30.7184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RKJeFV15wUp9fMBWXmh+j+UwIxE7k+anjoRRip2/4VltCr3KQHvGWqzl32VISmMi47PzsQwDp2/hPknfID04CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8546
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogTW9uZGF5LCBTZXB0ZW1iZXIgMjcsIDIwMjEgNDoz
NSBQTQ0KPiBUbzogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsga2lzaG9uQHRp
LmNvbTsgdmtvdWxAa2VybmVsLm9yZzsNCj4gcm9iaEBrZXJuZWwub3JnOyBnYWxha0BrZXJuZWwu
Y3Jhc2hpbmcub3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnDQo+IENjOiBsaW51eC1waHlAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsN
Cj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDMvNF0gYXJtNjQ6IGR0czogaW14OG1tOiBhZGQg
dGhlIHBjaWUgcGh5IHN1cHBvcnQNCj4gDQo+IEFtIFNvbm50YWcsIGRlbSAyNi4wOS4yMDIxIHVt
IDE1OjM5ICswODAwIHNjaHJpZWIgUmljaGFyZCBaaHU6DQo+ID4gQWRkIHRoZSBQQ0llIFBIWSBz
dXBwb3J0IG9uIGlNWDhNTSBwbGF0Zm9ybXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNo
YXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1ldmsuZHRzaSB8ICA0ICsrKysNCj4gPiAgYXJjaC9h
cm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kgICAgIHwgMTIgKysrKysrKysrKysr
DQo+IA0KPiBUaGlzIHNob3VsZCBiZSBzcGxpdCBpbnRvIDIgcGF0Y2hlczogb25lIGZvciB0aGUg
U29DIGFuZCBvbmUgZm9yIHRoZSBFVksgYm9hcmQuDQo+IA0KW1JpY2hhcmQgWmh1XSBPa2F5LCB3
b3VsZCBzcGxpdCB0aGlzIHBhdGNoIGludG8gMiBwYXRjaGVzIGxhdGVyLiBUaGFua3MuDQoNCj4g
PiAgMiBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLWV2ay5kdHNpDQo+ID4gYi9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tZXZrLmR0c2kNCj4gPiBpbmRleCBl
MDMzZDAyNTdiNWEuLmU3ZjM5ODQzMzQ4NiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tZXZrLmR0c2kNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tZXZrLmR0c2kNCj4gPiBAQCAtMjg5LDYgKzI4OSwxMCBA
QCBwY2E2NDE2OiBncGlvQDIwIHsNCj4gPiAgCX07DQo+ID4gIH07DQo+ID4NCj4gPiArJnBjaWVf
cGh5IHsNCj4gPiArCXN0YXR1cyA9ICJva2F5IjsNCj4gPiArfTsNCj4gPiArDQo+ID4gICZzYWkz
IHsNCj4gPiAgCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ID4gIAlwaW5jdHJsLTAgPSA8
JnBpbmN0cmxfc2FpMz47DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2lteDhtbS5kdHNpDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9p
bXg4bW0uZHRzaQ0KPiA+IGluZGV4IGU3NjQ4YzNiODM5MC4uZGUyMzFkNTMxYmE0IDEwMDY0NA0K
PiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpDQo+ID4g
KysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kNCj4gPiBAQCAt
OTk4LDYgKzk5OCwxOCBAQCB1c2JtaXNjMjogdXNibWlzY0AzMmU1MDIwMCB7DQo+ID4gIAkJCQly
ZWcgPSA8MHgzMmU1MDIwMCAweDIwMD47DQo+ID4gIAkJCX07DQo+ID4NCj4gPiArCQkJcGNpZV9w
aHk6IHBjaWUtcGh5QDMyZjAwMDAwIHsNCj4gPiArCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDht
bS1wY2llLXBoeSI7DQo+ID4gKwkJCQlyZWcgPSA8MHgzMmYwMDAwMCAweDEwMDAwPjsNCj4gPiAr
CQkJCWNsb2NrcyA9IDwmY2xrIElNWDhNTV9DTEtfUENJRTFfUEhZPjsNCj4gPiArCQkJCWNsb2Nr
LW5hbWVzID0gInBoeSI7DQo+ID4gKwkJCQlhc3NpZ25lZC1jbG9ja3MgPSA8JmNsayBJTVg4TU1f
Q0xLX1BDSUUxX1BIWT47DQo+ID4gKwkJCQlhc3NpZ25lZC1jbG9jay1yYXRlcyA9IDwxMDAwMDAw
MDA+Ow0KPiA+ICsJCQkJYXNzaWduZWQtY2xvY2stcGFyZW50cyA9IDwmY2xrDQo+IElNWDhNTV9T
WVNfUExMMl8xMDBNPjsNCj4gPiArCQkJCSNwaHktY2VsbHMgPSA8MD47DQo+ID4gKwkJCQlmc2ws
cmVmY2xrLXBhZC1tb2RlID0gPDE+Ow0KPiANCj4gTW92ZSB0aGlzIHRvIHRoZSBib2FyZCBEVCwg
YXMgdGhlIHBhZCBtb2RlIGlzIGEgYm9hcmQgbGV2ZWwgZGVjaXNpb24uDQo+IEFsc28gdXNlIHRo
ZSBlbnVtIGluc3RlYWQgb2YgcmF3IHZhbHVlLg0KW1JpY2hhcmQgWmh1XSBHb3QgdGhhdCwgdGhh
bmtzLg0KPiANCj4gPiArCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ID4gKwkJCX07DQo+ID4g
IAkJfTsNCj4gPg0KPiA+ICAJCWRtYV9hcGJoOiBkbWEtY29udHJvbGxlckAzMzAwMDAwMCB7DQo+
IA0KDQo=
