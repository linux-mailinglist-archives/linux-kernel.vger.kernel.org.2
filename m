Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554B533AA0F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 04:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhCODh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 23:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhCODhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 23:37:33 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10E0C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 20:37:33 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id z13so31939309iox.8
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 20:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A6CY6cKc95xTq+TlSR1oRBY2LuTAiSqefWIbt2lRRJM=;
        b=Ij/PZKQnNuHvmX7UXF1zWmqCCfLzDUCyKJgxu1E5SQJ3RLPSfLQ1L/Jh6HO7JizyOz
         vSKBD3WJCRIe/4EBhifp2WsofgYnzZ6tbN7eYNyo1G/6xQ6j9aQlVf2imasgWeMUQpf7
         vbOdd5jQlpmtZC4n1g03i07MQI8AOrDgRg/EEm5NjS+Pc3794vM/c59a+ca34zz2JBqd
         chzFANTXdPnr313QcpyizyQ4JzgMMsipzcEisI/qsXS2wQLXFut3SDok8SPToABFjVB7
         MiYiSifcRrLXOhsKjAZzQN/NIv5x4iYwa/pJ/twMor/9i00oxvvpLh8hmnR6IWKt1M5U
         bj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A6CY6cKc95xTq+TlSR1oRBY2LuTAiSqefWIbt2lRRJM=;
        b=hrg9A53cT3jHwovGKMAlq6zL65NWQMm3kuZu8RiNQsO12lIxvyP385A2guTbG14KS1
         WPAu3h33iYe9YysxQ/iwxUIahtv1aAlA9pLLT8omvkMRdq5QDwlHW3ZUIxhAaiJqhTGp
         9TGV6K4kI39OE1qiYOwVCY4AY8k2UTBNVmfZll3KzzUGTLymdslz5ezPws74lMgFtsTG
         zuFGnhcFoidrKdc+RD7p7WGrVQ0rBziVelvmrIlUG6yPJ0C0ki/+EJZu8U2figzX3xDW
         ic+bdFVUPGZYSMH8HyCw2Wycu7jqat+eSl1tAW4M1mZxrTlWKMZWwqdFYM35anoi/Pgd
         5gyw==
X-Gm-Message-State: AOAM530p1N6BPgNdjtkMGahFg6xmCClhiF2H9DYzzsawCQKTgZxGrZ/j
        DLjuwTepinvqF9qM1yqYF51WqA==
X-Google-Smtp-Source: ABdhPJwKUPdTlbWTs97YHCpuc081aR0MY8JOLfj7riMvasMxJrce3DnhrHVKuVjoIZRdjcJzRK7rIw==
X-Received: by 2002:a5d:9f4a:: with SMTP id u10mr6035206iot.186.1615779452941;
        Sun, 14 Mar 2021 20:37:32 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:4d84:eb70:5c32:32b8])
        by smtp.gmail.com with ESMTPSA id q207sm6643816iod.6.2021.03.14.20.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 20:37:32 -0700 (PDT)
Date:   Sun, 14 Mar 2021 21:37:27 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     linux-mm@kvack.org, Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, page-reclaim@google.com
Subject: Re: [PATCH v1 10/14] mm: multigenerational lru: core
Message-ID: <YE7Wd+0t3G/3hc/c@google.com>
References: <20210313075747.3781593-1-yuzhao@google.com>
 <20210313075747.3781593-11-yuzhao@google.com>
 <871rchw4x2.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rchw4x2.fsf@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2021 at 07:02:01PM -0700, Andi Kleen wrote:
> Yu Zhao <yuzhao@google.com> writes:

Hi Andi!

Recovering the context a bit:

		err = -EBUSY;

> > +
> > +#ifdef CONFIG_MEMCG
> > +		if (memcg && atomic_read(&memcg->moving_account))
> > +			goto contended;
> > +#endif
> > +		if (!mmap_read_trylock(mm))
> > +			goto contended;
> 
> These are essentially spinloops. Surely you need a cpu_relax() somewhere?

contended:
		...
		cond_resched();
	} while (err == -EAGAIN && !mm_is_oom_victim(mm) && !mm_has_migrated(mm, memcg));

So if it's contended, we break the loop.

> In general for all of spinloop like constructs it would be useful to
> consider how to teach lockdep about them.
> 
> > +	do {
> > +		old_flags = READ_ONCE(page->flags);
> > +		new_gen = ((old_flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
> > +		VM_BUG_ON_PAGE(new_gen < 0, page);
> > +		if (new_gen >= 0 && new_gen != old_gen)
> > +			goto sort;
> > +
> > +		new_gen = (old_gen + 1) % MAX_NR_GENS;
> > +		new_flags = (old_flags & ~LRU_GEN_MASK) | ((new_gen + 1UL) << LRU_GEN_PGOFF);
> > +		/* mark page for reclaim if pending writeback */
> > +		if (front)
> > +			new_flags |= BIT(PG_reclaim);
> > +	} while (cmpxchg(&page->flags, old_flags, new_flags) !=
> > old_flags);
> 
> I see this cmpxchg flags pattern a lot. Could there be some common code
> factoring?

Thanks for noticing this. A shorthand macro would be nice. Hmm... let
me investigate. I don't know how to do this off the top of my head:

A macro can be used like

  cmpxchg_macro() {
     func();
  }

without backslashes and it'll be expanded to

  do {
     func();
   } while ();
