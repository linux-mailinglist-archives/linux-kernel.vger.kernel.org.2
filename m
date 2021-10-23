Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E5243821D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 09:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhJWHDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 03:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhJWHDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 03:03:50 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E4FC061766
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 00:01:31 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id t4so7925632oie.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 00:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3XNK8/G5+03RpD0j7S3Gnth3OiCNUfmJqhs9h8ooGSo=;
        b=OhhKJKYrQv2NReaxw4cm/Scx8uvk7T8c/UtJ4+TgQyHQwehrzn0IEa7aZ3IuOFY5KV
         htMmxSTP6og8HYaIgwEpCpEAyeLrvZ0yfSEo1YW7Ps25tC3+Ft3FslUZPYZb2Jq8QwcD
         /x5zpO4OkHKtILpME0y9/K0r8EjZf3s5Uf5zzn7WD7NoYLC1t8ksECAKHvVL/pl43j/i
         m7B8SxNuvXpSdJ7J0hkGK32jGUCSkgDaYM+ONY4QV5X5mlIHgCogFwGMUKBxaS27W1yX
         87hicmmVrqENF/YZbp7jiBMJodinxWOqDmDx+sQ9tHz5L827wHilSzAAPAwSaTA9N761
         0zQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3XNK8/G5+03RpD0j7S3Gnth3OiCNUfmJqhs9h8ooGSo=;
        b=l6j7WRY/94EfGADjxRzqlNK5dOF0FZ2HJJAKAq4SyiOMq26ZhIfVfvIJcjgp5BhgvR
         TOncHZEHqQ5CUI3L5bTU6QVTrqhyH14YmbPJh/aAbCNJgsuaR8VjdBJpSCs+cjjw6hsZ
         ugiEH7i+1RXON6CfkIVa/oTdN8S3Ns4Ey4hG5FyGRQ1FBc1eRUrVGqx7wSCd8iBtVOu/
         WPisKU8kDbxAgpsZhoe4S7QDENqKsB0P/Oz7ikr17CjAbYWTPUzdCZDeW0Dgmwj/OXE2
         94ENyEi3zdrfcxEyfn44Ddgpu2nEUw3PxJlPp/vkZV+/Wydz9o07ZIggoSh9/P1fGu7+
         nyDw==
X-Gm-Message-State: AOAM533vRUptQ9EL4axvJQucHctdXQKd9105FXZeAtt7U1Y2rD5CAayR
        8hFyRH6nwQczXSZM2EK/vueY3It5BagmkoO1TAEEvQ==
X-Google-Smtp-Source: ABdhPJwqjlmr9J6papGjZZdJkxgKQ8pcBdronrFAgFi4Gj7VPd8fHvjCUvJ/r3u7L7WJiohVGJLwV8tiuzu5W95dT6E=
X-Received: by 2002:a05:6808:d50:: with SMTP id w16mr13922075oik.128.1634972490639;
 Sat, 23 Oct 2021 00:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210927173348.265501-1-info@alexander-lochmann.de>
 <YVQkzCryS9dkvRGB@hirez.programming.kicks-ass.net> <927385c7-0155-22b0-c2f3-7776b6fe374c@alexander-lochmann.de>
In-Reply-To: <927385c7-0155-22b0-c2f3-7776b6fe374c@alexander-lochmann.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 23 Oct 2021 09:01:19 +0200
Message-ID: <CACT4Y+aH5dZTSw7+59GTDQyikP6CqXCD7AAhjciaS_MQSbrV6A@mail.gmail.com>
Subject: Re: [PATCHv2] Introduced new tracing mode KCOV_MODE_UNIQUE.
To:     Alexander Lochmann <info@alexander-lochmann.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Aleksandr Nogikh <nogikh@google.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Oct 2021 at 00:03, Alexander Lochmann
<info@alexander-lochmann.de> wrote:
>
> Maybe Dmitry can shed some light on this. He actually suggested that
> optimization.
>
> - Alex
>
> On 29.09.21 10:33, Peter Zijlstra wrote:
> > On Mon, Sep 27, 2021 at 07:33:40PM +0200, Alexander Lochmann wrote:
> >> The existing trace mode stores PCs in execution order. This could lead
> >> to a buffer overflow if sufficient amonut of kernel code is executed.
> >> Thus, a user might not see all executed PCs. KCOV_MODE_UNIQUE favors
> >> completeness over execution order. While ignoring the execution order,
> >> it marks a PC as exectued by setting a bit representing that PC. Each
> >> bit in the shared buffer represents every fourth byte of the text
> >> segment.  Since a call instruction on every supported architecture is
> >> at least four bytes, it is safe to just store every fourth byte of the
> >> text segment.
> >
> > I'm still trying to wake up, but why are call instruction more important
> > than other instructions? Specifically, I'd think any branch instruction
> > matters for coverage.,
> >
> > More specifically, x86 can do a tail call with just 2 bytes.

Hi Peter, Alex,

The calls are important here because we only use PCs that are return
PCs from a callback emitted by the compiler. These PCs point to the
call of the callback.

I don't remember exactly what's the story for tail calls of the
callback for both compilers, ideally they should not use tail calls
for this call, and I think at least one of them does not use tail
calls.

But even with tail calls, the callback is emitted into every basic
block of code. So it should be (call, some other instructions, call)
and at least the first call is not a tail call.
