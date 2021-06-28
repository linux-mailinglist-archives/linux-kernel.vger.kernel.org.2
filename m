Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8793B673F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 19:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhF1RJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 13:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbhF1RJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 13:09:25 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC85C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 10:06:59 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a18so11660007lfs.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 10:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i8xDOyJ3LavDXHLbsdcYAyH/4RDP5lTkaIHc3Uc8npA=;
        b=htoR2qtuvvWWrBCEwU5CZRnDkcAfg4lvqp+OKxdcxlIMvCBV0act99GPc4fxnp3kQG
         mL01srRVJbyo+ALMwwKAq0aTxxTPSgycYaWbixzL73vUxX7WXajQSgw3so2O0xz6sf/C
         9XDKqf7aZxD8WxY528Ufmmw2Z5mxV4JF1naa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i8xDOyJ3LavDXHLbsdcYAyH/4RDP5lTkaIHc3Uc8npA=;
        b=KBOi5tpyYKwve1TnO5+kjovNZhRt90lkbc3NoIOL/cXmZpGhIEhfENl+1TTCnsmi+k
         1hrrI80bhfjtk5MOmZFnJZ/aQJCYXQ2YSCdb4jAALKBalmvJuwe1v00yPD0hC+j3xbeg
         cZbUbt9sEjZkT0ePe72neKbhxBqNSKylXLvTT8ANBbZf48KM6WPqHPWj9WnJiNNxgHtR
         OQWuYjDMHXIUl3UIOx3O6QSBUJEanz3KdYIyNn4nArTE+o/yR0uBNoP5wBhEf3dLFGlD
         bpZsyAHmFI8s2gOaMaXbY16v8rFzsvXyrqMezCUa6Zj1aRH9/9l4bTkf0uJzLEjS/t3v
         P+9Q==
X-Gm-Message-State: AOAM531f5zIWdxBD3oNnIM99iHSekDwVXHWXNmbY805yVr5jCW7MJ4dp
        wzIX7tP4oikhczw+AwXDPOXtohHhfA6CBV5X
X-Google-Smtp-Source: ABdhPJyifYudFqvZ+J/dRmVTb1sH0LhPsQGBpW8Ie4UnNr6sF/laECMVYle52jwcTPY6ftrDTWvaWA==
X-Received: by 2002:ac2:5088:: with SMTP id f8mr19859006lfm.233.1624900017535;
        Mon, 28 Jun 2021 10:06:57 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id o11sm200208lfb.218.2021.06.28.10.06.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 10:06:56 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id d16so33802052lfn.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 10:06:55 -0700 (PDT)
X-Received: by 2002:a05:6512:374b:: with SMTP id a11mr19158370lfs.377.1624900014858;
 Mon, 28 Jun 2021 10:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <YNQwgTR3n3mSO9+3@gmail.com> <CAHk-=wiebYt6ZG4Cp8fWqVnNqxMN4pybDZQ6gwsTWFc0XP=XPw@mail.gmail.com>
 <CAHk-=wgEyk9X5NefUL7gaqXOSDkdzCEDi6RafxGvG+Uq8rGrgA@mail.gmail.com>
 <CAHk-=wiJq0Ns7_AFRW+rvZcD_m+1t5cYgvQRO-Gbp8TEK1x1bQ@mail.gmail.com> <YNlapAKObfeVPoQO@gmail.com>
In-Reply-To: <YNlapAKObfeVPoQO@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Jun 2021 10:06:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjLNCm5kNnbHkw38c1t80FAPVYmNOOiTvdqedNm1SQRZg@mail.gmail.com>
Message-ID: <CAHk-=wjLNCm5kNnbHkw38c1t80FAPVYmNOOiTvdqedNm1SQRZg@mail.gmail.com>
Subject: Re: [GIT PULL] sigqueue cache fix
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 27, 2021 at 10:14 PM Ingo Molnar <mingo@kernel.org> wrote:
>
> The most fundamental race we can have is this:

No. It's this (all on the same CPU):

   sigqueue_cache_or_free():

       if (!READ_ONCE(current->sigqueue_cache))
                     <-- Interrupt happens here
               WRITE_ONCE(current->sigqueue_cache, q);

and then the interrupt sends a SIGCONT, which ends up flushing
previous process control signals, which ends up freeing them, which
ends up in sigqueue_cache_or_free() again, at which point you have

       if (!READ_ONCE(current->sigqueue_cache))
               WRITE_ONCE(current->sigqueue_cache, q);

again.

And both the original and the interrupting one sees a NULL
current->sigqueue_cache, so both of them will do that WRITE_ONCE(),
and when the interrupt returns, the original case will overwrite the
value that the interrupt free'd.

Boom - memory leak.

It does seem to be very small race window, and it's "only" a memory
leak, but it's a very simple example of how this cache was broken even
on UP.

              Linus
