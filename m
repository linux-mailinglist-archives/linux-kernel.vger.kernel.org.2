Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC25431194A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbhBFDBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 22:01:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55300 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230334AbhBFCi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:38:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612578992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xVM8jheEqSMk2QyHpvwNWebjlFDs65NWkUd4v2wDYHc=;
        b=YRXcloxJq+dXmL/Y1HT8DPphUK4yvOBIttALdlNvgU5/c1TiD1qR8frbiAzVQqCm278eAC
        nRMgeOaS3xle6gv+9h4TUBUVB3nQpy1ycZU0MQZdrjAHiecpF8EUZ6CmF7RUYIAiPORktl
        UKhK3raBDAYWMcUxFKccMpyNE7HkzjQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-ratyq5rJNWWH_IrvDt9Y2A-1; Fri, 05 Feb 2021 21:36:30 -0500
X-MC-Unique: ratyq5rJNWWH_IrvDt9Y2A-1
Received: by mail-qv1-f71.google.com with SMTP id dh16so6430669qvb.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 18:36:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xVM8jheEqSMk2QyHpvwNWebjlFDs65NWkUd4v2wDYHc=;
        b=OYLEOwyDoA1LLdbmtREtCeu75Fzfq2WI3j66Tw0xtlFZj0oritfqS98+6DqQYS6Qkk
         J2/Wz5+4h69mwjZeCPKZ94dVsWD5z/GFhbX6fQENL3vh81prv5emzpmcvmMk4hlfrUiD
         jt749TikvtvJaaVlfVHY0DQVIPMx5bSCAWgTcehQKBM8HfPmpV7uKqjm6skpHk7G3RDP
         qMVOX+r5Mgr35hvN5SdhdChHHVzWCeGMPyCnS2YOrNqPsLNzQR7hyH3HTG6EwHp7/QfB
         uBymOtx5f+yzhzfoyOlu9oNPAMbMOvmnpoomvBms0eOEt4xH+xPK/nHh4Te+NaQFSJwY
         2Z2A==
X-Gm-Message-State: AOAM533hOm+CRIHH0dccl7ncanQp4lm1RUDLYEwL9UumznmyoZlTFrtj
        MJ0uTXOhFG2TN5Vrukc91ut8llMRWiSFZqn/4xiLmMZ51nFLIlgbjt2RljUcqOL24O7MmvCfa45
        ZNGQDF2QB5t3YuY48vB+aYivJ
X-Received: by 2002:a0c:b49f:: with SMTP id c31mr7466420qve.35.1612578990205;
        Fri, 05 Feb 2021 18:36:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwoex5HpvPBM5UvEfsNE1ESwri7iRSz/V+1Pew+eLURB2aJovcfzWvRPgnMa/eebtLPb7GYuQ==
X-Received: by 2002:a0c:b49f:: with SMTP id c31mr7466406qve.35.1612578989882;
        Fri, 05 Feb 2021 18:36:29 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id 17sm12540565qtu.23.2021.02.05.18.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 18:36:29 -0800 (PST)
Date:   Fri, 5 Feb 2021 21:36:27 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH RFC 00/30] userfaultfd-wp: Support shmem and hugetlbfs
Message-ID: <20210206023627.GD3195@xz-x1>
References: <20210115170907.24498-1-peterx@redhat.com>
 <20210129224938.GC260413@xz-x1>
 <339d27e8-9f34-3e80-2910-46f46d58e9a6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <339d27e8-9f34-3e80-2910-46f46d58e9a6@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 01:53:34PM -0800, Mike Kravetz wrote:
> On 1/29/21 2:49 PM, Peter Xu wrote:
> > On Fri, Jan 15, 2021 at 12:08:37PM -0500, Peter Xu wrote:
> >> This is a RFC series to support userfaultfd upon shmem and hugetlbfs.
> ...
> > Huge & Mike,
> > 
> > Would any of you have comment/concerns on the high-level design of this series?
> > 
> > It would be great to know it, especially major objection, before move on to an
> > non-rfc version.
> 
> My apologies for not looking at this sooner.  Even now, I have only taken
> a very brief look at the hugetlbfs patches.
> 
> Coincidentally, I am working on the 'BUG' that soft dirty does not work for
> hugetlbfs.  As you can imagine, there is some overlap in handling of wp ptes
> set for soft dirty.  In addition, pmd sharing must be disabled for soft dirty
> as here and in Axel's uffd minor fault code.

Interesting to know that we'll reach and need something common from different
directions, especially when they all mostly happen at the same time. :)

Is there a real "BUG" that you mentioned?  I'd be glad to read about it if
there is a link or something.

> 
> No objections to the overall approach based on my quick look.

Thanks for having a look.

So for hugetlb one major thing is indeed about the pmd sharing part, which
seems that we've got very good consensus on.

The other thing that I'd love to get some comment would be a shared topic with
shmem in that: for a file-backed memory type, uffd-wp needs a consolidated way
to record wr-protect information even if the pgtable entries were flushed.
That comes from a fundamental difference between anonymous and file-backed
memory in that anonymous pages keep all info in the pgtable entry, but
file-backed memory is not, e.g., pgtable entries can be dropped at any time as
long as page cache is there.

I goes to look at soft-dirty then regarding this issue, and there's actually a
paragraph about it:

        While in most cases tracking memory changes by #PF-s is more than enough
        there is still a scenario when we can lose soft dirty bits -- a task
        unmaps a previously mapped memory region and then maps a new one at
        exactly the same place. When unmap is called, the kernel internally
        clears PTE values including soft dirty bits. To notify user space
        application about such memory region renewal the kernel always marks
        new memory regions (and expanded regions) as soft dirty.

I feel like it just means soft-dirty currently allows false positives: we could
have set the soft dirty bit even if the page is clean.  And that's what this
series wanted to avoid: it used the new concept called "swap special pte" to
persistent that information even for file-backed memory.  That all goes for
avoiding those false positives.

> 
> I'll try to take a closer look at the areas where efforts overlap.

I dumped above just to hope maybe it could help a little bit more for the
reviews, but if it's not, I totally agree we can focus on the overlapped part.
And, I'd be more than glad to read your work too if I can understand more on
what you're working on with the hugetlb soft dirty bug, since I do feel uffd-wp
is servicing similar goals just like what soft-dirty does, so we could share a
lot of common knowledge there. :)

Thanks again!

-- 
Peter Xu

