Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF8844F672
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 05:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbhKNE50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 23:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhKNE5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 23:57:25 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA56C061570
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 20:54:31 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id i9so12939667ilu.8
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 20:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ttNUxq0qtfBvTJ5kGfYiLGKmSoL+1Uh845zCE/sTC4U=;
        b=Xd84zFzt9p3IFvpswtGysN0/N1lRLIqokzpY7AMwiSJE7eS+Bu51kpPm8j7hH4ax/M
         prWi6klXpjnN/6IyvD6Htgpn1AdGh4GDiKqBL/g7Tr86IrkYePfbhl/INhoAnIpz81xZ
         E5YmVVUPQwDvhWkl99xqQp7QCz9NRXCWNs6PggX01gMwns9gUjgIuiJCQh8NK74SuT3I
         wnWtTCEgq/nKwnUB3yNXdg4K9couk1ERZ/CNRdolXikA9yXeXmsiUdvwwnKT8X5om0XS
         m/7VBZhDLQk3OWB3JyzlS7FX5VHerbzr43F4bwMV+5btrzJTQQ7d28c/uVDqEfvlY1Pl
         6jfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ttNUxq0qtfBvTJ5kGfYiLGKmSoL+1Uh845zCE/sTC4U=;
        b=hYnNGlFz8U9WRaljZUObdh+1rBg80FF7rS2HzLEjUsSXL70TQY2F+Ra2Dy+yCs3QrG
         LmYGxhzaqXuhTWj3PzUcnaUQWLJDLRfZoo2k9h7WANZMk7/jTIcKUn7QIlhoYGHn8y/m
         2bD6hhIhbFJzlOeabjw49y9Nj8I8tn0MqYnGo3MghsHNPnImDevQ7zdl+jQsvUbmN9Yb
         zyODMVIIQSkYw1FgBEZSTnilcgsijtn3FBZU9wfu7xVeqdQLe1xyDpPJ1ZTrioPTlN2h
         HqLyMQt9o/cuy0Cnha0ow2yH7vEQrPcWuP241Cej4LcAZ09AhWwkCxhoBAPcABllle/Y
         +aMA==
X-Gm-Message-State: AOAM530c6MIZr2en421yRt3jS61Vx/nOjv3OqXCWjJuvILMf84QqYQwG
        yrdd5mDkejqr+ZTfZOQZ9z2KyRztz8qY9/hb7a0wF6U=
X-Google-Smtp-Source: ABdhPJwJ0Hnd6C6hl/0Pjs1uzxgOl9hEuHKRHmnVUqgVO/NZ2bgbPWrW/f/FhWLMQYWCrMab+sweA5Pm0nHuQ57vIKk=
X-Received: by 2002:a05:6e02:190b:: with SMTP id w11mr16525865ilu.211.1636865671013;
 Sat, 13 Nov 2021 20:54:31 -0800 (PST)
MIME-Version: 1.0
References: <20211113124035.9180-1-brgerst@gmail.com> <20211113124035.9180-4-brgerst@gmail.com>
 <719e0170-7645-4787-8c3a-676f34068c27@www.fastmail.com>
In-Reply-To: <719e0170-7645-4787-8c3a-676f34068c27@www.fastmail.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Sat, 13 Nov 2021 23:54:19 -0500
Message-ID: <CAMzpN2gbOzsmnAh330+zk+ZZQmk-xNdUdCar6WaPrvHtgzknTA@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86_64: Use relative per-cpu offsets
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2021 at 8:18 PM Andy Lutomirski <luto@kernel.org> wrote:
>
>
>
> On Sat, Nov 13, 2021, at 4:40 AM, Brian Gerst wrote:
> > The per-cpu section is currently linked at virtual address 0, because
> > older compilers hardcoded the stack protector canary value at a fixed
> > offset from the start of the GS segment.  Use a standard relative offset
> > as the GS base when the stack protector is disabled, or a newer compiler
> > is used that supports a configurable location for the stack canary.
>
> Can you explain the benefit?  Also, I think we should consider dropping support for the fixed model like we did on x86_32.

This patch probably makes more sense if we drop the fixed model, as
that gets rid of alot of code that works around having to link the
percpu section differently.  I can respin this patchset to remove the
fixed model if it is agreed to require GCC 8.1 or later for stack
protector support.  The big question is if any actively supported
distributions still use an older compiler.

--
Brian Gerst
