Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBC93772A2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 17:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhEHPcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 11:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhEHPcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 11:32:05 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D02C061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 08:31:03 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id w4so15336417ljw.9
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 08:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T80RW0N0f2bW+RbqzRU+sONErcUEsqlqhrSCovQJd4U=;
        b=J06BUQYI0u+DnqsTFDFBW9BAol4dCToP14yYTvqrpw03eRMBn6wqgvdBIcmTmtUa4A
         5W0K6bMRkpOlnT6CwcVWRYVNjl9UHUiTVQt8AyjTba2fa2urqSpsnng7MZQLkZqrRfpu
         j85e+lD83jQdKI1jb6V7KdAg91qs6OZW5Fam0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T80RW0N0f2bW+RbqzRU+sONErcUEsqlqhrSCovQJd4U=;
        b=kZyT+Psq/S6quU71doE8ukWvg9BAdzTEypycj1e8orsjKALxWm4Z82K8r/8uxUGuvi
         SwBVZay9p684/2NVKma0CkPWKu3BAXoWzTuPL+frMFZIcK7eyO5srXIWrUYODoH0oOkq
         EpS/OKTaJZu24vhWM790KC2sLAM2w43mVhjELLQ3tkgp/k9B78sQpMoK/WVK2zKSlRsj
         97G1bPIFNazsZ6Az30kU7CVZrZhB1NJ81lFm/8DM25UGwpFt4wkKjI+Rv1cbrDArnCxP
         S7CxNNwUM0Mulg9QYM0jVZqQMIK/Nx23c/naHtPymv9CHeKfZpcq70LmQElQv2hYxBdf
         dqiw==
X-Gm-Message-State: AOAM532u8MIveAe9wcd8Hy1amnc9dTMX5aj3IFMesziy3a4ibUtRCEgB
        Rd6hus3quEd7IlglXCM/KXM0Y6bykC7+Zqqi
X-Google-Smtp-Source: ABdhPJwrsRD9U4myRGzg1+UHb2zZyJei0RzleBzRTDFwEDQOL7iKd5CVRq2SXn0TRKjsc8tJEL2y+w==
X-Received: by 2002:a2e:b0e5:: with SMTP id h5mr9734005ljl.453.1620487861655;
        Sat, 08 May 2021 08:31:01 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id a17sm1648407lfl.228.2021.05.08.08.30.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 May 2021 08:31:00 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id b21so15313358ljf.11
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 08:30:59 -0700 (PDT)
X-Received: by 2002:a05:651c:1311:: with SMTP id u17mr12053441lja.48.1620487859712;
 Sat, 08 May 2021 08:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210508122530.1971-1-justin.he@arm.com> <20210508122530.1971-2-justin.he@arm.com>
In-Reply-To: <20210508122530.1971-2-justin.he@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 May 2021 08:30:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgSFUUWJKW1DXa67A0DXVzQ+OATwnC3FCwhqfTJZsvj1A@mail.gmail.com>
Message-ID: <CAHk-=wgSFUUWJKW1DXa67A0DXVzQ+OATwnC3FCwhqfTJZsvj1A@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] fs: introduce helper d_path_fast()
To:     Jia He <justin.he@arm.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Al Viro <viro@ftp.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 8, 2021 at 5:29 AM Jia He <justin.he@arm.com> wrote:
>
> This helper is similar to d_path except for not taking seqlock/spinlock.

I see why you did it that way, but conditional locking is something we
really really try to avoid in the kernel.

It basically makes a lot of static tools unable to follow the locking
rules, and it makes it hard for people to se what's going on too.

So instead of passing a "bool need_lock" thing down, the way to do
these things is generally to extract the code inside the locked region
into a helper function of its own, and then you have

  __unlocked_version(...)
  {
       .. do the actual work
  }

  locked_version(..)
  {
      take_lock(..)
      retval = __unlocked_version(..);
      release_lock(..);
      return retval;
  }

this prepend_path() case is a bit more complicated because there's two
layers of locking, but I think the pattern should still work fine.

In fact, I think it would clean up prepend_path() and make it more
legible to have the two layers of mount_lock / rename_lock be done in
callers with the restarting being done as a loop in the caller rather
than as "goto restart_*".

              Linus
