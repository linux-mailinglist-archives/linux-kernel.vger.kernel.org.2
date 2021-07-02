Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0B63B99FE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 02:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbhGBAXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 20:23:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58700 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234195AbhGBAXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 20:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625185234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rQPsdOkVHeGKBuEsStJMLYq9tWsj5wYRKjPTUAXJMQg=;
        b=fM+iRd5ODoNG0m8i2Z2qxJvCe54K1AUZBzK/r2rwBJlEAwKbOgI2noqe//ZUWMUGLPeTNB
        hAnrEk/m7U92hgTkgG/zw6N/HzlVldQAA6tFvpOiEBj1G0JhqNocgfKzKc2Mb8bSS+JHGH
        unMoj+WswHVsRk6VXzPFNx4cHjYjWUg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-hgA3ORIPMsidc1wjVIcNZw-1; Thu, 01 Jul 2021 20:20:33 -0400
X-MC-Unique: hgA3ORIPMsidc1wjVIcNZw-1
Received: by mail-wm1-f72.google.com with SMTP id j38-20020a05600c1c26b02901dbf7d18ff8so5411634wms.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 17:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rQPsdOkVHeGKBuEsStJMLYq9tWsj5wYRKjPTUAXJMQg=;
        b=FVKE2wPKMdqwdHWhat57kKXqslieq7TNpmY9T97msrN93Ycz4//Ty3x6neWRKVgDFK
         QeLG6mWsm2w+9isy3Iy2IybBw+EaXN1AoQabjbIDVPE6NLi/OxmvB4Gnhv2XSFtC/blm
         G97ekOv45ApSssA9jg/k3PIDyP9mIRdLNqLViz7QVD56iNDQBuXlDA/gImKKAjgIaBcY
         MSw1p+Z35greHpo426ZQnawV2+s340joKkj+dF7zxTvuuG3sJziD36nDxkMs2oYLNHzx
         DULY+J/kYaSzHGeE614EX+VppsauZDKXNJbs3IV6XhNVa7MFMVa2qdpjPVQZQKmNxs1u
         hjug==
X-Gm-Message-State: AOAM533ps+DVgJfiDEaff2A5cd9YMaIK3DqoAqzHOzuFZd0LqyabjCvr
        xuBKNJdojSqD5nivyf312eatPO2bqgBJlZwouiI5ZYy25XndzKPtJQJg5rtQL2kQw9/oZsVvvol
        YY05uV5KeDecfB5dK9ixvryDSjYiFcjjNg3UATj1s
X-Received: by 2002:a7b:c4da:: with SMTP id g26mr13499688wmk.3.1625185232447;
        Thu, 01 Jul 2021 17:20:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2mrmrFqhY+KJO7OmT5+cTABba2Xcud4NJgvF/TCklQGhDqfs42VqLXpLsCT79j3xMTA47vuLYlFge+nI55lQ=
X-Received: by 2002:a7b:c4da:: with SMTP id g26mr13499672wmk.3.1625185232278;
 Thu, 01 Jul 2021 17:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210701204246.2037142-1-agruenba@redhat.com> <CAHk-=wjk6KP3vSLFNPMjoaZ4xY4u=DjTM+C+hCS3QKt+XAE6OA@mail.gmail.com>
In-Reply-To: <CAHk-=wjk6KP3vSLFNPMjoaZ4xY4u=DjTM+C+hCS3QKt+XAE6OA@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 2 Jul 2021 02:20:20 +0200
Message-ID: <CAHc6FU5XMfTOBW1a0OnMaPSmgWECvO-KYAo8HeVNsCyd-HyV3g@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Fix mmap + page fault deadlocks
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 1, 2021 at 11:41 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Jul 1, 2021 at 1:43 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > here's another attempt at fixing the mmap + page fault deadlocks we're
> > seeing on gfs2.  Still not ideal because get_user_pages_fast ignores the
> > current->pagefault_disabled flag
>
> Of course get_user_pages_fast() ignores the pagefault_disabled flag,
> because it doesn't do any page faults.
>
> If you don't want to fall back to the "maybe do IO" case, you should
> use the FOLL_FAST_ONLY flag - or get_user_pages_fast_only(), which
> does that itself.
>
> > For getting get_user_pages_fast changed to fix this properly, I'd need
> > help from the memory management folks.
>
> I really don't think you need anything at all from the mm people,
> because we already support that whole "fast only" case.

Yes, fair enough.

> Also, I have to say that I think the direct-IO code is fundamentally
> mis-designed. Why it is doing the page lookup _during_ the IO is a
> complete mystery to me. Why wasn't that done ahead of time before the
> filesystem took the locks it needed?

That would be inconvenient for reads, when the number of bytes read is
much smaller than the buffer size and we won't need to page in the
entire buffer.

> So what the direct-IO code _should_ do is to turn an ITER_IOVEC into a
> ITER_KVEC by doing the page lookup ahead of time, and none of these
> issues should even exist, and then the whole pagefault_disabled and/or
> FOLL_FAST_ONLY would be a complete non-issue.
>
> Is there any reason why that isn't what it does (other than historical baggage)?

It turns out that there's an even deeper issue with keeping references
to user-space pages. Those references will essentially pin the glock
of the associated inode to the node. Moving a glock off a node
requires truncating the inode's page cache, but the page references
would prevent that. So we'd only end up with different kinds of
potential deadlocks.

If we could get iomap_dio_rw to use "fast only" mode when requested,
we could fault in the pages without keeping references, try the IO,
and repeat when necessary.

Thanks a lot,
Adreas

