Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83EB63A2B84
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 14:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhFJM27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 08:28:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:39855 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230351AbhFJM2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 08:28:42 -0400
IronPort-SDR: SuDeniu2SS7HSSeio1A5z/tRz7UMimAsmNycZQYGFTy2e01uF0WLifQ9HYWMG+E3agGJ4AgCyY
 /A1x3k9lnSng==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="290915763"
X-IronPort-AV: E=Sophos;i="5.83,263,1616482800"; 
   d="scan'208";a="290915763"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 05:26:43 -0700
IronPort-SDR: dzmfLMoZf5QqeBQFiUDudECXetibQ9T0FfykRNjJRZx4z8F6eYNsktwXtTUP413nGLDrtT3P29
 kiPBSRqpqPsg==
X-IronPort-AV: E=Sophos;i="5.83,263,1616482800"; 
   d="scan'208";a="553049853"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 05:26:41 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1lrJle-0018gq-Ug; Thu, 10 Jun 2021 15:26:38 +0300
Date:   Thu, 10 Jun 2021 15:26:38 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Andy Shevchenko <andy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] lib: remove leading spaces before tabs
Message-ID: <YMIE/iciIMGu+vcK@smile.fi.intel.com>
References: <20210608071430.12687-1-thunder.leizhen@huawei.com>
 <CAHp75VfuMJ5kfRDB4tE2zr2Em79HiwrDJVROnw+kD3H+QNM4sg@mail.gmail.com>
 <da4915c5-fa13-0cf2-f2d2-02779a64af1b@huawei.com>
 <8a70d592e14f93822bf40832c7374d8e491c3afc.camel@perches.com>
 <26ee1009-259d-07a6-495f-87557be9ed8a@huawei.com>
 <3211e76c-d2a0-1e26-940b-9710073ee7d4@huawei.com>
 <CAHp75VfQq=RkjyZQsc-PHLTLRCzXovm-D_Z+Pp3A6vWGA-GKug@mail.gmail.com>
 <7e0f67a63b7093f4d20e0c0ccb076d9244e26a9a.camel@perches.com>
 <YMHW80wUyFpW6Utf@smile.fi.intel.com>
 <c8671b993095e58ca8f3f82cc69e2651666331c6.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8671b993095e58ca8f3f82cc69e2651666331c6.camel@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 05:05:39AM -0700, Joe Perches wrote:
> On Thu, 2021-06-10 at 12:10 +0300, Andy Shevchenko wrote:
> > If you care about parallelism, the checkpatch should be doing it itself.
> 
> ridiculous argument.  g'night...

I don't think so. Not everyone runs checkpatch in parallel on 1000 core machine
with terabytes of RAM.

Good night!

-- 
With Best Regards,
Andy Shevchenko


