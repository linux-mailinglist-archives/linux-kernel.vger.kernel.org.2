Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6EE33E6FD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 03:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhCQC1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 22:27:39 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3469 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhCQC13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 22:27:29 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4F0Ysn56KRz5crC;
        Wed, 17 Mar 2021 10:25:33 +0800 (CST)
Received: from dggema763-chm.china.huawei.com (10.1.198.205) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Wed, 17 Mar 2021 10:27:26 +0800
Received: from dggema768-chm.china.huawei.com (10.1.198.210) by
 dggema763-chm.china.huawei.com (10.1.198.205) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Wed, 17 Mar 2021 10:27:26 +0800
Received: from dggema768-chm.china.huawei.com ([10.9.48.81]) by
 dggema768-chm.china.huawei.com ([10.9.48.81]) with mapi id 15.01.2106.013;
 Wed, 17 Mar 2021 10:27:26 +0800
From:   "linfeng (M)" <linfeng23@huawei.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Huangweidong (C)" <weidong.huang@huawei.com>,
        "Wangjing (Hogan, Cloud Infrastructure Service Product Dept.)" 
        <hogan.wang@huawei.com>,
        "Wangxin (Alexander)" <wangxinxin.wang@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: RE: [PATCH] x86/kaslr: try process e820 entries if can not get
 suitable regions from efi
Thread-Topic: [PATCH] x86/kaslr: try process e820 entries if can not get
 suitable regions from efi
Thread-Index: AQHW40BOPMsRyBicpkWTP4HdZRlWOqoYND8AgADK1ICAANie4IBt+wjQ
Date:   Wed, 17 Mar 2021 02:27:26 +0000
Message-ID: <a8a2218428924264a3e9a62ab190a7e9@huawei.com>
References: <20210105085346.995-1-linfeng23@huawei.com>
 <CAMj1kXHJ62ib6zeRuqEKoASP1244naWijw9s7Ofhc8_g2K7WNA@mail.gmail.com>
 <X/TTgYA+C0LjFAo2@rani.riverdale.lan> 
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.151.88]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBXZWQsIDE3IE1hciAwOTo1NCwgTGluIEZlbmcgPGxpbmZlbmcyM0BodWF3ZWkuY29tPiB3
cm90ZToNCkFmdGVyIG1vcmUgdGhhbiBvbmUgbW9udGggdGVzdGluZywgd2UgZmluZCB0aGF0IGl0
IGlzIG5vdCBzdWl0YWJsZSB0byBwcm9jZXNzDQplODIwIGRpcmVjdGx5IGluIGtleGVjIHRvIHBs
YWNlIHRoZSBrZXJuZWwgY29kZS4gU29tZSByZWdpb25zLCBsaWtlIHRtcGxvZw0KYW5kIG1lbWF0
dHIgdGFibGVzLCBhcmUgbm90IG1hcmtlZCBhcyByZXNlcnZlZCBpbiBlODIwLg0KVGFrZSB0bXBs
b2csIGZvciBleGFtcGxlLCB0aGUgbWVtb3J5IG9mIHRhYmxlIGlzIG1hcmtlZCBhcyBFODIwX1RZ
UEVfUkFNDQppbiBlODIwIGFuZCBFRklfTE9BREVSX0RBVEEgaW4gZWZpLiBJIHdvbmRlciB3aHkg
bm90IG1hcmtlZCBpdCBhcw0KRTgyMF9UWVBFX1JFU0VSVkVELCB3aGljaCBpcyBjb250cmFyeSB0
byBvdXIgZXhwZWN0YXRpb25zLiBTbyBwcm9jZXNzaW5nDQplODIwIGRpcmVjdGx5IGluIGtleGVj
IGlzIGFnYWluc3QgdGhlIHByaW5jaXBsZXMgb2YgdGhlIGNvbW1pdA0KICAgIDA5ODJhZGM3NDY3
MyAoIng4Ni9ib290L0tBU0xSOiBXb3JrIGFyb3VuZCBmaXJtd2FyZSBidWdzIGJ5IGV4Y2x1ZGlu
Zw0KV2UgdHJ5IHRvIGF2b2lkIHBsYWNpbmcga2VybmVsIGNvZGUgb3IgZGF0YSBvbiB0bXBsb2cg
bWVtb3J5IHJhbmdlIGluDQprZXhlYy4gQnV0IHVuZm9ydHVuYXRlbHksIHRoZSBlZmkgaW5mbyBp
cyBub3QgcnVubmFibGUsIHNvIGl0IGlzIGFiYW5kb25lZCBpbiBmdW5jdGlvbg0KZWZpX21hcF9y
ZWdpb25zLiBXZSBjYW4gbm90IGdldCB0aGUgaW5mbyBpbiBrZXhlYy4NCkFueSB3YXksIHdlIHNr
aWxsIGhhdmVuJ3QgZm91bmQgYSBzdWl0YWJsZSBzb2x1dGlvbi4gQW55IGlkZWFzLCBmcmllbmRz
Pw0KPiBPbiBXZWQsIDYgSmFuIDIwMjEgMDM6MDQsIExpbiBGZW5nIDxsaW5mZW5nMjNAaHVhd2Vp
LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBUdWUsIEphbiAwNSwgMjAyMSBhdCAwOTo1NDo1MkFN
ICswMTAwLCBBcmQgQmllc2hldXZlbCB3cm90ZToNCj4gPiA+IChjYyBBcnZpbmQpDQo+ID4gPg0K
PiA+ID4gT24gVHVlLCA1IEphbiAyMDIxIGF0IDA5OjU0LCBMaW4gRmVuZyA8bGluZmVuZzIzQGh1
YXdlaS5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBPbiBlZmk2NCB4ODZfNjQgc3lzdGVt
LCB0aGUgRUZJX0NPTlZFTlRJT05BTF9NRU1PUlkgcmVnaW9ucyB3aWxsIG5vdA0KPiA+ID4gPiBi
ZSBtYXBwZWQgd2hlbiBtYWtpbmcgRUZJIHJ1bnRpbWUgY2FsbHMuIFNvIGtleGVjLXRvb2xzIGNh
biBub3QNCj4gPiA+ID4gZ2V0IHRoZXNlIGZyb20gL3N5cy9maXJtd2FyZS9lZmkvcnVudGltZS1t
YXAuIFRoZW4gY29tcHJlc3NlZCBib290DQo+ID4gPiA+IG9zIGNhbiBub3QgZ2V0IHN1aXRhYmxl
IHJlZ2lvbnMgaW4gcHJvY2Vzc19lZmlfZW50cmllcyBhbmQgcHJpbnQNCj4gPiA+ID4gZGVidWcg
bWVzc2FnZSBhcyBmb2xsb3c6DQo+ID4gPiA+ICAgICAgICAgUGh5c2ljYWwgS0FTTFIgZGlzYWJs
ZWQ6IG5vIHN1aXRhYmxlIG1lbW9yeSByZWdpb24hDQo+ID4gPiA+IFRvIGVuYWJsZSBwaHlzaWNh
bCBrYXNsciB3aXRoIGtleGVjLCBjYWxsIHByb2Nlc3NfZTgyMF9lbnRyaWVzDQo+ID4gPiA+IHdo
ZW4gbm8gc3VpdGFibGUgcmVnaW9ucyBpbiBlZmkgbWVtbWFwcy4NCj4gPiA+ID4NCj4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogTGluIEZlbmcgPGxpbmZlbmcyM0BodWF3ZWkuY29tPg0KPiA+ID4gPg0K
PiA+ID4gPiAtLS0NCj4gPiA+ID4NCj4gPiA+ID4gSSBmaW5kIGEgcmVndWxhciBvZiBLZXJuZWwg
Y29kZSBhbmQgZGF0YSBwbGFjZW1lbnQgd2l0aCBrZXhlYy4gSXQNCj4gPiA+ID4gc2VlbXMgdW5z
YWZlLiBUaGUgcmVhc29uIGlzIHNob3dlZCBhYm92ZS4NCj4gPiA+ID4NCj4gPiA+ID4gSSdtIG5v
dCBmYW1pbGlhciB3aXRoIGVmaSBmaXJtd2FyZS4gSSB3b25kZXIgaWYgdGhlcmUgYXJlIHNvbWUN
Cj4gPiA+ID4gcmlza3MgdG8gZ2V0IHJlZ2lvbnMgYWNjb3JkaW5nIHRvIGU4MjAgd2hlbiB0aGVy
ZSBpcyBubyBzdWl0YWJsZQ0KPiA+ID4gPiByZWdpb24gaW4gZWZpIG1lbW1hcHMuDQo+ID4gPiA+
IC0tLQ0KPiA+ID4gPiAgYXJjaC94ODYvYm9vdC9jb21wcmVzc2VkL2thc2xyLmMgfCA0ICsrKy0N
Cj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9r
YXNsci5jDQo+ID4gPiA+IGIvYXJjaC94ODYvYm9vdC9jb21wcmVzc2VkL2thc2xyLmMNCj4gPiA+
ID4gaW5kZXggYjkyZmZmYmU3NjFmLi5kYmQ3MjQ0YjcxYWEgMTAwNjQ0DQo+ID4gPiA+IC0tLSBh
L2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9rYXNsci5jDQo+ID4gPiA+ICsrKyBiL2FyY2gveDg2
L2Jvb3QvY29tcHJlc3NlZC9rYXNsci5jDQo+ID4gPiA+IEBAIC02ODUsNiArNjg1LDcgQEAgcHJv
Y2Vzc19lZmlfZW50cmllcyh1bnNpZ25lZCBsb25nIG1pbmltdW0sDQo+ID4gPiA+IHVuc2lnbmVk
IGxvbmcgaW1hZ2Vfc2l6ZSkgIHsNCj4gPiA+ID4gICAgICAgICBzdHJ1Y3QgZWZpX2luZm8gKmUg
PSAmYm9vdF9wYXJhbXMtPmVmaV9pbmZvOw0KPiA+ID4gPiAgICAgICAgIGJvb2wgZWZpX21pcnJv
cl9mb3VuZCA9IGZhbHNlOw0KPiA+ID4gPiArICAgICAgIGJvb2wgZWZpX21lbV9yZWdpb25fZm91
bmQgPSBmYWxzZTsNCj4gPiA+ID4gICAgICAgICBzdHJ1Y3QgbWVtX3ZlY3RvciByZWdpb247DQo+
ID4gPiA+ICAgICAgICAgZWZpX21lbW9yeV9kZXNjX3QgKm1kOw0KPiA+ID4gPiAgICAgICAgIHVu
c2lnbmVkIGxvbmcgcG1hcDsNCj4gPiA+ID4gQEAgLTc0MiwxMiArNzQzLDEzIEBAIHByb2Nlc3Nf
ZWZpX2VudHJpZXModW5zaWduZWQgbG9uZyBtaW5pbXVtLCB1bnNpZ25lZCBsb25nIGltYWdlX3Np
emUpDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgIShtZC0+YXR0cmlidXRlICYgRUZJX01F
TU9SWV9NT1JFX1JFTElBQkxFKSkNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgY29u
dGludWU7DQo+ID4gPiA+DQo+ID4gPiA+ICsgICAgICAgICAgICAgICBlZmlfbWVtX3JlZ2lvbl9m
b3VuZCA9IGZhbHNlOw0KPiA+IAkJCQkJICAgXl4gdGhpcyBzaG91bGQgYmUgdHJ1ZSwgbm90IGZh
bHNlLg0KPiBZb3UncmUgcmlnaHQuIEl0IHNob3VsZCBiZSB0cnVlIGhlcmUuIFRoYW5rcyBmb3Ig
cG9pbnRpbmcgb3V0Lg0KPiA+DQo+ID4gT3RoZXIgdGhhbiB0aGF0LCBJIHRoaW5rIHRoaXMgc2hv
dWxkIGJlIG9rYXkuIFRoZSByZWFzb24gRUZJIG1lbW1hcCBpcw0KPiA+IHByZWZlcnJlZCBvdmVy
IEU4MjAsIGFjY29yZGluZyB0byBjb21taXQNCj4gPg0KPiA+ICAgMDk4MmFkYzc0NjczICgieDg2
L2Jvb3QvS0FTTFI6IFdvcmsgYXJvdW5kIGZpcm13YXJlIGJ1Z3MgYnkNCj4gPiBleGNsdWRpbmcN
Cj4gPiBFRklfQk9PVF9TRVJWSUNFU18qIGFuZCBFRklfTE9BREVSXyogZnJvbSBLQVNMUidzIGNo
b2ljZSIpDQo+ID4NCj4gPiB3YXMgdG8gYXZvaWQgYWxsb2NhdGluZyBpbnNpZGUgRUZJX0JPT1Rf
U0VSVklDRVMvRUZJX0xPQURFUl9EQVRBIGV0Yy4NCj4gPiBUaGF0J3Mgbm90IGEgZGFuZ2VyIGR1
cmluZyBrZXhlYywgYW5kIEkgYmVsaWV2ZSBydW50aW1lIHNlcnZpY2VzDQo+ID4gcmVnaW9ucyBz
aG91bGQgYmUgbWFya2VkIGFzIHJlc2VydmVkIGluIHRoZSBFODIwIG1hcCwgcmlnaHQ/DQo+IFll
cy4NCj4gPg0KPiA+IEFsc28sIHNvbWV0aGluZyBhIGxpdHRsZSBmaXNoeS1sb29raW5nIGhlcmUg
aXMgdGhhdCB0aGUgZmlyc3QgbG9vcCB0bw0KPiA+IHNlZSBpZiB0aGVyZSBpcyBhbnkgRUZJX01F
TU9SWV9NT1JFX1JFTElBQkxFIHJlZ2lvbiBkb2VzIG5vdCBhcHBseSBhbnkNCj4gPiBvZiB0aGUg
Y2hlY2tzIG9uIHRoZSBtZW1vcnkgcmVnaW9uIHR5cGUvYXR0cmlidXRlcy4gSWYgdGhlcmUgaXMg
YQ0KPiA+IG1pcnJvciByZWdpb24gYnV0IGl0IGlzbid0IGNvbnZlbnRpb25hbCBtZW1vcnksIG9y
IGlmIGl0IHdhcw0KPiA+IHNvZnQtcmVzZXJ2ZWQsIHdlIHNob3VsZG4ndCBiZSBzZXR0aW5nIGVm
aV9taXJyb3JfZm91bmQuDQo+IEkgdGhpbmsgc28uIEFuZCBJIHdvbmRlciBpZiB0aGUgbWVtb3J5
IG1pcnJvciBkb2Vzbid0IHdvcmsgd2l0aCBrZXhlYyBhbmQga3NhbHINCj4gb25seSB0aGlzIHBh
dGNoIHVzZWQsIGJlY2F1c2UgYSBsb3Qgb2YgZWZpIGluZm9ybWF0aW9uIGlzIGxvc3QgYW5kIGU4
MjAgZG9uJ3QgaGF2ZQ0KPiBhbnkgbWlycm9yIHJlZ2lvbnMgaW5mb3JtYXRpb24uIER1ZSB0byBy
ZXNvdXJjZSBjb25zdHJhaW50cywgSSBoYXZlbid0IHRlc3RlZCBpdA0KPiB5ZXQuDQo+IEJ1dCBp
dCBzZWVtcyBzby4NCj4gPg0KPiA+DQo+ID4gPiA+ICAgICAgICAgICAgICAgICByZWdpb24uc3Rh
cnQgPSBtZC0+cGh5c19hZGRyOw0KPiA+ID4gPiAgICAgICAgICAgICAgICAgcmVnaW9uLnNpemUg
PSBtZC0+bnVtX3BhZ2VzIDw8IEVGSV9QQUdFX1NISUZUOw0KPiA+ID4gPiAgICAgICAgICAgICAg
ICAgaWYgKHByb2Nlc3NfbWVtX3JlZ2lvbigmcmVnaW9uLCBtaW5pbXVtLCBpbWFnZV9zaXplKSkN
Cj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gPiA+ICAgICAgICAg
fQ0KPiA+ID4gPiAtICAgICAgIHJldHVybiB0cnVlOw0KPiA+ID4gPiArICAgICAgIHJldHVybiBl
ZmlfbWVtX3JlZ2lvbl9mb3VuZDsNCj4gPiA+ID4gIH0NCj4gPiA+ID4gICNlbHNlDQo+ID4gPiA+
ICBzdGF0aWMgaW5saW5lIGJvb2wNCj4gPiA+ID4gLS0NCj4gPiA+ID4gMi4yMy4wDQo+ID4gPiA+
DQo=
