Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967303C76D1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 21:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbhGMTQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 15:16:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:30055 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhGMTQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 15:16:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="207211591"
X-IronPort-AV: E=Sophos;i="5.84,237,1620716400"; 
   d="scan'208";a="207211591"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 12:13:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,237,1620716400"; 
   d="scan'208";a="503348493"
Received: from irsmsx605.ger.corp.intel.com ([163.33.146.138])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jul 2021 12:13:23 -0700
Received: from tjmaciei-mobl5.localnet (10.209.50.142) by
 IRSMSX605.ger.corp.intel.com (163.33.146.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 13 Jul 2021 20:13:20 +0100
From:   Thiago Macieira <thiago.macieira@intel.com>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
CC:     <bp@suse.de>, <luto@kernel.org>, <tglx@linutronix.de>,
        <mingo@kernel.org>, <x86@kernel.org>, <len.brown@intel.com>,
        <dave.hansen@intel.com>, <jing2.liu@intel.com>,
        <ravi.v.shankar@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 12/26] x86/fpu/xstate: Use feature disable (XFD) to protect dynamic user state
Date:   Tue, 13 Jul 2021 12:13:16 -0700
Message-ID: <1817232.MPthNTNLIG@tjmaciei-mobl5>
Organization: Intel Corporation
In-Reply-To: <20210710130313.5072-13-chang.seok.bae@intel.com>
References: <20210710130313.5072-1-chang.seok.bae@intel.com> <20210710130313.5072-13-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [10.209.50.142]
X-ClientProxiedBy: orsmsx605.amr.corp.intel.com (10.22.229.18) To
 IRSMSX605.ger.corp.intel.com (163.33.146.138)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 10 July 2021 06:02:59 PDT Chang S. Bae wrote:
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index a58800973aed..f45b2cefd6cf 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -1112,6 +1112,44 @@ DEFINE_IDTENTRY(exc_device_not_available)
[cut]
> +                               /* Raise a signal when it failed to handle.
> */ +                               if (err)
> +                                       force_sig(SIGSEGV);
> +                       }
> +                       return;

Hello Chang

Can I make a suggestion that you send a different signal than SIGSEGV for the 
failure of unauthorised instructions? I would recommend SIGILL. Additionally, 
please consider a new ILL_* constant for the si_code field.

I have multiple reasons for that:
1) the XFD failure is not a memory issue, so SIGSEGV is not really 
appropriate, despite coming from an #NM interrupt

2) SIGILL is sent for the AMX instructions in other circumstances, due to CPU 
#UD, notably:
- running on a CPU without AMX support
- running under an OS that did not enable the AMX state in XCR0 (like Linux 
  before this patch series)

When a developer is debugging code and sees a SIGILL on a valid instruction 
stream in disassembly, they know they've got to code they should never have 
got to, bypassing CPU checks. Forgetting to ask for permission is now a 
variant of  that case.

3) the very first AMX instruction to cause the #NM is likely going to be an 
LDTILECFG or TILELOADD, which are memory-related instructions, so may #GP for 
using bad pointers (and LDTILECFG can #GP for bad tile configurations). 
Knowing that the issue was the instruction itself instead of the pointer or 
data being loaded is going to come in handy.

4) SIGSEGV will also be sent for another reason by the kernel. Your cover 
message had:

> 4. Applications touching AMX without permission results in process exit.
> 
>     Armed XFD results in #NM, results in SIGSEGV, typically resulting in
>     process exit.

> 6. NM handler allocation failure results in process exit.
> 
>     If the #NM handler can not allocate the 8KB buffer, the task will
>     receive a SIGSEGV at the instruction that took the #NM fault, typically
>     resulting in process exit.

Knowing that it was caused by reaching code that shouldn't have been reached, 
instead of an OOM issue, is handy.

Do note that this SIGSEGV for allocation is unlikely to happen. If the kernel 
is under memory pressure, the OOM killer will probably kick in and may kill 
(SIGKILL) this process instead. But at least #6 is a legitimate memory issue.


On the same topic, is there a way to save this state in a core dump? The FS 
and GS bases would also be very handy.

-- 
Thiago Macieira - thiago.macieira (AT) intel.com
  Software Architect - Intel DPG Cloud Engineering



