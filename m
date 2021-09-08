Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82275403D0E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 17:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349742AbhIHP6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 11:58:21 -0400
Received: from mga14.intel.com ([192.55.52.115]:48411 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235546AbhIHP6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 11:58:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="220200129"
X-IronPort-AV: E=Sophos;i="5.85,278,1624345200"; 
   d="scan'208";a="220200129"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 08:57:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,278,1624345200"; 
   d="scan'208";a="538847868"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Sep 2021 08:57:12 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 8 Sep 2021 08:57:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 8 Sep 2021 08:57:11 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.012;
 Wed, 8 Sep 2021 08:57:11 -0700
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
Thread-Index: AQHXpLWNMIIy4Yr8BEe0tJ9JqpTQzauaSlHw
Date:   Wed, 8 Sep 2021 15:57:11 +0000
Message-ID: <5621f6055ca641d89c0cd05c91f8b06c@intel.com>
References: <20210908130922.118265849@linutronix.de>
In-Reply-To: <20210908130922.118265849@linutronix.de>
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

PiBDaGFuZ2VzIHZzLiBWMiBbMl06DQo+DQo+ICAtIEZpeCB0aGUgYm9ndXMgbGVmdCBvdmVyIGNo
ZWNrIGZvciAjUEYgd2hpY2ggY2F1c2VzIGJvb3QgZmFpbHVyZXMNCg0KTXVjaCBiZXR0ZXIuIFRo
aXMgdmVyc2lvbiBib290cy4gIE1hY2hpbmUgY2hlY2sgcmVjb3Zlcnkgd29ya3MgYXMgd2VsbCBh
cyBpdCBkaWQgYmVmb3JlDQoodXNlciB0cmlnZ2VyZWQgbWFjaGluZSBjaGVja3MgYXJlIGZpbmUs
IGtlcm5lbCB0cmlnZ2VyZWQgb25lcyBhcmUgb2sgd2hlcmUgdGhleSB3ZXJlDQpiZWZvcmUgYW5k
IHN0aWxsIHRyaWdnZXIgaW5maW5pdGUgbG9vcHMgd2hlcmUgdGhleSBkaWQgYmVmb3JlKS4NCg0K
LVRvbnkNCg==
