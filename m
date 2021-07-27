Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C62B3D7194
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 10:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbhG0Iyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 04:54:36 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:46960 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235885AbhG0Iyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 04:54:32 -0400
X-UUID: 907db055f5bf458bace5cfe9da424ea1-20210727
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=pHkaLI0XXjme0KOzVJgZfcROjWi4O4Qvm9FSQ9EMZ7I=;
        b=Sbgx3enf0EGT3B4yyFLD4EiGmCuBrFwdklEtlVkBhlf5pMOz2Umo/V3/oHmr4xrlsGCC5RN78xNYD563nawA9efyxaIMLsMAaG1pIikxDYJ9nh0dJLQwwgTHFyaxIVOvNspM1ZH/6pSih3GQ7QnccD2Kn6h2WYGk2u4V5JEuOeI=;
X-UUID: 907db055f5bf458bace5cfe9da424ea1-20210727
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 687126901; Tue, 27 Jul 2021 16:54:28 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 27 Jul 2021 16:54:27 +0800
Received: from mtksdccf07 (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 27 Jul 2021 16:54:27 +0800
Message-ID: <77ecf897408ab1022bd7fd879b8708e99c479cd9.camel@mediatek.com>
Subject: Re: [PATCH 2/2] kasan, mm: reset tag for hex dump address
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Marco Elver <elver@google.com>
CC:     Nicholas Tang <nicholas.tang@mediatek.com>,
        Andrew Yang <andrew.yang@mediatek.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        "Andrey Ryabinin" <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <Kuan-Ying.Lee@mediatek.com>
Date:   Tue, 27 Jul 2021 16:54:26 +0800
In-Reply-To: <CANpmjNNOkCspsf4=gPLLw=29vtv4qEDaErB1i1sz-p+bzLxNKg@mail.gmail.com>
References: <20210727040021.21371-1-Kuan-Ying.Lee@mediatek.com>
         <20210727040021.21371-3-Kuan-Ying.Lee@mediatek.com>
         <CANpmjNNOkCspsf4=gPLLw=29vtv4qEDaErB1i1sz-p+bzLxNKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTA3LTI3IGF0IDA5OjIwICswMjAwLCBNYXJjbyBFbHZlciB3cm90ZToNCj4g
T24gVHVlLCAyNyBKdWwgMjAyMSBhdCAwNjowMCwgS3Vhbi1ZaW5nIExlZSA8DQo+IEt1YW4tWWlu
Zy5MZWVAbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPiANCj4gPiBUZXh0IGlzIGEgc3RyaW5nLiBX
ZSBuZWVkIHRvIG1vdmUgdGhpcyBrYXNhbl9yZXNldF90YWcoKQ0KPiA+IHRvIGFkZHJlc3MgYnV0
IHRleHQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogS3Vhbi1ZaW5nIExlZSA8S3Vhbi1ZaW5n
LkxlZUBtZWRpYXRlay5jb20+DQo+IA0KPiBUaGlzIHBhdGNoIGFsc28gbWFrZXMgc2Vuc2UgKEkg
dGhpbmspLCB0aGFua3MgZm9yIHNlbmRpbmcuIEJ1dCBpdCdzDQo+IHVuY2xlYXIgd2hhdCB0aGUg
cHJvYmxlbSBpcy4gVGhlIGZhY3QgdGhhdCB3aGVuIHRoZSBhZGRyZXNzIGlzDQo+IHByaW50ZWQN
Cj4gaXQgc3RpbGwgaW5jbHVkZXMgdGhlIHRhZz8gT3IgYSBmYWxzZSBwb3NpdGl2ZT8NCj4gSXQn
ZCBiZSBnb29kIHRvIGNsYXJpZnkgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLg0KDQpZZXMsIHByaW50
ZWQgYWRkcmVzcyBpbmNsdWRlcyB0aGUgdGFnLCBzbyB3aGVuIHdlIGFjY2VzcyB0aGUNCm1ldGFk
YXRhLCB3ZSB3aWxsIGVuY291bnRlciB0YWcgbWlzbWF0Y2ggd2l0aCBIVyB0YWctYmFzZWQga2Fz
YW4NCmVuYWJsZWQuDQoNCj4gDQo+IEhlcmUgSSdkIGFsc28gdXNlIGEgbW9yZSBkZXNjcmlwdGl2
ZSBwYXRjaCB0aXRsZSwgc29tZXRoaW5nIGxpa2UNCj4gImthc2FuLCBzbHViOiByZXNldCB0YWcg
d2hlbiBwcmludGluZyBhZGRyZXNzIi4NCj4gDQo+IEFsc28sIEkgdGhpbmsgdGhpcyBwYXRjaCBy
ZXF1aXJlcyBhOg0KPiANCj4gICBGaXhlczogYWExZWY0ZDdiM2Y2ICgia2FzYW4sIG1tOiByZXNl
dCB0YWdzIHdoZW4gYWNjZXNzaW5nDQo+IG1ldGFkYXRhIikNCj4gDQo+IFNvIHRoYXQgc3RhYmxl
IGtlcm5lbHMgY2FuIHBpY2sgdGhpcyB1cCBpZiBhcHByb3ByaWF0ZS4NCg0KVGhhbmsgeW91LCBN
YXJjby4NCkkgd2lsbCByZWZpbmUgY29tbWl0IG1lc3NhZ2UgaW4gdGhlIHYyLg0KDQo+IA0KPiA+
IC0tLQ0KPiA+ICBtbS9zbHViLmMgfCA0ICsrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvbW0vc2x1
Yi5jIGIvbW0vc2x1Yi5jDQo+ID4gaW5kZXggNmRhZDJiNmZkYTZmLi5kMjA2NzRmODM5YmEgMTAw
NjQ0DQo+ID4gLS0tIGEvbW0vc2x1Yi5jDQo+ID4gKysrIGIvbW0vc2x1Yi5jDQo+ID4gQEAgLTU3
Niw4ICs1NzYsOCBAQCBzdGF0aWMgdm9pZCBwcmludF9zZWN0aW9uKGNoYXIgKmxldmVsLCBjaGFy
DQo+ID4gKnRleHQsIHU4ICphZGRyLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5z
aWduZWQgaW50IGxlbmd0aCkNCj4gPiAgew0KPiA+ICAgICAgICAgbWV0YWRhdGFfYWNjZXNzX2Vu
YWJsZSgpOw0KPiA+IC0gICAgICAgcHJpbnRfaGV4X2R1bXAobGV2ZWwsIGthc2FuX3Jlc2V0X3Rh
Zyh0ZXh0KSwNCj4gPiBEVU1QX1BSRUZJWF9BRERSRVNTLA0KPiA+IC0gICAgICAgICAgICAgICAg
ICAgICAgIDE2LCAxLCBhZGRyLCBsZW5ndGgsIDEpOw0KPiA+ICsgICAgICAgcHJpbnRfaGV4X2R1
bXAobGV2ZWwsIHRleHQsIERVTVBfUFJFRklYX0FERFJFU1MsDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgMTYsIDEsIGthc2FuX3Jlc2V0X3RhZygodm9pZCAqKWFkZHIpLA0KPiA+IGxlbmd0
aCwgMSk7DQo+ID4gICAgICAgICBtZXRhZGF0YV9hY2Nlc3NfZGlzYWJsZSgpOw0KPiA+ICB9DQo+
ID4gDQo+ID4gLS0NCj4gPiAyLjE4LjANCj4gPiANCj4gPiAtLQ0KPiA+IFlvdSByZWNlaXZlZCB0
aGlzIG1lc3NhZ2UgYmVjYXVzZSB5b3UgYXJlIHN1YnNjcmliZWQgdG8gdGhlIEdvb2dsZQ0KPiA+
IEdyb3VwcyAia2FzYW4tZGV2IiBncm91cC4NCj4gPiBUbyB1bnN1YnNjcmliZSBmcm9tIHRoaXMg
Z3JvdXAgYW5kIHN0b3AgcmVjZWl2aW5nIGVtYWlscyBmcm9tIGl0LA0KPiA+IHNlbmQgYW4gZW1h
aWwgdG8ga2FzYW4tZGV2K3Vuc3Vic2NyaWJlQGdvb2dsZWdyb3Vwcy5jb20uDQo+ID4gVG8gdmll
dyB0aGlzIGRpc2N1c3Npb24gb24gdGhlIHdlYiB2aXNpdCANCj4gPiBodHRwczovL3VybGRlZmVu
c2UuY29tL3YzL19faHR0cHM6Ly9ncm91cHMuZ29vZ2xlLmNvbS9kL21zZ2lkL2thc2FuLWRldi8y
MDIxMDcyNzA0MDAyMS4yMTM3MS0zLUt1YW4tWWluZy5MZWUqNDBtZWRpYXRlay5jb21fXztKUSEh
Q1RSTktBOXdNZzBBUmJ3ITEzWE91WWJ6UFFyQnZJRE1OYnJUN3ZtOFJHYzU2T3FyNDAyUERmUVJE
bUhyckJzdWpyWlVyN085cTI0SmVESl8zTmxXU1EkDQo+ID4gIC4NCg==

