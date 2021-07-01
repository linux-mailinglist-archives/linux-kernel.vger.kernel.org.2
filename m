Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082483B9848
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 23:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbhGAVoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 17:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbhGAVoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 17:44:05 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF32C061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 14:41:33 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id q18so14390740lfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 14:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cSLIj5ijLv21MczqPZ//LmnEGNGY+Io9XntuI4cnzoQ=;
        b=dXQn8I1a2yN1cBmeKPtYWYtIIhKKS/PS4Fir76apBP7PT1Qn1TN9VvXgVyFndwp6Se
         lPYo3d0jKOsDiTtAmrblfXulaJXTA2jFuhkmV7AM4FfEAhbo135IjiZ8wLGAY9muHzM9
         m6GleTnZkrNR86145I3k1RFKMPl59JzpEQKDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cSLIj5ijLv21MczqPZ//LmnEGNGY+Io9XntuI4cnzoQ=;
        b=uT/iDSIarLaKg/aF1kQrZsrx3WEJqcAqSjjVo2vv923JiK6jlfVcl6X+od+DsMsH5O
         quLBDn5rSZUyB5XzgaTkeCXSnc7AY03c0K7qxNtXyxcbeHLevuMwMpkJKRRpBx+yyywg
         oDefhh7ZB4XpmB9/TrXg4mbWF7dMoHKvdZA1LavuLLYFbqm5JytTu9S4FrVg7v2HF21F
         SMpnUlre9YzdB5fGzuMHAr+agH/kUkcxABdWTYyjefZN9854JRHHZqanJwe4KRoZGu0v
         Y7J4YDti7z4QR2a1c6DAanJoQy0Pn0s4raym2OX3jZOnPLvNMDjuMOlabFE6+Emg1IBy
         o1JA==
X-Gm-Message-State: AOAM531xbx4lwenKb5kAfQWVpWR+Q+xxLD5u+1bOOULIeCh5xtc98rj2
        SUoaYzdStXSqX7t6m71dcSYvt+66lqkgFgM/rS0=
X-Google-Smtp-Source: ABdhPJyf2+5xN/Bxr0z0qp7wX5fnuesOVGRR7X0oj6Q7QB+M6YjJHBclD8w/azoL/UqXEOmtmp/GIw==
X-Received: by 2002:ac2:533c:: with SMTP id f28mr1311413lfh.268.1625175692079;
        Thu, 01 Jul 2021 14:41:32 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id x3sm142854ljd.90.2021.07.01.14.41.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 14:41:31 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id e3so2024036ljo.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 14:41:31 -0700 (PDT)
X-Received: by 2002:a05:651c:32e:: with SMTP id b14mr1183040ljp.251.1625175691224;
 Thu, 01 Jul 2021 14:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210701204246.2037142-1-agruenba@redhat.com>
In-Reply-To: <20210701204246.2037142-1-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Jul 2021 14:41:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjk6KP3vSLFNPMjoaZ4xY4u=DjTM+C+hCS3QKt+XAE6OA@mail.gmail.com>
Message-ID: <CAHk-=wjk6KP3vSLFNPMjoaZ4xY4u=DjTM+C+hCS3QKt+XAE6OA@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Fix mmap + page fault deadlocks
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 1, 2021 at 1:43 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> here's another attempt at fixing the mmap + page fault deadlocks we're
> seeing on gfs2.  Still not ideal because get_user_pages_fast ignores the
> current->pagefault_disabled flag

Of course get_user_pages_fast() ignores the pagefault_disabled flag,
because it doesn't do any page faults.

If you don't want to fall back to the "maybe do IO" case, you should
use the FOLL_FAST_ONLY flag - or get_user_pages_fast_only(), which
does that itself.

> For getting get_user_pages_fast changed to fix this properly, I'd need
> help from the memory management folks.

I really don't think you need anything at all from the mm people,
because we already support that whole "fast only" case.

Also, I have to say that I think the direct-IO code is fundamentally
mis-designed. Why it is doing the page lookup _during_ the IO is a
complete mystery to me. Why wasn't that done ahead of time before the
filesystem took the locks it needed?

So what the direct-IO code _should_ do is to turn an ITER_IOVEC into a
ITER_KVEC by doing the page lookup ahead of time, and none of these
issues should even exist, and then the whole pagefault_disabled and/or
FOLL_FAST_ONLY would be a complete non-issue.

Is there any reason why that isn't what it does (other than historical baggage)?

               Linus
