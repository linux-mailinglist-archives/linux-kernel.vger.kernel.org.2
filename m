Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FBB3D6BB3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 04:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbhG0BX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 21:23:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:19867 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229575AbhG0BX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 21:23:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="212339159"
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="212339159"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 19:04:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="455950254"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga007.jf.intel.com with ESMTP; 26 Jul 2021 19:04:24 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 26 Jul 2021 19:04:24 -0700
Received: from irsmsx605.ger.corp.intel.com (163.33.146.138) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 26 Jul 2021 19:04:22 -0700
Received: from irsmsx605.ger.corp.intel.com ([163.33.146.138]) by
 IRSMSX605.ger.corp.intel.com ([163.33.146.138]) with mapi id 15.01.2242.010;
 Tue, 27 Jul 2021 03:04:21 +0100
From:   "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "seanjc@google.com" <seanjc@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 1/6] x86/sgx: Provide indication of life-cycle of EPC
 pages
Thread-Topic: [PATCH v2 1/6] x86/sgx: Provide indication of life-cycle of EPC
 pages
Thread-Index: AQHXfMq64ck9iKFqFES93kMgbxNbPqtWDRMA
Date:   Tue, 27 Jul 2021 02:04:21 +0000
Message-ID: <bb43abe9e13f9a3af7e424e997c73c790b5ff7bf.camel@intel.com>
References: <20210708181423.1312359-1-tony.luck@intel.com>
         <20210719182009.1409895-1-tony.luck@intel.com>
         <20210719182009.1409895-2-tony.luck@intel.com>
In-Reply-To: <20210719182009.1409895-2-tony.luck@intel.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.253.164]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B97EC1F4A7A93740859A3008EA471274@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTA3LTE5IGF0IDExOjIwIC0wNzAwLCBUb255IEx1Y2sgd3JvdGU6DQo+IFNH
WCBFUEMgcGFnZXMgZ28gdGhyb3VnaCB0aGUgZm9sbG93aW5nIGxpZmUgY3ljbGU6DQo+IA0KPiAJ
RElSVFkgLS0tPiBGUkVFIC0tLT4gSU4tVVNFIC0tXA0KPiAgICAgICAgICAgICAgICAgICAgIF4g
ICAgICAgICAgICAgICAgIHwNCj4gICAgICAgICAgICAgICAgICAgICBcLS0tLS0tLS0tLS0tLS0t
LS0vDQo+IA0KPiBSZWNvdmVyeSBhY3Rpb24gZm9yIHBvaXNvbiBmb3IgYSBESVJUWSBvciBGUkVF
IHBhZ2UgaXMgc2ltcGxlLiBKdXN0DQo+IG1ha2Ugc3VyZSBuZXZlciB0byBhbGxvY2F0ZSB0aGUg
cGFnZS4gSU4tVVNFIHBhZ2VzIG5lZWQgc29tZSBleHRyYQ0KPiBoYW5kbGluZy4NCj4gDQo+IEl0
IHdvdWxkIGJlIGdvb2QgdG8gdXNlIHRoZSBzZ3hfZXBjX3BhZ2UtPm93bmVyIGZpZWxkIGFzIGFu
IGluZGljYXRvcg0KPiBvZiB3aGVyZSBhbiBFUEMgcGFnZSBpcyBjdXJyZW50bHkgaW4gdGhhdCBj
eWNsZSAob3duZXIgIT0gTlVMTCBtZWFucw0KPiB0aGUgRVBDIHBhZ2UgaXMgSU4tVVNFKS4gQnV0
IHRoZXJlIGlzIG9uZSBjYWxsZXIsIHNneF9hbGxvY192YV9wYWdlKCksDQo+IHRoYXQgY2FsbHMg
d2l0aCBOVUxMLg0KPiANCj4gTWFrZSB0aGUgZm9sbG93aW5nIGNoYW5nZXM6DQo+IA0KPiAxKSBD
aGFuZ2UgdGhlIHR5cGUgb2YgIm93bmVyIiB0byAidm9pZCAqIiAoaXQgY2FuIGhhdmUgb3RoZXIg
dHlwZXMNCj4gICAgYmVzaWRlcyAic3RydWN0IHNneF9lbmNsX3BhZ2UgKikuDQo+IDIpIFVwZGF0
ZSBzZ3hfYWxsb2NfdmFfcGFnZSgpIHRvIHBhc3MgaW4gYSBkdW1teSBub24tTlVMTCB2YWx1ZSBp
bg0KPiAgICB0aGlzIGNhc2UuDQo+IDMpIEFkZCBhIGNoZWNrIHRvIHNneF9mcmVlX2VwY19wYWdl
KCkgdG8gcHJldmVudCBjYWxsaW5nIHdpdGggTlVMTC4NCj4gNCkgUmVzZXQgb3duZXIgdG8gTlVM
TCBpbiBzZ3hfZnJlZV9lcGNfcGFnZSgpLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVG9ueSBMdWNr
IDx0b255Lmx1Y2tAaW50ZWwuY29tPg0KPiAtLS0NCj4gIGFyY2gveDg2L2tlcm5lbC9jcHUvc2d4
L2VuY2wuYyB8IDIgKy0NCj4gIGFyY2gveDg2L2tlcm5lbC9jcHUvc2d4L21haW4uYyB8IDYgKysr
KysrDQo+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1L3NneC9zZ3guaCAgfCAyICstDQo+ICAzIGZpbGVz
IGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3NneC9lbmNsLmMgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1
L3NneC9lbmNsLmMNCj4gaW5kZXggMDAxODA4ZTM5MDFjLi5jYTMyOGQ1NmQyMzAgMTAwNjQ0DQo+
IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvc2d4L2VuY2wuYw0KPiArKysgYi9hcmNoL3g4Ni9r
ZXJuZWwvY3B1L3NneC9lbmNsLmMNCj4gQEAgLTY3OSw3ICs2NzksNyBAQCBzdHJ1Y3Qgc2d4X2Vw
Y19wYWdlICpzZ3hfYWxsb2NfdmFfcGFnZSh2b2lkKQ0KPiAgCXN0cnVjdCBzZ3hfZXBjX3BhZ2Ug
KmVwY19wYWdlOw0KPiAgCWludCByZXQ7DQo+ICANCj4gLQllcGNfcGFnZSA9IHNneF9hbGxvY19l
cGNfcGFnZShOVUxMLCB0cnVlKTsNCj4gKwllcGNfcGFnZSA9IHNneF9hbGxvY19lcGNfcGFnZSgi
Tm90IE5VTEwhIiwgdHJ1ZSk7DQoNCg0KSSB3b3VsZCBpbnN0ZWFkIHNldCBvd25lciB0byBlcGNf
cGFnZSBpbnNpZGUgc2d4X2FsbG9jX2VwY19wYWdlKCksDQp3aGVuIE5VTEwgaXMgcGFzc2VkIHRv
IG93bmVyLiBUaGF0IHdvdWxkIGJlIHNlbWFudGljYWxseSBzb3VuZC4NCg0KL0phcmtrbw0K
