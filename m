Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B577307211
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 09:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbhA1Ixw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 03:53:52 -0500
Received: from mga05.intel.com ([192.55.52.43]:64178 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231764AbhA1IxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 03:53:02 -0500
IronPort-SDR: b2WPtn1NadayqOMla39RaBQB9ufJ3FYSszIaFpGT1lll/uvCooDY/nmtn0hPqTrzNva1A7vCsT
 kGPa0eHz3t6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="265033694"
X-IronPort-AV: E=Sophos;i="5.79,381,1602572400"; 
   d="scan'208";a="265033694"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 00:53:46 -0800
IronPort-SDR: pDiClYaI8TQxzAsxx3AhxaWV7WWLTfGrYaWK+wq7J6qie6/9ikS/ptPDrLLCgdgsdrvepVgB68
 dQSTyJWrZuVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,381,1602572400"; 
   d="scan'208";a="410907392"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jan 2021 00:53:46 -0800
Received: from lcsmsx603.ger.corp.intel.com (10.109.210.12) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 28 Jan 2021 00:53:45 -0800
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 LCSMSX603.ger.corp.intel.com (10.109.210.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 28 Jan 2021 10:53:43 +0200
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Thu, 28 Jan 2021 10:53:43 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Richard Weinberger <richard@nod.at>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mtd: use refcount to prevent corruption
Thread-Topic: [PATCH] mtd: use refcount to prevent corruption
Thread-Index: AQHW9OeD00Da249Jw0qJn6+VIZAeUao7z7AAgAAh5BBxoBSOfPxzntFAEGBJdu//fSiMQA==
Date:   Thu, 28 Jan 2021 08:53:43 +0000
Message-ID: <f91d7eff1d764ba7b47f023bc0fafacb@intel.com>
References: <20210127200319.662842-1-tomas.winkler@intel.com>
 <9732911.325628.1611780400338.JavaMail.zimbra@nod.at>
 <c8d0f22c5fdf443cb8dda1f996b148d9@intel.com>
 <1776363776.325713.1611782270873.JavaMail.zimbra@nod.at>
 <a6cb6eb10bbb48989d3a9e087951e50e@intel.com>
 <1665542284.336646.1611820031174.JavaMail.zimbra@nod.at>
In-Reply-To: <1665542284.336646.1611820031174.JavaMail.zimbra@nod.at>
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

DQoNCj4gVG9tYXMsDQo+IA0KPiAtLS0tLSBVcnNwcsO8bmdsaWNoZSBNYWlsIC0tLS0tDQo+ID4+
ID4+IENhbiB5b3UgcGxlYXNlIGV4cGxhaW4gYSBsaXR0bGUgbW9yZSB3aGF0IGRldmljZXMgYXJl
IGludm9sdmVkPw0KPiA+PiA+PiBEb2VzIGl0IGltcGxlbWVudCBfZ2V0X2RldmljZSgpIGFuZCBf
cHV0X2RldmljZSgpPw0KPiA+PiA+IE5vIHRoaXMgaXMgbm90IGNvbm5lY3RlZCB0byB0aG9zZSBo
YW5kbGVycyBvZiB0aGUgdW5kZXJseWluZyBkZXZpY2UNCj4gPj4gPiBhbmQgdGhvc2Ugd29uJ3Qg
aGVscC4NCj4gPj4gPiBJIGhhdmUgYSBzcGkgZGV2aWNlIHByb3ZpZGVkIGJ5IE1GRCBmcmFtZXdv
cmsgc28gaXQgY2FuIGdvIGF3YXkgYW55dGltZS4NCj4gPj4NCj4gPj4gQ2FuIGl0IGdvIGF3YXkg
cGh5c2ljYWxseSBvciBqdXN0IGluIHNvZnR3YXJlPw0KPiA+IFNvZnR3YXJlLCBidXQgc2luY2Ug
dGhpcyBpcyBtZmQgaXQncyBiYXNpY2FsbHkgaG90cGx1Zy4gVGhlIGtlcm5lbCBpcw0KPiA+IGNy
YXNoaW5nIHdoZW4gSSBzaW11bGF0ZSBoYXJkd2FyZSBmYWlsdXJlLg0KPiA+Pg0KPiA+PiBVc3Vh
bGx5IHRoZSBwYXR0ZXJuIGlzIHRoYXQgeW91IG1ha2Ugc3VyZSBpbiB0aGUgZGV2aWNlIGRyaXZl
ciB0aGF0DQo+ID4+IG5vYm9keSBjYW4gb3JwaGFuIHRoZSBNVEQgd2hpbGUgaXQgaXMgaW4gdXNl
Lg0KPiA+PiBlLmcuIGRyaXZlcnMvbXRkL3ViaS9nbHVlYmkuYyBkb2VzIHNvLiBJbiBfZ2V0X2Rl
dmljZSgpIGl0IGdyYWJzIGENCj4gPj4gcmVmZXJlbmNlIG9uIHRoZSB1bmRlcmx5aW5nIFVCSSB2
b2x1bWUgdG8gbWFrZSBzdXJlIGl0IGNhbm5vdCBnbyBhd2F5DQo+ID4+IHdoaWxlIHRoZSBNVEQg
KG9uIHRvcCBvZiBVQkkpIGlzIGluIHVzZS4NCj4gPg0KPiA+IEkgY2FuIHRyeSB0aGF0IGlmIGl0
IGhlbHBzLCBiZWNhdXNlIHdlIGFyZSBzaW11bGF0aW5nIHBvc3NpYmxlIGxvd2VyDQo+ID4gbGV2
ZWwgY3Jhc2guDQo+ID4gSW4gYW4gY2FzZSBJIGJlbGlldmUgdGhhdCB0aGUgcHJvcGVyIHJlZmNv
dXRpbmcgaXMgbXVjaCBtb3JlIHJvYnVzdA0KPiA+IHNvbHV0aW9uLCB0aGFuIHRoZSBjdXJyZW50
IG9uZS4NCj4gPiBJJ2QgYXBwcmVjaWF0ZSBpZiBzb21lb25lIGNhbiByZXZpZXcgdGhlIGFjdHVh
bCBpbXBsZW1lbnRhdGlvbi4NCj4gDQo+IFRoaXMgaGFwcGVucyByaWdodCBub3csIEkgdHJ5IHRv
IHVuZGVyc3RhbmQgd2h5IGV4YWN0bHkgdGhlIGN1cnJlbnQgd2F5IGlzIG5vdA0KPiBnb29kIGlu
IGVub3VnaC4gOi0pDQo+IA0KPiBZb3VyIGFwcHJvYWNoIG1ha2VzIHN1cmUgdGhhdCB0aGUgTVRE
IGl0c2VsZiBkb2VzIG5vdCBnbyBhd2F5IHdoaWxlIGl0IGhhcw0KPiB1c2VycyBidXQgaG93IGRv
ZXMgdGhpcyBoZWxwIGluIHRoZSBjYXNlIHdoZXJlIHRoZSB1bmRlcmx5aW5nIE1GRCBqdXN0DQo+
IHZhbmlzaGVzPw0KPiBUaGUgTVREIGNhbiBiZSBpbiB1c2UgYW5kIHRoZSBNRkQgY2FuIGdvIGF3
YXkgd2hpbGUgZS5nLiBtdGRfcmVhZCgpIG9yIHN1Y2gNCj4gdGFrZXMgcGxhY2UuDQoNClJlYWQg
d2lsbCBmYWlsLCBidXQga2VybmVsIHdvbid0IGNyYXNoIG9uIGFjY2VzcyB0byBtZW1vcnkgdGhh
dCB3YXMgZnJlZWQuDQoNClRoYW5rcw0KVG9tYXMNCg0KDQo=
