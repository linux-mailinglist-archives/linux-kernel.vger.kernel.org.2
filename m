Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52350403E10
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 19:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352353AbhIHRDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 13:03:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:57948 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235666AbhIHRDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 13:03:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="200072744"
X-IronPort-AV: E=Sophos;i="5.85,278,1624345200"; 
   d="scan'208";a="200072744"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 10:01:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,278,1624345200"; 
   d="scan'208";a="449502850"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga002.jf.intel.com with ESMTP; 08 Sep 2021 10:01:40 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 8 Sep 2021 10:01:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 8 Sep 2021 10:01:40 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.012;
 Wed, 8 Sep 2021 10:01:39 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: RE: [patch V3 00/20] x86/fpu: Clean up exception fixups and error
 handling in sigframe related code
Thread-Topic: [patch V3 00/20] x86/fpu: Clean up exception fixups and error
 handling in sigframe related code
Thread-Index: AQHXpLWNMIIy4Yr8BEe0tJ9JqpTQzauaSlHwgAAOdyA=
Date:   Wed, 8 Sep 2021 17:01:39 +0000
Message-ID: <f5d9412b0de4410084b4b8d111784b13@intel.com>
References: <20210908130922.118265849@linutronix.de>
 <5621f6055ca641d89c0cd05c91f8b06c@intel.com>
In-Reply-To: <5621f6055ca641d89c0cd05c91f8b06c@intel.com>
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

PiBNdWNoIGJldHRlci4gVGhpcyB2ZXJzaW9uIGJvb3RzLiAgTWFjaGluZSBjaGVjayByZWNvdmVy
eSB3b3JrcyBhcyB3ZWxsIGFzIGl0IGRpZCBiZWZvcmUNCj4gKHVzZXIgdHJpZ2dlcmVkIG1hY2hp
bmUgY2hlY2tzIGFyZSBmaW5lLCBrZXJuZWwgdHJpZ2dlcmVkIG9uZXMgYXJlIG9rIHdoZXJlIHRo
ZXkgd2VyZQ0KPiBiZWZvcmUgYW5kIHN0aWxsIHRyaWdnZXIgaW5maW5pdGUgbG9vcHMgd2hlcmUg
dGhleSBkaWQgYmVmb3JlKS4NCg0KV2l0aCB0aGVzZSB0aHJlZSBwYXRjaGVzOg0KDQpodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMTA4MTgwMDI5NDIuMTYwNzU0NC0xLXRvbnkubHVja0Bp
bnRlbC5jb20vDQoNCm9uIHRvcCBvZiB5b3VyIHNlcmllcyB0aGUgaW5maW5pdGUgbG9vcHMgYXJl
IGZpeGVkIChmaXJzdCBwYXRjaCkuDQoNCk90aGVyIHR3byBwYXRjaGVzIGZpeCBteSB3cml0ZSgy
KSB0ZXN0IHdoaWNoIGRvZXM6DQoNCglyZXQgPSB3cml0ZShmZCwgYnVmLCA1MTIpOw0KDQpXaGVy
ZSBJIGhhdmUgaW5qZWN0ZWQgcG9pc29uIGF0IHNvbWUgb2Zmc2V0IHdpdGhpbiAiYnVmIi4NCg0K
SWYgdGhlIHBvaXNvbiBpcyBhdCB0aGUgc3RhcnQgb2YgYnVmIEkgZ2V0IHJldCA9PSAtMSB3aXRo
IGVycm5vID09IC1FRkFVTFQuDQpJZiB0aGUgcG9pc29uIGlzIGF0IGEgbm9uLXplcm8gb2Zmc2V0
LCB0aGUgdGhlIGJ5dGVzIHVwIHRvIHRoZSBwb2lzb24NCmFyZSB3cml0dGVuIHRvIHRoZSBmaWxl
IGFuZCAicmV0IiB0ZWxscyB5b3UgaG93IG1hbnkgd2VyZSB3cml0dGVuLg0KDQotVG9ueSANCg==
