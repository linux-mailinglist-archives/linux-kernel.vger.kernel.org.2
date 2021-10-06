Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8844424793
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 21:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239370AbhJFT5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 15:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhJFT5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 15:57:20 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9836C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 12:55:26 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id i24so14318425lfj.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 12:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O34eH0EHa4dBMbkzaLgHHRId8l/MAEnDKw9FowvQGtw=;
        b=edyHFq+vsfJFiZd8DhlRrAHySi3AsFfIcOaBRsKAK4GAw+GqH/Tkncskp+ehkhkvMJ
         Rh2FRF9TCAYHNO5g5j8g+lb0xmVeKVhFZ6ypCqlHS/CxvSsbDGbiIdCrJ50GYAkgoDXB
         9Sb4DaPWafxMxih6hnxJnEqkQX8cOODs1n7pML6RNkqDaOBKUqN94bTbsnZO0ZrfyTxW
         KCcWG4t1IUhi6fL2HVsgpiA8yXyKm+j13sKaJOdS8iGg9UAZdGzrE87+cCGOZt/dupST
         xw5XIxspcb5yhHEaZRQmQCmulymMeghKLzA/lGlYMS9Fz+fSqOmBElUx5g8238R1pbbB
         Evyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O34eH0EHa4dBMbkzaLgHHRId8l/MAEnDKw9FowvQGtw=;
        b=18aTtK/4/cVNcl+EpOyyeIAHx8snIkL1kn0imrcdg1M9SovMeKJBllL9x7/EidTuEo
         hiYvCw5Sl7AbTNBL/SbOM1Pdky6dc76zy+x/cF8EzdWLvyFvEFs5kHWEvtWmg2Wu8B1q
         V5RmhVduUyNyshWP4lLc7eKpoL3xUJuXb3veKibnHKLFXENfBub5tXwRkS1UFknGl+UT
         7rvvKirwbtAPdt6ohNGPo1L0qkgI6chzSDpLPfndR3yanYJCIaoQ1CIJlT4IqvidR2iG
         BxVFtYQJfc9c+9FA8nPRCQ3p/e1i7dBXHSMlIKh5T/nrQtfTMWdT5uTgaw0ZMjsAMj1M
         QvTg==
X-Gm-Message-State: AOAM531TUvAC5LI7MuUTLTii4FDRy8JHH+lnJHUDYUx6RvxoC9ZLbQrT
        tPYsva6CGbxBrV6nfWezooUph/DUm+NACg/cRTZltg==
X-Google-Smtp-Source: ABdhPJxvYTzX1/2a+GZtvlTtfbjZ2f1aHuPdE1JLzkl2Tf4YIk/gPLeLtgxyWjoSngDOiqBUv32ywAZBk6mznY+UUkI=
X-Received: by 2002:a05:6512:2290:: with SMTP id f16mr11688585lfu.668.1633550125028;
 Wed, 06 Oct 2021 12:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211006194610.953319-1-tkjos@google.com> <20211006194610.953319-4-tkjos@google.com>
In-Reply-To: <20211006194610.953319-4-tkjos@google.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Wed, 6 Oct 2021 12:55:13 -0700
Message-ID: <CAHRSSExN4g0qubjjLhdGx5DA7njT5ZwPkAzCY1OEdR1dbscLVA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] binder: use euid from cred instead of using task
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, christian@brauner.io, jmorris@namei.org,
        serge@hallyn.com, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        keescook@chromium.org, jannh@google.com, jeffv@google.com,
        zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     joel@joelfernandes.org, kernel-team@android.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 6, 2021 at 12:46 PM Todd Kjos <tkjos@google.com> wrote:
>
> Set a transaction's sender_euid from the the 'struct cred'
> saved at binder_open() instead of looking up the euid
> from the binder proc's 'struct task'. This ensures
> the euid is associated with the security context that
> of the task that opened binder.
>
> Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
> Signed-off-by: Todd Kjos <tkjos@google.com>
> Stephen Smalley <stephen.smalley.work@gmail.com>

This should have been "Suggested-by: Stephen Smalley
<stephen.smalley.work@gmail.com>"

> Cc: stable@vger.kernel.org # 4.4+
> ---
> v3: added this patch to series
>
>  drivers/android/binder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 989afd0804ca..26382e982c5e 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2711,7 +2711,7 @@ static void binder_transaction(struct binder_proc *proc,
>                 t->from = thread;
>         else
>                 t->from = NULL;
> -       t->sender_euid = task_euid(proc->tsk);
> +       t->sender_euid = proc->cred->euid;
>         t->to_proc = target_proc;
>         t->to_thread = target_thread;
>         t->code = tr->code;
> --
> 2.33.0.800.g4c38ced690-goog
>
