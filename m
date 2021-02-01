Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83EF30AC86
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 17:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhBAQWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 11:22:15 -0500
Received: from mga01.intel.com ([192.55.52.88]:41319 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhBAQWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 11:22:11 -0500
IronPort-SDR: m1lGYe59Xhe5Q0BKaLZ8rq83nN51PXKJxKYL5HOjWs+8+Ozw2lXgt4Df+8+fPNKOqpunCvvQ1w
 XpA76M7MmP8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="199607947"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="199607947"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 08:20:24 -0800
IronPort-SDR: VChN+z2PsLbbaH3QYpdR7+a57+dLBAuownRnMSXs03PWiKTspxmN93maOO9q+J/T+7ajyPOynY
 40CnXxD4fhZA==
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="358646170"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 08:20:20 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l6bvz-001AkA-UR; Mon, 01 Feb 2021 18:20:15 +0200
Date:   Mon, 1 Feb 2021 18:20:15 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Christoph Lameter <cl@linux.com>, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 3/3] vsprintf: dump full information of page flags in
 pGp
Message-ID: <YBgqP78VEoE9G8Yf@smile.fi.intel.com>
References: <20210201115610.87808-1-laoar.shao@gmail.com>
 <20210201115610.87808-4-laoar.shao@gmail.com>
 <YBgBxaFSy8P/nrcH@smile.fi.intel.com>
 <CALOAHbAUPCUfZp_58QbVzvbP2UqoPqHAzzsgk1UTZ95v1rtqTw@mail.gmail.com>
 <YBgpavcZD4VXZri6@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBgpavcZD4VXZri6@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 06:16:42PM +0200, Andy Shevchenko wrote:
> On Mon, Feb 01, 2021 at 09:49:59PM +0800, Yafang Shao wrote:
> > On Mon, Feb 1, 2021 at 9:27 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Feb 01, 2021 at 07:56:10PM +0800, Yafang Shao wrote:

...

> > The existing one should be more important than the added one.
> > But the order of output will not match with the value for page->flags.
> > E.g.
> >     flags=0x17ffffc0010200(slab|head,Node 0,Zone 2,Lastcpupid 0x1fffff)
> > It may be strange to compare the value with the string.
> 
> More I'm looking at it, more I'm thinking it should have different specifiers
> for each group of desired flags to be printed.
> 
> So, you leave %pGp as is and then add another letter to add more details, so
> user will choose what and in which order they want.
> 
> For example, let's assume %pGp == %pGpf and P is a new specifier for what you
> are initially adding here:
> 
>   %pGpfP => referenced|uptodate|lru|active|private,Node 0,Zone 2
>   %pGpPf => Node 0,Zone 2,referenced|uptodate|lru|active|private
> 
> and so on.

And I agree with Matthew about format, but it doesn't oppose my suggestion
above.

-- 
With Best Regards,
Andy Shevchenko


