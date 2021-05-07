Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46580376714
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 16:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237656AbhEGOgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 10:36:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40588 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235979AbhEGOgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 10:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620398101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rgJM7rcwdpqiWcKrLGLGEmzPVdrTnOgLXsD7YCtl+rM=;
        b=fPVP9M4EW18Zh5VLBFw4BYFI7grp0Qu9Pb14sZN9nXHN0lC/xHrygQfSZ+kQwY47A9m7/B
        zbvEwgxoMolqPpvAPMeOaDP7HAAkjYO6jV/7DvsI9TsL5plq4lJiC8BUUHLCmkwSUCJ1Yb
        wctQ2RmJuu/Eef1LpLmXebgwadmPdAo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-g-pFlMhXOhSD-fdqUzKT7Q-1; Fri, 07 May 2021 10:34:59 -0400
X-MC-Unique: g-pFlMhXOhSD-fdqUzKT7Q-1
Received: by mail-qv1-f71.google.com with SMTP id x6-20020a0cda060000b02901c4b3f7d3d9so6789917qvj.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 07:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rgJM7rcwdpqiWcKrLGLGEmzPVdrTnOgLXsD7YCtl+rM=;
        b=HC/sGXeZy2yRVxvTnFxofDAM0obdN054QuG190bYUmh5nc/7txdOoSsMdb3dfmiPzG
         UxYAQ9bMsgMc4/4n90EPtjmcAqw/kQSJ+l7XQcbgpQnfJx0A8a2RbCP3DCbxNggpkgnE
         tliU8Y8unrxG31cUccrER52JpaBO/U3ygPyNfVLD2oCGe3j6l4QyCS734vyrEBmrymnc
         vIFLlmX7EyjTYacs7AxeKh2C5qSjaSpW04m1WjaNdiGGnv3yvWBH0xt+xATdTEfjR+Nh
         FsatQm0z+n/LS9SnCxzVLsXQW8ssLJsGRw6FXdhSVBrebTymBPEKSevqy+dOYj86LEeE
         Ll+A==
X-Gm-Message-State: AOAM530tcIIlFlO10oHjD6Rlt8DeOqKqekrYc09vFTd27dNv113nABLw
        aH2ziC/UfEPblMjVUYl9wCLDPPhRXm9vllyUm12X8plcDMIVTT0S3Ouz+sVFgxdAMCY8rqjlK29
        QE9MXDSValutKyZyYdnkzN8VT
X-Received: by 2002:a05:6214:486:: with SMTP id ay6mr9888773qvb.18.1620398098776;
        Fri, 07 May 2021 07:34:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/F5OaDko+vZfUHXfSJhKl5aMCi2Pl+T2EqSPFraTJjI2uArYbRY1NZZFlC9bDPNCS/RWtDQ==
X-Received: by 2002:a05:6214:486:: with SMTP id ay6mr9888747qvb.18.1620398098551;
        Fri, 07 May 2021 07:34:58 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id 67sm4999948qtf.54.2021.05.07.07.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 07:34:57 -0700 (PDT)
Date:   Fri, 7 May 2021 10:34:56 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 3/3] mm: gup: pack has_pinned in MMF_HAS_PINNED
Message-ID: <YJVQEGSLil7wYhEe@t490s>
References: <20210506232537.165788-1-peterx@redhat.com>
 <20210506232537.165788-4-peterx@redhat.com>
 <69055843-185d-20ea-213b-10494a2f7246@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <69055843-185d-20ea-213b-10494a2f7246@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 11:42:59PM -0700, John Hubbard wrote:
> > +#define MMF_HAS_PINNED		28	/* FOLL_PIN has run, never cleared */
> 
> How about this instead, so that we effectively retain the comment block
> that is otherwise being deleted from mm.h:
> 
> /*
>  * MMF_HAS_PINNED: Whether this mm has pinned any pages.  This can be either
>  * replaced in the future by mm.pinned_vm when it becomes stable, or grow into a
>  * counter on its own. We're aggresive on this bit for now: even if the pinned
>  * pages were unpinned later on, we'll still keep this bit set for the lifecycle
>  * of this mm, just for simplicity.
>  */
> #define MMF_HAS_PINNED		28	/* FOLL_PIN ran. Never cleared. */

Sure, good to know the comment is still valid!

> > @@ -1292,8 +1292,8 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
> >   		BUG_ON(*locked != 1);
> >   	}
> > -	if (flags & FOLL_PIN && !atomic_read(&mm->has_pinned))
> > -		atomic_set(&mm->has_pinned, 1);
> > +	if (flags & FOLL_PIN && !test_bit(MMF_HAS_PINNED, &mm->flags))
> > +		set_bit(MMF_HAS_PINNED, &mm->flags);
> 
> I expect this suggestion to be controversial, but I'm going to float it
> anyway. The above is a little less clear than it used to be, *and* it is
> in two places so far, so how about factoring out a tiny subroutine, like this:

Definitely less "controversial" than expected, isn't it? ;)

Thanks for the suggestion, it looks much better indeed.  Also I'll rename the
helper to mm_set_has_pinned_flag() as suggested by Matthew.

-- 
Peter Xu

