Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE65437FCE0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 19:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhEMRyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 13:54:16 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5108 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbhEMRyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 13:54:12 -0400
Received: from dggeml765-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fgzhl1PtBzYhVL;
        Fri, 14 May 2021 01:50:31 +0800 (CST)
Received: from dggemi710-chm.china.huawei.com (10.3.20.109) by
 dggeml765-chm.china.huawei.com (10.1.199.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 14 May 2021 01:53:00 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggemi710-chm.china.huawei.com (10.3.20.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 14 May 2021 01:52:58 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2176.012; Thu, 13 May 2021 18:52:57 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        liulongfang <liulongfang@huawei.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: RE: [Linuxarm]  Re: [RFC PATCH 2/3] vfio/hisilicon: register the
 driver to vfio
Thread-Topic: [Linuxarm]  Re: [RFC PATCH 2/3] vfio/hisilicon: register the
 driver to vfio
Thread-Index: AQHXMkL9mza0TJ8TfUm11z5ygPSvFqq7zAN3gAL2j3WAAIzL6IAgnBJYgAGsWYGAACE9wIAABZSAgAAb/VA=
Date:   Thu, 13 May 2021 17:52:56 +0000
Message-ID: <1035a9a9b03b43dd9f859136ed84a7f8@huawei.com>
References: <10d53c5d-e6d5-a165-84b2-eaf8a3b7dcce@huawei.com>
        <20210419123314.GT1370958@nvidia.com>
        <00c4fa43-21fa-a48b-b95d-a2310ffab725@huawei.com>
        <20210420125957.GA1370958@nvidia.com>
        <20210420160457.6b91850a@x1.home.shazbot.org>
        <25d033e6-1cba-0da0-2ee7-03a14e75b8a5@huawei.com>
        <20210421121224.62382e5d@redhat.com>
        <6ea89655-31c5-233b-ca2a-fcc166b5597c@huawei.com>
        <20210512121053.GT1002214@nvidia.com>
        <3eaa3114-81b6-1bd9-c7e6-cb1541389b58@huawei.com>
        <20210513134422.GD1002214@nvidia.com>
        <e3db0c328da6411ea2ae07595ed5f6c3@huawei.com>
 <20210513110349.68e3d59d@redhat.com>
In-Reply-To: <20210513110349.68e3d59d@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.81.63]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxleCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4IFdp
bGxpYW1zb24gW21haWx0bzphbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbV0NCj4gU2VudDogMTMg
TWF5IDIwMjEgMTg6MDQNCj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgPHNoYW1lZXJh
bGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT4NCj4gQ2M6IEphc29uIEd1bnRob3JwZSA8amdn
QG52aWRpYS5jb20+OyBsaXVsb25nZmFuZw0KPiA8bGl1bG9uZ2ZhbmdAaHVhd2VpLmNvbT47IGNv
aHVja0ByZWRoYXQuY29tOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eGFy
bUBvcGVuZXVsZXIub3JnDQo+IFN1YmplY3Q6IFtMaW51eGFybV0gUmU6IFtSRkMgUEFUQ0ggMi8z
XSB2ZmlvL2hpc2lsaWNvbjogcmVnaXN0ZXIgdGhlIGRyaXZlciB0bw0KPiB2ZmlvDQo+IA0KPiBP
biBUaHUsIDEzIE1heSAyMDIxIDE1OjQ5OjI1ICswMDAwDQo+IFNoYW1lZXJhbGkgS29sb3RodW0g
VGhvZGkgPHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT4NCj4gd3JvdGU6DQo+
IA0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IEphc29uIEd1
bnRob3JwZSBbbWFpbHRvOmpnZ0BudmlkaWEuY29tXQ0KPiA+ID4gU2VudDogMTMgTWF5IDIwMjEg
MTQ6NDQNCj4gPiA+IFRvOiBsaXVsb25nZmFuZyA8bGl1bG9uZ2ZhbmdAaHVhd2VpLmNvbT4NCj4g
PiA+IENjOiBBbGV4IFdpbGxpYW1zb24gPGFsZXgud2lsbGlhbXNvbkByZWRoYXQuY29tPjsgY29o
dWNrQHJlZGhhdC5jb207DQo+ID4gPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51
eGFybUBvcGVuZXVsZXIub3JnDQo+ID4gPiBTdWJqZWN0OiBbTGludXhhcm1dIFJlOiBbUkZDIFBB
VENIIDIvM10gdmZpby9oaXNpbGljb246IHJlZ2lzdGVyIHRoZSBkcml2ZXIgdG8NCj4gPiA+IHZm
aW8NCj4gPiA+DQo+ID4gPiBPbiBUaHUsIE1heSAxMywgMjAyMSBhdCAxMDowODoyOEFNICswODAw
LCBsaXVsb25nZmFuZyB3cm90ZToNCj4gPiA+ID4gT24gMjAyMS81LzEyIDIwOjEwLCBKYXNvbiBH
dW50aG9ycGUgd3JvdGU6DQo+ID4gPiA+ID4gT24gV2VkLCBNYXkgMTIsIDIwMjEgYXQgMDQ6Mzk6
NDNQTSArMDgwMCwgbGl1bG9uZ2Zhbmcgd3JvdGU6DQo+ID4gPiA+ID4NCj4gPiA+ID4gPj4gVGhl
cmVmb3JlLCB0aGlzIG1ldGhvZCBvZiBsaW1pdGluZyB0aGUgbGVuZ3RoIG9mIHRoZSBCQVINCj4g
PiA+ID4gPj4gY29uZmlndXJhdGlvbiBzcGFjZSBjYW4gcHJldmVudCB1bnNhZmUgb3BlcmF0aW9u
cyBvZiB0aGUgbWVtb3J5Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhlIGlzc3VlIGlzIERNQSBj
b250cm9sbGVkIGJ5IHRoZSBndWVzdCBhY2Nlc3NpbmcgdGhlIHNlY3VyZSBCQVINCj4gPiA+ID4g
PiBhcmVhLCBub3QgdGhlIGd1ZXN0IENQVS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEphc29uDQo+
ID4gPiA+ID4gLg0KPiA+ID4gPiA+DQo+ID4gPiA+IFRoaXMgc2VjdXJlIEJBUiBhcmVhIGlzIG5v
dCBwcmVzZW50ZWQgdG8gdGhlIEd1ZXN0LA0KPiA+ID4gPiB3aGljaCBtYWtlcyBpdCBpbXBvc3Np
YmxlIGZvciB0aGUgR3Vlc3QgdG8gb2J0YWluIHRoZSBzZWN1cmUgQkFSIGFyZWENCj4gPiA+ID4g
d2hlbiBlc3RhYmxpc2hpbmcgdGhlIERNQSBtYXBwaW5nIG9mIHRoZSBjb25maWd1cmF0aW9uIHNw
YWNlLg0KPiA+ID4gPiBJZiB0aGUgRE1BIGNvbnRyb2xsZXIgYWNjZXNzZXMgdGhlIHNlY3VyZSBC
QVIgYXJlYSwgdGhlIGFjY2VzcyB3aWxsDQo+ID4gPiA+IGJlIGJsb2NrZWQgYnkgdGhlIFNNTVUu
DQo+ID4gPg0KPiA+ID4gVGhlcmUgYXJlIHNjZW5hcmlvcyB3aGVyZSB0aGlzIGlzIG5vdCB0cnVl
Lg0KPiA+ID4NCj4gPiA+IEF0IGEgbWluaW11bSB0aGUgbWRldiBkcml2ZXIgc2hvdWxkIHJlZnVz
ZSB0byB3b3JrIGluIHRob3NlIGNhc2VzLg0KPiA+ID4NCj4gPg0KPiA+IEhpLA0KPiA+DQo+ID4g
SSB0aGluayB0aGUgaWRlYSBoZXJlIGlzIG5vdCBhIGdlbmVyaWMgc29sdXRpb24sIGJ1dCBhIHF1
aXJrIGZvciB0aGlzIHNwZWNpZmljIGRldi4NCj4gPg0KPiA+IFNvbWV0aGluZyBsaWtlLA0KPiA+
DQo+ID4gLS0tIGEvZHJpdmVycy92ZmlvL3BjaS92ZmlvX3BjaS5jDQo+ID4gKysrIGIvZHJpdmVy
cy92ZmlvL3BjaS92ZmlvX3BjaS5jDQo+ID4gQEAgLTg2Niw3ICs4NjYsMTIgQEAgc3RhdGljIGxv
bmcgdmZpb19wY2lfaW9jdGwoc3RydWN0IHZmaW9fZGV2aWNlDQo+ICpjb3JlX3ZkZXYsDQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gICAgICAgICAgICAgICAgIGNhc2Ug
VkZJT19QQ0lfQkFSMF9SRUdJT05fSU5ERVggLi4uDQo+IFZGSU9fUENJX0JBUjVfUkVHSU9OX0lO
REVYOg0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGluZm8ub2Zmc2V0ID0NCj4gVkZJT19Q
Q0lfSU5ERVhfVE9fT0ZGU0VUKGluZm8uaW5kZXgpOw0KPiA+IC0gICAgICAgICAgICAgICAgICAg
ICAgIGluZm8uc2l6ZSA9IHBjaV9yZXNvdXJjZV9sZW4ocGRldiwgaW5mby5pbmRleCk7DQo+ID4g
Kw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIChjaGVja19oaXNpX2FjY19xdWlyayhw
ZGV2LCBpbmZvKSkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGluZm8uc2l6
ZSA9IG5ld19zaXplOy8vIEJBUiBpcyBsaW1pdGVkDQo+IHdpdGhvdXQgbWlncmF0aW9uIHJlZ2lv
bi4NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBlbHNlDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBpbmZvLnNpemUgPSBwY2lfcmVzb3VyY2VfbGVuKHBkZXYsDQo+IGlu
Zm8uaW5kZXgpOw0KPiA+ICsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoIWluZm8u
c2l6ZSkgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW5mby5mbGFncyA9
IDA7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPg0KPiA+
IElzIHRoaXMgYW4gYWNjZXB0YWJsZS93b3JrYWJsZSBzb2x1dGlvbiBoZXJlPw0KPiANCj4gQXMg
SmFzb24gc2F5cywgdGhpcyBvbmx5IHJlc3RyaWN0cyBDUFUgYWNjZXNzIHRvIHRoZSBCQVIsIHRo
ZSBpc3N1ZSBpcw0KPiBETUEgYWNjZXNzLiAgQXMgdGhlIGhhcmR3YXJlIHZlbmRvciB5b3UgbWF5
IGJlIGFibGUgdG8gZ3VhcmFudGVlIHRoYXQNCj4gYSBETUEgdHJhbnNhY3Rpb24gZ2VuZXJhdGVk
IGJ5IHRoZSBkZXZpY2UgdGFyZ2V0aW5nIHRoZSByZW1haW5kZXIgb2YNCj4gdGhlIEJBUiB3aWxs
IGFsd2F5cyBnbyB1cHN0cmVhbSwgYnV0IGNhbiB5b3UgZ3VhcmFudGVlIHRoZSByb3V0aW5nDQo+
IGJldHdlZW4gdGhlIGRldmljZSBhbmQgdGhlIFNNTVU/ICBGb3IgaW5zdGFuY2UgaWYgdGhpcyBk
ZXZpY2UgY2FuIGJlDQo+IGltcGxlbWVudGVkIGFzIGEgcGx1Z2luIGNhcmQsIHRoZW4gaXQgY2Fu
IGJlIGluc3RhbGxlZCBpbnRvIGENCj4gZG93bnN0cmVhbSBwb3J0IHRoYXQgbWF5IG5vdCBzdXBw
b3J0IEFDUy4gIFRoYXQgZG93bnN0cmVhbSBwb3J0IG1heQ0KPiBpbXBsZW1lbnQgcmVxdWVzdCBy
ZWRpcmVjdGlvbiBhbGxvd2luZyB0aGUgdHJhbnNhY3Rpb24gdG8gcmVmbGVjdCBiYWNrDQo+IHRv
IHRoZSBkZXZpY2Ugd2l0aG91dCBJT01NVSB0cmFuc2xhdGlvbi4gIEF0IHRoYXQgcG9pbnQgdGhl
IHVzZXJzcGFjZQ0KPiBkcml2ZXIgY2FuIHRhcmdldCB0aGUga2VybmVsIGRyaXZlciBoYWxmIG9m
IHRoZSBCQVIgYW5kIHBvdGVudGlhbGx5DQo+IGV4cG9zZSBhIHNlY3VyaXR5IHJpc2suICBUaGFu
a3MsDQoNClRoZSBBQ0MgZGV2aWNlcyBvbiB0aGlzIHBsYXRmb3JtIGFyZSBub3QgcGx1Z2dhYmxl
IGRldmljZXMuIFRoZXkgYXJlIGV4cG9zZWQNCmFzIGludGVncmF0ZWQgZW5kcG9pbnQgZGV2aWNl
cy4gU28gSSBhbSBub3Qgc3VyZSB0aGUgYWJvdmUgY29uY2VybiBpcyB2YWxpZCBpbiB0aGlzDQpj
YXNlLg0KDQpJIGhhZCBhIGxvb2sgYXQgdGhlIHVzZXJzcGFjZSBkcml2ZXIgYXBwcm9hY2ggeW91
IHN1Z2dlc3RlZC4gQnV0IHVuZm9ydHVuYXRlbHkNCnRoZSBtaWdyYXRpb24gc3RhdGUgY2hhbmdl
IGZvciB0aGUgdmYgaGFzIHRvIGNoZWNrIHNvbWUgb2YgdGhlIHBmIHJlZ2lzdGVycyBmb3INCmNv
bmZpcm1pbmcgdGhlIHN0YXRlLiBTbyBldmVuIGlmIHdlIG1vdmUgdGhlIGltcGxlbWVudGF0aW9u
IHRvIFFlbXUsIHdlDQpzdGlsbCBtYXkgaGF2ZSB0byB1c2UgdGhlIG1pZ3JhdGlvbiB1QVBJIHRv
IGFjY2VzcyB0aGUgcGYgZGV2aWNlIHJlZ2lzdGVycy4NCg0KU2luY2UgdGhlIGRldmljZXMgd2Ug
YXJlIGNvbmNlcm5lZCBoZXJlIGFyZSBhbGwgaW50ZWdyYXRlZCBlbmRwb2ludHMgYW5kIGlmIHRo
ZSANCmFib3ZlIHF1aXJrIGlzIGFuIGFjY2VwdGFibGUgb25lLCB0aGVuIHdlIGNhbiB1c2UgdGhl
IHVBUEkgYXMgZG9uZSBpbiB0aGlzDQpzZXJpZXMgd2l0aG91dCBvdmVybHkgY29tcGxpY2F0aW5n
IHRoaW5ncyBoZXJlLg0KDQpQbGVhc2UgbGV0IG1lIGtub3cgeW91ciB0aG91Z2h0cywNCg0KVGhh
bmtzLA0KU2hhbWVlcg0KDQoNCg0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXw0KPiBMaW51eGFybSBtYWlsaW5nIGxpc3QgLS0gbGludXhhcm1Ab3BlbmV1
bGVyLm9yZw0KPiBUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4YXJtLWxlYXZl
QG9wZW5ldWxlci5vcmcNCg==
