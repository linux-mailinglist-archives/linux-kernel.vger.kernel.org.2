Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285704286F8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 08:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbhJKGq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 02:46:57 -0400
Received: from mx24.baidu.com ([111.206.215.185]:40916 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229797AbhJKGq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 02:46:56 -0400
Received: from BJHW-Mail-Ex01.internal.baidu.com (unknown [10.127.64.11])
        by Forcepoint Email with ESMTPS id 10A9125333B5ECEE11EB;
        Mon, 11 Oct 2021 14:44:47 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex01.internal.baidu.com (10.127.64.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Mon, 11 Oct 2021 14:44:47 +0800
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Mon, 11 Oct 2021 14:44:46 +0800
Received: from BJHW-MAIL-EX27.internal.baidu.com ([169.254.58.247]) by
 BJHW-MAIL-EX27.internal.baidu.com ([169.254.58.247]) with mapi id
 15.01.2308.014; Mon, 11 Oct 2021 14:44:46 +0800
From:   "Cai,Huoqing" <caihuoqing@baidu.com>
To:     "vigneshr@ti.com" <vigneshr@ti.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Subject: RE: [PATCH] MAINTAINERS: Update the devicetree documentation path of
 hyperbus
Thread-Topic: [PATCH] MAINTAINERS: Update the devicetree documentation path of
 hyperbus
Thread-Index: AQHXvNbBOZ4gVKSIN0mR+yCEygV/8qvNXIhg
Date:   Mon, 11 Oct 2021 06:44:46 +0000
Message-ID: <5d496515614a468881a896c2494add37@baidu.com>
References: <20211009062740.833-1-caihuoqing@baidu.com>
In-Reply-To: <20211009062740.833-1-caihuoqing@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.12.190.132]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQorQ2MgdmlnbmVzaHJAdGkuY29tLCBsaW51eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9y
Zw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENhaSxIdW9xaW5nIDxj
YWlodW9xaW5nQGJhaWR1LmNvbT4NCj4gU2VudDogMjAyMcTqMTDUwjnI1SAxNDoyOA0KPiBUbzog
Q2FpLEh1b3FpbmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVj
dDogW1BBVENIXSBNQUlOVEFJTkVSUzogVXBkYXRlIHRoZSBkZXZpY2V0cmVlIGRvY3VtZW50YXRp
b24gcGF0aCBvZg0KPiBoeXBlcmJ1cw0KPiANCj4gQ2hhbmdlIHRoZSBkZXZpY2V0cmVlIGRvY3Vt
ZW50YXRpb24gcGF0aA0KPiB0byAiRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL210
ZC90aSxhbTY1NC1oYm1jLnlhbWwiDQo+IHNpbmNlICdjeXByZXNzLGh5cGVyZmxhc2gudHh0JyBh
bmQgJ3RpLGFtNjU0LWhibWMudHh0JyBoYXZlDQo+IGJlZW4gY29udmVydGVkIHRvICd0aSxhbTY1
NC1oYm1jLnlhbWwnLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2FpIEh1b3FpbmcgPGNhaWh1b3Fp
bmdAYmFpZHUuY29tPg0KPiAtLS0NCj4gIE1BSU5UQUlORVJTIHwgMyArLS0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQo+IGluZGV4IDliMjU1Y2Y0ZmNhOC4uNDg5NDlj
ZDdmODk4IDEwMDY0NA0KPiAtLS0gYS9NQUlOVEFJTkVSUw0KPiArKysgYi9NQUlOVEFJTkVSUw0K
PiBAQCAtODc4Myw4ICs4NzgzLDcgQEAgUzoJU3VwcG9ydGVkDQo+ICBROglodHRwOi8vcGF0Y2h3
b3JrLm96bGFicy5vcmcvcHJvamVjdC9saW51eC1tdGQvbGlzdC8NCj4gIEM6CWlyYzovL2lyYy5v
ZnRjLm5ldC9tdGQNCj4gIFQ6CWdpdCBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4
L2tlcm5lbC9naXQvbXRkL2xpbnV4LmdpdCBjZmkvbmV4dA0KPiAtRjoJRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9jeXByZXNzLGh5cGVyZmxhc2gudHh0DQo+IC1GOglEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL3RpLGFtNjU0LWhibWMudHh0DQo+ICtG
OglEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL3RpLGFtNjU0LWhibWMueWFt
bA0KPiAgRjoJZHJpdmVycy9tdGQvaHlwZXJidXMvDQo+ICBGOglpbmNsdWRlL2xpbnV4L210ZC9o
eXBlcmJ1cy5oDQo+IA0KPiAtLQ0KPiAyLjI1LjENCg0K
