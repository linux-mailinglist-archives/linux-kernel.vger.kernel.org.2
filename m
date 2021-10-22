Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEF94370BF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 06:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhJVEVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 00:21:43 -0400
Received: from mx22.baidu.com ([220.181.50.185]:43178 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229463AbhJVEVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 00:21:42 -0400
Received: from BC-Mail-Ex31.internal.baidu.com (unknown [172.31.51.25])
        by Forcepoint Email with ESMTPS id CD9BBDFC8AD8CA59801D;
        Fri, 22 Oct 2021 12:19:23 +0800 (CST)
Received: from BJHW-Mail-Ex16.internal.baidu.com (10.127.64.39) by
 BC-Mail-Ex31.internal.baidu.com (172.31.51.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Fri, 22 Oct 2021 12:19:23 +0800
Received: from BJHW-Mail-Ex15.internal.baidu.com (10.127.64.38) by
 BJHW-Mail-Ex16.internal.baidu.com (10.127.64.39) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 22 Oct 2021 12:19:22 +0800
Received: from BJHW-Mail-Ex15.internal.baidu.com ([100.100.100.38]) by
 BJHW-Mail-Ex15.internal.baidu.com ([100.100.100.38]) with mapi id
 15.01.2308.014; Fri, 22 Oct 2021 12:19:22 +0800
From:   "Li,Rongqing" <lirongqing@baidu.com>
To:     Michel Lespinasse <michel@lespinasse.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@kernel.org" <mingo@kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSByYnRyZWU6IFJlbW92ZSB1bm5lZWRlZCBjaGVjayBj?=
 =?gb2312?B?b25kaXRpb24gaW4gcmJfZmluZF9maXJzdA==?=
Thread-Topic: [PATCH] rbtree: Remove unneeded check condition in rb_find_first
Thread-Index: AQHXtk67qDCXZ9JKBUOf9Klxd8vGjaveiukw
Date:   Fri, 22 Oct 2021 04:19:22 +0000
Message-ID: <5a3a7c84bfb94d26a2d6e88e86f6edda@baidu.com>
References: <1632986196-20074-1-git-send-email-lirongqing@baidu.com>
 <20210930225850.GA6434@lespinasse.org>
In-Reply-To: <20210930225850.GA6434@lespinasse.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.206.4]
x-baidu-bdmsfe-datecheck: 1_BJHW-Mail-Ex16_2021-10-22 12:19:23:010
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGluZw0KDQotTGkNCg0KPiBPbiBUaHUsIFNlcCAzMCwgMjAyMSBhdCAwMzoxNjozNlBNICswODAw
LCBMaSBSb25nUWluZyB3cm90ZToNCj4gPiB0aGUgdmFyaWFibGUgYyBpcyBpbnQgdHlwZSwgc28g
Y2hhbmdlIHRoZSBmb2xsb3dpbmcgY29uZGl0aW9uDQo+ID4NCj4gPiAJIGlmIChjIDw9IDApIHsN
Cj4gPg0KPiA+IAkgfQ0KPiA+IAkgZWxzZSBpZiAoYyA+IDApIHsNCj4gPg0KPiA+IAkgfQ0KPiA+
IGFzOg0KPiA+IAkgaWYgKGMgPD0gMCkgew0KPiA+DQo+ID4gCSB9DQo+ID4gCSBlbHNlIHsNCj4g
Pg0KPiA+IAkgfQ0KPiA+DQo+ID4gU3BvdHRlZC1ieTogTWljaGVsIExlc3BpbmFzc2UgPDxtaWNo
ZWxAbGVzcGluYXNzZS5vcmc+Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IExpIFJvbmdRaW5nIDxsaXJv
bmdxaW5nQGJhaWR1LmNvbT4NCj4gPiAtLS0NCj4gPiAgaW5jbHVkZS9saW51eC9yYnRyZWUuaCB8
ICAgIDIgKy0NCj4gPiAgMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9yYnRyZWUuaCBiL2lu
Y2x1ZGUvbGludXgvcmJ0cmVlLmggaW5kZXgNCj4gPiAyMzUwNDdkLi5kNWFjOGY3IDEwMDY0NA0K
PiA+IC0tLSBhL2luY2x1ZGUvbGludXgvcmJ0cmVlLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4
L3JidHJlZS5oDQo+ID4gQEAgLTI5NCw3ICsyOTQsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgcmJf
cmVwbGFjZV9ub2RlX2NhY2hlZChzdHJ1Y3QNCj4gcmJfbm9kZSAqdmljdGltLA0KPiA+ICAJCQlp
ZiAoIWMpDQo+ID4gIAkJCQltYXRjaCA9IG5vZGU7DQo+ID4gIAkJCW5vZGUgPSBub2RlLT5yYl9s
ZWZ0Ow0KPiA+IC0JCX0gZWxzZSBpZiAoYyA+IDApIHsNCj4gPiArCQl9IGVsc2Ugew0KPiA+ICAJ
CQlub2RlID0gbm9kZS0+cmJfcmlnaHQ7DQo+ID4gIAkJfQ0KPiA+ICAJfQ0KPiANCj4gTG9va3Mg
Z29vZCB0byBtZSwgdGhhbmtzIGZvciB0aGUgZml4Lg0KPiANCj4gUmV2aWV3ZWQtYnk6IE1pY2hl
bCBMZXNwaW5hc3NlIDxtaWNoZWxAbGVzcGluYXNzZS5vcmc+DQo+IA0KPiAtLQ0KPiBNaWNoZWwg
IndhbGtlbiIgTGVzcGluYXNzZQ0K
