Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83BA3305BE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 03:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbhCHCAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 21:00:00 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:56212 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233588AbhCHB7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 20:59:49 -0500
X-UUID: 5829353be91c45ce80dc07f32882201d-20210308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=6qYg+DJBSG1Du8y4MYkkOeqRrd9rwS5CN17jsGP6xzU=;
        b=WA6IpcBHguky+rMLAFcyeVeWfUfnqQYsRTb61ouCgT1I0ZyCZePG80OX9mfkEuH61webF2JR7kblsyqAwLYBVgnRR6TuJQkIfPfOXB4TsBGTJ/4vYovdhyD7mruRBO+S5rJJBhN+k4ZwSNlS88y6kVXiEGZMfT45EsTO46FcwVY=;
X-UUID: 5829353be91c45ce80dc07f32882201d-20210308
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1233242520; Mon, 08 Mar 2021 09:59:34 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs06n2.mediatek.inc
 (172.21.101.130) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 8 Mar
 2021 09:58:37 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 8 Mar 2021 09:58:36 +0800
Message-ID: <1615168716.32109.6.camel@mhfsdcap03>
Subject: Re: [PATCH 16/17] usb: common: add function to get interval
 expressed in us unit
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ikjoon Jang <ikjn@chromium.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Date:   Mon, 8 Mar 2021 09:58:36 +0800
In-Reply-To: <20210305153312.GA38200@rowland.harvard.edu>
References: <1614934975-15188-1-git-send-email-chunfeng.yun@mediatek.com>
         <1614934975-15188-16-git-send-email-chunfeng.yun@mediatek.com>
         <20210305153312.GA38200@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: AA76056FEB5929E229E6F99F439BC3A0267241E9DCA4D6CBEACABBBCC2768C852000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTAzLTA1IGF0IDEwOjMzIC0wNTAwLCBBbGFuIFN0ZXJuIHdyb3RlOg0KPiBP
biBGcmksIE1hciAwNSwgMjAyMSBhdCAwNTowMjo1NFBNICswODAwLCBDaHVuZmVuZyBZdW4gd3Jv
dGU6DQo+ID4gQWRkIGEgbmV3IGZ1bmN0aW9uIHRvIGNvbnZlcnQgYkludGVydmFsIGludG8gdGhl
IHRpbWUgZXhwcmVzc2VkDQo+ID4gaW4gMXVzIHVuaXQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1i
eTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiAN
Cj4gPiAtLS0gYS9kcml2ZXJzL3VzYi9jb21tb24vY29tbW9uLmMNCj4gPiArKysgYi9kcml2ZXJz
L3VzYi9jb21tb24vY29tbW9uLmMNCj4gPiBAQCAtMTY1LDYgKzE2NSwzOSBAQCBlbnVtIHVzYl9k
cl9tb2RlIHVzYl9nZXRfZHJfbW9kZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gIH0NCj4gPiAg
RVhQT1JUX1NZTUJPTF9HUEwodXNiX2dldF9kcl9tb2RlKTsNCj4gPiAgDQo+ID4gK3Vuc2lnbmVk
IGludCB1c2JfZGVjb2RlX2ludGVydmFsKGNvbnN0IHN0cnVjdCB1c2JfZW5kcG9pbnRfZGVzY3Jp
cHRvciAqZXBkLA0KPiA+ICsJCQkJIGVudW0gdXNiX2RldmljZV9zcGVlZCBzcGVlZCkNCj4gPiAr
ew0KPiA+ICsJdW5zaWduZWQgaW50IGludGVydmFsID0gMDsNCj4gPiArDQo+ID4gKwlzd2l0Y2gg
KHVzYl9lbmRwb2ludF90eXBlKGVwZCkpIHsNCj4gPiArCWNhc2UgVVNCX0VORFBPSU5UX1hGRVJf
Q09OVFJPTDoNCj4gPiArCQkvKiB1ZnJhbWVzIHBlciBOQUsgKi8NCj4gPiArCQlpZiAoc3BlZWQg
PT0gVVNCX1NQRUVEX0hJR0gpDQo+ID4gKwkJCWludGVydmFsID0gZXBkLT5iSW50ZXJ2YWw7DQo+
ID4gKwkJYnJlYWs7DQo+ID4gKwljYXNlIFVTQl9FTkRQT0lOVF9YRkVSX0lTT0M6DQo+ID4gKwkJ
aW50ZXJ2YWwgPSAxIDw8IChlcGQtPmJJbnRlcnZhbCAtIDEpOw0KPiA+ICsJCWJyZWFrOw0KPiA+
ICsJY2FzZSBVU0JfRU5EUE9JTlRfWEZFUl9CVUxLOg0KPiA+ICsJCS8qIHVmcmFtZXMgcGVyIE5B
SyAqLw0KPiA+ICsJCWlmIChzcGVlZCA9PSBVU0JfU1BFRURfSElHSCAmJiB1c2JfZW5kcG9pbnRf
ZGlyX291dChlcGQpKQ0KPiA+ICsJCQlpbnRlcnZhbCA9IGVwZC0+YkludGVydmFsOw0KPiA+ICsJ
CWJyZWFrOw0KPiA+ICsJY2FzZSBVU0JfRU5EUE9JTlRfWEZFUl9JTlQ6DQo+ID4gKwkJaWYgKHNw
ZWVkID49IFVTQl9TUEVFRF9ISUdIKQ0KPiA+ICsJCQlpbnRlcnZhbCA9IDEgPDwgKGVwZC0+Yklu
dGVydmFsIC0gMSk7DQo+ID4gKwkJZWxzZQ0KPiA+ICsJCQlpbnRlcnZhbCA9IGVwZC0+YkludGVy
dmFsOw0KPiA+ICsJCWJyZWFrOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWludGVydmFsICo9IChz
cGVlZCA+PSBVU0JfU1BFRURfSElHSCkgPyAxMjUgOiAxMDAwOw0KPiA+ICsNCj4gPiArCXJldHVy
biBpbnRlcnZhbDsNCj4gPiArfQ0KPiA+ICtFWFBPUlRfU1lNQk9MX0dQTCh1c2JfZGVjb2RlX2lu
dGVydmFsKTsNCj4gDQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC91c2IvY2g5LmgNCj4gPiArKysg
Yi9pbmNsdWRlL2xpbnV4L3VzYi9jaDkuaA0KPiA+IEBAIC05MCw2ICs5MCwxNyBAQCBleHRlcm4g
ZW51bSB1c2Jfc3NwX3JhdGUgdXNiX2dldF9tYXhpbXVtX3NzcF9yYXRlKHN0cnVjdCBkZXZpY2Ug
KmRldik7DQo+ID4gICAqLw0KPiA+ICBleHRlcm4gY29uc3QgY2hhciAqdXNiX3N0YXRlX3N0cmlu
ZyhlbnVtIHVzYl9kZXZpY2Vfc3RhdGUgc3RhdGUpOw0KPiA+ICANCj4gPiArLyoqDQo+ID4gKyAq
IHVzYl9kZWNvZGVfaW50ZXJ2YWwgLSBEZWNvZGUgYkludGVydmFsIGludG8gdGhlIHRpbWUgZXhw
cmVzc2VkIGluIDF1cyB1bml0DQo+ID4gKyAqIEBlcGQ6IFRoZSBkZXNjcmlwdG9yIG9mIHRoZSBl
bmRwb2ludA0KPiA+ICsgKiBAc3BlZWQ6IFRoZSBzcGVlZCB0aGF0IHRoZSBlbmRwb2ludCB3b3Jr
cyBhcw0KPiA+ICsgKg0KPiA+ICsgKiBGdW5jdGlvbiByZXR1cm5zIHRoZSBpbnRlcnZhbCBleHBy
ZXNzZWQgaW4gMXVzIHVuaXQgZm9yIHNlcnZpY2luZw0KPiA+ICsgKiBlbmRwb2ludCBmb3IgZGF0
YSB0cmFuc2ZlcnMuDQo+ID4gKyAqLw0KPiA+ICt1bnNpZ25lZCBpbnQgdXNiX2RlY29kZV9pbnRl
cnZhbChjb25zdCBzdHJ1Y3QgdXNiX2VuZHBvaW50X2Rlc2NyaXB0b3IgKmVwZCwNCj4gPiArCQkJ
CSBlbnVtIHVzYl9kZXZpY2Vfc3BlZWQgc3BlZWQpOw0KPiANCj4gQXMgYSBnZW5lcmFsIHJ1bGUs
IEkgYmVsaWV2ZSBwZW9wbGUgZXhwZWN0IHRvIGZpbmQgdGhlIGtlcm5lbGRvYyBmb3IgYSANCj4g
ZnVuY3Rpb24gbmV4dCB0byB0aGUgZnVuY3Rpb24ncyBkZWZpbml0aW9uLCBub3QgbmV4dCB0byB0
aGUgZGVjbGFyYXRpb24gDQo+IGluIGEgaGVhZGVyIGZpbGUuDQpHb3QgaXQsIHRoYW5rcw0KDQo+
IA0KPiBBbGFuIFN0ZXJuDQoNCg==

