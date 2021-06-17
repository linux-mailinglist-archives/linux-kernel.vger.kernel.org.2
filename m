Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D2E3AAEE8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 10:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhFQIkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 04:40:21 -0400
Received: from mga11.intel.com ([192.55.52.93]:27829 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229712AbhFQIkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 04:40:20 -0400
IronPort-SDR: N+EsSaTQKye2857rYYdNSwNpWUY7nPZy6oLyOcZTf/uTupgE0yGGmD6ELEed5FIKVKRe9E59ns
 YaA6MTjCut5Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="203304379"
X-IronPort-AV: E=Sophos;i="5.83,280,1616482800"; 
   d="scan'208";a="203304379"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 01:38:07 -0700
IronPort-SDR: 9r7wPOkRinaRCAffzfvHg029xMVOmn1+JTqDN6uVhCZAIMRnE6e9HWCmzqZe3c1GWpvAZ2Xs4E
 5vTyScrMPg/g==
X-IronPort-AV: E=Sophos;i="5.83,280,1616482800"; 
   d="scan'208";a="621983357"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 01:38:04 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ltnXE-0033F6-Bv; Thu, 17 Jun 2021 11:38:00 +0300
Date:   Thu, 17 Jun 2021 11:38:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org,
        kbuild-all@lists.01.org, Petr Mladek <pmladek@suse.com>,
        Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v7 4/5] printk: Userspace format indexing support
Message-ID: <YMsJ6ORGRKmSlvJO@smile.fi.intel.com>
References: <e42070983637ac5e384f17fbdbe86d19c7b212a5.1623775748.git.chris@chrisdown.name>
 <202106171546.7koPrJBA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202106171546.7koPrJBA-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 03:36:08PM +0800, kernel test robot wrote:
> Hi Chris,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on jeyu/modules-next]
> [also build test WARNING on linux/master soc/for-next openrisc/for-next powerpc/next asm-generic/master driver-core/driver-core-testing linus/master v5.13-rc6 next-20210616]
> [cannot apply to uml/linux-next tip/x86/core]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Chris-Down/printk-Userspace-format-indexing-support/20210617-101450
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git modules-next

Not sure that has what Andrew keeps in his quilt.

Chris, to avoid such issues, use `git format-patch --base ...` when sending a
series / patches.


-- 
With Best Regards,
Andy Shevchenko


