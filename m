Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3E3379892
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 22:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbhEJUvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 16:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhEJUvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 16:51:13 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFF7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 13:50:08 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id m7so5942952ilg.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 13:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+OPH32eMyvWVljUKupcgNYrsp+22kITMh1bNgQuNG54=;
        b=Mxjxihzh//9zKcu9Ei/s7qpprfPr0u6IWd/fzG/27jG6O59oV+tfK4/196kyU31Vcl
         3nSGBuQQvB66D/v7ppQcnRoAsabD/OhMkAkCh9ev8A3nkJhVCwYlm39d7pXdJ264+48s
         +HI1esCqRgNIuzrxE1+BCB3zfAROJXA/dbOBX5dOQRzeucERNZzChMSkYmrAYgdJV24b
         utcpquXLHT6v5hQWpDg18BYyfonggHceKG03q6Q1vlyEC8O/L162JWQjgIYAyMfLqq6y
         tW224WjoE6dM9wXytcfyTASLjZ9+hpH4WSr7e84wm+je4DzjYy3EXHk+FC0BiZccNGNI
         ojIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+OPH32eMyvWVljUKupcgNYrsp+22kITMh1bNgQuNG54=;
        b=V+DqsjrBmQbOo8OW8gXQ4Z+769Rhzcye5haNqwDuV1sZR5LS/vxUjexS0Z7587InvH
         q7+BHHFzqbEPJriHCL6h3zifsdBGs8N58WEM9AKIbgDafx8IECgdYFRbiNEwQkET12J4
         nbcBqOuv0hXrOkvTDwssfY/JUL7RiITTByLC++o0gfLQ5sCAY1rhSDvbQEZTs2vEYwEE
         zc8sjlu5GIq21hYhYVX75eo3P5hTdRru8u3d7baW+6xyI3rDZZCrgQ7+00ZSE7cLczCg
         Xx9uxpFDWK+cWLn/PRHv9VOnjbOhUNt0Uuv4l45E/km5Qz58hj8f+uNg0c58sEuXxLg/
         a7Pg==
X-Gm-Message-State: AOAM531neoe4m1tljwZLYLMvyiSSUow0UwNWIJma09xFJWpzSALOPk8C
        0XOta7Xgn/7jnwjOBgOw6+n1eRYWALZf5HDRAlU=
X-Google-Smtp-Source: ABdhPJxECFuCLykYB7YKe0je6q9qiM93rrTQq38VoIiZuQvsqL5p9dNor139YkV9lGC/+C8bXFsEpZBY1+j4DckipRU=
X-Received: by 2002:a92:d3c4:: with SMTP id c4mr21581909ilh.50.1620679807782;
 Mon, 10 May 2021 13:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210509044330.4655-1-pauldzim@gmail.com> <02957632-b050-f9eb-fcd8-75db9c92b8e0@ubuntu.com>
In-Reply-To: <02957632-b050-f9eb-fcd8-75db9c92b8e0@ubuntu.com>
From:   Paul Zimmerman <pauldzim@gmail.com>
Date:   Mon, 10 May 2021 13:49:42 -0700
Message-ID: <CADBGO7_cH2e1-zgVNvwVPRogqeFjTfJhKcuTfdF=xc_GoMmknA@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH RFC] Revert "drm/i915: Try to use fast+narrow
 link on eDP again and fall back to the old max strategy on failure"
To:     Timo Aaltonen <tjaalton@ubuntu.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 7:00 AM Timo Aaltonen <tjaalton@ubuntu.com> wrote:
>
> On 9.5.2021 7.43, Paul Zimmerman wrote:
> > This reverts commit 2bbd6dba84d44219387df051a1c799b7bac46099.
> >
> > Since 5.12-rc2, my Dell XPS-15 laptop has had a blank screen on boot.
> > The system seems to run fine other than having no display, I am able
> > to ssh into the machine. I don't see anything interesting in the dmesg
> > log. I bisected the problem down to this commit, and reverting it fixes
> > the problem.
>
> Have you tried with drm-tip? It has acca7762eb71bc0 which hopefully
> helps here.

I picked that one commit from the drm-tip tree (wasn't sure how to merge
the entire tree into the kernel) and can confirm that it does fix the problem.
Thank you! I hope the fix will be sent to Linus pretty soon, and it will need
backporting to the 5.12 kernel as well.

- Paul
