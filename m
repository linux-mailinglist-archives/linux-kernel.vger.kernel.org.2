Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B48344E4F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhCVSTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:19:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230465AbhCVSTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:19:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E77461998
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 18:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616437150;
        bh=cdPpn3bt7dQ/SwR6Dy7EJSGEakSRnVumbWhThjLvpUc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ig2dXZ7ya8sNkFozuTgi5W6y9J2EXekKgRlM1HiQaNB/3/YWllzoWA2uj9Dk6Gxot
         c8OYF13r5sAhuGUU2j8ZpwjyCp7bDl4NicFuDnUJxxP+c+htgTJv3IqaeEfprMd9Jz
         TW7rJ7yFUWB3eYR6w6rS6g9h90wNqi0tmi8PXcecWF/0Nf23MC0oYYRP0ZXlt7jerq
         1wv0bo98kRhYRaBn502GKr4F2Adul/durycOsGJlE8KAyWExidh2tjwzhVUyzI9w2L
         pAcGdtSxsIl/XrsBLiGD7/MkzrMfoS0+BMN6nvsAobPQIbcr7/cA8swpTPu+1/nMxN
         i6NLBjIBVRPzg==
Received: by mail-oi1-f181.google.com with SMTP id m13so14046396oiw.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:19:10 -0700 (PDT)
X-Gm-Message-State: AOAM531c8Lc9WC9Nf3AzA5BSVOn4NmMscdO9J31ruR8OVxXhlu+ubJUI
        CDJHNw1hacBwGDzZ2GREzHbwuBJwuFvsARkPqEA=
X-Google-Smtp-Source: ABdhPJxSLNPBxXBFB8iEKPeuTux32ku2fkG7glt0LYjH9Mkhk2/DYQAu3FtNVJIcSki7YiLz4HABxLu8570f24xCyfE=
X-Received: by 2002:a05:6808:3d9:: with SMTP id o25mr305830oie.4.1616437149772;
 Mon, 22 Mar 2021 11:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210322164308.827846-1-arnd@kernel.org> <CAD=FV=WY6yxx+vkH+UU4VYei29xBftdnyRBE1OpEELmJ-kLfFg@mail.gmail.com>
In-Reply-To: <CAD=FV=WY6yxx+vkH+UU4VYei29xBftdnyRBE1OpEELmJ-kLfFg@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 22 Mar 2021 19:18:53 +0100
X-Gmail-Original-Message-ID: <CAK8P3a33qv79GedMCwA=GFBWYCMB2fYrq2QmGpN3TWfqgg8j2A@mail.gmail.com>
Message-ID: <CAK8P3a33qv79GedMCwA=GFBWYCMB2fYrq2QmGpN3TWfqgg8j2A@mail.gmail.com>
Subject: Re: [PATCH] kgdb: fix gcc-11 warning on indentation
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@elte.hu>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 6:07 PM Doug Anderson <dianders@chromium.org> wrote:
> On Mon, Mar 22, 2021 at 9:43 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > -#define v1printk(a...) do { \
> > -       if (verbose) \
> > -               printk(KERN_INFO a); \
> > -       } while (0)
> > -#define v2printk(a...) do { \
> > -       if (verbose > 1) \
> > -               printk(KERN_INFO a); \
> > -               touch_nmi_watchdog();   \
> > -       } while (0)
> > -#define eprintk(a...) do { \
> > -               printk(KERN_ERR a); \
> > -               WARN_ON(1); \
> > -       } while (0)
> > +#define v1printk(a...) do {            \
>
> nit: In addition to the indentation change you're also lining up the
> backslashes. Is that just personal preference, or is there some
> official recommendation in the kernel? I don't really have a strong
> opinion either way (IMO each style has its advantages).

I don't think there is an official recommendation, I just think the
style is more common, and it helped my figure out what the
indentation should look like in this case.

>
> > +       if (verbose)                    \
> > +               printk(KERN_INFO a);    \
> > +} while (0)
> > +#define v2printk(a...) do {            \
> > +       if (verbose > 1)                \
> > +               printk(KERN_INFO a);    \
> > +       touch_nmi_watchdog();           \
>
> This touch_nmi_watchdog() is pretty wonky. I guess maybe the
> assumption is that the "verbose level 2" prints are so chatty that the
> printing might prevent us from touching the NMI watchdog in the way
> that we normally do and thus we need an extra one here?
>
> ...but, in that case, I think the old code was _wrong_ and that the
> intention was that the touch_nmi_watchdog() should only be if "verose
> > 1" as the indentation implied. There doesn't feel like a reason to
> touch the watchdog if we're not doing anything slow.

No idea. It was like this in Jason's original version from 2008.

        Arnd
