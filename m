Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B453637FB03
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 17:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbhEMPuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 11:50:46 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5107 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhEMPum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 11:50:42 -0400
Received: from dggeml751-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FgwyC2PrszYhLW;
        Thu, 13 May 2021 23:46:59 +0800 (CST)
Received: from dggemi712-chm.china.huawei.com (10.3.20.111) by
 dggeml751-chm.china.huawei.com (10.1.199.150) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 13 May 2021 23:49:28 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggemi712-chm.china.huawei.com (10.3.20.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 13 May 2021 23:49:27 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2176.012; Thu, 13 May 2021 16:49:25 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        liulongfang <liulongfang@huawei.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: RE: [Linuxarm]  Re: [RFC PATCH 2/3] vfio/hisilicon: register the
 driver to vfio
Thread-Topic: [Linuxarm]  Re: [RFC PATCH 2/3] vfio/hisilicon: register the
 driver to vfio
Thread-Index: AQHXMkL9mza0TJ8TfUm11z5ygPSvFqq7zAN3gAL2j3WAAIzL6IAgnBJYgAGsWYGAACE9wA==
Date:   Thu, 13 May 2021 15:49:25 +0000
Message-ID: <e3db0c328da6411ea2ae07595ed5f6c3@huawei.com>
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
In-Reply-To: <20210513134422.GD1002214@nvidia.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gR3VudGhvcnBl
IFttYWlsdG86amdnQG52aWRpYS5jb21dDQo+IFNlbnQ6IDEzIE1heSAyMDIxIDE0OjQ0DQo+IFRv
OiBsaXVsb25nZmFuZyA8bGl1bG9uZ2ZhbmdAaHVhd2VpLmNvbT4NCj4gQ2M6IEFsZXggV2lsbGlh
bXNvbiA8YWxleC53aWxsaWFtc29uQHJlZGhhdC5jb20+OyBjb2h1Y2tAcmVkaGF0LmNvbTsNCj4g
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXhhcm1Ab3BlbmV1bGVyLm9yZw0KPiBT
dWJqZWN0OiBbTGludXhhcm1dIFJlOiBbUkZDIFBBVENIIDIvM10gdmZpby9oaXNpbGljb246IHJl
Z2lzdGVyIHRoZSBkcml2ZXIgdG8NCj4gdmZpbw0KPiANCj4gT24gVGh1LCBNYXkgMTMsIDIwMjEg
YXQgMTA6MDg6MjhBTSArMDgwMCwgbGl1bG9uZ2Zhbmcgd3JvdGU6DQo+ID4gT24gMjAyMS81LzEy
IDIwOjEwLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4gPiBPbiBXZWQsIE1heSAxMiwgMjAy
MSBhdCAwNDozOTo0M1BNICswODAwLCBsaXVsb25nZmFuZyB3cm90ZToNCj4gPiA+DQo+ID4gPj4g
VGhlcmVmb3JlLCB0aGlzIG1ldGhvZCBvZiBsaW1pdGluZyB0aGUgbGVuZ3RoIG9mIHRoZSBCQVIN
Cj4gPiA+PiBjb25maWd1cmF0aW9uIHNwYWNlIGNhbiBwcmV2ZW50IHVuc2FmZSBvcGVyYXRpb25z
IG9mIHRoZSBtZW1vcnkuDQo+ID4gPg0KPiA+ID4gVGhlIGlzc3VlIGlzIERNQSBjb250cm9sbGVk
IGJ5IHRoZSBndWVzdCBhY2Nlc3NpbmcgdGhlIHNlY3VyZSBCQVINCj4gPiA+IGFyZWEsIG5vdCB0
aGUgZ3Vlc3QgQ1BVLg0KPiA+ID4NCj4gPiA+IEphc29uDQo+ID4gPiAuDQo+ID4gPg0KPiA+IFRo
aXMgc2VjdXJlIEJBUiBhcmVhIGlzIG5vdCBwcmVzZW50ZWQgdG8gdGhlIEd1ZXN0LA0KPiA+IHdo
aWNoIG1ha2VzIGl0IGltcG9zc2libGUgZm9yIHRoZSBHdWVzdCB0byBvYnRhaW4gdGhlIHNlY3Vy
ZSBCQVIgYXJlYQ0KPiA+IHdoZW4gZXN0YWJsaXNoaW5nIHRoZSBETUEgbWFwcGluZyBvZiB0aGUg
Y29uZmlndXJhdGlvbiBzcGFjZS4NCj4gPiBJZiB0aGUgRE1BIGNvbnRyb2xsZXIgYWNjZXNzZXMg
dGhlIHNlY3VyZSBCQVIgYXJlYSwgdGhlIGFjY2VzcyB3aWxsDQo+ID4gYmUgYmxvY2tlZCBieSB0
aGUgU01NVS4NCj4gDQo+IFRoZXJlIGFyZSBzY2VuYXJpb3Mgd2hlcmUgdGhpcyBpcyBub3QgdHJ1
ZS4NCj4gDQo+IEF0IGEgbWluaW11bSB0aGUgbWRldiBkcml2ZXIgc2hvdWxkIHJlZnVzZSB0byB3
b3JrIGluIHRob3NlIGNhc2VzLg0KPiANCg0KSGksDQoNCkkgdGhpbmsgdGhlIGlkZWEgaGVyZSBp
cyBub3QgYSBnZW5lcmljIHNvbHV0aW9uLCBidXQgYSBxdWlyayBmb3IgdGhpcyBzcGVjaWZpYyBk
ZXYuDQoNClNvbWV0aGluZyBsaWtlLCANCg0KLS0tIGEvZHJpdmVycy92ZmlvL3BjaS92ZmlvX3Bj
aS5jDQorKysgYi9kcml2ZXJzL3ZmaW8vcGNpL3ZmaW9fcGNpLmMNCkBAIC04NjYsNyArODY2LDEy
IEBAIHN0YXRpYyBsb25nIHZmaW9fcGNpX2lvY3RsKHN0cnVjdCB2ZmlvX2RldmljZSAqY29yZV92
ZGV2LA0KICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQogICAgICAgICAgICAgICAgY2Fz
ZSBWRklPX1BDSV9CQVIwX1JFR0lPTl9JTkRFWCAuLi4gVkZJT19QQ0lfQkFSNV9SRUdJT05fSU5E
RVg6DQogICAgICAgICAgICAgICAgICAgICAgICBpbmZvLm9mZnNldCA9IFZGSU9fUENJX0lOREVY
X1RPX09GRlNFVChpbmZvLmluZGV4KTsNCi0gICAgICAgICAgICAgICAgICAgICAgIGluZm8uc2l6
ZSA9IHBjaV9yZXNvdXJjZV9sZW4ocGRldiwgaW5mby5pbmRleCk7DQorDQorICAgICAgICAgICAg
ICAgICAgICAgICBpZiAoY2hlY2tfaGlzaV9hY2NfcXVpcmsocGRldiwgaW5mbykpDQorICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGluZm8uc2l6ZSA9IG5ld19zaXplOy8vIEJBUiBpcyBs
aW1pdGVkIHdpdGhvdXQgbWlncmF0aW9uIHJlZ2lvbi4NCisgICAgICAgICAgICAgICAgICAgICAg
IGVsc2UNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW5mby5zaXplID0gcGNpX3Jl
c291cmNlX2xlbihwZGV2LCBpbmZvLmluZGV4KTsNCisNCiAgICAgICAgICAgICAgICAgICAgICAg
IGlmICghaW5mby5zaXplKSB7DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGluZm8u
ZmxhZ3MgPSAwOw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCg0KSXMg
dGhpcyBhbiBhY2NlcHRhYmxlL3dvcmthYmxlIHNvbHV0aW9uIGhlcmU/DQoNClRoYW5rcywNClNo
YW1lZXINCg==
