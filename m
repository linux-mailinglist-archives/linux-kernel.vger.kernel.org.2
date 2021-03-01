Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80073298E4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 11:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346811AbhCAXua convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 1 Mar 2021 18:50:30 -0500
Received: from mga11.intel.com ([192.55.52.93]:39999 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239476AbhCASNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 13:13:09 -0500
IronPort-SDR: 9nwu0e3p9iB9nq5BMKVXEYKrlFqRFeUEIrZPuWi+ZZTAuZ6lltz6zuXIoe8/GoJyVJQPeDObUs
 yLmGyaWP49Iw==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="183154327"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="183154327"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 10:12:27 -0800
IronPort-SDR: 9iUx9PmuTuWibLM7Vibw58s6o1gLaWSWoN3ZVnuDzQCqrjQK/yu7AvVYNj6uWljOvD1A+RR8XB
 oA4UsSkIf/UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="517526629"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 01 Mar 2021 10:12:27 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 1 Mar 2021 10:12:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 1 Mar 2021 10:12:26 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.002;
 Mon, 1 Mar 2021 10:12:26 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Aili Yao <yaoaili@kingsoft.com>, Andy Lutomirski <luto@kernel.org>
CC:     =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKCAbJEJLWTh9GyhCIBskQkQ+TGkbKEIp?= 
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
Thread-Index: AQHW+52QL4Na2ZzwuU6zOFVHHVSkcqpmUikAgAAvRAD//40+AIAC4sSAgAMSD4CAA2yIgIAAIxjQ
Date:   Mon, 1 Mar 2021 18:12:26 +0000
Message-ID: <64e319e644b548a38c9549d668cfcc9c@intel.com>
References: <20210223204436.1df73153@alex-virtual-machine>
 <788DFBA0-903F-4548-9C2F-B1A1543EE770@amacapital.net>
 <20210223164259.GA166727@agluck-desk2.amr.corp.intel.com>
 <20210225124711.35b31965@alex-virtual-machine>
 <CALCETrXT9vGRT1S6Kk5ExfU+mW16rCY964r73ihRf5ZSh9H8jg@mail.gmail.com>
 <20210301155749.1cc324c7@alex-virtual-machine>
In-Reply-To: <20210301155749.1cc324c7@alex-virtual-machine>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Programs that get a signal might expect that the RIP that the signal
> frame points to is the instruction that caused the signal and that the
> instruction faulted without side effects.  For SIGSEGV, I would be
> especially nervous about this.  Maybe SIGBUS is safer.  For SIGSEGV,
> it's entirely valid to look at CR2 / si_fault_addr, fix it up, and
> return.  This would be completely *invalid* with your patch.  I'm not
> sure what to do about this.

The original plan was that s/w like databases would be able to write
their own application specific recovery code. E.g. they hit poison while
reading some "table". The process gets a SIGBUS with siginfo telling
the handler the virtual address range that has been lost. The code
uses mmap(MAP_FIXED) to map a new page into the lost address and
fills it with suitable data (either reconstructing lost data by replaying
transactions, or filling the table with some "data unknown" indicator).

Then the SIGBUS handler returns to re-execute the instruction that
failed.

As far as I know nobody has been that creative in production s/w.
But I think there are folks with a siglongjmp() to a "this whole transaction
just failed" safe point.

-Tony
