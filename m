Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBA5387292
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 08:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242012AbhERGs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 02:48:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3579 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241933AbhERGsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 02:48:24 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fkmgk4d3RzmVjV;
        Tue, 18 May 2021 14:44:18 +0800 (CST)
Received: from dggemi760-chm.china.huawei.com (10.1.198.146) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 14:47:03 +0800
Received: from lhreml703-chm.china.huawei.com (10.201.108.52) by
 dggemi760-chm.china.huawei.com (10.1.198.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 18 May 2021 14:47:02 +0800
Received: from lhreml703-chm.china.huawei.com ([10.201.68.198]) by
 lhreml703-chm.china.huawei.com ([10.201.68.198]) with mapi id 15.01.2176.012;
 Tue, 18 May 2021 07:47:00 +0100
From:   Salil Mehta <salil.mehta@huawei.com>
To:     "wangyanan (Y)" <wangyanan55@huawei.com>
CC:     Peter Maydell <peter.maydell@linaro.org>,
        Andrew Jones <drjones@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Shannon Zhao <shannon.zhaosl@gmail.com>,
        "Alistair Francis" <alistair.francis@wdc.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
        yangyicong <yangyicong@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "Wanghaibin (D)" <wanghaibin.wang@huawei.com>,
        zhukeqian <zhukeqian1@huawei.com>,
        yuzenghui <yuzenghui@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: RE: [RFC PATCH v3 6/9] hw/arm/virt-acpi-build: Use possible cpus in
 generation of MADT
Thread-Topic: [RFC PATCH v3 6/9] hw/arm/virt-acpi-build: Use possible cpus in
 generation of MADT
Thread-Index: AQHXSj8wnuHxD9/W3U6Az/MWJnnxn6rn6C1AgAC4rwCAACsOwA==
Date:   Tue, 18 May 2021 06:47:00 +0000
Message-ID: <82d006dab8b64e658f205246abc850c2@huawei.com>
References: <20210516102900.28036-1-wangyanan55@huawei.com>
 <20210516102900.28036-7-wangyanan55@huawei.com>
 <6d3c643dc9174f8199ea9422f9e995e5@huawei.com>
 <14284387-dcf4-cfb2-127c-5d1e1d0ecb79@huawei.com>
In-Reply-To: <14284387-dcf4-cfb2-127c-5d1e1d0ecb79@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.31.227]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiB3YW5neWFuYW4gKFkpDQo+IFNlbnQ6IFR1ZXNkYXksIE1heSAxOCwgMjAyMSA2OjAz
IEFNDQo+IA0KPiBIaSBTYWxpbCwNCj4gDQo+IE9uIDIwMjEvNS8xOCAxOjA3LCBTYWxpbCBNZWh0
YSB3cm90ZToNCj4gPj4gRnJvbTogUWVtdS1hcm0NCj4gW21haWx0bzpxZW11LWFybS1ib3VuY2Vz
K3NhbGlsLm1laHRhPWh1YXdlaS5jb21Abm9uZ251Lm9yZ10NCj4gPj4gT24gQmVoYWxmIE9mIFlh
bmFuIFdhbmcNCj4gPj4gU2VudDogU3VuZGF5LCBNYXkgMTYsIDIwMjEgMTE6MjkgQU0NCj4gPj4g
VG86IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47IEFuZHJldyBKb25l
cw0KPiA+PiA8ZHJqb25lc0ByZWRoYXQuY29tPjsgTWljaGFlbCBTIC4gVHNpcmtpbiA8bXN0QHJl
ZGhhdC5jb20+OyBJZ29yIE1hbW1lZG92DQo+ID4+IDxpbWFtbWVkb0ByZWRoYXQuY29tPjsgU2hh
bm5vbiBaaGFvIDxzaGFubm9uLnpoYW9zbEBnbWFpbC5jb20+OyBBbGlzdGFpcg0KPiA+PiBGcmFu
Y2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+OyBEYXZpZCBHaWJzb24NCj4gPj4gPGRhdmlk
QGdpYnNvbi5kcm9wYmVhci5pZC5hdT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgcWVtdS1hcm1A
bm9uZ251Lm9yZw0KPiA+PiBDYzogU29uZyBCYW8gSHVhIChCYXJyeSBTb25nKSA8c29uZy5iYW8u
aHVhQGhpc2lsaWNvbi5jb20+OyB6aHVrZXFpYW4NCj4gPj4gPHpodWtlcWlhbjFAaHVhd2VpLmNv
bT47IHlhbmd5aWNvbmcgPHlhbmd5aWNvbmdAaHVhd2VpLmNvbT47IFplbmd0YW8gKEIpDQo+ID4+
IDxwcmltZS56ZW5nQGhpc2lsaWNvbi5jb20+OyBXYW5naGFpYmluIChEKSA8d2FuZ2hhaWJpbi53
YW5nQGh1YXdlaS5jb20+Ow0KPiA+PiB5dXplbmdodWkgPHl1emVuZ2h1aUBodWF3ZWkuY29tPjsg
UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT47DQo+ID4+IFBoaWxpcHBlIE1hdGhp
ZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4NCj4gPj4gU3ViamVjdDogW1JGQyBQQVRDSCB2
MyA2LzldIGh3L2FybS92aXJ0LWFjcGktYnVpbGQ6IFVzZSBwb3NzaWJsZSBjcHVzIGluDQo+ID4+
IGdlbmVyYXRpb24gb2YgTUFEVA0KPiA+Pg0KPiA+PiBXaGVuIGJ1aWxkaW5nIEFDUEkgdGFibGVz
IHJlZ2FyZGluZyBDUFVzIHdlIHNob3VsZCBhbHdheXMgYnVpbGQNCj4gPj4gdGhlbSBmb3IgdGhl
IG51bWJlciBvZiBwb3NzaWJsZSBDUFVzLCBub3QgdGhlIG51bWJlciBvZiBwcmVzZW50DQo+ID4+
IENQVXMuIFNvIHdlIGNyZWF0ZSBnaWNjIG5vZGVzIGluIE1BRFQgZm9yIHBvc3NpYmxlIGNwdXMg
YW5kIHRoZW4NCj4gPj4gZW5zdXJlIG9ubHkgdGhlIHByZXNlbnQgQ1BVcyBhcmUgbWFya2VkIEVO
QUJMRUQuIEZ1cnRoZXJtb3JlLCBpdA0KPiA+PiBhbHNvIG5lZWRlZCBpZiB3ZSBhcmUgZ29pbmcg
dG8gc3VwcG9ydCBDUFUgaG90cGx1ZyBpbiB0aGUgZnV0dXJlLg0KPiA+IEhpIFlhbmFuLA0KPiA+
IFllcywgdGhlc2UgY2hhbmdlcyBhcmUgcGFydCBvZiB0aGUgUUVNVSBwYXRjaC1zZXQgSSBmbG9h
dGVkIGxhc3QgeWVhci4NCj4gPg0KPiA+IExpbms6IGh0dHBzOi8vd3d3Lm1haWwtYXJjaGl2ZS5j
b20vcWVtdS1kZXZlbEBub25nbnUub3JnL21zZzcxMjAxOC5odG1sDQo+IFllcywgSSBub3RpY2Vk
IHRoaXMuIFRoYW5rcyENCj4gPg0KPiA+IFBlcmhhcHMgSSBhbSBtaXNzaW5nIHNvbWV0aGluZywg
YnV0IGhvdyB0aGlzIHBhdGNoIGlzIHJlbGF0ZWQgdG8gdGhlIHZjcHUNCj4gPiB0b3BvbG9neSBz
dXBwb3J0Pw0KPiBObyByZWxhdGVkIGFjdHVhbGx5LiBCdXQgdGhpcyBwYXRjaCB0b2dldGhlciB3
aXRoIHBhdGNoIDUgYWltIHRvIHByb3ZpZGUNCj4gY29tcGxldGUgaW5mb3JtYXRpb24gKGFsbCBj
cHVzIGluY2x1ZGluZyBlbmFibGVkIGFuZCB0aGUgb3RoZXJzKSB0byBndWVzdCwNCj4gd2hpY2gg
d2lsbCBiZSBtb3JlIGNvbnNpc3RlbnQgd2l0aCByZXF1aXJlbWVudCBpbiBBQ1BJIHNwZWMuDQoN
Cg0KV2VsbCwgaWYgaXQgaXMgbm90IHJlbGF0ZWQgdG8gdGhlIGNwdSB0b3BvbG9neSBzdXBwb3J0
IHRoZW4gdGhpcyBhbmQgb3RoZXINCnNpbWlsYXIgcGF0Y2hlcyBpbmNsdWRlZCB3aXRoIHRoZSBz
YW1lIGxpbmUgb2YgdGhvdWdodCBzaG91bGQgbm90IGJlDQpwYXJ0IG9mIHRoaXMgcGF0Y2gtc2V0
LiANCg0KSSBhbSBhbHJlYWR5IHdvcmtpbmcgd2l0aCBBUk0gZm9sa3MgaW4gdGhpcyByZWdhcmQu
DQoNClRoYW5rcw0KDQo+IA0KPiBXZSBkb24ndCBjb25zaWRlciBjcHUgaG90cGx1ZyBhdCBhbGwg
aW4gdGhpcyBwYXRjaCwgYnV0IGl0IGluZGVlZCBwYXZlIHdheQ0KPiBmb3IgY3B1IGhvdHBsdWcg
aW4gdGhlIGZ1dHVyZS4NCj4gDQo+IFRoYW5rcywNCj4gWWFuYW4NCj4gPiBUaGFua3MNCj4gPg0K
PiA+PiBDby1kZXZlbG9wZWQtYnk6IEFuZHJldyBKb25lcyA8ZHJqb25lc0ByZWRoYXQuY29tPg0K
PiA+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXcgSm9uZXMgPGRyam9uZXNAcmVkaGF0LmNvbT4NCj4g
Pj4gQ28tZGV2ZWxvcGVkLWJ5OiBZaW5nIEZhbmcgPGZhbmd5aW5nMUBodWF3ZWkuY29tPg0KPiA+
PiBTaWduZWQtb2ZmLWJ5OiBZaW5nIEZhbmcgPGZhbmd5aW5nMUBodWF3ZWkuY29tPg0KPiA+PiBD
by1kZXZlbG9wZWQtYnk6IFlhbmFuIFdhbmcgPHdhbmd5YW5hbjU1QGh1YXdlaS5jb20+DQo+ID4+
IFNpZ25lZC1vZmYtYnk6IFlhbmFuIFdhbmcgPHdhbmd5YW5hbjU1QGh1YXdlaS5jb20+DQo+ID4+
IC0tLQ0KPiA+PiAgIGh3L2FybS92aXJ0LWFjcGktYnVpbGQuYyB8IDI5ICsrKysrKysrKysrKysr
KysrKysrKysrKystLS0tDQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyks
IDQgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9ody9hcm0vdmlydC1hY3Bp
LWJ1aWxkLmMgYi9ody9hcm0vdmlydC1hY3BpLWJ1aWxkLmMNCj4gPj4gaW5kZXggYTJkOGU4NzYx
Ni4uNGQ2NGFlYjg2NSAxMDA2NDQNCj4gPj4gLS0tIGEvaHcvYXJtL3ZpcnQtYWNwaS1idWlsZC5j
DQo+ID4+ICsrKyBiL2h3L2FybS92aXJ0LWFjcGktYnVpbGQuYw0KPiA+PiBAQCAtNDgxLDYgKzQ4
MSw5IEBAIGJ1aWxkX21hZHQoR0FycmF5ICp0YWJsZV9kYXRhLCBCSU9TTGlua2VyICpsaW5rZXIs
DQo+ID4+IFZpcnRNYWNoaW5lU3RhdGUgKnZtcykNCj4gPj4gICAgICAgY29uc3QgaW50ICppcnFt
YXAgPSB2bXMtPmlycW1hcDsNCj4gPj4gICAgICAgQWNwaU1hZHRHZW5lcmljRGlzdHJpYnV0b3Ig
KmdpY2Q7DQo+ID4+ICAgICAgIEFjcGlNYWR0R2VuZXJpY01zaUZyYW1lICpnaWNfbXNpOw0KPiA+
PiArICAgIE1hY2hpbmVDbGFzcyAqbWMgPSBNQUNISU5FX0dFVF9DTEFTUyh2bXMpOw0KPiA+PiAr
ICAgIGNvbnN0IENQVUFyY2hJZExpc3QgKnBvc3NpYmxlX2NwdXMgPQ0KPiA+PiBtYy0+cG9zc2li
bGVfY3B1X2FyY2hfaWRzKE1BQ0hJTkUodm1zKSk7DQo+ID4+ICsgICAgYm9vbCBwbXU7DQo+ID4+
ICAgICAgIGludCBpOw0KPiA+Pg0KPiA+PiAgICAgICBhY3BpX2RhdGFfcHVzaCh0YWJsZV9kYXRh
LCBzaXplb2YoQWNwaU11bHRpcGxlQXBpY1RhYmxlKSk7DQo+ID4+IEBAIC00OTEsMTEgKzQ5NCwy
MSBAQCBidWlsZF9tYWR0KEdBcnJheSAqdGFibGVfZGF0YSwgQklPU0xpbmtlciAqbGlua2VyLA0K
PiA+PiBWaXJ0TWFjaGluZVN0YXRlICp2bXMpDQo+ID4+ICAgICAgIGdpY2QtPmJhc2VfYWRkcmVz
cyA9IGNwdV90b19sZTY0KG1lbW1hcFtWSVJUX0dJQ19ESVNUXS5iYXNlKTsNCj4gPj4gICAgICAg
Z2ljZC0+dmVyc2lvbiA9IHZtcy0+Z2ljX3ZlcnNpb247DQo+ID4+DQo+ID4+IC0gICAgZm9yIChp
ID0gMDsgaSA8IE1BQ0hJTkUodm1zKS0+c21wLmNwdXM7IGkrKykgew0KPiA+PiArICAgIGZvciAo
aSA9IDA7IGkgPCBwb3NzaWJsZV9jcHVzLT5sZW47IGkrKykgew0KPiA+PiAgICAgICAgICAgQWNw
aU1hZHRHZW5lcmljQ3B1SW50ZXJmYWNlICpnaWNjID0gYWNwaV9kYXRhX3B1c2godGFibGVfZGF0
YSwNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHNpemVvZigqZ2ljYykpOw0KPiA+PiAgICAgICAgICAgQVJNQ1BVICphcm1j
cHUgPSBBUk1fQ1BVKHFlbXVfZ2V0X2NwdShpKSk7DQo+ID4+DQo+ID4+ICsgICAgICAgIC8qDQo+
ID4+ICsgICAgICAgICAqIFBNVSBzaG91bGQgaGF2ZSBiZWVuIGVpdGhlciBpbXBsZW1lbnRlZCBm
b3IgYWxsIENQVXMgb3Igbm90LA0KPiA+PiArICAgICAgICAgKiBzbyB3ZSBvbmx5IGdldCBpbmZv
cm1hdGlvbiBmcm9tIHRoZSBmaXJzdCBDUFUsIHdoaWNoIGNvdWxkDQo+ID4+ICsgICAgICAgICAq
IHJlcHJlc2VudCB0aGUgb3RoZXJzLg0KPiA+PiArICAgICAgICAgKi8NCj4gPj4gKyAgICAgICAg
aWYgKGkgPT0gMCkgew0KPiA+PiArICAgICAgICAgICAgcG11ID0gYXJtX2ZlYXR1cmUoJmFybWNw
dS0+ZW52LCBBUk1fRkVBVFVSRV9QTVUpOw0KPiA+PiArICAgICAgICB9DQo+ID4+ICsgICAgICAg
IGFzc2VydCghYXJtY3B1IHx8IGFybV9mZWF0dXJlKCZhcm1jcHUtPmVudiwgQVJNX0ZFQVRVUkVf
UE1VKSA9PQ0KPiBwbXUpOw0KPiA+PiArDQo+ID4+ICAgICAgICAgICBnaWNjLT50eXBlID0gQUNQ
SV9BUElDX0dFTkVSSUNfQ1BVX0lOVEVSRkFDRTsNCj4gPj4gICAgICAgICAgIGdpY2MtPmxlbmd0
aCA9IHNpemVvZigqZ2ljYyk7DQo+ID4+ICAgICAgICAgICBpZiAodm1zLT5naWNfdmVyc2lvbiA9
PSAyKSB7DQo+ID4+IEBAIC01MDQsMTEgKzUxNywxOSBAQCBidWlsZF9tYWR0KEdBcnJheSAqdGFi
bGVfZGF0YSwgQklPU0xpbmtlciAqbGlua2VyLA0KPiA+PiBWaXJ0TWFjaGluZVN0YXRlICp2bXMp
DQo+ID4+ICAgICAgICAgICAgICAgZ2ljYy0+Z2ljdl9iYXNlX2FkZHJlc3MgPQ0KPiA+PiBjcHVf
dG9fbGU2NChtZW1tYXBbVklSVF9HSUNfVkNQVV0uYmFzZSk7DQo+ID4+ICAgICAgICAgICB9DQo+
ID4+ICAgICAgICAgICBnaWNjLT5jcHVfaW50ZXJmYWNlX251bWJlciA9IGNwdV90b19sZTMyKGkp
Ow0KPiA+PiAtICAgICAgICBnaWNjLT5hcm1fbXBpZHIgPSBjcHVfdG9fbGU2NChhcm1jcHUtPm1w
X2FmZmluaXR5KTsNCj4gPj4gKyAgICAgICAgZ2ljYy0+YXJtX21waWRyID0gY3B1X3RvX2xlNjQo
cG9zc2libGVfY3B1cy0+Y3B1c1tpXS5hcmNoX2lkKTsNCj4gPj4gICAgICAgICAgIGdpY2MtPnVp
ZCA9IGNwdV90b19sZTMyKGkpOw0KPiA+PiAtICAgICAgICBnaWNjLT5mbGFncyA9IGNwdV90b19s
ZTMyKEFDUElfTUFEVF9HSUNDX0VOQUJMRUQpOw0KPiA+Pg0KPiA+PiAtICAgICAgICBpZiAoYXJt
X2ZlYXR1cmUoJmFybWNwdS0+ZW52LCBBUk1fRkVBVFVSRV9QTVUpKSB7DQo+ID4+ICsgICAgICAg
IC8qDQo+ID4+ICsgICAgICAgICAqIEFDUEkgc3BlYyBzYXlzIHRoYXQgTEFQSUMgZW50cnkgZm9y
IG5vbiBwcmVzZW50IENQVSBtYXkgYmUNCj4gPj4gKyAgICAgICAgICogb21pdHRlZCBmcm9tIE1B
RFQgb3IgaXQgbXVzdCBiZSBtYXJrZWQgYXMgZGlzYWJsZWQuIEhlcmUgd2UNCj4gPj4gKyAgICAg
ICAgICogY2hvb3NlIHRvIGFsc28ga2VlcCB0aGUgZGlzYWJsZWQgb25lcyBpbiBNQURULg0KPiA+
PiArICAgICAgICAgKi8NCj4gPj4gKyAgICAgICAgaWYgKHBvc3NpYmxlX2NwdXMtPmNwdXNbaV0u
Y3B1ICE9IE5VTEwpIHsNCj4gPj4gKyAgICAgICAgICAgIGdpY2MtPmZsYWdzID0gY3B1X3RvX2xl
MzIoQUNQSV9NQURUX0dJQ0NfRU5BQkxFRCk7DQo+ID4+ICsgICAgICAgIH0NCj4gPj4gKw0KPiA+
PiArICAgICAgICBpZiAocG11KSB7DQo+ID4+ICAgICAgICAgICAgICAgZ2ljYy0+cGVyZm9ybWFu
Y2VfaW50ZXJydXB0ID0NCj4gY3B1X3RvX2xlMzIoUFBJKFZJUlRVQUxfUE1VX0lSUSkpOw0KPiA+
PiAgICAgICAgICAgfQ0KPiA+PiAgICAgICAgICAgaWYgKHZtcy0+dmlydCkgew0KPiA+PiAtLQ0K
PiA+PiAyLjE5LjENCj4gPj4NCj4gPiAuDQo=
