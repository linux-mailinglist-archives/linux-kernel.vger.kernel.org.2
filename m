Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7202F3311A5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 16:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhCHPGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 10:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbhCHPGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 10:06:25 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B97C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 07:06:24 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id r24so7675872qtt.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 07:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Li3N1Y96+gEQ9rY20ifsmjZxXy9QR4Z7aERAqxrscmI=;
        b=p5gFLQwcTZK/QnM6D0BwoAMJ9RnkwInQUR+6r8Ufg7oNWKB2DVi1v2paZU/wC5vF32
         JY735yWKKLalIRCNTi0II/8UfDuOIoIKcpQqkfjvxaa4bkV+K3ZcrmGs5h5XEtSEPqSc
         Zfvz6xgnMmr1LltUJ4zTMGIdlhFJpg97l1zdpwERXfXyPW0jEaLSCRm3yfj5ot+yhOhP
         toAqx/C9Kcb11vf/PUHWElnzlSj3ggZXAROHy9HPLtPnehjEuoZR34a/pLx6lpMf/957
         wouTq+kZzUatqZuqLyfISqsVcDjv2cNZnf3m8juVAh2t4qfog97+b39FXAkxc+gdrYJT
         +GXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Li3N1Y96+gEQ9rY20ifsmjZxXy9QR4Z7aERAqxrscmI=;
        b=V0vUvdEUehslLLDG0ZjTm+W4F2v5DRPYpZ11Co7rEt5Am5yfa5gl6NAQFmCHpQMp5c
         bOUOrUCwLZRw6dM3Qltq8ifcxFxD/J6URFHMtZmbaWqD/Do5a7LiQrPW2TzhL8JONhhK
         yHwyeMcpDCnw1TsxniGZgD6tapbodnuZFBXLAskOObtvOQPxbb90Qv8fgE3OuOygakC8
         zSRqb9kEe7JMp8GDVu/+leTU/GogTAOSFRDqVzLmHDLyJdPNLn5cRSA2yaPqVxBnzJ+E
         PCcncmDqbvxbvIQuX2duRMHEKYvbxOqjp5KIIw2p3gO1UK/5r31ONDjXQM9y0aCyJMX7
         3tiA==
X-Gm-Message-State: AOAM532F4HykMG3YTwQhqT5PfjOztTnIU5nuktnOEG+RAG7LjsEllpqH
        9u/AwrxiqsolayusU9i1d20H3XXqhKz+qg==
X-Google-Smtp-Source: ABdhPJxw/2m3E1hQ2wF+0UtTras1XU6MS4mBorrO7KlAofep68NiP3T1H0+uXxQ3paWz+u74AGn4bw==
X-Received: by 2002:a05:622a:109:: with SMTP id u9mr20999436qtw.116.1615215983515;
        Mon, 08 Mar 2021 07:06:23 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:7fd0])
        by smtp.gmail.com with ESMTPSA id c186sm7889329qkb.107.2021.03.08.07.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 07:06:22 -0800 (PST)
Date:   Mon, 8 Mar 2021 10:06:20 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Saravanan D <saravanand@fb.com>, mingo@redhat.com, x86@kernel.org,
        dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH V6] x86/mm: Tracking linear mapping split events
Message-ID: <YEY9bNqysyK2ucDq@cmpxchg.org>
References: <20210218235744.1040634-1-saravanand@fb.com>
 <20210305165715.94140a44b177d0e34d59e220@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305165715.94140a44b177d0e34d59e220@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 04:57:15PM -0800, Andrew Morton wrote:
> On Thu, 18 Feb 2021 15:57:44 -0800 Saravanan D <saravanand@fb.com> wrote:
> 
> > To help with debugging the sluggishness caused by TLB miss/reload,
> > we introduce monotonic hugepage [direct mapped] split event counts since
> > system state: SYSTEM_RUNNING to be displayed as part of
> > /proc/vmstat in x86 servers
> >
> > ...
> >
> > --- a/arch/x86/mm/pat/set_memory.c
> > +++ b/arch/x86/mm/pat/set_memory.c
> > @@ -120,6 +120,10 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
> >  #ifdef CONFIG_SWAP
> >  		SWAP_RA,
> >  		SWAP_RA_HIT,
> > +#endif
> > +#ifdef CONFIG_X86
> > +		DIRECT_MAP_LEVEL2_SPLIT,
> > +		DIRECT_MAP_LEVEL3_SPLIT,
> >  #endif
> >  		NR_VM_EVENT_ITEMS
> >  };
> 
> This is the first appearance of arch-specific fields in /proc/vmstat.
> 
> I don't really see a problem with this - vmstat is basically a dumping
> ground of random developer stuff.  But was this the best place in which
> to present this data?

IMO it's a big plus for discoverability.

One of the first things I tend to do when triaging mysterious memory
issues is going to /proc/vmstat and seeing if anything looks abnormal.
There is value in making that file comprehensive for all things that
could indicate memory-related pathologies.

The impetus for adding these is a real-world tlb regression caused by
kprobes chewing up the direct mapping that took longer to debug than
necessary. We have the /proc/meminfo lines on the DirectMap, but those
are more useful when you already have a theory - they simply don't
make problems immediately stand out the same way.
