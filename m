Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC28F388165
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 22:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242866AbhERUak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 16:30:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29849 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239335AbhERUai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 16:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621369759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Byh3RXtf3e9z9fGxHtn9E4dig0desEcXbiOegyYPxxI=;
        b=XSTCi2I3UfhEM05tdE6q1ero94PPqCpQM3PnOk6bQB1p/FMHIZBpm33acX8DJB/3lD02Fs
        Dhjbg8Nd1mO1i1dIksWJ/2peb3OgP07hciVKBlyoe1GKo1JvZN+oGdQMNUf2tZ7+C019sU
        ulsVXCL937J41lQuFR3KytlDA74mnnY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-IKf642TcNnyRITsUYMNvNw-1; Tue, 18 May 2021 16:29:17 -0400
X-MC-Unique: IKf642TcNnyRITsUYMNvNw-1
Received: by mail-qt1-f198.google.com with SMTP id f17-20020ac87f110000b02901e117339ea7so8229431qtk.16
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 13:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Byh3RXtf3e9z9fGxHtn9E4dig0desEcXbiOegyYPxxI=;
        b=Aj8qGUGfNBTTeFJbhPAeVwqU8o8VNVTd1th4uPuARnpoFNQ9w9J6LfU82XJdCpeMx2
         PQjDXoO8j1SOOWkgYL9vC4ifiHmexgeHdSeColrcttfk+bupIWa65TWlif8FRKEQ0Hud
         kob/j3IeKWaBSirnqpRCcY6fpg/yIfyPIPvBr5Pjhevs4XjqGnJIcg2NfIcTAsB2uvnQ
         MIf0PUvD+2sOzUuXuewE2r8PP+IeJ/CTt7Xm7X2fqgAo1evGJKgATJHqKPC2s9kzm90c
         G2acigAdJUw9kW+SGSeHnsAgHmowqJM4SjOYzkCD9Yjde/YkFRYG5VH0itc0UKUocWur
         ns3w==
X-Gm-Message-State: AOAM530486iyCU/xQnod9qfOrsQVjkL0uCW4YYcg+aFsT29DUHSt59PK
        6xjSYBJ8yXKcT7UTqD5w/0egMsjXPM7w3na2etI23BVaSkdX5PN9OUZw/eOEQtUyNp/bK0CFPDi
        y7hBcpEJ11JEBLxFE9moOJs9/
X-Received: by 2002:a37:9a44:: with SMTP id c65mr7481941qke.368.1621369757340;
        Tue, 18 May 2021 13:29:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+5f5TscVPJ0ONHm5jVyCffJB6cEfYzjhEVjEsWtXZ+lJNcysTexL/nbuPh+rIA0ZMrBojSg==
X-Received: by 2002:a37:9a44:: with SMTP id c65mr7481922qke.368.1621369757048;
        Tue, 18 May 2021 13:29:17 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id g13sm13522617qtp.31.2021.05.18.13.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 13:29:16 -0700 (PDT)
Date:   Tue, 18 May 2021 16:29:14 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, bskeggs@redhat.com,
        akpm@linux-foundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        jhubbard@nvidia.com, rcampbell@nvidia.com, jglisse@redhat.com,
        hch@infradead.org, daniel@ffwll.ch, willy@infradead.org,
        bsingharora@gmail.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v8 5/8] mm: Device exclusive memory access
Message-ID: <YKQjmtMo+YQGx/wZ@t490s>
References: <20210407084238.20443-1-apopple@nvidia.com>
 <20210407084238.20443-6-apopple@nvidia.com>
 <YKMhorngO2DVrxac@t490s>
 <47694715.suB6H4Uo8R@nvdebian>
 <YKP5Dj4Q/riGGc43@t490s>
 <20210518173334.GE1002214@nvidia.com>
 <YKQBACJCjsxeM3ro@t490s>
 <20210518194509.GF1002214@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210518194509.GF1002214@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 04:45:09PM -0300, Jason Gunthorpe wrote:
> On Tue, May 18, 2021 at 02:01:36PM -0400, Peter Xu wrote:
> > > > Indeed it'll be odd for a COW page since for COW page then it means after
> > > > parent/child writting to the page it'll clone into two, then it's a mistery on
> > > > which one will be the one that "exclusived owned" by the device..
> > > 
> > > For COW pages it is like every other fork case.. We can't reliably
> > > write-protect the device_exclusive page during fork so we must copy it
> > > at fork time.
> > > 
> > > Thus three reasonable choices:
> > >  - Copy to a new CPU page
> > >  - Migrate back to a CPU page and write protect it
> > >  - Copy to a new device exclusive page
> > 
> > IMHO the ownership question would really help us to answer this one..
> 
> I'm confused about what device ownership you are talking about

My question was more about the user scenario rather than anything related to
the kernel code, nor does it related to page struct at all.

Let me try to be a little bit more verbose...

Firstly, I think one simple solution to handle fork() of device exclusive ptes
is to do just like device private ptes: if COW we convert writable ptes into
readable ptes.  Then when CPU access happens (in either parent/child) page
restore triggers which will convert those readable ptes into read-only present
ptes (with the original page backing it).  Then do_wp_page() will take care of
page copy.

However... if you see that also means parent/child have the equal opportunity
to reuse that original page: who access first will do COW because refcount>1
for that page (note! it's possible that mapcount==1 here, as we drop mapcount
when converting to device exclusive ptes; however with the most recent
do_wp_page change from Linus where we'll also check page_count(), we'll still
do COW just like when this page was GUPed by someone else).  While that matters
because the device is writting to that original page only, not the COWed one.

Then here comes the ownership question: If we still want to have the parent
process behave like before it fork()ed, IMHO we must make sure that original
page (that exclusively owned by the device once) still belongs to the parent
process not the child.  That's why I think if that's the case we'd do early cow
in fork(), because it guarantees that.

I can't say I fully understand the whole picture, so sorry if I missed
something important there.

Thanks,

-- 
Peter Xu

