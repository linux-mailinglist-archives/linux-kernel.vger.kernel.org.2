Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33353400C1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhCRIUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:20:35 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3309 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhCRIUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:20:17 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4F1Kcw0cmqz1455X;
        Thu, 18 Mar 2021 16:17:04 +0800 (CST)
Received: from dggpemm100010.china.huawei.com (7.185.36.24) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 18 Mar 2021 16:20:06 +0800
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggpemm100010.china.huawei.com (7.185.36.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Mar 2021 16:20:06 +0800
Received: from dggpeml500016.china.huawei.com ([7.185.36.70]) by
 dggpeml500016.china.huawei.com ([7.185.36.70]) with mapi id 15.01.2106.013;
 Thu, 18 Mar 2021 16:20:06 +0800
From:   "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
To:     Nadav Amit <nadav.amit@gmail.com>
CC:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        chenjiashang <chenjiashang@huawei.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?UkU6IEEgcHJvYmxlbSBvZiBJbnRlbCBJT01NVSBoYXJkd2FyZSDvvJ8=?=
Thread-Topic: =?utf-8?B?QSBwcm9ibGVtIG9mIEludGVsIElPTU1VIGhhcmR3YXJlIO+8nw==?=
Thread-Index: AQHXGtwEduPlUZeCNUCbiy3s/+KwAaqHJckAgADDZTCAAA0+AIABZ4Ng
Date:   Thu, 18 Mar 2021 08:20:06 +0000
Message-ID: <4d1c3bc0418e48b1b9d44799d65ea375@huawei.com>
References: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
 <FB4E11A5-84D4-4DAF-889E-FAA1BCD2E66F@gmail.com>
 <6a218e7fe42d41489d02f0b4e3ad2756@huawei.com>
 <98DB71EF-FF98-4509-85EC-26FF50825A58@gmail.com>
In-Reply-To: <98DB71EF-FF98-4509-85EC-26FF50825A58@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.151.207]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTmFkYXYsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFkYXYg
QW1pdCBbbWFpbHRvOm5hZGF2LmFtaXRAZ21haWwuY29tXQ0KPiBTZW50OiBUaHVyc2RheSwgTWFy
Y2ggMTgsIDIwMjEgMjoxMyBBTQ0KPiBUbzogTG9uZ3BlbmcgKE1pa2UsIENsb3VkIEluZnJhc3Ry
dWN0dXJlIFNlcnZpY2UgUHJvZHVjdCBEZXB0LikNCj4gPGxvbmdwZW5nMkBodWF3ZWkuY29tPg0K
PiBDYzogRGF2aWQgV29vZGhvdXNlIDxkd213MkBpbmZyYWRlYWQub3JnPjsgTHUgQmFvbHUNCj4g
PGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT47IEpvZXJnIFJvZWRlbCA8am9yb0A4Ynl0ZXMub3Jn
Pjsgd2lsbEBrZXJuZWwub3JnOw0KPiBhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbTsgY2hlbmpp
YXNoYW5nIDxjaGVuamlhc2hhbmdAaHVhd2VpLmNvbT47DQo+IGlvbW11QGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnOyBHb25nbGVpIChBcmVpKSA8YXJlaS5nb25nbGVpQGh1YXdlaS5jb20+Ow0K
PiBMS01MIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogQSBw
cm9ibGVtIG9mIEludGVsIElPTU1VIGhhcmR3YXJlIO+8nw0KPiANCj4gDQo+IA0KPiA+IE9uIE1h
ciAxNywgMjAyMSwgYXQgMjozNSBBTSwgTG9uZ3BlbmcgKE1pa2UsIENsb3VkIEluZnJhc3RydWN0
dXJlIFNlcnZpY2UNCj4gUHJvZHVjdCBEZXB0LikgPGxvbmdwZW5nMkBodWF3ZWkuY29tPiB3cm90
ZToNCj4gPg0KPiA+IEhpIE5hZGF2LA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4+IEZyb206IE5hZGF2IEFtaXQgW21haWx0bzpuYWRhdi5hbWl0QGdtYWlsLmNvbV0N
Cj4gPj4+ICByZXByb2R1Y2UgdGhlIHByb2JsZW0gd2l0aCBoaWdoIHByb2JhYmlsaXR5ICh+NTAl
KS4NCj4gPj4NCj4gPj4gSSBzYXcgTHUgcmVwbGllZCwgYW5kIGhlIGlzIG11Y2ggbW9yZSBrbm93
bGVkZ2FibGUgdGhhbiBJIGFtIChJIHdhcw0KPiA+PiBqdXN0IGludHJpZ3VlZCBieSB5b3VyIGVt
YWlsKS4NCj4gPj4NCj4gPj4gSG93ZXZlciwgaWYgSSB3ZXJlIHlvdSBJIHdvdWxkIHRyeSBhbHNv
IHRvIHJlbW92ZSBzb21lDQo+ID4+IOKAnG9wdGltaXphdGlvbnPigJ0gdG8gbG9vayBmb3IgdGhl
IHJvb3QtY2F1c2UgKGUuZy4sIHVzZSBkb21haW4gc3BlY2lmaWMNCj4gaW52YWxpZGF0aW9ucyBp
bnN0ZWFkIG9mIHBhZ2Utc3BlY2lmaWMpLg0KPiA+Pg0KPiA+DQo+ID4gR29vZCBzdWdnZXN0aW9u
ISBCdXQgd2UgZGlkIGl0IHRoZXNlIGRheXMsIHdlIHRyaWVkIHRvIHVzZSBnbG9iYWwgaW52YWxp
ZGF0aW9ucyBhcw0KPiBmb2xsb3c6DQo+ID4gCQlpb21tdS0+Zmx1c2guZmx1c2hfaW90bGIoaW9t
bXUsIGRpZCwgMCwgMCwNCj4gPiAJCQkJCQlETUFfVExCX0RTSV9GTFVTSCk7DQo+ID4gQnV0IGNh
biBub3QgcmVzb2x2ZSB0aGUgcHJvYmxlbS4NCj4gPg0KPiA+PiBUaGUgZmlyc3QgdGhpbmcgdGhh
dCBjb21lcyB0byBteSBtaW5kIGlzIHRoZSBpbnZhbGlkYXRpb24gaGludCAoaWgpDQo+ID4+IGlu
IGlvbW11X2ZsdXNoX2lvdGxiX3BzaSgpLiBJIHdvdWxkIHJlbW92ZSBpdCB0byBzZWUgd2hldGhl
ciB5b3UgZ2V0DQo+ID4+IHRoZSBmYWlsdXJlIHdpdGhvdXQgaXQuDQo+ID4NCj4gPiBXZSBhbHNv
IG5vdGljZSB0aGUgSUgsIGJ1dCB0aGUgSUggaXMgYWx3YXlzIFpFUk8gaW4gb3VyIGNhc2UsIGFz
IHRoZSBzcGVjIHNheXM6DQo+ID4gJycnDQo+ID4gUGFnaW5nLXN0cnVjdHVyZS1jYWNoZSBlbnRy
aWVzIGNhY2hpbmcgc2Vjb25kLWxldmVsIG1hcHBpbmdzDQo+ID4gYXNzb2NpYXRlZCB3aXRoIHRo
ZSBzcGVjaWZpZWQgZG9tYWluLWlkIGFuZCB0aGUNCj4gPiBzZWNvbmQtbGV2ZWwtaW5wdXQtYWRk
cmVzcyByYW5nZSBhcmUgaW52YWxpZGF0ZWQsIGlmIHRoZSBJbnZhbGlkYXRpb24NCj4gPiBIaW50
DQo+ID4gKElIKSBmaWVsZCBpcyBDbGVhci4NCj4gPiAnJycNCj4gPg0KPiA+IEl0IHNlZW1zIHRo
ZSBzb2Z0d2FyZSBpcyBldmVyeXRoaW5nIGZpbmUsIHNvIHdlJ3ZlIG5vIGNob2ljZSBidXQgdG8g
c3VzcGVjdCB0aGUNCj4gaGFyZHdhcmUuDQo+IA0KPiBPaywgSSBhbSBwcmV0dHkgbXVjaCBvdXQg
b2YgaWRlYXMuIEkgaGF2ZSB0d28gbW9yZSBzdWdnZXN0aW9ucywgYnV0IHRoZXkgYXJlIG11Y2gN
Cj4gbGVzcyBsaWtlbHkgdG8gaGVscC4gWWV0LCB0aGV5IGNhbiBmdXJ0aGVyIGhlbHAgdG8gcnVs
ZSBvdXQgc29mdHdhcmUgYnVnczoNCj4gDQo+IDEuIGRtYV9jbGVhcl9wdGUoKSBzZWVtcyB0byBi
ZSB3cm9uZyBJTUhPLiBJdCBzaG91bGQgaGF2ZSB1c2VkIFdSSVRFX09OQ0UoKQ0KPiB0byBwcmV2
ZW50IHNwbGl0LXdyaXRlLCB3aGljaCBtaWdodCBwb3RlbnRpYWxseSBjYXVzZSDigJxpbnZhbGlk
4oCdIChwYXJ0aWFsbHkNCj4gY2xlYXJlZCkgUFRFIHRvIGJlIHN0b3JlZCBpbiB0aGUgVExCLiBI
YXZpbmcgc2FpZCB0aGF0LCB0aGUgc3Vic2VxdWVudCBJT1RMQiBmbHVzaA0KPiBzaG91bGQgaGF2
ZSBwcmV2ZW50ZWQgdGhlIHByb2JsZW0uDQo+IA0KDQpZZXMsIHVzZSBXUklURV9PTkNFIGlzIG11
Y2ggc2FmZXIsIGhvd2V2ZXIgSSB3YXMganVzdCB0ZXN0aW5nIHRoZSBmb2xsb3dpbmcgY29kZSwN
Cml0IGRpZG4ndCByZXNvbHZlZCBteSBwcm9ibGVtLg0KDQpzdGF0aWMgaW5saW5lIHZvaWQgZG1h
X2NsZWFyX3B0ZShzdHJ1Y3QgZG1hX3B0ZSAqcHRlKQ0Kew0KICAgICAgICBXUklURV9PTkNFKHB0
ZS0+dmFsLCAwVUxMKTsNCn0NCg0KPiAyLiBDb25zaWRlciBlbnN1cmluZyB0aGF0IHRoZSBwcm9i
bGVtIGlzIG5vdCBzb21laG93IHJlbGF0ZWQgdG8gcXVldWVkDQo+IGludmFsaWRhdGlvbnMuIFRy
eSB0byB1c2UgX19pb21tdV9mbHVzaF9pb3RsYigpIGluc3RlYWQgb2YgcWlfZmx1c2hfaW90bGIo
KS4NCj4gDQoNCkkgdHJpZWQgdG8gZm9yY2UgdG8gdXNlIF9faW9tbXVfZmx1c2hfaW90bGIoKSwg
YnV0IG1heWJlIHNvbWV0aGluZyB3cm9uZywNCnRoZSBzeXN0ZW0gY3Jhc2hlZCwgc28gSSBwcmVm
ZXIgdG8gbG93ZXIgdGhlIHByaW9yaXR5IG9mIHRoaXMgb3BlcmF0aW9uLg0KDQo+IFJlZ2FyZHMs
DQo+IE5hZGF2DQo=
