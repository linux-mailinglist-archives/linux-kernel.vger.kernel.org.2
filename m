Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89D635E38D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 18:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhDMQNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 12:13:54 -0400
Received: from mga04.intel.com ([192.55.52.120]:52809 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231588AbhDMQNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 12:13:53 -0400
IronPort-SDR: xEuHZFmND3HnKRXF2O+JjQ5Mn6OpE0u1RqvYkdg1Cig8ydlT3zVo18gbnRK7Ahz5xMfvwdqGd2
 l3loOzsVsPXQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="192319088"
X-IronPort-AV: E=Sophos;i="5.82,219,1613462400"; 
   d="scan'208";a="192319088"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 09:07:34 -0700
IronPort-SDR: iekMBpGgBIPhIAT4f+Urbnh+/kqbtRL3QvoaMfLpCxEqfPaTwFtmbqNykVevhfKvyRRNkASD90
 jO/H2K3kbovw==
X-IronPort-AV: E=Sophos;i="5.82,219,1613462400"; 
   d="scan'208";a="521649801"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 09:07:31 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lWLZY-003njE-Jq; Tue, 13 Apr 2021 19:07:28 +0300
Date:   Tue, 13 Apr 2021 19:07:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v1 1/1] mfd: lpc_sch: Partially revert "Add support for
 Intel Quark X1000"
Message-ID: <YHXBwDIfMIoko4HZ@smile.fi.intel.com>
References: <20210303164944.41962-1-andriy.shevchenko@linux.intel.com>
 <YFnXkPIIbq+lDacz@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFnXkPIIbq+lDacz@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 01:57:04PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 03, 2021 at 06:49:44PM +0200, Andy Shevchenko wrote:
> > The IRQ support for SCH GPIO is not specific to the Intel Quark SoC.
> > Moreover the IRQ routing is quite interesting there, so while it's
> > needs a special support, the driver haven't it anyway yet.
> > 
> > Due to above remove basically redundant code of IRQ support.
> > 
> > This reverts commit ec689a8a8155ce8b966bd5d7737a3916f5e48be3.
> 
> Lee, just in case you missed this somehow.
> 
> Additional note: I have added IRQ support to the GPIO driver but it does NOT
> require anything from MFD part. So, this patch stays correct.

Gentle ping on this one. I'm afraid it may be forgotten.

-- 
With Best Regards,
Andy Shevchenko


