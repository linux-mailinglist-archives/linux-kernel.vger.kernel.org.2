Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD10397A7A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 21:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbhFATMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 15:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbhFATMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 15:12:33 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A77C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 12:10:51 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id k4so15472249qkd.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 12:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=MFawdZO8qw31LqF1YNPnBQn4vTvNybwM9oOXVgye56w=;
        b=ZQybl2DUCslmE5zuIPFnC434vrcQxWIlga+QSn3bsxaah8EC05cuOMDYytbpNslCuV
         wIB03QlJD8Bf7Xzzk7R0JOsDKLdijGQqy9EZDnmgypXfx4DqaEG5HUbIFLRxWdMjW3M3
         x4n+qqaRnqiVQXkxGKuI9PX7kpx8rEzaT2RSDXtUGkPU1/9ubWQdOZXmFtW83i1tOgCE
         LnRZAD31PBCiX9jlnJ7yLn0Nf1Eu0pBxUvt+ZiFjsy/sZK9Vp2RAYwZQd6FOVbIegCxW
         O3bvFTk54kqrf0mqmC9daGO6HzVpEanjnOWr07bdch+SsFTRsgSCmtgm2HyHRT5rBkfz
         Qywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=MFawdZO8qw31LqF1YNPnBQn4vTvNybwM9oOXVgye56w=;
        b=BJTWPsOVDOOQIKBkcN8/IIX45V+GaaJOTNuwirCJGjmakSeEG6P6Y2qNU4kPmmN5Q2
         SgE1CFPh3I11aTzGIFysIZKYXfIm+05EtdWmRdqkrgBikr+vl88XmGA8C4YIHq0zfbUL
         8ioL10Lc1cqQOpzDKVXzNq+2nIdNXzDVsnsk7uKGmRHQxnONw+3hLHQSczkM0Q9dKdmK
         a/T08ROm06kFagVm70RblP7dD6aNgeHFmOfG/nXvdZ5jUyxbtOwa6z0rQlT/0sjpVMNa
         7ZKn0oD+wavRMFha1GSwThpDIpQSGcjdEvO8VQfR94sRxExErWJTYpHH72kTlVK8NBac
         GBdQ==
X-Gm-Message-State: AOAM533nB0Oa3K7tpygfploopsu3VUeJII1fKKhpqVW7yJHAVGfFEoKU
        9yKdb08pxbtUuY0wCd1sFZe2sg==
X-Google-Smtp-Source: ABdhPJwhCdbmRQb7qVOI9FKquZ+yAv16YOjwlJo0usOfM+ayYHiegotPle8om3w+dPdzgqwHA3ATgA==
X-Received: by 2002:a37:7145:: with SMTP id m66mr23082124qkc.379.1622574650524;
        Tue, 01 Jun 2021 12:10:50 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id o22sm1101915qtq.89.2021.06.01.12.10.49
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 01 Jun 2021 12:10:50 -0700 (PDT)
Date:   Tue, 1 Jun 2021 12:10:48 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>, Xu Yu <xuyu@linux.alibaba.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, gavin.dg@linux.alibaba.com,
        Greg Thelen <gthelen@google.com>, Wei Xu <weixugc@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm, thp: relax migration wait when failed to get tail
 page
In-Reply-To: <YLZqKJ4anEGpAZfp@casper.infradead.org>
Message-ID: <alpine.LSU.2.11.2106011114580.1045@eggly.anvils>
References: <bc8567d7a2c08ab6fdbb8e94008157265d5d28a3.1622564942.git.xuyu@linux.alibaba.com> <alpine.LSU.2.11.2106010947370.1090@eggly.anvils> <YLZqKJ4anEGpAZfp@casper.infradead.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jun 2021, Matthew Wilcox wrote:
> On Tue, Jun 01, 2021 at 09:55:56AM -0700, Hugh Dickins wrote:
> > 
> > Well caught: you're absolutely right that there's a bug there.
> > But isn't cond_resched() just papering over the real bug, and
> > what it should do is a "page = compound_head(page);" before the
> > get_page_unless_zero()? How does that work out in your testing?
> 
> You do realise you're strengthening my case for folios by suggesting
> that, don't you?  ;-)

Hah! Well, I do realize that I'm offering you a marketing opportunity.
And you won't believe how many patches I dread to post for fear of that ;-)

But I'm not so sure that it strengthens your case: apparently folios
had not detected this?  Or do you have a hoard of folio-detected fixes
waiting for the day, and a folio-kit for each of the stable releases?

> 
> I was going to suggest that it won't make any difference because the
> page reference count is frozen, but the freezing happens after the call
> to unmap_page(), so it may make a difference.

I think that's a good point: I may have just jumped on the missing
compound_head(), without thinking it through as far as you have.

I'm having trouble remembering the dynamics now; but I think there
are cond_resched()s in the unmap_page() part, so the splitter may
get preempted even on a non-preempt kernel; whereas the frozen
part is all done expeditiously, with interrupts disabled.

Greg discovered the same issue recently, but we all got sidetracked,
and I don't know where his investigation ended up.  He was in favour
of cond_resched(), I was in favour of compound_head(); and I think I
was coming to the conclusion that if cond_resched() is needed, it
should not be there in __migration_entry_wait(), but somewhere up
in mm/gup.c, so that other faults that retry, expecting to reschedule
on return to userspace, do not get trapped in kernelspace this way.

Waiting on migration entries from THP splitting is an egregious
example, but others may be suffering too.

Hugh
