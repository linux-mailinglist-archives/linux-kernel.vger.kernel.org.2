Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D2637AD1C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 19:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhEKR3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 13:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhEKR3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 13:29:40 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F319C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 10:28:33 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id e11so12579815ljn.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 10:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RrNlIBNi0pzHeAbx2nI9bp+BT2pTo5nJxLzfaP11f6Y=;
        b=V7LgU5PcP4+3f+tLSMObksyzIebdnSvKK63MWqHO2ODHDAUYSrJRYbFBX2qv/dmyuc
         4mAZnM/E7KYBqOhy+wIwu0rkfv5GNYJ/fd6cro5o+GfV8aRLEeI0JUMgO6GBjTe5e3r2
         0oZemDf/7Kj9eSnUYgD+Zcix4Oxo8Fr0IsYTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RrNlIBNi0pzHeAbx2nI9bp+BT2pTo5nJxLzfaP11f6Y=;
        b=tR+eB2mG+nVDMlfVz/ClZ9zU8WblI9X3QwZxQJul94MRPAu4AGIaD2Z5fGDluVeFmP
         Ir8+lRgzQP8TMopSwMxLy54o5yZtQMkAy5+/wXjDp7Ju8DGo1RA1oTA+LUqSpqF/EmTD
         7gWZP9bshQh7zpCaErBBTL8B4bxLr/uQ24scxSfwpoUboNYvQBlfv2R+7+Pu4gh3iKuF
         lIlKvMFigVgo52nJ8uFxazPL2C1ldNNKdZw03nupU7hOxtCksImJH8xL1ZPvqxyvHJsy
         rtEWkA6WE7jQw/ZAtrAETUo5b5tXwUjFW92Pr5bFw97KXPziydrlbOBn5IfT+o/rkf0b
         RoYw==
X-Gm-Message-State: AOAM532LTpmGd1esKGmUqFYDqo7rR06Fx28ieNexv42WXlKMGMpLU7HC
        f3rxgzhaiBKsxKzxZwjgwgdU8TtqSokdtklP
X-Google-Smtp-Source: ABdhPJw9ljjig87Ar94YpI31jKvzDaeS4TUfwTd7UCrweximY7bsQpxdxFAUP594Pacpc8lf1ibJ2w==
X-Received: by 2002:a2e:9211:: with SMTP id k17mr26155176ljg.284.1620754111584;
        Tue, 11 May 2021 10:28:31 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id f18sm2707851lfu.157.2021.05.11.10.28.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 10:28:30 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id b7so26129108ljr.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 10:28:29 -0700 (PDT)
X-Received: by 2002:a05:651c:33a:: with SMTP id b26mr26092232ljp.220.1620754109305;
 Tue, 11 May 2021 10:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210511165626.GA13720@redhat.com>
In-Reply-To: <20210511165626.GA13720@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 May 2021 10:28:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLqbTNc1T+rHCm-kxbVAuhK3hjo5fOgDVf5-z--x1mvQ@mail.gmail.com>
Message-ID: <CAHk-=whLqbTNc1T+rHCm-kxbVAuhK3hjo5fOgDVf5-z--x1mvQ@mail.gmail.com>
Subject: Re: [PATCH RESEND2] ptrace: make ptrace() fail if the tracee changed
 its pid unexpectedly
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Pedro Alves <palves@redhat.com>,
        Simon Marchi <simon.marchi@efficios.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 9:56 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> This patch makes ptrace() fail in this case until debugger does wait()
> and consumes PTHREAD_EVENT_EXEC which reports old_pid.

I'm ok with the patch, just wondering which way it's supposed to come
to me. Should I just apply it directly?

That said, why this:

> +       rcu_read_lock();
> +       pid = task_pid_nr_ns(task, task_active_pid_ns(task->parent));
> +       rcu_read_unlock();

I don't see why the RCU read lock would be needed? task_pid_nr_ns()
does any required locking itself, afaik.

And even if it wasn't, this all happens with siglock held, can
anything actually change.

             Linus
