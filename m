Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E7E343827
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 06:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhCVFIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 01:08:47 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3374 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhCVFIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 01:08:24 -0400
Received: from DGGEML404-HUB.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4F3jBQ2hWsz5WZB;
        Mon, 22 Mar 2021 13:05:50 +0800 (CST)
Received: from dggema721-chm.china.huawei.com (10.3.20.85) by
 DGGEML404-HUB.china.huawei.com (10.3.17.39) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 22 Mar 2021 13:08:18 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggema721-chm.china.huawei.com (10.3.20.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 22 Mar 2021 13:08:18 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.013;
 Mon, 22 Mar 2021 13:08:18 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>
CC:     "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xuwei (O)" <xuwei5@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        yangyicong <yangyicong@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: RE: [Linuxarm]  Re: [PATCH] sched/fair: remove redundant
 test_idle_cores for non-smt
Thread-Topic: [Linuxarm]  Re: [PATCH] sched/fair: remove redundant
 test_idle_cores for non-smt
Thread-Index: AQHXHddXuHcs+4JUY0qe6RO3UWlyCqqO6BUAgACMBHA=
Date:   Mon, 22 Mar 2021 05:08:18 +0000
Message-ID: <c7b21aa948c04d45947dde153d28fa88@hisilicon.com>
References: <20210320221432.924-1-song.bao.hua@hisilicon.com>
 <5da632c1-382f-5c23-531e-98899cbe1abb@linux.intel.com>
In-Reply-To: <5da632c1-382f-5c23-531e-98899cbe1abb@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.249]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGksIEF1YnJleSBbbWFp
bHRvOmF1YnJleS5saUBsaW51eC5pbnRlbC5jb21dDQo+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMjIs
IDIwMjEgNTozNyBQTQ0KPiBUbzogU29uZyBCYW8gSHVhIChCYXJyeSBTb25nKSA8c29uZy5iYW8u
aHVhQGhpc2lsaWNvbi5jb20+Ow0KPiB2aW5jZW50Lmd1aXR0b3RAbGluYXJvLm9yZzsgbWluZ29A
cmVkaGF0LmNvbTsgcGV0ZXJ6QGluZnJhZGVhZC5vcmc7DQo+IGp1cmkubGVsbGlAcmVkaGF0LmNv
bTsgZGlldG1hci5lZ2dlbWFubkBhcm0uY29tOyByb3N0ZWR0QGdvb2RtaXMub3JnOw0KPiBic2Vn
YWxsQGdvb2dsZS5jb207IG1nb3JtYW5Ac3VzZS5kZQ0KPiBDYzogdmFsZW50aW4uc2NobmVpZGVy
QGFybS5jb207IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgeHV3ZWkgKE8pIDx4dXdlaTVAaHVhd2VpLmNvbT47IFpl
bmd0YW8gKEIpDQo+IDxwcmltZS56ZW5nQGhpc2lsaWNvbi5jb20+OyBndW9kb25nLnh1QGxpbmFy
by5vcmc7IHlhbmd5aWNvbmcNCj4gPHlhbmd5aWNvbmdAaHVhd2VpLmNvbT47IExpZ3Vvemh1IChL
ZW5uZXRoKSA8bGlndW96aHVAaGlzaWxpY29uLmNvbT47DQo+IGxpbnV4YXJtQG9wZW5ldWxlci5v
cmcNCj4gU3ViamVjdDogW0xpbnV4YXJtXSBSZTogW1BBVENIXSBzY2hlZC9mYWlyOiByZW1vdmUg
cmVkdW5kYW50IHRlc3RfaWRsZV9jb3Jlcw0KPiBmb3Igbm9uLXNtdA0KPiANCj4gSGkgQmFycnks
DQo+IA0KPiBPbiAyMDIxLzMvMjEgNjoxNCwgQmFycnkgU29uZyB3cm90ZToNCj4gPiB1cGRhdGVf
aWRsZV9jb3JlKCkgaXMgb25seSBkb25lIGZvciB0aGUgY2FzZSBvZiBzY2hlZF9zbXRfcHJlc2Vu
dC4NCj4gPiBidXQgdGVzdF9pZGxlX2NvcmVzKCkgaXMgZG9uZSBmb3IgYWxsIG1hY2hpbmVzIGV2
ZW4gdGhvc2Ugd2l0aG91dA0KPiA+IHNtdC4NCj4gDQo+IFRoZSBwYXRjaCBsb29rcyBnb29kIHRv
IG1lLg0KPiBNYXkgSSBrbm93IGZvciB3aGF0IGNhc2Ugd2UgbmVlZCB0byBrZWVwIENPTkZJR19T
Q0hFRF9TTVQgZm9yIG5vbi1zbXQNCj4gbWFjaGluZXM/DQoNCg0KSGkgQXVicmV5LA0KDQpJIHRo
aW5rIHRoZSBkZWZjb25maWcgb2YgYXJtNjQgaGFzIGFsd2F5cyBlbmFibGVkDQpDT05GSUdfU0NI
RURfU01UOg0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQv
dG9ydmFsZHMvbGludXguZ2l0L3RyZWUvYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZw0KDQpp
dCBpcyBwcm9iYWJseSB0cnVlIGZvciB4ODYgYXMgd2VsbC4NCg0KSSBkb24ndCB0aGluayBMaW51
eCBkaXN0cmlidXRpb24gd2lsbCBidWlsZCBhIHNlcGFyYXRlIGtlcm5lbA0KZm9yIG1hY2hpbmVz
IHdpdGhvdXQgc210LiBzbyBiYXNpY2FsbHkgdGhlIGtlcm5lbCBkZXBlbmRzIG9uDQpydW50aW1l
IHRvcG9sb2d5IHBhcnNlIHRvIGZpZ3VyZSBvdXQgaWYgc210IGlzIHByZXNlbnQgcmF0aGVyDQp0
aGFuIGRlcGVuZGluZyBvbiBhIHJlYnVpbGQuDQoNCg0KPiANCj4gVGhhbmtzLA0KPiAtQXVicmV5
DQo+IA0KPiANCj4gPiB0aGlzIGNvdWxkIGNvbnRyaWJ1dGUgdG8gdXAgOCUrIGhhY2tiZW5jaCBw
ZXJmb3JtYW5jZSBsb3NzIG9uIGENCj4gPiBtYWNoaW5lIGxpa2Uga3VucGVuZyA5MjAgd2hpY2gg
aGFzIG5vIHNtdC4gdGhpcyBwYXRjaCByZW1vdmVzIHRoZQ0KPiA+IHJlZHVuZGFudCB0ZXN0X2lk
bGVfY29yZXMoKSBmb3Igbm9uLXNtdCBtYWNoaW5lcy4NCj4gPg0KPiA+IHdlIHJ1biB0aGUgYmVs
b3cgaGFja2JlbmNoIHdpdGggZGlmZmVyZW50IC1nIHBhcmFtZXRlciBmcm9tIDIgdG8NCj4gPiAx
NCwgZm9yIGVhY2ggZGlmZmVyZW50IGcsIHdlIHJ1biB0aGUgY29tbWFuZCAxMCB0aW1lcyBhbmQg
Z2V0IHRoZQ0KPiA+IGF2ZXJhZ2UgdGltZToNCj4gPiAkIG51bWFjdGwgLU4gMCBoYWNrYmVuY2gg
LXAgLVQgLWwgMjAwMDAgLWcgJDENCj4gPg0KPiA+IGhhY2tiZW5jaCB3aWxsIHJlcG9ydCB0aGUg
dGltZSB3aGljaCBpcyBuZWVkZWQgdG8gY29tcGxldGUgYSBjZXJ0YWluDQo+ID4gbnVtYmVyIG9m
IG1lc3NhZ2VzIHRyYW5zbWlzc2lvbnMgYmV0d2VlbiBhIGNlcnRhaW4gbnVtYmVyIG9mIHRhc2tz
LA0KPiA+IGZvciBleGFtcGxlOg0KPiA+ICQgbnVtYWN0bCAtTiAwIGhhY2tiZW5jaCAtcCAtVCAt
bCAyMDAwMCAtZyAxMA0KPiA+IFJ1bm5pbmcgaW4gdGhyZWFkZWQgbW9kZSB3aXRoIDEwIGdyb3Vw
cyB1c2luZyA0MCBmaWxlIGRlc2NyaXB0b3JzIGVhY2gNCj4gPiAoPT0gNDAwIHRhc2tzKQ0KPiA+
IEVhY2ggc2VuZGVyIHdpbGwgcGFzcyAyMDAwMCBtZXNzYWdlcyBvZiAxMDAgYnl0ZXMNCj4gPg0K
PiA+IFRoZSBiZWxvdyBpcyB0aGUgcmVzdWx0IG9mIGhhY2tiZW5jaCB3LyBhbmQgdy9vIHRoaXMg
cGF0Y2g6DQo+ID4gZz0gICAgMiAgICAgIDQgICAgIDYgICAgICAgOCAgICAgIDEwICAgICAxMiAg
ICAgIDE0DQo+ID4gdy9vOiAxLjgxNTEgMy44NDk5IDUuNTE0MiA3LjI0OTEgOS4wMzQwIDEwLjcz
NDUgMTIuMDkyOQ0KPiA+IHcvIDogMS44NDI4IDMuNzQzNiA1LjQ1MDEgNi45NTIyIDguMjg4MiAg
OS45NTM1IDExLjMzNjcNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICs0LjElICArOC4z
JSAgKzcuMyUgICArNi4zJQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmFycnkgU29uZyA8c29u
Zy5iYW8uaHVhQGhpc2lsaWNvbi5jb20+DQo+ID4gLS0tDQo+ID4gIGtlcm5lbC9zY2hlZC9mYWly
LmMgfCA4ICsrKysrLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEva2VybmVsL3NjaGVkL2ZhaXIuYyBi
L2tlcm5lbC9zY2hlZC9mYWlyLmMNCj4gPiBpbmRleCAyZTJhYjFlLi5kZTQyYTMyIDEwMDY0NA0K
PiA+IC0tLSBhL2tlcm5lbC9zY2hlZC9mYWlyLmMNCj4gPiArKysgYi9rZXJuZWwvc2NoZWQvZmFp
ci5jDQo+ID4gQEAgLTYwMzgsOSArNjAzOCwxMSBAQCBzdGF0aWMgaW5saW5lIGJvb2wgdGVzdF9p
ZGxlX2NvcmVzKGludCBjcHUsIGJvb2wgZGVmKQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3Qgc2NoZWRf
ZG9tYWluX3NoYXJlZCAqc2RzOw0KPiA+DQo+ID4gLQlzZHMgPSByY3VfZGVyZWZlcmVuY2UocGVy
X2NwdShzZF9sbGNfc2hhcmVkLCBjcHUpKTsNCj4gPiAtCWlmIChzZHMpDQo+ID4gLQkJcmV0dXJu
IFJFQURfT05DRShzZHMtPmhhc19pZGxlX2NvcmVzKTsNCj4gPiArCWlmIChzdGF0aWNfYnJhbmNo
X2xpa2VseSgmc2NoZWRfc210X3ByZXNlbnQpKSB7DQo+ID4gKwkJc2RzID0gcmN1X2RlcmVmZXJl
bmNlKHBlcl9jcHUoc2RfbGxjX3NoYXJlZCwgY3B1KSk7DQo+ID4gKwkJaWYgKHNkcykNCj4gPiAr
CQkJcmV0dXJuIFJFQURfT05DRShzZHMtPmhhc19pZGxlX2NvcmVzKTsNCj4gPiArCX0NCj4gPg0K
PiA+ICAJcmV0dXJuIGRlZjsNCj4gPiAgfQ0KDQpUaGFua3MNCkJhcnJ5DQoNCg==
