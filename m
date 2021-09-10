Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5574071A9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 21:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbhIJTGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 15:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhIJTF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 15:05:59 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E20C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 12:04:48 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id y6so4811417lje.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 12:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4O05uObnyBd8PH14AaeRzOvwDNwVkRfGJ3V9bY0KSj4=;
        b=dyot85loehJbv+eVFq+4pRTmOI6g66axvC+prdc/KMvKaC+OmGvGJzdh3SbOZFYJ9B
         ezVjDR53MEUi5CkQqphuyQMH2kKjGWc8Dfqp624haoOJ8APcGryxYOZN3e5ec0SUTIw3
         krnhSjrwdiL++OkN28kLN4UNuosylP3I3vyCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4O05uObnyBd8PH14AaeRzOvwDNwVkRfGJ3V9bY0KSj4=;
        b=OySM9ylyLoDJHyXBI5ljf+SZrbUrXUTuttepv9Iwacbmw+TQ/pzosyVhjzyHy5YjRd
         L95ZQFjIT6Icphud2kjAmFhI7bRyqoNWn87SJ0SUzszweJpwZySpa8JySC3+3EdxaFKC
         RynxJ+lXJfJsxXR+Gd0A5rqMH5JYeXozsso3Oz09j3yE7F6gbkIEvUfvF8ltbM8xcsUN
         n1D3NihUvYIM4D9mkEEbld/DypoFNceTtl2f0DfR65xyoVXV3XWAqnp5FvyeqJD41zAL
         cFmiV498ihEMdhwVWP0FNjE1fjEdRYeyz8s1PxIDWFpdVOPytz7KmwCEYflLDPMEpkX4
         ew0Q==
X-Gm-Message-State: AOAM533B9/SACqeU+kJ5Tl/jjGAbArRJ6Aove/WPeKoAjjUBA9w6o4Fg
        7Fpe98IYnTp3aar45CTBH56/qKrfTaz/7k0byPk=
X-Google-Smtp-Source: ABdhPJwRg+HfeuE+S+GsuFFLlBehXjkqV6ZgAHhuS7itm7SyPDA3FDBH0cAnd4SLQOs2jht6mfUYbw==
X-Received: by 2002:a05:651c:90b:: with SMTP id e11mr5368757ljq.172.1631300685987;
        Fri, 10 Sep 2021 12:04:45 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 3sm661229ljq.136.2021.09.10.12.04.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 12:04:45 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id h1so4761692ljl.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 12:04:45 -0700 (PDT)
X-Received: by 2002:a2e:b53a:: with SMTP id z26mr5064397ljm.95.1631300684824;
 Fri, 10 Sep 2021 12:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <YTrQuvqvJHd9IObe@zeniv-ca.linux.org.uk> <f02eae7c-f636-c057-4140-2e688393f79d@kernel.dk>
 <YTrSqvkaWWn61Mzi@zeniv-ca.linux.org.uk> <9855f69b-e67e-f7d9-88b8-8941666ab02f@kernel.dk>
 <4b26d8cd-c3fa-8536-a295-850ecf052ecd@kernel.dk> <1a61c333-680d-71a0-3849-5bfef555a49f@kernel.dk>
 <YTuOPAFvGpayTBpp@zeniv-ca.linux.org.uk> <CAHk-=wiPEZypYDnoDF7mRE=u1y6E_etmCTuOx3v2v6a_Wj=z3g@mail.gmail.com>
 <b1944570-0e72-fd64-a453-45f17e7c1e56@kernel.dk> <CAHk-=wjWQtXmtOK9nMdM68CKavejv=p-0B81WazbjxaD-e3JXw@mail.gmail.com>
 <YTuogsGTH5pQLKo7@zeniv-ca.linux.org.uk>
In-Reply-To: <YTuogsGTH5pQLKo7@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Sep 2021 12:04:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg8O4NBTUr9GvNo=vnUmONUGYypN4dFr7QNEGUFcN=tBw@mail.gmail.com>
Message-ID: <CAHk-=wg8O4NBTUr9GvNo=vnUmONUGYypN4dFr7QNEGUFcN=tBw@mail.gmail.com>
Subject: Re: [git pull] iov_iter fixes
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 11:50 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> I think that sizeof(struct bio_vec) != sizeof(struct iovec):

Ooh, very good catch.

That would cause some *very* odd and subtle errors, since it just
happens to work on 64-bit, and then causes very confusing pointer
arithmetic errors on 32-bit.

So yeah, that

        i->iov -= state->nr_segs - i->nr_segs;

doesn't work after all, comment or not.

So only 'struct iovec' and 'struct kvec' actually have the same format
and can be used interchangeably.

            Linus
