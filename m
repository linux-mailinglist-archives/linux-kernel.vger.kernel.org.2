Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1D34155A6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 04:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238941AbhIWCyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 22:54:36 -0400
Received: from mail-eopbgr20058.outbound.protection.outlook.com ([40.107.2.58]:57911
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238905AbhIWCye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 22:54:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7+5nnQaQTcyZ4Rlws6XpDg71YbGp0RmWkDWvgMugMN0DWuVssfYduJcrFcD2ICNzvSWfVmI5LePr6EZi4hUvt2aUbfy5xMdlKTQTlRTQUoEZ6FyTpaaI4r+1i8mueqf4rHk9RYjrxuqhnCVWn3IHPJxZFOvcHjZduvsdcYwCaVH25c8vCbXTUvQDyTuCYZTQ++5UOScqnJPxpLu+FR0p+rnpRvsrAUK/yTJc6hHTj5Hyp2cYeK47KO7zeK8ksZOa3h5vtsV2PyJ2obdBXhKdAPzyIDwol+F0xBEjLPjnjmEfy1CkuZiZ9xiwS1O2GE9MeR0a0tHTYtaze3GYXFtXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=QAYjCWtSIXiSgwaA8S3XKhIFEnajsCmI0Aay8I//xsI=;
 b=GrbdICVHmFX7EhxVMgffi8B+ACGV52nHQBmI+HeFMBpxjQgXkOivCCQfrIcRrHH1WjPk5tvs1PwX+Yw/5+GK3kzVS6xT17w+RdIeZ9Fz6/X4g5BL+jvsCsjJUE0colwgvM38kL3DVkr6S0ag4dECSm1TVs+eV8YbZ+SRsDqIdscbbuCU7X7x5mLx/vRLf+fmbldURLbMcVcGZ5wf1HWSzxJ7hH8ZyZ27k/R1ZkacD/KXYoRzgG0h9j2YtnepDlICWPk3D17E1tzas7OI5E0wskP2WZOaXUKsFAaVqXJc5+1cSU3UNxseV7E+eAtfcNxQ4r/JyU8szWS33vQ6YajaSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAYjCWtSIXiSgwaA8S3XKhIFEnajsCmI0Aay8I//xsI=;
 b=JNTpmXyGbgv6D678cZg/DQRQevrHXePjUGfpdR058aDOMCbPSLu1bjdz7ZjGjiFykQa4OddHw5BzOj0+CN430CVwvyTf77WNbRYcW/fWAPmFOlK04AKLr3Ox1rFFdu1GNX8Ka7xPN6AhzClxNPLmNfZcllysWidSSN+hhfLCT5E=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB6PR0401MB2325.eurprd04.prod.outlook.com (2603:10a6:4:49::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Thu, 23 Sep
 2021 02:52:59 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f%9]) with mapi id 15.20.4544.013; Thu, 23 Sep 2021
 02:52:59 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/6] arm64: dts: imx8mm: add "cell-type" property for
 mac-address
Thread-Topic: [PATCH 5/6] arm64: dts: imx8mm: add "cell-type" property for
 mac-address
Thread-Index: AQHXpJjAeLkjOlVpnU64xPh16TTeY6uwA/cAgAD9G4A=
Date:   Thu, 23 Sep 2021 02:52:59 +0000
Message-ID: <DB8PR04MB67958AF4B6031D6D6D0FDEA5E6A39@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20210908100257.17833-1-qiangqing.zhang@nxp.com>
 <20210908100257.17833-6-qiangqing.zhang@nxp.com>
 <d24cdd9f-9498-fd3a-7650-91756a8c2227@pengutronix.de>
In-Reply-To: <d24cdd9f-9498-fd3a-7650-91756a8c2227@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7151f8b9-53a5-4ee0-2d85-08d97e3d40e6
x-ms-traffictypediagnostic: DB6PR0401MB2325:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0401MB23259A2C52FBF7867F903B49E6A39@DB6PR0401MB2325.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:298;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bQoHJgGa8R02ZibNRz0H/9RdzQM6BbsDupPz0gVP9WTcdxDcOLCkKTHjFR0DhiIiC7BESbVUuPoy9KbCVmImgs90Q/TIh1Y/d/yk+wU18TBcE9lQ+3gb6gB0vb2ehGuE/UbJTONyQbYC+BpUBNpnQ/yDjrQTT9rmM5lBRNOJUuDr5wVhf5vVZt7pjKjclhBdB7ykG4h5GarqWxYYcyRTnQUhxgOO5MMFJGoSv2OPRKrv3DqRkt6aaRa1jgHirqYwD81vpxsQZx1cEY64TUPG10aL5xFtxI601Y98QjXezBaI70EkVCwo9CO9XNfVom9zgNkHc1vM/yDp5Oj3G1cf8NKZyGzQ/A1o/2XiowW4mtbuqzlKJP0VgrGGQlYL18VgiriV+LTRLzTxk3854q3Stv2xuHwUmgzWqSqfbpEZzh8hbOPIL/ASgJNln3PqO9gntPlRZaOtzrlJvECjYow+Z5eQvgA4w4OVQqXWUReYs+B/vSeWsTD/lb+HPmG8EfaDQcJSBUb46L1RpBdVoK/d643zxrNzIeEGk8X6gIu3fBAWtvmDlLyz4OisUs1FaHXxA17RF/cQiDBOzpndFTTrsspm7gluOCFa3jjDocqJQG0EgvIeNoSCr4ccO/a4Z6gFTmez2C+dhEkZismfzCn3juRNJ8R3HIQ0w5XhjbK94ecgNfXeZXyxcrGHeSP6rZJbn9gDZziEzyU8DVB/kgvZcv1QOF+j9Y1Fqz/XAqBrCqST6alWUAdYtanJcDjiBPJJXVKiIxbWixnPSNsxF+YUW+XRS5Px7Yl+s1Y04i8moyAuHH6hEfv1clKm64wVjqP8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66446008)(54906003)(7696005)(71200400001)(66476007)(5660300002)(66556008)(2906002)(64756008)(316002)(508600001)(110136005)(45080400002)(33656002)(83380400001)(8936002)(186003)(38100700002)(122000001)(8676002)(6506007)(4326008)(66946007)(55016002)(86362001)(52536014)(53546011)(38070700005)(76116006)(26005)(966005)(9686003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?YzJhUGZXaFJhdk5KZGFoRmJFRFpieUtSUnJPWXMwUFZzQ2c2RlZqNEVUdXpJ?=
 =?gb2312?B?eWtpdXpkOVhzMEtJWTlkMktiYmZoL0dxeWd4a0ZCTjQ3RjdiakJpZ0VUSlVj?=
 =?gb2312?B?STdVTUpIZWNLS0g3VjFZaUxVU3NTVG05aHFoSmpMMEcxdTVNRGpJU0VOY2JR?=
 =?gb2312?B?bE5wMUdxNW40b0ltSlIxSTdJWEhsblJYcXhQTysvRGlBQTdTUmJkVlhTWE9h?=
 =?gb2312?B?UnNQVkNOdUZnS2YxRjA0ODRXTi9tUWQ2dElTUm5oR2NWLzFpTGxRcWJNcExu?=
 =?gb2312?B?Yy9GdWNLeWxNclpGaWpESjFpSXo2Z3h5Z1J0Q2J5L1hRWm44NCtlRFVuTDZ0?=
 =?gb2312?B?aTRaYmtIUWxTRXA5dmQybXdaajExUllYbkJKd0djQ1pGaVdDRW1JYWVHMitW?=
 =?gb2312?B?RWIzWUJ4WWdlTG5hVVViREdDRFNzeFFVRHN4NkwxQnhOTzU1RFRsYVdNMWRZ?=
 =?gb2312?B?SGJaQm1DbTcxUGdQZFlSMkNzWFRFMGVhU1ZiMXhLNTVObzRNbHY5Mk1uRmJI?=
 =?gb2312?B?ck5ZN2xzeDkxazA0MUhrekxqVU81azFIb0hmWlJHYlBCRTBteGllVGRHMDM5?=
 =?gb2312?B?SW9xb0VyZVlTZDJITE5pMVdYRjJBSGJDNTVjSWRZQWV1MGpWdThma25lOUhm?=
 =?gb2312?B?Q0Y3VERrRkJ2T2ZOYkprVWZPaXFXVUNDQ2RnUzZjN0pXSnZvL3VkaVcrVFlQ?=
 =?gb2312?B?SEhSb2YrMy95aFVIbXgrWGc3Q0FDSkh1amc4ZzVYUFFNN0NqSUo0a0RNUUY4?=
 =?gb2312?B?YmlKVm1NSkx1Yk9aQ1V2VVNzUEFIdldZOEw3eVhIZ3o3NndwS0RXM29hYTA1?=
 =?gb2312?B?eDJOVmNwblEwdG90SUN2TG0yTnZKSXJyZ3lrcTFSeVNwRUVhTUdKUURLY0hK?=
 =?gb2312?B?MitTbk93NjQxQzhucmhNMnBIU2NHRVoweG1uem5oaHp3cmZyeDB4YW05Qllk?=
 =?gb2312?B?eXVHMnVtMXJUUytZdDMyUjZYVUgwQzlDSWVuQi94b3MyR25jWTlPNjM0WTFR?=
 =?gb2312?B?V0d6VlNwUjJNN2pleVN3RkwxczljMjgrSzQvei8xckZFUUppR25MaHdPa3VC?=
 =?gb2312?B?eFBqbi9qVGJZb2xjaE16V1JRMkRDSklYUDJWSGtCa0FIb2dCUkRKSUwvQll3?=
 =?gb2312?B?RHBQZktLMUZmS3FOZnpUWVFRZ0FkNnNjdWNqWkIvaXladGV2M2QrblpjcUVQ?=
 =?gb2312?B?M1BNWkZ4R25tT3hURHcwWmlVYTBvSEk2WkQ1WXRiUFBUR1Z2VGQxRHlSRXdw?=
 =?gb2312?B?bGttbXpVNE5kajJVaFpuNzBTVllzTCthTm5HRDZvL2ZsdExjSnZWTzRCT0Vq?=
 =?gb2312?B?M01mTExsZzkxRi9VN3BBTml6WTlMdkRsWnQyMnBnZFcvZ2x6TWdMQU1pdUZl?=
 =?gb2312?B?ODBkakFLTENIdElSRFpSTDhJazdHdWl4Rkhlc1pyNG52Zm9LVmhJNGI2NWE5?=
 =?gb2312?B?TEdRcTZ2V2VibjRieThmb1MvOHJSaDRtbTNjT3NFamQ3T2JkVGRJZTlYOGpC?=
 =?gb2312?B?RTFyWE5pd3k1ZTE1Y2ZnRjhaWDlyaFZiNFZSajhLNnE2eGc2Vkk4dWpmSlNk?=
 =?gb2312?B?RWhxaVlmZU1NVE9FWkhSQm5VeU10KzdTM2lEcGtGTDZ4eUZXOTh0YjkxelNX?=
 =?gb2312?B?R1BRVzVyZEtRdVQvMzFiS210OHYwa3hsWEFpTC8yK3hyWklNNzNWNjh6WHMy?=
 =?gb2312?B?eHoxZm52Tzk1ZVA4YjBTTDdDNWFLa0IwNnJHUldpbnozaW1heGd6ZEt3TlAr?=
 =?gb2312?Q?IhfEcLiRUzuOXI5r/tRv2vF9AKB9S41hEJWVGrq?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7151f8b9-53a5-4ee0-2d85-08d97e3d40e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 02:52:59.5073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nDjdvx8RYQkeX4HH3UeLSFMbhI1g/4f7u9jjo5FkDBojCbRir7SS1uATjM1u+9l2NCwMNkEbIg5+vGPTZX2FwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2325
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBBaG1hZCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBaG1h
ZCBGYXRvdW0gPGEuZmF0b3VtQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAyMDIxxOo51MIyMsjV
IDE5OjQwDQo+IFRvOiBKb2FraW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAuY29tPjsNCj4g
c3Jpbml2YXMua2FuZGFnYXRsYUBsaW5hcm8ub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7IHNoYXdu
Z3VvQGtlcm5lbC5vcmcNCj4gQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBkbC1saW51
eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNS82XSBhcm02
NDogZHRzOiBpbXg4bW06IGFkZCAiY2VsbC10eXBlIiBwcm9wZXJ0eSBmb3INCj4gbWFjLWFkZHJl
c3MNCj4gDQo+IE9uIDA4LjA5LjIxIDEyOjAyLCBKb2FraW0gWmhhbmcgd3JvdGU6DQo+ID4gQWRk
ICJjZWxsLXR5cGUiIHByb3BlcnR5IGZvciBtYWMtYWRkcmVzcyBudm1lbSBjZWxsIHRvIHN1cHBv
cnRpbmcgbWFjDQo+ID4gYWRkcmVzcyByZXZlcnNlIGJ5dGUuDQo+IA0KPiBzL2lteDhtbS9pbXg4
bS8gaW4gY29tbWl0IG1lc3NhZ2UgdGl0bGUuDQoNCldpbGwgZml4IGl0IGluIFYyLg0KDQo+IERv
IHlvdSBpbnRlbmQgdG8gZG8gdGhpcyBmb3Igb2xkZXIgaS5NWCBhcyB3ZWxsPw0KDQpObyBwbGFu
IG5vdywgSSBqdXN0IHByZXBhcmUgaXQgZm9yIGkuTVg4TSBzZXJpYWxzLg0KDQpCZXN0IFJlZ2Fy
ZHMsDQpKb2FraW0gWmhhbmcNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEpvYWtpbSBaaGFuZyA8
cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpIHwgMiArKw0KPiA+IGFyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDhtbi5kdHNpIHwgMiArKw0KPiA+IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2lteDhtcC5kdHNpIHwgOSArKysrKysrKysNCj4gPiBhcmNoL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9pbXg4bXEuZHRzaSB8IDIgKysNCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCAxNSBp
bnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvaW14OG1tLmR0c2kNCj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2lteDhtbS5kdHNpDQo+ID4gaW5kZXggZTc2NDhjM2I4MzkwLi5mYjE0YmU5MzIzODYgMTAwNjQ0
DQo+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kNCj4g
PiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0uZHRzaQ0KPiA+IEBA
IC03LDYgKzcsNyBAQA0KPiA+ICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvZ3Bpby9ncGlvLmg+DQo+
ID4gICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnB1dC9pbnB1dC5oPg0KPiA+ICAjaW5jbHVkZSA8
ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXJtLWdpYy5oPg0KPiA+ICsjaW5jbHVk
ZSA8ZHQtYmluZGluZ3MvbnZtZW0vbnZtZW0uaD4NCj4gPiAgI2luY2x1ZGUgPGR0LWJpbmRpbmdz
L3RoZXJtYWwvdGhlcm1hbC5oPg0KPiA+DQo+ID4gICNpbmNsdWRlICJpbXg4bW0tcGluZnVuYy5o
Ig0KPiA+IEBAIC01MzksNiArNTQwLDcgQEANCj4gPg0KPiA+ICAJCQkJZmVjX21hY19hZGRyZXNz
OiBtYWMtYWRkcmVzc0A5MCB7DQo+ID4gIAkJCQkJcmVnID0gPDB4OTAgNj47DQo+ID4gKwkJCQkJ
Y2VsbC10eXBlID0gPE5WTUVNX0NFTExfVFlQRV9NQUNfQUREUkVTUz47DQo+ID4gIAkJCQl9Ow0K
PiA+ICAJCQl9Ow0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2lteDhtbi5kdHNpDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9p
bXg4bW4uZHRzaQ0KPiA+IGluZGV4IGQ0MjMxZTA2MTQwMy4uMGE5OTRlNmVkYzBiIDEwMDY0NA0K
PiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbi5kdHNpDQo+ID4g
KysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1uLmR0c2kNCj4gPiBAQCAt
Nyw2ICs3LDcgQEANCj4gPiAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2dwaW8vZ3Bpby5oPg0KPiA+
ICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW5wdXQvaW5wdXQuaD4NCj4gPiAgI2luY2x1ZGUgPGR0
LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2FybS1naWMuaD4NCj4gPiArI2luY2x1ZGUg
PGR0LWJpbmRpbmdzL252bWVtL252bWVtLmg+DQo+ID4gICNpbmNsdWRlIDxkdC1iaW5kaW5ncy90
aGVybWFsL3RoZXJtYWwuaD4NCj4gPg0KPiA+ICAjaW5jbHVkZSAiaW14OG1uLXBpbmZ1bmMuaCIN
Cj4gPiBAQCAtNTQ0LDYgKzU0NSw3IEBADQo+ID4NCj4gPiAgCQkJCWZlY19tYWNfYWRkcmVzczog
bWFjLWFkZHJlc3NAOTAgew0KPiA+ICAJCQkJCXJlZyA9IDwweDkwIDY+Ow0KPiA+ICsJCQkJCWNl
bGwtdHlwZSA9IDxOVk1FTV9DRUxMX1RZUEVfTUFDX0FERFJFU1M+Ow0KPiA+ICAJCQkJfTsNCj4g
PiAgCQkJfTsNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9pbXg4bXAuZHRzaQ0KPiA+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14
OG1wLmR0c2kNCj4gPiBpbmRleCA5ZjdjN2Y1ODdkMzguLjM3MTg4ZmYwN2YyMSAxMDA2NDQNCj4g
PiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAuZHRzaQ0KPiA+ICsr
KyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC5kdHNpDQo+ID4gQEAgLTcs
NiArNyw3IEBADQo+ID4gICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9ncGlvL2dwaW8uaD4NCj4gPiAg
I2luY2x1ZGUgPGR0LWJpbmRpbmdzL2lucHV0L2lucHV0Lmg+DQo+ID4gICNpbmNsdWRlIDxkdC1i
aW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQo+ID4gKyNpbmNsdWRlIDxk
dC1iaW5kaW5ncy9udm1lbS9udm1lbS5oPg0KPiA+ICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvdGhl
cm1hbC90aGVybWFsLmg+DQo+ID4NCj4gPiAgI2luY2x1ZGUgImlteDhtcC1waW5mdW5jLmgiDQo+
ID4gQEAgLTM1OCw2ICszNTksMTIgQEANCj4gPg0KPiA+ICAJCQkJZXRoX21hYzE6IG1hYy1hZGRy
ZXNzQDkwIHsNCj4gPiAgCQkJCQlyZWcgPSA8MHg5MCA2PjsNCj4gPiArCQkJCQljZWxsLXR5cGUg
PSA8TlZNRU1fQ0VMTF9UWVBFX01BQ19BRERSRVNTPjsNCj4gPiArCQkJCX07DQo+ID4gKw0KPiA+
ICsJCQkJZXRoX21hYzI6IG1hYy1hZGRyZXNzQDk2IHsNCj4gPiArCQkJCQlyZWcgPSA8MHg5NiA2
PjsNCj4gPiArCQkJCQljZWxsLXR5cGUgPSA8TlZNRU1fQ0VMTF9UWVBFX01BQ19BRERSRVNTPjsN
Cj4gPiAgCQkJCX07DQo+ID4gIAkJCX07DQo+ID4NCj4gPiBAQCAtODM2LDYgKzg0Myw4IEBADQo+
ID4gIAkJCQkJCQkgPCZjbGsgSU1YOE1QX1NZU19QTEwyXzEwME0+LA0KPiA+ICAJCQkJCQkJIDwm
Y2xrIElNWDhNUF9TWVNfUExMMl8xMjVNPjsNCj4gPiAgCQkJCWFzc2lnbmVkLWNsb2NrLXJhdGVz
ID0gPDA+LCA8MTAwMDAwMDAwPiwgPDEyNTAwMDAwMD47DQo+ID4gKwkJCQludm1lbS1jZWxscyA9
IDwmZXRoX21hYzI+Ow0KPiA+ICsJCQkJbnZtZW0tY2VsbC1uYW1lcyA9ICJtYWMtYWRkcmVzcyI7
DQo+ID4gIAkJCQlpbnRmX21vZGUgPSA8JmdwciAweDQ+Ow0KPiA+ICAJCQkJc3RhdHVzID0gImRp
c2FibGVkIjsNCj4gPiAgCQkJfTsNCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kNCj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2lteDhtcS5kdHNpDQo+ID4gaW5kZXggOTFkZjljNTM1MGFlLi4xY2IyMTFlNDcwYWUgMTAw
NjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kN
Cj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzaQ0KPiA+
IEBAIC0xMCw2ICsxMCw3IEBADQo+ID4gICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9ncGlvL2dwaW8u
aD4NCj4gPiAgI2luY2x1ZGUgImR0LWJpbmRpbmdzL2lucHV0L2lucHV0LmgiDQo+ID4gICNpbmNs
dWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQo+ID4gKyNp
bmNsdWRlIDxkdC1iaW5kaW5ncy9udm1lbS9udm1lbS5oPg0KPiA+ICAjaW5jbHVkZSA8ZHQtYmlu
ZGluZ3MvdGhlcm1hbC90aGVybWFsLmg+ICAjaW5jbHVkZQ0KPiA+IDxkdC1iaW5kaW5ncy9pbnRl
cmNvbm5lY3QvaW14OG1xLmg+DQo+ID4gICNpbmNsdWRlICJpbXg4bXEtcGluZnVuYy5oIg0KPiA+
IEBAIC01NzAsNiArNTcxLDcgQEANCj4gPg0KPiA+ICAJCQkJZmVjX21hY19hZGRyZXNzOiBtYWMt
YWRkcmVzc0A5MCB7DQo+ID4gIAkJCQkJcmVnID0gPDB4OTAgNj47DQo+ID4gKwkJCQkJY2VsbC10
eXBlID0gPE5WTUVNX0NFTExfVFlQRV9NQUNfQUREUkVTUz47DQo+ID4gIAkJCQl9Ow0KPiA+ICAJ
CQl9Ow0KPiA+DQo+ID4NCj4gDQo+IA0KPiAtLQ0KPiBQZW5ndXRyb25peCBlLksuICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfA0KPiB8DQo+IFN0ZXVlcndhbGRlciBTdHIuIDIxICAgICAgICAg
ICAgICAgICAgICAgICB8DQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0
bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGd3d3LnBlDQo+IG5ndXRyb25peC5kZSUyRiZhbXA7
ZGF0YT0wNCU3QzAxJTdDcWlhbmdxaW5nLnpoYW5nJTQwbnhwLmNvbSU3Qzk0DQo+IGQ2NzQ0ZGM5
OTU0NWRhNjk2YTA4ZDk3ZGJkYjgzZiU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1
DQo+ICU3QzAlN0MwJTdDNjM3Njc5MDc2MDU3NTkwNjE0JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNk
OGV5SldJag0KPiBvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dp
TENKWFZDSTZNbjAlM0QlN0MxMA0KPiAwMCZhbXA7c2RhdGE9cmI5WlpYRXFOeFFhcTlQT1JEUDVa
Vk9ncVpJTkZsdEJHMWVNdk05VmNCYyUzRCZhDQo+IG1wO3Jlc2VydmVkPTAgIHwNCj4gMzExMzcg
SGlsZGVzaGVpbSwgR2VybWFueSAgICAgICAgICAgICAgICAgIHwgUGhvbmU6ICs0OS01MTIxLTIw
NjkxNy0wDQo+IHwNCj4gQW10c2dlcmljaHQgSGlsZGVzaGVpbSwgSFJBIDI2ODYgICAgICAgICAg
IHwgRmF4Og0KPiArNDktNTEyMS0yMDY5MTctNTU1NSB8DQo=
