Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7040136AC17
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 08:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhDZGTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 02:19:20 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:51467 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231547AbhDZGTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 02:19:16 -0400
X-UUID: f0e1032ed00a4a6f805c68dea8835574-20210426
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=sdySB1yZvypohLBuKXjJSfPIJclDaqzDkEvBpP0MujQ=;
        b=OqQEZ0oNggwNSSwJb7L1lK6mO04J7htFTOET0H1dVCktiuLkZLCeetmnLNhPD/l5wpAGYMT5LVHJQlajxVFvPa5gUCXIWDtazbX3uj7LcF5Zq4sV66MjmygKzWkCw8K48N9UNnfhDHPazMynjm8OD5JaWeD3o8nMH0zHegO9r6o=;
X-UUID: f0e1032ed00a4a6f805c68dea8835574-20210426
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <ed.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1727616335; Mon, 26 Apr 2021 14:18:33 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 26 Apr 2021 14:18:31 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 26 Apr 2021 14:18:30 +0800
Message-ID: <ff7cb99e1a4c36582f5ab081f0aa6ed633db4305.camel@mediatek.com>
Subject: Re: [PATCH 1/1] sched: remove the redundant 'success' in the sched
 tracepoint
From:   Ed Tsai <ed.tsai@mediatek.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <stanley.chu@mediatek.com>, <loda.chou@mediatek.com>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Mon, 26 Apr 2021 14:18:31 +0800
In-Reply-To: <20210425175426.23f292a9@oasis.local.home>
References: <20210422122226.9415-1-ed.tsai@mediatek.com>
         <20210422114629.2b1ea3ad@gandalf.local.home>
         <0fd8e103cc2886724979f7d93066b86b773032eb.camel@mediatek.com>
         <20210425175426.23f292a9@oasis.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 014E52EE66485D057F8E3D68BE4AC6D130F1D3969CB0CE3F9720A60F30D714DC2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIxLTA0LTI1IGF0IDE3OjU0IC0wNDAwLCBTdGV2ZW4gUm9zdGVkdCB3cm90ZToN
Cj4gT24gRnJpLCAyMyBBcHIgMjAyMSAwODozODoyMiArMDgwMA0KPiBFZCBUc2FpIDxlZC50c2Fp
QG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+IA0KPiA+IE9uIFRodSwgMjAyMS0wNC0yMiBhdCAxMTo0
NiAtMDQwMCwgU3RldmVuIFJvc3RlZHQgd3JvdGU6DQo+ID4gPiBPbiBUaHUsIDIyIEFwciAyMDIx
IDIwOjIyOjI2ICswODAwDQo+ID4gPiBFZCBUc2FpIDxlZC50c2FpQG1lZGlhdGVrLmNvbT4gd3Jv
dGU6DQo+ID4gPiAgIA0KPiA+ID4gPiAnc3VjY2VzcycgaXMgbGVmdCBoZXJlIGZvciBhIGxvbmcg
dGltZSBhbmQgYWxzbyBpdCBpcw0KPiA+ID4gPiBtZWFuaW5nbGVzcw0KPiA+ID4gPiBmb3IgdGhl
IHVwcGVyIHVzZXIuIEp1c3QgcmVtb3ZlIGl0LiAgDQo+ID4gPiANCj4gPiA+IEhhdmUgeW91IHRl
c3RlZCBhbGwgdXNlcnNwYWNlIGNvZGUgdGhhdCBtaWdodCB1c2UgdGhpcz8NCj4gPiA+IA0KPiA+
ID4gVGhpcyBpcyB0aGUgInBvc3RlciBib3kiIGV4YW1wbGUgb2Ygd2h5IFBldGVyIFppamxzdHJh
IGhhdGVzDQo+ID4gPiB0cmFjZQ0KPiA+ID4gZXZlbnRzIDstKQ0KPiA+ID4gDQo+ID4gPiBJIGtu
b3cgSSd2ZSB1cGRhdGVkIHRyYWNlLWNtZCB0byBjaGVjayB0byBzZWUgaWYgdGhpcyBmaWVsZCBl
eGl0cw0KPiA+ID4gYmVmb3JlDQo+ID4gPiBkZXBlbmRpbmcgb24gaXQsIGJ1dCB0aGVyZSBtYXkg
YmUgc29tZSBvdGhlciB0b29scyB0aGF0IG1heSBub3QuDQo+ID4gPiBQZXJoYXBzDQo+ID4gPiBu
b3RoaW5nIHdpbGwgYnJlYWsuDQo+ID4gPiANCj4gPiA+IEknbSBhbGwgZm9yIHRoaXMgY2hhbmdl
LCBidXQgYmUgd2FyZSwgaXQgbWlnaHQgYmUgcmV2ZXJ0ZWQgaWYNCj4gPiA+IHRoZXJlJ3MNCj4g
PiA+IHNvbWUNCj4gPiA+IHRvb2wgb3V0IHRoYXQgdGhhdCBleHBlY3RzIGl0IHRvIGV4aXN0LiBU
aGlzIGlzIHdoeSBpdCBoYXNuJ3QNCj4gPiA+IGJlZW4NCj4gPiA+IHJlbW92ZWQuDQo+ID4gPiAN
Cj4gPiA+IC0tIFN0ZXZlICANCj4gPiANCj4gPiBJdCBpcyBsZWZ0IGhlcmUgb3ZlciA1IHllYXJz
LiBPbGQgdXNlcnNwYWNlIGNvZGUgbmVlZCB0aGlzIGVudHJ5DQo+ID4gYW5kDQo+ID4gYWxzbyBz
b21lb25lIG1heSB1c2UgaXQgZm9yIGEgbmV3IHRvb2wuIEkgaGF0ZSB0aGlzIGJ1dCBpdCBpcyBh
DQo+ID4gcHJvYmxlbQ0KPiA+IHNob3VsZCBiZSByZXNvbHZlZCBmb3IgdGhlIGtlcm5lbCBvciBp
Z25vcmUganVzdCBmaW5lLg0KPiA+IA0KPiANCj4gSSdtIHdpbGxpbmcgdG8gdGFrZSB0aGlzLCB3
aXRoIGEgbm90ZSB0aGF0IGlmIGFueW9uZSBjb21wbGFpbnMsIGl0DQo+IG1heQ0KPiBiZSByZXZl
cnRlZC4gQnV0IGFzIGl0IGdvZXMgd2l0aCBMaW51cydzIHJ1bGUgYWJvdXQgYnJlYWtpbmcgdXNl
cg0KPiBzcGFjZS4gSWYgeW91IGJyZWFrIHVzZXIgc3BhY2UsIGFuZCBub2JvZHkgbm90aWNlcywg
eW91IGRpZG4ndCByZWFsbHkNCj4gYnJlYWsgaXQhDQo+IA0KPiAtLSBTdGV2ZQ0KPiANCj4gDQoN
ClRoeCBTdGV2ZSwgdGhpcyBjaGFuZ2Ugd29yayBmaW5lIHRvIG1lIG9uIHRoZSB0cmFjZS1jbWQg
YW5kIHN5c3RyYWNlLg0KSXQncyBhIHNpbXBsZSBwYXRjaCB0byBjbGVhbiBjb2RlLiBSZXZlcnQg
aXQgaWYgYnJlYWsgdXNlciBleHBlcmllbmNlLg0K

