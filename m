Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CF83872D1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 09:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346931AbhERHGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 03:06:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3005 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245249AbhERHGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 03:06:15 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fkn3V4MmwzQpKQ;
        Tue, 18 May 2021 15:01:26 +0800 (CST)
Received: from dggema721-chm.china.huawei.com (10.3.20.85) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 15:04:55 +0800
Received: from lhreml703-chm.china.huawei.com (10.201.108.52) by
 dggema721-chm.china.huawei.com (10.3.20.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 18 May 2021 15:04:54 +0800
Received: from lhreml703-chm.china.huawei.com ([10.201.68.198]) by
 lhreml703-chm.china.huawei.com ([10.201.68.198]) with mapi id 15.01.2176.012;
 Tue, 18 May 2021 08:04:52 +0100
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
Subject: RE: [RFC PATCH v3 4/9] hw/arm/virt: Initialize the present cpu
 members
Thread-Topic: [RFC PATCH v3 4/9] hw/arm/virt: Initialize the present cpu
 members
Thread-Index: AQHXSj7Bs+01wvGUNEWbtmBiG2lmC6rn8VxQgACpzgCAADVmEA==
Date:   Tue, 18 May 2021 07:04:51 +0000
Message-ID: <6d8b9142e8a34d1390f2f0b4bfb53a00@huawei.com>
References: <20210516102900.28036-1-wangyanan55@huawei.com>
 <20210516102900.28036-5-wangyanan55@huawei.com>
 <6c8f9c3502384f648f30c7381e87dda9@huawei.com>
 <68883a1b-5303-da13-a051-e909e1d1f71b@huawei.com>
In-Reply-To: <68883a1b-5303-da13-a051-e909e1d1f71b@huawei.com>
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

PiBGcm9tOiB3YW5neWFuYW4gKFkpDQo+IFNlbnQ6IFR1ZXNkYXksIE1heSAxOCwgMjAyMSA1OjQz
IEFNDQo+IA0KPiBIaSBTYWxpbCwNCj4gDQo+IE9uIDIwMjEvNS8xOCA0OjQ4LCBTYWxpbCBNZWh0
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
MyA0LzldIGh3L2FybS92aXJ0OiBJbml0aWFsaXplIHRoZSBwcmVzZW50IGNwdSBtZW1iZXJzDQo+
ID4+DQo+ID4+IFdlIGNyZWF0ZSBhbmQgaW5pdGlhbGl6ZSBhIGNwdW9iaiBmb3IgZWFjaCBwcmVz
ZW50IGNwdSBpbg0KPiA+PiBtYWNodmlydF9pbml0KCkuIE5vdyB3ZSBhbHNvIGluaXRpYWxpemUg
dGhlIGNwdSBtZW1iZXIgb2YNCj4gPj4gc3RydWN0dXJlIENQVUFyY2hJZCBmb3IgZWFjaCBwcmVz
ZW50IGNwdSBpbiB0aGUgZnVuY3Rpb24uDQo+ID4gWy4uLl0NCj4gPg0KPiA+PiAgICAgICAgICAg
cWRldl9yZWFsaXplKERFVklDRShjcHVvYmopLCBOVUxMLCAmZXJyb3JfZmF0YWwpOw0KPiA+PiAr
DQo+ID4+ICsgICAgICAgIC8qDQo+ID4+ICsgICAgICAgICAqIEFzIEFSTSBjcHUgaG90cGx1ZyBp
cyBub3Qgc3VwcG9ydGVkIHlldCwgd2UgaW5pdGlhbGl6ZQ0KPiA+PiArICAgICAgICAgKiB0aGUg
cHJlc2VudCBjcHUgbWVtYmVycyBoZXJlLg0KPiA+PiArICAgICAgICAgKi8NCj4gPj4gKyAgICAg
ICAgbWFjaGluZS0+cG9zc2libGVfY3B1cy0+Y3B1c1tuXS5jcHUgPSBjcHVvYmo7DQo+ID4NCj4g
PiB3aGVuIHZjcHUgSG90cGx1ZyBpcyBub3Qgc3VwcG9ydGVkIHlldCwgd2hhdCBuZWNlc3NpdGF0
ZXMgdGhpcyBjaGFuZ2Ugbm93Pw0KPiA+DQo+IFRoZSBpbml0aWFsaXphdGlvbiB3aWxsIGdpdmVz
IGEgd2F5IHRvIGRldGVybWluZSB3aGV0aGVyIGEgQ1BVIGlzDQo+IHByZXNlbnQgb3Igbm90Lg0K
PiBBdCBsZWFzdCwgZm9yIG5vdyBpdCB3aWxsIGJlIHVzZWQgd2hlbiBnZW5lcmF0aW5nIEFDUEkg
dGFibGVzLCBlLmcuDQo+IERTRFQsIE1BRFQuDQo+IFNlZSBwYXRjaCA1IGFuZCA2Lg0KDQp5ZXMs
ICBidXQgd2h5IGRvIHlvdSByZXF1aXJlIGl0IG5vdyBhcyBwYXJ0IG9mIHRoZSB2Y3B1IHRvcG9s
b2d5IGNoYW5nZT8NCg0KQXMtZmFyLWFzLWktY2FuLXNlZSwgUFBUVCB0YWJsZSBjaGFuZ2VzKHBh
cnQgb2YgcGF0Y2ggNS85KSBkbyBub3QgcmVxdWlyZQ0KdGhpcyBjaGFuZ2UuIENoYW5nZSBpbiBQ
YXRjaCA1LzkgaGFzIGFsc28gYmVlbiBkb25lIGluIGFudGljaXBhdGlvbiBvZg0Kc29tZSBmdXR1
cmUgcmVxdWlyZW1lbnQodmNwdSBIb3RwbHVnPykuDQoNClBsZWFzZSBjb3JyZWN0IG1lIGhlcmUg
aWYgSSBhbSB3cm9uZz8NCg0KVGhhbmtzDQoNCg==
