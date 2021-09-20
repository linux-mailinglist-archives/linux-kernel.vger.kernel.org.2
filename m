Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E7F4117A1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbhITOyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:54:51 -0400
Received: from mail-eopbgr30120.outbound.protection.outlook.com ([40.107.3.120]:40101
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233972AbhITOyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:54:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9bYG5rLi2/ud+kToHeC/SPBehbfrTwGfSWwX5vSd6qzzZBTxjbKp7+BtWOYDRgsCkChwr6iOYhP3Xk3xpSvD4PMRpEpUhprIQYRiTxSSnLaLsIzu0jWX4k6ufuPBXwtMBqFsaD65s2AGlFJm4VyC5VKdWctZV70cQux1rnXnj60HCWE15qC/vA/XPUpUkIvl9F/8isqrTQNGFeVsfJs9gIFWn+nmBfGNGxM8b2OV9RlCJfmhzMQNiznOFyPvGxeSp20F0ydPmTe2UHifNJ9p+h14fsvaW4MM5eAJ3yCwHUSaMiu6ShH+TlsF+Tp2di1OccHwWl9/nqZVE16FkN6Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=uda2zQdUBHpiWS4O0jGQ1lxmUbP3K5e3oCA5unnL/eQ=;
 b=YKX62e4LtWrg4hlgXEzw1q+eTbqrQsbHfxMi0MfAsYWJ5exwdjrfObf4ovmSg+yxkWuys4IKkfKcfRNU04ogkzpIvtYEAplumBdAGx4XwuTkSQ9HrN834sbCLUWU5EBYuiWY12njE0S42aAhqrAXfKwA/YI8kiCAmM2EYfz0jErxWztAFRJjVWPZmUmuv3x5op4fLmqIRQveoP2w2pkPGdUgJpcShNGy4iHoFoqAzZsXtQVTAwdfEJzh545jmMNdIcpa9xj0qYm5izBrb2Onfez7/7Tt+oylYhz5AbqKbHv+BfYk5/pfDgWCZNoHaCj4i8kB5hv+yxRnXJiMwboOWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uda2zQdUBHpiWS4O0jGQ1lxmUbP3K5e3oCA5unnL/eQ=;
 b=GAqaB/RBTMs1e4fa1lzt+BQdTT4F6ZDM8ASUnvG+55nEVOlUFSdvkqGqKtwRXDUJetuqi2JKHCGTJxfJeZRzaeFrmf6R+Zbt+u3QoEmrS6jnfMEftLskopJpycQqGg+SaW2y2fYZDm+3xMOp+b/C91JWRt6JsZ4NbBkbuih4jZ8=
Received: from DB7PR05MB5431.eurprd05.prod.outlook.com (2603:10a6:10:55::32)
 by DB9PR05MB8492.eurprd05.prod.outlook.com (2603:10a6:10:268::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.15; Mon, 20 Sep
 2021 14:53:21 +0000
Received: from DB7PR05MB5431.eurprd05.prod.outlook.com
 ([fe80::8f4:9f42:ea10:e8e7]) by DB7PR05MB5431.eurprd05.prod.outlook.com
 ([fe80::8f4:9f42:ea10:e8e7%3]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 14:53:21 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "s.riedmueller@phytec.de" <s.riedmueller@phytec.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 7/9] dt-bindings: arm: fsl: clean-up all toradex
 boards/modules
Thread-Topic: [PATCH v3 7/9] dt-bindings: arm: fsl: clean-up all toradex
 boards/modules
Thread-Index: AQHXrVW9e2MDMcKR106AO96H4s3tzKus22aAgAAocIA=
Date:   Mon, 20 Sep 2021 14:53:21 +0000
Message-ID: <025a9fe31eab5a8b5f02a9f1c7979c1e0c1691c6.camel@toradex.com>
References: <20210919125536.117743-1-marcel@ziswiler.com>
         <20210919125536.117743-8-marcel@ziswiler.com>
         <1632140917.871356.4136126.nullmailer@robh.at.kernel.org>
In-Reply-To: <1632140917.871356.4136126.nullmailer@robh.at.kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=toradex.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 067709eb-71e2-4598-e27d-08d97c46641c
x-ms-traffictypediagnostic: DB9PR05MB8492:
x-microsoft-antispam-prvs: <DB9PR05MB84924CFFE71A55ABD8A1332CFBA09@DB9PR05MB8492.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:773;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qjYLVZ82Lf8CQLWoUu0kANAqBPxsdK3XGq2LOcZvOi1wxKtyYvCSZKC3uhcL+ZDGUvByXZK/lIqMGThAuonIpMiY0fECJNNrK2Sy39ImOBu/gAJbvB3EizJVNABf3WXm+pLnWDwJIYY5WX9i6bEmskmx/qBUO0cPkojCsohMgXzdf9OC0qXoAFd4W6tcz6U/TGuSLP3rxIVV3EJVoDon4Vr6AkCiSP4KunPV80QzCablQFdNmEL6RHyTJRrTZiXGHjxuLuWI7Ej39JMDY4pGjpD9WwpjTjph5Pjrh9JTtrNEFmh1bwU9Cbg8RhwCRW10j0HlQ3Eshe2G2zNeunDWKydaL7Ht3UhLEtrQGk0g1rMTaZnbRC6OE0NwQBLYz/bv4nnT0uXS86mBtpOwPnoz7aRH+Z4h1l/RL275+tM2T3o2rK9pi5jVvnOx4Mz22B+jSm03s3uUdjWho67+ElbvOuXyGiCrhyGNBAAVj+xb/8BsP7hWN2nRSDK3RbbOZgqSI4F1lgUclQ/wGO+Zcv/ecPYAA3uCyaRs4KkKdgEsPdkptf7Qt0BMS/RD/7vkIvPuEMZk7Q0UdY47IZG6OzNb2Qc40wIemokB9JyWZ+/ZkQu/LtuGCeIyRKqha2OyUqX6xqqW9pbdYQKd5FbKCnxpYajXK/1voGelOM8uGMt/LpfnmFBvCg4iiOkH0F2rfsvkeCVzsN+2twVraibMyGw0qXEId7RN+ZjbVoZuEJGZ+M3WWPefeBFIEs8NfLPqMzfldmeGj1Oec6ZTl4sqYc/JSJuHbGUAjNtdqrbrdmnC6QI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR05MB5431.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39850400004)(366004)(71200400001)(38100700002)(38070700005)(8676002)(64756008)(66556008)(26005)(4326008)(186003)(8936002)(6512007)(966005)(2616005)(508600001)(44832011)(6486002)(83380400001)(2906002)(6506007)(122000001)(76116006)(36756003)(66476007)(91956017)(66446008)(6916009)(54906003)(7416002)(66946007)(316002)(86362001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3dVTkZuV1h1RUZ4enNJc09aQVJXSnExYVh4S1RMTzNkWWZVUFljVlM5ZTFn?=
 =?utf-8?B?MVh5YTJmTHJ1UFJMWlVzMDdOd0ZmSEJQOFZjNnJma2hIcG9BZ1J2RUpldkow?=
 =?utf-8?B?VS9IRXMxZ0t4MGNBUkFyUGZvSEZVMnJhQzZYbHlxNzR2Q1VYbmUzZGN5dy9Y?=
 =?utf-8?B?dTZNc29tTUR5SmxpSi9BR2VXSk1JUWYwSDRvNDRBdzZMakxZdXhidm9zNjZr?=
 =?utf-8?B?Y1VZMVJXQWFxb1hmbEdGSW5IN0VXR0pqWmRhdE5aM1hYVjkvMmUzNjlwL2pK?=
 =?utf-8?B?aG5xMWNZVDl4UWhEWk1xRGVQUjUxaWJZMmFrUVphWVdQcGhKM1NjRGRVUXdQ?=
 =?utf-8?B?T0hQUkU5N2NkZmVBbytTRGtIV0wwVU0rSFhPbEFucWVFaUczQ2psbzYreEdr?=
 =?utf-8?B?elQrS0tCMmlDUCtiZ0YvaWZEdGVsdEJONFJQN0RvaXBabklBeW41WTZLaFFr?=
 =?utf-8?B?QXREZ25sakh6MWx5eUVlUlltRkhTT0lEbllKMzVHbzgyOUJiREdPNzNKYWwv?=
 =?utf-8?B?UWcreG02V0E5WHVwOWUrM2d1WHZxd3lzRHZjMDNHQlNhYzFHUTNnT0JrUldi?=
 =?utf-8?B?UnhrMWFvcWJkc3pGR0FhdXNKazJGeEluMEVCSE9sWDkyQm1QMzZqNFVIN2NU?=
 =?utf-8?B?Y1A2SnRMd2tIUG40M3UrbGJUamdSWlM2dXB5TktOVEd5c2E1Ky9IRWF5blNl?=
 =?utf-8?B?Y3VIMUxJMXMzYTlETTVaR21mbVJPdCs1bW9lOUNwL2o3bDVOamw3dHRkYVBL?=
 =?utf-8?B?ZnBOclBUeTl6UGxtN20wSjNDVDRWMjJqU1FsTkhFRlRWak9OWEVqRzhaRXRY?=
 =?utf-8?B?a0JybGlrdi9SakxuWmhJRkJnZnNKK2dqQzNGSlZDN1FhU0gzQVdvakQzbC8v?=
 =?utf-8?B?bkR0RDFpWXpEajlDRXJGQVJmRjZJYUVMRk81Mkd2Yy8yYUkxeHBmeUp0VFNs?=
 =?utf-8?B?bjAxQnhXNjdING5Rb2lpOGwzUTZqN0oxYjBVSnZVSEdaSTBYbFhIOUpZQ3U1?=
 =?utf-8?B?VnNYZ1dNZzZNazJGYk90U0kzTXg4eDVTWkVnMmtHT0pETlpNQS9qUk9wYmd6?=
 =?utf-8?B?NkVndmFRbXBvZDdwOG8rclI2elFNLzl6eW42QnhLRG9CVnJCZVcvT2Jmcmk4?=
 =?utf-8?B?VGRFck4zRUo0VlpmY1FCVFhGeDYvaUFXQ2YxcERJOUF0Qk1JekxOZUZYMWR3?=
 =?utf-8?B?MHN5dzJRYjZCR1YxbUZWRENlU1cvMSttMmFlc24yUUo4SHZHdEU2YjVlRGFt?=
 =?utf-8?B?TWpYcmI2czZPQXlvL25PN0JmT3FVb010VkJOQkNXOEdabGVBSVBjcXhCaElY?=
 =?utf-8?B?dXl4TmM4K3dmVWQwWDZnYTRHN25ZbzkyaE5TYURycDNiczJCSFlOcVpReXNV?=
 =?utf-8?B?WmVOZjdGZy80cUxqMmZqUml1SWJuOUxxSTlNVm5Ha0pUSFBGZWtWRlhmVWlG?=
 =?utf-8?B?cEFZUzZKRVdDV1grdlpSeTFZTnc1SVY5VDMzejRUV0dmZU1tQXBRMTgrbHAv?=
 =?utf-8?B?aFR4UUEyNjl6V3NKYmFVUXd1MTVScHZWWmZub1pEUmxBam1qb0NBeDlIeUYx?=
 =?utf-8?B?UlIzZFFSd0NSV1k4SFRrZndpeVVsVG1iV3VKY1d1ZFZCWFI4WWxTWmlaVlVP?=
 =?utf-8?B?VVBveFQzWFpnR2czTWZjNVUwRUhZN2dhdFA0TDFHRXBCemNWOEM0NXJqTHB0?=
 =?utf-8?B?ZnAvdnovajdtd2dMSXpDZDU4ZnlDU0g3bXdjNExvUHVBbnViODkwbGZhRE9X?=
 =?utf-8?B?Tjk4dFJZdGtaNXRIOFMrOUNQRTA2a0YzOEpQaGlISGh2MjBrTFEwbG5FN1hz?=
 =?utf-8?B?bHl5SkJ1UWJzc1dlTDVWZz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A63672018D1F9439A09274B3530CE2C@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR05MB5431.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 067709eb-71e2-4598-e27d-08d97c46641c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2021 14:53:21.7935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8SgWdsC4Kh3bjKFBWCW85eK3hlD6c15WDNbzsSEuN4fDvQ1XLK8lNJ42npp8swdcFP94ut0W3eW3FByektDXlHpKQI6WcKjN+P7FqiuU3KI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR05MB8492
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTA5LTIwIGF0IDA3OjI4IC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gU3VuLCAxOSBTZXAgMjAyMSAxNDo1NTozNCArMDIwMCwgTWFyY2VsIFppc3dpbGVyIHdyb3Rl
Og0KPiA+IEZyb206IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29t
Pg0KPiA+IA0KPiA+IFNpbXBsaWZ5IGFuZCB1bmlmeSB0aGUgZGlzdGluY3Rpb24gYmV0d2VlbiBt
b2R1bGVzIGFuZCBjYXJyaWVyIGJvYXJkcy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXJj
ZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCj4gPiBBY2tlZC1ieTog
Um9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCj4gPiBSZXZpZXdlZC1ieTogRmFiaW8gRXN0
ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPiA+IA0KPiA+IC0tLQ0KPiA+IA0KPiA+IENoYW5n
ZXMgaW4gdjM6DQo+ID4gLSBBZGQgRmFiaW8ncyByZXZpZXdlZC1ieS4gVGhhbmtzIQ0KPiA+IC0g
QWRkIFJvYidzIGFjay4gVGhhbmtzIQ0KPiA+IA0KPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gLSBO
ZXcgcGF0Y2ggY2xlYW5pbmctdXAgZHQtYmluZGluZ3MgZG9jdW1lbnRhdGlvbi4NCj4gPiANCj4g
PiDCoC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbMKgwqDCoMKgwqDCoMKgwqDC
oCB8IDc5ICsrKysrKysrKystLS0tLS0tLS0NCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA0MSBpbnNl
cnRpb25zKCspLCAzOCBkZWxldGlvbnMoLSkNCj4gPiANCj4gDQo+IE15IGJvdCBmb3VuZCBlcnJv
cnMgcnVubmluZyAnbWFrZSBEVF9DSEVDS0VSX0ZMQUdTPS1tIGR0X2JpbmRpbmdfY2hlY2snDQo+
IG9uIHlvdXIgcGF0Y2ggKERUX0NIRUNLRVJfRkxBR1MgaXMgbmV3IGluIHY1LjEzKToNCj4gDQo+
IHlhbWxsaW50IHdhcm5pbmdzL2Vycm9yczoNCj4gLi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvYXJtL2ZzbC55YW1sOjQ3NToxMTE6IFt3YXJuaW5nXSBsaW5lIHRvbyBsb25nICgx
MTMgPiAxMTAgY2hhcmFjdGVycykNCj4gKGxpbmUtbGVuZ3RoKQ0KPiAuL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnNsLnlhbWw6NjEyOjExMTogW3dhcm5pbmddIGxpbmUg
dG9vIGxvbmcgKDExMyA+IDExMCBjaGFyYWN0ZXJzKQ0KPiAobGluZS1sZW5ndGgpDQo+IA0KPiBk
dHNjaGVtYS9kdGMgd2FybmluZ3MvZXJyb3JzOg0KPiANCj4gZG9jIHJlZmVyZW5jZSBlcnJvcnMg
KG1ha2UgcmVmY2hlY2tkb2NzKToNCj4gDQo+IFNlZSBodHRwczovL3BhdGNod29yay5vemxhYnMu
b3JnL3BhdGNoLzE1Mjk4MzMNCj4gDQo+IFRoaXMgY2hlY2sgY2FuIGZhaWwgaWYgdGhlcmUgYXJl
IGFueSBkZXBlbmRlbmNpZXMuIFRoZSBiYXNlIGZvciBhIHBhdGNoDQo+IHNlcmllcyBpcyBnZW5l
cmFsbHkgdGhlIG1vc3QgcmVjZW50IHJjMS4NCj4gDQo+IElmIHlvdSBhbHJlYWR5IHJhbiAnbWFr
ZSBkdF9iaW5kaW5nX2NoZWNrJyBhbmQgZGlkbid0IHNlZSB0aGUgYWJvdmUNCj4gZXJyb3Iocyks
IHRoZW4gbWFrZSBzdXJlICd5YW1sbGludCcgaXMgaW5zdGFsbGVkIGFuZCBkdC1zY2hlbWEgaXMg
dXAgdG8NCj4gZGF0ZToNCj4gDQo+IHBpcDMgaW5zdGFsbCBkdHNjaGVtYSAtLXVwZ3JhZGUNCg0K
QWZ0ZXIgc3VibWl0dGluZyB0aGUgZml4ZWQgVjQgSSB3ZW50IGJhY2sgdG8gbXkgVjMgYnJhbmNo
IGFuZCBub3cgaXQgc3VkZGVubHkgc2hvd3MgaXQgcHJvcGVybHkuIEkgZ3Vlc3MsDQpzb21ldGhp
bmcgZ290IHN0dWNrIHNvbWV3aGVyZSAoOy1wKS4NCg0K4qyiW3ppbUB0b29sYm94IGxpbnV4LW5l
eHQuZ2l0XSQgbWFrZSBPPS4uLy4uL0J1aWxkcy9saW51eC1hcm0tbmV4dC1pbXhfdjZfdjcvIERU
X0NIRUNLRVJfRkxBR1M9LW0NCkRUX1NDSEVNQV9GSUxFUz1Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvYXJtL2ZzbC55YW1sIGR0X2JpbmRpbmdfY2hlY2sNCm1ha2VbMV06IEVudGVy
aW5nIGRpcmVjdG9yeSAnL3Zhci9ob21lL3ppbS9CdWlsZHMvbGludXgtYXJtLW5leHQtaW14X3Y2
X3Y3Jw0KICBMSU5UICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncw0KL3Zhci9o
b21lL3ppbS9Tb3VyY2VzL2xpbnV4LW5leHQuZ2l0L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9hcm0vZnNsLnlhbWw6NDc1OjExMTogW3dhcm5pbmddIGxpbmUgdG9vDQpsb25nICgx
MTMgPiAxMTAgY2hhcmFjdGVycykgKGxpbmUtbGVuZ3RoKQ0KL3Zhci9ob21lL3ppbS9Tb3VyY2Vz
L2xpbnV4LW5leHQuZ2l0L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnNs
LnlhbWw6NjEzOjExMTogW3dhcm5pbmddIGxpbmUgdG9vDQpsb25nICgxMTMgPiAxMTAgY2hhcmFj
dGVycykgKGxpbmUtbGVuZ3RoKQ0KL3Zhci9ob21lL3ppbS9Tb3VyY2VzL2xpbnV4LW5leHQuZ2l0
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnNsLnlhbWw6NjIwOjExMTog
W3dhcm5pbmddIGxpbmUgdG9vDQpsb25nICgxMTMgPiAxMTAgY2hhcmFjdGVycykgKGxpbmUtbGVu
Z3RoKQ0KDQo+IFBsZWFzZSBjaGVjayBhbmQgcmUtc3VibWl0Lg0KDQpBbnl3YXksIHRoZSBWNCBo
YXMgdGhpcyBhbGwgZml4ZWQuIFRoYW5rcyENCg==
