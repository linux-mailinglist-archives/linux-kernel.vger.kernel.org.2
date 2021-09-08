Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85273403328
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 06:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhIHEHw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Sep 2021 00:07:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:20103 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhIHEHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 00:07:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10100"; a="220434118"
X-IronPort-AV: E=Sophos;i="5.85,276,1624345200"; 
   d="scan'208";a="220434118"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 21:06:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,276,1624345200"; 
   d="scan'208";a="513105144"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 07 Sep 2021 21:06:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 7 Sep 2021 21:06:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 7 Sep 2021 21:06:43 -0700
Received: from orsmsx610.amr.corp.intel.com ([10.22.229.23]) by
 ORSMSX610.amr.corp.intel.com ([10.22.229.23]) with mapi id 15.01.2242.012;
 Tue, 7 Sep 2021 21:06:43 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Ziljstra <peterz@infradead.org>
Subject: RE: [patch V2 00/20] x86/fpu: Clean up exception fixups and error
 handling in sigframe related code
Thread-Topic: [patch V2 00/20] x86/fpu: Clean up exception fixups and error
 handling in sigframe related code
Thread-Index: AQHXpCJtVbDXYHaEVUKqChRZNl/sYquZdCmA//+LHqCAAHjEgP//mTdQgACCAwCAAAvOgP//5erg
Date:   Wed, 8 Sep 2021 04:06:43 +0000
Message-ID: <cf9a841219904c048983fe2aee578761@intel.com>
References: <20210907195612.321345EED@xen13.tec.linutronix.de>
 <874kaw9mpo.ffs@tglx> <e190b62e3f954cc1804a41149a842641@intel.com>
 <871r609m2i.ffs@tglx> <a883fe85b6b941b9bff44bc4b268bba1@intel.com>
 <87v93c82zn.ffs@tglx> <87sfyg8118.ffs@tglx>
In-Reply-To: <87sfyg8118.ffs@tglx>
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

>> Huch? That tree is based on 0bcfe68b876 and it just has those 20 patches
>> on top which should not at all interfere with your root filesystem
>> device. Let me verify.
>
> I lost connection to my test machines. Will continue tomorrow morning.

To save you some time I ran a bisect. It says the wheels fall off the bus at
patch 13/20

$ git bisect bad
43bce826b58940bd3143f110d36f5901d009e527 is the first bad commit
commit 43bce826b58940bd3143f110d36f5901d009e527
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Mon Aug 30 18:27:25 2021 +0200

    x86/fpu/signal: Move xstate clearing out of copy_fpregs_to_sigframe()

    When the direct saving of the FPU registers to the user space sigframe
    fails, copy_fpregs_to_sigframe() attempts to clear the user buffer.

    The most likely reason for such a fail is a page fault. As
    copy_fpregs_to_sigframe() is invoked with pagefaults disabled the chance
    that __clear_user() succeeds is minuscule.

    Move the clearing out into the caller which replaces the
    fault_in_pages_writeable() in that error handling path.

    The return value confusion will be cleaned up separately.

    Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

:040000 040000 a7dce9444541186dcc30f21c9d0416d48f215507 71056cf4baa014ca33ab4861b0aca76b154979bf M arch
