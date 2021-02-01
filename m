Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71DF30AF5B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbhBAScv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:32:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:60182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232713AbhBASaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:30:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C881B64EC2
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 18:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612204196;
        bh=FipONDQzL82MzeHTs/g79CTahBPGOxpEHTPTJ0lePDc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HF5crvQOCYinS+g2qYz1n3FPqCP4s0WXG5bCzGQ5NIpFnDjDFT9wf3VfmedKU09dm
         N6UTwD3wGk/V2fxdrdTTUHMPpTblp9jMXon6pDt0tYMAiLEDTHno//bYY2s8JTyWYw
         PfbrzFlWWDWgqEuF4A5d3Qa/AXAWUMxdYhcA2lKqw9KacCRL7Yrbr23zZN3IrUHqZ6
         iLK3m1WD9fkk1T3g+QTtH46wQ36MMebmDR+2xtO9CqqMeGFMMROSoAkzlfoAQli0Se
         CfAfDnCEvAk0hLNBG/lDb7FIx85lEe9R/VNDMJDPKcpD2nVsQzY7km4rs53VBuc0xL
         Xf33um5WqOsUQ==
Received: by mail-ed1-f41.google.com with SMTP id g10so1763099eds.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:29:55 -0800 (PST)
X-Gm-Message-State: AOAM530QVqbmFh1kN0jz6GXTcp+OoHax2orkv6C/vF1SYvUcWxF9iJZF
        WV4zJiLD5+/o1rfb2vYtWXxsD3H7icoqyiTsBm+k8Q==
X-Google-Smtp-Source: ABdhPJw6dOEhiDFQAUIeq5FJYdEMHcfVEg53N7ay6QjEuCeH9MAxxhgO+nJtKNrTdXQpFRzl1I/ycbrY7LopiZrzeFE=
X-Received: by 2002:a05:6402:3585:: with SMTP id y5mr19862404edc.97.1612204194301;
 Mon, 01 Feb 2021 10:29:54 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9oHBtR4fBBUY8E_Oi7av-=OjOGkSNhQuMJMHhafCjazBw@mail.gmail.com>
In-Reply-To: <CAHmME9oHBtR4fBBUY8E_Oi7av-=OjOGkSNhQuMJMHhafCjazBw@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 1 Feb 2021 10:29:42 -0800
X-Gmail-Original-Message-ID: <CALCETrVGLx5yeHo7ExAmJZmPjVjcJiV7p1JOa4iUaW5DRoEvLQ@mail.gmail.com>
Message-ID: <CALCETrVGLx5yeHo7ExAmJZmPjVjcJiV7p1JOa4iUaW5DRoEvLQ@mail.gmail.com>
Subject: Re: forkat(int pidfd), execveat(int pidfd), other awful things?
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jann@thejh.net>,
        Christian Brauner <christian.brauner@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 9:47 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Andy & others,
>
> I was reversing some NT stuff recently and marveling over how wild and
> crazy things are over in Windows-land. A few things related to process
> creation caught my interest:
>
> - It's possible to create a new process with an *arbitrary parent
> process*, which means it'll then inherit various things like handles
> and security attributes and tokens from that new parent process.
>
> - It's possible to create a new process with the memory space handle
> of a different process. Consider this on Linux, and you have some
> abomination like `forkat(int pidfd)`.

My general thought is that this is an excellent idea, but maybe not
quite in this form.  I do rather like a lot about the NT design,
although I have to say that their actual taste in the structures
passed into APIs is baroque at best.

If we're going to do this, though, can we stay away from fork and and
exec entirely?  Fork is cute but inefficient, and exec is the source
of neverending complexity and bugs in the kernel.  But I also think
that whole project can be decoupled into two almost-orthogonal pieces:

1. Inserting new processes into unusual places in the process tree.
The only part of setuid that really needs kernel help to replace is
for the daemon to be able to make its newly-spawned child be a child
of the process that called out to the daemon. Christian's pidfd
proposal could help here, and there could be a new API that is only a
minor tweak to existing fork/exec to fork-and-reparent.

2. A sane process creation API.  It would be delightful to be able to
create a fully-specified process without forking.  This might end up
being a fairly complicated project, though -- there are a lot of
inherited process properties to be enumerated.

(Bonus #3): binfmts are a pretty big attack surface.  Having a way to
handle all the binfmt magic in userspace might be a nice extension to
#2.

--Andy
