Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91BBD42CCA1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 23:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhJMVRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 17:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhJMVRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 17:17:44 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FFEC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 14:15:40 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g10so15772620edj.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 14:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TQq8IvaJAjyAgsNLQVRIoKAyd4/0gIAn1tmOmUFhanE=;
        b=1hoJxRLx9CDwzaLFfCWC7qHVwLpaH4AhgcdqNtaKnTTcrWAsBdZ3ELmYrWgA+wb/Ft
         3oaCEbsC6CRwJb4BOqczID4uVshEP0yXHgqxfh4UsvC83MkI22tV3uFVMkoydL47DGYZ
         wDmuQVJgE/hE8ZVNTYuqiBWOacunyac2Rm+QxGW2Cdcv481ovyMcfYfrRKr4AfLM2nqL
         6Qlf7kUMYec66C8QY8sOmbwNocgnaUxEscSueh5QUwmc0l6EZYa9mDqeU9hsCRMk5Wjg
         ILGcgVMuZW3WowmeyjcGC6o8+34tyCxqUr1o2nFHdeTHb4TnPyGmZeNSmratnocLlvNp
         qZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TQq8IvaJAjyAgsNLQVRIoKAyd4/0gIAn1tmOmUFhanE=;
        b=AJX+5XDrf6fnXAP9/JWK4N5CK1X4aXnE3WNwPstA5uWcztyh8KUONQzYJRxRCGsEw9
         hWNSDZOgJtQK6ooQCUaSDL+5inhOlBvKtnRe7eaiL/wqGickkeQ3WeDG5PuEzV56Z5Sw
         UsGQseAgwvxRoYABXEbhEkA0toG5XHZLgBbNoi7gUer5Rai85+1tf12BJZ3m8P4RaSqs
         UacB1+JbzQyxsukV0fqtLrL0CRiKRS+s//kMvf+xhMJLQ1L2owwgq7wYpyuRwfCZy7f4
         qWhWISo+1GgQgoeGvnxJyTHapyeGJ6N7Kpl4uLftneNdZfcWXpnjfmp0v6eML3/T2aZS
         Zw3g==
X-Gm-Message-State: AOAM531Ajj+hpIWcM+Np1kwZvBCoZ+owBmH5QCJEWvSik0r76tV8xyad
        h5Tp3lE4hd4cHBTKD7nV+ejrYBZLMPYnSAjHNE4m
X-Google-Smtp-Source: ABdhPJzKrEknnA5r7cZyO5mtn9/niWqr5UyZx2uYLQKgqXHcUiyW63KeZe8TQp1bIfb7b4dFe6xUsZLnSjMCzfAOGtw=
X-Received: by 2002:a50:e1cd:: with SMTP id m13mr2653217edl.93.1634159739020;
 Wed, 13 Oct 2021 14:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <20211013091208.36209-1-cuigaosheng1@huawei.com> <20211013091208.36209-3-cuigaosheng1@huawei.com>
In-Reply-To: <20211013091208.36209-3-cuigaosheng1@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 13 Oct 2021 17:15:28 -0400
Message-ID: <CAHC9VhQTD86Y9ryGNkVKsChJ573GAka_gBuTgXR8q5OpV-zMbw@mail.gmail.com>
Subject: Re: [PATCH -next,v2 2/2] audit: return early if the rule has a lower priority
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, xiujianfeng@huawei.com,
        wangweiyang2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 5:10 AM Gaosheng Cui <cuigaosheng1@huawei.com> wrote:
>
> It is not necessary for audit_filter_rules() functions to check
> audit fileds of the rule with a lower priority, and if we did,
> there might be some unintended effects, such as the ctx->ppid
> may be changed unexpectedly, so return early if the rule has
> a lower priority.
>
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  kernel/auditsc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Thanks for this patch, it looks reasonable to me but have you done any
testing with this patch?  If so, what have you done?

As a FYI, the audit-testsuite project lives here:
* https://github.com/linux-audit/audit-testsuite

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 42d4a4320526..b517947bfa48 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -470,6 +470,9 @@ static int audit_filter_rules(struct task_struct *tsk,
>         u32 sid;
>         unsigned int sessionid;
>
> +       if (ctx && rule->prio <= ctx->prio)
> +               return 0;
> +
>         cred = rcu_dereference_check(tsk->cred, tsk == current || task_creation);
>
>         for (i = 0; i < rule->field_count; i++) {
> @@ -737,8 +740,6 @@ static int audit_filter_rules(struct task_struct *tsk,
>         }
>
>         if (ctx) {
> -               if (rule->prio <= ctx->prio)
> -                       return 0;
>                 if (rule->filterkey) {
>                         kfree(ctx->filterkey);
>                         ctx->filterkey = kstrdup(rule->filterkey, GFP_ATOMIC);
> --
> 2.30.0

-- 
paul moore
www.paul-moore.com
