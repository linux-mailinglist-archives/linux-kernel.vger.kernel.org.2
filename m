Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552D336E0A9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 23:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhD1VEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 17:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhD1VEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 17:04:08 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A0DC06138A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 14:03:21 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id q4so19392497qtn.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 14:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=WDC8cMj9KQFGN4oBcXzeVKvPTnKsbzd/gp0dCQd3X/Q=;
        b=PWfyOCz5TRVUzpG1EnvMvWIUqUPjRWGfHRaQDh1gQrU3bm+IA8jET9L2HQs1jsgddu
         KJMUUzIo0qPq4qZ1QF4Ijkptc1ShjKY0xkgvIJnGoRpxTjka8IINMp2eAwbGqRho8QRN
         4g2d4UFc9fY8A8tiNxbklAWVZ+eIKiuYpxiaZ2BXCWKAzRw547K1ezKj+xmWddgegHsu
         NECnDTscXuhIYqkp7FhZarCow+KRdssgIwz7iTWgxwhxkRc0ubxs/YyN2kjylejK5U/t
         GHNLe3pUhmcULk7fGyYlOaB2HcxH0hHxEVgpi/8giB7fKphxewl+1cilR+A9ktR8Z+im
         0MCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=WDC8cMj9KQFGN4oBcXzeVKvPTnKsbzd/gp0dCQd3X/Q=;
        b=uSM0Sk0KQvETEElI6Q7Eu55GupYgraNox33Nt2JPkgAXfsfNbY44vo04K2u9V+hn9U
         P488Xu6Fcd0MYfuAzfgJCP4YzqjujP4bb5WGDKqmSAGp3AtQORewk7tfIVqPFFTmiON2
         uQbJ3cR7uNZBJlVzSREUnTb+Xp5RqdraeWHNnDv+j/5S0dagr8q/D3kVeBiH9gecHLe8
         sfuIbuWg8bsEtEq0YcK7Dc+Ia0r/GDN7HXP+U+/qsNSw6WOITwFXwenrX4W43d1yd0nk
         62luUsW04IuHRFHo+zQK9awHxR3TVQeSwi9fTMaaJw9QLgU5k13Uu05zWZLeD+cvJIDu
         VzIQ==
X-Gm-Message-State: AOAM532e1bjdxaBFXJyt3llg5lsNcOxzOKM4Wm2o1jFYIYqyEhAX1RFm
        Fual+pPMlosaxFtjrrpoDtXRmA==
X-Google-Smtp-Source: ABdhPJxHpUFRnQapCxPAOUFJmZDOlcbrm4ZSAzgXZrqUUfcjf4VuDgreeNK4a6SEKbnoW6EIbypMWg==
X-Received: by 2002:a05:622a:6:: with SMTP id x6mr28372136qtw.1.1619643800361;
        Wed, 28 Apr 2021 14:03:20 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k18sm676219qkg.53.2021.04.28.14.03.19
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 28 Apr 2021 14:03:19 -0700 (PDT)
Date:   Wed, 28 Apr 2021 14:03:05 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Axel Rasmussen <axelrasmussen@google.com>
cc:     Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] userfaultfd: release page in error path to avoid
 BUG_ON
In-Reply-To: <20210428183943.GH6584@xz-x1>
Message-ID: <alpine.LSU.2.11.2104281338380.9009@eggly.anvils>
References: <20210428180109.293606-1-axelrasmussen@google.com> <20210428183943.GH6584@xz-x1>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2021, Peter Xu wrote:
> On Wed, Apr 28, 2021 at 11:01:09AM -0700, Axel Rasmussen wrote:
> > Consider the following sequence of events (described from the point of
> > view of the commit that introduced the bug - see "Fixes:" below):
> > 
> > 1. Userspace issues a UFFD ioctl, which ends up calling into
> >    shmem_mcopy_atomic_pte(). We successfully account the blocks, we
> >    shmem_alloc_page(), but then the copy_from_user() fails. We return
> >    -EFAULT. We don't release the page we allocated.
> > 2. Our caller detects this error code, tries the copy_from_user() after
> >    dropping the mmap_sem, and retries, calling back into
> >    shmem_mcopy_atomic_pte().
> > 3. Meanwhile, let's say another process filled up the tmpfs being used.
> > 4. So shmem_mcopy_atomic_pte() fails to account blocks this time, and
> >    immediately returns - without releasing the page. This triggers a
> >    BUG_ON in our caller, which asserts that the page should always be
> >    consumed, unless -EFAULT is returned.
> > 
> > (Later on in the commit history, -EFAULT became -ENOENT, mmap_sem became
> > mmap_lock, and shmem_inode_acct_block() was added.)
> 
> I suggest you do s/EFAULT/ENOENT/ directly in above.

I haven't looked into the history, but it would be best for this to
describe the situation in v5.12, never mind the details which were
different at the time of the commit tagged with Fixes.  But we stay
alert that when it's backported to stable, we may need to adjust
something to suit those releases (which will depend on how much
else has been backported to them meanwhile).

> 
> > 
> > A malicious user (even an unprivileged one) could trigger this
> > intentionally without too much trouble.

I regret having suggested that. Maybe. Opinions differ as to whether
it's helpful to call attention like that. I'd say delete that paragraph.

> > 
> > To fix this, detect if we have a "dangling" page when accounting fails,
> > and if so, release it before returning.
> > 
> > Fixes: cb658a453b93 ("userfaultfd: shmem: avoid leaking blocks and used blocks in UFFDIO_COPY")
> > Reported-by: Hugh Dickins <hughd@google.com>
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Thanks for getting on to this so quickly, Axel.
But Peter is right, that unlock_page() needs removing.

> > ---
> >  mm/shmem.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 26c76b13ad23..46766c9d7151 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -2375,8 +2375,19 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
> >  	pgoff_t offset, max_off;
> >  
> >  	ret = -ENOMEM;
> > -	if (!shmem_inode_acct_block(inode, 1))
> > +	if (!shmem_inode_acct_block(inode, 1)) {
> > +		/*
> > +		 * We may have got a page, returned -ENOENT triggering a retry,
> > +		 * and now we find ourselves with -ENOMEM. Release the page, to
> > +		 * avoid a BUG_ON in our caller.
> > +		 */
> > +		if (unlikely(*pagep)) {
> > +			unlock_page(*pagep);
> 
> Not necessary?

Worse than not necessary: would trigger a VM_BUG_ON_PAGE(). Delete!

> 
> > +			put_page(*pagep);
> > +			*pagep = NULL;
> > +		}
> >  		goto out;
> 
> All "goto out" in this functions looks weird as it returns directly... so if
> you're touching this after all, I suggest we do "return -ENOMEM" directly and
> drop the "ret = -ENOMEM".

No strong feeling either way from me on that: whichever looks best
to you.  But I suspect the "ret = -ENOMEM" cannot be dropped,
because it's relied on further down too?

> 
> Thanks,
> 
> > +	}
> >  
> >  	if (!*pagep) {
> >  		page = shmem_alloc_page(gfp, info, pgoff);
> > -- 
> > 2.31.1.498.g6c1eba8ee3d-goog
> > 
> 
> -- 
> Peter Xu
