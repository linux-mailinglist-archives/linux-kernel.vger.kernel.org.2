Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CB338D964
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 09:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhEWHH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 03:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbhEWHH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 03:07:26 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7809C061574;
        Sun, 23 May 2021 00:06:00 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id b13so32127941ybk.4;
        Sun, 23 May 2021 00:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JJ5WTjC0WyPsVTwdflI4inh3P5TZgEqktVKMaXkm0+4=;
        b=XfbRWKZ83w1iYHQb/7Q6VC4Sm8CjCl/EbdECqi4PiSpCXcaVNmNx+NKKaih+Nv442A
         0XXFcaq8XeKCb/Ql0Pa79WFp/+IBWiE01/aOd2kmZQwOeAyOOjwV7gg8jFPLnZ5RVDuQ
         xVLM26jpsB4mBtmX2ot+Kyg3VKxvUMwuVYKCjseXUzqmY3X6x/a5+CCAiqOlDx+1FUsJ
         s/8EeoK1fBy+S772FsRBM3QA3qJqpHihyg6KuA+FWoe79F9qt/gvQ6uvKKBOAiPJORlj
         oA0yq7bgLpnaEgZPsyghQOvnPHhUTzP/qWnPz5vpxUjEPy3L50RxoI7wxMhaKZgnPIu2
         1cKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JJ5WTjC0WyPsVTwdflI4inh3P5TZgEqktVKMaXkm0+4=;
        b=UVVkxPkA3rEyv2OBPO1OGwyNvMWp8Ec7WrBfdPF2XkgUPTuOlMXWUs3UdlPqVVOO0I
         Bf7q3Q7ibVaKCodPhFYysetNR4MaS+dKDbCmpEkR7QbnUOE5G7bvuY8mQK5KJLxVNc/Y
         4DRnf88LBxCewQ8o0i9cTk9tD+WbJXx4yyQshcddGkUXYzqhLhdr+cHSeGht/GygyjzY
         eDOEgWOx9mDT7fre7kZUfFN0Wjrz7MEclV+ieJv5H2aP4tI8o/vjDJyUcHE5GRDcP9Nv
         M34YNt1ppEBUXZd20ypjqAbTA0hgi4luWpuMiZO8cJWtlGQHqYHpiVuaI1nEBIqvlPEV
         bqTA==
X-Gm-Message-State: AOAM532i0J69yMbGMN9I+bYXgy0LFrB3Sru3uoLJshh73PcWO0yZ5+0d
        LmumCSLzXZSoeLtu+li8I+lRz5dNd4gFKpjr1PxlUBpOb6I=
X-Google-Smtp-Source: ABdhPJy8qNErGH7nLxNMW7tCxFmbqj0Gw6sLxEeWq6AbALM0JRYgNwvGePaVDxKETnbyLvPHNvNsqwFd/m0LV2kutjU=
X-Received: by 2002:a25:850b:: with SMTP id w11mr25666807ybk.518.1621753559766;
 Sun, 23 May 2021 00:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210518052117.14819-1-lukas.bulwahn@gmail.com>
 <20210518052117.14819-2-lukas.bulwahn@gmail.com> <69da627e-91c5-66f0-c0c9-75fbaaba6782@kernel.org>
In-Reply-To: <69da627e-91c5-66f0-c0c9-75fbaaba6782@kernel.org>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Sun, 23 May 2021 09:05:48 +0200
Message-ID: <CAKXUXMw21Up0WhSX0V=h5oYcw-ocLT0Bv=tUaekA1beoo6u+aA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] MAINTAINERS: TTY LAYER: add some ./include/linux/
 header files
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 7:37 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>
> On 18. 05. 21, 7:21, Lukas Bulwahn wrote:
> > An early prototypical automated code analysis of headers and the
> > existing MAINTAINERS sections identified some header files in
> > ./include/linux/ to be probably included into the TTY LAYER section.
> >
> > I further checked those suggestions by this analysis and identified a
> > subset of files that I am rather certain to belong to the TTY LAYER.
> >
> > Add these ./include/linux/ header files to TTY LAYER in MAINTAINERS.
> >
> > The patterns include/linux/tty*.h and include/linux/vt_*.h currently cover:
> >
> >    include/linux/tty.h
> >    include/linux/tty_driver.h
> >    include/linux/tty_flip.h
> >    include/linux/tty_ldisc.h
> >
> >    include/linux/vt_buffer.h
> >    include/linux/vt_kern.h
>
> Yes, that looks good.
>
> Can you extend the tool to include/uapi too?
>
> For example this is missing too:
> include/uapi/linux/tty*.h
>
> It expands to:
> include/uapi/linux/tty_flags.h
> include/uapi/linux/tty.h
>

Jiri,

Greg already picked this patch up; so I will keep this patch as-is and move on.

But I agree:
I am still tuning my script and that still needs a bit of work, so I
will still need some time until the next patches will follow.
Once I am happy with the script and I go back to manual checking,
review and adjustment of its output, I will follow your suggestion,
and prioritize to check that all additions for ./include/linux and
./include/uapi/linux are complete.
However, I will probably not come back to the TTY LAYER for a while
(until I can fully automate those patches with high confidence). The
patch for the next subsystem will probably be MEMORY MANAGEMENT or so,
depending if the manual checks and reviews show that the patches are
sufficiently good for that second try. I will come back to TTY LAYER,
once my method can assign all files in ./include sufficiently well to
its corresponding MAINTAINERS section; that will then be probably part
of a larger patch series for all MAINTAINERS sections and not just to
check the method for one or two sections.

Lukas
