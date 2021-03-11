Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58344337304
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbhCKMtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:49:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:53500 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232825AbhCKMtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:49:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615466958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D4xUYx/BDSZxiqahQ+yhhPAeEk7mnpJi5OROTIn6COI=;
        b=CjUV+LYOCvcnM6tveQ54vicvPtfku/X34ZAVkFBMuWL8JaZdNBL0DsMAk/egV1uFDdmugf
        ChFcSUsMbg8e02lMtgZ60Nsrpuoujxlzyk23/Boe0OKUUgeySF/UUOuOLrHc5MNcx5FR9P
        8OPqgJoI8VVGQz1Lw1CysvrNcZGoXHQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D78DDAC17;
        Thu, 11 Mar 2021 12:49:17 +0000 (UTC)
Date:   Thu, 11 Mar 2021 13:49:17 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, tglx@linutronix.de,
        john.ogness@linutronix.de, urezki@gmail.com, ast@fb.com,
        Eric Dumazet <edumazet@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] hugetlb: select PREEMPT_COUNT if HUGETLB_PAGE for
 in_atomic use
Message-ID: <YEoRzSw4xoEY6SPv@dhcp22.suse.cz>
References: <20210311021321.127500-1-mike.kravetz@oracle.com>
 <YEnY5hWLT/en7kw1@hirez.programming.kicks-ass.net>
 <YEncYrWCVn2/20/C@dhcp22.suse.cz>
 <YEnjqLpGU2LHaysv@hirez.programming.kicks-ass.net>
 <YEnmmK42kpeB3Ho4@dhcp22.suse.cz>
 <YEnochPwIyAsiEWS@hirez.programming.kicks-ass.net>
 <YEn6W0RcjNiP0N0P@dhcp22.suse.cz>
 <YEoA08n60+jzsnAl@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEoA08n60+jzsnAl@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11-03-21 12:36:51, Peter Zijlstra wrote:
[...]
> Also, Linus hates constructs like this:
> 
>   https://lkml.kernel.org/r/CAHk-=wht7kAeyR5xEW2ORj7m0hibVxZ3t+2ie8vNHLQfdbN2_g@mail.gmail.com

Btw. I would really appreciate if somebody would explain why it is
_fundamentally broken_ to check for an atomic context and chose a
different handling in a code path, like put_page, which is out of hands
of the called context? This can be called from a wide variety of
contexts. There is no way to pass a context information to the called
function. I do recognize that this is not an act of beauty but why
fundamentally broken?

The put_page context can certainly work towards robustness and operate
on the most restrictive context grounds (I really hope nobody will ever
come up with an idea that put_page can be called from nmi context). This
can make the code more complex and less optimal in normal case (e.g.
hugetlb is almost never freed from an atomic context - one has to be
really creative to achieve that). So where do we draw a line?

-- 
Michal Hocko
SUSE Labs
