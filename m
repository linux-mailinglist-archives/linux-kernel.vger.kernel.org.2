Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEC130E35E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 20:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhBCThP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 14:37:15 -0500
Received: from mga01.intel.com ([192.55.52.88]:5950 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231296AbhBCThN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 14:37:13 -0500
IronPort-SDR: EjwDIsVy3c6WF00rPkdDgid8M99z0Vzt4GJwwIG4JJeYb/54V2BfjiATgnWxOG/aVFwHmMBl+L
 bqFx2YPcPDYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="200070508"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="200070508"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 11:35:28 -0800
IronPort-SDR: wvqFBOGBv6TkhLjc0tjMG0iEkYLihlCupR907htdu1Pcsy0EU9gMdQL423diT2xYCi2JPIc9N0
 0fN5E8iG8pTw==
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="480464255"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 11:35:27 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l7Nvw-001iG7-G8; Wed, 03 Feb 2021 21:35:24 +0200
Date:   Wed, 3 Feb 2021 21:35:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@dell.com>
Cc:     Hans De Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] platform/x86: Move all dell drivers to their own
 subdirectory
Message-ID: <YBr6/ClMRV4Sw/kN@smile.fi.intel.com>
References: <20210203192637.2947540-1-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203192637.2947540-1-mario.limonciello@dell.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 01:26:37PM -0600, Mario Limonciello wrote:
> A user without a Dell system doesn't need to pick any of these
> drivers.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>

You are fast, thanks!

...

> +menuconfig DELL_X86_PLATFORM_DRIVERS

I'm not sure this is a good order, rather X86_PLATFORM_DRIVERS_DELL?

...

> +if DELL_X86_PLATFORM_DRIVERS
> +source "drivers/platform/x86/dell/Kconfig"
> +endif # DELL_X86_PLATFORM_DRIVERS

Would you expect something else here?

I would rather unconditionally source this and inside it do that menuconfig
with ifdeffery.

-- 
With Best Regards,
Andy Shevchenko


