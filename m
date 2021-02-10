Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D327D316B33
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 17:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhBJQ3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 11:29:04 -0500
Received: from mga14.intel.com ([192.55.52.115]:56763 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232273AbhBJQ3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 11:29:00 -0500
IronPort-SDR: CiItd527TcV6KZg/uwUNFDygSb5jbnlpqouA+hoXKOFdSXHlJoW4jRXk+ndEz1zvKtETZmJ4jN
 8Dju+V0O7uxQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="181329195"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="181329195"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 08:27:00 -0800
IronPort-SDR: iDCFj3FScJh1aCbM/3YQ2GQ7n7Pnt11AD+MDLAGiNS+TicXC0tGpJumUeFAluf+0ZPN+13aGKP
 uwSkK26rRasw==
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="510436292"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 08:26:57 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l9sKM-003lpV-5i; Wed, 10 Feb 2021 18:26:54 +0200
Date:   Wed, 10 Feb 2021 18:26:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Ingo Molnar <mingo@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v4 0/8] support for bitmap (and hence CPU) list "N"
 abbreviation
Message-ID: <YCQJToq1d63BU55S@smile.fi.intel.com>
References: <20210209225907.78405-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209225907.78405-1-paul.gortmaker@windriver.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 05:58:59PM -0500, Paul Gortmaker wrote:
> The basic objective here was to add support for "nohz_full=8-N" and/or
> "rcu_nocbs="4-N" -- essentially introduce "N" as a portable reference
> to the last core, evaluated at boot for anything using a CPU list.

I thought we kinda agreed that N is confusing and L is better.
N to me is equal to 32 on 32 core system as *number of cores / CPUs*. While L
sounds better as *last available CPU number*.

-- 
With Best Regards,
Andy Shevchenko


