Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7421C41BCA0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 04:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243726AbhI2CRF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Sep 2021 22:17:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:63690 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243628AbhI2CRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 22:17:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="204994181"
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; 
   d="scan'208";a="204994181"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 19:15:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; 
   d="scan'208";a="554425552"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Sep 2021 19:15:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 19:15:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 19:15:08 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.012;
 Tue, 28 Sep 2021 19:15:08 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Yu, Fenghua" <fenghua.yu@intel.com>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
Thread-Topic: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
Thread-Index: AQHXrlppUXtiT4Ul9UCq0y1lpkQn1quyuuKAgAWuhwCAAKRkgIAAyOqAgAB9aAD//53xAIAAfQEA//+wWACAAICAgP//j4cAABJzk4AADh9DwA==
Date:   Wed, 29 Sep 2021 02:15:08 +0000
Message-ID: <9e12eba3e78e4bc98d550943ff639ebe@intel.com>
References: <20210920192349.2602141-5-fenghua.yu@intel.com>
 <1aae375d-3cd4-4ab8-9c64-9e387916e6c0@www.fastmail.com>
 <YVIxeBh3IKYYK711@agluck-desk2.amr.corp.intel.com>
 <035290e6-d914-a113-ea6c-e845d71069cf@intel.com>
 <YVNj8sm8iectc6iU@agluck-desk2.amr.corp.intel.com>
 <3f97b77e-a609-997b-3be7-f44ff7312b0d@intel.com>
 <YVN652x14dMgyE85@agluck-desk2.amr.corp.intel.com>
 <f6014b16-7b4c-cbb6-c975-1ec34092956f@intel.com>
 <YVOg7zgpdQlc7Zjt@agluck-desk2.amr.corp.intel.com>
 <YVOp60LOL+bfh3iT@otcwcpicx3.sc.intel.com>
 <YVOuYAFaTG6Khotb@agluck-desk2.amr.corp.intel.com>
 <840148c7b70f4358852c4f1ccbc5d567@intel.com>
In-Reply-To: <840148c7b70f4358852c4f1ccbc5d567@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> 	if (!(xsave->header.xfeatures & fmask)) {
>> 		xsave->header.xfeatures |= fmask;	//<<<<<
>> 		xsaves(xsave, fmask);
>> 	}
>
> I'm not sure why the FPU state is initialized here.
>
> For updating the PASID state, it's unnecessary to init the PASID state.
>
> Maybe it is necessary in other cases?

Dave had suggested initializing feature state when it is unknown (could
be garbage).  This is my attempt to follow that guidance. I'm not confident
that my tests for "is the state in registers, in memory, or is garbage"
really capture all the cases.

-Tony
