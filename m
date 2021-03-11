Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E05C337F66
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 22:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhCKVLN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 11 Mar 2021 16:11:13 -0500
Received: from mga04.intel.com ([192.55.52.120]:25630 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230431AbhCKVKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 16:10:21 -0500
IronPort-SDR: 12hnibvAz7Y0NkCxSxQ75t/LVqKnmuTqo3wRKW9gLlszUJCwcYSG0avBxkNCKlKUELd06D3End
 bv4akPThLX+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="186365297"
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="186365297"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 13:10:03 -0800
IronPort-SDR: mNiYVKGfY6eQo3jt5dbwy+56rw5oM3B4WkCSPVJ27Z8X+/skd4U4rzZXQbrYP15hcCxDI22IZp
 P630yyLhWN4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="589353470"
Received: from irsmsx602.ger.corp.intel.com ([163.33.146.8])
  by orsmga005.jf.intel.com with ESMTP; 11 Mar 2021 13:10:00 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 irsmsx602.ger.corp.intel.com (163.33.146.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 11 Mar 2021 21:09:59 +0000
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.013;
 Thu, 11 Mar 2021 13:09:57 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>
CC:     Andi Kleen <ak@linux.intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "yao.jin@linux.intel.com" <yao.jin@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: RE: [PATCH V2 20/25] perf/x86/intel: Add Alder Lake Hybrid support
Thread-Topic: [PATCH V2 20/25] perf/x86/intel: Add Alder Lake Hybrid support
Thread-Index: AQHXFrfRS7+fP1DgV0u9rghYd88t86p/RY4w
Date:   Thu, 11 Mar 2021 21:09:57 +0000
Message-ID: <a606211b5b454ef5b658858e0cb361f0@intel.com>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
 <1615394281-68214-21-git-send-email-kan.liang@linux.intel.com>
 <YEpAtTttSxMVDWYp@hirez.programming.kicks-ass.net>
 <01176076-049b-0129-4865-8c49cd002060@linux.intel.com>
 <20210311195832.GK4746@worktop.programming.kicks-ass.net>
 <400dbd6e-389c-899d-6d11-14b5a8f8f90e@linux.intel.com>
 <20210311204742.GM4746@worktop.programming.kicks-ass.net>
In-Reply-To: <20210311204742.GM4746@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> I think the "sapphire_rapids" is the code name for the server platform.
>
> If that's really the case, then:
>
> #define INTEL_FAM6_SAPPHIRERAPIDS_X     0x8F
>
> is wrong, those things should be uarch name, not platform name. Tony?

0x8F is the model number of the CPU that is named Sapphire Rapids that
goes into the Eagle Stream platform

If you want a uarch name, that might be the name of the core
(.... something-cove ... I can't keep track of the names of all the
coves). But that would likely lead to different confusion later if that
*cove core is used in some other CPU model number that doesn't
neatly fit into our _X, _L etc. suffix scheme)

-Tony
