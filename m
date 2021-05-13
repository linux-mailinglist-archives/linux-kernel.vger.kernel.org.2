Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A868437F172
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 04:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhEMCyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 22:54:40 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:35222 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230364AbhEMCyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 22:54:35 -0400
X-UUID: 945b5eb47a9b4bac8f61246354f7cf35-20210513
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=DkvV/jPRPm57TuS9uX0S6v2TxWE8Q0xW72CfQJu/OlI=;
        b=ZsRhWOR7pujiM9EJy3tMvvQG+cF5tsbYsXH3shzwHjc/j/b8Ghd27ZlpKY758giRPJ2yUWMwH24XsBWqosHlniMnsoUT2AjFhFlwwcuGRaxqo2Po/Du2P9N8T9du4Ml1b7T9ufpjB5CF2P2SlyAU+Gq2ZHmspHIk1Y1NG9aIGXA=;
X-UUID: 945b5eb47a9b4bac8f61246354f7cf35-20210513
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1742560615; Thu, 13 May 2021 10:53:23 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 13 May 2021 10:53:21 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 13 May 2021 10:53:21 +0800
Message-ID: <1620874401.21092.10.camel@mtkswgap22>
Subject: Re: [PATCH] mm/sparse: fix check_usemap_section_nr warnings
From:   Miles Chen <miles.chen@mediatek.com>
To:     Baoquan He <bhe@redhat.com>
CC:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        <k-hagio-ab@nec.com>
Date:   Thu, 13 May 2021 10:53:21 +0800
In-Reply-To: <20210513011648.GA6776@MiWiFi-R3L-srv>
References: <20210511093114.15123-1-miles.chen@mediatek.com>
         <YJpbWVrgJFLRpzl3@kernel.org> <1620797600.14730.7.camel@mtkswgap22>
         <YJuh90iYeZ8F4Ain@kernel.org> <20210513011648.GA6776@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 7753801D92E62CBD26FBF274B8115874F75D8956F43F6CF55697AE995F99B2F32000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTA1LTEzIGF0IDA5OjE2ICswODAwLCBCYW9xdWFuIEhlIHdyb3RlOg0KPiBP
biAwNS8xMi8yMSBhdCAxMjozN3BtLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0KPiA+IE9uIFdlZCwg
TWF5IDEyLCAyMDIxIGF0IDAxOjMzOjIwUE0gKzA4MDAsIE1pbGVzIENoZW4gd3JvdGU6DQo+ID4g
PiBPbiBUdWUsIDIwMjEtMDUtMTEgYXQgMTM6MjQgKzAzMDAsIE1pa2UgUmFwb3BvcnQgd3JvdGU6
DQo+ID4gPiA+IE9uIFR1ZSwgTWF5IDExLCAyMDIxIGF0IDA1OjMxOjE0UE0gKzA4MDAsIE1pbGVz
IENoZW4gd3JvdGU6DQo+ID4gPiA+ID4gSW4gY3VycmVudCBpbXBsZW1lbnRhdGlvbiBvZiBub2Rl
X2RhdGEsIGlmIENPTkZJR19ORUVEX01VTFRJUExFX05PREVTPXksDQo+ID4gPiA+ID4gbm9kZV9k
YXRhIGlzIGFsbG9jYXRlZCBieSBrem1hbGxvYy4gSWYgQ09ORklHX05FRURfTVVMVElQTEVfTk9E
RVM9biwNCj4gPiA+ID4gPiB3ZSB1c2UgYSBnbG9iYWwgdmFyaWFibGUgbmFtZWQgImNvbnRpZ19w
YWdlX2RhdGEiLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IElmIENPTkZJR19ERUJVR19WSVJUVUFM
IGlzIG5vdCBlbmFibGVkLiBfX3BhKCkgY2FuIGhhbmRsZSBib3RoIGt6YWxsb2MgYW5kDQo+ID4g
PiA+ID4gc3ltYm9sIGNhc2VzLiBCdXQgaWYgQ09ORklHX0RFQlVHX1ZJUlRVQUwgaXMgc2V0LCB3
ZSB3aWxsIGhhdmUgdGhlDQo+ID4gPiA+ID4gInZpcnRfdG9fcGh5cyB1c2VkIGZvciBub24tbGlu
ZWFyIGFkZHJlc3MiIHdhcm5pbmcgd2hlbiBib290aW5nLg0KPiA+ID4gPiANCj4gPiA+ID4gTWF5
YmUgd2UnbGwganVzdCBhbGxvY2F0ZSBwZ2RhdCBmb3IgQ09ORklHX05FRURfTVVMVElQTEVfTk9E
RVM9biAod2hpY2ggaXMNCj4gPiA+ID4gZXNzZW50aWFsbHkgIU5VTUEpIGNhc2UgaW4sIHNheSwg
ZnJlZV9hcmVhX2luaXQoKT8NCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiB0aGFua3MgZm9yIHlvdXIg
Y29tbWVudC4NCj4gPiA+IA0KPiA+ID4gSSBjaGVjayB0aGUgc291cmNlIHRyZWUgYW5kIGZvdW5k
IHRoYXQgY29udGlnX3BhZ2VfZGF0YSBpcyB1c2VkIGJ5DQo+ID4gPiBjcmFzaF9jb3JlLmMgYXMg
YSBzeW1ib2wuIEkgYW0gbm90IGZhbWlsaWFyIHdpdGggY3Jhc2hfY29yZSBidXQgSSBndWVzcw0K
PiA+ID4gYWxsb2NhdGUgcGdkYXQgbWF5IGJyZWFrIHRoaXMgY3Jhc2hfY29yZSB1c2Vycy4NCj4g
PiA+IA0KPiA+ID4gRm9yIGV4YW1wbGU6IHNvbWUgdXNlcnNwYWNlIHNjcmlwdHMgd2FudCB0byBy
ZWFkIHRoZSBhZGRyZXNzIG9mDQo+ID4gPiBjb250aWdfcGFnZV9kYXRhIHN5bWJvbCBmcm9tIGEg
Y29yZWZpbGUuDQo+ID4gPiANCj4gPiA+IGtlcm5lbC9jcmFzaF9jb3JlLmM6NDYwOiAgICAgICAg
Vk1DT1JFSU5GT19TWU1CT0woY29udGlnX3BhZ2VfZGF0YSk7DQo+ID4gPiANCj4gPiA+ICNpZm5k
ZWYgQ09ORklHX05FRURfTVVMVElQTEVfTk9ERVMNCj4gPiA+ICAgICAgICAgVk1DT1JFSU5GT19T
WU1CT0wobWVtX21hcCk7DQo+ID4gPiAgICAgICAgIFZNQ09SRUlORk9fU1lNQk9MKGNvbnRpZ19w
YWdlX2RhdGEpOw0KPiA+ID4gI2VuZGlmDQo+ID4gDQo+ID4gTXkgdW5kZXJzdGFuZGluZyBpcyB0
aGF0IFZNQ09SRUlORk9fU1lNQk9MKCkgc2hvdWxkIGNvcnJlc3BvbmQgdG8gYWN0dWFsDQo+ID4g
c3ltYm9sLiBJZiB0aGVyZSBpcyBubyBjb250aWdfcGFnZV9kYXRhIHN5bWJvbCwgdGhlcmUgaXMg
bm8gbmVlZCBmb3INCj4gPiBWTUNPUkVJTkZPX1NZTUJPTCgpIGVpdGhlci4NCj4gDQo+IFllYWgs
IGl0J3MgZXhwb3J0ZWQgZm9yIG1ha2VkdW1wZmlsZSBhbmQgY3Jhc2ggdXRpbGl0eSB0byBwYXJz
ZSBhbmQgZ2V0DQo+IHRoZSBtZW1vcnkgbGF5b3V0IG9mIHRoZSBjb3JydXB0ZWQga2VybmVsLiBJ
ZiByZW1vdmluZyBpdCwgbWFrZWR1bXBmaWxlDQo+IHdpbGwgZ2V0IGl0IGZyb20gbm9kZV9kYXRh
W10uIExvb2tzIGxpa2UgYSBnb29kIGlkZWEgdG8gdW5pZnkgY29kZSBmb3INCj4gbnVtYXwhbnVt
YSBvbiBwZ2xpc3RfZGF0YSBpbnN0YW5jZXMuDQo+IA0KPiBBZGQgS2F6dSB0byBDQyBzaW5jZSBo
ZSBtYWludGFpbiBtYWtlZHVtcGZpbGUgYW5kIENyYXNoIHV0aWxpdGllcy4NCg0KdGhhbmtzIGZv
ciBhZGRpbmcgdGhlIGV4cGVydHMgaW4uIChJIHNlYXJjaGVkIHRoZSBzb3VyY2UgY29kZSBvZiBj
cmFzaA0KbGFzdCBuaWdodCBhbmQgZm91bmQgdGhhdCBjb250aWdfcGFnZV9kYXRhIGlzIHVzZWQg
aW4gbWVtb3J5LmMpDQoNCkkgd2lsbCBtb3ZlIHRoZSBhbGxvY2F0aW9uIGFuZCBpbml0aWFsaXph
dGlvbiB0byBmcmVlX2FyZWFfaW5pdCgpIGFuZA0Kc3VibWl0IHBhdGNoIHYyLg0KDQoNCk1pbGVz
DQoNCj4gDQo+IE15IGNvbmNlcm4gaXMgdGhhdCB0aGF0IG9ubHkgaGFwcGVucyBvbiBhcm0vYXJt
NjQvcmlzY3YsIGRvZXMgaXQgbWVhbiB0aGUNCj4gd2FybmluZyBpcyBub3QgbmVjZXNzYXJ5LCBz
byBjYW4gYmUgcmVtb3ZlZD8gT3Igd2UgbmVlZCB0byBjaGVjayBpZg0KPiBDT05GSUdfREVCVUdf
VklSVFVBTCBkb2Vzbid0IHdvcmsgd2VsbCBpbiB0aGlzIGNhc2UuDQo+IA0KPiBUaGFua3MNCj4g
QmFvcXVhbg0KPiANCg0K

