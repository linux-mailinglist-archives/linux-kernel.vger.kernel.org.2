Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55154415411
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 01:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238518AbhIVXqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 19:46:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40849 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238517AbhIVXqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 19:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632354286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ne0ywWngZHBSJ8dAIWoxHtO3qWVXQfT+1+GXEa8/WYk=;
        b=GY3+DngfEsjpFkqeqB8qwx+IbIpp5DoVVaoB59mK4Dkni22xd8GUeTGeZ8h8Um8HAS1pVh
        joFed9W8aDt6VfjzmfpUL2GZuESNI3bIQR5BYlnJNRl0z1onZ95cM0Fxu5x41CKjqV/8gD
        xAn3NxnyNxNneHIbc1Qku8XxTIOCr8k=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104--MUxs4alN7yYZRtuJ9_Cow-1; Wed, 22 Sep 2021 19:44:45 -0400
X-MC-Unique: -MUxs4alN7yYZRtuJ9_Cow-1
Received: by mail-qv1-f70.google.com with SMTP id z6-20020a056214060600b0037a3f6bd9abso16192586qvw.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 16:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ne0ywWngZHBSJ8dAIWoxHtO3qWVXQfT+1+GXEa8/WYk=;
        b=V0wqmekaoZYn9ganVG0zD36ZHpZ+nLmfh3043Q6H+vw580ZwwBWvcYsfoqpkDpbTuQ
         grQ8y/gh/xQ6TOt1O4VIbuv0Ojr4qcov9ryoDQpJ2CIef9a3ao/fj9IH2uXJDY7gNAwA
         JVYA+e8vCxYGtc5ybIJB5OfUUc+OM747ntF7JvOq6U+g+uIKR5yEzCDeKyGS2g8WOcdR
         UOTWcaLtUCFSFSuFCFEuYGR2RFBA5F6jQuMR1VM1iYB3Ku1uSt6hFRAP0R3Q7D2cfxgU
         6ieU0Mk2YjaZzrILACcZwiLyQNCf72Ukdx+EmsjBTGKfkN7+RsNPXagSELGtZGbMuCbo
         jFKw==
X-Gm-Message-State: AOAM532GZbWApRukifJerkL7EA5CPKNUP/hYgRHEpBlbeYY2xkinzGSM
        HSD+KGT8/89mX+l44iBnFt7n9pRBG/6YrcZ5OIfIE9lZRzEjCZEzK/jRRUEuyVjtaIs8kfU7UEh
        r3mDdrrPD39ryy4e9OmQwRnoy
X-Received: by 2002:ac8:6112:: with SMTP id a18mr2095038qtm.120.1632354284959;
        Wed, 22 Sep 2021 16:44:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrpGgdy4IzBHebYvi/26Kw8sVv+UUWE4AJ4iQwt2K6Ve0g5KvZwqr66BpyRZ+rUhLREAurbA==
X-Received: by 2002:ac8:6112:: with SMTP id a18mr2095024qtm.120.1632354284739;
        Wed, 22 Sep 2021 16:44:44 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d3ec])
        by smtp.gmail.com with ESMTPSA id d17sm2475932qte.0.2021.09.22.16.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 16:44:44 -0700 (PDT)
Date:   Wed, 22 Sep 2021 19:44:42 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH] mm/khugepaged: Detecting uffd-wp vma more efficiently
Message-ID: <YUu/6lWX92WLUzpt@t490s>
References: <20210922175156.130228-1-peterx@redhat.com>
 <CAJHvVch3g_UY-akMdu0O9413iCb1H83DLhR1Am8WnfUyV=s1=g@mail.gmail.com>
 <YUueOUfoamxOvEyO@t490s>
 <24224366-293a-879-95db-f69abcb0cb70@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <24224366-293a-879-95db-f69abcb0cb70@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 04:18:09PM -0700, Hugh Dickins wrote:
> On Wed, 22 Sep 2021, Peter Xu wrote:
> > 
> > Not installing pmd means uffd-minor can still trap any further faults just like
> > before, afaiu.
> > 
> > There's a very trivial detail that the pmd missing case will have a very slight
> > code path change when the next page fault happens: in __handle_mm_fault() we'll
> > first try to go into create_huge_pmd() once, however since shmem didn't provide
> > huge_fault(), we'll go the VM_FAULT_FALLBACK path, and things will go like
> > before when faulting on a small pte.  The next UFFDIO_CONTINUE will allocate
> > that missing pmd again, however it'll install a 4K page only.
> 
> I think you're mistaken there.
> 
> I can't tell you much about ->huge_fault(), something introduced for
> DAX I believe; but shmem has managed pmd mappings without it, since
> before ->huge_fault() was ever added.

Right, I wanted to express we didn't go into there, hence no way to allocate
pmd there.

> 
> Look for the call to do_set_pmd() in finish_fault(): I think you'll
> find that is the way shmem's huge pmds get in.
> 
> Earlier in the thread you suggested "shmem_getpage() only returns
> small pages": but it can very well return PageTransCompound pages,
> head or tail, which arrive at this do_set_pmd().

But note that uffd-minor will trap the shmem fault() even if pmd_none:

	page = pagecache_get_page(mapping, index,
					FGP_ENTRY | FGP_HEAD | FGP_LOCK, 0);

	if (page && vma && userfaultfd_minor(vma)) {
		if (!xa_is_value(page)) {
			unlock_page(page);
			put_page(page);
		}
		*fault_type = handle_userfault(vmf, VM_UFFD_MINOR);
		return 0;
	}

That's why I think it'll be fine, because it should only be UFFDIO_CONTINUE
that installs the pte (alongside with allocating the pmd).

Or did I miss something?

Thanks,

-- 
Peter Xu

