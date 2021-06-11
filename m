Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64183A3FD1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 12:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhFKKKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 06:10:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:53626 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229480AbhFKKK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 06:10:28 -0400
IronPort-SDR: H3dTZA6faqhc8Gde0/8oXJEYx2HZQipR5pGkrJ/Zht3YqE0PExP1uxyyHA6vGCL9NoDsLrg9m0
 SnxnIEWCexxg==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="269346684"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="269346684"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 03:08:15 -0700
IronPort-SDR: MMv/k8ORRTiS9Mib26HqKMo2TnhmQUC40TC7Ph8aantSp3xu9n9O9OIFcltfPILziIJbncEBdd
 wve54RVKJJLA==
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="402971775"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 03:08:12 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1lre5A-001Ttb-V4; Fri, 11 Jun 2021 13:08:08 +0300
Date:   Fri, 11 Jun 2021 13:08:08 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Joe Perches <joe@perches.com>, Jason Baron <jbaron@akamai.com>,
        Stefani Seibold <stefani@seibold.net>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jens Axboe <axboe@kernel.dk>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] scripts/spelling.txt: add some spelling pairs and
 reorder
Message-ID: <YMM2CFHe2zxIkHcT@smile.fi.intel.com>
References: <20210611071241.16728-1-thunder.leizhen@huawei.com>
 <CAHp75Vdpgpa=TDt5RgG2Eq_+iLZrRSj9XqB97y01SxhdKUYYgg@mail.gmail.com>
 <CAHp75VdJJdPTnUMVqjwMv+73nQf_-0nosS5su-GiDFRAVCbMyw@mail.gmail.com>
 <908eb849-1925-8305-a1f3-aeb48f6f4c75@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <908eb849-1925-8305-a1f3-aeb48f6f4c75@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 05:48:14PM +0800, Leizhen (ThunderTown) wrote:
> On 2021/6/11 16:10, Andy Shevchenko wrote:
> > On Fri, Jun 11, 2021 at 11:02 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> >> On Fri, Jun 11, 2021 at 10:19 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
> >>>
> >>> Add spelling_sanitizer.sh and use it to reorder, then add some spelling
> >>> "mistake||correction" pairs.
> >>
> >> The sorting idea is good, but the order is not.
> >> What you really need is to use language corpus [1] instead. So in such
> >> case you will eliminate false positives (to some extent).
> > 
> > Perhaps I need to elaborate what I meant. The (important) feature of
> > the corpus is sorting by frequency of the word usage. That's what
> 
> That's unlikely. Even if that were the case, no one could figure 'the frequency' out.

What do you mean? It's a natural sorting for the language corpus. First you get
the most used words down to less used.

> > would be the best. Unfortunately I don't know if codespell uses linear
> > search or hash based (i.o.w. does it convert the input file to the
> > Python list() or set() object?).
> 
> I think "spelling.txt" will be reprocessed by the tool.

Of course, and that's what I meant in the parentheses, i.e. to check what data
structure is used behind the scene.

> For the same set of data, if the performance differs significantly or even does not work
> due to the user's input order, the implementation of the tool itself must be problematic.
> 
> So our ranking of "spelling.txt" is how to make it easy to see.
> 
> I don't know if it's right. Pure logical reasoning.

Depends on the above it might increase the ratio of false positives.
Also it depends to the data base (spelling.txt).

What you need here is to make sure that:
 1) tool using arbitrary ordering already (by implying hash table, i.e. set()
    in Python);
 2) the current ordering is arbitrary and doesn't imply any side effects.

With this research conducted and explained, I'm fine with reordering.

> >> [1]: https://en.wikipedia.org/wiki/Corpus_of_Contemporary_American_English

-- 
With Best Regards,
Andy Shevchenko


