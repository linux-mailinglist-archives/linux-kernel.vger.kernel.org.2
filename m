Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F5031AD51
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 18:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhBMRKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 12:10:09 -0500
Received: from mga06.intel.com ([134.134.136.31]:20889 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229647AbhBMRKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 12:10:02 -0500
IronPort-SDR: Gr4Pq2iBa2WqrY9rrgPLQjQIXDv/wvErNIfFny3MykeUR32DP2YNw8mn81U8sNLAZiKhu9UnNb
 NRacJ7VgdN7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9894"; a="244021468"
X-IronPort-AV: E=Sophos;i="5.81,176,1610438400"; 
   d="scan'208";a="244021468"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2021 09:09:20 -0800
IronPort-SDR: zxeaR09jXell1e+x2UGPbnP4I9gr3xdCYoPW6FrRXaGwyPYSfVZkCxoCy/x+Rmc+/M5nGiwoxx
 0Lv+4396MH/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,176,1610438400"; 
   d="scan'208";a="437984772"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga001.jf.intel.com with ESMTP; 13 Feb 2021 09:09:20 -0800
Received: from lcsmsx602.ger.corp.intel.com (10.109.210.11) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sat, 13 Feb 2021 09:09:19 -0800
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 LCSMSX602.ger.corp.intel.com (10.109.210.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sat, 13 Feb 2021 19:09:17 +0200
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.2106.002;
 Sat, 13 Feb 2021 19:09:17 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Richard Weinberger <richard@nod.at>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mtd: use refcount to prevent corruption
Thread-Topic: [PATCH] mtd: use refcount to prevent corruption
Thread-Index: AQHW9OeD00Da249Jw0qJn6+VIZAeUao7z7AAgAAh5BBxoBSOfPxzntFAEGBJdu//fSiMQP//4NkAAA+XK+AnHY02HSTJqnMg
Date:   Sat, 13 Feb 2021 17:09:17 +0000
Message-ID: <783a45b0bc04483e9a0a6bb0a083bccb@intel.com>
References: <20210127200319.662842-1-tomas.winkler@intel.com>
 <c8d0f22c5fdf443cb8dda1f996b148d9@intel.com>
 <1776363776.325713.1611782270873.JavaMail.zimbra@nod.at>
 <a6cb6eb10bbb48989d3a9e087951e50e@intel.com>
 <1665542284.336646.1611820031174.JavaMail.zimbra@nod.at>
 <f91d7eff1d764ba7b47f023bc0fafacb@intel.com> <20210128100032.5eb542c6@xps13>
 <10c2e98c393a486cab3bc953e9926e38@intel.com>
 <1363048722.339069.1611865409332.JavaMail.zimbra@nod.at>
In-Reply-To: <1363048722.339069.1611865409332.JavaMail.zimbra@nod.at>
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

DQo+IA0KPiBUb21hcywNCj4gDQo+IC0tLS0tIFVyc3Byw7xuZ2xpY2hlIE1haWwgLS0tLS0NCj4g
Pj4gQXMgUmljaGFyZCB3YXMgc2F5aW5nLCB3ZSBhcmUgcmVhbGx5IG9wZW4gdG8gZW5oYW5jZSBN
VEQgcmVmY291bnRpbmcuDQo+ID4+DQo+ID4+IEhvd2V2ZXIsIHRoZSBpc3N1ZSB5b3UgYXJlIGZh
Y2luZyBpcywgSU1ITywgbm90IHJlbGF0ZWQgdG8gTVREIGJ1dCB0bw0KPiBNRkQuDQo+ID4+IFRo
ZXJlIHNob3VsZCBiZSBhIHdheSB0byBhdm9pZCBNRkQgdG8gdmFuaXNoIGJ5IHRha2luZyBhIHJl
ZmVyZW5jZSBvZg0KPiA+PiBpdCB0aHJvdWdoIG10ZC0+X2dldF9kZXZpY2UoKS4gSSBkb24ndCB0
aGluayBhZGRyZXNzaW5nIHRoZSBjYXNlDQo+ID4+IHdoZXJlIE1GRCB2YW5pc2hlcyB3aGlsZSBN
VEQgKGFzIGEgdXNlcikgaXMgc3RpbGwgYWN0aXZlIGlzIHRoZSByaWdodA0KPiBhcHByb2FjaC4N
Cj4gPg0KPiA+IEkgdGhpbmsgaXQgd29uJ3Qgd29yayBiZWNhdXNlIE1GRCBzdWItZHJpdmVyIHJl
bW92ZSgpIGlzIGNhbGxlZCAgIGFuZCBpdA0KPiBtdXN0DQo+ID4gc3VjY2VlZCBiZWNhdXNlIHRo
ZSBtYWluIGRldmljZSAgaXMgbm90IGFjY2Vzc2libGUgdW5saWtlIGdsdWV1YmkNCj4gPiB3aGlj
aCBqdXN0IHJldHVybnMgLUVCVVNZLg0KPiANCj4gV2VsbCwgdGhlIHRyaWNrIGluIGdsdWJpIChh
bmQgb3RoZXIgTVREcyB3aXRoICJob3RwbHVnIiBzdXBwb3J0KSBpcyBub3QgdG8NCj4gcmVqZWN0
IHJlbW92YWwgb2YgdGhlIHN1Yi1kZXZpY2UuIC0+X3B1dF9kZXZpY2UoKSBpcyBvZiByZXR1cm4g
dHlwZSB2b2lkLg0KPiBUaGUga2V5IGlzIGdyYWJiaW5nIGEgcmVmZXJlbmNlIG9uIHRoZSBzdWIt
ZGV2aWNlIGluIC0+X2dldF9kZXZpY2UoKSBzdWNoDQo+IHRoYXQgdGhlIGxheWVyIGJlbG93IGRv
ZXNuJ3QgZXZlbiB0cnkgdG8gcmVtb3ZlIHdoaWxlIHRoZSBNVEQgaXMgaW4gdXNlLg0KDQpJIHVu
ZGVyc3RhbmQgdGhhdC4gQnV0IGluIHRoYXQgY2FzZSB0aGUga2VybmVsIGlzIGluIHRoZSBtZXJj
eSBvZiB1c2VyIHNwYWNlIHRvIGNsb3NlIHRoZSBoYW5kbGUsICANCnRoZSB3aG9sZSBwZXJjZXB0
aW9uIGhlcmUgaXMgdGhhdCBvZiBob3RwbHVnIHRoYXQgdGhlIGRldmljZSBpcyAgcGh5c2ljYWxs
eSByZW1vdmVkIGl0IGNhbm5vdCB3YWl0IA0KZm9yIHRoZSB1c2VyIHNwYWNlIHRvIGNvbXBsZXRl
LiBXaGF0J3MgdGhlIGZpeCBpcyB0cnlpbmcgdG8gZG8gaXMgdG8gYmFpbCBvdXQgZ3JhY2VmdWxs
eS4NCg0KPiA+IHNvIHdlIHBvc3Rwb25lIHRoZSBtdGQgdW5yZWdpc3RlciB0byAgbXRkX2luZm8t
Pl9wdXRfZGV2aWNlKCkgIGJ1dCBpdA0KPiA+IHRoYXQgc3RhdGUgd2UgaGF2ZSBub3RoaW5nIHRv
IGhvbGQgb24gYXMgdGhlIGRldmljZSBpcyBnb25lIGluDQo+ID4gcmVtb3ZlKCkgVXNlciB3aWxs
IGZhaWwgYW55d2F5LCBhcyB0aGUgdW5kZXJseWluZyBkZXZpY2UgaXMgbm90DQo+ID4gZnVuY3Rp
b25hbCBpbiB0aGF0IHN0YXRlLg0KPiA+IEFueXdheSBJJ3ZlIHRyaWVkIHlvdXIgc3VnZ2VzdGlv
biwgdGhlIGtlcm5lbCBpcyBjcmFzaGluZywgaG9wZSBJDQo+ID4gaGF2ZW4ndCBkb25lIHNvbWUg
c2lsbHkgYnVnLg0KPiANCj4gQ2FuIHlvdSBwb2ludCB1cyB0byB0aGUgYWZmZWN0ZWQgY29kZT8N
Cj4gVGhpcyB3b3VsZCBoZWxwIGEgbG90IHRvIHVuZGVyc3RhbmQgdGhlIGlzc3VlIGJldHRlci4N
Cj4gSSdtIHN1cmUgd2UgY2FuIGZpbmQgYSBzb2x1dGlvbi4NCg0KR290IGdyZWVuIGxpZ2h0IG9u
IHJlbGVhc2luZyB0aGUgcGF0Y2hlcyB3aWxsIHNlbmQgc29vbi4NCg0KDQpUaGFua3MNClRvbWFz
DQoNCg==
