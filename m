Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17E0373DCC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 16:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbhEEOke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 10:40:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:34880 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232919AbhEEOk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 10:40:28 -0400
IronPort-SDR: tdB2uNvJ/LXe4g5ar1Jk+fo2Yfm2nilJV1NtUNs/ol8IFVnxILxymWNGMlpYnmAKIa4aIzbLuK
 C1GSTEFKAVjg==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="178448126"
X-IronPort-AV: E=Sophos;i="5.82,275,1613462400"; 
   d="scan'208";a="178448126"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 07:39:18 -0700
IronPort-SDR: XZ5IviLdQ+f5E/oFWIhUWRCETarxu2IT6+vdkaoRWdNqeR70mAw4TbIuWIyugPAw1K96F2pgUI
 udlZyCaz0lFw==
X-IronPort-AV: E=Sophos;i="5.82,275,1613462400"; 
   d="scan'208";a="406570372"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 07:39:18 -0700
Date:   Wed, 5 May 2021 07:39:16 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH] sched: Work around undefined behavior in sched class
 checking
Message-ID: <20210505143916.GS4032392@tassilo.jf.intel.com>
References: <20210505033945.1282851-1-ak@linux.intel.com>
 <YJI/OwoflyY2IXvf@hirez.programming.kicks-ass.net>
 <875yzxh8j8.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yzxh8j8.fsf@oldenburg.str.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Context:
> 
>   <https://lore.kernel.org/lkml/20210505033945.1282851-1-ak@linux.intel.com/>
> 
> Obviously, GCC doesn't do this in general. 

We've seen it in other cases before, that's why RELOC_HIDE exists.
A classic case was __pa_symbol()

That dates back nearly two decades at this point.

>  Would you please provide a
> minimal test case?

You can only reproduce it with a LTO build because it needs knowledge
between different translation units for this specific case.

But gcc will totally do the optimization even without LTO if it can
prove the same inside a single TU.

If you want to reproduce it you can use my tree here
git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc lto-5.12-3
and revert the fix. The kernel will not boot.

-Andi
