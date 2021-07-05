Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A4D3BBA22
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 11:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhGEJ1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 05:27:22 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53537 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230149AbhGEJ1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 05:27:21 -0400
X-UUID: 53d9613721654e0f9ba8796b85c37edf-20210705
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=dV2vuesOizqkAALaltoauNH3MR2oZFb5XVp6WIEb1T8=;
        b=J/sFiNrMNP88Q7E7MLAaDcE0P5jADYaIOXFeUdieVC4nbKqr924Y+9Kvw+GwqDKtpuH7HRzKCN5TFm/1Ox8QXNXpMJ1xUqtY/eWuCeazVxZAu7n3wjL6D1Py476eb6TISxYnV9BERAq8QeIZLC9k2td3snWQ9GqvnwdswCJSRbU=;
X-UUID: 53d9613721654e0f9ba8796b85c37edf-20210705
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1395625169; Mon, 05 Jul 2021 17:24:43 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 5 Jul 2021 17:24:41 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 5 Jul 2021 17:24:41 +0800
Message-ID: <1625477081.856.5.camel@mtkswgap22>
Subject: Re: [PATCH] mm/sparse: clarify pgdat_to_phys
From:   Miles Chen <miles.chen@mediatek.com>
To:     Mike Rapoport <rppt@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Mon, 5 Jul 2021 17:24:41 +0800
In-Reply-To: <YN8QaoJuDP9Nr744@kernel.org>
References: <20210630092309.17654-1-miles.chen@mediatek.com>
         <YN8QaoJuDP9Nr744@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTA3LTAyIGF0IDE2OjExICswMzAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBPbiBXZWQsIEp1biAzMCwgMjAyMSBhdCAwNToyMzowOVBNICswODAwLCBNaWxlcyBDaGVuIHdy
b3RlOg0KPiA+IGNsYXJpZnkgcGdkYXRfdG9fcGh5cygpIGJ5IHdyYXBwaW5nIHBnZGF0X3RvX3Bo
eXMNCj4gPiB3aXRoIENPTkZJR19OVU1BLiAodGhlIHNhbWUgY29uZmlnIGFzIGNvbnRpZ19wYWdl
X2RhdGEpDQo+ID4gDQo+ID4gTm8gZnVuY3Rpb25hbCBjaGFuZ2UgaW50ZW5kZWQuDQo+ID4gDQo+
ID4gQ29tbWVudCBmcm9tIE1hcmsgWzFdOg0KPiA+ICINCj4gPiAuLi4gYW5kIEkgcmVja29uIGl0
J2QgYmUgY2xlYXJlciBhbmQgbW9yZSByb2J1c3QgdG8gZGVmaW5lDQo+ID4gcGdkYXRfdG9fcGh5
cygpIGluIHRoZSBzYW1lIGlmZGVmcyBhcyBjb250aWdfcGFnZV9kYXRhIHNvDQo+ID4gdGhhdCB0
aGVzZSwgc3RheSBpbi1zeW5jLiBlLmcuIGhhdmU6DQo+ID4gDQo+ID4gfCAjaWZkZWYgQ09ORklH
X05VTUENCj4gPiB8ICNkZWZpbmUgcGdkYXRfdG9fcGh5cyh4KQl2aXJ0X3RvX3BoeXMoeCkNCj4g
PiB8ICNlbHNlIC8qIENPTkZJR19OVU1BICovDQo+ID4gfA0KPiA+IHwgZXh0ZXJuIHN0cnVjdCBw
Z2xpc3RfZGF0YSBjb250aWdfcGFnZV9kYXRhOw0KPiA+IHwgLi4uDQo+ID4gfCAjZGVmaW5lIHBn
ZGF0X3RvX3BoeXMoeCkJX19wYV9zeW1ib2woJmNvbnRpZ19wYWdlX2RhdGEpDQo+ID4gfA0KPiA+
IHwgI2VuZGlmIC8qIENPTklGSUdfTlVNQSAqLw0KPiA+ICINCj4gPiANCj4gPiBbMV0gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYXJtLWtlcm5lbC8yMDIxMDYxNTEzMTkwMi5HQjQ3MTIx
QEMwMlREMFVUSEYxVC5sb2NhbC8NCj4gPiANCj4gPiBDYzogTWFyayBSdXRsYW5kIDxtYXJrLnJ1
dGxhbmRAYXJtLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNaWxlcyBDaGVuIDxtaWxlcy5jaGVu
QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgbW0vc3BhcnNlLmMgfCAxNyArKysrKysrKyst
LS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9u
cygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9tbS9zcGFyc2UuYyBiL21tL3NwYXJzZS5jDQo+
ID4gaW5kZXggNzI3MmY3YTE0NDlkLi42MmMyMWVjMjhlMzMgMTAwNjQ0DQo+ID4gLS0tIGEvbW0v
c3BhcnNlLmMNCj4gPiArKysgYi9tbS9zcGFyc2UuYw0KPiA+IEBAIC0zNDQsMTQgKzM0NCwxNSBA
QCBzaXplX3QgbWVtX3NlY3Rpb25fdXNhZ2Vfc2l6ZSh2b2lkKQ0KPiA+ICAJcmV0dXJuIHNpemVv
ZihzdHJ1Y3QgbWVtX3NlY3Rpb25fdXNhZ2UpICsgdXNlbWFwX3NpemUoKTsNCj4gPiAgfQ0KPiA+
ICANCj4gPiAtc3RhdGljIGlubGluZSBwaHlzX2FkZHJfdCBwZ2RhdF90b19waHlzKHN0cnVjdCBw
Z2xpc3RfZGF0YSAqcGdkYXQpDQo+ID4gLXsNCj4gPiAtI2lmbmRlZiBDT05GSUdfTlVNQQ0KPiA+
IC0JcmV0dXJuIF9fcGFfc3ltYm9sKHBnZGF0KTsNCj4gPiAtI2Vsc2UNCj4gPiAtCXJldHVybiBf
X3BhKHBnZGF0KTsNCj4gPiAtI2VuZGlmDQo+ID4gLX0NCj4gPiArI2lmZGVmIENPTkZJR19OVU1B
DQo+ID4gKyNkZWZpbmUgcGdkYXRfdG9fcGh5cyhwZ2RhdCkgX19wYShwZ2RhdCkNCj4gPiArI2Vs
c2UgLyogQ09ORklHX05VTUEgKi8NCj4gPiArLyoNCj4gPiArICogV2hlbiAhQ09ORklHX05VTUEs
IHdlIG9ubHkgZXhwZWN0IHBnZGF0ID09ICZjb250aWdfcGFnZV9kYXRhLA0KPiA+ICsgKiBhbmQg
dXNlIF9fcGFfc3ltYm9sKCkuDQo+ID4gKyAqLw0KPiA+ICsjZGVmaW5lIHBnZGF0X3RvX3BoeXMo
cGdkYXQpIF9fcGFfc3ltYm9sKHBnZGF0KQ0KPiA+ICsjZW5kaWYgLyogQ09ORklHX05VTUEgKi8N
Cj4gDQo+IEknbSBub3Qgc3VyZSBhIG1hY3JvIGlzIGJldHRlciB0aGFuIGEgc3RhdGljIGlubGlu
ZS4NCj4gDQo+IE1heWJlIHdlJ2Qgd2FudCB0byB3YXJuIGlmIHBnZGF0IHBhc3NlZCB0byBwZ3Rh
dF90b19waHlzKCkgaXMgbm90DQo+ICZjb250aWdfcGFnZV9kYXRhLCBlLmcgc29tZXRoaW5nIGxp
a2UNCj4gDQo+IHN0YXRpYyBpbmxpbmUgcGh5c19hZGRyX3QgcGdkYXRfdG9fcGh5cyhzdHJ1Y3Qg
cGdsaXN0X2RhdGEgKnBnZGF0KQ0KPiB7DQo+IAlpZiAoIUlTX0VOQUJMRUQoQ09ORklHX05VTUEp
KSB7DQo+IAkJaWYgKHBnZGF0ID09ICZjb250aWdfcGFnZV9kYXRhKQ0KPiAJCQlyZXR1cm4gX19w
YV9zeW1ib2woJmNvbnRpZ19wYWdlX2RhdGEpOw0KPiAJCWVsc2UNCj4gCQkJcHJfd2FybigiVW5l
eHBlY3RlZCBwZ2xpc3RfZGF0YSBwb2ludGVyIVxuIik7DQo+IAl9DQo+IAkNCj4gCXJldHVybiBf
X3BhKHBnZGF0KTsNCj4gfQ0KDQpTb3JyeSBmb3IgbXkgbGF0ZSByZXNwb25zZS4NClRoYW5rcyBm
b3IgdGhlIGd1aWRlLiBJdCBsb29rcyBiZXR0ZXIgdGhpcyB3YXkuSSB3aWxsIHN1Ym1pdCBwYXRj
aCB2Mi4NCg0KPiAgIA0KPiA+ICAjaWZkZWYgQ09ORklHX01FTU9SWV9IT1RSRU1PVkUNCj4gPiAg
c3RhdGljIHN0cnVjdCBtZW1fc2VjdGlvbl91c2FnZSAqIF9faW5pdA0KPiA+IC0tIA0KPiA+IDIu
MTguMA0KPiA+IA0KPiANCg0K

