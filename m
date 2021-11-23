Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE6445ABFA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 20:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238586AbhKWTHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 14:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237867AbhKWTHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 14:07:07 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5C4C061714
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 11:03:59 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id e136so270739ybc.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 11:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LaJDBQtG+DXnowMTWJkyijLSJN0Nkf4J+qtT5TSoBEI=;
        b=mQCCR9inMpWYYwbUGGVizRPX9wGXFm98dDWlQwsVO7KEchapJCw8z+Jk+kt5oAiOTn
         AVJ7fktJSJM7+Y/Vmf1chEFvGOJcw/EkXm619Z5/WbGXLdyAMTv8nYRkEjiPBQpkvnsi
         SSXX1N2k45VvAT1BJsY5xOLa97gq9lwLuK1R4COC9iDGddnsCWILegcY2+YdzYLDvDF5
         KFOR8dM4tSnzrIhlOGwMqMymf+yS9GN5hhUm7V7ziwGA8ZzPddtD2ELwJq/zT5lNPwAO
         C1wEiNMaT+eMDYpAYbqgs9UxC2/Kbw1t4MPvV9vjhCKrX5ij+ZsHCY7aJzX7nosnLDmD
         JEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LaJDBQtG+DXnowMTWJkyijLSJN0Nkf4J+qtT5TSoBEI=;
        b=bLjreYxFHlOFU12qbmWxYXRPPS1kNc7fiuiICwkjnDsgSbUdIz4ujdLaFHN2+TF/kB
         ptuTT4cWMZTTvNPFCIqEqpALJtSaazmIHmP87yUmMe8ZoDFoYeuzTK/c9ijXZKkOWRLY
         TgkZTeB7ei4zVwSy7z0KqVwbRDuE8tjaZy0YC8TbBVL26jgiJw31414uE5K0j1cmC+ng
         0jWvj7A0rAgsKgvBIr4oLLYUy0OIaTGXH6frIuRbmUdwY2W7SMilsstmUTiz/IvWXZiq
         J4jpLfxyRe2aYqFfCFMV4J1ab1x6O7qfiv6Y/NL3xs7+qBwvn5prFmjHYu6i/eWErkH7
         Jcsg==
X-Gm-Message-State: AOAM532sxXn/IRcoRB5q6NQb/ot9FP4a+nvnE1JPEUzxKHF10L6LxUYn
        VGy/JpcH/NP/07FC+mP20jnhbvZLnd6qtiJxvOFByw==
X-Google-Smtp-Source: ABdhPJx//oGK6Bbe1RlllZHspiLuAizblPN9ksFjcKp9AQS/Xvy2Df8UTFQ8P8KdANqVeMJomE72IUDla9pmJsyq1wc=
X-Received: by 2002:a25:d4d5:: with SMTP id m204mr9471650ybf.418.1637694238141;
 Tue, 23 Nov 2021 11:03:58 -0800 (PST)
MIME-Version: 1.0
References: <20211123162635.29c8bccb@canb.auug.org.au> <CAJuCfpEvDOsNGcN9cqStx3PpoG_pJgQevvc+V6gcRrCUBa0YWA@mail.gmail.com>
In-Reply-To: <CAJuCfpEvDOsNGcN9cqStx3PpoG_pJgQevvc+V6gcRrCUBa0YWA@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 23 Nov 2021 11:03:47 -0800
Message-ID: <CAJuCfpF6gyCNzkaq5QnthhV886ueFhkAJv4sJ6rtW+8Z-t0qmA@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the akpm-current tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 12:38 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Mon, Nov 22, 2021 at 9:26 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > After merging the akpm-current tree, today's linux-next build (htmldocs)
> > produced this warning:
> >
> > Documentation/filesystems/proc.rst:429: WARNING: Malformed table.
> > No bottom table border found.
> >
> > =======                    ====================================
> > [heap]                     the heap of the program
> > [stack]                    the stack of the main process
> > [vdso]                     the "virtual dynamic shared object",
> >                            the kernel system call handler
> > Documentation/filesystems/proc.rst:434: WARNING: Block quote ends without a blank line; unexpected unindent.
> > Documentation/filesystems/proc.rst:436: WARNING: Block quote ends without a blank line; unexpected unindent.
> > Documentation/filesystems/proc.rst:436: WARNING: Malformed table.
> > No bottom table border found.
> >
> > =======                    ====================================
> >
> > or if empty, the mapping is anonymous.
> >
> > Introduced by commit
> >
> >   2df148be9486 ("mm: add a field to store names for private anonymous memory")
>
> Thank you for reporting! I'll try to fix it first thing in the morning.

Hi Stephen,
I just posted a fix for the warning at
https://lore.kernel.org/linux-next/20211123185928.2513763-1-surenb@google.com/T/#u
One thing I'm not sure is that I used SHA from linux-next in the Fixes: field:

Fixes: 2df148be9486 ("mm: add a field to store names for private
anonymous memory")

Not sure if that's acceptable. Please let me know if you want me to
repost the fix without that line.
Thanks,
Suren.

> Thanks,
> Suren.
>
> >
> > --
> > Cheers,
> > Stephen Rothwell
