Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1004347707
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 12:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbhCXLX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 07:23:26 -0400
Received: from mga14.intel.com ([192.55.52.115]:15020 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231811AbhCXLXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 07:23:04 -0400
IronPort-SDR: 4sPfXJozztFMmGJfwwPLcHN6sKWBNnTMxWCsUdV3LRD0kao4jLqI7CtP+Bnhukw1JwohyEBFm7
 Qbr/xhC3dXfA==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="190094688"
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="190094688"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 04:23:04 -0700
IronPort-SDR: MfwqPanb0Iqc+iEtOQA8LkpLg1kxRPa4SNLLV8oYa35Vku0bst3vAN5AzUVeig8hOQFCgusefC
 tJPJ+dCnMe/g==
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="593346812"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 04:23:01 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lP1bG-00FeXS-5N; Wed, 24 Mar 2021 13:22:58 +0200
Date:   Wed, 24 Mar 2021 13:22:58 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 03/12] dump_stack: Add vmlinux build ID to stack traces
Message-ID: <YFshElW7XI+ekhfy@smile.fi.intel.com>
References: <20210324020443.1815557-1-swboyd@chromium.org>
 <20210324020443.1815557-4-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324020443.1815557-4-swboyd@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 07:04:34PM -0700, Stephen Boyd wrote:
> Add the running kernel's build ID[1] to the stacktrace information
> header.  This makes it simpler for developers to locate the vmlinux with
> full debuginfo for a particular kernel stacktrace. Combined with
> scripts/decode_stracktrace.sh, a developer can download the correct
> vmlinux from a debuginfod[2] server and find the exact file and line
> number for the functions plus offsets in a stacktrace.
> 
> This is especially useful for pstore crash debugging where the kernel
> crashes are recorded in the pstore logs and the recovery kernel is
> different or the debuginfo doesn't exist on the device due to space
> concerns (the data can be large and a security concern). The stacktrace
> can be analyzed after the crash by using the build ID to find the
> matching vmlinux and understand where in the function something went
> wrong.
> 
> Example stacktrace from lkdtm:

Can we drop the noise from the example and leave only important part(s)?

>  WARNING: CPU: 4 PID: 3255 at drivers/misc/lkdtm/bugs.c:83 lkdtm_WARNING+0x28/0x30 [lkdtm]
>  Modules linked in: lkdtm rfcomm algif_hash algif_skcipher af_alg xt_cgroup uinput xt_MASQUERADE
>  CPU: 4 PID: 3255 Comm: bash Not tainted 5.11 #3 aa23f7a1231c229de205662d5a9e0d4c580f19a1
>  Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
>  pstate: 00400009 (nzcv daif +PAN -UAO -TCO BTYPE=--)
>  pc : lkdtm_WARNING+0x28/0x30 [lkdtm]
>  lr : lkdtm_do_action+0x24/0x40 [lkdtm]
>  sp : ffffffc0134fbca0
>  x29: ffffffc0134fbca0 x28: ffffff92d53ba240
>  x27: 0000000000000000 x26: 0000000000000000
>  x25: 0000000000000000 x24: ffffffe3622352c0
>  x23: 0000000000000020 x22: ffffffe362233366
>  x21: ffffffe3622352e0 x20: ffffffc0134fbde0
>  x19: 0000000000000008 x18: 0000000000000000
>  x17: ffffff929b6536fc x16: 0000000000000000
>  x15: 0000000000000000 x14: 0000000000000012
>  x13: ffffffe380ed892c x12: ffffffe381d05068
>  x11: 0000000000000000 x10: 0000000000000000
>  x9 : 0000000000000001 x8 : ffffffe362237000
>  x7 : aaaaaaaaaaaaaaaa x6 : 0000000000000000
>  x5 : 0000000000000000 x4 : 0000000000000001
>  x3 : 0000000000000008 x2 : ffffff93fef25a70
>  x1 : ffffff93fef15788 x0 : ffffffe3622352e0
>  Call trace:
>   lkdtm_WARNING+0x28/0x30 [lkdtm]
>   direct_entry+0x16c/0x1b4 [lkdtm]
>   full_proxy_write+0x74/0xa4
>   vfs_write+0xec/0x2e8
>   ksys_write+0x84/0xf0
>   __arm64_sys_write+0x24/0x30
>   el0_svc_common+0xf4/0x1c0
>   do_el0_svc_compat+0x28/0x3c
>   el0_svc_compat+0x10/0x1c
>   el0_sync_compat_handler+0xa8/0xcc
>   el0_sync_compat+0x178/0x180
>  ---[ end trace 3d95032303e59e68 ]---
> 
> The hex string aa23f7a1231c229de205662d5a9e0d4c580f19a1 is the build ID,
> following the kernel version number.

-- 
With Best Regards,
Andy Shevchenko


