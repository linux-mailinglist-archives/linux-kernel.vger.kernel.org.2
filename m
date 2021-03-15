Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4995633AEF1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 10:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhCOJi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 05:38:57 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38390 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229460AbhCOJi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 05:38:26 -0400
X-UUID: 477c428a4827495a83b913091db26065-20210315
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=bPuVjFo6Jbk+asJxO6pPeVmiKh3ForgwpqM3f8bjyIU=;
        b=D8SU/ZVBdKxsZkYa6Cqe2YcW+4ELDG5XNzRf0RbQqll10KC5b8y70nYffihvYjhqqYG7AvoruoKnAMRmnOQ1IyJjs4OvvnRN7VwTqSjhpm7IAOPhQKW++ov88gX1N4yNnoNObIDQzHUkoQR1gpgN6wLKQXtC3r/vfzD098FSqJo=;
X-UUID: 477c428a4827495a83b913091db26065-20210315
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1031721851; Mon, 15 Mar 2021 17:38:24 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 15 Mar 2021 17:38:22 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 15 Mar 2021 17:38:22 +0800
Message-ID: <1615801102.24887.4.camel@mtksdccf07>
Subject: Re: [PATCH] task_work: kasan: record task_work_add() call stack
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Dmitry Vyukov <dvyukov@google.com>
CC:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Andrey Konovalov" <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>
Date:   Mon, 15 Mar 2021 17:38:22 +0800
In-Reply-To: <CACT4Y+YrFeRQkw+M8rpOF5169LFn9+puL3Dh1Kk1AOoKV-nyrQ@mail.gmail.com>
References: <20210315015940.11788-1-walter-zh.wu@mediatek.com>
         <CACT4Y+YrFeRQkw+M8rpOF5169LFn9+puL3Dh1Kk1AOoKV-nyrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 3B89127E2864DD5DFFD3E95D33CE31C96FF11CB243C9301855A3735564F8F2002000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTAzLTE1IGF0IDA3OjU4ICswMTAwLCAnRG1pdHJ5IFZ5dWtvdicgdmlhIGth
c2FuLWRldiB3cm90ZToNCj4gT24gTW9uLCBNYXIgMTUsIDIwMjEgYXQgMzowMCBBTSBXYWx0ZXIg
V3UgPHdhbHRlci16aC53dUBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gV2h5IHJlY29y
ZCB0YXNrX3dvcmtfYWRkKCkgY2FsbCBzdGFjaz8NCj4gPiBTeXpib3QgcmVwb3J0cyBtYW55IHVz
ZS1hZnRlci1mcmVlIGlzc3VlcyBmb3IgdGFza193b3JrLCBzZWUgWzFdLg0KPiA+IEFmdGVyIHNl
ZSB0aGUgZnJlZSBzdGFjayBhbmQgdGhlIGN1cnJlbnQgYXV4aWxpYXJ5IHN0YWNrLCB3ZSB0aGlu
aw0KPiA+IHRoZXkgYXJlIHVzZWxlc3MsIHdlIGRvbid0IGtub3cgd2hlcmUgcmVnaXN0ZXIgdGhl
IHdvcmssIHRoaXMgd29yaw0KPiA+IG1heSBiZSB0aGUgZnJlZSBjYWxsIHN0YWNrLCBzbyB0aGF0
IHdlIG1pc3MgdGhlIHJvb3QgY2F1c2UgYW5kDQo+ID4gZG9uJ3Qgc29sdmUgdGhlIHVzZS1hZnRl
ci1mcmVlLg0KPiA+DQo+ID4gQWRkIHRhc2tfd29ya19hZGQoKSBjYWxsIHN0YWNrIGludG8gS0FT
QU4gYXV4aWxpYXJ5IHN0YWNrIGluDQo+ID4gb3JkZXIgdG8gaW1wcm92ZSBLQVNBTiByZXBvcnQu
IEl0IGlzIHVzZWZ1bCBmb3IgcHJvZ3JhbW1lcnMNCj4gPiB0byBzb2x2ZSB1c2UtYWZ0ZXItZnJl
ZSBpc3N1ZXMuDQo+ID4NCj4gPiBbMV06IGh0dHBzOi8vZ3JvdXBzLmdvb2dsZS5jb20vZy9zeXpr
YWxsZXItYnVncy9zZWFyY2g/cT1rYXNhbiUyMHVzZS1hZnRlci1mcmVlJTIwdGFza193b3JrX3J1
bg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2FsdGVyIFd1IDx3YWx0ZXItemgud3VAbWVkaWF0
ZWsuY29tPg0KPiA+IFN1Z2dlc3RlZC1ieTogRG1pdHJ5IFZ5dWtvdiA8ZHZ5dWtvdkBnb29nbGUu
Y29tPg0KPiA+IENjOiBBbmRyZXkgUnlhYmluaW4gPHJ5YWJpbmluLmEuYUBnbWFpbC5jb20+DQo+
ID4gQ2M6IERtaXRyeSBWeXVrb3YgPGR2eXVrb3ZAZ29vZ2xlLmNvbT4NCj4gPiBDYzogQW5kcmV5
IEtvbm92YWxvdiA8YW5kcmV5a252bEBnb29nbGUuY29tPg0KPiA+IENjOiBBbGV4YW5kZXIgUG90
YXBlbmtvIDxnbGlkZXJAZ29vZ2xlLmNvbT4NCj4gPiBDYzogQW5kcmV3IE1vcnRvbiA8YWtwbUBs
aW51eC1mb3VuZGF0aW9uLm9yZz4NCj4gPiBDYzogTWF0dGhpYXMgQnJ1Z2dlciA8bWF0dGhpYXMu
YmdnQGdtYWlsLmNvbT4NCj4gPiBDYzogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPg0KPiA+
IENjOiBPbGVnIE5lc3Rlcm92IDxvbGVnQHJlZGhhdC5jb20+DQo+ID4gLS0tDQo+ID4gIGtlcm5l
bC90YXNrX3dvcmsuYyB8IDMgKysrDQo+ID4gIG1tL2thc2FuL2thc2FuLmggICB8IDIgKy0NCj4g
PiAgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9rZXJuZWwvdGFza193b3JrLmMgYi9rZXJuZWwvdGFza193b3JrLmMN
Cj4gPiBpbmRleCA5Y2RlOTYxODc1YzAuLmYyNTUyOTQzNzdkYSAxMDA2NDQNCj4gPiAtLS0gYS9r
ZXJuZWwvdGFza193b3JrLmMNCj4gPiArKysgYi9rZXJuZWwvdGFza193b3JrLmMNCj4gPiBAQCAt
NTUsNiArNTUsOSBAQCBpbnQgdGFza193b3JrX2FkZChzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRhc2ss
IHN0cnVjdCBjYWxsYmFja19oZWFkICp3b3JrLA0KPiA+ICAgICAgICAgICAgICAgICBicmVhazsN
Cj4gPiAgICAgICAgIH0NCj4gPg0KPiA+ICsgICAgICAgLyogcmVjb3JkIHRoZSB3b3JrIGNhbGwg
c3RhY2sgaW4gb3JkZXIgdG8gcHJpbnQgaXQgaW4gS0FTQU4gcmVwb3J0cyAqLw0KPiA+ICsgICAg
ICAga2FzYW5fcmVjb3JkX2F1eF9zdGFjayh3b3JrKTsNCj4gDQo+IEkgdGhpbmsgdGhpcyBjYWxs
IHNob3VsZCBiZSBkb25lIF9iZWZvcmVfIHdlIGFjdHVhbGx5IHF1ZXVlIHRoZSB3b3JrLA0KPiBi
ZWNhdXNlIHRoaXMgZnVuY3Rpb24gbWF5IG9wZXJhdGUgb24gbm9uLWN1cnJlbnQgdGFzay4NCj4g
Q29uc2lkZXIsIHdlIHF1ZXVlIHRoZSB3b3JrLCB0aGUgb3RoZXIgdGFzayBhbHJlYWR5IGV4ZWN1
dGVzIGl0IGFuZA0KPiB0cmlnZ2VycyB1c2UtYWZ0ZXItZnJlZSwgbm93IG9ubHkgbm93IHdlIHJl
Y29yZCB0aGUgc3RhY2suDQoNCmFncmVlLCB3aGF0IGRvIHlvdSB0aGluayBiZWxvdyBjaGFuZ2U/
DQoNCi0tLSBhL2tlcm5lbC90YXNrX3dvcmsuYw0KKysrIGIva2VybmVsL3Rhc2tfd29yay5jDQpA
QCAtMzQsNiArMzQsOSBAQCBpbnQgdGFza193b3JrX2FkZChzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRh
c2ssIHN0cnVjdA0KY2FsbGJhY2tfaGVhZCAqd29yaywNCiB7DQogICAgc3RydWN0IGNhbGxiYWNr
X2hlYWQgKmhlYWQ7DQoNCisgICAvKiByZWNvcmQgdGhlIHdvcmsgY2FsbCBzdGFjayBpbiBvcmRl
ciB0byBwcmludCBpdCBpbiBLQVNBTiByZXBvcnRzDQoqLw0KKyAgIGthc2FuX3JlY29yZF9hdXhf
c3RhY2sod29yayk7DQorDQogICAgZG8gew0KICAgICAgICBoZWFkID0gUkVBRF9PTkNFKHRhc2st
PnRhc2tfd29ya3MpOw0KICAgICAgICBpZiAodW5saWtlbHkoaGVhZCA9PSAmd29ya19leGl0ZWQp
KQ0KQEAgLTU1LDkgKzU4LDYgQEAgaW50IHRhc2tfd29ya19hZGQoc3RydWN0IHRhc2tfc3RydWN0
ICp0YXNrLCBzdHJ1Y3QNCmNhbGxiYWNrX2hlYWQgKndvcmssDQogICAgICAgIGJyZWFrOw0KICAg
IH0NCg0KLSAgIC8qIHJlY29yZCB0aGUgd29yayBjYWxsIHN0YWNrIGluIG9yZGVyIHRvIHByaW50
IGl0IGluIEtBU0FOIHJlcG9ydHMNCiovDQotICAga2FzYW5fcmVjb3JkX2F1eF9zdGFjayh3b3Jr
KTsNCi0NCiAgICByZXR1cm4gMDsNCiB9DQoNCj4gTW9yZW92ZXIsIEkgdGhpbmsgd2UgY2FuIHRy
aWdnZXIgdXNlLWFmdGVyLWZyZWUgaGVyZSBvdXJzZWx2ZXMgd2hpbGUNCj4gcmVjb3JkaW5nIHRo
ZSBhdXggc3RhY2suIFdlIHF1ZXVlZCB0aGUgd29yaywgYW5kIHRoZSB3b3JrIGNhbiBjYXVzZQ0K
PiBvd24gZnJlZSwgc28gaXQncyBub3QgbmVjZXNzYXJ5IGxpdmUgYnkgbm93Lg0KDQpTb3JyeSwg
SSBkb24ndCBmdWxseSBrbm93IHlvdXIgbWVhbmluZywgZG8geW91IG1lYW4gd2Ugc2hvdWxkIGFk
ZCBhbg0KYWJvcnQgd2hlbiBkZXRlY3QgdXNlLWFmdGVyLWZyZWU/DQoNCj4gDQo+ID4gICAgICAg
ICByZXR1cm4gMDsNCj4gPiAgfQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL21tL2thc2FuL2thc2Fu
LmggYi9tbS9rYXNhbi9rYXNhbi5oDQo+ID4gaW5kZXggMzQzNmM2YmY3YzBjLi5kMzAwZmU5NDE1
YmQgMTAwNjQ0DQo+ID4gLS0tIGEvbW0va2FzYW4va2FzYW4uaA0KPiA+ICsrKyBiL21tL2thc2Fu
L2thc2FuLmgNCj4gPiBAQCAtMTQ2LDcgKzE0Niw3IEBAIHN0cnVjdCBrYXNhbl9hbGxvY19tZXRh
IHsNCj4gPiAgICAgICAgIHN0cnVjdCBrYXNhbl90cmFjayBhbGxvY190cmFjazsNCj4gPiAgI2lm
ZGVmIENPTkZJR19LQVNBTl9HRU5FUklDDQo+ID4gICAgICAgICAvKg0KPiA+IC0gICAgICAgICog
Y2FsbF9yY3UoKSBjYWxsIHN0YWNrIGlzIHN0b3JlZCBpbnRvIHN0cnVjdCBrYXNhbl9hbGxvY19t
ZXRhLg0KPiA+ICsgICAgICAgICogQXV4aWxpYXJ5IHN0YWNrIGlzIHN0b3JlZCBpbnRvIHN0cnVj
dCBrYXNhbl9hbGxvY19tZXRhLg0KPiA+ICAgICAgICAgICogVGhlIGZyZWUgc3RhY2sgaXMgc3Rv
cmVkIGludG8gc3RydWN0IGthc2FuX2ZyZWVfbWV0YS4NCj4gPiAgICAgICAgICAqLw0KPiA+ICAg
ICAgICAgZGVwb3Rfc3RhY2tfaGFuZGxlX3QgYXV4X3N0YWNrWzJdOw0KPiA+IC0tDQo+ID4gMi4x
OC4wDQo+IA0KDQo=

