Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234A3310022
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 23:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhBDWgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 17:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhBDWgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 17:36:22 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE73C061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 14:35:42 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id r20so3697191qtm.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 14:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c/LawSxYi3ooi+jx8tMFJRDuOSYkGLnBjCJsS5cMwW0=;
        b=cIXN/L4+RBamqknWxJ/9/w3hWJCbFughWGOh8tKQhhbr1vyJlN2/Y6ezV8omFtTe+N
         aMxqaH/cgxkKM5dGNBRLf/O0b/4f3Qa72sChKuupte1DJVR5Wi6XU2Rfbj3iMOw/4GCG
         m5COjHVSDa9MjZLGnXOok4XnBUElnZSftpk2vP822PAsjPzUzpPQtzoAUvrcI+Qn9gwx
         nbKHg3eKzrD7QogB2c0S4re7q9qa2c5fdX1sHtiYFIGIDODHUpM0x/1uQWNeuAMJEOob
         GejXnwd3DINbfqbhuGtj+v3E/MaxIlbhRt9f83hr8NnKEhWKJPL055oj3Fzuaqtf4PIH
         z9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c/LawSxYi3ooi+jx8tMFJRDuOSYkGLnBjCJsS5cMwW0=;
        b=sKCPSYmS+Rrwb7246y5wblM7earZX6T42WN0qtsCUojwfTgVo8xl84hkqZB3HQw8+b
         LJb7Gg/GUpLRxgSudggPahtbo1OqnhO4n2HLKV+xl4p+DlXMSdwL21TRzjkIzgrQAK66
         vQJzdaX4OdbVEfTZPdqFFrw1wrR1BjsQ5t9QzdK0Jqym+AhqNSpfGDsjA6b/8vzsWdAp
         b+QTwkrtx/Eyjx7Hx1A4MrrgZh8CEW9q10r6cLp+N6SqcMGxcRnWdCgtzDa6gTMtwnh5
         cdaQ8OEVV/LoU1DnV0fQq+dO4IHB6nHcbc8GAbpkMlxHjwblxtx2OCdeezSeEqtDKbyZ
         V4AA==
X-Gm-Message-State: AOAM533wIG89OtxjHly3KdwGFltgLg1rKa6INAo2FsG6Lt0ejzKq/0+u
        NOsbApaqV7ie61DbbuvnPDODwVT7VWuo35HLbJdDY19wuq7aQQ==
X-Google-Smtp-Source: ABdhPJzPkXWd+YjJHiQnow5l7lj0QifzOMZJgw4xBeJPEZoWco8N8dgoxBaBvr+6FxemS1snSrLDFig/UxwA3WrBvGE=
X-Received: by 2002:ac8:5bc4:: with SMTP id b4mr1822554qtb.240.1612478141862;
 Thu, 04 Feb 2021 14:35:41 -0800 (PST)
MIME-Version: 1.0
References: <PS1PR04MB29345AB59076B370A4F99F75D6B39@PS1PR04MB2934.apcprd04.prod.outlook.com>
In-Reply-To: <PS1PR04MB29345AB59076B370A4F99F75D6B39@PS1PR04MB2934.apcprd04.prod.outlook.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Fri, 5 Feb 2021 09:35:31 +1100
Message-ID: <CAOSf1CGJ6ZeowMP8Zjo3TazYyaEGuEab4-QRKRJ2jjixUGGtCA@mail.gmail.com>
Subject: Re: [PATCH] arch:powerpc simple_write_to_buffer return check
To:     Mayank Suman <mayanksuman@live.com>
Cc:     Russell Currey <ruscur@russell.cc>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 5:17 AM Mayank Suman <mayanksuman@live.com> wrote:
>
> Signed-off-by: Mayank Suman <mayanksuman@live.com>

commit messages aren't optional

> ---
>  arch/powerpc/kernel/eeh.c                    | 8 ++++----
>  arch/powerpc/platforms/powernv/eeh-powernv.c | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index 813713c9120c..2dbe1558a71f 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -1628,8 +1628,8 @@ static ssize_t eeh_force_recover_write(struct file *filp,
>         char buf[20];
>         int ret;
>
> -       ret = simple_write_to_buffer(buf, sizeof(buf), ppos, user_buf, count);
> -       if (!ret)
> +       ret = simple_write_to_buffer(buf, sizeof(buf)-1, ppos, user_buf, count);

We should probably be zeroing the buffer. Reading to sizeof(buf) - 1
is done in a few places to guarantee that the string is nul
terminated, but without the preceeding memset() that isn't actually
guaranteed.

> +       if (ret <= 0)
>                 return -EFAULT;

EFAULT is supposed to be returned when the user supplies a buffer to
write(2) which is outside their address space. I figured letting the
sscanf() in the next step fail if the user passes writes a zero-length
buffer and returning EINVAL made more sense. That said, the exact
semantics around zero length writes are pretty handwavy so I guess
this isn't wrong, but I don't think it's better either.

>         /*
> @@ -1696,7 +1696,7 @@ static ssize_t eeh_dev_check_write(struct file *filp,
>
>         memset(buf, 0, sizeof(buf));
>         ret = simple_write_to_buffer(buf, sizeof(buf)-1, ppos, user_buf, count);
> -       if (!ret)
> +       if (ret <= 0)
>                 return -EFAULT;
>
>         ret = sscanf(buf, "%x:%x:%x.%x", &domain, &bus, &dev, &fn);
> @@ -1836,7 +1836,7 @@ static ssize_t eeh_dev_break_write(struct file *filp,
>
>         memset(buf, 0, sizeof(buf));
>         ret = simple_write_to_buffer(buf, sizeof(buf)-1, ppos, user_buf, count);
> -       if (!ret)
> +       if (ret <= 0)
>                 return -EFAULT;
>
>         ret = sscanf(buf, "%x:%x:%x.%x", &domain, &bus, &dev, &fn);
> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
> index 89e22c460ebf..36ed2b8f7375 100644
> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> @@ -76,8 +76,8 @@ static ssize_t pnv_eeh_ei_write(struct file *filp,
>                 return -ENXIO;
>
>         /* Copy over argument buffer */
> -       ret = simple_write_to_buffer(buf, sizeof(buf), ppos, user_buf, count);
> -       if (!ret)
> +       ret = simple_write_to_buffer(buf, sizeof(buf)-1, ppos, user_buf, count);
> +       if (ret <= 0)
>                 return -EFAULT;
>
>         /* Retrieve parameters */
> --
> 2.30.0
>
