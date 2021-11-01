Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89771441C51
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 15:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhKAOPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 10:15:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:48045 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231882AbhKAOP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 10:15:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10154"; a="229749026"
X-IronPort-AV: E=Sophos;i="5.87,199,1631602800"; 
   d="scan'208";a="229749026"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 07:12:55 -0700
X-IronPort-AV: E=Sophos;i="5.87,199,1631602800"; 
   d="scan'208";a="449269433"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 07:12:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mhY3A-002gyP-V2;
        Mon, 01 Nov 2021 16:12:36 +0200
Date:   Mon, 1 Nov 2021 16:12:36 +0200
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     Aditya Garg <gargaditya08@live.com>
Cc:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Orlando Chamberlain <redecorating@protonmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] Kernel 5.15 fails to boot on Apple Macs with T2
 chip.
Message-ID: <YX/11JbsNAx8jHWC@smile.fi.intel.com>
References: <F94B8FCA-E736-4E87-BFAC-D668A481B5C4@live.com>
 <7A40981F-AA9A-462E-81D2-CE1FFA5174CA@live.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7A40981F-AA9A-462E-81D2-CE1FFA5174CA@live.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 12:52:56PM +0000, Aditya Garg wrote:
> I remember facing this issue on 5.15-rc3 also. Though I am not sure about rc2 and rc1.

Stop top-posting!

> > On 01-Nov-2021, at 6:14 PM, Aditya Garg <gargaditya08@live.com> wrote:
> > 
> > Due to some issue in intel-lpss-acpi, kernel 5.15 fails to boot on Apple Macs with T2 chip in 5.15. As a temporary workaround, "# CONFIG_MFD_INTEL_LPSS_ACPI is not set” has been set in the kernel configuration so that it does not interfere.

What issue? Can you bisect and/or describe better what exactly is going on?

> > You are requested to fix this issue.

What? We may not fix the thing we don't have even clue about...

-- 
With Best Regards,
Andy Shevchenko


