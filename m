Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10595306581
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 22:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbhA0U5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 15:57:05 -0500
Received: from mga18.intel.com ([134.134.136.126]:31611 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232167AbhA0U4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 15:56:33 -0500
IronPort-SDR: Vo/GB3taxr8Ip6pnyZupQEQsl7XfOAd4DOuKFf+/yNbJIO52YjCl7ENGuyLhNke8f9XqAAHIH9
 cu7+GmnP8owg==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="167806445"
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="167806445"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 12:55:50 -0800
IronPort-SDR: eW5aSob8dr7nNZZVReNYejFMh4C48yxCIyvU2fUPjjMh4fvPhuQmxcG8zIpgOM5Kpq70iNSxRW
 p6Mp/TABIr/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="351128700"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 27 Jan 2021 12:55:49 -0800
Received: from lcsmsx602.ger.corp.intel.com (10.109.210.11) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 27 Jan 2021 12:55:48 -0800
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 LCSMSX602.ger.corp.intel.com (10.109.210.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 27 Jan 2021 22:55:47 +0200
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Wed, 27 Jan 2021 22:55:46 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Richard Weinberger <richard@nod.at>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mtd: use refcount to prevent corruption
Thread-Topic: [PATCH] mtd: use refcount to prevent corruption
Thread-Index: AQHW9OeD00Da249Jw0qJn6+VIZAeUao7z7AAgAAh5BA=
Date:   Wed, 27 Jan 2021 20:55:46 +0000
Message-ID: <c8d0f22c5fdf443cb8dda1f996b148d9@intel.com>
References: <20210127200319.662842-1-tomas.winkler@intel.com>
 <9732911.325628.1611780400338.JavaMail.zimbra@nod.at>
In-Reply-To: <9732911.325628.1611780400338.JavaMail.zimbra@nod.at>
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

DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIG10ZDogdXNlIHJlZmNvdW50IHRvIHByZXZlbnQgY29y
cnVwdGlvbg0KPiANCj4gVG9tYXMsDQo+IA0KPiAtLS0tLSBVcnNwcsO8bmdsaWNoZSBNYWlsIC0t
LS0tDQo+ID4gVm9uOiAiVG9tYXMgV2lua2xlciIgPHRvbWFzLndpbmtsZXJAaW50ZWwuY29tPg0K
PiA+IEFuOiAiTWlxdWVsIFJheW5hbCIgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+LCAicmlj
aGFyZCINCj4gPiA8cmljaGFyZEBub2QuYXQ+LCAiVmlnbmVzaCBSYWdoYXZlbmRyYSIgPHZpZ25l
c2hyQHRpLmNvbT4sICJsaW51eC1tdGQiDQo+ID4gPGxpbnV4LW10ZEBsaXN0cy5pbmZyYWRlYWQu
b3JnPiwgImxpbnV4LWtlcm5lbCINCj4gPiA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4N
Cj4gPiBDQzogIlRvbWFzIFdpbmtsZXIiIDx0b21hcy53aW5rbGVyQGludGVsLmNvbT4NCj4gPiBH
ZXNlbmRldDogTWl0dHdvY2gsIDI3LiBKYW51YXIgMjAyMSAyMTowMzoxOQ0KPiA+IEJldHJlZmY6
IFtQQVRDSF0gbXRkOiB1c2UgcmVmY291bnQgdG8gcHJldmVudCBjb3JydXB0aW9uDQo+IA0KPiA+
IFdoZW4gdW5kZXJseWluZyBkZXZpY2UgaXMgcmVtb3ZlZCBtdGQgY29yZSB3aWxsIGNyYXNoIGlu
IGNhc2UgdXNlcg0KPiA+IHNwYWNlIGlzIHN0aWxsIGhvbGRpbmcgYW4gb3BlbiBoYW5kbGUgdG8g
YSBtdGQgZGV2aWNlIG5vZGUuDQo+ID4gQSBwcm9wZXIgcmVmY291bnRpbmcgaXMgbmVlZGVkIHNv
IGRldmljZSBpcyByZWxlYXNlIG9ubHkgd2hlbiBhDQo+ID4gcGFydGl0aW9uIGhhcyBubyBhY3Rp
dmUgdXNlcnMuIFRoZSBjdXJyZW50IHNpbXBsZSBjb3VudGVyIGlzIG5vdA0KPiA+IHN1ZmZpY2ll
bnQuDQo+IA0KPiBDYW4geW91IHBsZWFzZSBleHBsYWluIGEgbGl0dGxlIG1vcmUgd2hhdCBkZXZp
Y2VzIGFyZSBpbnZvbHZlZD8NCj4gRG9lcyBpdCBpbXBsZW1lbnQgX2dldF9kZXZpY2UoKSBhbmQg
X3B1dF9kZXZpY2UoKT8NCk5vIHRoaXMgaXMgbm90IGNvbm5lY3RlZCB0byB0aG9zZSBoYW5kbGVy
cyBvZiB0aGUgdW5kZXJseWluZyBkZXZpY2UgYW5kIHRob3NlIHdvbid0IGhlbHAuIA0KSSBoYXZl
IGEgc3BpIGRldmljZSBwcm92aWRlZCBieSBNRkQgZnJhbWV3b3JrIHNvIGl0IGNhbiBnbyBhd2F5
IGFueXRpbWUuIA0KTXkgc29sdXRpb24gdHJpZXMgdG8gIHJlcGxhY2UgdGhlIGN1cnJlbnQgc2lt
cGxlIHBhcnRpdGlvbiByZWZlcmVuY2UgY291bnRpbmcuICBJbiBwcmV2aW91cyBzb2x1dGlvbiBp
dCB3aWxsIHJldHVybiAtRUJVU1kgb24gcGFydGl0aW9uIHRoYXQgaXMgaGVsZCBidXQgd2lsbCBy
ZW1vdmUgdGhlIGFjdHVhbCBwYXJlbnQgZGV2aWNlLCBsZWFkaW5nIHRvIGNyYXNoLg0KQWxzbyB3
L28gcmVmZXJlbmNlIGNvdW50aW5nIHRoZXJlIGlzIG5vIHByb2Nlc3MgdG8gYWN0dWFsbHkgcmVt
b3ZlIHRoZSBwYXJ0aXRpb24gdGhhdCB3YXMgcHJldmlvdXNseSBidXN5Lg0KDQpUaGFua3MNClRv
bWFzDQoNCg0KDQo+IA0KPiBUaGFua3MsDQo+IC8vcmljaGFyZA0K
