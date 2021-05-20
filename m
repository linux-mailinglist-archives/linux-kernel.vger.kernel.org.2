Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C39C38AFC8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 15:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbhETNTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:19:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:10444 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232048AbhETNTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:19:02 -0400
IronPort-SDR: zcO61oLzLD86ujbPINHW74+fpS8SfBoxECIN/Ory8xZ9B8yGrXaL/fb11ot+HJgsC8BDxpXmXl
 2wg++kXalrFQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="201265382"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="201265382"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 06:17:40 -0700
IronPort-SDR: Dr5yN49R17UnKrq8jzwOgYsvFvsawFoiRo13RfZjtYtFdTpdsZt0NDnrDBica6Nu0AG7G1+sGS
 Od97rlZo/PZw==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="543523032"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 06:17:39 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ljiYS-00DUBL-Fp; Thu, 20 May 2021 16:17:36 +0300
Date:   Thu, 20 May 2021 16:17:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] kernel.h: split out panic and oops helpers (ia64
 fix)
Message-ID: <YKZhcKqomWxH3eph@smile.fi.intel.com>
References: <20210520130557.55277-1-andriy.shevchenko@linux.intel.com>
 <f2420178-53d7-a1e4-eea7-5e1773835411@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2420178-53d7-a1e4-eea7-5e1773835411@physik.fu-berlin.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 03:12:24PM +0200, John Paul Adrian Glaubitz wrote:
> On 5/20/21 3:05 PM, Andy Shevchenko wrote:
> > Note, this patch is untested. I have no ia64 compiler at hand.

> I can test it later today.

Appreciate it, thanks!

This is against Linux Next (where Andrew's patches are sitting for a while).

-- 
With Best Regards,
Andy Shevchenko


