Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B832306DA7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 07:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhA1Gec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 01:34:32 -0500
Received: from mga06.intel.com ([134.134.136.31]:64772 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229785AbhA1Geb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 01:34:31 -0500
IronPort-SDR: t7pGZuJZZrGj1rHFX+90i69wbK/yci8qv09lfnUeO/nZFb/Ob3s1j0SM/B0wZL8VtcpyJovLOO
 knXnphN7lfrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="241714346"
X-IronPort-AV: E=Sophos;i="5.79,381,1602572400"; 
   d="scan'208";a="241714346"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:33:50 -0800
IronPort-SDR: l+tRUQI/DhisSjVUdEcootSuETTPJUR3+HNQC3fCUbAzmTztf1oDip2R11hPCeoajwpETZ2XFn
 4ouf1ZYNdvZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,381,1602572400"; 
   d="scan'208";a="407414005"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jan 2021 22:33:50 -0800
Received: from lcsmsx602.ger.corp.intel.com (10.109.210.11) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 27 Jan 2021 22:33:49 -0800
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 LCSMSX602.ger.corp.intel.com (10.109.210.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 28 Jan 2021 08:33:47 +0200
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Thu, 28 Jan 2021 08:33:47 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Richard Weinberger <richard@nod.at>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mtd: use refcount to prevent corruption
Thread-Topic: [PATCH] mtd: use refcount to prevent corruption
Thread-Index: AQHW9OeD00Da249Jw0qJn6+VIZAeUao7z7AAgAAh5BBxoBSOfPxzntFA
Date:   Thu, 28 Jan 2021 06:33:47 +0000
Message-ID: <a6cb6eb10bbb48989d3a9e087951e50e@intel.com>
References: <20210127200319.662842-1-tomas.winkler@intel.com>
 <9732911.325628.1611780400338.JavaMail.zimbra@nod.at>
 <c8d0f22c5fdf443cb8dda1f996b148d9@intel.com>
 <1776363776.325713.1611782270873.JavaMail.zimbra@nod.at>
In-Reply-To: <1776363776.325713.1611782270873.JavaMail.zimbra@nod.at>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IA0KPiAtLS0tLSBVcnNwcsO8bmdsaWNoZSBNYWlsIC0tLS0tDQo+ID4+ID4gV2hlbiB1bmRl
cmx5aW5nIGRldmljZSBpcyByZW1vdmVkIG10ZCBjb3JlIHdpbGwgY3Jhc2ggaW4gY2FzZSB1c2Vy
DQo+ID4+ID4gc3BhY2UgaXMgc3RpbGwgaG9sZGluZyBhbiBvcGVuIGhhbmRsZSB0byBhIG10ZCBk
ZXZpY2Ugbm9kZS4NCj4gPj4gPiBBIHByb3BlciByZWZjb3VudGluZyBpcyBuZWVkZWQgc28gZGV2
aWNlIGlzIHJlbGVhc2Ugb25seSB3aGVuIGENCj4gPj4gPiBwYXJ0aXRpb24gaGFzIG5vIGFjdGl2
ZSB1c2Vycy4gVGhlIGN1cnJlbnQgc2ltcGxlIGNvdW50ZXIgaXMgbm90DQo+ID4+ID4gc3VmZmlj
aWVudC4NCj4gPj4NCj4gPj4gQ2FuIHlvdSBwbGVhc2UgZXhwbGFpbiBhIGxpdHRsZSBtb3JlIHdo
YXQgZGV2aWNlcyBhcmUgaW52b2x2ZWQ/DQo+ID4+IERvZXMgaXQgaW1wbGVtZW50IF9nZXRfZGV2
aWNlKCkgYW5kIF9wdXRfZGV2aWNlKCk/DQo+ID4gTm8gdGhpcyBpcyBub3QgY29ubmVjdGVkIHRv
IHRob3NlIGhhbmRsZXJzIG9mIHRoZSB1bmRlcmx5aW5nIGRldmljZQ0KPiA+IGFuZCB0aG9zZSB3
b24ndCBoZWxwLg0KPiA+IEkgaGF2ZSBhIHNwaSBkZXZpY2UgcHJvdmlkZWQgYnkgTUZEIGZyYW1l
d29yayBzbyBpdCBjYW4gZ28gYXdheSBhbnl0aW1lLg0KPiANCj4gQ2FuIGl0IGdvIGF3YXkgcGh5
c2ljYWxseSBvciBqdXN0IGluIHNvZnR3YXJlPw0KU29mdHdhcmUsIGJ1dCBzaW5jZSB0aGlzIGlz
IG1mZCBpdCdzIGJhc2ljYWxseSBob3RwbHVnLiBUaGUga2VybmVsIGlzIGNyYXNoaW5nIHdoZW4g
SSBzaW11bGF0ZSBoYXJkd2FyZSBmYWlsdXJlLg0KPiANCj4gVXN1YWxseSB0aGUgcGF0dGVybiBp
cyB0aGF0IHlvdSBtYWtlIHN1cmUgaW4gdGhlIGRldmljZSBkcml2ZXIgdGhhdCBub2JvZHkgY2Fu
DQo+IG9ycGhhbiB0aGUgTVREIHdoaWxlIGl0IGlzIGluIHVzZS4NCj4gZS5nLiBkcml2ZXJzL210
ZC91YmkvZ2x1ZWJpLmMgZG9lcyBzby4gSW4gX2dldF9kZXZpY2UoKSBpdCBncmFicyBhIHJlZmVy
ZW5jZSBvbg0KPiB0aGUgdW5kZXJseWluZyBVQkkgdm9sdW1lIHRvIG1ha2Ugc3VyZSBpdCBjYW5u
b3QgZ28gYXdheSB3aGlsZSB0aGUgTVREIChvbg0KPiB0b3Agb2YgVUJJKSBpcyBpbiB1c2UuDQoN
CkkgY2FuIHRyeSB0aGF0IGlmIGl0IGhlbHBzLCBiZWNhdXNlIHdlIGFyZSBzaW11bGF0aW5nIHBv
c3NpYmxlIGxvd2VyIGxldmVsIGNyYXNoLiANCkluIGFuIGNhc2UgSSBiZWxpZXZlIHRoYXQgdGhl
IHByb3BlciByZWZjb3V0aW5nIGlzIG11Y2ggbW9yZSByb2J1c3Qgc29sdXRpb24sIHRoYW4gdGhl
IGN1cnJlbnQgb25lLg0KSSdkIGFwcHJlY2lhdGUgaWYgc29tZW9uZSBjYW4gcmV2aWV3IHRoZSBh
Y3R1YWwgaW1wbGVtZW50YXRpb24uIA0KDQpUaGFua3MNClRvbWFzDQoNCg==
