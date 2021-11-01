Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0372D4420F8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 20:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhKATkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 15:40:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:12247 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229636AbhKATkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 15:40:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10155"; a="229818506"
X-IronPort-AV: E=Sophos;i="5.87,200,1631602800"; 
   d="scan'208";a="229818506"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 12:00:42 -0700
X-IronPort-AV: E=Sophos;i="5.87,200,1631602800"; 
   d="scan'208";a="467403485"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 12:00:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mhcXf-002mmB-VU;
        Mon, 01 Nov 2021 21:00:23 +0200
Date:   Mon, 1 Nov 2021 21:00:23 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Aditya Garg <gargaditya08@live.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Orlando Chamberlain <redecorating@protonmail.com>
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Fix too early PM enablement in
 the ACPI ->probe()
Message-ID: <YYA5R6KyIYJJrUkc@smile.fi.intel.com>
References: <20211101151036.33598-1-andriy.shevchenko@linux.intel.com>
 <E051196A-C49B-4528-B72D-0BBC907AABFD@live.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E051196A-C49B-4528-B72D-0BBC907AABFD@live.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 06:21:51PM +0000, Aditya Garg wrote:
> > On 01-Nov-2021, at 8:40 PM, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > 
> > The runtime PM callback may be called as soon as the runtime PM facility
> > is enabled and activated. It means that ->suspend() may be called before
> > we finish probing the device in the ACPI case. Hence, NULL pointer
> > dereference:
> > 
> >  intel-lpss INT34BA:00: IRQ index 0 not found
> >  BUG: kernel NULL pointer dereference, address: 0000000000000030
> >  ...
> >  Workqueue: pm pm_runtime_work
> >  RIP: 0010:intel_lpss_suspend+0xb/0x40 [intel_lpss]
> > 
> > To fix this, first try to register the device and only after that enable
> > runtime PM facility.

> Following patch fixed the issue for me.
> Tested-by: Aditya Garg <gargaditya08@live.com>

Thanks for testing!


-- 
With Best Regards,
Andy Shevchenko


