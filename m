Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7875B3FA02E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 21:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhH0T5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 15:57:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40882 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231320AbhH0T5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 15:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630094185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sd/3n0607wJTjqztLgFnu0bOLL0OQcH0TvNvy1LbLr8=;
        b=SHj+3ue+PHmRxrG6E0hgpSIfIL42eS2WIKZcBZP5WZRHYdMmOlSe97vo+zIgNdrZFsvahA
        9PeevwDg597Iev6nPFEWVTxjGIxHehriQQye81kMgGWkyWG0CB4HFUlJeys/JwSl8+4SXi
        gLbTqqbvg6P/4mbfsQiV/HI8GM7+m+E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-Gk_zVumnM3qh5lwMUXg-Sw-1; Fri, 27 Aug 2021 15:56:24 -0400
X-MC-Unique: Gk_zVumnM3qh5lwMUXg-Sw-1
Received: by mail-wm1-f69.google.com with SMTP id y24-20020a7bcd98000000b002eb50db2b62so885386wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 12:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sd/3n0607wJTjqztLgFnu0bOLL0OQcH0TvNvy1LbLr8=;
        b=YtoKbg16Y3tbh/nM1rdFPm6XryfS2cNI11GK/vWDEJKfqHaUqK+ErKcwUd4ZjIKlhG
         liiyOpCV6QjNhakVbxHKHa0DkJ70cCnV9dv1UcUqpbQy0cIjD2A8BBzh+eCVEDsZi1Lo
         vffWYITZlU+ixCLKnIryBnS4W/a8aLkFcK1tiEwYIXPwu4AsTwDgt63fuvh20L52eqOc
         nR1kpMucptLszrc8AGmt9lJKrvoPLJifOETxLO5StYM9M7crM4ZHMd6aj8h8hozHA9mI
         sXCU+/O/Y9UPDW9QEUMkvzCchlPAL0G5x1w4OGgBMffXltZpY8cKQNTExUwBUmW0SVQT
         2nMw==
X-Gm-Message-State: AOAM5303cDXPZxZ9C4AhlI90eOW62JYrvY9s6ygHc475g8Um9k+wYeTy
        zCYM/Dd0E0ojtSYK6UX0DJBIrXNZui3HvVgZkwOICwbm5+QXnQCz+v9hWcTsfJ7aE1itv531z3p
        507QlY/CAc3wCMvxTWsdEAZcn645VLb++CXYrGYB5
X-Received: by 2002:a5d:47a4:: with SMTP id 4mr12104533wrb.329.1630094182742;
        Fri, 27 Aug 2021 12:56:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydEhO4+TbNABovpa3HgGNECXB3WhRpPNdamPW7spcpayLjxbNmB0mkBEQta0WVv1DaGiTw07KdhCXl6aFWwBE=
X-Received: by 2002:a5d:47a4:: with SMTP id 4mr12104517wrb.329.1630094182497;
 Fri, 27 Aug 2021 12:56:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210827164926.1726765-1-agruenba@redhat.com> <20210827164926.1726765-19-agruenba@redhat.com>
 <YSkzSHSp8lld6dwW@zeniv-ca.linux.org.uk>
In-Reply-To: <YSkzSHSp8lld6dwW@zeniv-ca.linux.org.uk>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 27 Aug 2021 21:56:10 +0200
Message-ID: <CAHc6FU47cApVzAcVrkCLfoV7AGzs7T-cBGejVXRtfHWVdhXfxA@mail.gmail.com>
Subject: Re: [PATCH v7 18/19] iov_iter: Introduce nofault flag to disable page faults
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 8:47 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Fri, Aug 27, 2021 at 06:49:25PM +0200, Andreas Gruenbacher wrote:
> > Introduce a new nofault flag to indicate to get_user_pages to use the
> > FOLL_NOFAULT flag.  This will cause get_user_pages to fail when it
> > would otherwise fault in a page.
> >
> > Currently, the noio flag is only checked in iov_iter_get_pages and
> > iov_iter_get_pages_alloc.  This is enough for iomaop_dio_rw, but it
> > may make sense to check in other contexts as well.
>
> I can live with that, but
>         * direct assignments (as in the next patch) are fucking hard to
> grep for.  Is it intended to be "we set it for duration of primitive",
> or...?

It's for this kind of pattern:

       pagefault_disable();
       to->nofault = true;
       ret = iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL,
                          IOMAP_DIO_PARTIAL, written);
       to->nofault = false;
       pagefault_enable();

Clearing the flag at the end isn't strictly necessary, but it kind of
documents that the flag pertains to iomap_dio_rw and not something
else.

>         * it would be nice to have a description of intended semantics
> for that thing.  This "may make sense to check in other contexts" really
> needs to be elaborated (and agreed) upon.  Details, please.

Maybe the description should just be something like:

"Introduce a new nofault flag to indicate to iov_iter_get_pages not to
fault in user pages.

This is implemented by passing the FOLL_NOFAULT flag to get_user_pages,
which causes get_user_pages to fail when it would otherwise fault in a
page. We'll use the ->nofault flag to prevent iomap_dio_rw from faulting
in pages when page faults are not allowed."

Thanks,
Andreas

