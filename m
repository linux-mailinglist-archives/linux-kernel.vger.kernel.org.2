Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832A0340118
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhCRIjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:39:35 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3368 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhCRIjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:39:02 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4F1L3Q0FVSz5dW4;
        Thu, 18 Mar 2021 16:36:34 +0800 (CST)
Received: from dggpemm500011.china.huawei.com (7.185.36.110) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 18 Mar 2021 16:38:58 +0800
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggpemm500011.china.huawei.com (7.185.36.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Mar 2021 16:38:58 +0800
Received: from dggpeml500016.china.huawei.com ([7.185.36.70]) by
 dggpeml500016.china.huawei.com ([7.185.36.70]) with mapi id 15.01.2106.013;
 Thu, 18 Mar 2021 16:38:58 +0800
From:   "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>
CC:     chenjiashang <chenjiashang@huawei.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        "will@kernel.org" <will@kernel.org>
Subject: =?utf-8?B?UkU6IEEgcHJvYmxlbSBvZiBJbnRlbCBJT01NVSBoYXJkd2FyZSDvvJ8=?=
Thread-Topic: =?utf-8?B?QSBwcm9ibGVtIG9mIEludGVsIElPTU1VIGhhcmR3YXJlIO+8nw==?=
Thread-Index: AQHXGtwEduPlUZeCNUCbiy3s/+KwAaqHJckAgADDZTCAAA0+AIABZ4Ng//+HOQCAAIduIA==
Date:   Thu, 18 Mar 2021 08:38:58 +0000
Message-ID: <d7bb4ab26b8542c698926b7a0a3fc12c@huawei.com>
References: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
 <FB4E11A5-84D4-4DAF-889E-FAA1BCD2E66F@gmail.com>
 <6a218e7fe42d41489d02f0b4e3ad2756@huawei.com>
 <98DB71EF-FF98-4509-85EC-26FF50825A58@gmail.com>
 <4d1c3bc0418e48b1b9d44799d65ea375@huawei.com>
 <MWHPR11MB18860801196A9319EBD96AF68C699@MWHPR11MB1886.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB18860801196A9319EBD96AF68C699@MWHPR11MB1886.namprd11.prod.outlook.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGlhbiwgS2V2aW4gW21h
aWx0bzprZXZpbi50aWFuQGludGVsLmNvbV0NCj4gU2VudDogVGh1cnNkYXksIE1hcmNoIDE4LCAy
MDIxIDQ6MjcgUE0NCj4gVG86IExvbmdwZW5nIChNaWtlLCBDbG91ZCBJbmZyYXN0cnVjdHVyZSBT
ZXJ2aWNlIFByb2R1Y3QgRGVwdC4pDQo+IDxsb25ncGVuZzJAaHVhd2VpLmNvbT47IE5hZGF2IEFt
aXQgPG5hZGF2LmFtaXRAZ21haWwuY29tPg0KPiBDYzogY2hlbmppYXNoYW5nIDxjaGVuamlhc2hh
bmdAaHVhd2VpLmNvbT47IERhdmlkIFdvb2Rob3VzZQ0KPiA8ZHdtdzJAaW5mcmFkZWFkLm9yZz47
IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBMS01MDQo+IDxsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnPjsgYWxleC53aWxsaWFtc29uQHJlZGhhdC5jb207IEdvbmdsZWkgKEFy
ZWkpDQo+IDxhcmVpLmdvbmdsZWlAaHVhd2VpLmNvbT47IHdpbGxAa2VybmVsLm9yZw0KPiBTdWJq
ZWN0OiBSRTogQSBwcm9ibGVtIG9mIEludGVsIElPTU1VIGhhcmR3YXJlIO+8nw0KPiANCj4gPiBG
cm9tOiBpb21tdSA8aW9tbXUtYm91bmNlc0BsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZz4gT24g
QmVoYWxmIE9mDQo+ID4gTG9uZ3BlbmcgKE1pa2UsIENsb3VkIEluZnJhc3RydWN0dXJlIFNlcnZp
Y2UgUHJvZHVjdCBEZXB0LikNCj4gPg0KPiA+ID4gMi4gQ29uc2lkZXIgZW5zdXJpbmcgdGhhdCB0
aGUgcHJvYmxlbSBpcyBub3Qgc29tZWhvdyByZWxhdGVkIHRvDQo+ID4gPiBxdWV1ZWQgaW52YWxp
ZGF0aW9ucy4gVHJ5IHRvIHVzZSBfX2lvbW11X2ZsdXNoX2lvdGxiKCkgaW5zdGVhZCBvZg0KPiBx
aV9mbHVzaF9pb3RsYigpLg0KPiA+ID4NCj4gPg0KPiA+IEkgdHJpZWQgdG8gZm9yY2UgdG8gdXNl
IF9faW9tbXVfZmx1c2hfaW90bGIoKSwgYnV0IG1heWJlIHNvbWV0aGluZw0KPiA+IHdyb25nLCB0
aGUgc3lzdGVtIGNyYXNoZWQsIHNvIEkgcHJlZmVyIHRvIGxvd2VyIHRoZSBwcmlvcml0eSBvZiB0
aGlzIG9wZXJhdGlvbi4NCj4gPg0KPiANCj4gVGhlIFZULWQgc3BlYyBjbGVhcmx5IHNheXMgdGhh
dCByZWdpc3Rlci1iYXNlZCBpbnZhbGlkYXRpb24gY2FuIGJlIHVzZWQgb25seSB3aGVuDQo+IHF1
ZXVlZC1pbnZhbGlkYXRpb25zIGFyZSBub3QgZW5hYmxlZC4gSW50ZWwtSU9NTVUgZHJpdmVyIGRv
ZXNuJ3QgcHJvdmlkZSBhbg0KPiBvcHRpb24gdG8gZGlzYWJsZSBxdWV1ZWQtaW52YWxpZGF0aW9u
IHRob3VnaCwgd2hlbiB0aGUgaGFyZHdhcmUgaXMgY2FwYWJsZS4gSWYgeW91DQo+IHJlYWxseSB3
YW50IHRvIHRyeSwgdHdlYWsgdGhlIGNvZGUgaW4gaW50ZWxfaW9tbXVfaW5pdF9xaS4NCj4gDQoN
CkhpIEtldmluLA0KDQpUaGFua3MgdG8gcG9pbnQgb3V0IHRoaXMuIERvIHlvdSBoYXZlIGFueSBp
ZGVhcyBhYm91dCB0aGlzIHByb2JsZW0gPyBJIHRyaWVkDQp0byBkZXNjcmlwdCB0aGUgcHJvYmxl
bSBtdWNoIGNsZWFyIGluIG15IHJlcGx5IHRvIEFsZXgsIGhvcGUgeW91IGNvdWxkIGhhdmUNCmEg
bG9vayBpZiB5b3UncmUgaW50ZXJlc3RlZC4NCg0KPiBUaGFua3MNCj4gS2V2aW4NCg==
