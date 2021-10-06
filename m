Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F55C4241E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 17:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238379AbhJFP5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 11:57:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:59648 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230014AbhJFP5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:57:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="289528357"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="289528357"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 08:54:48 -0700
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="458469286"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 08:54:44 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mY9Fh-009FLL-FZ;
        Wed, 06 Oct 2021 18:54:41 +0300
Date:   Wed, 6 Oct 2021 18:54:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <oliver.sang@intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [x86/platform]  d7109fe3a0:
 kernel-selftests.gpio.gpio-mockup.sh.fail
Message-ID: <YV3GwQ68KssgPUHW@smile.fi.intel.com>
References: <20210912150158.GF25450@xsang-OptiPlex-9020>
 <YT4YaHTiaDibkzfK@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YT4YaHTiaDibkzfK@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change Bart's address accordingly to last MAINTAINER update.

On Sun, Sep 12, 2021 at 06:10:32PM +0300, Andy Shevchenko wrote:
> +Cc: Bart
> 
> On Sun, Sep 12, 2021 at 11:01:58PM +0800, kernel test robot wrote:
> > Greeting,
> > 
> > FYI, we noticed the following commit (built with gcc-9):
> 
> Thanks for the report.
> 
> First of all, please teach your bot to cut up things a bit. ~13k lines
> is something not expected here, really!
> 
> > commit: d7109fe3a0991a0f7b4ac099b78c908e3b619787 ("x86/platform: Increase maximum GPIO number for X86_64")
> > https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git x86/urgent
> > 
> > 
> > in testcase: kernel-selftests
> > version: kernel-selftests-x86_64-d0cba0d1-1_20210907
> > with following parameters:
> > 
> > 	group: group-01
> > 	ucode: 0xe2
> > 
> > test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> > test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> > 
> > 
> > on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz with 32G memory
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> > 2021-09-10 00:58:57 make run_tests -C gpio
> > make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7109fe3a0991a0f7b4ac099b78c908e3b619787/tools/testing/selftests/gpio'
> > TAP version 13
> > 1..1
> > # selftests: gpio: gpio-mockup.sh
> > # 1.  Module load tests
> > # 1.1.  dynamic allocation of gpio
> > # 2.  Module load error tests
> > # 2.1 gpio overflow
> > # test failed: unexpected chip - gpiochip0
> > # GPIO gpio-mockup test FAIL
> > not ok 1 selftests: gpio: gpio-mockup.sh # exit=1
> 
> Test does the overflow check with 1024 as a parameter and comments deliberately
> tells about limitation. What it should do instead is to use the actual GPIO
> number from the kernel configuration.

-- 
With Best Regards,
Andy Shevchenko


