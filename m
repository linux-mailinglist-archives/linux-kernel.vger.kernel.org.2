Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9898F345D7E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 12:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhCWL5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 07:57:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:4042 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230096AbhCWL5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:57:09 -0400
IronPort-SDR: h7L9McVi264EvfC99WY0aEAMBd1K8NfbWphNbyLzAcHsB2kHI4IMg04yim6pCepxwN8xXVbbcT
 odp2PFsoVaXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="190557692"
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="190557692"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 04:57:08 -0700
IronPort-SDR: Kr2qfO3W8v609q5JOMoXa9erA7jtCQRTIvS2rfsyrndNYusfhViN4JuCuHZWRip8Hf13O4vO5W
 /5g/WtmcgzBQ==
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="408283704"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 04:57:07 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lOfei-00F0Ou-Ky; Tue, 23 Mar 2021 13:57:04 +0200
Date:   Tue, 23 Mar 2021 13:57:04 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v1 1/1] mfd: lpc_sch: Partially revert "Add support for
 Intel Quark X1000"
Message-ID: <YFnXkPIIbq+lDacz@smile.fi.intel.com>
References: <20210303164944.41962-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303164944.41962-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 06:49:44PM +0200, Andy Shevchenko wrote:
> The IRQ support for SCH GPIO is not specific to the Intel Quark SoC.
> Moreover the IRQ routing is quite interesting there, so while it's
> needs a special support, the driver haven't it anyway yet.
> 
> Due to above remove basically redundant code of IRQ support.
> 
> This reverts commit ec689a8a8155ce8b966bd5d7737a3916f5e48be3.

Lee, just in case you missed this somehow.

Additional note: I have added IRQ support to the GPIO driver but it does NOT
require anything from MFD part. So, this patch stays correct.


-- 
With Best Regards,
Andy Shevchenko


