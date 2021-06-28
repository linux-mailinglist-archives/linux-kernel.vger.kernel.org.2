Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133C63B5955
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 08:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbhF1HCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 03:02:09 -0400
Received: from mail-co1nam11on2066.outbound.protection.outlook.com ([40.107.220.66]:63072
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229998AbhF1HCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 03:02:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVPh9+7h94a7IsO1Tez9LcQUN+5knYGMSl9Wx0Jtv9MOxDrCh5d14wOxH41wZ3h0hab0mriBL9xEdF927iTjWRrHeYZ28DvJkUockcSPfDGIC2nAWDGkvKNw1C/W9X3neo4KzIBowUXAe+wwyaA7fXoUm6NyeB3nXpenOT7utvQUGkeaXFmh6aLJGcb5uV3dtMgdU8E5e4sBJHYQWc3viv1hWiOZGleiQL6l9WpAxcb7rkkyBOBR0Fno8FeIi1Hcn4wvurMJONA19Y6mv/DNojIJvgnCinXbga14RtTGJ0DifhEH2i8b720B4iGZmnD42I5G3LvBiSW7awyjbIVIIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQMmnfkPJ5T1jJDZ+6TTI7qv9pIiEKjuvIXGVFM8GeA=;
 b=UJxe3CtPzTUUSQoOUQBzax0hK00QYvxNzxslMozo1hVQgkqir37G0x0alcDs0PynTZykwD+C81YcOqRFwpUabg1QItVHSh831+sD+2iYfGsOUBxQAJj3HupBzw3IwpbV8r4JDSBm0CTbrZbyKo0MGXjFkE2ZS/H913YXC58gAsXWE32wrQAWwKhVdlXuen0SrD1KRGW1LXNnIA/UC0YvFzuLaP9ecL+3+DCCqt7BXZafZFD2aXGvKhvxSMdSYGbQdR0FAzoNTNAuzZEnZ3OBy4fxkm/hw5wrJ1+/ricV+3TkaT9t3kLJT0TaSSzXmJnHVtnt2S2hbCLgW01J079Nuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQMmnfkPJ5T1jJDZ+6TTI7qv9pIiEKjuvIXGVFM8GeA=;
 b=MsNLt9Dbcs/S3vx6dEeltv+2cKIqNLwanzhVNL1ETKuO3QJV7NT0YM3b1644DgzoL3tpBhYfrQtl7GI79vWZa+1OW+3MXmTmBx267ktPECok6vFAV9lXFFBQr3MhcZPhevHgxNd9wKbJ/Hv9XiaxVCe/+45FEIxraWGq4dniwY8=
Received: from BYAPR02MB3941.namprd02.prod.outlook.com (2603:10b6:a02:f8::18)
 by BY5PR02MB6900.namprd02.prod.outlook.com (2603:10b6:a03:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Mon, 28 Jun
 2021 06:59:41 +0000
Received: from BYAPR02MB3941.namprd02.prod.outlook.com
 ([fe80::a974:6b60:92b:265]) by BYAPR02MB3941.namprd02.prod.outlook.com
 ([fe80::a974:6b60:92b:265%5]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 06:59:41 +0000
From:   Rajan Vaja <RAJANV@xilinx.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "kristo@kernel.org" <kristo@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        Michal Simek <michals@xilinx.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "quanyang.wang@windriver.com" <quanyang.wang@windriver.com>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 1/4] clk: zynqmp: Use firmware specific common clock
 flags
Thread-Topic: [PATCH v5 1/4] clk: zynqmp: Use firmware specific common clock
 flags
Thread-Index: AQHXaPLpEbVz5HSoZ0StdDVSydytWaslX9GAgAOgQ3A=
Date:   Mon, 28 Jun 2021 06:59:41 +0000
Message-ID: <BYAPR02MB394184FD49527801FE8E5389B7039@BYAPR02MB3941.namprd02.prod.outlook.com>
References: <20210624121633.22179-1-rajan.vaja@xilinx.com>
 <20210624121633.22179-2-rajan.vaja@xilinx.com>
 <162466330370.3259633.11293469583164120084@swboyd.mtv.corp.google.com>
In-Reply-To: <162466330370.3259633.11293469583164120084@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 734a106e-e435-471f-938f-08d93a024d8b
x-ms-traffictypediagnostic: BY5PR02MB6900:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB6900556CAE97C7B99496C619B7039@BY5PR02MB6900.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g2murfB8yeH+n11+U+Mo47jHzn3YtkR4o6O2wHrnKFwtWU3KNC/0JCC6hmcKbPQD+xKboyGM6MrBpPU4PAb9r+UiZj6/sXC8vs/ct69QyXKpXgzJRSyULfhh6q9L+rsSm4o6uxhK6np3sXk8yG3GWNO9YXNS/yDTHuzUi4/ws+lHXSaxm/uDAW43oZpVRBeSWg2v5GxMvU85QfP592FmkC9XFZzuSNTytRshqIFW3s+csJUYKNS1f1mENo4rQ6C1JVg+LQ2bs2sQO/0BMkK0BjP4Pu2hYYEFhn6yAeRi93dzAtBL17TelDuDZZx6Yq1+JUY1WRMtHNwf3nbe9afAmG3S/Br1XqGi93B3zonlcXfCZIjqUdlQhTT2Kqqxg3BAFMEL6SBBxeFuIgz3mkBWQH6JppROuh9vdbe9EbNXWroK2BHJTRo5ua021JjThp/LC7nXhOalcfNrjziJDd947A7kHJ5Fdg+VMlberqMRKZ5beP+IFFw5KI9FLukH3hauAcnqAeQHF1bpGUqM51S6i2Q5850hH79yeQPA0C0haYdJqdjW+TnD49j1wyNJ+s1aQFC3FANLmGf32GRxxbvyo6vSngUNJfSOBudhO6vjlzE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB3941.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39850400004)(376002)(366004)(396003)(136003)(66556008)(66446008)(71200400001)(64756008)(66476007)(33656002)(7696005)(5660300002)(8676002)(53546011)(6506007)(186003)(2906002)(38100700002)(83380400001)(54906003)(4326008)(26005)(86362001)(110136005)(478600001)(52536014)(55016002)(9686003)(122000001)(66946007)(76116006)(8936002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SG93RFlWN1V3VnMvc2ViemNkUDE1Q2ZaUnNkTzYzT0FlM0ZIclkxd09icGRX?=
 =?utf-8?B?OXNTdkZWUHhxTHI5aDNQMGlnSXdrSFAxd3RoOSsveW9zVjFrcXhnL0pVQWc0?=
 =?utf-8?B?dzgxeW12WGN3UGpjb00wTkRlMkZJdHh4ZDBndWQ5ZFBGcFRFQU9GUzRTTnNT?=
 =?utf-8?B?dmVMdFZLUjZQaWd4b3ByK2Z6Y2NJcFpmTmlScGJ2MHpTTUlQY3llU2R6ZWpW?=
 =?utf-8?B?VHdZbzM5U082bmlKOGR0WEVTelQrVVAyeXBpV28zTEZxd1J4dk41dmpCSGFw?=
 =?utf-8?B?V24rbjVsNkEwUmdxdU4ycnlmUC84TG9SMW0xRFduM3M4RXNsUWJHQm5mRG40?=
 =?utf-8?B?a2RjVGhGSTBDZ2tLMjBYUjEyZ2dmWnp0Ynd4MXphNEtYTjhEcDdLTUdUeHg1?=
 =?utf-8?B?WnhRRWVaWS9URjdXMDI0T21sWVpWUzJJR3RDNThzWFdDNzEyd1VhK1Rqb0xS?=
 =?utf-8?B?eU9sOElONmV3ejI2QXZyVUdCcG0wZVZmKzVqYkxTREQvT1g3RHlwMDJyOHcr?=
 =?utf-8?B?MFpydStTbmJVU1JPVksyVnE1RHBDdE5lWnlPRHpyeDgvQTdWT0FRNDlJYXdz?=
 =?utf-8?B?NnVKNUJHRDB1ZmNmMmFlM3RCWGtXS1JXMUVuQWdBUk1EMG13VDJJUU9URExE?=
 =?utf-8?B?VXlVb1FJL0VDQlNqU2d6QmY0Q2RXZm5ZZmNmRGhYeW1qUXN2REdFT0FUZWpa?=
 =?utf-8?B?TG5SZ1I5OHJXU0gwQTEyYm5kOFFSOFQrYjVSSEVqMXQwd1g4KzlwM0p2THgw?=
 =?utf-8?B?QXVZd1VEdUd5RWtudnRvUnZmSU9KY2FmbERNc2hmd0UwckhDNzQwWDNmbHZ4?=
 =?utf-8?B?Q0w4dnMxNmY5aEtTeTVrOEx1MUdxOTduVlROU2paQlRhUzlkQ3ppNm1jQkRi?=
 =?utf-8?B?UnpCTlBVQ2tTZmhIQ012TGJwZE4vMDZxRUJHMjRxeEljb1ZnUUFzb3didVpp?=
 =?utf-8?B?SDNiY3ZjTi94QXZqaHMyb3F5bDVZYUtBZURyVEZabG5MYVBlNEpJellSajlF?=
 =?utf-8?B?SWc4YWE5c1F4VWNqeFF6dVhvUUk5ajNKUHVuS1RvZVY0Q1Z2WmlJWEx3Qzls?=
 =?utf-8?B?aWRnZkxXdnRMK2Q2eFlXLzB5RXpKcVpyMW45YnZVSTlXUGJCVTlOM3Q1azZy?=
 =?utf-8?B?TnptMVR1anQwaDhJODRLN1VaU2lqWUl1SFFNREZLYWMzdEovM1ZJcVB5Rity?=
 =?utf-8?B?WGN5TGhaazBYY05aK0llVzIzMzEzQmxXYTVOVE9MWTBud1dNNDJPNTRTdld6?=
 =?utf-8?B?V2NTdUhEYkZUZytXcGhrbFVwdmdXQ0xwdmZTb0NRZHhxNlV4dTFQUWp2NGta?=
 =?utf-8?B?SVhHeTRBYmp2ajdKZVJjRGlhaTZZWUJaWFllY2RnYXZhR1pTQ0xrc2xCMm9w?=
 =?utf-8?B?WW00ZWVNbENTeFJuTSt2Z0IxaEJIMHh4SFJlQkVDZ2N1VEg3UVYvVDJHeFFr?=
 =?utf-8?B?bzdMUDdhWCszOUZjMFhLMndpWURkN0V2b1ZaZVIzWVJzWmZVTFpBL0RNekxS?=
 =?utf-8?B?b3ByUlo4UWN0czdZYVNJcno3YmY3amNrNkJQUmdrd0UwL3ZnRW9uSTNNN2d6?=
 =?utf-8?B?MEdhYW9uMU9ZQ2xNdDJ5ajVXT0IrMGx6ZzhkMnhERUFmYjdVQzRPNCtYRTYr?=
 =?utf-8?B?bG9lVVV2Q21BSlpkSlhTNk1BaXpkeTU4UldWVXRwOHZIaGdqZk50Sk82YWE4?=
 =?utf-8?B?Uk15cEM4ZmwraGtqczlxV3FBRlJwQ05mNmV5L3hHUW8rS1RvVzZwNlpmOEE3?=
 =?utf-8?Q?apjYS48Bi0p+h+QEPXnHY3eV+IfbpGYpxLFug5Y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB3941.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 734a106e-e435-471f-938f-08d93a024d8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 06:59:41.3585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UzJ+f7lL/AHJ2soVKTNgVH6e/U15pC7PX7jBOra27smfZt8xlQAWWowmgWqX0JGZYBAq+7OZi8miVGH17trRZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6900
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RlcGhlbiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVw
aGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgSnVuZSAyNSwgMjAy
MSA0OjIyIFBNDQo+IFRvOiBSYWphbiBWYWphIDxSQUpBTlZAeGlsaW54LmNvbT47IGtyaXN0b0Br
ZXJuZWwub3JnOyBsZWUuam9uZXNAbGluYXJvLm9yZzsNCj4gTWljaGFsIFNpbWVrIDxtaWNoYWxz
QHhpbGlueC5jb20+OyBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsNCj4gcXVhbnlhbmcud2FuZ0B3
aW5kcml2ZXIuY29tDQo+IENjOiBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBSYWphbiBWYWphIDxSQUpBTlZAeGlsaW54LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2NSAxLzRdIGNsazogenlucW1wOiBVc2UgZmlybXdhcmUgc3BlY2lmaWMgY29tbW9uIGNsb2Nr
DQo+IGZsYWdzDQo+IA0KPiBRdW90aW5nIFJhamFuIFZhamEgKDIwMjEtMDYtMjQgMDU6MTY6MzAp
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL3p5bnFtcC9jbGtjLmMgYi9kcml2ZXJzL2Ns
ay96eW5xbXAvY2xrYy5jDQo+ID4gaW5kZXggZGI4ZDBkNzE2MWNlLi5hZjA2YTE5NWVjNDYgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jbGsvenlucW1wL2Nsa2MuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvY2xrL3p5bnFtcC9jbGtjLmMNCj4gPiBAQCAtMjcxLDYgKzI3MSwzNCBAQCBzdGF0aWMgaW50
IHp5bnFtcF9wbV9jbG9ja19nZXRfdG9wb2xvZ3kodTMyDQo+IGNsb2NrX2lkLCB1MzIgaW5kZXgs
DQo+ID4gICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4NCj4gPiArdW5zaWduZWQgbG9u
ZyB6eW5xbXBfY2xrX21hcF9jb21tb25fY2NmX2ZsYWdzKGNvbnN0IHUzMiB6eW5xbXBfZmxhZykN
Cj4gPiArew0KPiA+ICsgICAgICAgdW5zaWduZWQgbG9uZyBjY2ZfZmxhZyA9IDA7DQo+ID4gKw0K
PiA+ICsgICAgICAgaWYgKHp5bnFtcF9mbGFnICYgWllOUU1QX0NMS19TRVRfUkFURV9HQVRFKQ0K
PiA+ICsgICAgICAgICAgICAgICBjY2ZfZmxhZyB8PSBDTEtfU0VUX1JBVEVfR0FURTsNCj4gPiAr
ICAgICAgIGlmICh6eW5xbXBfZmxhZyAmIFpZTlFNUF9DTEtfU0VUX1BBUkVOVF9HQVRFKQ0KPiA+
ICsgICAgICAgICAgICAgICBjY2ZfZmxhZyB8PSBDTEtfU0VUX1BBUkVOVF9HQVRFOw0KPiA+ICsg
ICAgICAgaWYgKHp5bnFtcF9mbGFnICYgWllOUU1QX0NMS19TRVRfUkFURV9QQVJFTlQpDQo+ID4g
KyAgICAgICAgICAgICAgIGNjZl9mbGFnIHw9IENMS19TRVRfUkFURV9QQVJFTlQ7DQo+ID4gKyAg
ICAgICBpZiAoenlucW1wX2ZsYWcgJiBaWU5RTVBfQ0xLX0lHTk9SRV9VTlVTRUQpDQo+ID4gKyAg
ICAgICAgICAgICAgIGNjZl9mbGFnIHw9IENMS19JR05PUkVfVU5VU0VEOw0KPiA+ICsgICAgICAg
aWYgKHp5bnFtcF9mbGFnICYgWllOUU1QX0NMS19HRVRfUkFURV9OT0NBQ0hFKQ0KPiA+ICsgICAg
ICAgICAgICAgICBjY2ZfZmxhZyB8PSBDTEtfR0VUX1JBVEVfTk9DQUNIRTsNCj4gDQo+IERvZXMg
dGhlIGZpcm13YXJlIHJlYWxseSB1c2UgYWxsIHRoZXNlIGZsYWdzPyBJZGVhbGx5IHdlIGdldCBy
aWQgb2YgdGhlDQo+IGFib3ZlIHR3by4NCj4gDQo+ID4gKyAgICAgICBpZiAoenlucW1wX2ZsYWcg
JiBaWU5RTVBfQ0xLX1NFVF9SQVRFX05PX1JFUEFSRU5UKQ0KPiA+ICsgICAgICAgICAgICAgICBj
Y2ZfZmxhZyB8PSBDTEtfU0VUX1JBVEVfTk9fUkVQQVJFTlQ7DQo+ID4gKyAgICAgICBpZiAoenlu
cW1wX2ZsYWcgJiBaWU5RTVBfQ0xLX0dFVF9BQ0NVUkFDWV9OT0NBQ0hFKQ0KPiA+ICsgICAgICAg
ICAgICAgICBjY2ZfZmxhZyB8PSBDTEtfR0VUX0FDQ1VSQUNZX05PQ0FDSEU7DQo+ID4gKyAgICAg
ICBpZiAoenlucW1wX2ZsYWcgJiBaWU5RTVBfQ0xLX1JFQ0FMQ19ORVdfUkFURVMpDQo+ID4gKyAg
ICAgICAgICAgICAgIGNjZl9mbGFnIHw9IENMS19SRUNBTENfTkVXX1JBVEVTOw0KPiANCj4gQW5k
IHRoaXMgb25lLg0KPiANCj4gPiArICAgICAgIGlmICh6eW5xbXBfZmxhZyAmIFpZTlFNUF9DTEtf
U0VUX1JBVEVfVU5HQVRFKQ0KPiA+ICsgICAgICAgICAgICAgICBjY2ZfZmxhZyB8PSBDTEtfU0VU
X1JBVEVfVU5HQVRFOw0KPiA+ICsgICAgICAgaWYgKHp5bnFtcF9mbGFnICYgWllOUU1QX0NMS19J
U19DUklUSUNBTCkNCj4gPiArICAgICAgICAgICAgICAgY2NmX2ZsYWcgfD0gQ0xLX0lTX0NSSVRJ
Q0FMOw0KPiANCj4gQW5kIHRoaXMgb25lLg0KPiANCj4gSSB3b3JyeSB0aGF0IHN1cHBvcnRpbmcg
YWxsIHRoZXNlIGZsYWdzIHdpbGwgbWVhbiB3ZSBjYW4gbmV2ZXIgZ2V0IHJpZA0KPiBvZiB0aGVt
LiBBbmQgd2UgY3VycmVudGx5IGRvbid0IHN1cHBvcnQgc2V0dGluZyBjcml0aWNhbCB2aWEgRFQs
IHdoaWNoDQo+IGlzIGVzc2VudGlhbGx5IGFub3RoZXIgZmlybXdhcmUgaW50ZXJmYWNlIGxpa2Ug
dGhpcyBvbmUuDQpbUmFqYW5dIGZpcm13YXJlIGlzIHVzaW5nIGJlbG93IGZsYWdzOg0KWllOUU1Q
X0NMS19TRVRfUkFURV9HQVRFDQpaWU5RTVBfQ0xLX1NFVF9QQVJFTlRfR0FURQ0KWllOUU1QX0NM
S19TRVRfUkFURV9QQVJFTlQNClpZTlFNUF9DTEtfSUdOT1JFX1VOVVNFRA0KWllOUU1QX0NMS19T
RVRfUkFURV9OT19SRVBBUkVOVA0KWllOUU1QX0NMS19JU19DUklUSUNBTA0KDQpPdGhlciBmbGFn
cyBhcmUgdW51c2VkLiBJIHdpbGwgcmVtb3ZlIHVudXNlZCBmbGFncyBpbiBuZXh0IHZlcnNpb24u
DQoNClRoYW5rcywNClJhamFuDQo+IA0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiBjY2ZfZmxh
ZzsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgLyoqDQo+ID4gICAqIHp5bnFtcF9jbGtfcmVnaXN0ZXJf
Zml4ZWRfZmFjdG9yKCkgLSBSZWdpc3RlciBmaXhlZCBmYWN0b3Igd2l0aCB0aGUNCj4gPiAgICog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2xvY2sgZnJhbWV3b3JrDQo=
