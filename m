Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63BA3D5371
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 08:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhGZGQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 02:16:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36770 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231570AbhGZGQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 02:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627282632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hoM+40XrUs08/iafF0W5TlGWYGpGG8kF5CcKon7tTtw=;
        b=JH4sTO+ItS2ylGohJwbMuzFe7NEZ3thd+ywlWkIUP9ewujUW9bwlMzAVTXbl/gbZXPPl4J
        PB1abFQNDILxsZyU8d9L/mkWS3c0klcJkej+dG2yTWykuYghRbqDSCtLcZiCyHJ/AYzTp1
        /FEh1U3AJ31u6abG5osRgHkYM+XJfOA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-1JI8rUoDN2u4t3dbBjiGQw-1; Mon, 26 Jul 2021 02:57:10 -0400
X-MC-Unique: 1JI8rUoDN2u4t3dbBjiGQw-1
Received: by mail-wr1-f70.google.com with SMTP id s22-20020adf97960000b02901535eae4100so2368573wrb.14
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 23:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hoM+40XrUs08/iafF0W5TlGWYGpGG8kF5CcKon7tTtw=;
        b=FaafJY4vsIhtIfuESdj+2kQZRZm6uANf8Q2Jndhhg8YglDXjIC7iebAfW57FkU6geU
         N025eTo0XpnMc9XLEg+TuRAs9Yh0cb5JgJUJ7GIti+8pZUdmRgSJEEJhuKM7mG8gI0eU
         9w2oSzPq+3Q0rQYSRs/0sm8ATXlkYkfXrLTqDoNnWMBMmGwB9QqgNgkubvLkBlGkuigL
         5XoW/l1hejoS8wFYcuDBMx/e4DMKZDeBNMV4GsDFVGwwKPGnoA+qfZ366AjnmXCOcTec
         0mtr7VZM8NIiS62+9yyDVf1JYt1yasOL7FJ3DBux7BneBCjLtXWYrQl2tXqdLIt59YZ4
         4r6Q==
X-Gm-Message-State: AOAM532mvWgTU1H5WIu4dBFaDNylsJNF2ZmTQLCINTtoCH9L9Oi8XLcy
        DfZj6jEuovDJ2lGYxQEaK+JdFdjVH8qbYyrmL1zyaBeyI2h+nXBjBGURSORo4f5eLCWYeYiFel4
        XBTWHw23v4/H1AGSXgEWsuAHe5mW+8ai9xEy4hf5n
X-Received: by 2002:a05:600c:2319:: with SMTP id 25mr9998432wmo.27.1627282629744;
        Sun, 25 Jul 2021 23:57:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1d7vnal7HJ1PcZ4njvl3+oYt3GMB7C300ETtzmpr8AsBsi2dyhup0b5RU8e3Tw7o3XKPki+Q+cwnpDOXFJvY=
X-Received: by 2002:a05:600c:2319:: with SMTP id 25mr9998417wmo.27.1627282629625;
 Sun, 25 Jul 2021 23:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAHpGcMJBhWcwteLDSBU3hgwq1tk_+LqogM1ZM=Fv8U0VtY5hMg@mail.gmail.com>
 <20210723174131.180813-1-hsiangkao@linux.alibaba.com> <20210725221639.426565-1-agruenba@redhat.com>
 <YP4mzBixPoBgGCCR@casper.infradead.org>
In-Reply-To: <YP4mzBixPoBgGCCR@casper.infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 26 Jul 2021 08:56:58 +0200
Message-ID: <CAHc6FU6C44b=u3YJmL9VSZGwLK3wAVxgnNdxx87RmEwVbRUB=w@mail.gmail.com>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Huang Jianan <huangjianan@oppo.com>,
        linux-erofs@lists.ozlabs.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 5:07 AM Matthew Wilcox <willy@infradead.org> wrote:
> On Mon, Jul 26, 2021 at 12:16:39AM +0200, Andreas Gruenbacher wrote:
> > @@ -247,7 +251,6 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> >       sector_t sector;
> >
> >       if (iomap->type == IOMAP_INLINE) {
> > -             WARN_ON_ONCE(pos);
> >               iomap_read_inline_data(inode, page, iomap);
> >               return PAGE_SIZE;
>
> This surely needs to return -EIO if there was an error.

Hmm, right.

Thanks,
Andreas

