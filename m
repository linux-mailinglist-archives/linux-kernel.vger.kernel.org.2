Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706F6389E81
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 08:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhETG75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 02:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhETG7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 02:59:54 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CD4C061574;
        Wed, 19 May 2021 23:58:32 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id b13so20013281ybk.4;
        Wed, 19 May 2021 23:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OOnCvrmBVmZJvIgFsTp0MHGvpgi/wTmOhJpH9VAETjw=;
        b=Lm4gDSJqG2vlLHYaqIzBqUjvv3o692GWvO3G47R0akkLAgEXRBwntlShNPZmt74ghm
         nws0+SLM+qiy4bca7mi2DahPnFGPuN9bXp1mjqJ7jTj0+9UJr9it1fikC0MT1RwXQyhf
         AvWFeQcfKcCTO26z3HIJWcScl5mkyPehCDMCQn3pn0z51W8UVPJgLoe7vu8zZXaQmO+W
         I6gCZEvmUBu7FwaAtgBiraaYHRTz/g6SjOAvTepYvn0pTMJXxgw+M+IIBN7g0EOH7ior
         +kx+EwuOgYjt2NRVY4oLlPESzbteXcaR+EA/VKD9F2X5dUf0Sx/FkDkZZ8uX5R34dsak
         /wxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OOnCvrmBVmZJvIgFsTp0MHGvpgi/wTmOhJpH9VAETjw=;
        b=lD4xAaZnFEX/IOWz+mXAzCCUmr/fmxxXrX4DR5GXG4b35TqGTZSyRIj4FrSWZVfG2n
         KelCs0e0Oj4ffHenZlPJNZBKIE/qu4iSEpXHPRojJMcaq6CqiPaARl6WDsWCKEYaY8f1
         80fKOjTN55CBb1JNl/d0iB0v52nbErpqUeJBz1Z5IMekIjqzPckH/kuqvqdTkSMxqIkn
         XwAkFWxTdqYfqdNGZT9YUDFAw1pgv5YB52CTgXfQi21d0gfvObOGiOrbKlRuCU1JDike
         aaGidBhz2DnoKftXVcsHFSVPGjah1ZbI7poiwEgpOQLT7EmevdpsSMBuytRHpheJrpFo
         V1ow==
X-Gm-Message-State: AOAM531mcTlR6lBbnJe8MUAxb+nw/7R/dTJ73NlB9lh5tDI9QoBzgP9d
        zl30q4cmrDPdei5BkXHBi7rXQabOatO6BY1vadY=
X-Google-Smtp-Source: ABdhPJzes7jm5YzVxbSEXeWNu/17oBVCUgxdbC4mNsKxCn3j7Xc8THnPTTi32iNdIu7wBIbjGyiP4k7v2+VxuuZP+3M=
X-Received: by 2002:a25:5d08:: with SMTP id r8mr4651409ybb.464.1621493911937;
 Wed, 19 May 2021 23:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210520015704.489737-1-andrew@aj.id.au>
In-Reply-To: <20210520015704.489737-1-andrew@aj.id.au>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 20 May 2021 08:58:21 +0200
Message-ID: <CAKXUXMxTnz6edBLpBgqOo6uUiSGm8rULH9P8G24xx2OhP_Yb6A@mail.gmail.com>
Subject: Re: [PATCH] Documentation: checkpatch: Tweak BIT() macro include
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        openbmc@lists.ozlabs.org, Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 3:57 AM Andrew Jeffery <andrew@aj.id.au> wrote:
>
> While include/linux/bitops.h brings in the BIT() macro, it was moved to
> include/linux/bits.h in [1]. Since [1] BIT() has moved again into
> include/vdso/bits.h via [2].
>
> I think the move to the vDSO header can be considered a implementation
> detail, so for now update the checkpatch documentation to recommend use
> of include/linux/bits.h.
>
> [1] commit 8bd9cb51daac ("locking/atomics, asm-generic: Move some macros from <linux/bitops.h> to a new <linux/bits.h> file")
> [2] commit 3945ff37d2f4 ("linux/bits.h: Extract common header for vDSO")
>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Looks sound to me.

I would prefer a bit of word-smithing the commit message by just
removing the references:

So:

> While include/linux/bitops.h brings in the BIT() macro, it was moved to
> include/linux/bits.h in commit 8bd9cb51daac ("locking/atomics, asm-generic: Move some macros from <linux/bitops.h> to a new <linux/bits.h> file"). Since that commit, BIT() has moved again into
> include/vdso/bits.h via commit 3945ff37d2f4 ("linux/bits.h: Extract common header for vDSO").
>
> I think the move to the vDSO header can be considered a implementation
> detail, so for now update the checkpatch documentation to recommend use
> of include/linux/bits.h.
>

And then drop references [1] and [2].

Andrew, what do you think?

Lukas
