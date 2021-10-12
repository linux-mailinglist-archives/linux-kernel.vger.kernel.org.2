Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA3942A6F9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 16:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbhJLORv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 10:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236943AbhJLORt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 10:17:49 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8DFC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 07:15:48 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z20so58685edc.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 07:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aoPtWn8baP6eRSr17d2f6zS5KeNXDmBfvhv/KvnkI98=;
        b=Q0GzZf8y3jQsalaCpkjO7Xc7tEeuj8YoaCdes5NuFUfZGzqwd61sYH2/NOkKwkD7q1
         WwK0oYsirPr1AmSrrRP6JbqEcT5PGqrznuXuc5/iQVnDFa0Lov/MyXavaY/WWsCIGqNg
         egtpFEbRfmlZKGX04zW70zw4q7QRz5iOQ1boWpvu+xOPrWOOuz8IzGo4norCr+j9lDe6
         JhVW4Vnr4R7GeV8dwaJouoKGuPjQGDc6x3vb9UhzageDyYX2rVei+75o+TBRrw3to7Xh
         XEDZorVzkxB2Ui/YtqiM4Bgtf+p7nk5DYd1pQbrV4AzkcM2NsoiqcLMeh2kh5F6HkxF1
         jzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aoPtWn8baP6eRSr17d2f6zS5KeNXDmBfvhv/KvnkI98=;
        b=YzozdIQ49izEuT5i9b3G3Eopwtx1UP18/eC61A1MbLfaF76Vb3qTYQWOKcQrMYEAv4
         3MYuUoVkx5F12XffsOvC5mXpjS2aqDa0XDE+EX+rSmW5/2k43KZ2CTrXcCB4tLk3tYng
         EZ055mHuqUMt0CpO++rz6G5N2aTVNxM6HMLUTPg1MmF8wmQLRdhZQjlWlvv3ffavfaqZ
         J3vxiFnLKSDNmBUF7++gQxoCqghMqwz3NABJMZ4dCbxI5wjNLNuADXGONotz6NcpX7OV
         kNS7gAHfsqCwkl6e281U1RBv1EOyJujxiOwRulfMzI0pVEgl1YDOurYpu0qHGZWlLjjW
         WJKA==
X-Gm-Message-State: AOAM5338Pl3ux7wnRCC6Y07JYKMqzDdeXqi6tQYYiby/+NMvAQPjbxCI
        pgGcoJ2nDHq7DNu+oc/hkYFOZTFJf8scHPLWvzX2
X-Google-Smtp-Source: ABdhPJzAhF3kFHRyB9RJcZzE5mPMvbI7D9RRlGMRlB0qZKuSNHL2WEUygRk4E8noeQ40AfRTVa2UlSHslAqAuo457lk=
X-Received: by 2002:a05:6402:2552:: with SMTP id l18mr172650edb.370.1634048146288;
 Tue, 12 Oct 2021 07:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211009063053.187953-1-cuigaosheng1@huawei.com>
In-Reply-To: <20211009063053.187953-1-cuigaosheng1@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 Oct 2021 10:15:34 -0400
Message-ID: <CAHC9VhRopU95Vxroaa4JxWkt=gK7KgJjvK+t9kmkQZTor63p_g@mail.gmail.com>
Subject: Re: [PATCH -next] integrity: return early if audit_log_start return NULL
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     James Morris <jmorris@namei.org>, Serge Hallyn <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiujianfeng@huawei.com,
        wangweiyang2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 9, 2021 at 2:28 AM Gaosheng Cui <cuigaosheng1@huawei.com> wrote:
>
> audit_log_start() may return NULL in below cases:
>   - when audit is not initialized.
>   - when audit backlog limit exceeds.
>
> After the call to audit_log_start() is made and then possible NULL audit
> buffer argument is passed to audit_log_*() functions, audit_log_*()
> functions return immediately in case of a NULL audit buffer argument.
>
> It is not necessary for audit_log_*() functions to be called with
> NULL audit buffer argument, so return early when audit_log_start()
> returns NULL.
>
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  security/integrity/integrity_audit.c | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
> index 29220056207f..fbc032185d72 100644
> --- a/security/integrity/integrity_audit.c
> +++ b/security/integrity/integrity_audit.c
> @@ -45,6 +45,8 @@ void integrity_audit_message(int audit_msgno, struct inode *inode,
>                 return;
>
>         ab = audit_log_start(audit_context(), GFP_KERNEL, audit_msgno);
> +       if (unlikely(!ab))
> +               return;
>         audit_log_format(ab, "pid=%d uid=%u auid=%u ses=%u",
>                          task_pid_nr(current),
>                          from_kuid(&init_user_ns, current_uid()),
> --
> 2.30.0

-- 
paul moore
www.paul-moore.com
