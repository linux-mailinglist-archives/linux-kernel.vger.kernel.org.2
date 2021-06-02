Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38EF399569
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 23:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhFBV3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 17:29:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:7445 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229467AbhFBV3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 17:29:45 -0400
IronPort-SDR: bSFxWQNZ6JC2QMdjY7AiG4f0PosZCFcNX9BgzLEGyJT5Ihx5gs+BOM48CpiqZNgEfGpcZ26gZG
 Zq5eNnr9jI+A==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="203930965"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="203930965"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 14:28:01 -0700
IronPort-SDR: Kj8OAPusdJl3fZe5jCIQLhmxFadTkVB9CsifIUCcHqitenzm66LdM0+ihKbnoEOVtCilLC4UH4
 mwiasflJVtgg==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="479879953"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.95.91]) ([10.212.95.91])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 14:28:00 -0700
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Subject: Re: [patch 0/8] x86/fpu: Mop up XSAVES and related damage
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>
References: <20210602095543.149814064@linutronix.de>
Message-ID: <9c5c90bf-fbf6-7e45-4668-2f40f11e8b36@intel.com>
Date:   Wed, 2 Jun 2021 14:28:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210602095543.149814064@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/2021 2:55 AM, Thomas Gleixner wrote:
> syszbot reported a warnon for XRSTOR raising #GP:
> 
>   https://lore.kernel.org/r/0000000000004c453905c30f8334@google.com
> 
> with a syzcaller reproducer and a conclusive bisect result.
> 
> It took a while to destill a simple C reproducer out of it which allowed to
> pin point the root cause: The recent addition of supervisor XSTATEs broke
> the signal restore path for the case where the signal handler wreckaged the
> XSTATE on stack because it does not sanitize the XSTATE header which causes
> a subsequent XRSTOR to fail and #GP.
> 
> The following series addresses the problem and fixes related issues which
> were found while inspecting the related changes.
> 
> Thanks to Andy and Dave for working on this with me!
> 
> Thanks,
> 
> 	tglx
> ---
>   arch/x86/include/asm/fpu/xstate.h                     |    4
>   arch/x86/kernel/fpu/core.c                            |   62 ++++++---
>   arch/x86/kernel/fpu/regset.c                          |   43 ++----
>   arch/x86/kernel/fpu/signal.c                          |   30 +++-
>   arch/x86/kernel/fpu/xstate.c                          |   95 +++++----------
>   b/tools/testing/selftests/x86/corrupt_xstate_header.c |  114 ++++++++++++++++++
>   tools/testing/selftests/x86/Makefile                  |    3
>   7 files changed, 234 insertions(+), 117 deletions(-)
> 

With the series applied, glibc pkey test fails sometimes.  I will try to 
find out the cause.

The test:

https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/tst-pkey.c

The output:

error: ../sysdeps/unix/sysv/linux/tst-pkey.c:161: not true: 
!check_page_access (i, false)
error: ../sysdeps/unix/sysv/linux/tst-pkey.c:162: not true: 
!check_page_access (i, true)
error: ../sysdeps/unix/sysv/linux/tst-pkey.c:161: not true: 
!check_page_access (i, false)
error: ../sysdeps/unix/sysv/linux/tst-pkey.c:162: not true: 
!check_page_access (i, true)
error: ../sysdeps/unix/sysv/linux/tst-pkey.c:161: not true: 
!check_page_access (i, false)
error: ../sysdeps/unix/sysv/linux/tst-pkey.c:162: not true: 
!check_page_access (i, true)
../sysdeps/unix/sysv/linux/tst-pkey.c:238: numeric comparison failure
    left: 0 (0x0); from: result->access_rights[i]
   right: 1 (0x1); from: PKEY_DISABLE_ACCESS
../sysdeps/unix/sysv/linux/tst-pkey.c:238: numeric comparison failure
    left: 0 (0x0); from: result->access_rights[i]
   right: 1 (0x1); from: PKEY_DISABLE_ACCESS
../sysdeps/unix/sysv/linux/tst-pkey.c:238: numeric comparison failure
    left: 0 (0x0); from: result->access_rights[i]
   right: 1 (0x1); from: PKEY_DISABLE_ACCESS
../sysdeps/unix/sysv/linux/tst-pkey.c:242: numeric comparison failure
    left: 0 (0x0); from: result->access_rights[i]
   right: 1 (0x1); from: PKEY_DISABLE_ACCESS
../sysdeps/unix/sysv/linux/tst-pkey.c:242: numeric comparison failure
    left: 0 (0x0); from: result->access_rights[i]
   right: 1 (0x1); from: PKEY_DISABLE_ACCESS
../sysdeps/unix/sysv/linux/tst-pkey.c:242: numeric comparison failure
    left: 0 (0x0); from: result->access_rights[i]
   right: 1 (0x1); from: PKEY_DISABLE_ACCESS
error: 12 test failures
