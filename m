Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C970F3A1BD2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 19:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhFIReB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 13:34:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:28399 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229792AbhFIRd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 13:33:59 -0400
IronPort-SDR: mEKs28w6UBW7Oo6FoXwVJCPRaOnA+doNMP2nmpaJRcGtb76NQU9PW4+N/DTeu4EaQ3nrLnzOuv
 reMst7XWqXLQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="184812891"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="184812891"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 10:32:04 -0700
IronPort-SDR: 4Rnrd8b1FkD/0HaDpgwKDf+Yq0H9EQocm4DL4mk+Hhy2NEs8YmvvgDl6n4UBiaz+wLEElgHjrH
 d+zRPy5rH40Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="485806690"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jun 2021 10:32:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 9 Jun 2021 10:32:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 9 Jun 2021 10:32:03 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.008;
 Wed, 9 Jun 2021 10:32:03 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Ingo Molnar" <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: RE: [PATCH] x86/cpufeatures: Force disable X86_FEATURE_ENQCMD and
 remove update_pasid()
Thread-Topic: [PATCH] x86/cpufeatures: Force disable X86_FEATURE_ENQCMD and
 remove update_pasid()
Thread-Index: AQHXVGt3asHLaBFynUG7zSoQX2rt5Kr9vnIAgAAaOACAA1lTUIAB1x8AgAj4W/A=
Date:   Wed, 9 Jun 2021 17:32:02 +0000
Message-ID: <7d8788a9e04d4901a03bcea11e8e842b@intel.com>
References: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com>
 <1600187413-163670-10-git-send-email-fenghua.yu@intel.com>
 <87mtsd6gr9.ffs@nanos.tec.linutronix.de> <YLShmFEzddfm7WQs@zn.tnic>
 <87y2bv438p.ffs@nanos.tec.linutronix.de>
 <36866b38ec92425b879881a88acf547b@intel.com>
 <db552f51-76ee-b7f5-20f1-14f1c703d423@kernel.org>
In-Reply-To: <db552f51-76ee-b7f5-20f1-14f1c703d423@kernel.org>
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

Pj4gSSd2ZSB0b2xkIEZlbmdodWEgdG8gZGlnIG91dCB0aGUgcHJldmlvdXMgaXRlcmF0aW9uIG9m
IHRoaXMgcGF0Y2ggd2hlcmUNCj4+IHRoZSBwbGFuIHdhcyB0byBsYXppbHkgZml4IHRoZSBQQVNJ
RF9NU1IgaW4gb3RoZXIgdGhyZWFkcyBpbiB0aGUgI0dQDQo+PiBoYW5kbGVyLg0KPg0KPiBCbGVj
aC4gIEFsc28gdGhpcyB3b24ndCB3b3JrIGZvciBvdGhlciBQQVNJRC1saWtlIGZlYXR1cmVzLg0K
Pg0KPiBJIGhhdmUgYSBoYWxmLXdyaXR0ZW4gcGF0Y2ggdG8gZml4IHRoaXMgdXAgZm9yIHJlYWwu
ICBTdGF5IHR1bmVkLg0KDQpBbmR5OiBBbnkgdXBkYXRlIG9uIHRoaXM/DQoNCi1Ub255DQo=
