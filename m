Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3563EB763
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 17:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241096AbhHMPHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 11:07:50 -0400
Received: from mga17.intel.com ([192.55.52.151]:55411 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240849AbhHMPHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 11:07:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10075"; a="195842836"
X-IronPort-AV: E=Sophos;i="5.84,319,1620716400"; 
   d="scan'208";a="195842836"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 08:07:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,319,1620716400"; 
   d="scan'208";a="440385639"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga002.jf.intel.com with ESMTP; 13 Aug 2021 08:07:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 13 Aug 2021 08:07:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 13 Aug 2021 08:07:20 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.010;
 Fri, 13 Aug 2021 08:07:20 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
CC:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 1/2] mm,hwpoison: fix race with hugetlb page allocation
Thread-Topic: [PATCH v6 1/2] mm,hwpoison: fix race with hugetlb page
 allocation
Thread-Index: AQHXjzJ4oLpdbdbIlE+0uuWADomvDqtwCKsA///1mwCAAXHrgIAAFrKw
Date:   Fri, 13 Aug 2021 15:07:20 +0000
Message-ID: <96d4fd8b75e44a6c970e4d9530980f21@intel.com>
References: <20210603233632.2964832-1-nao.horiguchi@gmail.com>
 <20210603233632.2964832-2-nao.horiguchi@gmail.com>
 <20210812042813.GA1576603@agluck-desk2.amr.corp.intel.com>
 <20210812090303.GA153531@hori.linux.bs1.fc.nec.co.jp>
 <20210812152548.GA1579021@agluck-desk2.amr.corp.intel.com>
 <20210813062951.GA203438@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20210813062951.GA203438@hori.linux.bs1.fc.nec.co.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSdtIHJ1bm5pbmcgdGhlIGRlZmF1bHQgY2FzZSBmcm9tIG15IGVpbmpfbWVtX3VjIHRlc3QuIFRo
YXQganVzdDoNCg0KMSkgYWxsb2NhdGVzIGEgcGFnZSB1c2luZzoNCg0KCW1tYXAoTlVMTCwgcGFn
ZXNpemUsIFBST1RfUkVBRHxQUk9UX1dSSVRFLCBNQVBfU0hBUkVEfE1BUF9BTk9OLCAtMSwgMCk7
DQoNCjIpIGZpbGxzIHRoZSBwYWdlIHdpdGggcmFuZG9tIGRhdGEgKHRvIG1ha2Ugc3VyZSBpdCBo
YXMgYmVlbiBhbGxvY2F0ZWQsIGFuZCB0aGF0IHRoZSBrZXJuZWwgY2FuJ3QNCmRvIEtTTSB0cmlj
a3MgdG8gc2hhcmUgdGhpcyBwaHlzaWNhbCBwYWdlIHdpdGggc29tZSBvdGhlciB1c2VyKS4NCg0K
MykgaW5qZWN0cyB0aGUgZXJyb3IgYXQgYSAxS0Igb2Zmc2V0IHdpdGhpbiB0aGUgcGFnZS4NCg0K
NCkgZG9lcyBhIG1lbW9yeSByZWFkIG9mIHRoZSBwb2lzb24gYWRkcmVzcy4NCg0KDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGFjdGlvbl9yZXN1bHQocGZuLCBNRl9NU0dfVU5LTk9XTiwg
TUZfSUdOT1JFRCk7DQo+ICAgKyAgICAgICAgICAgICAgICAgICAgICAgZHVtcF9wYWdlKHAsICJo
d3BvaXNvbiB1bmtub3duIHBhZ2UiKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVz
ID0gLUVCVVNZOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIHVubG9ja19tdXRl
eDsNCj4gICAgICAgICAgICAgICAgICAgIH0NCg0KSSBhZGRlZCB0aGF0IHBhdGNoIGFnYWluc3Qg
dXBzdHJlYW0gKHY1LjE0LXJjNSkuICBIZXJlJ3MgdGhlIGR1bXAuIFRoZSAicGZuIiBtYXRjaGVz
IHRoZSBwaHlzaWNhbCBhZGRyZXNzIHdoZXJlIEkgaW5qZWN0ZWQsDQphbmQgaXQgaGFzIHRoZSBo
d3BvaXNvbiBmbGFnIGJpdCB0aGF0IHdhcyBzZXQgZWFybHkgaW4gbWVtb3J5X2ZhaWx1cmUoKSAt
LS0gc28gdGhpcyBpcyB0aGUgcmlnaHQgcGFnZS4NCg0KWyAgIDc5LjM2ODIxMl0gTWVtb3J5IGZh
aWx1cmU6IDB4NjIzODg5OiByZWNvdmVyeSBhY3Rpb24gZm9yIHVua25vd24gcGFnZTogSWdub3Jl
ZA0KWyAgIDc5LjM3NTUyNV0gcGFnZTowMDAwMDAwMDY1YWQ5NDc5IHJlZmNvdW50OjMgbWFwY291
bnQ6MSBtYXBwaW5nOjAwMDAwMDAwYTRhYzg0M2IgaW5kZXg6MHgwIHBmbjoweDYyMzg4OQ0KWyAg
IDc5LjM4NDkwOV0gbWVtY2c6ZmY0MGE1NjlmMjk2NjAwMA0KWyAgIDc5LjM4ODMxM10gYW9wczpz
aG1lbV9hb3BzIGlubzo0YzAwIGRlbnRyeSBuYW1lOiJkZXYvemVybyINClsgICA3OS4zOTM4OTZd
IGZsYWdzOiAweDE3ZmZmZmMwODgwMDBjKHVwdG9kYXRlfGRpcnR5fHN3YXBiYWNrZWR8aHdwb2lz
b258bm9kZT0wfHpvbmU9MnxsYXN0Y3B1cGlkPTB4MWZmZmZmKQ0KWyAgIDc5LjQwMzQ1NV0gcmF3
OiAwMDE3ZmZmZmMwODgwMDBjIDAwMDAwMDAwMDAwMDAwMDAgZGVhZDAwMDAwMDAwMDEyMiBmZjQw
YTU2OWY0NWE3MTYwDQpbICAgNzkuNDExMTkxXSByYXc6IDAwMDAwMDAwMDAwMDAwMDAgMDAwMDAw
MDAwMDAwMDAwMCAwMDAwMDAwMzAwMDAwMDAwIGZmNDBhNTY5ZjI5NjYwMDANClsgICA3OS40MTg5
MzFdIHBhZ2UgZHVtcGVkIGJlY2F1c2U6IGh3cG9pc29uIHVua25vd24gcGFnZQ0KDQoNCi1Ub255
DQo=
