Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5EC3769C6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 20:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhEGSDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 14:03:16 -0400
Received: from mga12.intel.com ([192.55.52.136]:60518 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229461AbhEGSDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 14:03:15 -0400
IronPort-SDR: ZQlsik2nannmJZD/3wRMAYkIXw3+YsTGV8RPQkIXSTT20YmEEVmRs0/sp5z11L5m7dFJ5FcR+s
 LFK+BWgp1ttw==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="178346740"
X-IronPort-AV: E=Sophos;i="5.82,281,1613462400"; 
   d="scan'208";a="178346740"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 11:02:14 -0700
IronPort-SDR: /NklHU5Xjn1sFGCMrq9gHWtcLEiE6yT4LbsngQZzS5qLfCCb+dVKXk/my+2j7MnwsaXV4bllwt
 ciYnYUb7hhUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,281,1613462400"; 
   d="scan'208";a="397812967"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 07 May 2021 11:02:14 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 7 May 2021 11:02:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 7 May 2021 11:02:13 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.013;
 Fri, 7 May 2021 11:02:13 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Aili Yao <yaoaili@kingsoft.com>,
        =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
CC:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Oscar Salvador" <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>, Jue Wang <juew@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yaoaili126@gmail.com" <yaoaili126@gmail.com>
Subject: RE: [PATCH v3 0/3] mm,hwpoison: fix sending SIGBUS for Action
 Required MCE
Thread-Topic: [PATCH v3 0/3] mm,hwpoison: fix sending SIGBUS for Action
 Required MCE
Thread-Index: AQHXNklUtDziI1+1ZUqZsXGvSliLyarXX3UAgAAW4VCAAJTpAIAAYa8A///72gA=
Date:   Fri, 7 May 2021 18:02:13 +0000
Message-ID: <e6577ace06ca4ce9bbfb8195d7a2bfb7@intel.com>
References: <20210421005728.1994268-1-nao.horiguchi@gmail.com>
        <d09f178272df4c82b8c090ba79d222b5@intel.com>
        <87ba79daaba1416589b203118be096cb@intel.com>
        <20210507052422.GB2158342@hori.linux.bs1.fc.nec.co.jp>
 <20210507191400.6258dee6@alex-virtual-machine>
In-Reply-To: <20210507191400.6258dee6@alex-virtual-machine>
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

PiBCZWZvcmUgY2M6c3RhYmxlLCB3b3VsZCB5b3UgcGxlYXNlIGRvIG9uZSBzdHJlc3MgdGVzdCBm
aXJzdD8NCj4gSXQgZmFpbGVkIGluIG15IHNlcnZlciwgYnV0IEkgZGlkbid0IGRpZyBpbnRvIGl0
LCBtYXliZSB0aGUgZmFpbCBpcyBtZWFuaW5nbGVzcy4NCj4gSnVzdCBhIHNtYWxsIHN1Z2dlc3Rp
b24uDQoNClVwc3RyZWFtIHBsdXMgdGhlc2UgdGhyZWUgcGF0Y2hlcyBwYXNzZWQgYW4gb3Zlcm5p
Z2h0IDgtaG91ciBzdHJlc3MgdGVzdA0Kb24gZm91ciBtYWNoaW5lcyBoZXJlIChydW5uaW5nIGEg
dGVzdCB0aGF0J3MgYmVlbiBmYWlsaW5nIHdpdGggaHVuZyBrZXJuZWxzDQphbmQga2VybmVsIGNy
YXNoZXMgdy9vIHRoZXNlIHBhdGNoZXMpLg0KDQpXaGF0IHdlcmUgdGhlIHN5bXB0b21zIG9mIHlv
dXIgZmFpbGVkIHNlcnZlcj8NCg0KLVRvbnkNCg==
