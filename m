Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B4244C5F5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 18:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbhKJRc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 12:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhKJRc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 12:32:56 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2071FC061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 09:30:08 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id f18so7774287lfv.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 09:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k62P9OFKi7tZqOtk4kBzcgOA3yFmavp9RFu5P0iMC0g=;
        b=ljxJneVdEcWQ3qyU1mPxpDQlUwwN8+KNbwvfNpwpuRkApjgLJxOKjjW48ozjxduyk2
         0dDyEfPebZH4w1FESanp5t9gnvTDOczY8fqIlI5+nl/rxqWSZcF4Na+asDo6Qet0sFZ6
         1oWiDAMSMEefSXvc1kOaOojDK13HmRJ33IgYQUvnlFbKjZ4/1VJlM9cZ2T8fvaRjMp7J
         PW+ccuSHzksl0bB/SF5CD1zX5V8xo6camlxe6oUpF70m/inV3eZPZ0FhKtMTHaEvZCq5
         bNNwUMxUPC44MCWw3SiWm5WIV8ioSFUhcZ/3CmEbxdCUiHgdVtSTOHaY1XcVXil0yUYh
         EdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k62P9OFKi7tZqOtk4kBzcgOA3yFmavp9RFu5P0iMC0g=;
        b=3HxZxGiGJ6NAn7zCuNNPCym0fUvwqH6dDc6zrilhwcA9XnXUNbLB+a7wYX2vz9NUQy
         Q0Y7GCKt/Ml1ArC0SS6McWr86P7nXlVt2Qm31ymG/EGYOGkLo8Ao3shSLZgdMyX90oNa
         x6DxET1Mm8UGR+hU7YnTS5ZBC8y+9HFGzQe0yWzdCSrp8+udSY32+rmn0E9OC59b4phb
         FGZMkTsekAtVzgR6j+QTZne6PX6aZv6LCy3eNZDdhXSsujqBa4hcrKRnpAPd2xjeJarK
         gZkkMZ515zjSazj9PS5WlhKZKhRj0VP5e1i5GxBTZGpZek50zG2c73S/V/hsalNj7ffy
         Bw0w==
X-Gm-Message-State: AOAM531MYYW0EucVYTRO9ykQf7dcg+fMR3gFGhguha0SnzaBOMxYJ5nb
        sOlirfAynTM3vNFezrqWofpnsjMatztNaSkD87dGvA==
X-Google-Smtp-Source: ABdhPJw2bxIy8Du772N/Ij9qar0UNe2w1m5oda+QNyfinfOMVNeyPkdm0Q5Sgwf4E99E7hLDHhk9QDbDtomvdcxfc+E=
X-Received: by 2002:a05:6512:3e12:: with SMTP id i18mr718737lfv.456.1636565406166;
 Wed, 10 Nov 2021 09:30:06 -0800 (PST)
MIME-Version: 1.0
References: <20211102142331.3753798-1-pgonda@google.com> <20211102142331.3753798-2-pgonda@google.com>
 <YYqhT+Enba5xa4cO@google.com> <CAMkAt6oVySH-1g+EXKvxQ9vmBV8rwTLq=qfe2+VZC+c6vATL7w@mail.gmail.com>
 <45af7051-aab0-2b19-2904-64eceec93df5@amd.com>
In-Reply-To: <45af7051-aab0-2b19-2904-64eceec93df5@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Wed, 10 Nov 2021 10:29:54 -0700
Message-ID: <CAMkAt6pivYG=nV_EhP9Uj2gB8kBQB4dAnTcSeGd9249KuWzsyg@mail.gmail.com>
Subject: Re: [PATCH V3 1/4] crypto: ccp - Fix SEV_INIT error logging on init
To:     Tom Lendacky <Thomas.Lendacky@amd.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Marc Orr <marcorr@google.com>,
        David Rientjes <rientjes@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 9, 2021 at 12:25 PM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 11/9/21 10:46 AM, Peter Gonda wrote:
> > On Tue, Nov 9, 2021 at 9:27 AM Sean Christopherson <seanjc@google.com> wrote:
> >> On Tue, Nov 02, 2021, Peter Gonda wrote:
>
> ...
>
> >>
> >>          SEV: failed to INIT error 0, rc -16
> >>
> >> which a bit head scratching without looking at the code.  AFAICT, the PSP return
> >> codes aren't intrinsically hex, so printing error as a signed demical and thus
> >>
> >>          SEV: failed to INIT error -1, rc -16
> >>
> >> would be less confusing.
> >>
> >> And IMO requiring the caller to initialize error is will be neverending game of
> >> whack-a-mole.  E.g. sev_ioctl() fails to set "error" in the userspace structure,
> >> and literally every function exposed via include/linux/psp-sev.h has this same
> >> issue.  Case in point, the retry path fails to re-initialize "error" and will
> >> display stale information if the second sev_platform_init() fails without reaching
> >> the PSP.
> >
> > OK I can update __sev_platform_init_locked() to set error to -1. That
> > seems pretty reasonable. Tom, is that OK with you?
>
> Yup, I'm ok with using -1.
>
> >
>
> ...
>
> >
> > These comments seem fine to me. But I'll refrain from updating
> > anything here since this seems out-of-scope of this series. Happy to
> > discuss further and work on that if Tom is interested in those
> > refactors too.
>
> That's one of those things we've wanted to get around to improving but
> just haven't had the time. So, yes, if you wish to refactor the 'error'
> related area, that would be great.

OK so when I actually sat down to work on this. I realized this is
bigger than I thought. If we want to have error == -1 for all return
from psp-sev.h functions where the PSP isn't called yet there are a
lot of changes. For example if CONFIG_CRYPTO_DEV_SP_PSP is not defined
all these stubs need to be to set `*errror == -`, basically all these
functions need to be updated.

So to keep this series more targeted. I think I'll drop the error
here. And just have this patch print the rc value. If what I said
above seems reasonable I'll do those error refactors. Are people
envisioning something else for the error fixups?

>
> Thanks,
> Tom
>
> >
