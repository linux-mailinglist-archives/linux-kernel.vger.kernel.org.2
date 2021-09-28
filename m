Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E0F41B29B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 17:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241459AbhI1PHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:07:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35603 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241441AbhI1PHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632841560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GTEeKi/UYmjYJkWNK0SGATQ/qYJFiOXPZZXq8sMSFeY=;
        b=M8+Joa+r6ouQ2sfjRmyjodtn5gJZgRJmXTDdx9McHeexvxiE11mljtk1g8yfxYuAoTXDWT
        4DWWf91s1hyueR9munn5FAM3wnK7FmxskmivrMAywxfwXZG1B23POIFG5Mh0LZO3DEufbJ
        q2BM23kA7/PjnJoiug0nloIx8jtIH88=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-eUZr9hGYNiWceD5vLCMfYA-1; Tue, 28 Sep 2021 11:05:59 -0400
X-MC-Unique: eUZr9hGYNiWceD5vLCMfYA-1
Received: by mail-wr1-f71.google.com with SMTP id z15-20020adfec8f000000b001606a799300so1393416wrn.19
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 08:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GTEeKi/UYmjYJkWNK0SGATQ/qYJFiOXPZZXq8sMSFeY=;
        b=gh4QmdV8/zu47u14jfoKfcv0cGxDbUdLO6uDt8VHsaFvdt2UKAZ70DduAWjREsuE+q
         uyM2/0aaA4xSuMmmBfS48uHPIjcfJCHT5oSVn8ILf2Xy8F7pZQlONnPXpgVCZhtG3u7b
         D8dTG1qDedH+N2udcForl8CC4gDeErT9Bdv4OxpAVMHZuXSm9e9jdKHgcf0/hTiDbBIF
         syFibpZCJEOgUeZk+OmPE//RFSuU1JLb398Y3uLFXl/tp0JwMnhPNXMF6qGbXm5u+h8n
         3cK95PZpPC8hrq+vKgsJgUlYPJNlsq+TvyUcp9Qj5IHiakHyS8oGwyEfZ+fTyjmlL0th
         Chhw==
X-Gm-Message-State: AOAM53144Xtyy0UB+ewHePEt3UaYrC1CIB/0vpsNysKtPsxw+WQqffHf
        a2kQ4njt32rRXvbVUwFkWNYkidgquID25XLSG6CVL/DKNMnyMCWeiHrsqxRgnSLjP7+VZPH55mZ
        J74SD/1vzxuc9vAtJ7sUIqjIcMh5rthfGHBvkLeuS
X-Received: by 2002:a1c:192:: with SMTP id 140mr5194530wmb.186.1632841557825;
        Tue, 28 Sep 2021 08:05:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz45bDVa7yHh7ZlDdOqmKGhDvsP9wWie0zsYCjSZRICnWeTnJ+JMvq9BqN1jrAgmwTyXD/iZRUEiGUwLJEUR9A=
X-Received: by 2002:a1c:192:: with SMTP id 140mr5194517wmb.186.1632841557678;
 Tue, 28 Sep 2021 08:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210827164926.1726765-1-agruenba@redhat.com> <20210827164926.1726765-16-agruenba@redhat.com>
 <YTnuDhNlSN1Ie1MJ@infradead.org>
In-Reply-To: <YTnuDhNlSN1Ie1MJ@infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 28 Sep 2021 17:05:46 +0200
Message-ID: <CAHc6FU4_3m-f2T360Vq-WF=nkqDq9Zc+dekRt+wrcjvbUR1oSQ@mail.gmail.com>
Subject: Re: [PATCH v7 15/19] iomap: Support partial direct I/O on user copy failures
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 1:22 PM Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, Aug 27, 2021 at 06:49:22PM +0200, Andreas Gruenbacher wrote:
> > In iomap_dio_rw, when iomap_apply returns an -EFAULT error and the
> > IOMAP_DIO_PARTIAL flag is set, complete the request synchronously and
> > return a partial result.  This allows the caller to deal with the page
> > fault and retry the remainder of the request.
> >
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > ---
> >  fs/iomap/direct-io.c  | 6 ++++++
> >  include/linux/iomap.h | 7 +++++++
> >  2 files changed, 13 insertions(+)
> >
> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index 8054f5d6c273..ba88fe51b77a 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -561,6 +561,12 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> >               ret = iomap_apply(inode, pos, count, iomap_flags, ops, dio,
> >                               iomap_dio_actor);
> >               if (ret <= 0) {
> > +                     if (ret == -EFAULT && dio->size &&
> > +                         (dio_flags & IOMAP_DIO_PARTIAL)) {
> > +                             wait_for_completion = true;
> > +                             ret = 0;
>
> Do we need a NOWAIT check here to skip the wait_for_completion
> for that case?

Hmm, you're probably right, yes. I'll add that.

Thanks,
Andreas

