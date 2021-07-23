Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287203D36F0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 10:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbhGWH7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 03:59:34 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:35594 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234586AbhGWH7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 03:59:33 -0400
X-UUID: 99d6bfe353d04a4ebba226ceb58f3499-20210723
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=6eFxbfXU1aGruy1a6KsbRzQX11yjS2zTUljrzlkeqUU=;
        b=hr79QuZ31l8PtsKCPcPzv+oHGdsHt3MktK/1aYXM1h48h69CZQE+srWopEqrpXsCDNP7kFKkDmvDtBcD/BXYF9MzhwtiJVU90NHMPqzPg/Ha79sUlv/2uTjrqYtEutODQmvZvcxZxyADoVplg9WSQFMkYuTzXhYnJKPHXlJL2M4=;
X-UUID: 99d6bfe353d04a4ebba226ceb58f3499-20210723
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1807898697; Fri, 23 Jul 2021 16:40:03 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 23 Jul 2021 16:40:02 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 23 Jul 2021 16:40:01 +0800
Message-ID: <1627029602.14347.6.camel@mtkswgap22>
Subject: Re: [RESEND PATCH v2] mm/sparse: clarify pgdat_to_phys
From:   Miles Chen <miles.chen@mediatek.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Fri, 23 Jul 2021 16:40:02 +0800
In-Reply-To: <a042906d-7d07-d1af-57d2-ab4cbdc53f36@redhat.com>
References: <20210723070137.23321-1-miles.chen@mediatek.com>
         <a042906d-7d07-d1af-57d2-ab4cbdc53f36@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTA3LTIzIGF0IDA5OjEwICswMjAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gT24gMjMuMDcuMjEgMDk6MDEsIE1pbGVzIENoZW4gd3JvdGU6DQo+ID4gQ2xhcmlmeSBw
Z2RhdF90b19waHlzKCkgYnkgdGVzdGluZyBpZg0KPiA+IHBnZGF0ID09ICZjb250aWdfcGFnZV9k
YXRhIHdoZW4gQ09ORklHX05VTUE9bi4NCj4gPiANCj4gPiBjb250aWdfcGFnZV9kYXRhIGlzIG9u
bHkgYXZhaWxhYmxlIHdoZW4gQ09ORklHX05VTUE9bg0KPiA+IHNvIHdlIGhhdmUgdG8gdXNlICNp
Zm5kZWYgaGVyZS4NCj4gPiANCj4gPiBObyBmdW5jdGlvbmFsIGNoYW5nZSBpbnRlbmRlZC4NCj4g
PiANCj4gPiBDb21tZW50IGZyb20gTWFyayBbMV06DQo+ID4gIg0KPiA+IC4uLiBhbmQgSSByZWNr
b24gaXQnZCBiZSBjbGVhcmVyIGFuZCBtb3JlIHJvYnVzdCB0byBkZWZpbmUNCj4gPiBwZ2RhdF90
b19waHlzKCkgaW4gdGhlIHNhbWUgaWZkZWZzIGFzIGNvbnRpZ19wYWdlX2RhdGEgc28NCj4gPiB0
aGF0IHRoZXNlLCBzdGF5IGluLXN5bmMuIGUuZy4gaGF2ZToNCj4gPiANCj4gPiB8ICNpZmRlZiBD
T05GSUdfTlVNQQ0KPiA+IHwgI2RlZmluZSBwZ2RhdF90b19waHlzKHgpCXZpcnRfdG9fcGh5cyh4
KQ0KPiA+IHwgI2Vsc2UgLyogQ09ORklHX05VTUEgKi8NCj4gPiB8DQo+ID4gfCBleHRlcm4gc3Ry
dWN0IHBnbGlzdF9kYXRhIGNvbnRpZ19wYWdlX2RhdGE7DQo+ID4gfCAuLi4NCj4gPiB8ICNkZWZp
bmUgcGdkYXRfdG9fcGh5cyh4KQlfX3BhX3N5bWJvbCgmY29udGlnX3BhZ2VfZGF0YSkNCj4gPiB8
DQo+ID4gfCAjZW5kaWYgLyogQ09OSUZJR19OVU1BICovDQo+ID4gIg0KPiA+IA0KPiA+IENvbW1l
bnQgZnJvbSBNaWtlIFsyXToNCj4gPiAiDQo+ID4gSSdtIG5vdCBzdXJlIGEgbWFjcm8gaXMgYmV0
dGVyIHRoYW4gYSBzdGF0aWMgaW5saW5lLg0KPiA+IA0KPiA+IE1heWJlIHdlJ2Qgd2FudCB0byB3
YXJuIGlmIHBnZGF0IHBhc3NlZCB0byBwZ3RhdF90b19waHlzKCkgaXMgbm90DQo+ID4gJmNvbnRp
Z19wYWdlX2RhdGEsIGUuZyBzb21ldGhpbmcgbGlrZQ0KPiA+IA0KPiA+IHN0YXRpYyBpbmxpbmUg
cGh5c19hZGRyX3QgcGdkYXRfdG9fcGh5cyhzdHJ1Y3QgcGdsaXN0X2RhdGEgKnBnZGF0KQ0KPiA+
IHsNCj4gPiAJaWYgKCFJU19FTkFCTEVEKENPTkZJR19OVU1BKSkgew0KPiA+IAkJaWYgKHBnZGF0
ID09ICZjb250aWdfcGFnZV9kYXRhKQ0KPiA+IAkJCXJldHVybiBfX3BhX3N5bWJvbCgmY29udGln
X3BhZ2VfZGF0YSk7DQo+ID4gCQllbHNlDQo+ID4gCQkJcHJfd2FybigiVW5leHBlY3RlZCBwZ2xp
c3RfZGF0YSBwb2ludGVyIVxuIik7DQo+ID4gCX0NCj4gPiANCj4gPiAJcmV0dXJuIF9fcGEocGdk
YXQpOw0KPiA+IH0NCj4gPiAiDQo+ID4gDQo+ID4gWzFdIGh0dHBzOi8vdXJsZGVmZW5zZS5jb20v
djMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1hcm0ta2VybmVsLzIwMjEwNjE1MTMx
OTAyLkdCNDcxMjFAQzAyVEQwVVRIRjFULmxvY2FsL19fOyEhQ1RSTktBOXdNZzBBUmJ3ITFiSlRu
SDJnSjZRdnNCS1RYSDh4T2lLZkhGLXhxXzFkb2szY25FVEQ0ZTRxanJ5bnRGbThLMFhqdEVta0hB
eEc2ZyQgDQo+ID4gWzJdIGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xvcmUu
a2VybmVsLm9yZy9wYXRjaHdvcmsvcGF0Y2gvMTQ1MjkwMy8qMTY1MDc1OV9fO0l3ISFDVFJOS0E5
d01nMEFSYnchMWJKVG5IMmdKNlF2c0JLVFhIOHhPaUtmSEYteHFfMWRvazNjbkVURDRlNHFqcnlu
dEZtOEswWGp0RW1iR1hFa1ZnJCANCj4gPiANCj4gPiBDYzogTWlrZSBSYXBvcG9ydCA8cnBwdEBr
ZXJuZWwub3JnPg0KPiA+IENjOiBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IE1pbGVzIENoZW4gPG1pbGVzLmNoZW5AbWVkaWF0ZWsuY29tPg0K
PiA+IA0KPiA+IC0tLQ0KPiA+IA0KPiA+IENoYW5nZSBzaW5jZSB2MToNCj4gPiBUaGFua3MgZm9y
IE1pa2UncyBjb21tZW50LCBjaGVjayBpZiBwZ2RhdCA9PSAmY29udGlnX3BhZ2VfZGF0YSwNCj4g
PiBzbyBpdCBpcyBjbGVhcmVyIHRoYXQgd2Ugb25seSBleHBlY3QgY29udGlnX3BhZ2VfZGF0YSB3
aGVuDQo+ID4gQ09ORklHX05VTUE9bi4NCj4gPiAtLS0NCj4gPiAgIG1tL3NwYXJzZS5jIHwgNyAr
KysrLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9tbS9zcGFyc2UuYyBiL21tL3NwYXJzZS5jDQo+
ID4gaW5kZXggNjMyNmNkZjM2YzRmLi5mNzNmZjNjMTI0YzUgMTAwNjQ0DQo+ID4gLS0tIGEvbW0v
c3BhcnNlLmMNCj4gPiArKysgYi9tbS9zcGFyc2UuYw0KPiA+IEBAIC0zNDgsMTAgKzM0OCwxMSBA
QCBzaXplX3QgbWVtX3NlY3Rpb25fdXNhZ2Vfc2l6ZSh2b2lkKQ0KPiA+ICAgc3RhdGljIGlubGlu
ZSBwaHlzX2FkZHJfdCBwZ2RhdF90b19waHlzKHN0cnVjdCBwZ2xpc3RfZGF0YSAqcGdkYXQpDQo+
ID4gICB7DQo+ID4gICAjaWZuZGVmIENPTkZJR19OVU1BDQo+ID4gLQlyZXR1cm4gX19wYV9zeW1i
b2wocGdkYXQpOw0KPiA+IC0jZWxzZQ0KPiA+ICsJaWYgKHBnZGF0ID09ICZjb250aWdfcGFnZV9k
YXRhKQ0KPiA+ICsJCXJldHVybiBfX3BhX3N5bWJvbCgmY29udGlnX3BhZ2VfZGF0YSk7DQo+ID4g
Kwlwcl93YXJuKCJVbmV4cGVjdGVkIHBnbGlzdF9kYXRhIHBvaW50ZXIhXG4iKTsNCj4gDQo+IFNo
b3VsZG4ndCB0aGlzIHJhdGhlciBiZSBhIFZNX0JVR19PTigpPw0KPiANCj4gQmVjYXVzZSBpdCBs
b29rcyBsaWtlIHNvbWV0aGluZyB0aGF0IHNob3VsZCBiYXJlbHkgaGFwcGVuIGFuZCB3ZSBtaWdo
dCANCj4gbm90IHdhbnQgdG8gcGVyZm9ybSBydW50aW1lIGNoZWNrcyBvbiBlYWNoIGFuZCBldmVy
eSBzeXN0ZW0/DQoNCnRoYW5rcyBmb3IgeW91ciBjb21tZW50LCBJIHdpbGwgdXNlIFZNX0JVR19P
TigpIHRvIGNoZWNrIGlmIHBnZGF0ID09DQpjb250aWdfcGFnZV9kYXRhIHRvIGF2b2lkIHRoZSBy
dW50aW1lIGNoZWNrLg0KPiANCj4gDQoNCg==

