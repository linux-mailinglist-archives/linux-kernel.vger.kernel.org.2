Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2DA349301
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhCYNWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:22:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:57585 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230425AbhCYNW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:22:28 -0400
IronPort-SDR: P/KZAZhtWsb3siYJQ6aqApP/pSTIw/rOucAgNXdfnKqWtyCIWGUuL1Vzyaz50HARidKCrcy2jD
 hMb4/Y4/Ob6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="178478717"
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="178478717"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 06:22:27 -0700
IronPort-SDR: s84PZ1wzip9QzzxBwviK59uqJwLGtOiq2JCpygHpBsDVhsqnjkLz7in2OYc1bWHfFofW2mP8wa
 Z91DucKLk+Xg==
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="376846989"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 06:22:25 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lPPwM-00G3Jl-U7; Thu, 25 Mar 2021 15:22:22 +0200
Date:   Thu, 25 Mar 2021 15:22:22 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Subject: Re: [PATCH] include: linux: debug_locks: Remove duplicate declaration
Message-ID: <YFyOjtTI8XXPKgph@smile.fi.intel.com>
References: <20210325022707.840531-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325022707.840531-1-wanjiabing@vivo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 10:26:58AM +0800, Wan Jiabing wrote:
> struct task_struct is declared at 9th line. Remove the duplicate.

It seems the duplicate is the other one and you removed wrong one.

> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  include/linux/debug_locks.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/debug_locks.h b/include/linux/debug_locks.h
> index 2915f56ad421..0b3187a5290d 100644
> --- a/include/linux/debug_locks.h
> +++ b/include/linux/debug_locks.h
> @@ -46,7 +46,6 @@ extern int debug_locks_off(void);
>  # define locking_selftest()	do { } while (0)
>  #endif
>  
> -struct task_struct;
>  
>  #ifdef CONFIG_LOCKDEP
>  extern void debug_show_all_locks(void);
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


