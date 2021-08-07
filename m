Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACB43E3413
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 10:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhHGIXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 04:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhHGIXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 04:23:43 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA584C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 01:23:25 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id g13so22847001lfj.12
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 01:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fNCKT62JLRIeakSn+CiyLvekLIUd1tPLkplTW8gEfng=;
        b=gpweqAiVjz8W6kBCEKrehKHLG+UHn09/PNbeqET8mBv05m0GC7AYK1pcCPytNROWJZ
         tTJs+Qs7hnnJ4g8SapH1fIZmWodizIBChmWBq4TvSnDGEUlhTCOzW12psK4YHpGmb5iT
         LUAhIklj8hzgBPsPqaHlkpMf+EPutlWz4c1Lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fNCKT62JLRIeakSn+CiyLvekLIUd1tPLkplTW8gEfng=;
        b=R9XO5GORssy+xU9m4UGVlnk+xDZ/nTkyep7+v0R+mM/TyFzqEBJqbSjqBxYkCMybBF
         DbBXI8A9xrWTtJQwzSq3Wa6PUIsuIIneauVeH5hDpH3Vje2B+h4CJPRKxcV3naAQ19Gg
         0tFBBgnXS7/FXsYFR+QwEMucNH40W46dszY4sQNqKyichIvsIteA4/d+rfN/nHdvzLWI
         JNgosqkIuLJRb9WG5VSBAz1qWMWVJO1ZMxYlajgKeIjHjmmqPgKmsHSMxLXYhj4IYO8Q
         n3hoRLduToRZLibITG+E0GLs08w7wXKCtIIjAe3afGBbvsinUOYqmckvrTBvjeSznra1
         o45Q==
X-Gm-Message-State: AOAM533NaZ4MCdEPyUnBjMhHkxYg7cmmPpdnC4nXVUWjjRXjHukJSWzZ
        v4XWzg7avuHPWyQEqZ8fA/0ktij6UcnYXH4I
X-Google-Smtp-Source: ABdhPJzRIJSy8hsnJ1xppXOrRhUTvbp6fAc/1E+HB2YIhxhPGm6p71inSlUyL7ITTSH/YKTdIjdpbA==
X-Received: by 2002:ac2:4c19:: with SMTP id t25mr8701590lfq.260.1628324603854;
        Sat, 07 Aug 2021 01:23:23 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id c11sm903065ljr.1.2021.08.07.01.23.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Aug 2021 01:23:23 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id g30so18591985lfv.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 01:23:23 -0700 (PDT)
X-Received: by 2002:ac2:4885:: with SMTP id x5mr10152763lfc.487.1628324603028;
 Sat, 07 Aug 2021 01:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <87a6lvak43.fsf@disp2133> <20210806021052.3013-1-hdanton@sina.com>
 <87r1f7450i.fsf@disp2133> <20210806061458.3075-1-hdanton@sina.com>
 <CAHk-=wjdfLQ+z=uM3qUPSb1wgnugeN5+wyH11kmatUXskYqrCA@mail.gmail.com> <20210807050314.1807-1-hdanton@sina.com>
In-Reply-To: <20210807050314.1807-1-hdanton@sina.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 7 Aug 2021 01:23:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=whyqY=1cAOXTE1o=w2jm8CKcM47=iOR2o2aNundzUpa_g@mail.gmail.com>
Message-ID: <CAHk-=whyqY=1cAOXTE1o=w2jm8CKcM47=iOR2o2aNundzUpa_g@mail.gmail.com>
Subject: Re: [GIT PULL] ucount fix for v5.14-rc
To:     Hillf Danton <hdanton@sina.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 6, 2021 at 10:03 PM Hillf Danton <hdanton@sina.com> wrote:
>
> Then the current atomic_add_negative() in consideration over the "risk"
> of count overflow in real workloads can be replaced with the not_zero
> version.

What? No.

The atomic_add_negative() has absolutely nothing to do with not_zero.

The "negative" comes not at all from the count ever being zero, and as
I explained, that isn't even an issue here.

The "negative" is from a large _positive_ count growing so much that
the sign bit gets set. It's basically a "31-bit overflow" thing.

So:

 - not_zero makes no sense for get_ucounts(), because it can't be
zero, because we hold a reference to it

 - atomic_add_negative() is about not letting the counts become too
large, and when they do, we undo the reference (ie the pattern is
"increment ref - but if it then overflows into bit #31, decrement it
again"

and the two have *NOTHING* to do with each other. So your statement
about replacing one with the other makes no sense.

I was trying to explain that in _other_ situations, the
"atomic_inc_not_zero()" kind of pattern is used as a way to allow the
find-vs-last-drop race to be done without locking, but that's not what
the ucounts code does.

ucounts uses the ucounts_lock, and that one is entirely immaterial for
the atomic_add_negative() case, because the "negative" test is
literally about the value being as far away from zero as is _possible_
(and at that point, the lock is most definitely not needed - it's
needed only for the cases where the refcount goes to zero, and to make
sure that a "find" cannot race with that).

                Linus
