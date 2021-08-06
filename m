Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0F93E26B8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 11:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244057AbhHFJEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 05:04:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:10069 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243794AbhHFJEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:04:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10067"; a="211233378"
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="211233378"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 02:04:21 -0700
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="672125541"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 02:04:19 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mBvm1-005lgs-Rb; Fri, 06 Aug 2021 12:04:13 +0300
Date:   Fri, 6 Aug 2021 12:04:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Gross <mgross@linux.intel.com>
Subject: Re: [RFT, PATCH v1 1/1] platform/x86: dell-smo8800: Convert to be a
 platform driver
Message-ID: <YQz7DV4lOSD7+RJ8@smile.fi.intel.com>
References: <20210803194039.35083-1-andriy.shevchenko@linux.intel.com>
 <20210805192221.s7uoi5gh6zzkqinh@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210805192221.s7uoi5gh6zzkqinh@pali>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 09:22:21PM +0200, Pali Rohár wrote:
> On Tuesday 03 August 2021 22:40:39 Andy Shevchenko wrote:
> > ACPI core in conjunction with platform driver core provides
> > an infrastructure to enumerate ACPI devices. Use it in order
> > to remove a lot of boilerplate code.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Tested on Dell Latitude E6440. After applying this patch /dev/freefall
> device is created and can be opened (for waiting for disk fall). Also
> interrupt is registered in /proc/interrupts file:
> 
>  23:          0          0          0          0  IR-IO-APIC  23-edge      smo8800
> 
> But I have not done real hard disk fall on this machine :-) so I guess
> it would work as before applying this patch.

At least the change doesn't touch any functional parts except device driver
enumeration.

> Reviewed-by: Pali Rohár <pali@kernel.org>
> Tested-by: Pali Rohár <pali@kernel.org>

Thank you!

-- 
With Best Regards,
Andy Shevchenko


