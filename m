Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEFF362592
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 18:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbhDPQWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 12:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbhDPQVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 12:21:46 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092AFC061756
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 09:21:18 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x7so27217385wrw.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 09:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AkiQ5TcFawdlPUYcBb4wZotL+ipQ+/8FiigKI2/wRiI=;
        b=P8jOhoYcZlcJvYtCeRSjHuS/495j4eH3EWhLIMwvEx+zOGYPnvLHJT/vwcwkl+u2tJ
         Ir1ICkDixEkUsfFGdWERoeb7yxBTLQK8+yqXlfy06l/df/3AhbnbqXyhJN3KsOLUEF2b
         quXXbdbcViwXYeq3V8q7ABsRgMQqX81V2YMssHmhaF6k7DRfFd1RZ++Si+qo1ipqddKu
         +f9tnPkeypefIQYlCLctGRiNfEn89A1R6NJeGYMcMDJP0yYI9KWc6DP8vAIiwIMKoJ37
         ftgCNtWQnnbiDZmvTQa2VBcNaWok8CrUp+JToW2jqHM9dv5SjJL+EaXpJ29dKvfXDX9H
         l3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AkiQ5TcFawdlPUYcBb4wZotL+ipQ+/8FiigKI2/wRiI=;
        b=N5xlQQ8PEBo+gDkQHmygEHcR7aB2i7ewV+EoYgH3+DleDgc/LBrQdTIHuup7Vjk7Nr
         S0u3eqJTdM+q35vQ4ZS2zKlQzkYk/Xm3l0U6yFXwPR2QdQczk/rktmL+MS5nl28Y8yEC
         ClRaMuMIx9ysbw92/IzyPMDn3qs+7GKhWpwvuiqwMHBXy36JwdMs/TjI2tzPlRTLYxlb
         sha8F3jrEzTS1yDNd1TwDROHpjBcegR9hg41Yi73Jcym1wGrb84I/s38z/Ne3QLSsOeZ
         AY6wvCtH0vcLRVeqLTsjTL5uRyvq6R4STqq25QvNv6kpuhLJoowIjuypdDEQGIbLRmh7
         r/nA==
X-Gm-Message-State: AOAM531Zj1vhFZAhKx2Yd9baZORNgrqKcIf6rfWaeaD3/BZZwSItZ4At
        rb3MV/L+F/0cvHOBDg8D5ZiS
X-Google-Smtp-Source: ABdhPJw1BqkMZ7as3eCu7+6HY27WFD+I0Cd3zqMNm7CH7+puAegKrzIt39ou1OFGgq7zDIwRhKixmQ==
X-Received: by 2002:a05:6000:18ae:: with SMTP id b14mr9993777wri.211.1618590076604;
        Fri, 16 Apr 2021 09:21:16 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:209:51db:fb7a:d252:e3c1])
        by smtp.gmail.com with ESMTPSA id v2sm12180947wrr.26.2021.04.16.09.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 09:21:16 -0700 (PDT)
Date:   Fri, 16 Apr 2021 17:21:12 +0100
From:   Wedson Almeida Filho <wedsonaf@google.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>, ojeda@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] [RFC] Rust support
Message-ID: <YHm5eHNFOlKlOo9g@google.com>
References: <20210414184604.23473-1-ojeda@kernel.org>
 <YHlz54rd1YQHsOA/@hirez.programming.kicks-ass.net>
 <YHmMJWmzz2vZ3qQH@google.com>
 <YHm0DYB08ZI2kuZm@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHm0DYB08ZI2kuZm@mit.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 11:58:05AM -0400, Theodore Ts'o wrote:
> Another fairly common use case is a lockless, racy test of a
> particular field, as an optimization before we take the lock before we
> test it for realsies.  In this particular case, we can't allocate
> memory while holding a spinlock, so we check to see without taking the
> spinlock to see whether we should allocate memory (which is expensive,
> and unnecessasry most of the time):

I'd have to think more about whether we can build generic safe abstraction for
this pattern. But even if we can't, we always have the unsafe escape hatch: we
can grant unsafe unlocked access to the data; in such cases, the onus is on the
caller to convince themselves that what they're doing is safe, i.e., the
compiler won't offer compile-time guarantees.

However, and I think this is also an advantage of Rust, such unsafe accesses
*must* be explicitly tagged as such (and this is enforced at compile-time), so
you'd do something like:

// SAFETY: The below is safe because...
if !unsafe{ journal.access_unlocked().j_running_transaction } {
}

And the idea is that unsafe blocks like the one above will require additional
scrutiny from reviewers. So this also makes the lives of maintainers/reviewers
easier as they'd know that these sections need more attention.

> The other thing that I'll note is that diferent elements in thet
> journal structure are protected by different spinlocks; we don't have
> a global lock protecting the entire structure, which is critical for
> scalability on systems with a large number of CPU's with a lot of
> threads all wanting to perform file system operations.

Yes, this is fine, the way to do it in Rust would be to break your struct up
into something like (we have something like this in Binder):

struct X {
    [...]
}

struct Y {
    [...]
}

struct Z {
    x: SpinLock<X>,
    y: SpinLock<Y>,
    a: u32,
    [...]
}
  
> So having a guard structure which can't be bypassed on the entire
> structure would result in a pretty massive performance penalty for the
> ext4 file system.  I know that initially the use of Rust in the kernel
> is targetted for less performance critical modules, such as device
> drivers, but I thought I would mention some of the advantages of more
> advanced locking techniques.

Thanks for this. Yes, while the initial target is drivers, we do want to provide
a general framework that could potentially be used anywhere.

Please let us know if you find other patterns that seem problematic.

Cheers,
-Wedson
