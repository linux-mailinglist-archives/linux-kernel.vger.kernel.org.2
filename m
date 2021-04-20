Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824DF365E58
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 19:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbhDTRQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 13:16:57 -0400
Received: from mga17.intel.com ([192.55.52.151]:3722 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233384AbhDTRQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 13:16:51 -0400
IronPort-SDR: lLbvsdnGu/mr5ZaHRGLoKwpmAR0q0abgxvF1eXrWexVaS79e4UsZLiq1JgHznGlF24Dptt0ikF
 C/m9xsT+x75g==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="175654744"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="175654744"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 10:15:59 -0700
IronPort-SDR: JC2WjAdARMdudZdAfhpx7XMTWO8cD03xYrjszBdStg1Wd0hKtTkRRastDdOANUv1J27aWCnny6
 tVUJXyhQZEIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="420540926"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga008.fm.intel.com with ESMTP; 20 Apr 2021 10:15:59 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 20 Apr 2021 10:15:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 20 Apr 2021 10:15:58 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.013;
 Tue, 20 Apr 2021 10:15:58 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Jue Wang <juew@google.com>
CC:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        "david@redhat.com" <david@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "luto@kernel.org" <luto@kernel.org>,
        =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        "yaoaili@kingsoft.com" <yaoaili@kingsoft.com>
Subject: RE: [PATCH v1 3/3] mm,hwpoison: add kill_accessing_process() to find
 error virtual address
Thread-Topic: [PATCH v1 3/3] mm,hwpoison: add kill_accessing_process() to find
 error virtual address
Thread-Index: AQHXNYlKy8Wo/vG6R0yHUmvh3EYC7Kq9jeAAgACBdAD//5UC0A==
Date:   Tue, 20 Apr 2021 17:15:58 +0000
Message-ID: <e79166a5455c4dfb8bffcf2a6926f773@intel.com>
References: <CAPcxDJ5gH9XvZ1bMsRqqU8bTpGLsz75+pWMnj52b-nMZHKhdtQ@mail.gmail.com>
 <20210420154730.GA577592@agluck-desk2.amr.corp.intel.com>
 <CAPcxDJ6bPH4TSO44RpPSU2EqjmBaWOf88JMfYKdiFYe755Dzug@mail.gmail.com>
In-Reply-To: <CAPcxDJ6bPH4TSO44RpPSU2EqjmBaWOf88JMfYKdiFYe755Dzug@mail.gmail.com>
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

PiBJIG1lYW50IGluIHRoaXMgY2FzZSAocmFjaW5nIHRvIGFjY2VzcyB0aGUgc2FtZSBwb2lzb25l
ZCBwYWdlcyksIHRoZQ0KPiBwYWdlIG1hcHBpbmcgc2hvdWxkIGhhdmUgYmVlbiByZW1vdmVkIGJ5
IGFuZCB0aGUgaHdwb2lzb24gc3dhcCBwdGUNCj4gaW5zdGFsbGVkIGJ5IHRoZSB3aW5uZXIgdGhy
ZWFkPw0KDQpNeSAibXV0ZXgiIHBhdGNoIHRoYXQgSG9yaWd1Y2hpLXNhbiBoYXMgaW5jbHVkZWQg
aGlzIHN1bW1hcnkgc2VyaWVzIHNob3VsZA0KbWFrZSB0aGlzIGhhcHBlbiBpbiBtb3N0IGNhc2Vz
LiBPbmx5IHByb2JsZW0gaXMgaWYgdGhlIGZpcnN0IHRocmVhZCBydW5zIGludG8gc29tZQ0KZXJy
b3IgYW5kIGRvZXMgbm90IGNvbXBsZXRlIHVubWFwcGluZyB0aGUgcG9pc29uIHBhZ2UgZnJvbSBh
bGwgb3RoZXIgdGFza3MuDQoNClNvIHRoZSBiYWNrdXAgcGxhbiBpcyB0byBzY2FuIHRoZSBwYWdl
IHRhYmxlcy4NCg0KPj4gV2VsbCwgSSBkaWQgdHJ5IGEgcGF0Y2ggdGhhdCByZW1vdmVkICphbGwq
IHVzZXIgbWFwcGluZ3MgKHN3aXRjaGVkIENSMyB0bw0KPj4gc3dhcHBlcl9wZ2RpcikgYW5kIHJl
dHVybmVkIHRvIHVzZXIuIFRoZW4gaGF2ZSB0aGUgcmVzdWx0aW5nIHBhZ2UgZmF1bHQNCj4+IHJl
cG9ydCB0aGUgYWRkcmVzcy4gQnV0IHRoYXQgZGlkbid0IHdvcmsgdmVyeSB3ZWxsLg0KPiBDdXJp
b3VzIHdoYXQgZGlkbid0IHdvcmsgd2VsbCBpbiB0aGlzIGNhc2U/IDotKQ0KDQpBbmR5IEx1dG9t
aXJza2kgd2Fzbid0IGhhcHB5IHdpdGggdGhlIGFwcHJvYWNoLiBJdCB3YXMgc3BlY2lmaWNhbGx5
DQp0byBjb3ZlciB0aGUgImtlcm5lbCBhY2Nlc3NlcyBwb2lzb24gbW9yZSB0aGFuIG9uY2UgZnJv
bSBnZXRfdXNlcigpIi4NCg0KSXQgZG9lc24ndCBnZW5lcmFsaXplIHRvIHRoZSBjYXNlIHdoZXJl
IHRoZSB1c2VyIGFjY2Vzc2VkIHRoZSBwb2lzb24gKGJlY2F1c2UNCnlvdSdsbCBqdXN0IHRha2Ug
dGhlICNQRiBvbiB0aGUgaW5zdHJ1Y3Rpb24gZmV0Y2ggLi4uIGV2ZXJ5dGhpbmcgaXMgdW5tYXBw
ZWQgLi4uDQppbnN0ZWFkIG9mIG9uIHRoZSBvcmlnaW5hbCBkYXRhIGFjY2VzcykuDQoNCi1Ub255
DQoNCg==
