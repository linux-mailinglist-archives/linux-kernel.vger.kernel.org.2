Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2272533AFA7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhCOKNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:13:37 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60377 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229596AbhCOKNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:13:19 -0400
X-UUID: 14d725c739564bfdbc81dc282ff48273-20210315
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=618js/PS6ZPaWu29u7iJ5zsMGtOyFM88Lrk/7gggYzg=;
        b=XS+ASPMS0f6iOMJGyN7nMWN6hZmcUpXi79/qun+Qd+2wvcihW/HLlAf0emKj0yjzPZtmXqMul1FL+52TLsFGeCPHoWgjkh742C3ajzbHP+1knXOO8PvgdCBB8fKFOJ/4FMjIa2FkAeLy6u770WDIak1ZXE9+xoOs+UeilMZpp2E=;
X-UUID: 14d725c739564bfdbc81dc282ff48273-20210315
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1803650274; Mon, 15 Mar 2021 18:13:12 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 15 Mar 2021 18:13:09 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 15 Mar 2021 18:13:09 +0800
Message-ID: <1615803189.26681.2.camel@mtksdccf07>
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
Date:   Mon, 15 Mar 2021 18:13:09 +0800
In-Reply-To: <CACT4Y+YtenynUES2Kb6jSjfw_wT4NMeyX+uG5KdCe3SHhq1qsw@mail.gmail.com>
References: <20210315015940.11788-1-walter-zh.wu@mediatek.com>
         <CACT4Y+YrFeRQkw+M8rpOF5169LFn9+puL3Dh1Kk1AOoKV-nyrQ@mail.gmail.com>
         <1615801102.24887.4.camel@mtksdccf07>
         <CACT4Y+YtenynUES2Kb6jSjfw_wT4NMeyX+uG5KdCe3SHhq1qsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 485F11046E134C02B7185E4AE2E19A4AA60643209A878351DC8250614617A2D42000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTAzLTE1IGF0IDExOjAzICswMTAwLCAnRG1pdHJ5IFZ5dWtvdicgdmlhIGth
c2FuLWRldiB3cm90ZToNCj4gT24gTW9uLCBNYXIgMTUsIDIwMjEgYXQgMTA6MzggQU0gV2FsdGVy
IFd1IDx3YWx0ZXItemgud3VAbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIE1vbiwg
MjAyMS0wMy0xNSBhdCAwNzo1OCArMDEwMCwgJ0RtaXRyeSBWeXVrb3YnIHZpYSBrYXNhbi1kZXYg
d3JvdGU6DQo+ID4gPiBPbiBNb24sIE1hciAxNSwgMjAyMSBhdCAzOjAwIEFNIFdhbHRlciBXdSA8
d2FsdGVyLXpoLnd1QG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IFdoeSBy
ZWNvcmQgdGFza193b3JrX2FkZCgpIGNhbGwgc3RhY2s/DQo+ID4gPiA+IFN5emJvdCByZXBvcnRz
IG1hbnkgdXNlLWFmdGVyLWZyZWUgaXNzdWVzIGZvciB0YXNrX3dvcmssIHNlZSBbMV0uDQo+ID4g
PiA+IEFmdGVyIHNlZSB0aGUgZnJlZSBzdGFjayBhbmQgdGhlIGN1cnJlbnQgYXV4aWxpYXJ5IHN0
YWNrLCB3ZSB0aGluaw0KPiA+ID4gPiB0aGV5IGFyZSB1c2VsZXNzLCB3ZSBkb24ndCBrbm93IHdo
ZXJlIHJlZ2lzdGVyIHRoZSB3b3JrLCB0aGlzIHdvcmsNCj4gPiA+ID4gbWF5IGJlIHRoZSBmcmVl
IGNhbGwgc3RhY2ssIHNvIHRoYXQgd2UgbWlzcyB0aGUgcm9vdCBjYXVzZSBhbmQNCj4gPiA+ID4g
ZG9uJ3Qgc29sdmUgdGhlIHVzZS1hZnRlci1mcmVlLg0KPiA+ID4gPg0KPiA+ID4gPiBBZGQgdGFz
a193b3JrX2FkZCgpIGNhbGwgc3RhY2sgaW50byBLQVNBTiBhdXhpbGlhcnkgc3RhY2sgaW4NCj4g
PiA+ID4gb3JkZXIgdG8gaW1wcm92ZSBLQVNBTiByZXBvcnQuIEl0IGlzIHVzZWZ1bCBmb3IgcHJv
Z3JhbW1lcnMNCj4gPiA+ID4gdG8gc29sdmUgdXNlLWFmdGVyLWZyZWUgaXNzdWVzLg0KPiA+ID4g
Pg0KPiA+ID4gPiBbMV06IGh0dHBzOi8vZ3JvdXBzLmdvb2dsZS5jb20vZy9zeXprYWxsZXItYnVn
cy9zZWFyY2g/cT1rYXNhbiUyMHVzZS1hZnRlci1mcmVlJTIwdGFza193b3JrX3J1bg0KPiA+ID4g
Pg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBXYWx0ZXIgV3UgPHdhbHRlci16aC53dUBtZWRpYXRl
ay5jb20+DQo+ID4gPiA+IFN1Z2dlc3RlZC1ieTogRG1pdHJ5IFZ5dWtvdiA8ZHZ5dWtvdkBnb29n
bGUuY29tPg0KPiA+ID4gPiBDYzogQW5kcmV5IFJ5YWJpbmluIDxyeWFiaW5pbi5hLmFAZ21haWwu
Y29tPg0KPiA+ID4gPiBDYzogRG1pdHJ5IFZ5dWtvdiA8ZHZ5dWtvdkBnb29nbGUuY29tPg0KPiA+
ID4gPiBDYzogQW5kcmV5IEtvbm92YWxvdiA8YW5kcmV5a252bEBnb29nbGUuY29tPg0KPiA+ID4g
PiBDYzogQWxleGFuZGVyIFBvdGFwZW5rbyA8Z2xpZGVyQGdvb2dsZS5jb20+DQo+ID4gPiA+IENj
OiBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KPiA+ID4gPiBDYzog
TWF0dGhpYXMgQnJ1Z2dlciA8bWF0dGhpYXMuYmdnQGdtYWlsLmNvbT4NCj4gPiA+ID4gQ2M6IEpl
bnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4NCj4gPiA+ID4gQ2M6IE9sZWcgTmVzdGVyb3YgPG9s
ZWdAcmVkaGF0LmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBrZXJuZWwvdGFza193b3JrLmMg
fCAzICsrKw0KPiA+ID4gPiAgbW0va2FzYW4va2FzYW4uaCAgIHwgMiArLQ0KPiA+ID4gPiAgMiBm
aWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+ID4NCj4g
PiA+ID4gZGlmZiAtLWdpdCBhL2tlcm5lbC90YXNrX3dvcmsuYyBiL2tlcm5lbC90YXNrX3dvcmsu
Yw0KPiA+ID4gPiBpbmRleCA5Y2RlOTYxODc1YzAuLmYyNTUyOTQzNzdkYSAxMDA2NDQNCj4gPiA+
ID4gLS0tIGEva2VybmVsL3Rhc2tfd29yay5jDQo+ID4gPiA+ICsrKyBiL2tlcm5lbC90YXNrX3dv
cmsuYw0KPiA+ID4gPiBAQCAtNTUsNiArNTUsOSBAQCBpbnQgdGFza193b3JrX2FkZChzdHJ1Y3Qg
dGFza19zdHJ1Y3QgKnRhc2ssIHN0cnVjdCBjYWxsYmFja19oZWFkICp3b3JrLA0KPiA+ID4gPiAg
ICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gPiA+ICAgICAgICAgfQ0KPiA+ID4gPg0KPiA+ID4g
PiArICAgICAgIC8qIHJlY29yZCB0aGUgd29yayBjYWxsIHN0YWNrIGluIG9yZGVyIHRvIHByaW50
IGl0IGluIEtBU0FOIHJlcG9ydHMgKi8NCj4gPiA+ID4gKyAgICAgICBrYXNhbl9yZWNvcmRfYXV4
X3N0YWNrKHdvcmspOw0KPiA+ID4NCj4gPiA+IEkgdGhpbmsgdGhpcyBjYWxsIHNob3VsZCBiZSBk
b25lIF9iZWZvcmVfIHdlIGFjdHVhbGx5IHF1ZXVlIHRoZSB3b3JrLA0KPiA+ID4gYmVjYXVzZSB0
aGlzIGZ1bmN0aW9uIG1heSBvcGVyYXRlIG9uIG5vbi1jdXJyZW50IHRhc2suDQo+ID4gPiBDb25z
aWRlciwgd2UgcXVldWUgdGhlIHdvcmssIHRoZSBvdGhlciB0YXNrIGFscmVhZHkgZXhlY3V0ZXMg
aXQgYW5kDQo+ID4gPiB0cmlnZ2VycyB1c2UtYWZ0ZXItZnJlZSwgbm93IG9ubHkgbm93IHdlIHJl
Y29yZCB0aGUgc3RhY2suDQo+ID4NCj4gPiBhZ3JlZSwgd2hhdCBkbyB5b3UgdGhpbmsgYmVsb3cg
Y2hhbmdlPw0KPiA+DQo+ID4gLS0tIGEva2VybmVsL3Rhc2tfd29yay5jDQo+ID4gKysrIGIva2Vy
bmVsL3Rhc2tfd29yay5jDQo+ID4gQEAgLTM0LDYgKzM0LDkgQEAgaW50IHRhc2tfd29ya19hZGQo
c3RydWN0IHRhc2tfc3RydWN0ICp0YXNrLCBzdHJ1Y3QNCj4gPiBjYWxsYmFja19oZWFkICp3b3Jr
LA0KPiA+ICB7DQo+ID4gICAgIHN0cnVjdCBjYWxsYmFja19oZWFkICpoZWFkOw0KPiA+DQo+ID4g
KyAgIC8qIHJlY29yZCB0aGUgd29yayBjYWxsIHN0YWNrIGluIG9yZGVyIHRvIHByaW50IGl0IGlu
IEtBU0FOIHJlcG9ydHMNCj4gPiAqLw0KPiA+ICsgICBrYXNhbl9yZWNvcmRfYXV4X3N0YWNrKHdv
cmspOw0KPiA+ICsNCj4gDQo+IFRoaXMgbG9va3MgZ29vZCB0byBtZS4NCj4gDQo+IA0KPiA+ICAg
ICBkbyB7DQo+ID4gICAgICAgICBoZWFkID0gUkVBRF9PTkNFKHRhc2stPnRhc2tfd29ya3MpOw0K
PiA+ICAgICAgICAgaWYgKHVubGlrZWx5KGhlYWQgPT0gJndvcmtfZXhpdGVkKSkNCj4gPiBAQCAt
NTUsOSArNTgsNiBAQCBpbnQgdGFza193b3JrX2FkZChzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRhc2ss
IHN0cnVjdA0KPiA+IGNhbGxiYWNrX2hlYWQgKndvcmssDQo+ID4gICAgICAgICBicmVhazsNCj4g
PiAgICAgfQ0KPiA+DQo+ID4gLSAgIC8qIHJlY29yZCB0aGUgd29yayBjYWxsIHN0YWNrIGluIG9y
ZGVyIHRvIHByaW50IGl0IGluIEtBU0FOIHJlcG9ydHMNCj4gPiAqLw0KPiA+IC0gICBrYXNhbl9y
ZWNvcmRfYXV4X3N0YWNrKHdvcmspOw0KPiA+IC0NCj4gPiAgICAgcmV0dXJuIDA7DQo+ID4gIH0N
Cj4gPg0KPiA+ID4gTW9yZW92ZXIsIEkgdGhpbmsgd2UgY2FuIHRyaWdnZXIgdXNlLWFmdGVyLWZy
ZWUgaGVyZSBvdXJzZWx2ZXMgd2hpbGUNCj4gPiA+IHJlY29yZGluZyB0aGUgYXV4IHN0YWNrLiBX
ZSBxdWV1ZWQgdGhlIHdvcmssIGFuZCB0aGUgd29yayBjYW4gY2F1c2UNCj4gPiA+IG93biBmcmVl
LCBzbyBpdCdzIG5vdCBuZWNlc3NhcnkgbGl2ZSBieSBub3cuDQo+ID4NCj4gPiBTb3JyeSwgSSBk
b24ndCBmdWxseSBrbm93IHlvdXIgbWVhbmluZywgZG8geW91IG1lYW4gd2Ugc2hvdWxkIGFkZCBh
bg0KPiA+IGFib3J0IHdoZW4gZGV0ZWN0IHVzZS1hZnRlci1mcmVlPw0KPiANCj4gSSBtZWFudCB0
aGF0IHdoZXJlIHdlIGhhZCB0aGUga2FzYW5fcmVjb3JkX2F1eF9zdGFjayh3b3JrKSBjYWxsIGlu
IHRoZQ0KPiBmaXJzdCB2ZXJzaW9uIG9mIHRoZSBwYXRjaCwgd29yayBjYW4gYmUgYWxyZWFkeSBm
cmVlZC4gV2UgbXVzdCBub3QNCj4gYWNjZXNzIHdvcmsgYWZ0ZXIgcXVldWVpbmcgaXQuDQo+IA0K
DQpHb3QgaXQuIE5vdyBJIG11c3QgdHJlYXQgdXJnZW50IGlzc3VlLCBJIHdpbGwgc2VuZCB2MiBw
YXRjaCB0b21vcnJvdy4NCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCg0KPiA+ID4gPiAgICAg
ICAgIHJldHVybiAwOw0KPiA+ID4gPiAgfQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEv
bW0va2FzYW4va2FzYW4uaCBiL21tL2thc2FuL2thc2FuLmgNCj4gPiA+ID4gaW5kZXggMzQzNmM2
YmY3YzBjLi5kMzAwZmU5NDE1YmQgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL21tL2thc2FuL2thc2Fu
LmgNCj4gPiA+ID4gKysrIGIvbW0va2FzYW4va2FzYW4uaA0KPiA+ID4gPiBAQCAtMTQ2LDcgKzE0
Niw3IEBAIHN0cnVjdCBrYXNhbl9hbGxvY19tZXRhIHsNCj4gPiA+ID4gICAgICAgICBzdHJ1Y3Qg
a2FzYW5fdHJhY2sgYWxsb2NfdHJhY2s7DQo+ID4gPiA+ICAjaWZkZWYgQ09ORklHX0tBU0FOX0dF
TkVSSUMNCj4gPiA+ID4gICAgICAgICAvKg0KPiA+ID4gPiAtICAgICAgICAqIGNhbGxfcmN1KCkg
Y2FsbCBzdGFjayBpcyBzdG9yZWQgaW50byBzdHJ1Y3Qga2FzYW5fYWxsb2NfbWV0YS4NCj4gPiA+
ID4gKyAgICAgICAgKiBBdXhpbGlhcnkgc3RhY2sgaXMgc3RvcmVkIGludG8gc3RydWN0IGthc2Fu
X2FsbG9jX21ldGEuDQo+ID4gPiA+ICAgICAgICAgICogVGhlIGZyZWUgc3RhY2sgaXMgc3RvcmVk
IGludG8gc3RydWN0IGthc2FuX2ZyZWVfbWV0YS4NCj4gPiA+ID4gICAgICAgICAgKi8NCj4gPiA+
ID4gICAgICAgICBkZXBvdF9zdGFja19oYW5kbGVfdCBhdXhfc3RhY2tbMl07DQo+ID4gPiA+IC0t
DQo+ID4gPiA+IDIuMTguMA0KPiA+ID4NCj4gPg0KPiA+IC0tDQo+ID4gWW91IHJlY2VpdmVkIHRo
aXMgbWVzc2FnZSBiZWNhdXNlIHlvdSBhcmUgc3Vic2NyaWJlZCB0byB0aGUgR29vZ2xlIEdyb3Vw
cyAia2FzYW4tZGV2IiBncm91cC4NCj4gPiBUbyB1bnN1YnNjcmliZSBmcm9tIHRoaXMgZ3JvdXAg
YW5kIHN0b3AgcmVjZWl2aW5nIGVtYWlscyBmcm9tIGl0LCBzZW5kIGFuIGVtYWlsIHRvIGthc2Fu
LWRldit1bnN1YnNjcmliZUBnb29nbGVncm91cHMuY29tLg0KPiA+IFRvIHZpZXcgdGhpcyBkaXNj
dXNzaW9uIG9uIHRoZSB3ZWIgdmlzaXQgaHR0cHM6Ly9ncm91cHMuZ29vZ2xlLmNvbS9kL21zZ2lk
L2thc2FuLWRldi8xNjE1ODAxMTAyLjI0ODg3LjQuY2FtZWwlNDBtdGtzZGNjZjA3Lg0KPiANCg0K

