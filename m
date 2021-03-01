Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08EF7329B35
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 11:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbhCBBPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 20:15:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:33937 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240192AbhCATFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 14:05:36 -0500
IronPort-SDR: NfwZ2JfSP9lJwj1lHbw7T6LGMl9FFrzkRYrqvQfnLfpiLdb7VY5fKGRgjFKJi0QZJnFZL15iWc
 DQZrjQ2wenoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="250618511"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="250618511"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 11:02:43 -0800
IronPort-SDR: q7Fb6bLx0pGKZSEn++bEkzupajJoYjF3dlZVBtyb2X6Hp/uhmuo5ZigaA87XtJXqSo8skhWzi3
 ppfuMjt1dxNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="517545598"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga004.jf.intel.com with ESMTP; 01 Mar 2021 11:02:42 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 1 Mar 2021 11:02:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 1 Mar 2021 11:02:41 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.002;
 Mon, 1 Mar 2021 11:02:41 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Andy Lutomirski <luto@kernel.org>, Aili Yao <yaoaili@kingsoft.com>
CC:     =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKCDloIDlj6Mg55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] x86/fault: Send a SIGBUS to user process always for
 hwpoison page access.
Thread-Topic: [PATCH v3] x86/fault: Send a SIGBUS to user process always for
 hwpoison page access.
Thread-Index: AQHW+52QL4Na2ZzwuU6zOFVHHVSkcqpmUikAgAAvRAD//40+AIAC4sSAgAMSD4CAA5534A==
Date:   Mon, 1 Mar 2021 19:02:41 +0000
Message-ID: <8d0c76f97f35499f91a2b82d3e7c024d@intel.com>
References: <20210223204436.1df73153@alex-virtual-machine>
 <788DFBA0-903F-4548-9C2F-B1A1543EE770@amacapital.net>
 <20210223164259.GA166727@agluck-desk2.amr.corp.intel.com>
 <20210225124711.35b31965@alex-virtual-machine>
 <CALCETrXT9vGRT1S6Kk5ExfU+mW16rCY964r73ihRf5ZSh9H8jg@mail.gmail.com>
In-Reply-To: <CALCETrXT9vGRT1S6Kk5ExfU+mW16rCY964r73ihRf5ZSh9H8jg@mail.gmail.com>
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

PiBTb21lIHByb2dyYW1zIG1heSB1c2UgcmVhZCgyKSwgd3JpdGUoMiksIGV0YyBhcyB3YXlzIHRv
IGNoZWNrIGlmDQo+IG1lbW9yeSBpcyB2YWxpZCB3aXRob3V0IGdldHRpbmcgYSBzaWduYWwuICBU
aGV5IG1pZ2h0IG5vdCB3YW50DQo+IHNpZ25hbHMsIHdoaWNoIG1lYW5zIHRoYXQgdGhpcyBmZWF0
dXJlIG1pZ2h0IG5lZWQgdG8gYmUgY29uZmlndXJhYmxlLg0KDQpUaGF0IHNvdW5kcyBsaWtlIGFu
IGFwcGFsbGluZyBoYWNrLiBJZiB1c2VycyBuZWVkIHN1Y2ggYSBtZWNoYW5pc20NCndlIHNob3Vs
ZCBjcmVhdGUgc29tZSBiZXR0ZXIgd2F5IHRvIGRvIHRoYXQuDQoNCkFuIGFlb24gYWdvIEFDUEkg
Y3JlYXRlZCB0aGUgUkFTRiB0YWJsZSBhcyBhIHdheSBmb3IgdGhlIE9TIHRvDQphc2sgdGhlIHBs
YXRmb3JtIHRvIHNjYW4gYSBibG9jayBvZiBwaHlzaWNhbCBtZW1vcnkgdXNpbmcgdGhlIHBhdHJv
bA0Kc2NydWJiZXIgaW4gdGhlIG1lbW9yeSBjb250cm9sbGVyLiAgSSBuZXZlciBkaWQgYW55dGhp
bmcgd2l0aCBpdCBpbiBMaW51eA0KYmVjYXVzZSBpdCB3YXMganVzdCB0b28gY29tcGxleCBhbmQg
ZGlkbid0IGtub3cgb2YgYW55IHVzZSBjYXNlcy4NCg0KVXNlcnMgd291bGQgd2FudCB0byBjaGVj
ayB2aXJ0dWFsIGFkZHJlc3Nlcy4gUGVyaGFwcyBzb21lIG5ldw0Kb3B0aW9uIE1BRFZfQ0hFQ0tG
T1JQT0lTT04gdG8gbWFkdmlzZSgyKSA/DQoNCi1Ub255DQo=
