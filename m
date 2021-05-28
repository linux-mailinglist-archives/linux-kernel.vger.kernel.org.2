Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8147394511
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 17:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbhE1P3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 11:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbhE1P3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 11:29:52 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E95FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 08:28:17 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id o8so5841831ljp.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 08:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O8+KLwgLoww+TmbrLVoD0p0vfc5UfRumQ9Rk3w9z9h8=;
        b=YfV3IKdCsLwZauDK47dXQKw8qQev721rxkMQ2amyhwwlp2+vg29NFNkVQ0CI96DIL/
         VlKAcimBaX4mE7C4SpTPqKEZd+z9/CqtSaA/9rKJedEurN1v6ASAp3oW8icBk4OADbHU
         un+717GDRcPZgm0R6NVTP/11PI2Irq1W48EUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O8+KLwgLoww+TmbrLVoD0p0vfc5UfRumQ9Rk3w9z9h8=;
        b=L4knE60yp3jsK+MeiVWoe/5Ycb15LjT/NafWld1BQPLYWi7wf6pDF9ZGxegwGSWqbX
         9a3qBjJg6lMvA57QE4Wx0TIlGUdOMrG8BnD+4iEEeXtusy/0ebfndFnjoaiacsLAuBk7
         UthTY08+GIDcGYjLmWd5igqCw35vKKDk2COp5dPCVIahFsfVaPRnUTrdnlNWvXuW9tn/
         flnWLpez4raQPOpjv1vBfHp/G7FTm3oDvDElgM7mxUvXkd6BET9CVWjfxY2YX1dHl9Np
         iMS7ZTlB7RX3f3LbHAfyZoLIddlRo5DCT4vaxtp68DHBGwT+1jwbYikpIvXjJbZO3PFA
         MW6g==
X-Gm-Message-State: AOAM532M2TLql6dk7K2u/nv3OQqe1erqNf3g5gRxymijjFDvdQ0gPO0k
        wb7cpZSnbl20YL6kPXXlNSoRtfPd80pVP9UxrHnmew==
X-Google-Smtp-Source: ABdhPJwnj+xo62zd1H1eayR77ymUvylc6snJlV4WoIE1RLjcfXeq9Sd+xHPaqkosXu42TIDk93sc22FOsZL6FIvyA/E=
X-Received: by 2002:a2e:9787:: with SMTP id y7mr6946175lji.65.1622215695592;
 Fri, 28 May 2021 08:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210517193908.3113-1-sargun@sargun.me> <20210517193908.3113-3-sargun@sargun.me>
 <CACaBj2YUiowSKzvh02OjpQNqQViA8N0eyRMimkK=90NagRF40w@mail.gmail.com> <202105271137.C491991621@keescook>
In-Reply-To: <202105271137.C491991621@keescook>
From:   Rodrigo Campos <rodrigo@kinvolk.io>
Date:   Fri, 28 May 2021 17:27:39 +0200
Message-ID: <CACaBj2aaDkJwDM8ugR5LxWEOho3nZuHjYLLsth3XYjf39tpaQQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] seccomp: Refactor notification handler to prepare
 for new semantics
To:     Kees Cook <keescook@chromium.org>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        LKML <linux-kernel@vger.kernel.org>, containers@lists.linux.dev,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 8:42 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, May 27, 2021 at 01:51:13PM +0200, Rodrigo Campos wrote:
> >
> > Kees, as I mentioned in the linked thread, this issue is present in
> > 5.9+ kernels. Should we add the cc to stable for this patch? Or should
> > we cc to stable the one linked, that just fixes the issue without
> > semantic changes to userspace?
>
> It sounds like the problem is with Go, using addfd, on 5.9-5.13 kernels,
> yes?

Yes.

> Would the semantic change be a problem there? (i.e. it sounds like
> the semantic change was fine for the 5.14+ kernels, so I'm assuming it's
> fine for earlier ones too.)

No, I don't think it will cause any problem.

> > Just to be clear, the other patch that fixes the problem without
> > userspace visible changes is this:
> > https://lore.kernel.org/lkml/20210413160151.3301-1-rodrigo@kinvolk.io/
>
> I'd prefer to use the now-in-next fix if we can. Is it possible to build
> a test case that triggers the race so we can have some certainty that
> any fix in -stable covers it appropriately?

I've verified that Sargun's patch also solves the problem in mainline.
I have now also verified that it applies cleany and fixes the issue
for linux-stable/5.10.y and linux-stable/5.12.y too (without the patch
I see the problem, with the patch I don't see it).  5.11 is already
EOL, so I didn't try it (probably will work as well).

The test case that I have is quite a complicated one, though. I'm
using the PR we opened to runc to add support for seccomp notify[1]
and a seccomp agent slightly modified from the example in the PR with
some cgo to use addfd, and need to run it for several thousand
iterations, as the kernel needs to be interrupted in a specific line
and some kernel locks to be acquired in a specific order for this to
trigger. If you think it is important, I can try to cleanup the code
and share it, but the issue is basically what I explained here:
https://lore.kernel.org/lkml/20210413160151.3301-2-rodrigo@kinvolk.io/

Can we cc this patch to stable, then? :)


Best,
Rodrigo

[1]: https://github.com/opencontainers/runc/pull/2682
