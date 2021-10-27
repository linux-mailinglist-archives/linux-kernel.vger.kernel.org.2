Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4233B43D1B4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 21:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243688AbhJ0Tdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 15:33:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:61830 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231623AbhJ0Tdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 15:33:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10150"; a="229000407"
X-IronPort-AV: E=Sophos;i="5.87,187,1631602800"; 
   d="scan'208";a="229000407"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 12:31:14 -0700
X-IronPort-AV: E=Sophos;i="5.87,187,1631602800"; 
   d="scan'208";a="723502170"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 12:31:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mfodQ-001ZEu-Fx;
        Wed, 27 Oct 2021 22:30:52 +0300
Date:   Wed, 27 Oct 2021 22:30:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v2 1/1] kernel.h: split out instruction pointer accessors
Message-ID: <YXmo7C4qLCySmW8s@smile.fi.intel.com>
References: <20211027154623.82223-1-andriy.shevchenko@linux.intel.com>
 <202110280217.A2FUrtxH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202110280217.A2FUrtxH-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 02:09:48AM +0800, kernel test robot wrote:
> Hi Andy,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on next-20211026]
> [cannot apply to linus/master v5.15-rc7 v5.15-rc6 v5.15-rc5 v5.15-rc7]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/kernel-h-split-out-instruction-pointer-accessors/20211027-235208
> base:    2376e5fe91bcad74b997d2cc0535abff79ec73c5
> config: i386-tinyconfig (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/0day-ci/linux/commit/9fc7130c986cccb5765165dd9f7fc77a4935892c
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Andy-Shevchenko/kernel-h-split-out-instruction-pointer-accessors/20211027-235208
>         git checkout 9fc7130c986cccb5765165dd9f7fc77a4935892c
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         make W=1 O=build_dir ARCH=i386 prepare
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

Thanks!
Something went wrong when I fixed the typos...

-- 
With Best Regards,
Andy Shevchenko


