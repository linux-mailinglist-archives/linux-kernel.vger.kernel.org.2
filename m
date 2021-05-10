Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5880D378E16
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244224AbhEJNEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 09:04:51 -0400
Received: from mga05.intel.com ([192.55.52.43]:39426 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350924AbhEJNCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 09:02:15 -0400
IronPort-SDR: zaMFxyVBgp5Gj7lpdNGc0Rrqrc2yyNhaya9yc/Kd0S+sfPqcL48gFrPEZ+iVMdnQDZkCxMzAai
 t92xRGKCOQaA==
X-IronPort-AV: E=McAfee;i="6200,9189,9979"; a="284670985"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="284670985"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 06:00:04 -0700
IronPort-SDR: 3M2YVPj9Xs/GVOQ6mCjyLcp7R4S09oy3hZuXpJRJuzc+uyjf45L8vxioyqHXoF4vBlOGG4qu5Z
 H5DX0mEdv6Rw==
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="470788052"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 05:59:57 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lg5Vp-00BAd3-S1; Mon, 10 May 2021 15:59:53 +0300
Date:   Mon, 10 May 2021 15:59:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        Christian Eggers <ceggers@arri.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH v2 1/9] units: Add the HZ macros
Message-ID: <YJkuSYlAipXkgSD0@smile.fi.intel.com>
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

Hmm... I think you need to rebase, add cover letter and resend.

-- 
With Best Regards,
Andy Shevchenko


