Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24553E5BAB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 15:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239036AbhHJNcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 09:32:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:19037 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236555AbhHJNcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 09:32:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="202071397"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="202071397"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 06:31:41 -0700
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="675007671"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 06:31:39 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mDRqv-007Q2t-1K; Tue, 10 Aug 2021 16:31:33 +0300
Date:   Tue, 10 Aug 2021 16:31:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chris von Recklinghausen <crecklin@redhat.com>
Cc:     pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix UBSAN splat in test_scanf
Message-ID: <YRJ/tTuj7r4jppv4@smile.fi.intel.com>
References: <20210809102013.525671-1-crecklin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809102013.525671-1-crecklin@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 06:20:13AM -0400, Chris von Recklinghausen wrote:

Thanks for the report and fix!

First of all, have you seen this:
https://lore.kernel.org/lkml/20210727150132.28920-1-andriy.shevchenko@linux.intel.com/T/#u
?

> On a system with CONFIG_UBSAN_SHIFT=y, the following splat was observed:

> [  104.676826] test_scanf: loaded.
> [  104.680862] ================================================================================
> [  104.690304] UBSAN: shift-out-of-bounds in lib/test_scanf.c:274:51
> [  104.697144] shift exponent 32 is too large for 32-bit type 'unsigned int'

As you may see in the above the rule of thumb is to include only meaningful
parts of the oops.

-- 
With Best Regards,
Andy Shevchenko


