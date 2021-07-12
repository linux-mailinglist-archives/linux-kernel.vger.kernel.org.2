Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBFC3C60AD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 18:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbhGLQhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 12:37:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:43423 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233444AbhGLQhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:37:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="271124923"
X-IronPort-AV: E=Sophos;i="5.84,234,1620716400"; 
   d="scan'208";a="271124923"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 09:34:19 -0700
X-IronPort-AV: E=Sophos;i="5.84,234,1620716400"; 
   d="scan'208";a="412145447"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 09:34:17 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m2ysl-00CI3k-1x; Mon, 12 Jul 2021 19:34:11 +0300
Date:   Mon, 12 Jul 2021 19:34:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        Christian Eggers <ceggers@arri.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH v2 1/9] units: Add the HZ macros
Message-ID: <YOxvAwb1Ho9iTxWg@smile.fi.intel.com>
References: <20210224144222.23762-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224144222.23762-1-daniel.lezcano@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 03:42:11PM +0100, Daniel Lezcano wrote:
> The macros for the unit conversion for frequency are duplicated in
> different places.
> 
> Provide these macros in the 'units' header, so they can be reused.

Any progress on this? Are you planning to resubmit?

-- 
With Best Regards,
Andy Shevchenko


