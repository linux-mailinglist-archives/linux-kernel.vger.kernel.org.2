Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B0D4579AD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 00:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236091AbhKSXnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 18:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236028AbhKSXnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 18:43:14 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B0FC061748
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 15:40:11 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b1so49922858lfs.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 15:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rBqNH03SQHw54nf1sSLFeWZJtpAA4tMJRhcRf6KK130=;
        b=ZEUS3rHgG5f2CCTc1i5ALCmvS4HcCVZiaidRuvK86lumr9erVB2h2XrBaYGm7oIjKp
         JWQJtexwctyJWKSZdCQVixTIO2Zxj3BoXhxok/WV0QIi5SJJsgdwVKwexMLdJE97En+3
         iE9UfXKoSopnS4zhM5A3LGjsMGvogDbNEVQ7YDxixypMv3iUuOzbmd4lWJfqJQZgKeRS
         7b/sJfvO+At756/nSyk9U+8OOMUIv/j1CC4fTM06hC+oIGQJvZRxvVeFRXLT6H6twA8M
         Bskhfub2s1U69JF2cRPZXO93m8/NhW/yqzRgVarKHG+TF/56zv1FoScXbVc8eg/CMpiN
         mT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rBqNH03SQHw54nf1sSLFeWZJtpAA4tMJRhcRf6KK130=;
        b=YCDW0zwcPUtorcq/KK73i8VZUcdpBpLq7vO8D5T6vNlmo+PCA4OEtBhpqJ8Uof4OKP
         S+LGRs/OAXKD0zfDph77o0KbwTWyhm05Y2W/8/0X7FE4dpVKLqDYE8GTbVqKTzbYLwi9
         o6b+pHSXBbjwhzMTbVScKVouLKTxYjy/pEp2oxWJqjder0Am9KG8WetOO3Wzwjxu7rOz
         uS1ipUSWbvmp2m1dHa2uzZOkjw4PNNqwDMtvWmTzb6guowduc862Mogv/0cAh/FA7BBP
         aHtlzJCsOAGZiMMIX62jxxhlGfRlOSp2IfQwKzGPqTBeR2ZCl/0TmMUo4fB+CrJwSnU8
         UN7A==
X-Gm-Message-State: AOAM53210Lgjlo3qU6ITrqRKhY3I0Pz7UM3zTCr7uKFk76JIYAsg+EMB
        t6Csup3Ds1/yjl+kRIa+PtL0amBnvlyE4439VZfh0w==
X-Google-Smtp-Source: ABdhPJzxz4GreJQD8XtyasARCmhfSzifXzAHxJK+0NBW3rz8ATOv0jsOv/R4JyiSyBLSmIv/Uo7ALRra8bmC0ysep0g=
X-Received: by 2002:a05:6512:22c7:: with SMTP id g7mr37002485lfu.668.1637365209836;
 Fri, 19 Nov 2021 15:40:09 -0800 (PST)
MIME-Version: 1.0
References: <20211112180720.2858135-1-tkjos@google.com> <CAHC9VhQaHzrjdnr_DvZdPfWGiehC17yJVAJdVJMn8tOC1_Y+gA@mail.gmail.com>
In-Reply-To: <CAHC9VhQaHzrjdnr_DvZdPfWGiehC17yJVAJdVJMn8tOC1_Y+gA@mail.gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Fri, 19 Nov 2021 15:39:59 -0800
Message-ID: <CAHRSSEwUUUxXOnb2_fg1qnEXbCtD+G7KW8=xwKZFA5r-PKcPBg@mail.gmail.com>
Subject: Re: [PATCH] binder: fix test regression due to sender_euid change
To:     Paul Moore <paul@paul-moore.com>
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, christian@brauner.io, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, keescook@chromium.org, jannh@google.com,
        jeffv@google.com, zohar@linux.ibm.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, kernel-team@android.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 3:00 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Fri, Nov 12, 2021 at 1:07 PM Todd Kjos <tkjos@google.com> wrote:
> >
> > This is a partial revert of commit
> > 29bc22ac5e5b ("binder: use euid from cred instead of using task").
> > Setting sender_euid using proc->cred caused some Android system test
> > regressions that need further investigation. It is a partial
> > reversion because subsequent patches rely on proc->cred.
> >
> > Cc: stable@vger.kernel.org # 4.4+
> > Fixes: 29bc22ac5e5b ("binder: use euid from cred instead of using task")
> > Signed-off-by: Todd Kjos <tkjos@google.com>
> > Change-Id: I9b1769a3510fed250bb21859ef8beebabe034c66

Greg, I neglected to remove the "Change-Id" from my Android pre-submit
testing. Can you remove that, or would you like me to resubmit without
it?

> > ---
> > - the issue was introduced in 5.16-rc1, so please apply to 5.16
> > - this should apply cleanly to all stable branches back to 4.4
> >   that contain "binder: use euid from cred instead of using task"
> >
> >
> >  drivers/android/binder.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> This looks okay to me.  I assume this is going in via GregKH's tree?
>
> Acked-by: Paul Moore <paul@paul-moore.com>
>
> > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > index 49fb74196d02..cffbe57a8e08 100644
> > --- a/drivers/android/binder.c
> > +++ b/drivers/android/binder.c
> > @@ -2710,7 +2710,7 @@ static void binder_transaction(struct binder_proc *proc,
> >                 t->from = thread;
> >         else
> >                 t->from = NULL;
> > -       t->sender_euid = proc->cred->euid;
> > +       t->sender_euid = task_euid(proc->tsk);
> >         t->to_proc = target_proc;
> >         t->to_thread = target_thread;
> >         t->code = tr->code;
> > --
> > 2.34.0.rc1.387.gb447b232ab-goog
>
> --
> paul moore
> www.paul-moore.com
