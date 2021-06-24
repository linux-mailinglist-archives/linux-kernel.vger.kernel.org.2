Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC503B33F4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 18:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhFXQcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 12:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhFXQce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 12:32:34 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC3CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 09:30:15 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id c16so8556500ljh.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 09:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wMqqOybXOXLzXw+VpmlDlMk63l10Wq0BrobUIsojbEo=;
        b=Z2oG1njUjInQhPLj2j4rWtb12zLFHh8hS48OtsxIQWo2zyQ0/RgX6/E58b1fC8gV2F
         5WsbDMxMvddb1iDKmbs6y30jP3omYIah/khxlGS6xaBp3pfapsyKtEF47UjEZuliE+pW
         ezNw3N9lR59kIX3UqsLsE4g2Dd9rnmojTuYrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wMqqOybXOXLzXw+VpmlDlMk63l10Wq0BrobUIsojbEo=;
        b=hgsDsuHcIG05+df88ZvrjAOZfIWv2gWLgt9VTC4QeCY1cxWSwr8RRhfHzT+rCGnn26
         hs5wecScfr+1Xb04i9zZ5CcZXJDQ8uHFp6oxR8mrfCwHJ2aWxN+lCe2N3oNkPPVih99y
         UWXFn4fZcfRvpZ0YfIlO0xWhEaJv+mV2r/vIWZj1Qs4H365Wka+10doTLtyzR+MAMLdw
         lylOCltw15cxa9iJ9PA5Se1h64kmgbmP2MYlRIX/p+gjgzq8Q9i9TLWC85eWw66wQwp5
         aaHvKSV0F216teABPSuUuVMYb+iJACBDsEnCYlVTP8JWKhp36zY4zqNvJ2T16ft8fUYz
         aohw==
X-Gm-Message-State: AOAM530rUe3ub8hpP2Li5aF5JcIpk6dgIQAXa/oG8LEkvaNJZEDZAzw9
        lK2QBoYZQq3J1Va+v20E3C9ohU0JjoKL35/R
X-Google-Smtp-Source: ABdhPJwx6XxN1XoEJPyl9kfowPUnTXpGd0YpStoG2Z+pt9OdiH1UpMM7Lx7Gd7A+vz6E3b5hGUaonw==
X-Received: by 2002:a05:651c:323:: with SMTP id b3mr4688672ljp.139.1624552213310;
        Thu, 24 Jun 2021 09:30:13 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id e7sm267584lfr.152.2021.06.24.09.30.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 09:30:12 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id x20so1796081ljc.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 09:30:11 -0700 (PDT)
X-Received: by 2002:a2e:7813:: with SMTP id t19mr4486372ljc.411.1624552211545;
 Thu, 24 Jun 2021 09:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <YNQwgTR3n3mSO9+3@gmail.com>
In-Reply-To: <YNQwgTR3n3mSO9+3@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Jun 2021 09:29:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiebYt6ZG4Cp8fWqVnNqxMN4pybDZQ6gwsTWFc0XP=XPw@mail.gmail.com>
Message-ID: <CAHk-=wiebYt6ZG4Cp8fWqVnNqxMN4pybDZQ6gwsTWFc0XP=XPw@mail.gmail.com>
Subject: Re: [GIT PULL] sigqueue cache fix
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 12:13 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> Fix a memory leak in the recently introduced sigqueue cache.

Side note: I detest the READ_ONCE/WRITE_ONCE games for the sigqueue
cache thing. I also think it's actively buggy.

The sigqueue cache is only safe when it's serialized by the sighand
lock, so all those games with "ONCE" accesses are entirely bogus and
misleading.

It looks like this is due to __sigqueue_alloc() being called without
the lock held (in which case sigqueue_flags will be SIGQUEUE_PREALLOC)
and then it does this:

                q = READ_ONCE(t->sigqueue_cache);
                if (!q || sigqueue_flags)
                        q = kmem_cache_alloc(sigqueue_cachep, gfp_flags);

where the point is that it reads that sigqueue_cache thing even if
sigqueue_flags is non-zero (no lock), so presumably KCSAN complained
about it.

However, hiding it from KCSAN (instead of just test sigqueue_flags
*first* - which admittedly would presumably need some kind of
serialization) is not only ugly, I think it's hiding the *real* bug,
which is

  release_posix_timer ->
    sigqueue_free ->
      __sigqueue_free ->
      sigqueue_cache_or_free

where that sigqueue_free() thing explicitly calls __sigqueue_free()
*outside* the sighand lock. End result: I don't think that cache is
serialized at all.

So I think the sigqueue cache is still potentially quite buggy, and I
think the bug is hidden by the READ/WRITE_ONCE games that are
misleading and not actually valid.

But maybe there is something I'm missing that makes that
release_posix_timer case ok. Or maybe I'm misunderstanding that code
entirely. But it does look bad to me. And the ONCE accesses look
positively wrong in every single possible way: they aren't logical,
and they are actively hindering KCSAN rather than fixing anything at
all.

              Linus
