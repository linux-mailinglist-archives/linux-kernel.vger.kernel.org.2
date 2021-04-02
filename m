Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD43352B27
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 16:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbhDBN5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 09:57:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:22014 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229932AbhDBN5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 09:57:43 -0400
IronPort-SDR: BIYrNQOFXzo/hd52bZPhh5NWZJ0MhYwZVVLeMNc1e9tUHgTeXTCsyYljv+LsTPBjyCx4Wv67Zz
 cZTRmk0jI52Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="212744960"
X-IronPort-AV: E=Sophos;i="5.81,299,1610438400"; 
   d="scan'208";a="212744960"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 06:57:41 -0700
IronPort-SDR: +zv6cCDWwz+JXwN0T+v1UAFzO1v7zqlQANUj43HnLNzm9T3/qFB4QRzf07DNf3svrj36xfNKjY
 C7G1tgVSRlYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,299,1610438400"; 
   d="scan'208";a="413188499"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 02 Apr 2021 06:57:41 -0700
Received: from lcsmsx603.ger.corp.intel.com (10.109.210.12) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 2 Apr 2021 06:57:40 -0700
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 LCSMSX603.ger.corp.intel.com (10.109.210.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 2 Apr 2021 16:57:38 +0300
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.2106.013;
 Fri, 2 Apr 2021 16:57:38 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        "Box, David E" <david.e.box@intel.com>,
        "Hans de Goede" <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
CC:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mashiah, Tamar" <tamar.mashiah@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: RE: [PATCH] platform/x86: intel_pmc_core: export platform
 global_reset via sysfs.
Thread-Topic: [PATCH] platform/x86: intel_pmc_core: export platform
 global_reset via sysfs.
Thread-Index: AQHXJz51Jw2Dp3h1DUm1gcOTnDUY2qqhCEmAgAA4ZmA=
Date:   Fri, 2 Apr 2021 13:57:38 +0000
Message-ID: <a57460c2ca0949e4998a8545a01ab112@intel.com>
References: <20210401213144.1009224-1-tomas.winkler@intel.com>
 <f930c11b-7324-19ee-9776-d97a90533b21@metux.net>
In-Reply-To: <f930c11b-7324-19ee-9776-d97a90533b21@metux.net>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRW5yaWNvIFdlaWdlbHQs
IG1ldHV4IElUIGNvbnN1bHQgPGxrbWxAbWV0dXgubmV0Pg0KPiBTZW50OiBGcmlkYXksIEFwcmls
IDAyLCAyMDIxIDE2OjMyDQo+IFRvOiBXaW5rbGVyLCBUb21hcyA8dG9tYXMud2lua2xlckBpbnRl
bC5jb20+OyBSYWpuZWVzaCBCaGFyZHdhag0KPiA8aXJlbmljLnJham5lZXNoQGdtYWlsLmNvbT47
IEJveCwgRGF2aWQgRSA8ZGF2aWQuZS5ib3hAaW50ZWwuY29tPjsgSGFucw0KPiBkZSBHb2VkZSA8
aGRlZ29lZGVAcmVkaGF0LmNvbT47IE1hcmsgR3Jvc3MgPG1ncm9zc0BsaW51eC5pbnRlbC5jb20+
DQo+IENjOiBwbGF0Zm9ybS1kcml2ZXIteDg2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsNCj4gTWFzaGlhaCwgVGFtYXIgPHRhbWFyLm1hc2hpYWhAaW50ZWwu
Y29tPjsgQW5keSBTaGV2Y2hlbmtvDQo+IDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHBsYXRmb3JtL3g4NjogaW50ZWxfcG1jX2NvcmU6
IGV4cG9ydCBwbGF0Zm9ybQ0KPiBnbG9iYWxfcmVzZXQgdmlhIHN5c2ZzLg0KPiANCj4gT24gMDEu
MDQuMjEgMjM6MzEsIFRvbWFzIFdpbmtsZXIgd3JvdGU6DQo+IA0KPiBIaSwNCj4gDQo+ID4gRHVy
aW5nIFBDSCBtYW51ZmFjdHVyaW5nIGEgZ2xvYmFsIHJlc2V0IGhhcyB0byBiZSBpbmR1Y2VkIGlu
IG9yZGVyIGZvcg0KPiA+IGNvbmZpZ3VyYXRpb24gY2hhbmdlcyB0YWtlIGFmZmVjdCB1cG9uIGZv
bGxvd2luZyBwbGF0Zm9ybSByZXNldC4NCj4gPiBUaGlzIHNldHRpbmcgd2FzIGNvbW1vbmx5IGRv
bmUgYnkgYWNjZXNzaW5nIFBNQyByZWdpc3RlcnMgdmlhIC9kZXYvbWVtDQo+ID4gYnV0IGR1ZSB0
byBzZWN1cml0eSBjb25jZXJuIC9kZXYvbWVtIGFjY2VzcyBpcyBtdWNoIHJlc3RyaWN0ZWQsIGhl
bmNlDQo+ID4gdGhlIHJlYXNvbiBmb3IgZXhwb3NpbmcgdGhpcyBzZXR0aW5nIHZpYSBkZWRpY2F0
ZWQgc3lzZnMgaW50ZXJmYWNlLg0KPiA+IFRvIHByZXZlbnQgcG9zdCBtYW51ZmFjdHVyaW5nIGFi
dXNlIHRoZSByZWdpc3RlciBpcyBwcm90ZWN0ZWQgYnkNCj4gPiBoYXJkd2FyZSBsb2NraW5nLg0K
PiANCj4gY291bGQgeW91IHBsZWFzZSBkZWZpbmUgIm1hbnVmYWN0dXJpbmciID8gVGhlIGNoaXAg
b3IgYm9hcmQgPw0KQm9hcmQNCj4gDQo+IElzIHRoZXJlIGFueSB1c2UgZm9yIHRoaXMsIGFmdGVy
IHRoZSBtYWNoaW5lIGxlZnQgdGhlIGZhY3RvcnkgPw0KDQpSZWZ1cmJpc2hpbmcsIG1vc3RseSwg
dGhlIHJlZ2lzdGVyIGlzIGh3IGxvY2tlZCBhZnRlciB0aGF0Lg0KDQo+IA0KPiANCj4gLS1tdHgN
Cj4gDQo+IC0tDQo+IC0tLQ0KPiBIaW53ZWlzOiB1bnZlcnNjaGzDvHNzZWx0ZSBFLU1haWxzIGvD
tm5uZW4gbGVpY2h0IGFiZ2Vow7ZydCB1bmQgbWFuaXB1bGllcnQNCj4gd2VyZGVuICEgRsO8ciBl
aW5lIHZlcnRyYXVsaWNoZSBLb21tdW5pa2F0aW9uIHNlbmRlbiBTaWUgYml0dGUgaWhyZW4NCj4g
R1BHL1BHUC1TY2hsw7xzc2VsIHp1Lg0KPiAtLS0NCj4gRW5yaWNvIFdlaWdlbHQsIG1ldHV4IElU
IGNvbnN1bHQNCj4gRnJlZSBzb2Z0d2FyZSBhbmQgTGludXggZW1iZWRkZWQgZW5naW5lZXJpbmcg
aW5mb0BtZXR1eC5uZXQgLS0gKzQ5LTE1MS0NCj4gMjc1NjUyODcNCg==
