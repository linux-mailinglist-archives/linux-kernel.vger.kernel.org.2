Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933FC3B4BEE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 04:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhFZCIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 22:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhFZCIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 22:08:40 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FC2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 19:06:17 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id h15so19442453lfv.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 19:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1r9fda5xI/fIh7bSJ74jyECq8A2FTtDKQSX+15pKXGQ=;
        b=Z7UIltlgkmoVglUnL+W5so59xngkmaGjrNilGK5+1Pr/N7Bpe9av7CbiH7mf0wuBm1
         ecMr0OyoJgta2kCfUvc28arqVCHXlBh/hrLEKop6ChNWVnOYzwOqvrWzFereIeFjZiUx
         pfKa3bxjQTkFvhFJztoflrLkHKVGqafNzFSUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1r9fda5xI/fIh7bSJ74jyECq8A2FTtDKQSX+15pKXGQ=;
        b=p+si+xUfmv5HEw/mokUurVYD2MgKdu64WXLTwx1AURDIGPqE/1GAFSi195GxBLgeu9
         F9/TdSDjU/P4aMOIslJJjpIRmg3Y4DfFi7qBJXNcoJvA2/7cMNS/N0RGEFl+ynFZ6h0V
         X7WgV/DXfNYRfXSoH4N2sbTaLsbJEbKNdeTm5gluGh4fXoPONXNQ4QgqYr/2sIjbZ/19
         RajZfEqbBPSdn51Et6ULI0RB/00NQctZAF7JCmpHoeCtb/FfdMEznXunIz7OHSua7BzJ
         8nabe18+ju1g4Yg4NLDw1zoHiCOZzMRHpp3Vv34ieglEfc7pitj2Xfv5CTDLRw7jERyi
         MShA==
X-Gm-Message-State: AOAM532h0Mv594li9ok/aloBL1V2V0ji2MwqcmMaKLjP9U9D2sQ5hPHR
        MdZfDH8NPMUGC35lZM5/MTNuGpiJSl6bYk3Y
X-Google-Smtp-Source: ABdhPJyl3X2klX4CHQZML4YEN/dnx4T7XPvPhxFJbHaMKwV4Vr46kys8ONSqEUJd/dqPQbQt0mR3MA==
X-Received: by 2002:a05:6512:2294:: with SMTP id f20mr9998127lfu.120.1624673175377;
        Fri, 25 Jun 2021 19:06:15 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id b13sm657058lfo.104.2021.06.25.19.06.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 19:06:15 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id d25so15128145lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 19:06:14 -0700 (PDT)
X-Received: by 2002:a2e:a276:: with SMTP id k22mr10301538ljm.465.1624673174147;
 Fri, 25 Jun 2021 19:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <YNYz+hVeqsQmiEqN@localhost.localdomain> <YNZG6N0W/7gjG7Gm@localhost.localdomain>
 <20210625163040.a15af04872959da9af161fca@linux-foundation.org>
In-Reply-To: <20210625163040.a15af04872959da9af161fca@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Jun 2021 19:05:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=whVa=nm_GW=NVfPHqcxDbWt4JjjK1YWb0cLjO4ZSGyiDA@mail.gmail.com>
Message-ID: <CAHk-=whVa=nm_GW=NVfPHqcxDbWt4JjjK1YWb0cLjO4ZSGyiDA@mail.gmail.com>
Subject: Re: [PATCH v2] ELF: add and use SUPPRESS_WARN_UNUSED_RESULT
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 4:30 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> I can't imagine who added this to load_elf_binary():
>
>         if (current->personality & MMAP_PAGE_ZERO) {
>                 /* Why this, you ask???  Well SVr4 maps page 0 as read-only,
>                    and some applications "depend" upon this behavior.
>                    Since we do not have the power to recompile these, we
>                    emulate the SVr4 behavior. Sigh. */
>                 error = vm_mmap(NULL, 0, PAGE_SIZE, PROT_READ | PROT_EXEC,
>                                 MAP_FIXED | MAP_PRIVATE, 0);
>         }
>
> I think it was there before most of us were born.  The comment has a
> torvaldsy/viroey feel to it.

Heh.

It goes back to at least 1.1.14 (1994, I think) and originates in the
ibcs code (Intel Binary Compatibility Specification 2), back in the
dark ages when we thought that mattered.

Native Linux binaries were still a.out at that point. When ELF then
became a native thing, we just moved (or copied) the old iBCS2 code
over, and that "map zeroes at NULL" came along.

And I think it's actually Eric Youngdale who did that code. See

    https://www.linuxjournal.com/article/2809

and

    https://www.linuxjournal.com/article/1059
    https://www.linuxjournal.com/article/1060

> Do we really care about userspace which relies upon an SVR4 quirk?  I
> guess it's too hard to prove the no case, so it stays.

I think we can safely remove it. Doing a mmap() at address zero will
not actually work anyway in any half-way modern Linux environment.

And I think the "map zeroes at NULL" wasn't even universal for SVr4.
_Some_ binaries may have expected it, but I suspect it was the
exception rather than the rule.

So I'd happily take a patch that just removes it. If nothing else, it
would be trivial to put back if somebody screams, but I seriously
doubt that is going to happen.

            Linus
