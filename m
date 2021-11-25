Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13F945D332
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 03:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244547AbhKYCis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 21:38:48 -0500
Received: from smtpbguseast1.qq.com ([54.204.34.129]:51046 "EHLO
        smtpbguseast1.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237790AbhKYCgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 21:36:42 -0500
X-QQ-GoodBg: 1
X-QQ-SSF: B0400000000000F0
X-QQ-FEAT: 7jw2iSiCazoXTPOXxNx8TAAgWRd1IUVbzNWBGROABMxUOynXHfLNm4LGI7VT9
        b+HLpp8Rbw405UztceRDfw6DiXzm1a7BcVEoFspEDQXtTIlxzwQ4AxLVptOY+9bSsl/fmxh
        yJvwFhW/J5e1qZu53AGxxc42Mv/NH4L+l4uujdFbh09vZbw/7atIBCjh6uETM83/P7JthU9
        NIi2/xOKU0jroeLMz2yFT8zNL5kqpR4BrMKqTwPz3AzD6PRFBFIZZCaNF966AtdiYuwi8bz
        XXG2jmamh+KbaCuc1j2WOTGj8OqR65JCFEQ1na2V5X8nYVG7M9Fh5PMdw5pNqaml89Pjfux
        XzyqdVA2AwrnXHQa1974Jr/El0oEnPxpJYybvaF4QghisARRBBEkhfA1lClF5uwERlMn/8f
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 113.57.13.187
X-QQ-STYLE: 
X-QQ-mid: logic531t1637807603t8976761
From:   "=?utf-8?B?bGlhbnpoaSBjaGFuZw==?=" <changlianzhi@uniontech.com>
To:     "=?utf-8?B?ZG1pdHJ5LnRvcm9raG92?=" <dmitry.torokhov@gmail.com>
Cc:     "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>,
        "=?utf-8?B?R3JlZyBLSA==?=" <gregkh@linuxfoundation.org>,
        "=?utf-8?B?amlyaXNsYWJ5?=" <jirislaby@kernel.org>,
        "=?utf-8?B?QW5keSBTaGV2Y2hlbmtv?=" 
        <andriy.shevchenko@linux.intel.com>,
        "=?utf-8?B?MjgyODI3OTYx?=" <282827961@qq.com>
Subject: Re: [PATCH v14] tty: Fix the keyboard led light display problem
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Thu, 25 Nov 2021 10:33:23 +0800
X-Priority: 3
Message-ID: <tencent_5573CD56296D5E2F4C59A664@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20211108055139.7202-1-changlianzhi@uniontech.com>
        <YYtpr/bP0HqBsmbW@google.com>
        <tencent_032E4FE80FDB8EA164AE0644@qq.com>
In-Reply-To: <tencent_032E4FE80FDB8EA164AE0644@qq.com>
X-QQ-ReplyHash: 4029738618
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Thu, 25 Nov 2021 10:33:25 +0800 (CST)
Feedback-ID: logic:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IE9uIE1vbiwgTm92IDA4LCAyMDIxIGF0IDAxOjUxOjM5UE0gKzA4MDAsIGxpYW56aGkg
Y2hhbmcgd3JvdGU6DQo+ID4gPiBTd2l0Y2hpbmcgZnJvbSB0aGUgZGVza3RvcCBlbnZpcm9u
bWVudCB0byB0aGUgdHR5IGVudmlyb25tZW50LA0KPiA+ID4gdGhlIHN0YXRlIG9mIHRoZSBr
ZXlib2FyZCBsZWQgbGlnaHRzIGFuZCB0aGUgc3RhdGUgb2YgdGhlIGtleWJvYXJkDQo+ID4g
PiBsb2NrIGFyZSBpbmNvbnNpc3RlbnQuIFRoaXMgaXMgYmVjYXVzZSB0aGUgYXR0cmlidXRl
IGtiLT5rYmRtb2RlDQo+ID4gPiBvZiB0aGUgdHR5IGJvdW5kIGluIHRoZSBkZXNrdG9wIGVu
dmlyb25tZW50IChYb3JnKSBpcyBzZXQgdG8NCj4gPiA+IFZDX09GRiwgd2hpY2ggY2F1c2Vz
IHRoZSBsZWRzdGF0ZSBhbmQga2ItPmxlZGZsYWdzdGF0ZQ0KDQo+ID4gV2Uga25vdyB0aGF0
IFhvcmcgc2V0cyBrYmRtb2RlIG1vZGUgdG8gVkNfT0ZGLCBidXQgaXQgZG9lcyBub3QgbWVh
biB0aGF0DQo+ID4geW91IGNhbiBzYXkgZm9yIHN1cmUgdGhhdCBpdCBpcyBYb3JnIGluc3Rh
bmNlIHRoYXQgY29udHJvbHMgYSBWVCBzaW1wbHkNCj4gPiBieSBvYnNlcnZpbmcga2ItPmti
ZG1vZGUuIFRoZXJlIG1heSBiZSBzb21ldGhpbmcgZWxzZSBlbnRpcmVseS4gVGhhdCBpcw0K
PiA+IHdoeSB5b3Ugd2FudCBkcml2ZXJzL3R0eS92dC9rZXlib2FyZC5jIHRvIHJlc2V0IExF
RHMgYW5kIGxlYXZlIGl0IHRvDQo+ID4gd2hvZXZlciBpcyBjb250cm9sbGluZyBWVCB0byBz
ZXQgdGhlbSB0byBzb21ldGhpbmcgZWxzZSBpZiBpdCBpcw0KPiA+IGRlc2lyZWQuDQoNCj4g
RG9lcyB0aGlzIG1lYW4gbGV0IG1lIGNoYW5nZSB0aGUgZGVzY3JpcHRpb24gaW5mb3JtYXRp
b24/IE9yIGlzIHRoZQ0KPiBqdWRnbWVudCBvZiBWQ19PRkYgaW4gcGF0Y2ggaW5jb3JyZWN0
Pw0KPiBUaGUgc2V0dXAgbWV0aG9kIG9mIFhvcmcgbWVudGlvbmVkIGhlcmUgaXMganVzdCB0
byBkZXNjcmliZSBhIHByb2Nlc3MNCj4gaW4gd2hpY2ggSSBmb3VuZCB0aGUgcHJvYmxlbTsN
Cj4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IHdoZW4gdGhlIG1vZGUgb2Yga2JkbW9kZSBp
cyBzZXQgdG8gVkNfT0ZGLA0KPiBWVCBzaG91bGRuJ3QgaW50ZXJmZXJlIHdpdGggdGhlIHN0
YXRlIG9mIHRoZSBrZXlib2FyZCBsaWdodCwgcmlnaHQ/IFRoaXMgaXMNCj4gaG93IGZ1bmN0
aW9ucyBzdWNoIGFzIGtiZF9rZXljb2RlKCkgYXJlIGltcGxlbWVudGVkLg0KPiBXaGVuIFZU
IGlzIHN3aXRjaGVkLCBpZiB0aGUgVlQgbW9kZSBpcyBWQ19PRkYsIHRoZXJlIGlzIGFsc28g
bm8gbmVlZA0KPiB0byBzZXQgdGhlIHN0YXRlIG9mIHRoZSBrZXlib2FyZCBsaWdodC4gSSB0
aGluayB0aGlzIGlzIHJlYXNvbmFibGUuDQoNCj4gPiA+ID4gdmFsdWVzIG9mIHRoZSBib3Vu
ZCB0dHkgdG8gYWx3YXlzIGJlIDAsIHdoaWNoIGNhdXNlcyB0aGUgc3dpdGNoDQo+ID4gPiA+
IGZyb20gdGhlIGRlc2t0b3AgV2hlbiB0byB0aGUgdHR5IGVudmlyb25tZW50LCB0aGUgTEVE
IGxpZ2h0DQo+ID4gPiA+IHN0YXR1cyBpcyBpbmNvbnNpc3RlbnQgd2l0aCB0aGUga2V5Ym9h
cmQgbG9jayBzdGF0dXMuDQo+ID4gPiA+IEluIG9yZGVyIHRvIGVuc3VyZSB0aGF0IHRoZSBr
ZXlib2FyZCBMRUQgbGlnaHRzIGFyZSBkaXNwbGF5ZWQNCj4gPiA+ID4gbm9ybWFsbHkgZHVy
aW5nIHRoZSBWVCBzd2l0Y2hpbmcgcHJvY2Vzcywgd2hlbiB0aGUgVlQgaXMNCj4gPiA+ID4g
c3dpdGNoZWQsIHRoZSBjdXJyZW50IFZUIExFRCBjb25maWd1cmF0aW9uIGlzIGZvcmNlZCB0
byBiZSBpc3N1ZWQuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogbGlhbnpoaSBjaGFu
ZyA8Y2hhbmdsaWFuemhpQHVuaW9udGVjaC5jb20+DQo+ID4gPiBTdWdnZXN0ZWQtYnk6IGRt
aXRyeS50b3Jva2hvdiA8ZG1pdHJ5LnRvcm9raG92QGdtYWlsLmNvbT4NCj4gPiA+IFN1Z2dl
c3RlZC1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRl
bC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICB2MTM6DQo+ID4gPiAgVGhlIGtiZF9iaCBmdW5j
dGlvbiBubyBsb25nZXIgaGFuZGxlcyB0aGUgImtiLT5rYmRtb2RlID09IFZDX09GRiINCj4g
PiA+ICBzY2VuZSwgYnV0IHB1dHMgdGhpcyBwcm9jZXNzIGluIHZ0X3NldF9sZWRzX2NvbXB1
dGVfc2hpZnRzdGF0ZQ0KPiA+ID4gIHRvZ2V0aGVyLiBCZWNhdXNlIHRoZSBjdXJyZW50IGNp
cmN1bXZlbnRpb24gaXMgdGhhdCBvdGhlciB0dHlzDQo+ID4gPiAgc3dpdGNoIHRvIHRoZSBY
b3JnLWJvdW5kIHR0eSBzY2VuZSwgc28gdGhpcyBCZXR0ZXIuDQo+ID4gPiAgdjE0Og0KPiA+
ID4gIFNvcnJ5LCBJIGZvcmdvdCB0byB2ZXJpZnkgdGhlIGZvcm1hdCwgaXQgaXMgZ29vZCBu
b3cuDQo+ID4gPg0KPiA+ID4gIGRyaXZlcnMvdHR5L3Z0L2tleWJvYXJkLmMgfCAxOSArKysr
KysrKysrKysrKysrKystDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90
dHkvdnQva2V5Ym9hcmQuYyBiL2RyaXZlcnMvdHR5L3Z0L2tleWJvYXJkLmMNCj4gPiA+IGlu
ZGV4IGM3ZmJiY2RjYzM0Ni4uOTFlMWM1ZDkyMDI5IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJp
dmVycy90dHkvdnQva2V5Ym9hcmQuYw0KPiA+ID4gKysrIGIvZHJpdmVycy90dHkvdnQva2V5
Ym9hcmQuYw0KPiA+ID4gPiBAQCAtMTUzLDYgKzE1Myw3IEBAIHN0YXRpYyBpbnQgc2hpZnRf
c3RhdGUgPSAwOw0KPiA+ID4NCj4gPiA+ICBzdGF0aWMgdW5zaWduZWQgaW50IGxlZHN0YXRl
ID0gLTFVOyAvKiB1bmRlZmluZWQgKi8NCj4gPiA+ICBzdGF0aWMgdW5zaWduZWQgY2hhciBs
ZWRpb2N0bDsNCj4gPiA+ICtzdGF0aWMgYm9vbCB2dF9zd2l0Y2g7DQo+ID4gPg0KPiA+ID4g
IC8qDQo+ID4gPiAgICogTm90aWZpZXIgbGlzdCBmb3IgY29uc29sZSBrZXlib2FyZCBldmVu
dHMNCj4gPiA+IEBAIC00MTIsOSArNDEzLDIwIEBAIHN0YXRpYyB2b2lkIGRvX2NvbXB1dGVf
c2hpZnRzdGF0ZSh2b2lkKQ0KPiA+ID4gIC8qIFdlIHN0aWxsIGhhdmUgdG8gZXhwb3J0IHRo
aXMgbWV0aG9kIHRvIHZ0LmMgKi8NCj4gPiA+ICB2b2lkIHZ0X3NldF9sZWRzX2NvbXB1dGVf
c2hpZnRzdGF0ZSh2b2lkKQ0KPiA+ID4gIHsNCj4gPiA+ICsgc3RydWN0IGtiZF9zdHJ1Y3Qg
KmtiOw0KPiA+ID4gIHVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ID4gPg0KPiA+ID4gLSBzZXRf
bGVkcygpOw0KPiA+ID4gKyAvKiBYb3JnIHdpbGwgYmluZCBhIHR0eSwgdGhlIGtiLT5rYmRt
b2RlIG9mIHRoaXMgdHR5IHdpbGwgYmUgc2V0IHRvDQo+ID4gPiArICogVkNfT0ZGLCBhbmQg
dGhpcyB0dHkgd2lsbCBubyBsb25nZXIgc2V0IHRoZSBrZXlib2FyZCBsaWdodC4gSWYNCj4g
PiA+ICsgKiB0aGVyZSBpcyBubyBzdWNoIHJlc3RyaWN0aW9uLCB3aGVuIHN3aXRjaGluZyBm
cm9tIG90aGVyIHR0eSB0bw0KPiA+ID4gKyAqIFhvcmctYm91bmQgdHR5LCB0aGUgdHR5IHdp
bGwgc2V0IHRoZSBrZXlib2FyZCBsaWdodCwgd2hpY2ggaXMNCj4gPiA+ICsgKiB1bnJlYXNv
bmFibGUNCj4gPiA+ICsgKi8NCj4gPiA+ICsga2IgPSBrYmRfdGFibGUgKyBmZ19jb25zb2xl
Ow0KPiA+ID4gKyBpZiAoa2ItPmtiZG1vZGUgIT0gVkNfT0ZGKSB7DQo+ID4gPiArIHZ0X3N3
aXRjaCA9IHRydWU7DQo+ID4gPiArIHNldF9sZWRzKCk7DQo+ID4gPiArIH0NCj4gPiA+DQo+
ID4gPiAgc3Bpbl9sb2NrX2lycXNhdmUoJmtiZF9ldmVudF9sb2NrLCBmbGFncyk7DQo+ID4g
PiAgZG9fY29tcHV0ZV9zaGlmdHN0YXRlKCk7DQo+ID4gPiBAQCAtMTI1NSw2ICsxMjY3LDEx
IEBAIHN0YXRpYyB2b2lkIGtiZF9iaChzdHJ1Y3QgdGFza2xldF9zdHJ1Y3QgKnVudXNlZCkN
Cj4gPiA+ICBsZWRzIHw9ICh1bnNpZ25lZCBpbnQpa2JkLT5sb2Nrc3RhdGUgPDwgODsNCj4g
PiA+ICBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZsZWRfbG9jaywgZmxhZ3MpOw0KPiA+ID4N
Cj4gPiA+ICsgaWYgKHZ0X3N3aXRjaCkgew0KPiA+ID4gKyBsZWRzdGF0ZSA9IH5sZWRzOw0K
PiA+ID4gKyB2dF9zd2l0Y2ggPSBmYWxzZTsNCj4gPiA+ICsgfQ0KPiA+ID4gKw0KPiA+ID4g
IGlmIChsZWRzICE9IGxlZHN0YXRlKSB7DQo+ID4gPiAga2JkX3Byb3BhZ2F0ZV9sZWRfc3Rh
dGUobGVkc3RhdGUsIGxlZHMpOw0KPiA+ID4gIGxlZHN0YXRlID0gbGVkczsNCj4gPiA+IC0t
DQoNCkhpIGZyaWVuZHMsIGhvdyBpcyB0aGlzIHBhdGNoIHByb2dyZXNzaW5nIG5vdywgZG8g
SSBuZWVkIHRvIG1vZGlmeSBpdCBmdXJ0aGVyPw0KDQpUaGFua3MuDQotLQ0KbGlhbnpoaSBj
aGFuZw==



