Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F803E2EEA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 19:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241514AbhHFRia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 13:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241257AbhHFRi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 13:38:28 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A149C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 10:38:11 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id y34so19366475lfa.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 10:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tCXinlV0wnDynlc7+5YbEkw4Pmdgz0pi7a+6jwEmh9g=;
        b=Ya2DBsuPmVvdHFDsNSye+7lf4RmgU4wPy9fFJ5G+VEbZp5LUxio2fLxbLr25C07oPM
         mlO1UMVGhhyLxpLvvR1jYUafSDgRS0/YbdbIwGIHmNZaYk1FVdM1WiDhufCjko7yMu4W
         qCzn8AuVhtlXY+gCVzI6I/oiqblDxLrQuwCAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tCXinlV0wnDynlc7+5YbEkw4Pmdgz0pi7a+6jwEmh9g=;
        b=V0bIvPcV5E6L9MKSExbtmibeRshF58vsci/Hll3qca4e7+jG1a5UtpKWbiQFiImbwO
         A+kEM3i28jqJw4VjtxeYvbEWgGd6bg0Sq64HpThtQi3sEmhaj3XY7xzZcVAHGzG9m83K
         T9YXTORHG3FkSTtODIfgjVfrbr4lyysvRvNqF0qs+obJ2RzfKf0KzfKqRMoyrdd52u+1
         MptOWFJgVuoa6JMRCWVg3y2YL/8hKz+NdHLl8QaGNIBrmd7G+Aefy9hQ5He6EsFxms/Z
         BSG0RCHbosLo2utDCWRA82w74vU2yJtFODKHACNweYbXF2cXYtF0LSRrKFQmUaCNoPx8
         Lv7w==
X-Gm-Message-State: AOAM5307OFlnXvI6Yvny01c20+a6Fdm3qDjwQNmHNSGp6lqLGdctmQa3
        gU/N96x/tklsDSmaDqQanNHo0aHMw2+x5aD7
X-Google-Smtp-Source: ABdhPJybmkmwp9hq+bMtpP9CnfDd5x13pILpTriw/0lhhIHpdU1FsLvmYfXAcXGFDtUIel1ENJrENw==
X-Received: by 2002:a05:6512:151c:: with SMTP id bq28mr8837064lfb.374.1628271489449;
        Fri, 06 Aug 2021 10:38:09 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id u26sm892816lfr.94.2021.08.06.10.38.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 10:38:09 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id h2so752512lji.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 10:38:08 -0700 (PDT)
X-Received: by 2002:a2e:9241:: with SMTP id v1mr6980964ljg.48.1628271488628;
 Fri, 06 Aug 2021 10:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <87a6lvak43.fsf@disp2133> <20210806021052.3013-1-hdanton@sina.com>
 <87r1f7450i.fsf@disp2133> <20210806061458.3075-1-hdanton@sina.com>
In-Reply-To: <20210806061458.3075-1-hdanton@sina.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Aug 2021 10:37:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjdfLQ+z=uM3qUPSb1wgnugeN5+wyH11kmatUXskYqrCA@mail.gmail.com>
Message-ID: <CAHk-=wjdfLQ+z=uM3qUPSb1wgnugeN5+wyH11kmatUXskYqrCA@mail.gmail.com>
Subject: Re: [GIT PULL] ucount fix for v5.14-rc
To:     Hillf Danton <hdanton@sina.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 11:15 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On Thu, 05 Aug 2021 22:38:05 -0500 Eric W. Biederman wrote:
> >
> >I think you are saying if someone calls get_ucounts without knowing the
> >reference count is at least one a user after free will happen.  It is a
> >bug to call get_ucounts unless it is known the reference count is at
> >least one.
>
> Doubt it works because no atomicity is ensured by two atomic operations
> in tow.
>
>         if (atomic_read(&ucounts->count) >= 1)
>                 if (ucounts && atomic_add_negative(1, &ucounts->count))

Note that the first atomic_read() check is purely a debug check.

Eric's point is that you can't do "get_ucounts()" on an ucount that
you don't already have a reference to - that would be a bug even
*without* the "get_ucounts()", because you're clearly dealing with an
ucount that could be released at any time.

So you have only a couple of operations:

 (a) find_ucounts() looks up the ucount for a user that doesn't have a ref yet.

 (b) get_ucounts() increments a ref for somebody who already has a
ucount but is giving it away to somebody else too. We know the ref
can't go down to zero, because we are ourselves holding a ref to it.

 (c) put_ucounts() decrements a ref (and frees it when the refs go
down to zero).

Of these, (a) needs to be called under the lock, and needs to
increment the ref-count before the lock is released.

But (b) does *not* need a lock, exactly because the current getter
must already hold a ref, so it can't go away.

And (c) needs to hold a lock only for the "goes to zero" case, so you
can avoid the lock if the count started out higher than 1 (which is
why we have that atomic_dec_and_lock_irqsave() pattern)

The bug was in (a) and (c), but (b) is fine.

Side note: other data structures - not ucounts - can have slightly
more complex behavior, and in particular you can do the find/put
operations without locking if you

 - use RCU to free it

 - do the "find" in a RCU read-locked section

 - after finding it, you use "get_ref_not_zero()" to do an atomic "did
somebody free the last ref, if not increment it"

and the above pattern allows you to do all of a-c without any actual
locking, just local atomics.

That's what all the really critical kernel data structures tend to do.

(And the *really* critical data structures with complex topology - ie
dentries - have a local lock too, and use the lockref data structure,
but that's basically just dentries and the gfs2 gl/qd_lock - and I
have a sneaking suspicion that the gfs2 use is more of a "because I
can" rather than a "because I need to")

                 Linus
