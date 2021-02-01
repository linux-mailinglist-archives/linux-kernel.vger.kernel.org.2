Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFD130AC45
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 17:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbhBAQFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 11:05:48 -0500
Received: from mga14.intel.com ([192.55.52.115]:28222 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229739AbhBAQFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 11:05:30 -0500
IronPort-SDR: CJtk6+y5BpW7ThlPvL3KEM9UNxFKUGrP8ImbEgYY6d1G9y1dkcbItdeqRgGG6/Fm+K2z55vVpU
 1x0quq8EErpQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="179929827"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="179929827"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 08:03:42 -0800
IronPort-SDR: ljDc5msUhmj/4lS3B56cYEn1l3RyBTJnAI3TFKuXb7/PJsJ7erdIUNrxtWc+L3hB5cmpPOojTk
 mSRyU9R1zN+A==
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="506891303"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 08:03:36 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l6bfo-001AXR-RA; Mon, 01 Feb 2021 18:03:32 +0200
Date:   Mon, 1 Feb 2021 18:03:32 +0200
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
Message-ID: <YBgmVDk5ECUiopCu@smile.fi.intel.com>
References: <20210201115610.87808-1-laoar.shao@gmail.com>
 <20210201115610.87808-4-laoar.shao@gmail.com>
 <66784ea1-29c7-6bed-ca7f-cd3e7ea9155b@redhat.com>
 <YBgDW6dbdT7AvCXE@smile.fi.intel.com>
 <CALOAHbAeU53py1yi7Dd-vrP6fJO1OMJXM4bVo0O3jc9iAY5UTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbAeU53py1yi7Dd-vrP6fJO1OMJXM4bVo0O3jc9iAY5UTA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 09:52:53PM +0800, Yafang Shao wrote:
> On Mon, Feb 1, 2021 at 9:34 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Feb 01, 2021 at 02:23:33PM +0100, David Hildenbrand wrote:
> > > On 01.02.21 12:56, Yafang Shao wrote:

...

> > > Printing that in addition to the raw value could be helpful. Just some
> > > thoughts.
> >
> > printf() buffer is not a black hole, esp. when you get it messed with critical
> > messages (Oops). I suggest to reduce a burden as much as possible. If you wish
> > to get this, make it caller-configurable, i.e. adding another letter to the
> > specifier.
> >
> 
> I think David's suggestion will help us to identify issues.
> 
> You mean that we should use another one like "%pGpd" - means pGp debug
> - to implement it ?

Yes.

-- 
With Best Regards,
Andy Shevchenko


