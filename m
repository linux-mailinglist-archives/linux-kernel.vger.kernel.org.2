Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1883F1DC2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhHSQZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 12:25:19 -0400
Received: from mail-eopbgr10128.outbound.protection.outlook.com ([40.107.1.128]:36007
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229497AbhHSQZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:25:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFqqSUKGkF4y3dUBhWYvb+HDc7tU+jGvQ4qn0h0RTuAMGP7zGKcLz6zQcYImCsbwV4nC8DrNox1dtkPhaDLdQzFCfbDmvHjld9TJijCP3lwOUXNO6f1R1DldVXyyAVAMdx5BFzV0OkUaHdKxZxm6Et+Er/ZySUuxbljAsqAQSKS1MiOUN6MEjZJCTLLgMu/982HIJsA9jyTq34YnCt9GoTklEQ/o5xVVnyEOdQiiqVWbOUxidk0fmeMWU/FXCrAYAYHwG/Cx6btwfsBE8QdnTGPND+kDtLBmEVDrXkThA5jKB2ZHJpsOBrQGedLmAuVFHHm88vLybIEdSCeJvpL/RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZVIA7HCyOq6xn5unWCgqqVFq+IzEuRa32I5Ols+g98=;
 b=LamxPz5wrcRlp+YDLOF5E2tGtZesioxZsUwIo7E3ZKwbGXX8pil6YAGjzgG53UpJ9k8xl7fWqYgb6ZVGGotuHjKj0ITr1BjMrKyaBDOxFwOU22FZq806JI0lEVZcAzZLWhWBKvG4kywSHd9jDApIvVI967kLuYNJ2MTvnLyXn2MJMzaQznz/Np9YXqXecz8wy9VFDyNPNIvjc5s1pN0n6QBQrGAZXDUsSo/BXIk45eXKgOVrXqm1tMRbZnS34ouq2VukKfui3F5Ft2Nx19cHCODlGdgdYkUxENcQw5jHkEZyiz8V56m4gJ2H9DAnVW8hjWbBZbfsIrCAQrHwnYIj/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZVIA7HCyOq6xn5unWCgqqVFq+IzEuRa32I5Ols+g98=;
 b=sTJVtak1m0Z0TA3ixQFZAvml/cx7YYCS65b/CX8lF3PIIeHxxrsi3qWOkNSCxo5jQ2jUGuKWHRH90vULZzQ2FhgeBPnvSWkFv16JSGArwuKozTxod1Fd0BtMsSCA6ZI9uzit8c7NnVKEUH2prdd7hLfoloiSqeT9p4l6MZdzFU4=
Received: from DB7PR05MB5431.eurprd05.prod.outlook.com (2603:10a6:10:55::32)
 by DBAPR05MB7191.eurprd05.prod.outlook.com (2603:10a6:10:1a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 19 Aug
 2021 16:24:38 +0000
Received: from DB7PR05MB5431.eurprd05.prod.outlook.com
 ([fe80::8f4:9f42:ea10:e8e7]) by DB7PR05MB5431.eurprd05.prod.outlook.com
 ([fe80::8f4:9f42:ea10:e8e7%3]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 16:24:38 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "soc@kernel.org" <soc@kernel.org>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "olof@lixom.net" <olof@lixom.net>, "arnd@arndb.de" <arnd@arndb.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: Re: [PATCH v1 7/7] ARM: dts: colibri-imx6ull-emmc: add device trees
Thread-Topic: [PATCH v1 7/7] ARM: dts: colibri-imx6ull-emmc: add device trees
Thread-Index: AQHXlQMkuwghHZtcSUCQfnhPvcQ5Dqt7A2GA
Date:   Thu, 19 Aug 2021 16:24:38 +0000
Message-ID: <81b0c6edf6d2b50cea08a02650b07df95eb424d7.camel@toradex.com>
References: <20210819140345.357167-1-marcel@ziswiler.com>
         <20210819140345.357167-8-marcel@ziswiler.com>
In-Reply-To: <20210819140345.357167-8-marcel@ziswiler.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=toradex.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8446c884-3a7c-448f-f6c7-08d9632dd716
x-ms-traffictypediagnostic: DBAPR05MB7191:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBAPR05MB71916DE5965013EEA5D9B149FBC09@DBAPR05MB7191.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LQql5lIUj0wa11RVKDBo7dlbXVbvKy+SnVFLjqvANcPd00KBmgaYgqjOTDFRu6wUsJcg9UQFfyjVLrHx5Q/jOkF2eikxLS0qJD2sespaPcwfd1K1ZTsNa0kN3QDDh5/6Y0FbIxcGeaECLOQfK3dgV22mtwZP4kvz+dB4qd7lXp5wuZsnNYFXJJgPtc5+cbb3qvg1HUiZywOnokYvtHCCJghtHmrQTH0G+VXhuzkYS3n1l3o9a6jpzZ31tx4y9pPGOub0qAgZDNmGTFznK6DIaHLb+bEogY+9XYwkkdZIVpKE6YnXdQdIeUGILGZPv0hw0xRE5L1UU78r0i3GNxTu5eofMjNnFMsNa1brhM4eBt4VXXTiJJYj9H3joL+Cmf0NaQ1YaXE3aTt7biZfLOBli23dx+f0naHbyOSuMAy8jC7YkupVDgW77t+2ebKYoAcb7kNOQ6gMPRs2BPHFmGYAoMMG3WGqAa0b/yZU57MBULt/13C9cZNMwPJd73IZvCm1F2m06Hh1x0YsA4jf52YuC7Nq7tzdd6Uvv4F75o1Pnxnq+df8pane9pNLhp2xg9ntyJJCfJRuF5GEg02qp76976szY2wv33vDsFIjVWKjqulS6tILoVWJO6lO5+rlEg+fHtxWSkhYGcO26SJcGM5le1yfR1F7gNul0X7Fq4r5sxCFBeUnUnf7CV+6yVDnGOqKzWGQECBCcnMHqDQFGIhC2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR05MB5431.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(366004)(346002)(136003)(396003)(376002)(6512007)(44832011)(5660300002)(38100700002)(122000001)(71200400001)(4326008)(2616005)(54906003)(38070700005)(7416002)(6486002)(186003)(36756003)(8676002)(66946007)(8936002)(478600001)(86362001)(76116006)(2906002)(64756008)(66446008)(83380400001)(316002)(66556008)(6916009)(91956017)(66476007)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlVaUnNTVkttM05MNm5ZNnhFSkd0YjJIUlhmc0FGV25JSWJXeWE4Zi81VzMz?=
 =?utf-8?B?U1pYZVBVS0VjVjdla0NUQlA0alpxTFJMR3VhaWZPMkEzTHJKWDQwRzA0M0tE?=
 =?utf-8?B?dVNNUXBQTGFTdm4xYkVpUGtST25oWmd2VkpIc2NCdXFqYzhPdGN2cGc4QXlU?=
 =?utf-8?B?alVDaEpNa1gzRm9pNUptQStrS093YUtIU1VESy9MU3lvMVpsRzJWTS9RSnhI?=
 =?utf-8?B?bXlrTkVWeW03dHhtdzFSVDcydjJzVmRiQUR5YUlVKzJnaVpja05XVzAva2VE?=
 =?utf-8?B?RjBTdUZ1VzNnTGpSMFJ4ZFhETUYreFFUNlJ6WFZBR0xnc3BDR0hvNWltS3Ez?=
 =?utf-8?B?RVdiVXJ6UVArZUJnUDRubXBtMWFoVVgwTmkyRUhaN2dtWjRrYS85QjYxaGJ0?=
 =?utf-8?B?LzJPcUN0Vy9ibm10NWppUkdqSVFaWis3dEhzSmZtM0E0bXVadnBDT2o0d05t?=
 =?utf-8?B?UjM4YzRha2tOMlIvM3A1UVllZC9yY2lYYmRBeDV1K1BTTWJwN1BDYjBCbjV1?=
 =?utf-8?B?L1ZrcTNTQ3g0RnB5NjV6THZYUk4xNG5Tdi8ybjhNdUkxVEhDOFphR3NRd056?=
 =?utf-8?B?cWZ3bndPT3orc2F3ZkVRU2pLUWF2ZnBNbmdzMVBMWi9HWHFvNmdmRSthdFBY?=
 =?utf-8?B?RjJJV1QvcFJDSVJCc05vbGkrVXpaRzBMZmdrMFdaSmo0RDdWR1l0VlNxS2RK?=
 =?utf-8?B?dTRKUFhHUXFnN29aYTE2K3dVamVBZ1dIdXpqT2wxTWRGZ1U2eXR2aFBDQnEv?=
 =?utf-8?B?cUFBUlVGcTN2aTRyVm5VRjBqZmNlS3JMbTNxWXEwblNtd1ZJdHNwa0Z5Tlp5?=
 =?utf-8?B?OXBEa3A1aUJlQWYzRjdpblZzcmJMOEJ5ckREVHlna0pPL001Mk9MMFhKNjFB?=
 =?utf-8?B?SnN6TXdJQjhPSHZFTFQybFZub0MzVmM0N0piT3BQYlYxNGJnOFh0M3NXemls?=
 =?utf-8?B?NnVQdlNSY29HNnh2VGVlY2U0SW1ld0FnbUllOFFxaFdpQmZMbCtZOWVUUEhN?=
 =?utf-8?B?djE5Nk9jOVdSRDJwaWRxQnRGMFJEQ3dmNmFRMTZVYXY5cDBwRDh2NkEzY2lW?=
 =?utf-8?B?R0I0SHN4bWd5K0NtWVI0alVsN0hRT085WlJxRW1uSDdyVFVySXB2b1g4L0tD?=
 =?utf-8?B?dERMZWtvWjRpV0JPS2poVXJhdzkwSU5ORGZ1bVNLU2FBZ3I3S29UV2xVWDJt?=
 =?utf-8?B?LzhzVU0xaUpuVW45TENQUjhJNHpPV2NhS1J0YStJbHppZzRjSnh0aDJWNWRn?=
 =?utf-8?B?TkRNcWRaQ2RrR1ppMTRwbkVuK21PUnptWi9WWjFMNWVGMklsOTRWZnJVN0Ni?=
 =?utf-8?B?ejlrL0dHcHVFUTRuajhIVnQyS3RGcXE4WC9pRHlWd25Fdm4rT21ZK1pvRWJC?=
 =?utf-8?B?M3VMKzZaanBIZ0JXQWhneWp5MnlWc3d6TXc3dyt1eEZadmlQYWc1amhKTENU?=
 =?utf-8?B?QTdhNE1JSG9BRE9UUm9TZ0ZGV1dQV2F1WHFXU2VkVkdFWUhWTEU4K2VodTlH?=
 =?utf-8?B?RmttdUg4MWJJc2pRSWFKbHM5cmhueG9wSnYyc0YzUE55d0tmWnB4K0NDVThK?=
 =?utf-8?B?S2ZidVYvK201SDh3TmdTOHg5OFYxclV6WkhiaTFxVFd4MVpuOFArSEQxSWhH?=
 =?utf-8?B?cG5vWS9HakRPcUhUZ0dOdjc0UTNpeTJMQi9YcUd1b0l2aW51NUtQK2dhaDU2?=
 =?utf-8?B?ODU3N0NuNThPZTEwQmQ2a2pkSW9zNm5uT2ZUSEZYK1loTExjOFVKL09tSEJL?=
 =?utf-8?B?SENXNytNdlJBUUN0UmQyQWx6ZTJtV3g0eUlHMXBVbktUZTNEQVcrOStzbVRm?=
 =?utf-8?B?R1pvL3g1alY2aW5qRnpmQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52A690C217556349A0CE24FA2104330E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR05MB5431.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8446c884-3a7c-448f-f6c7-08d9632dd716
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 16:24:38.2140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i0uxqbddQedosKdGacyERuiOUQLQvNdiiWD0eIVcFpy+6WZrSc501gQlEQwcn0KKqUmBCbzCiaIctfObMQnwsaIVHoZnsWJTZgL8SH1n3Lg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR05MB7191
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTA4LTE5IGF0IDE2OjAzICswMjAwLCBNYXJjZWwgWmlzd2lsZXIgd3JvdGU6
Cj4gRnJvbTogTWF4IEtydW1tZW5hY2hlciA8bWF4LmtydW1tZW5hY2hlckB0b3JhZGV4LmNvbT4K
PiAKPiBBZGQgZGV2aWNlcyB0cmVlcyBmb3IgYSBDb2xpYnJpIGlNWDZVTEwgMUdCIHdoaWNoIGhh
cyBhIGVNTUMgaW5zdGVhZCBvZgo+IHRoZSByYXcgTkFORCB1c2VkIG9uIG90aGVyIFNLVXMuCj4g
Cj4gUmVsYXRlZC10bzogRUxCLTQwNTYsIEVMQi00MDU4Cj4gU2lnbmVkLW9mZi1ieTogTWF4IEty
dW1tZW5hY2hlciA8bWF4LmtydW1tZW5hY2hlckB0b3JhZGV4LmNvbT4KPiBTaWduZWQtb2ZmLWJ5
OiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4KPiAKPiAtLS0K
PiAKPiDCoGFyY2gvYXJtL2Jvb3QvZHRzL01ha2VmaWxlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArCj4gwqAuLi4vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJp
LWVtbWMtZXZhbC12My5kdHMgfMKgIDE3ICsrCj4gwqAuLi4vZHRzL2lteDZ1bGwtY29saWJyaS1l
bW1jLW5vbndpZmkuZHRzacKgwqDCoMKgIHwgMTg1ICsrKysrKysrKysrKysrKysrKwo+IMKgYXJj
aC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLmR0c2nCoMKgwqDCoMKgwqDCoCB8wqAgMzAg
KystCj4gwqA0IGZpbGVzIGNoYW5nZWQsIDIzMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
Cj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJp
LWVtbWMtZXZhbC12My5kdHMKPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9ib290L2R0
cy9pbXg2dWxsLWNvbGlicmktZW1tYy1ub253aWZpLmR0c2kKPiAKPiAuLi4KPgo+IGRpZmYgLS1n
aXQgYS9hcmNoL2FybS9ib290L2R0cy9pbXg2dWxsLWNvbGlicmkuZHRzaSBiL2FyY2gvYXJtL2Jv
b3QvZHRzL2lteDZ1bGwtY29saWJyaS5kdHNpCj4gaW5kZXggMGNkYmY3YjZlNzI4NS4uZjQzMmZj
MGE2YTUzMCAxMDA2NDQKPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9pbXg2dWxsLWNvbGlicmku
ZHRzaQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJyaS5kdHNpCj4gQEAg
LTEsNiArMSw2IEBACj4gwqAvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAgT1Ig
TUlUKQo+IMKgLyoKPiAtICogQ29weXJpZ2h0IDIwMTggVG9yYWRleCBBRwo+ICsgKiBDb3B5cmln
aHQgMjAxOC0yMDIxIFRvcmFkZXggQUcKPiDCoCAqLwo+IMKgCj4gwqAjaW5jbHVkZSAiaW14NnVs
bC5kdHNpIgo+IEBAIC0zNDUsNiArMzQ1LDE5IEBAIE1YNlVMX1BBRF9FTkVUMV9SWF9EQVRBMV9f
R1BJTzJfSU8wMcKgwqDCoMKgwqDCoMKgMHhiMGIwIC8qIFNPRElNTSA2MyAqLwo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPjsKPiDCoMKgwqDCoMKgwqDCoMKgfTsKPiDCoAo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgKiBXaXRoIGFuIGVNTUMgaW5zdGVhZCBvZiBhIHJhdyBOQU5EIGRldmljZSB0aGUg
Zm9sbG93aW5nIHBpbnMKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogYXJlIGF2
YWlsYWJsZSBhdCBTT0RJTU0gcGlucwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Ki8KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGluY3RybF9ncG1pX2dwaW86IGdw
bWktZ3Bpby1ncnAgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgZnNsLHBpbnMgPSA8Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgTVg2VUxfUEFEX05BTkRfQUxFX19HUElPNF9JTzEw
wqDCoMKgwqDCoMKgwqDCoMKgwqAweDEwYjAgLyogU09ESU1NIDE0MCAqLwo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoE1YNlVM
X1BBRF9OQU5EX0NFMF9CX19HUElPNF9JTzEzwqDCoMKgwqDCoMKgwqDCoDB4MTBiMCAvKiBTT0RJ
TU0gMTQ0ICovCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgTVg2VUxfUEFEX05BTkRfQ0xFX19HUElPNF9JTzE1wqDCoMKgwqDC
oMKgwqDCoMKgwqAweDEwYjAgLyogU09ESU1NIDE0NiAqLwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoE1YNlVMX1BBRF9OQU5E
X1JFQURZX0JfX0dQSU80X0lPMTLCoMKgwqDCoMKgwqAweDEwYjAgLyogU09ESU1NIDE0MiAqLwo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPjsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfTsKPiArCgpKdXN0IG5vdGljZWQgdGhhdCBJIHNv
bWVob3cgbWVzc2VkIHVwIHRoZSBpbmRlbnRhdGlvbiBhYm92ZSB3aXRoIG9uZSBzcHVyaW91cyB0
YWIgdG9vIG11Y2guIFdpbGwgY29ycmVjdCB0aGF0CmluIGEgdjIuIFNvcnJ5IGFib3V0IHRoYXQu
Cgo+IMKgwqDCoMKgwqDCoMKgwqBwaW5jdHJsX2dwbWlfbmFuZDogZ3BtaS1uYW5kLWdycCB7Cj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBmc2wscGlucyA9IDwKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBNWDZVTF9QQURfTkFORF9EQVRB
MDBfX1JBV05BTkRfREFUQTAwwqDCoMKgMHgxMDBhOQo+IEBAIC01MzMsNiArNTQ2LDIxIEBAIE1Y
NlVMX1BBRF9HUElPMV9JTzAzX19PU0MzMktfMzJLX09VVMKgwqDCoMKgwqDCoMKgMHgxMAo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPjsKPiDCoMKgwqDCoMKgwqDCoMKgfTsKPiDC
oAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwaW5jdHJsX3VzZGhjMmVtbWM6IHVz
ZGhjMmVtbWNncnAgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgZnNsLHBpbnMgPSA8Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgTVg2VUxfUEFEX05BTkRfUkVfQl9fVVNESEMyX0NM
S8KgwqDCoMKgIDB4MTcwNTkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBNWDZVTF9QQURfTkFORF9XRV9CX19VU0RIQzJfQ01E
wqDCoMKgwqAgMHgxNzA1OQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoE1YNlVMX1BBRF9OQU5EX0RBVEEwMF9fVVNESEMyX0RB
VEEwIDB4MTcwNTkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBNWDZVTF9QQURfTkFORF9EQVRBMDFfX1VTREhDMl9EQVRBMSAw
eDE3MDU5Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgTVg2VUxfUEFEX05BTkRfREFUQTAyX19VU0RIQzJfREFUQTIgMHgxNzA1
OQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoE1YNlVMX1BBRF9OQU5EX0RBVEEwM19fVVNESEMyX0RBVEEzIDB4MTcwNTkKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBNWDZVTF9QQURfTkFORF9EQVRBMDRfX1VTREhDMl9EQVRBNCAweDE3MDU5Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
TVg2VUxfUEFEX05BTkRfREFUQTA1X19VU0RIQzJfREFUQTUgMHgxNzA1OQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoE1YNlVM
X1BBRF9OQU5EX0RBVEEwNl9fVVNESEMyX0RBVEE2IDB4MTcwNTkKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBNWDZVTF9QQURf
TkFORF9EQVRBMDdfX1VTREhDMl9EQVRBNyAweDE3MDU5Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA+Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqB9Owo+ICsKCkRpdHRvIGFib3ZlLgoKPiDCoMKgwqDCoMKgwqDCoMKgcGluY3RybF93ZG9n
OiB3ZG9nLWdycCB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBmc2wscGlucyA9
IDwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBNWDZV
TF9QQURfTENEX1JFU0VUX19XRE9HMV9XRE9HX0FOWcKgwqDCoCAweDMwYjAKCkNoZWVycwoKTWFy
Y2VsCg==
