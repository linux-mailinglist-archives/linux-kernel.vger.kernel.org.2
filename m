Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB414272E3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 23:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243337AbhJHVOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 17:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhJHVOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 17:14:48 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3CEC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 14:12:52 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b8so40977474edk.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 14:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EbVIsJCQSO+vbMr39E67OTfH62jkz85HI8YV0eMVgIY=;
        b=T7Z+PBZZ38/6eeh/G0tV6G+yxjOETQG+WszM1muqiScaLBeF+ZqJusgY97w/t0aTO3
         +MI1AGLBQEIWws+2qXERwclzdSHvOyGM7RvutJ6OjcI7wphFhBL8D5d5R9wT+v/lKNUB
         RPO1tE0qnxQiqKveu0tAXLppvxkNPbIAXXLwxZmmyTdBM2cKXrAx05BsmTQiQWyiKieo
         8UluRsflN+2B2C34sdt78fRGMCCkYjzFOnqjur3cgIrnOhZXe2MMxQHhg+TLsVrM2pDw
         DT5a17au43scpkF9zLSKfbSqon56fcuuQng06yVjEfMY5U05F0x/WSFA6+HITs3i5nPO
         Kjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EbVIsJCQSO+vbMr39E67OTfH62jkz85HI8YV0eMVgIY=;
        b=cvsL35qywSZCrd/il7+O3VqbiAoJFba0lfEaVrUvBlE76CzM/EGhwItJRIA2sD/08p
         dGnw4LBLok5csG0sbs+OfXSak5IEfFmxCUOt30EaHYQjy0PVOf0egoeeOLHECaBTyzeN
         oKcbjFLAwcLqUgQPwYNTol48KdOairUsw06HNikxtRCNBlKQL8c8fCnnQFZPcidRUVkY
         pZnH7py8vBXMdSheKUDEE9U8oUVjE+DTfJ7kiRRTjH/ardJLvn/va30xBZR3fsg4cFpE
         +/asYMjORb1+2beVs4kUhhzb66u3e/jWVyo/2MrbajI+Vx9iD0hpzxMTCxur48sEgvK4
         3fQw==
X-Gm-Message-State: AOAM533zKB6695xeYg2MevZ/igd92Fv3jfy1SvZaU+E4w0KRNVNjW/hT
        gwcuRLFiZX7E2MTxkCkasts5/kw/BkF5YAiR/Kde
X-Google-Smtp-Source: ABdhPJxgroJYCNaXqAYWnw5dFNkqDUN49FqbTznbw+BDWQCcH7lTpM7uryrWhhByaIb7UK+S2FmjYrhHEtPE4oeuQhs=
X-Received: by 2002:a17:907:7601:: with SMTP id jx1mr7240204ejc.69.1633727571022;
 Fri, 08 Oct 2021 14:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211007004629.1113572-1-tkjos@google.com> <20211007004629.1113572-4-tkjos@google.com>
In-Reply-To: <20211007004629.1113572-4-tkjos@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 8 Oct 2021 17:12:39 -0400
Message-ID: <CAHC9VhTRTcZW9eyXXvAN7T=ZCQ_zwH5iBz+d0h2ntf7=XHE-Vw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] binder: use euid from cred instead of using task
To:     Todd Kjos <tkjos@google.com>, casey@schaufler-ca.com
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, christian@brauner.io,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, keescook@chromium.org,
        jannh@google.com, Jeffrey Vander Stoep <jeffv@google.com>,
        zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        kernel-team@android.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 6, 2021 at 8:46 PM Todd Kjos <tkjos@google.com> wrote:
>
> Set a transaction's sender_euid from the 'struct cred'
> saved at binder_open() instead of looking up the euid
> from the binder proc's 'struct task'. This ensures
> the euid is associated with the security context that
> of the task that opened binder.
>
> Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
> Signed-off-by: Todd Kjos <tkjos@google.com>
> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Cc: stable@vger.kernel.org # 4.4+
> ---
> v3: added this patch to series
>
>  drivers/android/binder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This is an interesting ordering of the patches.  Unless I'm missing
something I would have expected patch 3/3 to come first, followed by
2/3, with patch 1/3 at the end; basically the reverse of what was
posted here.

My reading of the previous thread was that Casey has made his peace
with these changes so unless anyone has any objections I'll plan on
merging 2/3 and 3/3 into selinux/stable-5.15 and merging 1/3 into
selinux/next.

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

--
paul moore
www.paul-moore.com
