Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270F44249BA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 00:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbhJFWiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 18:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239593AbhJFWiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 18:38:17 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFB9C061760
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 15:36:24 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id p18so4577111vsu.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 15:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pjWer8xPM+oHm3N7ZbhTbt1Y4siZYnnVEDWcGpFVN9M=;
        b=XqQVjMiRfbzrBy3CS/MLC2JRPkZiOixEAI9VomrlZ9DIBcnbWSV5iy8YLBOrNeCoiR
         CkI6ykTaDXhBgFSnaRwExP27ZmFdJDQ95z6Epdz8M8H1iKjrEjIRjKK351G6rx1iMEyb
         ERR034mVT6+qzITx5BvKeOVJ+L+/2tzZmEK9Mt1ZVKh6E0gShzlj/2Do8ajsZ/yFfq31
         k0usUKs4Ni9y0vCvJDvKrRxVduY/k07W9q68SiBgl7Au1oGaG979jmdlQV2azazzO86+
         eppJudnJPrDAsFhf6Iw89SLb3/feD6Zb7U2jlliQXFVl2pQw5V1lr89/vgoXPJTnF+ZQ
         ANbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pjWer8xPM+oHm3N7ZbhTbt1Y4siZYnnVEDWcGpFVN9M=;
        b=5VnjaMkDu3doZm1eaAWrWuRR3xdf9NQnnbyPYwOUG2OSb+H1UpYemu7iZFNJ6NMm/M
         496KEEiSI+v6LBL3dy5udlWhQ9JpZoQE/YHNBt0QRAwMGcMlqInmTjMAWq5dkrZCcP/9
         D+hcdr4njhZ9622Zc0uNmmYjAwdyDzvt5GfF0JKud2AWfM4FpjArP4371oUhclXrTZvd
         KadBRGVvdhTzxWan2BslKo4RiIfT57NNEGL2JoKh0wSqJRPACxTiDlzHwLhm/nYNkPwa
         U1R9uXcSiC4rwJ9uoI/nwOYYu+tye5FmMqWTnZiHUzqAGiYQ/DgShYkPnOH5MwYpDu9v
         x8PQ==
X-Gm-Message-State: AOAM531dK3BnhfJryc6F5bibMrdSMZ5Z1t3GiesL1VyyH36smkxqX0pj
        5Oc/b5ygzgaMuiEuhlcaePZk6C6Ck1Hd+a/19/9WNA==
X-Google-Smtp-Source: ABdhPJweVIcyDIWMmg2YzkI5CdOhKpkRsFFoHr/WFSKYB2uv7HfOoVt1UaCjxBMRwUh7D90s2pmBkox45adiR7nURo8=
X-Received: by 2002:a67:d583:: with SMTP id m3mr910405vsj.41.1633559782905;
 Wed, 06 Oct 2021 15:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <20211006195029.532034-1-ramjiyani@google.com> <YV4SELcjE7EfBiLI@gmail.com>
In-Reply-To: <YV4SELcjE7EfBiLI@gmail.com>
From:   Ramji Jiyani <ramjiyani@google.com>
Date:   Wed, 6 Oct 2021 15:36:11 -0700
Message-ID: <CAKUd0B8r=7EKOuyy=FACg438f2vQRdJMyzfJzcQOUd+4My4oYg@mail.gmail.com>
Subject: Re: [PATCH v2] aio: Add support for the POLLFREE
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     arnd@arndb.de, viro@zeniv.linux.org.uk, bcrl@kvack.org, hch@lst.de,
        kernel-team@android.com, linux-aio@kvack.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        oleg@redhat.com, Jeff Moyer <jmoyer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 6, 2021 at 2:16 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, Oct 06, 2021 at 07:50:29PM +0000, Ramji Jiyani wrote:
> > Commit f5cb779ba163 ("ANDROID: binder: remove waitqueue when thread
> > exits.") fixed the use-after-free in eventpoll but aio still has the
> > same issue because it doesn't honor the POLLFREE flag.
> >
> > Add support for the POLLFREE flag to force complete iocb inline in
> > aio_poll_wake(). A thread may use it to signal it's exit and/or request
> > to cleanup while pending poll request. In this case, aio_poll_wake()
> > needs to make sure it doesn't keep any reference to the queue entry
> > before returning from wake to avoid possible use after free via
> > poll_cancel() path.
> >
> > The POLLFREE flag is no more exclusive to the epoll and is being
> > shared with the aio. Remove comment from poll.h to avoid confusion.
> >
> > This fixes a use after free issue between binder thread and aio
> > interactions in certain sequence of events [1].
> >
> > [1] https://lore.kernel.org/all/CAKUd0B_TCXRY4h1hTztfwWbNSFQqsudDLn2S_28csgWZmZAG3Q@mail.gmail.com/
> >
> > Signed-off-by: Ramji Jiyani <ramjiyani@google.com>
> > Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
>
> Can you add Fixes and Cc stable tags to ensure that this fix gets backported?
> Please refer to Documentation/process/submitting-patches.rst.
>
> - Eric

Thanks Eric. I'll send v3 with these changes soon.

~ Ramji
