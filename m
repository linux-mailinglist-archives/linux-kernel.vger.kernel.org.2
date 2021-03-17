Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0BF33ED1B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbhCQJf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:35:59 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3470 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhCQJf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:35:58 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4F0lN81yZtz5dXG;
        Wed, 17 Mar 2021 17:34:00 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Wed, 17 Mar 2021 17:35:51 +0800
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 17 Mar 2021 17:35:51 +0800
Received: from dggpeml500016.china.huawei.com ([7.185.36.70]) by
 dggpeml500016.china.huawei.com ([7.185.36.70]) with mapi id 15.01.2106.013;
 Wed, 17 Mar 2021 17:35:51 +0800
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
Thread-Index: AQHXGtwEduPlUZeCNUCbiy3s/+KwAaqHJckAgADDZTA=
Date:   Wed, 17 Mar 2021 09:35:51 +0000
Message-ID: <6a218e7fe42d41489d02f0b4e3ad2756@huawei.com>
References: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
 <FB4E11A5-84D4-4DAF-889E-FAA1BCD2E66F@gmail.com>
In-Reply-To: <FB4E11A5-84D4-4DAF-889E-FAA1BCD2E66F@gmail.com>
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
QW1pdCBbbWFpbHRvOm5hZGF2LmFtaXRAZ21haWwuY29tXQ0KPiBTZW50OiBXZWRuZXNkYXksIE1h
cmNoIDE3LCAyMDIxIDE6NDYgUE0NCj4gVG86IExvbmdwZW5nIChNaWtlLCBDbG91ZCBJbmZyYXN0
cnVjdHVyZSBTZXJ2aWNlIFByb2R1Y3QgRGVwdC4pDQo+IDxsb25ncGVuZzJAaHVhd2VpLmNvbT4N
Cj4gQ2M6IERhdmlkIFdvb2Rob3VzZSA8ZHdtdzJAaW5mcmFkZWFkLm9yZz47IEx1IEJhb2x1DQo+
IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+OyBKb2VyZyBSb2VkZWwgPGpvcm9AOGJ5dGVzLm9y
Zz47IHdpbGxAa2VybmVsLm9yZzsNCj4gYWxleC53aWxsaWFtc29uQHJlZGhhdC5jb207IGNoZW5q
aWFzaGFuZyA8Y2hlbmppYXNoYW5nQGh1YXdlaS5jb20+Ow0KPiBpb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZzsgR29uZ2xlaSAoQXJlaSkgPGFyZWkuZ29uZ2xlaUBodWF3ZWkuY29tPjsN
Cj4gTEtNTCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IEEg
cHJvYmxlbSBvZiBJbnRlbCBJT01NVSBoYXJkd2FyZSDvvJ8NCj4gDQo+IA0KPiANCj4gPiBPbiBN
YXIgMTYsIDIwMjEsIGF0IDg6MTYgUE0sIExvbmdwZW5nIChNaWtlLCBDbG91ZCBJbmZyYXN0cnVj
dHVyZSBTZXJ2aWNlDQo+IFByb2R1Y3QgRGVwdC4pIDxsb25ncGVuZzJAaHVhd2VpLmNvbT4gd3Jv
dGU6DQo+ID4NCj4gPiBIaSBndXlzLA0KPiA+DQo+ID4gV2UgZmluZCB0aGUgSW50ZWwgaW9tbXUg
Y2FjaGUgKGkuZS4gaW90bGIpIG1heWJlIHdvcmtzIHdyb25nIGluIGENCj4gPiBzcGVjaWFsIHNp
dHVhdGlvbiwgaXQgd291bGQgY2F1c2UgRE1BIGZhaWxzIG9yIGdldCB3cm9uZyBkYXRhLg0KPiA+
DQo+ID4gVGhlIHJlcHJvZHVjZXIgKGJhc2VkIG9uIEFsZXgncyB2ZmlvIHRlc3RzdWl0ZVsxXSkg
aXMgaW4gYXR0YWNobWVudCwNCj4gPiBpdCBjYW4gcmVwcm9kdWNlIHRoZSBwcm9ibGVtIHdpdGgg
aGlnaCBwcm9iYWJpbGl0eSAofjUwJSkuDQo+IA0KPiBJIHNhdyBMdSByZXBsaWVkLCBhbmQgaGUg
aXMgbXVjaCBtb3JlIGtub3dsZWRnYWJsZSB0aGFuIEkgYW0gKEkgd2FzIGp1c3QgaW50cmlndWVk
DQo+IGJ5IHlvdXIgZW1haWwpLg0KPiANCj4gSG93ZXZlciwgaWYgSSB3ZXJlIHlvdSBJIHdvdWxk
IHRyeSBhbHNvIHRvIHJlbW92ZSBzb21lIOKAnG9wdGltaXphdGlvbnPigJ0gdG8gbG9vayBmb3IN
Cj4gdGhlIHJvb3QtY2F1c2UgKGUuZy4sIHVzZSBkb21haW4gc3BlY2lmaWMgaW52YWxpZGF0aW9u
cyBpbnN0ZWFkIG9mIHBhZ2Utc3BlY2lmaWMpLg0KPiANCg0KR29vZCBzdWdnZXN0aW9uISBCdXQg
d2UgZGlkIGl0IHRoZXNlIGRheXMsIHdlIHRyaWVkIHRvIHVzZSBnbG9iYWwgaW52YWxpZGF0aW9u
cyBhcyBmb2xsb3c6DQoJCWlvbW11LT5mbHVzaC5mbHVzaF9pb3RsYihpb21tdSwgZGlkLCAwLCAw
LA0KCQkJCQkJRE1BX1RMQl9EU0lfRkxVU0gpOw0KQnV0IGNhbiBub3QgcmVzb2x2ZSB0aGUgcHJv
YmxlbS4NCg0KPiBUaGUgZmlyc3QgdGhpbmcgdGhhdCBjb21lcyB0byBteSBtaW5kIGlzIHRoZSBp
bnZhbGlkYXRpb24gaGludCAoaWgpIGluDQo+IGlvbW11X2ZsdXNoX2lvdGxiX3BzaSgpLiBJIHdv
dWxkIHJlbW92ZSBpdCB0byBzZWUgd2hldGhlciB5b3UgZ2V0IHRoZSBmYWlsdXJlDQo+IHdpdGhv
dXQgaXQuDQoNCldlIGFsc28gbm90aWNlIHRoZSBJSCwgYnV0IHRoZSBJSCBpcyBhbHdheXMgWkVS
TyBpbiBvdXIgY2FzZSwgYXMgdGhlIHNwZWMgc2F5czoNCicnJw0KUGFnaW5nLXN0cnVjdHVyZS1j
YWNoZSBlbnRyaWVzIGNhY2hpbmcgc2Vjb25kLWxldmVsIG1hcHBpbmdzIGFzc29jaWF0ZWQgd2l0
aCB0aGUgc3BlY2lmaWVkDQpkb21haW4taWQgYW5kIHRoZSBzZWNvbmQtbGV2ZWwtaW5wdXQtYWRk
cmVzcyByYW5nZSBhcmUgaW52YWxpZGF0ZWQsIGlmIHRoZSBJbnZhbGlkYXRpb24gSGludA0KKElI
KSBmaWVsZCBpcyBDbGVhci4NCicnJw0KDQpJdCBzZWVtcyB0aGUgc29mdHdhcmUgaXMgZXZlcnl0
aGluZyBmaW5lLCBzbyB3ZSd2ZSBubyBjaG9pY2UgYnV0IHRvIHN1c3BlY3QgdGhlIGhhcmR3YXJl
Lg0K
