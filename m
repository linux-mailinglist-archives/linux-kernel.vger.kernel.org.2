Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE0B3F79E2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238909AbhHYQIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:08:55 -0400
Received: from mx20.baidu.com ([111.202.115.85]:59826 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230523AbhHYQIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:08:54 -0400
Received: from BJHW-Mail-Ex14.internal.baidu.com (unknown [10.127.64.37])
        by Forcepoint Email with ESMTPS id DF387400DBA6DCECF17B;
        Thu, 26 Aug 2021 00:08:06 +0800 (CST)
Received: from BJHW-Mail-Ex15.internal.baidu.com (10.127.64.38) by
 BJHW-Mail-Ex14.internal.baidu.com (10.127.64.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 26 Aug 2021 00:08:06 +0800
Received: from BJHW-Mail-Ex15.internal.baidu.com ([100.100.100.38]) by
 BJHW-Mail-Ex15.internal.baidu.com ([100.100.100.38]) with mapi id
 15.01.2308.014; Thu, 26 Aug 2021 00:08:06 +0800
From:   "Li,Rongqing" <lirongqing@baidu.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <michel@lespinasse.org>
CC:     "dbueso@suse.de" <dbueso@suse.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIHJidHJlZTogc3RvcCBpdGVyYXRpb24gZWFybHkg?=
 =?utf-8?B?aW4gcmJfZmluZF9maXJzdA==?=
Thread-Topic: [PATCH] rbtree: stop iteration early in rb_find_first
Thread-Index: AQHXmZfxa5733C09dkeQnFqnvZqqcauDkmoAgAAD8QCAAAGFgIAAFyIAgACziVo=
Date:   Wed, 25 Aug 2021 16:08:06 +0000
Message-ID: <e9fac96f205e4b8f94432143052f93af@baidu.com>
References: <1629885588-10590-1-git-send-email-lirongqing@baidu.com>
 <YSYr7nqql825rHol@hirez.programming.kicks-ass.net>
 <20210825115332.GA4645@lespinasse.org>
 <20210825115859.GB4645@lespinasse.org>,<YSZD6suya8fR/2uY@hirez.programming.kicks-ass.net>
In-Reply-To: <YSZD6suya8fR/2uY@hirez.programming.kicks-ass.net>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [111.205.14.1]
x-baidu-bdmsfe-datecheck: 1_BJHW-Mail-Ex14_2021-08-26 00:08:06:822
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4+IA0KPj4gIA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIDEwDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAvDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgNQ0K
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXA0KPj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAxMA0KPj4gIA0KPj4g
VGhlIHNlYXJjaCB3b3VsZCBzdG9wIGFmdGVyIHZpc2l0aW5nIG5vZGUgNSwgYW5kIG1pc3MgdGhl
IGxlYWYgd2hpY2gNCj4+IGlzIHRoZSBleHBlY3RlZCBub2RlIHRvIGJlIHJldHVybmVkLg0KDQog
dGhhbmtzIGZvciBleHBsYW5hdGlvbi4NCg0KPiBKdXN0IHRvIGNsYXJpZnk7IHRoZSBjdXJyZW50
IGNvZGUgKmRvZXMqIHdvcmsgaGVyZS4gVGhlIHByb3Bvc2VkIHBhdGNoDQo+IGJyZWFrcyBpdC4N
Cg0KdHJ1ZSwgbXkgcGF0Y2ggaXMgd3JvbmcuDQoNCmJ1dCByYl9maW5kX2ZpcnN0IHNlZW1zIGhh
dmUgb3RoZXIgaXNzdWUuwqAgd2hlbiB0aGUga2V5IGlzIGVxdWFsLCB3ZSBzaG91bGQgc2VhcmNo
IHJpZ2h0IGxlYWYsIG5vdCBsZWZ0IGxlYWYNCnJiX2ZpbmRfZmlyc3Qgc2hvdWxkIGxpa2UgYmVs
b3cNCg0KCXdoaWxlIChub2RlKSB7DQoJCWludCBjID0gY21wKGtleSwgbm9kZSk7DQoNCgkJaWYg
KGMgPCAwKSB7DQoJCQlub2RlID0gbm9kZS0+cmJfbGVmdDsNCgkJfSBlbHNlIHsNCgkJCWlmICgh
YykNCgkJCQltYXRjaCA9IG5vZGU7DQoJCQlub2RlID0gbm9kZS0+cmJfcmlnaHQ7DQoJCX0NCgl9
DQrCoA0Kc2luY2UgdGhlIG5vZGXCoMKgaXMgaW5zZXJ0ZWQgdG8gcmlnaHQgd2hlbiB0aGUga2V5
IGlzIGVxdWFsLCBzZWUgcmJfYWRkKCkNCg0KIC1MaQ0KDQo=
