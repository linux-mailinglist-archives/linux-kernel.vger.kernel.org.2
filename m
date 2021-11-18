Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606FE455196
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 01:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241868AbhKRAUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 19:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbhKRAUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 19:20:44 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F3DC061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 16:17:45 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id r5so3701692pgi.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 16:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0/ePZE53xfRM2dxJ7WwM0t/fbqT3BR+OwaQ6jXETuSg=;
        b=Yp1qatYRFLIvWBaM0TjVdzqVsKSbignbTKKebZ4BgYnl6h7NXeL8KqH+ixaFRfMdEv
         gW5stvA3Pnq1rC1YED5iV2UlbkI9WUc2YrFRSEdScghZFOsSiP2h+I6IEVzMgRlYOK3S
         j668nZBmXWtR549TdjJq3h7XNahZqf5H2dKR/ZZ4NBLNi7wqxruhTCgzaDctsVbqZnR3
         wIaAiHu8Rezf8nku2UyPl8HhP/tMFfIh4vFx9rYSudT3AL6FvdgZsx+SCsMRWmTAtA8k
         2YjHIlZd2s1gGU5/TLRgGLbPgdSV0xeoBpSNfusZg6Zsazd8VTr7pNsJYD4GH6UEGBFL
         3o7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0/ePZE53xfRM2dxJ7WwM0t/fbqT3BR+OwaQ6jXETuSg=;
        b=cpoyOs8oWo5it7W6ymtddF9mE5QDjaz9gv9zUIDQoyA2U2Kc3pQDMrI6qteo5j6ioM
         zXLQ6yNg4qtoZdGpcLNT1bBS5xH5prgsmfuPybiyOapylUyUx5st3j8GX5gDT5QKzm9R
         4vW/7C5vE2+lhpuy8YRIhHWHC2C9wlqwORbqLXXvags/cutoKkdcjEqJlZNB7DUo8OpF
         7/0M2N9e1ecr7/IMcGt9GogeBRXjONGEskk6BUxHPn6TClFW5g8oz6ir4FgwgobVCr42
         k05CL/HTV1BRhgV8sSNRwmmEJaiVU8nul03FGm0WylpjWxQB2l4TCiKhy0r/E7bs4SmX
         Pxsw==
X-Gm-Message-State: AOAM531yOGgk5H8xEGTMr+UTgLrx+fYqsy4kFZXCIn7BLiNK1x+/6w6G
        OSTBCqhuWXFP07MZIR6ZyyGNmfcEkDClo9UIynATFg==
X-Google-Smtp-Source: ABdhPJw7Abfxxj63AWlbfApMBpQn9WUmA4dR75/tohCovpw6teKJTH7u5CX53d+ZgvP7u1M07z4spaUo+W7gauBvKG4=
X-Received: by 2002:a63:600c:: with SMTP id u12mr8388097pgb.146.1637194664489;
 Wed, 17 Nov 2021 16:17:44 -0800 (PST)
MIME-Version: 1.0
References: <20211117181922.3e9a2329@gandalf.local.home> <CAHk-=wgcrEbFgkw9720H3tW-AhHOoEKhYwZinYJw4FpzSaJ6_Q@mail.gmail.com>
 <20211117190039.61d9746e@gandalf.local.home>
In-Reply-To: <20211117190039.61d9746e@gandalf.local.home>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Wed, 17 Nov 2021 16:17:33 -0800
Message-ID: <CAC_TJvcFkcsFBmAr_nsNOODcjX_wuKKsBgbSKFc5AwAyByufdQ@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Fix double free bug
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 4:00 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 17 Nov 2021 15:38:59 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > On Wed, Nov 17, 2021 at 3:19 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > On error, the operands and the histogram expression are destroyed,
> > > but since the destruction is recursive, do not destroy the operands
> > > if they already belong to the expression that is about to be destroyed.
> >
> > Honestly, this seems horribly ugly.
>
> I guess we have a difference in opinion to what is ugly, as the v1 version
> of Kalesh's patch was closer to yours, and I hated the complexity of having
> to know when to to call what. Because the logic is not that simple.
>
> See https://lore.kernel.org/all/20211117021223.2137117-1-kaleshsingh@google.com/
>
> >
> > The problem seems to be that the "goto error" cases are simply just wrong.
> >
> > Why isn't the fix to make the error cases be the right ones, instead
> > of having one odd error case that then has to do some magic things to
> > not free the wrong things?
> >
> > The patch ends up a bit bigger, mainly because I renamed the different
> > "free" cases, and because I made the non-freeing ones just return the
> > error directly.
>
> I agree with the first part of your patch, which was not the reason for
> being the cause of the bug.
>
> >
> > Something like this (UNTESTED!) patch, IOW?
>
> But the part after the expr is allocated gets a bit more tricky, and that
> is why I requested that logic, namely due to the "combine_consts" case. But
> as the expr->operand[]s are NULL'd and the operand*s are destroyed, I guess
> it's still fine with just freeing the expr if we add an error case there.
>
> Kalesh, care to spin a v3 implementing Linus's solution?

Hi Steve,

Yes I'll resend a new version, more in line to Linus suggestion.

Thanks,
Kalesh
>
> -- Steve
