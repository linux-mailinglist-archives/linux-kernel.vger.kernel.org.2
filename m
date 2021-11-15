Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27E645073F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 15:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbhKOOmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 09:42:07 -0500
Received: from mga17.intel.com ([192.55.52.151]:64192 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236635AbhKOOlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 09:41:47 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="214172869"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="214172869"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 06:38:48 -0800
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="453834726"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 06:38:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mmd7z-0077SS-86;
        Mon, 15 Nov 2021 16:38:35 +0200
Date:   Mon, 15 Nov 2021 16:38:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marco Elver <elver@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Wei Liu <wei.liu@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Alexander Popov <alex.popov@linux.com>
Subject: Re: [PATCH] panic: use error_report_end tracepoint on warnings
Message-ID: <YZJw69RdPES7gHBM@smile.fi.intel.com>
References: <20211115085630.1756817-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115085630.1756817-1-elver@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 09:56:30AM +0100, Marco Elver wrote:
> Introduce the error detector "warning" to the error_report event and use
> the error_report_end tracepoint at the end of a warning report.
> 
> This allows in-kernel tests but also userspace to more easily determine
> if a warning occurred without polling kernel logs.

...

>  enum error_detector {
>  	ERROR_DETECTOR_KFENCE,
> -	ERROR_DETECTOR_KASAN
> +	ERROR_DETECTOR_KASAN,
> +	ERROR_DETECTOR_WARN

...which exactly shows my point (given many times somewhere else) why comma
is good to have when we are not sure the item is a terminator one in the enum
or array of elements.

>  };

-- 
With Best Regards,
Andy Shevchenko


