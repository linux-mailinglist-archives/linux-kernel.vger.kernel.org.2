Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1D03D21B6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 12:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhGVJZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:25:16 -0400
Received: from mail-eopbgr00042.outbound.protection.outlook.com ([40.107.0.42]:37061
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230410AbhGVJZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:25:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpNYYN9Io5tb9tN0EmD62MJI6PIOq+3P3jaT12CcvETADWCPrPZrGPHDDRxqdqorv0QV9WLQONWFvx90a/qInyxKPJcKWMeCk4GoNFnBMLgxhnoQqhsfYiBATQ0ia88CWT2f1z/AnVlOm5aHUwE4GiZTblWUXsOIx9QFNJrRJJSMahQoQsgq2pkUQFWHmdTpHyc5eRZwS2eNcLQItthOc2zxEvw/fkhEUexjYQ6klvSUYMlFFGx1uUzeTIJdMxi4hQey2YvZ7epf1AaEurQZsiqHTw/Qi5FidHrkD1A+gQ0nbHSSapjaqtLSC2YkA9sim1bjQnJB96aOC2CCueCygA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npjIR798jFw7Nt4qpyu8l+kKcKvS9xPEcLBtxDZXl3I=;
 b=DVMIylTpTYEv7EwC1nsSx+UIfI80+JpYCD7jUCol41F0mSpO2M7bNJEqTe4bCM8C458Uxb0IyUsGwVJhB1Y66ZAlKCYEQhcW9mn7oPZh3nkt3uT4z3KKjrdVU+XkBdeoWjY+wvxaA9mSpSdBLQhdyA7mZ7vtfaXw2IwgtxusdAQWlZE1R2guZ0YaN2NsRdizVZfySpDU4WjYc0rrzv31N6JghIndZg1IkG22nt0sP7dXroYxnvlmTsCH5Urk8sU4jnoddtLmsXQECRYk63fRSV2im0W0fO/xXevPgc+OwYB7w3h/MnDatSwl7sQOfvNYyOEZta6mkcQ5Hs0S0Ta5tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npjIR798jFw7Nt4qpyu8l+kKcKvS9xPEcLBtxDZXl3I=;
 b=PMsJPKuFw/+hmvOiu0XPCxxdxttWpc9aBa1uZp3STbkSHAwN7T9rg3DvVXM7Bjw27HNQs+/DAeMON/RAJ5QM0A9Zq0wixr6C72gA1gMCX05T1kawYJREmjoMN/hWSLmjLadExYkJpsZwlpNr4z1MOGVs06tBhnCMVvHyQihSnKo=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB6PR0401MB2326.eurprd04.prod.outlook.com (2603:10a6:4:47::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Thu, 22 Jul
 2021 10:05:48 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9c70:fd2f:f676:4802]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9c70:fd2f:f676:4802%9]) with mapi id 15.20.4352.026; Thu, 22 Jul 2021
 10:05:48 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
CC:     "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 08/15] MAINTAINERS: update fsl,fec.yaml reference
Thread-Topic: [PATCH 08/15] MAINTAINERS: update fsl,fec.yaml reference
Thread-Index: AQHXfuBkFPuboYLQak2/cQsgadm+vKtOw5kg
Date:   Thu, 22 Jul 2021 10:05:47 +0000
Message-ID: <DB8PR04MB6795128D2C50CBEFB4A718A2E6E49@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <cover.1626947923.git.mchehab+huawei@kernel.org>
 <3df6b6353f49dfe6fe76a0d62b504ce4744e80f0.1626947923.git.mchehab+huawei@kernel.org>
In-Reply-To: <3df6b6353f49dfe6fe76a0d62b504ce4744e80f0.1626947923.git.mchehab+huawei@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2857c14-ed5d-456e-58fb-08d94cf8474b
x-ms-traffictypediagnostic: DB6PR0401MB2326:
x-microsoft-antispam-prvs: <DB6PR0401MB2326D63650F92CAAAC7B7119E6E49@DB6PR0401MB2326.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:635;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7MyzvjdvQeaDFjhI5L9fcT5g2QsvD6MjtSkOrpfgRwpY1TPJTFThgiuEX+ZD1rtYPcJlvPZkrXIQ0BbHMWQmRv35ctEH+4YkAdoUg73Q9T91usZFWpE/GPBibFdk/iegamLqRFqdFGYSHBPBfmm4R05/m0jloulpfmoymndYla7j+4qyLPqg8Z8JLS00G0Kza2Wjl0CJbXeJau7pKxgTtqFME6maJdqKndL0n6FAP6gxW3K2lA+BMWgIcoCBOTWFHCsgszipe7s2aLrKx1oR0iiNUQDp4W+ed74tf4UrfLm4wL9v506HlPvom/xz771N+5SJqYH5CgnHgEDYz91CJ1BLThxYRKY1w/qT22VJj3raBCqrv+pqJdcCJsYcSSDUntH6UTUv+9C2UpMUxIl2AUFN7h2ymMx54t3ax+8ckbtMO+gQiv+knv3BDb2PJ3gvnBq2oH/bCiVzeFTIqBvnKzHGwPcUMo5RZd3RpxSSZA68hySPP/TWkT9s4oKHoZP/oYp9KvE0tfpmV/cZ4f834PCBfQ+0mT70xIrJKbwCIyT9Wg7QIrF9/wYMdb3Azl297PEVgAzgTZjDZYXDhLO4liGDFoGUvDS9JjXXzoekUmuJObhHgkjbARFaRo5cgeRxX/HlcJ4Lw31O8QdwHdgJx7QuRlS0eo7cwFQrzR5e0Yj74gaNBtQz3Ix/7SCz8560hl/UfcPR9f+FFDh0hXwfEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(5660300002)(52536014)(66476007)(2906002)(122000001)(83380400001)(6506007)(71200400001)(33656002)(66946007)(86362001)(26005)(64756008)(66446008)(38100700002)(316002)(66556008)(8676002)(8936002)(54906003)(110136005)(76116006)(4326008)(53546011)(15650500001)(9686003)(7696005)(478600001)(55016002)(186003)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WWFEeE90NmpBQUF0K0dYc3owOU8vUU9OdDZjNkhnVm90em9hK01oSVA2Sk9i?=
 =?gb2312?B?TmdqNzIyNVZITlFPRXE2eEFBY3dKRWxUTzZueUp1RDZwNzFmZll5OHBlUlU4?=
 =?gb2312?B?R09penZLVDZSVDRHYjRHUjA2VmhRdFFLMXREenRDMjFWc0IwVXlIRFY1WldG?=
 =?gb2312?B?T1RZd01zbVJ0RkpqdHowdVRIT2dxem1WMXFaYlBzMFVhMHl2YXdiS1EyY1hk?=
 =?gb2312?B?OG9SMXF3V2RmcCtibHBJTGdKZXk1djBHQXNsclU4RHlPOTgyeGErcU53Uy9n?=
 =?gb2312?B?dHdPV3JLaU9jWEpxS0ZVV1FOS0JlUnpmSTdhSHc3dHhuY2NxZXFYbnp5Ymxq?=
 =?gb2312?B?Ky9nM1V0UFowQzRFSHpEd2p1ajBVdzZDdFpvay9NTDVjZnQ0aVkvKzFxcE1K?=
 =?gb2312?B?OXdzV3l1RTJUcGVBVUVQWnZYeUgxN0xhVUlXOFNwUHJ2L0dndDFVWUlsSXIz?=
 =?gb2312?B?dUo4V1F3Q2QvOWtDeWtnNVdWTzliOXJOSnhpalppMVp0aVo5L2ROeG9md3dY?=
 =?gb2312?B?YmF6bG5Gbk1GTWN2V2ZLV0hZY3c4clRnbFBSek5DMkt4U1YwaDVGVnVuT2lB?=
 =?gb2312?B?dTJJeDlGMnlBTFdYc3dvc3BOUDRiZitwYm1hbzhpaWtmK1FXZG0zWXVEU1Z0?=
 =?gb2312?B?R0RqN2dleit5SWdtTzlTaitFcExlVTZYMGZHVGhrNHUyTEV1Y2JhZzMwKzJ4?=
 =?gb2312?B?K21OSGhNbVNSQzF0TGFVQlhsQnIwZ2V2cktnS0hFVVk4SXF0aUZzMnBJSTY5?=
 =?gb2312?B?cFBId0JnZWpGVTNzTUpJMDNjREZDWHZveDB1VC9hM2kwVkRFY0NYQ1ZFQzRj?=
 =?gb2312?B?dDIyeHlUYTZKNDRSWFlUTzJHMkl5Q1hMUkUyZy9kcXB0Y09zUTQ4aTZmWENs?=
 =?gb2312?B?TWRZT0dpbnBjZ3NxWDNXV2tzMG1aWUJtdGcyOU16TkFGZHM3L21rWGhOMXJG?=
 =?gb2312?B?RG4rZUxPcFFLK0krN1pqbzRHV1Z1MGpIV0Z6Vmo1U2xXV1lyNlBkQko1K2Zs?=
 =?gb2312?B?QXU4MmluUndWNlhaeVpsY0dmQmExSmJpVHlBZ3IrRHd5ZEkxV0Y5K1JleEJw?=
 =?gb2312?B?QmwzSFlTUzFUWXdKOTJUa3N1Y0NiUENSd053Y0x5eGp1bzBGWG9ob2pOTXZy?=
 =?gb2312?B?VnNNNmNiTzhmS3drOEhsUVFmOXh4RHhVMVR0SS82SGF5VVdTYkM3NFhmS0U0?=
 =?gb2312?B?OStMbEFzOWwrdFpHK1kwVDhELzFGYzcxVEF1THFUUEEvQTVtbnRsMWZjQll4?=
 =?gb2312?B?WWgzc3U3K3VIR2k0eC9tMVVaaWx4Sk56a2J0MEFnZjUyU1htUXdTVkwxWFpX?=
 =?gb2312?B?SFlOYW1iNlJma0hXTTBJbkkrcjB1VnVjT2U2VVgxQlo5eU9RdklLamxnM2Jk?=
 =?gb2312?B?YUdKOEZXV08yTzFjTHpQYU5vZU8rQTIvN2NRL2xRaXc4d3V6ZzRCdzgwbXBo?=
 =?gb2312?B?aGErWXRVTzg5dDNySUxJUUdHSmdMVS9FOFY4Z0w5ODdWZDUwMjNHdlZKeW9V?=
 =?gb2312?B?czFWM2VFZG1VVWNINXovdUtJVkVvY29BY202dVdWcUdjU3FFZkg2dHhLU205?=
 =?gb2312?B?eTRHT3l4RG1pK0dhS0xwQ25KT0ZmOWNvZ3NUWiswYi9ObGR4Z2F1a1dSWmV3?=
 =?gb2312?B?NE10T0lqeWErOG5PdlMvNmJlRHBqb1NsOUdBU1I0ZjZwazBLUlpUN3dxaUxs?=
 =?gb2312?B?OWc3UUZCS0MvQVZEc2QxdHFrZEdPYWw2cWtDLytEY3ZYcDJ1TVp5L0k5SmRh?=
 =?gb2312?Q?NdjsjA7zTrhaYUPbYU=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2857c14-ed5d-456e-58fb-08d94cf8474b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2021 10:05:47.9853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jNCTEJiOmK9bSiKxoJzgiRaEDnfjlXi5kyiQHMTjdnA4m6srS4kmKX6rT/LoU2J/R+b5UNWKqYuVvTNyKrLMNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2326
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hdXJvIENhcnZhbGhvIENo
ZWhhYiA8bWNoZWhhYkBrZXJuZWwub3JnPiBPbiBCZWhhbGYgT2YgTWF1cm8NCj4gQ2FydmFsaG8g
Q2hlaGFiDQo+IFNlbnQ6IDIwMjHE6jfUwjIyyNUgMTg6MDANCj4gVG86IExpbnV4IERvYyBNYWls
aW5nIExpc3QgPGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc+DQo+IENjOiBNYXVybyBDYXJ2YWxo
byBDaGVoYWIgPG1jaGVoYWIraHVhd2VpQGtlcm5lbC5vcmc+OyBEYXZpZCBTLiBNaWxsZXINCj4g
PGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBKb25hdGhhbiBDb3JiZXQgPGNvcmJldEBsd24ubmV0Pjsg
Sm9ha2ltIFpoYW5nDQo+IDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT47IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIIDA4LzE1XSBNQUlOVEFJTkVSUzogdXBk
YXRlIGZzbCxmZWMueWFtbCByZWZlcmVuY2UNCj4gDQo+IENoYW5nZXNldCA5NmU0NzgxYjNkOTMg
KCJkdC1iaW5kaW5nczogbmV0OiBmZWM6IGNvbnZlcnQgZnNsLCpmZWMgYmluZGluZ3MgdG8NCj4g
eWFtbCIpDQo+IHJlbmFtZWQ6IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQv
ZnNsLWZlYy50eHQNCj4gdG86IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQv
ZnNsLGZlYy55YW1sLg0KPiANCj4gVXBkYXRlIGl0cyBjcm9zcy1yZWZlcmVuY2UgYWNjb3JkaW5n
bHkuDQo+IA0KPiBGaXhlczogOTZlNDc4MWIzZDkzICgiZHQtYmluZGluZ3M6IG5ldDogZmVjOiBj
b252ZXJ0IGZzbCwqZmVjIGJpbmRpbmdzIHRvIHlhbWwiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBNYXVy
byBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWIraHVhd2VpQGtlcm5lbC5vcmc+DQo+IC0tLQ0KVGhh
bmtzLg0KDQpSZXZpZXdlZC1ieTogSm9ha2ltIFpoYW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNv
bT4NCg0KQmVzdCBSZWdhcmRzLA0KSm9ha2ltIFpoYW5nDQo+ICBNQUlOVEFJTkVSUyB8IDIgKy0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4gaW5kZXggYjkzMzlkNGM4
YTE3Li45MmJlNjhlM2VmYjUgMTAwNjQ0DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+ICsrKyBiL01B
SU5UQUlORVJTDQo+IEBAIC03MzY1LDcgKzczNjUsNyBAQCBGUkVFU0NBTEUgSU1YIC8gTVhDIEZF
QyBEUklWRVINCj4gIE06CUpvYWtpbSBaaGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+DQo+
ICBMOgluZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+ICBTOglNYWludGFpbmVkDQo+IC1GOglEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2ZzbC1mZWMudHh0DQo+ICtGOglEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2ZzbCxmZWMueWFtbA0KPiAgRjoJZHJp
dmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlYy5oDQo+ICBGOglkcml2ZXJzL25ldC9ldGhl
cm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYw0KPiAgRjoJZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJl
ZXNjYWxlL2ZlY19wdHAuYw0KPiAtLQ0KPiAyLjMxLjENCg0K
