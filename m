Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14203D6B9F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 03:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbhG0BIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 21:08:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:45662 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229575AbhG0BIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 21:08:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="273428522"
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="273428522"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 18:48:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="516513255"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jul 2021 18:48:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 26 Jul 2021 18:48:43 -0700
Received: from irsmsx605.ger.corp.intel.com (163.33.146.138) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 26 Jul 2021 18:48:42 -0700
Received: from irsmsx605.ger.corp.intel.com ([163.33.146.138]) by
 IRSMSX605.ger.corp.intel.com ([163.33.146.138]) with mapi id 15.01.2242.010;
 Tue, 27 Jul 2021 02:48:40 +0100
From:   "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>,
        "seanjc@google.com" <seanjc@google.com>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC PATCH 1/4] x86/sgx: Track phase and type of SGX EPC pages
Thread-Topic: [RFC PATCH 1/4] x86/sgx: Track phase and type of SGX EPC pages
Thread-Index: AQHXXK7zaT5nPNFZW0CRpS5zurO9nKtBReUAgBUDBIA=
Date:   Tue, 27 Jul 2021 01:48:40 +0000
Message-ID: <98df594dccc9fb5ac857a00308118e6a48bc24a4.camel@intel.com>
References: <20210608214038.1026259-1-tony.luck@intel.com>
         <20210608214038.1026259-2-tony.luck@intel.com>
         <YO3FuBupQTKYaKBf@google.com>
In-Reply-To: <YO3FuBupQTKYaKBf@google.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.253.164]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7827381154496E43889F288FF35E0EA5@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTA3LTEzIGF0IDE2OjU2ICswMDAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBUdWUsIEp1biAwOCwgMjAyMSwgVG9ueSBMdWNrIHdyb3RlOg0KPiA+IEFkZCBh
IHR5cGUgZmllbGQgdG8gc3RydWN0IGVwY19wYWdlIGZvciBob3cgYW4gaW4tdXNlIHBhZ2UgaGFz
IGJlZW4NCj4gPiBhbGxvY2F0ZWQuIFJlLXVzZSAiZW51bSBzZ3hfcGFnZV90eXBlIiBmb3IgdGhp
cyB0eXBlLCB3aXRoIGEgY291cGxlDQo+ID4gb2YgYWRkaXRpb25zIGZvciBzL3cgdHlwZXMuDQo+
IA0KPiBJTU8sIHRha2luZyBkaWZmZXJlbnQgYWN0aW9ucyBiYXNlZCBvbiB0aGUgcGFnZSB0eXBl
IGlzIGZsYXdlZC4gIERpdHRvIGZvciBhZGRpbmcNCj4gYSBmbGFnIHRvIHRyYWNrIHNvIGNhbGxl
ZCAiZGlydHkiIHBhZ2VzLg0KDQpJIGFncmVlIHdpdGggdGhpcy4gTGV0J3Mga2VlcCBtaWNyb2Fy
Y2hpdGVjdHVyZSByZWxhdGVkDQpzdHJ1Y3R1cmVzL2VudW1zIHNlcGFyYXRlIGZyb20gInNvZnR3
YXJlIGRlZmluZWQiIHRoaW5ncy4NCg0KSWYgc3VjaCB0aGluZ3MgYWRkIHVwIChpLmUuIHNpbWls
YXIgYWRkaXRpb25zIHRvIHNvbWV0aGluZw0KZWxzZSBpbiBmdXR1cmUpLCBpdCB3aWxsIGJlIGJv
dGggaGFyZCB0byBtYWludGFpbiwgYW5kIGFsc28NCnRoZSBzdWJzeXN0ZW0gd2lsbCBiZSBoYXJk
ZXIgdG8gdW5kZXJzdGFuZCBmb3IgcG90ZW50aWFsIGZ1dHVyZQ0KY29udHJpYnV0ZXJzLg0KDQov
SmFya2tvDQo=
