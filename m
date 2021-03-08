Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80304331625
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 19:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhCHScI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 13:32:08 -0500
Received: from mga11.intel.com ([192.55.52.93]:62939 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231184AbhCHSbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 13:31:47 -0500
IronPort-SDR: qCvNj870y8vPboMto6mMCXingGJyTszw5K9OFrdsM83y+IQC670uN2m30cNMswDYH2elqkXynu
 k93pCAx7Mf4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="184720942"
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="184720942"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 10:31:47 -0800
IronPort-SDR: 1vpfTv/xLbfg8qBk0iB7CACv0cQC1t0xzAP+6vxKIPs54rdQcftIuvJ76W8DI+K7rW9QE07fhe
 muP5bA7eyJ9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="369500948"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga003.jf.intel.com with ESMTP; 08 Mar 2021 10:31:46 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 10:31:45 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 10:31:07 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.013;
 Mon, 8 Mar 2021 10:31:07 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Andy Lutomirski <luto@amacapital.net>,
        Aili Yao <yaoaili@kingsoft.com>
CC:     Andy Lutomirski <luto@kernel.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
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
Thread-Index: AQHW+52QL4Na2ZzwuU6zOFVHHVSkcqpmUikAgAAvRAD//40+AIAC4sSAgAMSD4CAA5534IAAicMAgAKzWQCAAAergIAGtN8AgADz2wCAAI0/AP//fEfg
Date:   Mon, 8 Mar 2021 18:31:07 +0000
Message-ID: <4fc1b4e8f1fb4c8c81f280db09178797@intel.com>
References: <20210308174912.4ac9029a@alex-virtual-machine>
 <8F3F763F-59CC-4E25-B4DE-89CD0632F754@amacapital.net>
In-Reply-To: <8F3F763F-59CC-4E25-B4DE-89CD0632F754@amacapital.net>
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

PiBDYW4geW91IHBvaW50IG1lIGF0IHRoYXQgU0lHQlVTIGNvZGUgaW4gYSBjdXJyZW50IGtlcm5l
bD8NCg0KSXQgaXMgaW4ga2lsbF9tZV9tYXliZSgpLiAgbWNlX3ZhZGRyIGlzIHNldHVwIHdoZW4g
d2UgZGlzYXNzZW1ibGUgd2hhdGV2ZXIgZ2V0X3VzZXIoKQ0Kb3IgY29weSBmcm9tIHVzZXIgdmFy
aWFudCB3YXMgaW4gdXNlIGluIHRoZSBrZXJuZWwgd2hlbiB0aGUgcG9pc29uIG1lbW9yeSB3YXMg
Y29uc3VtZWQuDQoNCiAgICAgICAgaWYgKHAtPm1jZV92YWRkciAhPSAodm9pZCBfX3VzZXIgKikt
MWwpIHsNCiAgICAgICAgICAgICAgICBmb3JjZV9zaWdfbWNlZXJyKEJVU19NQ0VFUlJfQVIsIHAt
Pm1jZV92YWRkciwgUEFHRV9TSElGVCk7DQoNCldvdWxkIGl0IGJlIGFueSBiZXR0ZXIgaWYgd2Ug
dXNlZCB0aGUgQlVTX01DRUVSUl9BTyBjb2RlIHRoYXQgZ29lcyBpbnRvIHNpZ2luZm8/DQoNClRo
YXQgd291bGQgbWFrZSBpdCBtYXRjaCB1cCBiZXR0ZXIgd2l0aCB3aGF0IGhhcHBlbnMgd2hlbiBw
b2lzb24gaXMgZm91bmQNCmFzeW5jaHJvbm91c2x5IGJ5IHRoZSBwYXRyb2wgc2NydWJiZXIuIEku
ZS4gdGhlIHNlbWFudGljcyBhcmU6DQoNCkFSOiBZb3UganVzdCB0b3VjaGVkIHBvaXNvbiBhdCB0
aGlzIGFkZHJlc3MgYW5kIG5lZWQgdG8gZG8gc29tZXRoaW5nIGFib3V0IHRoYXQuDQpBTzogSnVz
dCBsZXR0aW5nIHlvdSBrbm93IHRoYXQgeW91IGhhdmUgc29tZSBwb2lzb24gYXQgdGhlIGFkZHJl
c3MgaW4gc2lnaW5mby4NCg0KLVRvbnkNCg==
