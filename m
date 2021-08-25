Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841B23F7C31
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 20:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237121AbhHYS1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 14:27:50 -0400
Received: from mx20.baidu.com ([111.202.115.85]:56322 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236451AbhHYS1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 14:27:49 -0400
Received: from BJHW-Mail-Ex13.internal.baidu.com (unknown [10.127.64.36])
        by Forcepoint Email with ESMTPS id D142FE7C2592BD3FE5B4;
        Thu, 26 Aug 2021 02:26:59 +0800 (CST)
Received: from BJHW-Mail-Ex15.internal.baidu.com (10.127.64.38) by
 BJHW-Mail-Ex13.internal.baidu.com (10.127.64.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 26 Aug 2021 02:26:59 +0800
Received: from BJHW-Mail-Ex15.internal.baidu.com ([100.100.100.38]) by
 BJHW-Mail-Ex15.internal.baidu.com ([100.100.100.38]) with mapi id
 15.01.2308.014; Thu, 26 Aug 2021 02:26:59 +0800
From:   "Li,Rongqing" <lirongqing@baidu.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Michel Lespinasse <michel@lespinasse.org>,
        "dbueso@suse.de" <dbueso@suse.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSF0gcmJ0cmVlOiBzdG9wIGl0ZXJhdGlv?=
 =?utf-8?B?biBlYXJseSBpbiByYl9maW5kX2ZpcnN0?=
Thread-Topic: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIHJidHJlZTogc3RvcCBpdGVyYXRpb24gZWFybHkg?=
 =?utf-8?B?aW4gcmJfZmluZF9maXJzdA==?=
Thread-Index: AQHXmZfxa5733C09dkeQnFqnvZqqcauDkmoAgAAD8QCAAAGFgIAAFyIAgACvD1///5MtAIAAlobR
Date:   Wed, 25 Aug 2021 18:26:59 +0000
Message-ID: <000ff2757fc24d91ade7cab0195ab9b4@baidu.com>
References: <1629885588-10590-1-git-send-email-lirongqing@baidu.com>
 <YSYr7nqql825rHol@hirez.programming.kicks-ass.net>
 <20210825115332.GA4645@lespinasse.org> <20210825115859.GB4645@lespinasse.org>
 <YSZD6suya8fR/2uY@hirez.programming.kicks-ass.net>
 <90ea3457ddc7485fbc8db5f7ca5b07ab@baidu.com>,<20210825171850.GD17784@worktop.programming.kicks-ass.net>
In-Reply-To: <20210825171850.GD17784@worktop.programming.kicks-ass.net>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [111.205.14.1]
x-baidu-bdmsfe-datecheck: 1_BJHW-Mail-Ex13_2021-08-26 02:26:59:932
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCg0KDQoNCg0KDQoNCsKgICAgDQpPbiBXZWQsIEF1ZyAyNSwgMjAyMSBhdCAwNDowMTo1M1BN
ICswMDAwLCBMaSxSb25ncWluZyB3cm90ZToNCj4gDQo+ID4+DQo+ID4+DQo+ID4+wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDEwDQo+ID4+wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLw0KPiA+PsKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA1DQo+ID4+wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXA0KPiA+PsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgMTANCg0KPlRoYXQgYWdhaW4gYnJlYWtzIHRoZSBhYm92ZSBj
YXNlLg0KDQogICAgICAgICAgICAgICAgICAgICAgIDEwDQogICAgICAgICAgICAgICAgICAgICAv
DQogICAgICAgICAgICAgICAgICAgIDUNCiAgICAgICAgICAgICAgICAgICAgICAgXA0KICAgICAg
ICAgICAgICAgICAgICAgIDEwDQoNCnRoZSBhYm92ZSBjYXNlIHNob3VsZCBub3QgZXhpc3QuIGxp
a2UgYmVsb3csIHdoZW4gc2Vjb25kIDEwIGlzIGluc2VydGVkLCBpdCBzaG91bGQgYmUgaW5zZXJ0
ZWQgdG8gcmlnaHQgbGVhZg0KICAgICAgICAgICAgICAgICAgICAgICAxMA0KICAgICAgICAgICAg
ICAgICAgICAgLw0KICAgICAgICAgICAgICAgICAgICA1DQoNCmFzIGEgcmVzdWx0LCBpdCBzaG91
bGQgYmUNCg0KICAgICAgICAgICAgICAgICAgICAgICAxMA0KICAgICAgICAgICAgICAgICAgICAg
LyAgICAgXA0KICAgICAgICAgICAgICAgICAgICA1ICAgICAgMTANCg0Kc2luY2UgMTAgaXMgbm90
IGxlc3MgMTAsIHNvIG5ldyAxMCBpcyBpbnNlcnRlZCB0byByaWdodC4NCmFuZCBpdCBkZXBlbmRz
IG9uIA0KYm9vbCAoKmxlc3MpKHN0cnVjdCByYl9ub2RlICosIGNvbnN0IHN0cnVjdCByYl9ub2Rl
ICopIHdoaWNoIG5vdCByZXR1cm4gdHJ1ZSB3aGVuIGVxdWFsDQoNCnRoaXMgY2FzZSBzaG91bGQg
YmUgb2sNCiAgICAgICAgICAgICAgICAgICAgICAgMTANCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgIDEyDQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgLw0KICAgICAgICAgICAgICAgICAgICAgICAgICAxMA0KDQotTGkNCg0KDQoNCg0K
DQoNCg0KICAgIA==
