Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421E7358940
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhDHQGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:06:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:14786 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231791AbhDHQGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:06:42 -0400
IronPort-SDR: yjMgLflof8+oeXmJekZrXeztLihzUGPkLXmMwoxkbvcVfA+enYkzoVA5ib6mbDYncSDWMKVc8q
 WHKHC2HKXIRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="257556225"
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="257556225"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 09:06:12 -0700
IronPort-SDR: Zxu39MFZ5xVlK8mdv1U81FsVCage3qyw9f6VIuKaxGhRrTjAGJkq51Qk/erDzNmGGG8Wa+NXVv
 9mYfmFTOxvSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="381774424"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 08 Apr 2021 09:06:11 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 8 Apr 2021 09:06:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 8 Apr 2021 09:06:10 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.013;
 Thu, 8 Apr 2021 09:06:10 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andy Lutomirski <luto@kernel.org>,
        Aili Yao <yaoaili@kingsoft.com>,
        =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKCDloIDlj6PjgIDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Subject: RE: [PATCH 4/4] x86/mce: Avoid infinite loop for copy from user
 recovery
Thread-Topic: [PATCH 4/4] x86/mce: Avoid infinite loop for copy from user
 recovery
Thread-Index: AQHXIdN9Uq2ZPuUUNUmBuOc9O6imO6qrKhCA//+g2gA=
Date:   Thu, 8 Apr 2021 16:06:10 +0000
Message-ID: <89a1b424a211459ab522c0d2c3e8fc98@intel.com>
References: <20210326000235.370514-1-tony.luck@intel.com>
 <20210326000235.370514-5-tony.luck@intel.com>
 <20210408133631.GJ10192@zn.tnic>
In-Reply-To: <20210408133631.GJ10192@zn.tnic>
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

PiBXaGF0IEknbSBzdGlsbCB1bmNsZWFyIG9uLCBkb2VzIHRoaXMgbmV3IHZlcnNpb24gYWRkcmVz
cyB0aGF0DQo+ICJteXN0ZXJpb3VzIiBoYW5nIG9yIHBhbmljIHdoaWNoIHRoZSB2YWxpZGF0aW9u
IHRlYW0gdHJpZ2dlcmVkIG9yIHlvdQ0KPiBoYXZlbid0IGNoZWNrZWQgeWV0Pw0KDQpObyA6LSgN
Cg0KVGhleSBhcmUgdHJpZ2dlcmluZyBzb21lIGNhc2Ugd2hlcmUgbXVsdGlwbGUgdGhyZWFkcyBp
biBhIHByb2Nlc3MgaGl0IHRoZSBzYW1lDQpwb2lzb24sIGFuZCBzb21laG93IG1lbW9yeV9mYWls
dXJlKCkgZmFpbHMgdG8gY29tcGxldGUgb2ZmbGluaW5nIHRoZSBwYWdlLiBBdCB0aGlzDQpwb2lu
dCBhbnkgb3RoZXIgdGhyZWFkcyB0aGF0IGhpdCB0aGF0IHBhZ2UgZ2V0IHRoZSBlYXJseSByZXR1
cm4gZnJvbSBtZW1vcnlfZmFpbHVyZQ0KKGJlY2F1c2UgdGhlIHBhZ2UgZmxhZ3Mgc2F5IGl0IGlz
IHBvaXNvbmVkKSAuLi4gYW5kIHNvIHdlIGxvb3AuDQoNCkJ1dCB0aGUgInJlY292ZXIgZnJvbSBj
YXNlcyB3aGVyZSBtdWx0aXBsZSBtYWNoaW5lIGNoZWNrcyBoYXBwZW4NCnNpbXVsdGFuZW91c2x5
IiBjYXNlIGlzIG9ydGhvZ29uYWwgdG8gdGhlICJkbyB0aGUgcmlnaHQgdGhpbmcgdG8gcmVjb3Zl
cg0Kd2hlbiB0aGUga2VybmVsIHRvdWNoZXMgcG9pc29uIGF0IGEgdXNlciBhZGRyZXNzIi4gU28g
SSB0aGluayB3ZSBjYW4NCnRhY2tsZSB0aGVtIHNlcGFyYXRlbHkNCg0KLVRvbnkNCg==
