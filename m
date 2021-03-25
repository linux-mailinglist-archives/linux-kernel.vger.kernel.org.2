Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8960A349304
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhCYNYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:24:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:7598 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229731AbhCYNXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:23:47 -0400
IronPort-SDR: o0ZTxGrFrj72cbYX36iDdY7EUOiQLoNcVQdU6o2sufIAenHjrtAdCuwak3/01eaoxdOH/F/zrE
 oxOFzOSUd9Fw==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="188628354"
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="188628354"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 06:23:47 -0700
IronPort-SDR: j2N33Qd84WMcvnjdw27sNTAmh6DExk6dS+RDKkgYTwUzZhsG6p6MlvV+YRPOqzWUwOI+0oiAU3
 oRmrbEpLLV6w==
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="375068246"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 06:23:44 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lPPxb-00G3Ks-0i; Thu, 25 Mar 2021 15:23:39 +0200
Date:   Thu, 25 Mar 2021 15:23:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Subject: Re: [PATCH] include: linux: debug_locks: Remove duplicate declaration
Message-ID: <YFyO2/AtZ6RHkTVU@smile.fi.intel.com>
References: <20210325022707.840531-1-wanjiabing@vivo.com>
 <YFyOjtTI8XXPKgph@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFyOjtTI8XXPKgph@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 03:22:22PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 25, 2021 at 10:26:58AM +0800, Wan Jiabing wrote:
> > struct task_struct is declared at 9th line. Remove the duplicate.
> 
> It seems the duplicate is the other one and you removed wrong one.

Okay, they are on the same level of ifdeffery, technically there is no
difference. Practically the other one closer to its user.

-- 
With Best Regards,
Andy Shevchenko


