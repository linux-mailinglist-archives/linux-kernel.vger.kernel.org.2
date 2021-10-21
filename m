Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CD6435AB6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 08:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhJUGKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 02:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhJUGKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 02:10:48 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5945C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 23:08:32 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id o26so1064489ljj.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 23:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EVbsqCKrfgIqa6Ad+OM2Vv/QlVpi1r5BzxrD9qJwH8U=;
        b=GjtB4xaDhHpedB3Xvy6nzwmGV90o0dLBod2kZeXdvkvplmkRsvO4Cl/b2IWuLXzpug
         zTEQA+Kne+clFahjUh8eaTLpRms0VqT/b6U237ewQWP6dbbUyF+ntXxTBKzCvQLVMEy3
         teXfdGIyWhDa5+n82v1OYGqIhSlzGwFCldWec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EVbsqCKrfgIqa6Ad+OM2Vv/QlVpi1r5BzxrD9qJwH8U=;
        b=nTCRmAGnm19VBeX6ZULKtitjuNw+P8s60mkBaXGRATB9BUpALbqQjQizHtphHdiAoh
         Z8BTokbRQWAffBT0vwZTv9I1G7MdopBkZqQucZ1OiK3cYMifKGcibOlxHMyn9YqCSbS6
         KMMTzR4F30MGEqvYme6yCD6AgA7i8uAWT2DXtIbMIw9+k0ayUJ7tdYziaQ5rFv0rP/bN
         fYyQe10PLWV97yFHpLsw8TZIkRQyrNhkiKNOfZKVCojIn80oRBi8Lm7eCcyadf0YvSZP
         ucWICAP1GSvohpOO6txoS5AD6b+8lHA2fAZtoU/1MTyVZEWpFIRixgTj5XWeYYP9B/pn
         PXEQ==
X-Gm-Message-State: AOAM533jV/hD3g6/1lZspnYX19HKddOhfK9nOJTqzbjpZfWpWpswX7jf
        zTjzz6Rfr0BhFu09i15L4dnXVyYj4W0rjF6gPIQ=
X-Google-Smtp-Source: ABdhPJxKaLkACChW0qnUst30UdXDrOK5CS6n8af/kyQBGGrgAdTowvTd5tfn+Bzp6pQBMgo3jkHIgQ==
X-Received: by 2002:a2e:7306:: with SMTP id o6mr3559083ljc.381.1634796510641;
        Wed, 20 Oct 2021 23:08:30 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id o9sm370435lfu.11.2021.10.20.23.08.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 23:08:27 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id g8so749399ljn.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 23:08:25 -0700 (PDT)
X-Received: by 2002:a2e:1510:: with SMTP id s16mr3786948ljd.56.1634796505052;
 Wed, 20 Oct 2021 23:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211019091344.65629198@gandalf.local.home> <CAHk-=wjvGRtwMHDJ9VR8197+_rVveqE73Uv-MMFbvuUEbWKNtQ@mail.gmail.com>
 <20211020121727.57f46a15@gandalf.local.home> <CAHk-=whr2M-jzyv9B8Co0V0TMvCpnH24fWYwxXrN9YeGKicoVw@mail.gmail.com>
 <20211020181241.0e6a2b47@gandalf.local.home> <20211020184101.25b7e583@gandalf.local.home>
In-Reply-To: <20211020184101.25b7e583@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Oct 2021 20:08:09 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgBhyLhQLPem1vybKNt7BKP+=qF=veBgc7VirZaXn4FUw@mail.gmail.com>
Message-ID: <CAHk-=wgBhyLhQLPem1vybKNt7BKP+=qF=veBgc7VirZaXn4FUw@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Fix to recursion protection for 5.15
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 12:41 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I guess I can still automate the Cc's without issue.

I like the cc: lines, and I don't think it's a great argument to say
that "the data is in the thread in the link".

Generally the commit message should stand on its own, and contain
enough of the relevant information that the link data isn't needed.

So _primarily_ the "Link:" line should be about background - and for
"oh, there was discussion about this patch after it was committed".

So it should not be seen as a _replacement_ for any information in the
commit itself, or as an excuse to leave relevant information out.

That said, I'm not entirely convinced that it's useful copying
everybody that was on the cc of the patch - particularly if they never
actually participated in the discussion at all.

But it's probably better to have too many cc's listed in the commit
than too few - at least within reason.

Because if a commit turns out to cause problems, the list of email
addresses mentioned in the commit message should be seen as the
primary list of "hey people, this patch you were involved with has
issues"

           Linus
