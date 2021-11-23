Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43840459C31
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 07:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbhKWGPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 01:15:31 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:31897 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbhKWGP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 01:15:26 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Hytvn5vKyzcbWn;
        Tue, 23 Nov 2021 14:07:17 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (7.185.36.74) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 23 Nov 2021 14:12:17 +0800
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 23 Nov 2021 14:12:17 +0800
Received: from dggpeml100016.china.huawei.com ([7.185.36.216]) by
 dggpeml100016.china.huawei.com ([7.185.36.216]) with mapi id 15.01.2308.020;
 Tue, 23 Nov 2021 14:12:17 +0800
From:   "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
To:     Jason Wang <jasowang@redhat.com>, Parav Pandit <parav@nvidia.com>
CC:     "mst@redhat.com" <mst@redhat.com>,
        "sgarzare@redhat.com" <sgarzare@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: RE: [PATCH] vdpa_sim: avoid putting an uninitialized iova_domain
Thread-Topic: [PATCH] vdpa_sim: avoid putting an uninitialized iova_domain
Thread-Index: AQHX35uc/oNnB2exRE+LoZU0FVNECKwP6pSAgAAQ2YCAAKUEoA==
Date:   Tue, 23 Nov 2021 06:12:17 +0000
Message-ID: <690da6f45a364dbbaea38d393762c6fc@huawei.com>
References: <20211122122221.56-1-longpeng2@huawei.com>
 <PH0PR12MB54811F4CC671312DFB2FACCDDC609@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsDmqwWdw51NKftjhcGr6z9ynP8dcqDiaQY=soTXTSBDg@mail.gmail.com>
In-Reply-To: <CACGkMEsDmqwWdw51NKftjhcGr6z9ynP8dcqDiaQY=soTXTSBDg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.148.223]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gV2FuZyBbbWFp
bHRvOmphc293YW5nQHJlZGhhdC5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDIzLCAy
MDIxIDEyOjEzIFBNDQo+IFRvOiBQYXJhdiBQYW5kaXQgPHBhcmF2QG52aWRpYS5jb20+DQo+IENj
OiBMb25ncGVuZyAoTWlrZSwgQ2xvdWQgSW5mcmFzdHJ1Y3R1cmUgU2VydmljZSBQcm9kdWN0IERl
cHQuKQ0KPiA8bG9uZ3BlbmcyQGh1YXdlaS5jb20+OyBtc3RAcmVkaGF0LmNvbTsgc2dhcnphcmVA
cmVkaGF0LmNvbTsgTWF4IEd1cnRvdm95DQo+IDxtZ3VydG92b3lAbnZpZGlhLmNvbT47IHZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBHb25nbGVpIChBcmVpKSA8YXJlaS5nb25nbGVpQGh1YXdlaS5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHZkcGFfc2ltOiBhdm9pZCBwdXR0aW5nIGFuIHVuaW5pdGlh
bGl6ZWQgaW92YV9kb21haW4NCj4gDQo+IE9uIFR1ZSwgTm92IDIzLCAyMDIxIGF0IDExOjEyIEFN
IFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZpZGlhLmNvbT4gd3JvdGU6DQo+ID4NCj4gPg0KPiA+DQo+
ID4gPiBGcm9tOiBMb25ncGVuZyhNaWtlKSA8bG9uZ3BlbmcyQGh1YXdlaS5jb20+DQo+ID4gPiBT
ZW50OiBNb25kYXksIE5vdmVtYmVyIDIyLCAyMDIxIDU6NTIgUE0NCj4gPiA+DQo+ID4gPiBGcm9t
OiBMb25ncGVuZyA8bG9uZ3BlbmcyQGh1YXdlaS5jb20+DQo+ID4gPg0KPiA+ID4gVGhlIHN5c3Rl
bSB3aWxsIGNyYXNoIGlmIHdlIHB1dCBhbiB1bmluaXRpYWxpemVkIGlvdmFfZG9tYWluLCB0aGlz
IGNvdWxkDQo+ID4gPiBoYXBwZW4gd2hlbiBhbiBlcnJvciBvY2N1cnMgYmVmb3JlIGluaXRpYWxp
emluZyB0aGUgaW92YV9kb21haW4gaW4NCj4gPiA+IHZkcGFzaW1fY3JlYXRlKCkuDQo+ID4gPg0K
PiA+ID4gQlVHOiBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLCBhZGRyZXNzOiAwMDAw
MDAwMDAwMDAwMDAwIC4uLg0KPiA+ID4gUklQOiAwMDEwOl9fY3B1aHBfc3RhdGVfcmVtb3ZlX2lu
c3RhbmNlKzB4OTYvMHgxYzANCj4gPiA+IC4uLg0KPiA+ID4gQ2FsbCBUcmFjZToNCj4gPiA+ICA8
VEFTSz4NCj4gPiA+ICBwdXRfaW92YV9kb21haW4rMHgyOS8weDIyMA0KPiA+ID4gIHZkcGFzaW1f
ZnJlZSsweGQxLzB4MTIwIFt2ZHBhX3NpbV0NCj4gPiA+ICB2ZHBhX3JlbGVhc2VfZGV2KzB4MjEv
MHg0MCBbdmRwYV0NCj4gPiA+ICBkZXZpY2VfcmVsZWFzZSsweDMzLzB4OTANCj4gPiA+ICBrb2Jq
ZWN0X3JlbGVhc2UrMHg2My8weDE2MA0KPiA+ID4gIHZkcGFzaW1fY3JlYXRlKzB4MTI3LzB4MmEw
IFt2ZHBhX3NpbV0NCj4gPiA+ICB2ZHBhc2ltX25ldF9kZXZfYWRkKzB4N2QvMHhmZSBbdmRwYV9z
aW1fbmV0XQ0KPiA+ID4gIHZkcGFfbmxfY21kX2Rldl9hZGRfc2V0X2RvaXQrMHhlMS8weDFhMCBb
dmRwYV0NCj4gPiA+ICBnZW5sX2ZhbWlseV9yY3ZfbXNnX2RvaXQrMHgxMTIvMHgxNDANCj4gPiA+
ICBnZW5sX3Jjdl9tc2crMHhkZi8weDFkMA0KPiA+ID4gIC4uLg0KPiA+ID4NCj4gPiA+IFNvIHdl
IG11c3QgbWFrZSBzdXJlIHRoZSBpb3ZhX2RvbWFpbiBpcyBhbHJlYWR5IGluaXRpYWxpemVkIGJl
Zm9yZSBwdXQgaXQuDQo+ID4gPg0KPiA+ID4gSW4gYWRkaXRpb24sIHdlIG1heSBnZXQgdGhlIGZv
bGxvd2luZyB3YXJuaW5nIGluIHRoaXMgY2FzZToNCj4gPiA+IFdBUk5JTkc6IC4uLiBkcml2ZXJz
L2lvbW11L2lvdmEuYzozNDQgaW92YV9jYWNoZV9wdXQrMHg1OC8weDcwDQo+ID4gPg0KPiA+ID4g
U28gd2UgbXVzdCBtYWtlIHN1cmUgdGhlIGlvdmFfY2FjaGVfcHV0KCkgaXMgaW52b2tlZCBvbmx5
IGlmIHRoZQ0KPiA+ID4gaW92YV9jYWNoZV9nZXQoKSBpcyBhbHJlYWR5IGludm9rZWQuIExldCdz
IGZpeCBpdCB0b2dldGhlci4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMb25ncGVuZyA8
bG9uZ3BlbmcyQGh1YXdlaS5jb20+DQo+ID4NCj4gPiBDYW4geW91IHBsZWFzZSBhZGQgdGhlIGZp
eGVzIHRhZyBoZXJlIHNvIHRoYXQgb2xkZXIga2VybmVscyBjYW4gdGFrZSB0aGlzIGZpeD8NCj4g
Pg0KPiANCj4gSSBndWVzcyBpdCdzIDQwODBmYzEwNjc1MCAoInZkcGFfc2ltOiB1c2UgaW92YSBt
b2R1bGUgdG8gYWxsb2NhdGUgSU9WQQ0KPiBhZGRyZXNzZXMiKQ0KPiANCg0KSSB0aGluayBzby4g
SSdsbCBhZGQgdGhlIGZpeGVzIHRhZyBpbiBWMiwgdGhhbmtzLg0KDQo+IFRoYW5rcw0KDQo=
