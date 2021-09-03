Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAF83FF92E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 06:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhICEAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 00:00:15 -0400
Received: from mx21.baidu.com ([220.181.3.85]:39420 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229481AbhICEAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 00:00:14 -0400
Received: from Bc-Mail-Ex13.internal.baidu.com (unknown [172.31.51.53])
        by Forcepoint Email with ESMTPS id 5CAB279588733DD13411;
        Fri,  3 Sep 2021 11:59:08 +0800 (CST)
Received: from BJHW-Mail-Ex15.internal.baidu.com (10.127.64.38) by
 Bc-Mail-Ex13.internal.baidu.com (172.31.51.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Fri, 3 Sep 2021 11:59:08 +0800
Received: from BJHW-Mail-Ex15.internal.baidu.com ([100.100.100.38]) by
 BJHW-Mail-Ex15.internal.baidu.com ([100.100.100.38]) with mapi id
 15.01.2308.014; Fri, 3 Sep 2021 11:59:08 +0800
From:   "Li,Rongqing" <lirongqing@baidu.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1Jlc2VuZF1bUEFUQ0hdIHNjaGVkL2ZhaXI6IG1pY3JvLW9wdGlt?=
 =?gb2312?B?aXplIHBpY2tfbmV4dF9lbnRpdHkoKQ==?=
Thread-Topic: [Resend][PATCH] sched/fair: micro-optimize pick_next_entity()
Thread-Index: AQHXmXpTtX+GjcL/s0yQXbsQCHGtUquNKpuAgASRAzA=
Date:   Fri, 3 Sep 2021 03:59:08 +0000
Message-ID: <ccbb34c46fe74d11a93c8514f0ba9936@baidu.com>
References: <1629872869-19829-1-git-send-email-lirongqing@baidu.com>
 <YS44IzVARx2ZaEUo@hirez.programming.kicks-ass.net>
In-Reply-To: <YS44IzVARx2ZaEUo@hirez.programming.kicks-ass.net>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.194.62]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS3Tyrz+1K28/i0tLS0tDQo+ILeivP7IyzogUGV0ZXIgWmlqbHN0cmEgPHBldGVy
ekBpbmZyYWRlYWQub3JnPg0KPiC3osvNyrG85DogMjAyMcTqONTCMzHI1SAyMjoxMA0KPiDK1bz+
yMs6IExpLFJvbmdxaW5nIDxsaXJvbmdxaW5nQGJhaWR1LmNvbT4NCj4gs63LzTogbWluZ29AcmVk
aGF0LmNvbTsganVyaS5sZWxsaUByZWRoYXQuY29tOyB2aW5jZW50Lmd1aXR0b3RAbGluYXJvLm9y
ZzsNCj4gZGlldG1hci5lZ2dlbWFubkBhcm0uY29tOyByb3N0ZWR0QGdvb2RtaXMub3JnOyBic2Vn
YWxsQGdvb2dsZS5jb207DQo+IG1nb3JtYW5Ac3VzZS5kZTsgYnJpc3RvdEByZWRoYXQuY29tOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+INb3zOI6IFJlOiBbUmVzZW5kXVtQQVRDSF0g
c2NoZWQvZmFpcjogbWljcm8tb3B0aW1pemUgcGlja19uZXh0X2VudGl0eSgpDQo+IA0KPiBPbiBX
ZWQsIEF1ZyAyNSwgMjAyMSBhdCAwMjoyNzo0OVBNICswODAwLCBMaSBSb25nUWluZyB3cm90ZToN
Cj4gPiBPbmx5IGNoZWNrIHRoZSBza2lwIGJ1ZGR5IHdoZW4gbmV4dCBidWRkeSBhbmQgbGFzdCBi
dWRkeSBhcmUgbm90DQo+ID4gcGlja2VkIHVwLCB0aGlzIGNhbiBzYXZlIHRoZSBjeWNsZXMgb2Yg
Y2hlY2tpbmcgdGhlIHNraXAgYnVkZHkgYW5kDQo+ID4gY29tcHV0YXRpb24gb2YgdGhlIHNlY29u
ZCBidWRkeSwgd2hlbiBuZXh0IGFuZCBsYXN0IGJ1ZGR5IHdpbGwgYmUNCj4gPiBwaWNrZWQgdXAg
Zm9yIGV4YW1wbGUsIHlpZWxkX3RvX3Rhc2tfZmFpcigpIHNldCBib3RoIG5leHQgYW5kIHNraXAN
Cj4gPiBidWRkeQ0KPiANCj4gSXMgdGhhdCBhY3R1YWxseSBtZWFzdXJhYmxlPw0KPiANCj4gQnV0
IGxvb2tpbmcgYXQgaXQsIHNob3VsZCB3ZSBub3QsIGluc3RlYWQsIG1vdmUgdGhlIHdob2xlIC0+
c2tpcCB0aGluZyB0byB0aGUNCj4gYm90dG9tLCBzbyB3ZSB1bmNvbmRpdGlvbmFsbHkgY2hlY2sg
aXQgdnMgdGhlIHJlc3VsdCBvZg0KPiAtPm5leHQvLT5sYXN0ID8NCj4gDQo+IEltYWdpbmUgLT5u
ZXh0ID09IC0+c2tpcCwgdGhlbiB3ZSB3YW50IHRvIGF2b2lkIHJ1bm5pbmcgaXQgYW5kIG5vdCBo
YXZlDQo+IC0+bmV4dCB3aW4uDQoNCnNraXAgbWVhbnMgdGhpcyB0YXNrIGlzIHJ1bm5pbmcgb24g
Y3B1LCBuZXh0IGlzIHRoZSBibG9ja2VkIHRhc2sgYW5kIHdpbGwgYmUgcnVubmluZy4NCg0KSSBk
b25vdCBrbm93IGhvdyB0aGV5IGNhbiBiZSBzYW1lLg0KDQotTGkNCg==
