Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A9D3D8574
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 03:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbhG1BfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 21:35:11 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:42372 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234015AbhG1BfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 21:35:09 -0400
X-UUID: 83ffc371ee0242f1a9a5e03b4eae63e0-20210728
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=tystcQCeK1JokSJpr3jNYbyoX8+NJdw5MNRuzT9Nl1s=;
        b=B5YTcTWL9N2Ccfi/OHpSmHeQ1b5DSpNGkjNIucKMFWfNzier6BvpJ/OC9il7NL3B1NQCPxjNGQXCW/WBvxH/c0kJv8QuGKkvSn7x024/8rJD8bSMUJFrkBNlpLXaBwnQhuMB2iSh92KC0Hcv0bLiz67/4HtV0FlyXwJ4I3krgP8=;
X-UUID: 83ffc371ee0242f1a9a5e03b4eae63e0-20210728
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2004428482; Wed, 28 Jul 2021 09:35:05 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs06n1.mediatek.inc
 (172.21.101.129) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 28 Jul
 2021 09:35:05 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 28 Jul 2021 09:35:03 +0800
Message-ID: <1627436103.31194.3.camel@mhfsdcap03>
Subject: Re: [PATCH 1/2] phy: introduce phy mode PHY_MODE_UART and
 phy_get_mode_ext()
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Macpaul Lin <macpaul.lin@mediatek.com>
CC:     <linux-phy@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ainge Hsu <ainge.hsu@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Date:   Wed, 28 Jul 2021 09:35:03 +0800
In-Reply-To: <1627383013-4535-1-git-send-email-macpaul.lin@mediatek.com>
References: <1627383013-4535-1-git-send-email-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTA3LTI3IGF0IDE4OjUwICswODAwLCBNYWNwYXVsIExpbiB3cm90ZToNCj4g
U29tZSBlbWJlZGRlZCBwbGF0Zm9ybSBzaGFyZWQgUElOcyBiZXR3ZWVuIFVTQiBhbmQgVUFSVC4N
Cj4gDQo+IEZvciBleGFtcGxlLCBzb21lIHBob25lIHdpbGwgdXNlIHNwZWNpYWwgY2FibGUgZGV0
ZWN0aW9uIGluIGJvb3QgbG9hZGVyDQo+IHRvIHN3aXRjaCBVU0IgcG9ydCBmdW5jdGlvbiBpbnRv
IFVBUlQgbW9kZS4gSGVuY2UgS2VybmVsIG5lZWQgdG8gcXVlcnkNCj4gdGhlIGhhcmR3YXJlIHN0
YXRlIGZyb20gUEhZIHJlZ2lzdGVycyB0byBjb25maXJtIHRoZSBpbml0aWFsemF0aW9uIGZsb3cN
Cj4gZm9yIFBIWSBhbmQgVVNCIGRyaXZlci4NCj4gDQo+IFRvIHN1cHBvcnQgdGhpcyBraW5kIG9m
IFBJTiBzd2l0Y2gsIG5ldyBQSFkgTU9ERSBhbmQgcXVlcnkgQVBJIGlzDQo+IHJlcXVpcmVkLiBI
ZXJlIHdlIGludHJvZHVjZSBhIG5ldyBQSFkgbW9kZTogUEhZX01PREVfVUFSVC4NCj4gDQo+IEFQ
SSBwaHlfZ2V0X21vZGVfZXh0KCkgY2FuIGJlIHVzZWQgdG8gcXVlcnkgdGhlIE1PREUgZnJvbSBo
YXJkd2FyZQ0KPiBpbnN0ZWFkIG9mIHJlYWRpbmcgaXQgZnJvbSBwaHkgYXR0cmlidXRlcy4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IE1hY3BhdWwgTGluIDxtYWNwYXVsLmxpbkBtZWRpYXRlay5jb20+
DQo+IC0tLQ0KPiAgZHJpdmVycy9waHkvcGh5LWNvcmUuYyAgfCAgIDE3ICsrKysrKysrKysrKysr
KysrDQo+ICBpbmNsdWRlL2xpbnV4L3BoeS9waHkuaCB8ICAgIDMgKysrDQo+ICAyIGZpbGVzIGNo
YW5nZWQsIDIwIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS9w
aHktY29yZS5jIGIvZHJpdmVycy9waHkvcGh5LWNvcmUuYw0KPiBpbmRleCBjY2I1NzViLi5iOGY2
NTM5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BoeS9waHktY29yZS5jDQo+ICsrKyBiL2RyaXZl
cnMvcGh5L3BoeS1jb3JlLmMNCj4gQEAgLTM3Myw2ICszNzMsMjMgQEAgaW50IHBoeV9zZXRfbW9k
ZV9leHQoc3RydWN0IHBoeSAqcGh5LCBlbnVtIHBoeV9tb2RlIG1vZGUsIGludCBzdWJtb2RlKQ0K
PiAgfQ0KPiAgRVhQT1JUX1NZTUJPTF9HUEwocGh5X3NldF9tb2RlX2V4dCk7DQo+ICANCj4gK2lu
dCBwaHlfZ2V0X21vZGVfZXh0KHN0cnVjdCBwaHkgKnBoeSkNCj4gK3sNCj4gKwlpbnQgcmV0Ow0K
PiArDQo+ICsJaWYgKCFwaHkgfHwgIXBoeS0+b3BzLT5nZXRfbW9kZV9leHQpDQo+ICsJCXJldHVy
biAwOw0KPiArDQo+ICsJbXV0ZXhfbG9jaygmcGh5LT5tdXRleCk7DQo+ICsJcmV0ID0gcGh5LT5v
cHMtPmdldF9tb2RlX2V4dChwaHkpOw0KPiArCWlmICghcmV0KQ0KPiArCQlyZXQgPSBwaHktPmF0
dHJzLm1vZGU7DQo+ICsJbXV0ZXhfdW5sb2NrKCZwaHktPm11dGV4KTsNCj4gKw0KPiArCXJldHVy
biByZXQ7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MX0dQTChwaHlfZ2V0X21vZGVfZXh0KTsNCj4g
Kw0KPiAgaW50IHBoeV9zZXRfbWVkaWEoc3RydWN0IHBoeSAqcGh5LCBlbnVtIHBoeV9tZWRpYSBt
ZWRpYSkNCj4gIHsNCj4gIAlpbnQgcmV0Ow0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9w
aHkvcGh5LmggYi9pbmNsdWRlL2xpbnV4L3BoeS9waHkuaA0KPiBpbmRleCAwZWQ0MzRkLi43ZDMy
YzZiIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3BoeS9waHkuaA0KPiArKysgYi9pbmNs
dWRlL2xpbnV4L3BoeS9waHkuaA0KPiBAQCAtMzQsNiArMzQsNyBAQCBlbnVtIHBoeV9tb2RlIHsN
Cj4gIAlQSFlfTU9ERV9VU0JfREVWSUNFX0hTLA0KPiAgCVBIWV9NT0RFX1VTQl9ERVZJQ0VfU1Ms
DQo+ICAJUEhZX01PREVfVVNCX09URywNCj4gKwlQSFlfTU9ERV9VQVJULA0KPiAgCVBIWV9NT0RF
X1VGU19IU19BLA0KPiAgCVBIWV9NT0RFX1VGU19IU19CLA0KPiAgCVBIWV9NT0RFX1BDSUUsDQo+
IEBAIC03MCw2ICs3MSw3IEBAIGVudW0gcGh5X21lZGlhIHsNCj4gICAqIEBwb3dlcl9vbjogcG93
ZXJpbmcgb24gdGhlIHBoeQ0KPiAgICogQHBvd2VyX29mZjogcG93ZXJpbmcgb2ZmIHRoZSBwaHkN
Cj4gICAqIEBzZXRfbW9kZTogc2V0IHRoZSBtb2RlIG9mIHRoZSBwaHkNCj4gKyAqIEBnZXRfbW9k
ZV9leHQ6IGdldCB0aGUgZXh0ZW50ZWQgbW9kZSBvZiB0aGUgcGh5DQo+ICAgKiBAc2V0X21lZGlh
OiBzZXQgdGhlIG1lZGlhIHR5cGUgb2YgdGhlIHBoeSAob3B0aW9uYWwpDQo+ICAgKiBAc2V0X3Nw
ZWVkOiBzZXQgdGhlIHNwZWVkIG9mIHRoZSBwaHkgKG9wdGlvbmFsKQ0KPiAgICogQHJlc2V0OiBy
ZXNldHRpbmcgdGhlIHBoeQ0KPiBAQCAtODMsNiArODUsNyBAQCBzdHJ1Y3QgcGh5X29wcyB7DQo+
ICAJaW50CSgqcG93ZXJfb24pKHN0cnVjdCBwaHkgKnBoeSk7DQo+ICAJaW50CSgqcG93ZXJfb2Zm
KShzdHJ1Y3QgcGh5ICpwaHkpOw0KPiAgCWludAkoKnNldF9tb2RlKShzdHJ1Y3QgcGh5ICpwaHks
IGVudW0gcGh5X21vZGUgbW9kZSwgaW50IHN1Ym1vZGUpOw0KPiArCWludAkoKmdldF9tb2RlX2V4
dCkoc3RydWN0IHBoeSAqcGh5KTsNCj4gIAlpbnQJKCpzZXRfbWVkaWEpKHN0cnVjdCBwaHkgKnBo
eSwgZW51bSBwaHlfbWVkaWEgbWVkaWEpOw0KPiAgCWludAkoKnNldF9zcGVlZCkoc3RydWN0IHBo
eSAqcGh5LCBpbnQgc3BlZWQpOw0KPiAgDQphZGQgcHJvdG90eXBlIG9mIHBoeV9nZXRfbW9kZV9l
eHQoc3RydWN0IHBoeSAqcGh5KSBmb3IgYm90aCBjYXNlcyB0aGF0DQpDT05GSUdfR0VORVJJQ19Q
SFkgaXMgZW5hYmxlZCBvciBub3QgaW4gbGludXgvcGh5L3BoeS5oDQoNCg==

