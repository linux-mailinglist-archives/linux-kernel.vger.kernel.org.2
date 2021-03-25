Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C613495E7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 16:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhCYPpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 11:45:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:47365 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230438AbhCYPp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 11:45:28 -0400
IronPort-SDR: tG+4mCt7J1sTW+lgdOhftp0pcJdgGMBJPaJ4EZdTRupbv1diSMm2SROBadJWFdpwLRWNDYUNOZ
 IuY8gtoiSsWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="170935033"
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="170935033"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 08:45:27 -0700
IronPort-SDR: ttG/+1rrifuWhY0jX+aAvXNx2TuCEsyyqCIVmF5ZKXHeqfuWGEPKhR8LYcFUl1vY9V7ZthoyEb
 uS9EuJOkhSKg==
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="525695283"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 08:45:25 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lPSAk-00G5au-EU; Thu, 25 Mar 2021 17:45:22 +0200
Date:   Thu, 25 Mar 2021 17:45:22 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, keal_w@yeah.net
Subject: Re: [PATCH] [v2] include: linux: debug_locks: Remove duplicate
 declaration
Message-ID: <YFywEil0TwbHItSJ@smile.fi.intel.com>
References: <20210325152029.4976-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325152029.4976-1-wanjiabing@vivo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 11:20:28PM +0800, Wan Jiabing wrote:
> struct task_struct has been declared.

"...declared twice."

In the subject line the "include: linux: " part is not needed.

FWIW, after addressing above,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Remove the duplicate.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
> Changelog:
> v2:
> - Remove another duplicate declaration for being closer
>   to its user.
> ---
>  include/linux/debug_locks.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/debug_locks.h b/include/linux/debug_locks.h
> index 2915f56ad421..32f6a37a3d3f 100644
> --- a/include/linux/debug_locks.h
> +++ b/include/linux/debug_locks.h
> @@ -6,8 +6,6 @@
>  #include <linux/bug.h>
>  #include <linux/printk.h>
>  
> -struct task_struct;
> -
>  extern int debug_locks __read_mostly;
>  extern int debug_locks_silent __read_mostly;
>  
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


