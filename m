Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5A935E3B4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 18:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243769AbhDMQVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 12:21:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:50746 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243617AbhDMQVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 12:21:43 -0400
IronPort-SDR: vDGbHZqvdumhyllk8hPbLu5kZNRWOKNlWBTW6LTLXo92JlMifG0a0jc9VFZ4cilPaOgTexDrK5
 ceSzNy30YXJQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="174548200"
X-IronPort-AV: E=Sophos;i="5.82,219,1613462400"; 
   d="scan'208";a="174548200"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 09:13:05 -0700
IronPort-SDR: 1pO1hJaf8WINRL4wbzdxmyH32S+GgXOczS4j9m4/wM9SwmUlTFBg3ogbHz4fddrBKoZrsmjX49
 b1BCNxTidZfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,219,1613462400"; 
   d="scan'208";a="443484427"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 13 Apr 2021 09:13:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 13 Apr 2021 09:13:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 13 Apr 2021 09:13:03 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.013;
 Tue, 13 Apr 2021 09:13:03 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andy Lutomirski <luto@kernel.org>,
        Aili Yao <yaoaili@kingsoft.com>,
        =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKCDloIDlj6PjgIDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Subject: RE: [PATCH 3/4] mce/copyin: fix to not SIGBUS when copying from user
 hits poison
Thread-Topic: [PATCH 3/4] mce/copyin: fix to not SIGBUS when copying from user
 hits poison
Thread-Index: AQHXIdNZ5cXe1TMEnUGYFh4Lw8pmVKqqGL4A//+RoICAAS+iAIAAFhAAgAfbOAD//+zj8A==
Date:   Tue, 13 Apr 2021 16:13:03 +0000
Message-ID: <bd3dbae888584ce58a8d6e4b549b29ce@intel.com>
References: <20210326000235.370514-1-tony.luck@intel.com>
 <20210326000235.370514-4-tony.luck@intel.com>
 <20210407211816.GP25319@zn.tnic>
 <20210407214310.GA479383@agluck-desk2.amr.corp.intel.com>
 <20210408084958.GC10192@zn.tnic>
 <20210408170852.GA485019@agluck-desk2.amr.corp.intel.com>
 <20210413100722.GC16519@zn.tnic>
In-Reply-To: <20210413100722.GC16519@zn.tnic>
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

PiBTbyB3aGF0IEknbSBtaXNzaW5nIHdpdGggYWxsIHRoaXMgZnVuIGlzLCB5ZWFoLCBzdXJlLCB3
ZSBoYXZlIHRoaXMNCj4gZmFjaWxpdHkgb3V0IHRoZXJlIGJ1dCB3aG8ncyB1c2luZyBpdD8gSXMg
YW55b25lIGV2ZW4gdXNpbmcgaXQgYXQgYWxsPw0KDQpFdmVuIGlmIG5vIGFwcGxpY2F0aW9ucyBl
dmVyIGRvIGFueXRoaW5nIHdpdGggaXQsIGl0IGlzIHN0aWxsIHVzZWZ1bCB0byBhdm9pZA0KY3Jh
c2hpbmcgdGhlIHdob2xlIHN5c3RlbSBhbmQganVzdCB0ZXJtaW5hdGUgb25lIGFwcGxpY2F0aW9u
L2d1ZXN0Lg0KDQo+IElmIHNvLCBkb2VzIGl0IGV2ZW4gbWFrZSBzZW5zZSwgZG9lcyBpdCBuZWVk
IGltcHJvdmVtZW50cywgZXRjPw0KDQpUaGVyZSdzIG9uZSBtb3JlIGl0ZW0gb24gbXkgbG9uZyB0
ZXJtIFRPRE8gbGlzdC4gQWRkIGZpeHVwcyBzbyB0aGF0DQpjb3B5X3RvX3VzZXIoKSBmcm9tIHBv
aXNvbiBpbiB0aGUgcGFnZSBjYWNoZSBkb2Vzbid0IGNyYXNoLCBidXQganVzdA0KY2hlY2tzIHRv
IHNlZSBpZiB0aGUgcGFnZSB3YXMgY2xlYW4gLi4gLmluIHdoaWNoIGNhc2UgcmUtcmVhZCBmcm9t
IHRoZQ0KZmlsZXN5c3RlbSBpbnRvIGEgZGlmZmVyZW50IHBoeXNpY2FsIHBhZ2UgYW5kIHJldGly
ZSB0aGUgb2xkIHBhZ2UgLi4uIHRoZQ0KcmVhZCBjYW4gbm93IHN1Y2NlZWQuIElmIHRoZSBwYWdl
IGlzIGRpcnR5LCB0aGVuIGZhaWwgdGhlIHJlYWQgKGFuZCByZXRpcmUNCnRoZSBwYWdlIC4uLiBu
ZWVkIHRvIG1ha2Ugc3VyZSBmaWxlc3lzdGVtIGtub3dzIHRoZSBkYXRhIGZvciB0aGUgcGFnZQ0K
d2FzIGxvc3Qgc28gc3Vic2VxdWVudCByZWFkcyByZXR1cm4gLUVJTyBvciBzb21ldGhpbmcpLg0K
DQpQYWdlIGNhY2hlIG9jY3VwaWVzIGVub3VnaCBtZW1vcnkgdGhhdCBpdCBpcyBhIGJpZyBlbm91
Z2gNCnNvdXJjZSBvZiBzeXN0ZW0gY3Jhc2hlcyB0aGF0IGNvdWxkIGJlIGF2b2lkZWQuIEknbSBu
b3Qgc3VyZQ0KaWYgdGhlcmUgYXJlIGFueSBvdGhlciBvYnZpb3VzIGNhc2VzIGFmdGVyIHRoaXMg
Li4uIGl0IGFsbCBnZXRzIGludG8NCmRpbWluaXNoaW5nIHJldHVybnMgLi4uIG5vdCByZWFsbHkg
d29ydGggaXQgdG8gaGFuZGxlIGEgY2FzZSB0aGF0DQpvbmx5IG9jY3VwaWVzIDAuMDAwMDIlIG9m
IG1lbW9yeS4NCg0KPiBCZWNhdXNlIGZyb20gd2hlcmUgSSBzdGFuZCBpdCBhbGwgbG9va3MgbGlr
ZSB3ZSBkbyBhbGwgdGhlc2UgZmFuY3kNCj4gcmVjb3ZlcnkgdGhpbmdzIGJ1dCBpcyB1c2Vyc3Bh
Y2UgZXZlbiBwYXlpbmcgYXR0ZW50aW9uIG9yIHVzaW5nIHRoZW0gb3INCj4gd2hhdGV2ZXIuLi4N
Cg0KU2VlIGFib3ZlLiBXaXRoIGNvcmUgY291bnRzIGNvbnRpbnVpbmcgdG8gaW5jcmVhc2UsIHRo
ZSBjbG91ZCBzZXJ2aWNlDQpwcm92aWRlcnMgcmVhbGx5IHdhbnQgdG8gc2VlIGZld2VyIGV2ZW50
cyB0aGF0IGNyYXNoIHRoZSB3aG9sZSBwaHlzaWNhbA0KbWFjaGluZSAodGFraW5nIGRvd24gZG96
ZW5zLCBvciBodW5kcmVkcywgb2YgZ3Vlc3QgVk1zKS4NCg0KLVRvbnkNCg==
