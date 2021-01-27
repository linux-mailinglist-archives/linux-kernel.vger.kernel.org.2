Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161B030676E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbhA0XBq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Jan 2021 18:01:46 -0500
Received: from mga03.intel.com ([134.134.136.65]:51950 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233180AbhA0W6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 17:58:36 -0500
IronPort-SDR: o4vl8oV3+xkYJzeeabT2VAxLXJR9JJNKch3svPDyL4uk6TmMdjyNN7RXsE7Pd1BjxFUXNakjzg
 jBxgDE1wT+BQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="180223146"
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="180223146"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 14:40:00 -0800
IronPort-SDR: UGA1dZN8wKbLyOMVSV8oG7V54a3T3baKRL9nzJr1vxYI5rB51CKkE0qcfRrQcEZ/5CgPieowmg
 AyKGNJrOffRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="353967511"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga003.jf.intel.com with ESMTP; 27 Jan 2021 14:40:00 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 27 Jan 2021 14:40:00 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 27 Jan 2021 14:39:59 -0800
Received: from orsmsx611.amr.corp.intel.com ([10.22.229.24]) by
 ORSMSX611.amr.corp.intel.com ([10.22.229.24]) with mapi id 15.01.1713.004;
 Wed, 27 Jan 2021 14:39:59 -0800
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Li, Xiaoyao" <xiaoyao.li@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: RE: [PATCH v4 1/4] x86/cpufeatures: Enumerate #DB for bus lock
 detection
Thread-Topic: [PATCH v4 1/4] x86/cpufeatures: Enumerate #DB for bus lock
 detection
Thread-Index: AQHW9PFAPoRJX+AnhkuFXC9BaOBb+qo7/kbA
Date:   Wed, 27 Jan 2021 22:39:59 +0000
Message-ID: <adf4082ffef7410c961cfe76acc93606@intel.com>
References: <20201124205245.4164633-1-fenghua.yu@intel.com>
 <20201124205245.4164633-2-fenghua.yu@intel.com>
 <87wnvydqxi.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87wnvydqxi.fsf@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thomas,

> On Wed, Jan 27, 2021 2:16 PM, Thomas Gleixner wrote:
> On Tue, Nov 24 2020 at 20:52, Fenghua Yu wrote:
> 
> > A bus lock is acquired though either split locked access to writeback
> > (WB) memory or any locked access to non-WB memory. This is typically
> > >1000 cycles slower than an atomic operation within a cache line. It
> > also disrupts performance on other cores.
> >
> > Some CPUs have ability to notify the kernel by an #DB trap after a
> > user instruction acquires a bus lock and is executed. This allows the
> > kernel to enforce user application throttling or mitigations.
> 
> That's nice, but how does that interact with a data breakpoint on the same
> location?

If both data breakpoint and bus lock happen on the same location, the bus lock
is handled first and then the data breakpoint is handled in the same exception:

1. If warn on bus lock, a rate limited warning is printed for the bus lock and then
    a SIGTRAP is sent to the user process.
2. If fatal on bus lock, a SIGBUS is sent to the user process for the bus lock and a
    SIGTRAP is also sent to the user process. I think the SIGBUS will be delivered first
    to the process and then SIGTRAP will be delivered to the process.
3. If ratelimit on bus lock, first the tasks in the user sleep for specified time, then
    SIGTRAP is sent to the user process.

Is the interaction OK?

> 
> Also the information you pointed to in the cover letter
> 
> >  [1] Intel Instruction Set Extension Chapter 8:
> > https://software.intel.com/sites/default/files/managed/c5/15/architect
> > ure-instruction-set-extensions-programming-reference.pdf
> 
> does not contain anything which is even remotely related to this patch series.
> That chapter describes another bit in TEST_CTRL_MSR ...

I think either I gave an old link or the content in the link was changed to an older version of ISE doc after this series was released.

Here is the new ISE doc and the bus lock exception is described in Chapter 9.
https://software.intel.com/content/dam/develop/public/us/en/documents/architecture-instruction-set-extensions-programming-reference.pdf

I'll update the link in the next version.

Thanks!

-Fenghua
