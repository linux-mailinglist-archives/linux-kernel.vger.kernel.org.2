Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B90307D42
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhA1SA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:00:58 -0500
Received: from mga07.intel.com ([134.134.136.100]:62687 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231446AbhA1R6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 12:58:49 -0500
IronPort-SDR: DL8SY/b333KVSqSbCPKYtjt9ubhJQvyUUKYTskxPoOArVdFtVHBTvwiNQZ2tgLDE79sdH+to94
 aogJyy2DX0oQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="244367920"
X-IronPort-AV: E=Sophos;i="5.79,383,1602572400"; 
   d="scan'208";a="244367920"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 09:57:53 -0800
IronPort-SDR: DjuDc+ED+B7u05IN5Yc8E9sNgLGhr+YLu6AmqfYCJY4KplT658lVrOiGkjfWh6YIqqweS5jg2v
 MVKnFxPKdaMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,383,1602572400"; 
   d="scan'208";a="363892443"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jan 2021 09:57:53 -0800
Received: from lcsmsx603.ger.corp.intel.com (10.109.210.12) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 28 Jan 2021 09:57:52 -0800
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 LCSMSX603.ger.corp.intel.com (10.109.210.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 28 Jan 2021 19:57:50 +0200
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Thu, 28 Jan 2021 19:57:50 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mtd: use refcount to prevent corruption
Thread-Topic: [PATCH] mtd: use refcount to prevent corruption
Thread-Index: AQHW9OeD00Da249Jw0qJn6+VIZAeUao7z7AAgAAh5BBxoBSOfPxzntFAEGBJdu//fSiMQP//4NkAAA+XK+A=
Date:   Thu, 28 Jan 2021 17:57:50 +0000
Message-ID: <10c2e98c393a486cab3bc953e9926e38@intel.com>
References: <20210127200319.662842-1-tomas.winkler@intel.com>
        <9732911.325628.1611780400338.JavaMail.zimbra@nod.at>
        <c8d0f22c5fdf443cb8dda1f996b148d9@intel.com>
        <1776363776.325713.1611782270873.JavaMail.zimbra@nod.at>
        <a6cb6eb10bbb48989d3a9e087951e50e@intel.com>
        <1665542284.336646.1611820031174.JavaMail.zimbra@nod.at>
        <f91d7eff1d764ba7b47f023bc0fafacb@intel.com> <20210128100032.5eb542c6@xps13>
In-Reply-To: <20210128100032.5eb542c6@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.184.70.1]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBIaSBUb21hcywNCj4gDQo+ICJXaW5rbGVyLCBUb21hcyIgPHRvbWFzLndpbmtsZXJAaW50ZWwu
Y29tPiB3cm90ZSBvbiBUaHUsIDI4IEphbiAyMDIxDQo+IDA4OjUzOjQzICswMDAwOg0KPiANCj4g
PiA+IFRvbWFzLA0KPiA+ID4NCj4gPiA+IC0tLS0tIFVyc3Byw7xuZ2xpY2hlIE1haWwgLS0tLS0N
Cj4gPiA+ID4+ID4+IENhbiB5b3UgcGxlYXNlIGV4cGxhaW4gYSBsaXR0bGUgbW9yZSB3aGF0IGRl
dmljZXMgYXJlIGludm9sdmVkPw0KPiA+ID4gPj4gPj4gRG9lcyBpdCBpbXBsZW1lbnQgX2dldF9k
ZXZpY2UoKSBhbmQgX3B1dF9kZXZpY2UoKT8NCj4gPiA+ID4+ID4gTm8gdGhpcyBpcyBub3QgY29u
bmVjdGVkIHRvIHRob3NlIGhhbmRsZXJzIG9mIHRoZSB1bmRlcmx5aW5nDQo+ID4gPiA+PiA+IGRl
dmljZSBhbmQgdGhvc2Ugd29uJ3QgaGVscC4NCj4gPiA+ID4+ID4gSSBoYXZlIGEgc3BpIGRldmlj
ZSBwcm92aWRlZCBieSBNRkQgZnJhbWV3b3JrIHNvIGl0IGNhbiBnbyBhd2F5DQo+IGFueXRpbWUu
DQo+ID4gPiA+Pg0KPiA+ID4gPj4gQ2FuIGl0IGdvIGF3YXkgcGh5c2ljYWxseSBvciBqdXN0IGlu
IHNvZnR3YXJlPw0KPiA+ID4gPiBTb2Z0d2FyZSwgYnV0IHNpbmNlIHRoaXMgaXMgbWZkIGl0J3Mg
YmFzaWNhbGx5IGhvdHBsdWcuIFRoZSBrZXJuZWwNCj4gPiA+ID4gaXMgY3Jhc2hpbmcgd2hlbiBJ
IHNpbXVsYXRlIGhhcmR3YXJlIGZhaWx1cmUuDQo+ID4gPiA+Pg0KPiA+ID4gPj4gVXN1YWxseSB0
aGUgcGF0dGVybiBpcyB0aGF0IHlvdSBtYWtlIHN1cmUgaW4gdGhlIGRldmljZSBkcml2ZXINCj4g
PiA+ID4+IHRoYXQgbm9ib2R5IGNhbiBvcnBoYW4gdGhlIE1URCB3aGlsZSBpdCBpcyBpbiB1c2Uu
DQo+ID4gPiA+PiBlLmcuIGRyaXZlcnMvbXRkL3ViaS9nbHVlYmkuYyBkb2VzIHNvLiBJbiBfZ2V0
X2RldmljZSgpIGl0IGdyYWJzDQo+ID4gPiA+PiBhIHJlZmVyZW5jZSBvbiB0aGUgdW5kZXJseWlu
ZyBVQkkgdm9sdW1lIHRvIG1ha2Ugc3VyZSBpdCBjYW5ub3QNCj4gPiA+ID4+IGdvIGF3YXkgd2hp
bGUgdGhlIE1URCAob24gdG9wIG9mIFVCSSkgaXMgaW4gdXNlLg0KPiA+ID4gPg0KPiA+ID4gPiBJ
IGNhbiB0cnkgdGhhdCBpZiBpdCBoZWxwcywgYmVjYXVzZSB3ZSBhcmUgc2ltdWxhdGluZyBwb3Nz
aWJsZQ0KPiA+ID4gPiBsb3dlciBsZXZlbCBjcmFzaC4NCj4gPiA+ID4gSW4gYW4gY2FzZSBJIGJl
bGlldmUgdGhhdCB0aGUgcHJvcGVyIHJlZmNvdXRpbmcgaXMgbXVjaCBtb3JlDQo+ID4gPiA+IHJv
YnVzdCBzb2x1dGlvbiwgdGhhbiB0aGUgY3VycmVudCBvbmUuDQo+ID4gPiA+IEknZCBhcHByZWNp
YXRlIGlmIHNvbWVvbmUgY2FuIHJldmlldyB0aGUgYWN0dWFsIGltcGxlbWVudGF0aW9uLg0KPiA+
ID4NCj4gPiA+IFRoaXMgaGFwcGVucyByaWdodCBub3csIEkgdHJ5IHRvIHVuZGVyc3RhbmQgd2h5
IGV4YWN0bHkgdGhlIGN1cnJlbnQNCj4gPiA+IHdheSBpcyBub3QgZ29vZCBpbiBlbm91Z2guIDot
KQ0KPiA+ID4NCj4gPiA+IFlvdXIgYXBwcm9hY2ggbWFrZXMgc3VyZSB0aGF0IHRoZSBNVEQgaXRz
ZWxmIGRvZXMgbm90IGdvIGF3YXkgd2hpbGUNCj4gPiA+IGl0IGhhcyB1c2VycyBidXQgaG93IGRv
ZXMgdGhpcyBoZWxwIGluIHRoZSBjYXNlIHdoZXJlIHRoZSB1bmRlcmx5aW5nDQo+ID4gPiBNRkQg
anVzdCB2YW5pc2hlcz8NCj4gPiA+IFRoZSBNVEQgY2FuIGJlIGluIHVzZSBhbmQgdGhlIE1GRCBj
YW4gZ28gYXdheSB3aGlsZSBlLmcuIG10ZF9yZWFkKCkNCj4gPiA+IG9yIHN1Y2ggdGFrZXMgcGxh
Y2UuDQo+ID4NCj4gPiBSZWFkIHdpbGwgZmFpbCwgYnV0IGtlcm5lbCB3b24ndCBjcmFzaCBvbiBh
Y2Nlc3MgdG8gbWVtb3J5IHRoYXQgd2FzIGZyZWVkLg0KPiANCj4gQXMgUmljaGFyZCB3YXMgc2F5
aW5nLCB3ZSBhcmUgcmVhbGx5IG9wZW4gdG8gZW5oYW5jZSBNVEQgcmVmY291bnRpbmcuDQo+IA0K
PiBIb3dldmVyLCB0aGUgaXNzdWUgeW91IGFyZSBmYWNpbmcgaXMsIElNSE8sIG5vdCByZWxhdGVk
IHRvIE1URCBidXQgdG8gTUZELg0KPiBUaGVyZSBzaG91bGQgYmUgYSB3YXkgdG8gYXZvaWQgTUZE
IHRvIHZhbmlzaCBieSB0YWtpbmcgYSByZWZlcmVuY2Ugb2YgaXQNCj4gdGhyb3VnaCBtdGQtPl9n
ZXRfZGV2aWNlKCkuIEkgZG9uJ3QgdGhpbmsgYWRkcmVzc2luZyB0aGUgY2FzZSB3aGVyZSBNRkQN
Cj4gdmFuaXNoZXMgd2hpbGUgTVREIChhcyBhIHVzZXIpIGlzIHN0aWxsIGFjdGl2ZSBpcyB0aGUg
cmlnaHQgYXBwcm9hY2guDQoNCkkgdGhpbmsgaXQgd29uJ3Qgd29yayBiZWNhdXNlIE1GRCBzdWIt
ZHJpdmVyIHJlbW92ZSgpIGlzIGNhbGxlZCAgIGFuZCBpdCBtdXN0IHN1Y2NlZWQgYmVjYXVzZSB0
aGUgbWFpbiBkZXZpY2UgIGlzIG5vdCBhY2Nlc3NpYmxlIHVubGlrZSBnbHVldWJpIHdoaWNoIGp1
c3QgcmV0dXJucyAtRUJVU1kuDQpzbyB3ZSBwb3N0cG9uZSB0aGUgbXRkIHVucmVnaXN0ZXIgdG8g
IG10ZF9pbmZvLT5fcHV0X2RldmljZSgpICBidXQgaXQgdGhhdCBzdGF0ZSB3ZSBoYXZlIG5vdGhp
bmcgdG8gaG9sZA0Kb24gYXMgdGhlIGRldmljZSBpcyBnb25lIGluIHJlbW92ZSgpDQpVc2VyIHdp
bGwgZmFpbCBhbnl3YXksIGFzIHRoZSB1bmRlcmx5aW5nIGRldmljZSBpcyBub3QgZnVuY3Rpb25h
bCBpbiB0aGF0IHN0YXRlLg0KQW55d2F5IEkndmUgdHJpZWQgeW91ciBzdWdnZXN0aW9uLCB0aGUg
a2VybmVsIGlzIGNyYXNoaW5nLCBob3BlIEkgaGF2ZW4ndCBkb25lIHNvbWUgc2lsbHkgYnVnLg0K
DQpUaGFua3MNClRvbWFzDQoNCg0KDQo=
