Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6753078C7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 15:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhA1Ozh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 09:55:37 -0500
Received: from mga14.intel.com ([192.55.52.115]:43766 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232093AbhA1OwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 09:52:15 -0500
IronPort-SDR: UFCMLpLVRVM0h7S/BradE+l7gO5glLQ0b2i4c4Z8nwJGI8a2FGkGOWZdX2ABHZwpoZ4UHo7Hmw
 zwkPP6BvxkqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="179461560"
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; 
   d="scan'208";a="179461560"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 06:50:30 -0800
IronPort-SDR: u4n4TMgqT90ApYC1tY2cmk2pdY+umiWpga+sUTa6uZD/jBdyeY6Tdvz9+WFVyf7OQLXAyrsbcv
 ZCbqKUOwRGxA==
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; 
   d="scan'208";a="354197851"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 06:50:25 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l58cn-0004Pc-5q; Thu, 28 Jan 2021 16:50:21 +0200
Date:   Thu, 28 Jan 2021 16:50:21 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] printk: dump full information of page flags in pGp
Message-ID: <YBLPLRZ7GXILXuyM@smile.fi.intel.com>
References: <20210128021947.22877-1-laoar.shao@gmail.com>
 <20210128021947.22877-4-laoar.shao@gmail.com>
 <YBKp/NHanaN4e0im@smile.fi.intel.com>
 <CALOAHbA+MV9Xi5Ge--6F+e9bqouJvXfWmqP6ucvUkX8CWNuQPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbA+MV9Xi5Ge--6F+e9bqouJvXfWmqP6ucvUkX8CWNuQPw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 09:18:24PM +0800, Yafang Shao wrote:
> On Thu, Jan 28, 2021 at 8:11 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> Thanks for the explanation.
> I will change it as you suggested.

You are welcome!

Just note, that kasprintf() should work for this as well as for the rest
printf() cases. That's why it's very important to return proper buffer pointer.

Also read `man snprintf(3)` RETURN VALUE section to understand it.

-- 
With Best Regards,
Andy Shevchenko


