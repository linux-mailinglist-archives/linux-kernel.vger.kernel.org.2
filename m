Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CA93146B6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 03:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhBIC6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 21:58:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32968 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230131AbhBIC5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 21:57:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612839361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZCPgOdo0sguJV+CnbMbF2hM5SDTI0aKdRJzqe0KmNUc=;
        b=fkW0IKlYRuvnaUvqPf44Yq2iubsVVZ3YkzvY1MKSLlNzA+h5VIt33RpZ7HJeOBmYswl6NU
        HLbSI43X0nYPgO9gOb+fa4ubGsqW7/skcOwd5Co+1YiOV+N4ML5fTsLVo+Uum+I1Vnq2Zb
        cQU9WH/T1Jpe+ef9Kg/tDkiK3DdoP7Q=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-jz5z1AO7POKqYFKYfJLS5g-1; Mon, 08 Feb 2021 21:55:59 -0500
X-MC-Unique: jz5z1AO7POKqYFKYfJLS5g-1
Received: by mail-qk1-f198.google.com with SMTP id 124so2002149qkg.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 18:55:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZCPgOdo0sguJV+CnbMbF2hM5SDTI0aKdRJzqe0KmNUc=;
        b=oY8qj48PwMHNGxbrJz3yac85cBEnIbDW8r7WuTbrtmLy/P684+qsnEizWSW9ga0USp
         v/yAJV7lkpJ81In1VqY1snwqh2c/CGW2/7+kx7eFANsmPnARVi0Hpulpi7a47plgZSid
         w/Wi5Dh0jT8WQegBpb9T1Ah2B9caZ7TC+J6k90C0/Z/hqB9ekpwkMqPpBOb1L95X0QbM
         ymqp9I+IbvEWfdXvrXF62Kgz53PT2XUhzRtkF8Mf8txjqRPj6ucWovF7uJSN278WbSgr
         rvo7ruOdaC6cCy0TlqpnCtP6SjZ5YV7Cds2TQRxerhuolu3j6KrSBiTb95w1pwwHOQuK
         ItNQ==
X-Gm-Message-State: AOAM530bTdC4vJ5EL8o+VZzRsT9PFnntw/c/VIpYDyDpCFnrhCEkHGEQ
        mNV8P+1oEg1FqOPS+SbFhElQ+zJ6ehbX8I9ibqD3msD5UhXevNX9UmJreuvle4qTmR4Lh8dXyqx
        hlfQxvoQZWlzGUnLe5+DNV0Hv
X-Received: by 2002:a05:6214:118e:: with SMTP id t14mr18876781qvv.50.1612839359380;
        Mon, 08 Feb 2021 18:55:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzw+JQUTVQ5YYbkf1TNWGMyrE7IvTpldV4OfemnnYjq2iJrzhzieq28T220Dnmd4gQiQ116Og==
X-Received: by 2002:a05:6214:118e:: with SMTP id t14mr18876771qvv.50.1612839359161;
        Mon, 08 Feb 2021 18:55:59 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id u45sm13510077qte.3.2021.02.08.18.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 18:55:58 -0800 (PST)
Date:   Mon, 8 Feb 2021 21:55:56 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Gal Pressman <galpress@amazon.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jann Horn <jannh@google.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Wei Zhang <wzam@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 5/5] hugetlb: Do early cow when page pinned on src mm
Message-ID: <20210209025556.GA82021@xz-x1>
References: <20210205165406.4655-1-peterx@redhat.com>
 <20210205165406.4655-6-peterx@redhat.com>
 <e3029aca-f487-225b-7a78-7712c4c465a6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e3029aca-f487-225b-7a78-7712c4c465a6@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 04:09:26PM -0800, Mike Kravetz wrote:
> On 2/5/21 8:54 AM, Peter Xu wrote:
> > This is the last missing piece of the COW-during-fork effort when there're
> > pinned pages found.  One can reference 70e806e4e645 ("mm: Do early cow for
> > pinned pages during fork() for ptes", 2020-09-27) for more information, since
> > we do similar things here rather than pte this time, but just for hugetlb.
> 
> Thanks for all the changes, the patch looks much better.
> 
> I did not look at 70e806e4e645 in detail until now.  That commit had the
> 'write protect trick' which was removed in subsequent commits.  It took me
> a bit of git history tracking to figure out the state of that code today and
> the reasons for the subsequent changes.  I guess that was a good way to
> educate me. :) 

Thanks for looking into those details.  I didn't expect that to happen since
after Jason's rework with 57efa1fe5957 ("mm/gup: prevent gup_fast from racing
with COW during fork", 2020-12-15) we can ignore the whole wr-protect idea as a
whole.  I referenced 70e806e4e645 more for the idea of why we do that, and also
copy_present_page() on how it is generally implemented.  That gup-fast race is
definitely tricky on its own.

> 
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  mm/hugetlb.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 62 insertions(+), 4 deletions(-)
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Thanks!

I'll post a new version very soon with your r-b, and also a compile warning
fixed in the other patch as reported by Gal.

-- 
Peter Xu

