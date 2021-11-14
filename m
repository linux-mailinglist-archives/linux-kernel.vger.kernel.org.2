Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A577244FA0D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 20:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbhKNTF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 14:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbhKNTFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 14:05:50 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA46C061746
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 11:02:50 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x15so61858604edv.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 11:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b+ABDQXsBUyVLtXlNRqtyl8o9biKyBrTUCqIxKOLyuU=;
        b=B9CeaN2r881/Way6TIyQtHvBfngi1muQE0Rs1xXkaiOWQpY38MhI/PYz1Nkr8b7MZd
         8tGS4oeixS7lNGh/1Sz24bNtp83CmlDiM0h5wzKRVjhx0PDFpXvYDzgwWjlGDSfD0RYp
         WwYqXN4OPhSw8PcyeudfXH958VRg8C5BBRRmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b+ABDQXsBUyVLtXlNRqtyl8o9biKyBrTUCqIxKOLyuU=;
        b=YkoaU4Q1zU7OuajtToL1ZwSxzM8XjJ2eE4zF+o3tuWnZoewOdv8ZU47o+FOKYN3DIb
         krV0imzT3S7cO+0O3QLE9uZJuJWr1c+gGaftNBB6pIwm2d306tcUqTRLGfIFMz3QM0M2
         1aS70QZOiXtPnIUMMcRj4paE47wiUCSIvyzA6IjBmR7ZvyocoCI3uqEAul8IeF9r5jjw
         XhhwaCT9widnwCy40aJaeKbcvYzWzsx4VyePEH5V/OY50BQwJ4Lhqbk8xbEmRgp6UwSj
         9taMVgIp8Btr/wmEqtY1RRGFVxNj0tAKkJLLsdZ4PPhplPvy3m3uP7KTnAUdeVUa8RJo
         zJiw==
X-Gm-Message-State: AOAM530SUkbou01miwJfawCgq7MciknvbD/hA8LYSQUc+MH3Usnda0Dl
        dJj9saRSPDN3zMlrVa98Q7FXYcohXrXKJTCp7Ys=
X-Google-Smtp-Source: ABdhPJwG/vxRfa3KZOTYDifNPFngXF57DdeqUSMlqUbUE0QTWCkJ5+ykBV07YZ8TOJW3RQbE3P7vAw==
X-Received: by 2002:a17:907:7d86:: with SMTP id oz6mr40253509ejc.193.1636916568554;
        Sun, 14 Nov 2021 11:02:48 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id u14sm6153793edj.74.2021.11.14.11.02.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Nov 2021 11:02:48 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id u1so26165140wru.13
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 11:02:47 -0800 (PST)
X-Received: by 2002:adf:d1e2:: with SMTP id g2mr39177688wrd.105.1636916567700;
 Sun, 14 Nov 2021 11:02:47 -0800 (PST)
MIME-Version: 1.0
References: <163689642456.3249160.13397023971040961440.tglx@xen13> <163689642744.3249160.6971106813056927807.tglx@xen13>
In-Reply-To: <163689642744.3249160.6971106813056927807.tglx@xen13>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Nov 2021 11:02:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjQxHwdC61ore062Hc5PAF2o6CJnDG_NsQe+e599RovJw@mail.gmail.com>
Message-ID: <CAHk-=wjQxHwdC61ore062Hc5PAF2o6CJnDG_NsQe+e599RovJw@mail.gmail.com>
Subject: Re: [GIT pull] timers/urgent for v5.16-rc1
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2021 at 5:31 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> +       /*
> +        * A copied work entry from the old task is not meaningful, clear it.
> +        * N.B. init_task_work will not do this.
> +        */
> +       memset(&p->posix_cputimers_work.work, 0,
> +              sizeof(p->posix_cputimers_work.work));
> +       init_task_work(&p->posix_cputimers_work.work,
> +                      posix_cpu_timers_work);

Ugh.

Instead of the added four lines of comment, and two lines of
"memset()", maybe this should just have made init_task_work() DTRT?

Yes,. I see this:

        /* Protect against double add, see task_tick_numa and task_numa_work */
        p->numa_work.next               = &p->numa_work;
        ...
        init_task_work(&p->numa_work, task_numa_work);

but I think that one is so subtle and such a special case that it
should have been updated - just make that magic special flag happen
after the init_task_work.

A lot of the other cases seem to zero-initialize things elsewhere
(generally with kzalloc()), but I note that at least
io_ring_exit_work() seems to have this:

        struct io_tctx_exit exit;
        ...
        init_task_work(&exit.task_work, io_tctx_exit_cb);

and the ->next pointer is never set to NULL.

Now, in 99% of all cases the ->next pointer simply doesn't matter,
because task_work_add() will only set it, not caring about the old
value.

But apparently it matters for posix_cputimers_work and for numa_work,
and so I think it's very illogical that init_task_work() will not
actually initialize it properly.

Hmm?

I've pulled this, but it really looks like the wrong solution to the
whole "uninitialized data".

And that task_tick_numa() special case is truly horrendous, and really
should go after the init_task_work() regardless, exactly because you'd
expect that init_task_work() to initialize the work even if it doesn't
happen to right now.

Or is somebody doing init_task_work() to only change the work-function
on an already initialized work entry? Becuase that sounds both racy
and broken to me, and none of the things I looked at from a quick grep
looked like that at all.

              Linus
