Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D194205A2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 07:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbhJDFzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 01:55:36 -0400
Received: from mail-eopbgr60042.outbound.protection.outlook.com ([40.107.6.42]:6112
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232131AbhJDFzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 01:55:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DW8IL3JQClV/AsvuCL9ZmvuMC2bkSD9h3yskJxnp/SZb6dqOFLjaThDrousT7GXbUnZk2W3Iwl9Fed+jwgSFszK8KrX82SkSOE5EcAhU4CLjFqb7p25pwlomrfqbbrCrrSc+G42iBeegdrWcnamZtzmsFL0dGoHyYPLvbXX2502O6pCuIATwh/KqBJR+QJHvd0hc2W4gov8DbM9LLJv3jdnxh8qfmmz+ao0+LvH6Cx8QNNMflwyP1ZAPdWbTH2r4D3nxSu8ulbwMl5liNpMmB5UcJdNuPdA9cIfXulI1l7qof1kA6Ntt2lZtXI4lKyubDKQqq6tV887UZr3WKz53lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEAcsAxkEVClTGApMBgx7pDUR8cW6nxrmrWUOlA20Vc=;
 b=K05p9DnqtwmVfr9FnyKWYaC8NCk06D0uw+OzEpJ1uBi5QlHlgqE2N8z0bgexneZ7Uu/xIkzOGZ5QOLNIfeycGBqXse/KNj1VEg5jBzar2dqFgtIUsGAgelVRd8K5dWO04iAXlzG19WlrJzC22rC2tvCj3QUel4bF0XYHy8A8Zfja5F2IEWKyuiSjrDER6//poJfbPQ5YjaK6Cur8W195THrNlhS62zO99V21O/dNaRRSy/4R1o59E7V7JOO9adJRZgzsr4Zp+Rfmhb38NGTR9y3D6ddOuu2dkYsIY9YkkKma3asdvi+lMwHRl/MY65MjhtqAoAh4Noppph9yrtvI+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEAcsAxkEVClTGApMBgx7pDUR8cW6nxrmrWUOlA20Vc=;
 b=nM0b8Twri3M2WKNQ2o+KFnNtNyr2ZDEx1FAXP3KD96oXEeBk2Sk6B1KH1829QDD8aEVBI6YZ2lwrmXjQh17Y+MD7Pxw5d3mGLSLLPvw7FzPkKlv+jpDHsoJmsi4IrnvjMeTArBqIBOsqA9lLV0iecQ5cuAxlSVMeaWgUYiVAKKo=
Received: from AS8PR04MB8673.eurprd04.prod.outlook.com (2603:10a6:20b:428::9)
 by AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16; Mon, 4 Oct
 2021 05:53:45 +0000
Received: from AS8PR04MB8673.eurprd04.prod.outlook.com
 ([fe80::d4f7:fe6:3e65:3c55]) by AS8PR04MB8673.eurprd04.prod.outlook.com
 ([fe80::d4f7:fe6:3e65:3c55%7]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 05:53:45 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>
CC:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH v2 04/16] ARM: dts: ls1021a-qds: Add node for QSPI
 flash
Thread-Topic: [EXT] [PATCH v2 04/16] ARM: dts: ls1021a-qds: Add node for QSPI
 flash
Thread-Index: AQHXtlfopRpWy+oE2kOXPz/B4PLFIqu9mgdggAD5YICAA8ffoA==
Date:   Mon, 4 Oct 2021 05:53:45 +0000
Message-ID: <AS8PR04MB867338457BEBF8BB91163420E0AE9@AS8PR04MB8673.eurprd04.prod.outlook.com>
References: <20211001000417.15334-1-leoyang.li@nxp.com>
 <20211001000417.15334-5-leoyang.li@nxp.com>
 <AS8PR04MB86734729E9E08F70FF7E5AEEE0AB9@AS8PR04MB8673.eurprd04.prod.outlook.com>
 <CADRPPNTKsO7MYoUUXLgC+XnPPsrzjeBggvRnKvaB=3HUJy9-1A@mail.gmail.com>
In-Reply-To: <CADRPPNTKsO7MYoUUXLgC+XnPPsrzjeBggvRnKvaB=3HUJy9-1A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71bf19ca-696a-4dee-10df-08d986fb5411
x-ms-traffictypediagnostic: AS8PR04MB8946:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB8946C7499CA83146297753C0E0AE9@AS8PR04MB8946.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 399PNKkxmaW5IJPuS/TM7qnHjN9wNplB35Cy8VbyOgYwm5oF34/qADfNOH7icnd1Hdain+sbwg2fq/be4kXokYvrJsAOA1vw/WwUCjIluOGrbJ8mrQ6twwGYnevoHmKvWY/2q3VfFy4PBGQxCe3zjbcZf4RYriUfO9vTAkrLQfnfgEamB7M8p4H/5d+K0ThrG9/5xwk53XxsVR5v0CnkAQxdpT9EpAjLvct0vV54eHpkOdqFBNQ/cnGzkujEm95jZX//YDfOE2Gy4vgLOf73Cb8/WiLh2d6e1G+ciVeIn+wXKm5Y9/CwZf1fqSHVbmklG0HdhW0lcUJit7d9cgIxP/0M8arRY2RYAtIexiJPdv+tZ7SvhKE1rbLrrjrOhEHIck5uUCwpXiDhCu1kqOW26wDGL7P2fHRthWZ0URBIswXGbLWhIJ/uqVm+kl/h1EOr+UItluxFGcE1N7sfAMrfFSLFeS7zN4z8mQKFuzPSE6tOm6SxrhU5QxiuI2NQh+zjrRZF0udm+flHB1oK179vX5oufCaXgmpXVzbpiC97OsI90HXjmeJAgofZtVe1TAymxEtnf/elhxji6CNhv0DHko6G3/8qUmBFBj0YAvc1PYhOvZJ0QR4LrQRV/2ichOGssCzXCSd8uZTK/+i+kb9dLAjQNG+MCNvYMs9JgKYqC4KJ5zjs7+tH30XiVFM7Z7z+bUADf26YoJ0VEtW3ysNoSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8673.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(66446008)(55236004)(53546011)(508600001)(66476007)(186003)(76116006)(6636002)(6862004)(7696005)(64756008)(6506007)(316002)(54906003)(33656002)(5660300002)(8936002)(66556008)(52536014)(66946007)(26005)(38100700002)(71200400001)(8676002)(4326008)(44832011)(83380400001)(55016002)(9686003)(38070700005)(2906002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3Q3cDl5MWRPYUZtUHhyd0N0ZGtPMVAzejZHMm1lUnhRTVVOZzZYaHJmcGNE?=
 =?utf-8?B?a0x0WjNteWg1SE9vVXRXTkJQNmpSWjh1VUFIVnh0MFNqK0RuQnZ5VEd1L2lE?=
 =?utf-8?B?QStuU2d4YUQvU1k1N0VtRlNlR3BrTERnVDE0dGQvcmtLOWtBY0FUdnhIS3lF?=
 =?utf-8?B?b1k0cXl3ZmY1ZG5WbU15VFE3VlJLcDBHUDFSemhkUVcvRGFjbld4M2ZOeXdO?=
 =?utf-8?B?QzRvS3V3MElVaWtRMkpCM2QrV3BiRi9HdEEyTmt4Zm0xWWFyM3luM2tSbVM1?=
 =?utf-8?B?N25SeGRTSkxPUGpuQXM0U21yVWpFQjVtb2ZTVEFKM1ErQUJKMGwzeEt5VlVD?=
 =?utf-8?B?TEJvQjZGSzdPQXBadXEvZUhKYmx4ZUJSZ0NNWjR5R1Y1a1VLZVdEM08vQ2F3?=
 =?utf-8?B?RmVQNHZwS0NYckxYblNOdmxwbUFRbVhvczZwVUNTb3Q2T0xnOTQxOUFvWkhZ?=
 =?utf-8?B?Mlh0Q3hYZThxRTg4N016T1NpSVdyd0ZWSHRxVTlaaUNRdlVrbjRjOTB4NGl5?=
 =?utf-8?B?c1FxczJNNzlDVWljWEF3RVp6SXlhUWJSZGxVT2J4S1EzQnJkQW5XZ1FWNWJ1?=
 =?utf-8?B?d003emc3ZnNDZk95bHZuK21ZZElWVnJJR01tWHFmWitrT295N0Vwalg4enpp?=
 =?utf-8?B?SGJ3WkJyVWduVWY4NTFnanNWTjRlbFd6VW8xbzBVQXZVNWFMYXBSYW0xQm1L?=
 =?utf-8?B?ZFYrWGhBcEN3ZGFKTjJHTlUzdWtNSjZNaVh0bStlREM4VGpmY0VsNG1uKytk?=
 =?utf-8?B?NTJBNlp5TlloY3Q1ZVh4R0IrRVZTOW5mYkZ3bHV2T2pNRExua3BNcjVFVUFk?=
 =?utf-8?B?d044ZVloYUdYN3o4VjgyV2kydXB5Y0JENWZzRkRzWEFKUTN3ZlViSTZFYzlt?=
 =?utf-8?B?YVBwclBYUUNTMW9KYUg3WXJ6VWl3QmVRZnRseTFzVHJidGFiVFN2ekx0bG5v?=
 =?utf-8?B?cHRyeWRyaTNIdlM2WHJaM2h1ZHp1c2hjUkRMY0xNUHN6NEp3dmQ0NThldnZl?=
 =?utf-8?B?ZW9RZ25HN2I4UmNCQ2VIem5XUVc5dmZZczNUTW92UUk3VWhnays0aHFrT1ZE?=
 =?utf-8?B?K2JIdGVsb0Vmak05TVpTcFkwNWRrcy94Z3Z1Z0dIa29CU2U1STgwR3VtSmNp?=
 =?utf-8?B?V29QL0pkMkJzNis0c3FRMUs5R1BOWjRLRTdVM0gzaWx0NlNhN0lrK2R2UmNt?=
 =?utf-8?B?T0k0RkdZQk1uT3hsMHQxQ2ZDblBlMEVaeVQzMHkrZmpqRXhXRGs0VVd3UXM4?=
 =?utf-8?B?V014UGkxOU5WSHJVdlJHUEN0Q3c1aDNjNVM0U2xSSzZtWStzanJzTlpreEVw?=
 =?utf-8?B?cGh6WFdWWXI0N1JQNDY1cmFGcTA3aU9RZDh1aW9HWW9jaGVlTHREbzR1QTdT?=
 =?utf-8?B?bURYb0xDOHR3djE1ZWtTZlgwK0VaUlZhUE1sQU5pR3c1RFp4ZmwzdnBIYnp5?=
 =?utf-8?B?YUdXVTNsM3U1QlpFa0ZNRzZiNk5tWFAwSDFXRUpjVFZWNEdhODZ5SXQwZitU?=
 =?utf-8?B?MHcwZmZWcjdmUkxhYXl1TFg2Nzc2N0VwbUZ3VDFod0pCSEJIVmFQVmhxdVFQ?=
 =?utf-8?B?UDZETEJ4OVBwWmpRU1FOYVJoRGlRdUh1elh0VzZBREYwamhUdEgvSCtLNmxh?=
 =?utf-8?B?RmpLaDdOd1RuL1l3TnY2S29RNnl4WjRvcTAzT2FKVERDbFNMbDdiVy80c0Q0?=
 =?utf-8?B?d1hUZmQwYzNtMHNnZkFkWk91cUZyYWc3b2Y1K3pzY1RDYTlEc2JSWXVTOHdF?=
 =?utf-8?Q?W/ZR6iU4Vnju8rz3rvRZbzlDSax1Y5Xtg1idlRa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8673.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71bf19ca-696a-4dee-10df-08d986fb5411
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2021 05:53:45.3838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AzYZE0F/Eydenh6SKJAuo7SM1PwRik5nGfER7nmR5/fwO63Ku1iYzvTSHax7odZVQfS85YkB7k9BVwV18qgw6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8946
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaSBZYW5nIDxsZW95YW5nLmxp
QG54cC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBPY3RvYmVyIDIsIDIwMjEgMTozOCBBTQ0KPiBU
bzogS3VsZGVlcCBTaW5naCA8a3VsZGVlcC5zaW5naEBueHAuY29tPg0KPiBDYzogU2hhd24gR3Vv
IDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47
DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBPbGVrc2lqIFJlbXBlbCA8bGludXhAcmVt
cGVsLXByaXZhdC5kZT47IGxpbnV4LQ0KPiBhcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtFWFRdIFtQQVRD
SCB2MiAwNC8xNl0gQVJNOiBkdHM6IGxzMTAyMWEtcWRzOiBBZGQgbm9kZSBmb3INCj4gUVNQSSBm
bGFzaA0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBPbiBGcmksIE9jdCAxLCAyMDIx
IGF0IDEyOjMwIEFNIEt1bGRlZXAgU2luZ2ggPGt1bGRlZXAuc2luZ2hAbnhwLmNvbT4NCj4gd3Jv
dGU6DQo+ID4NCj4gPiBIaSBMZW8sDQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4gPiBGcm9tOiBMaSBZYW5nIDxsZW95YW5nLmxpQG54cC5jb20+DQo+ID4gPiBTZW50
OiBGcmlkYXksIE9jdG9iZXIgMSwgMjAyMSA1OjM0IEFNDQo+ID4gPiBUbzogU2hhd24gR3VvIDxz
aGF3bmd1b0BrZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcNCj4gPiA+IDxyb2JoK2R0QGtlcm5lbC5v
cmc+OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgT2xla3NpaiBSZW1wZWwNCj4gPiA+IDxs
aW51eEByZW1wZWwtcHJpdmF0LmRlPjsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOw0KPiA+ID4gbGludXgtIGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IENjOiBMZW8g
TGkgPGxlb3lhbmcubGlAbnhwLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFtFWFRdIFtQQVRDSCB2MiAw
NC8xNl0gQVJNOiBkdHM6IGxzMTAyMWEtcWRzOiBBZGQgbm9kZSBmb3INCj4gPiA+IFFTUEkgZmxh
c2gNCj4gPiA+DQo+ID4gPiBDYXV0aW9uOiBFWFQgRW1haWwNCj4gPiA+DQo+ID4gPiBBZGQgdGhl
IG1pc3Npbmcgbm9kZSBmb3IgcXNwaSBmbGFzaC4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBMaSBZYW5nIDxsZW95YW5nLmxpQG54cC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBhcmNoL2Fy
bS9ib290L2R0cy9sczEwMjFhLXFkcy5kdHMgfCAxNSArKysrKysrKysrKysrKysNCj4gPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQg
YS9hcmNoL2FybS9ib290L2R0cy9sczEwMjFhLXFkcy5kdHMNCj4gPiA+IGIvYXJjaC9hcm0vYm9v
dC9kdHMvbHMxMDIxYS1xZHMuZHRzDQo+ID4gPiBpbmRleCBlMmFhNTY5ZmY0MDQuLjUyMmUxZGM1
MTA1OSAxMDA2NDQNCj4gPiA+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2xzMTAyMWEtcWRzLmR0
cw0KPiA+ID4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvbHMxMDIxYS1xZHMuZHRzDQo+ID4gPiBA
QCAtMjg2LDYgKzI4NiwyMSBAQCB0YmkwOiB0YmktcGh5QDggew0KPiA+ID4gICAgICAgICB9Ow0K
PiA+ID4gIH07DQo+ID4gPg0KPiA+ID4gKyZxc3BpIHsNCj4gPiA+ICsgICAgICAgbnVtLWNzID0g
PDI+Ow0KPiA+DQo+ID4gUGxlYXNlIGRyb3AgIm51bS1jcyIgcHJvcGVydHkgYXMgaXQgaXMgbm90
IHVzZWQgYnkgcXNwaSBkcml2ZXIuDQo+ID4NCj4gPiA+ICsgICAgICAgc3RhdHVzID0gIm9rYXki
Ow0KPiA+ID4gKw0KPiA+ID4gKyAgICAgICBxZmxhc2gwOiBmbGFzaEAwIHsNCj4gPg0KPiA+IENh
biB3ZSBoYXZlIGZsYXNoIGNoaXAgbmFtZSBpbnN0ZWFkIG9mIHFmbGFzaD8NCj4gPiBUaGVyZSBp
cyBubyBoYXJkIHJlcXVpcmVtZW50LCBpdCB3aWxsIGhlbHAgaW4gYWxpZ25pbmcgbm9kZSBwcm9w
ZXJ0aWVzIHdpdGgNCj4gb3RoZXIgYm9hcmQgcHJvcGVydGllcyBzdWNoIGFzIExYMjE2MEEtUkRC
LCBMUzEwNDZBLVJEQiBldGMuDQo+IA0KPiBUaGFua3MgZm9yIHRoZSByZXZpZXcuICBJIGZpbmQg
dGhhdCB0aGVyZSBpcyBubyByZWZlcmVuY2UgdG8gdGhlIGxhYmVsIGF0IGFsbC4gIEkNCj4gZG9u
J3Qga25vdyB3aHkgd2UgYWRkZWQgaXQgaW4gdGhlIGZpcnN0IHBsYWNlLiAgUHJvYmFibHkgd2Ug
Y2FuIGp1c3QgcmVtb3ZlIGl0Pw0KDQpJIGJlbGlldmUgeWVzLCB0aG91Z2ggSSBoYXZlbid0IGNo
ZWNrZWQgaXQgYnV0IEkgdGhpbmsgaXQncyBzYWZlIHRvIHJlbW92ZSBsYWJlbCBhbmQga2VlcCBv
bmx5IGZsYXNoQDAuDQoNClJlZ2FyZHMNCkt1bGRlZXANCg==
