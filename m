Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCA743BD50
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 00:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240099AbhJZWiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 18:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhJZWis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 18:38:48 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A543C061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 15:36:24 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id c4so924774pgv.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 15:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zi+Ls5+JAndy1ZPzSuOjFuN6VdKyUSUs7sXCMvCwlGg=;
        b=LJEq0GmSDjII5qoqNXb8I5W6PisdeBh1LIyMwhPfeH8jzXHP4ZrLifdIwzNQXW8ND+
         56t95Ea/Oqnfk5EEZkWGv95L5UKMfXuEpMIbUg4d2KfjhFvvEHFYMDk4APFQZNapynog
         DhJ2UCdsyAqV8hPYK36maA4WMOe5o0Op6Zh9He6znf/VlsRMkJ+NiMj4film9/LelDPm
         XiDOAiK8cMpHJgCHZtb8Uv/+Ko0zhFnqv0fpM4uhiaCjkNvDeNL9YbnC9FFAVxCI0KYT
         ORxkP+gOODKPJ+VnagaB/IDqovDoYYUu3bs0HutZs8cfVbm9psDQk/fzFx4QVipzGMiL
         qv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zi+Ls5+JAndy1ZPzSuOjFuN6VdKyUSUs7sXCMvCwlGg=;
        b=EECZre5+ObwuM4C8wp9JwZJrxM6cq413hgAOt/CD3FIb2d+5sRn+qVvxMY4CV3EwuB
         NG9Qnr0IfwWXc5JlPnydVZ10Rk6WvFzOKO5fgW2cibhjTfIuSOqtR3czEeBQ+iF5oVTw
         bRs8CkLuOel23VNeoLJoSwz9AuBmscjQmY0If5lBo14nNL/DQxysJBWTKKbB+KG1DMkF
         ltnIZh0l3T7z6jRlXwhb7Ypv00JEsg0d3i8yyQXMxd7Ly2z4u6pF8uNJNtXJq6sG/aUv
         PUkTl7EWOcRQtju5nW5s+HxGYLqOTVZgXL5MbfKdKkiMCxFin4k0KrIGSYyzCH8Eo+OS
         2Qtw==
X-Gm-Message-State: AOAM530cFg9Q0y47EVi/z4d0EWK/8X6O29L1RoLcTf1iwkk/TJs2KauO
        +q437AHKGkjRKfEMK5nAV0KSQ99ObH1pW4IYaqpOaw==
X-Google-Smtp-Source: ABdhPJwjCAAGi9tkRXoXDwC14P/IcuyIu3pM5/sbKwp6NDekn9JY6rjbRwLYhExz4gA1yDh9lLUVLL2tGJ/b0/YF4ko=
X-Received: by 2002:a65:6215:: with SMTP id d21mr21410794pgv.62.1635287783574;
 Tue, 26 Oct 2021 15:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211026222746.403866-1-jevburton.kernel@gmail.com>
In-Reply-To: <20211026222746.403866-1-jevburton.kernel@gmail.com>
From:   Joe Burton <jevburton@google.com>
Date:   Tue, 26 Oct 2021 15:36:12 -0700
Message-ID: <CAL0ypaAyBSnuKD1ZSeWL6nofMJ343Hqdp5HTpxXOt6qsxurJ5g@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Deprecate bpf_objects_list
To:     Joe Burton <jevburton.kernel@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, trivial@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I messed up the mailing lists and will be resending this patch series
in a moment. Apologies for the noise.

Best,
Joe Burton


On Tue, Oct 26, 2021 at 3:27 PM Joe Burton <jevburton.kernel@gmail.com> wrote:
>
> From: Joe Burton <jevburton@google.com>
>
> Add a flag to `enum libbpf_strict_mode' to disable the global
> `bpf_objects_list', preventing race conditions when concurrent threads
> call bpf_object__open() or bpf_object__close().
>
> bpf_object__next() will return NULL if this option is set.
>
> Callers may achieve the same workflow by tracking bpf_objects in
> application code.
>
>   [0] Closes: https://github.com/libbpf/libbpf/issues/293
>
> Signed-off-by: Joe Burton <jevburton@google.com>
> ---
>  tools/lib/bpf/libbpf.c        | 8 +++++++-
>  tools/lib/bpf/libbpf.h        | 3 ++-
>  tools/lib/bpf/libbpf_legacy.h | 6 ++++++
>  3 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 2fbed2d4a645..59d39ce9f375 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1148,6 +1148,7 @@ static struct bpf_object *bpf_object__new(const char *path,
>                                           size_t obj_buf_sz,
>                                           const char *obj_name)
>  {
> +       bool strict = (libbpf_mode & LIBBPF_STRICT_NO_OBJECT_LIST);
>         struct bpf_object *obj;
>         char *end;
>
> @@ -1188,7 +1189,8 @@ static struct bpf_object *bpf_object__new(const char *path,
>         obj->loaded = false;
>
>         INIT_LIST_HEAD(&obj->list);
> -       list_add(&obj->list, &bpf_objects_list);
> +       if (!strict)
> +               list_add(&obj->list, &bpf_objects_list);
>         return obj;
>  }
>
> @@ -7935,6 +7937,10 @@ struct bpf_object *
>  bpf_object__next(struct bpf_object *prev)
>  {
>         struct bpf_object *next;
> +       bool strict = (libbpf_mode & LIBBPF_STRICT_NO_OBJECT_LIST);
> +
> +       if (strict)
> +               return NULL;
>
>         if (!prev)
>                 next = list_first_entry(&bpf_objects_list,
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index e1900819bfab..defabdbe7760 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -168,7 +168,8 @@ LIBBPF_API struct bpf_program *
>  bpf_object__find_program_by_name(const struct bpf_object *obj,
>                                  const char *name);
>
> -LIBBPF_API struct bpf_object *bpf_object__next(struct bpf_object *prev);
> +LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 7, "track bpf_objects in application code instead")
> +struct bpf_object *bpf_object__next(struct bpf_object *prev);
>  #define bpf_object__for_each_safe(pos, tmp)                    \
>         for ((pos) = bpf_object__next(NULL),            \
>                 (tmp) = bpf_object__next(pos);          \
> diff --git a/tools/lib/bpf/libbpf_legacy.h b/tools/lib/bpf/libbpf_legacy.h
> index 29ccafab11a8..5ba5c9beccfa 100644
> --- a/tools/lib/bpf/libbpf_legacy.h
> +++ b/tools/lib/bpf/libbpf_legacy.h
> @@ -57,6 +57,12 @@ enum libbpf_strict_mode {
>          * function name instead of section name.
>          */
>         LIBBPF_STRICT_SEC_NAME = 0x04,
> +       /*
> +        * Disable the global 'bpf_objects_list'. Maintaining this list adds
> +        * a race condition to bpf_object__open() and bpf_object__close().
> +        * Clients can maintain it on their own if it is valuable for them.
> +        */
> +       LIBBPF_STRICT_NO_OBJECT_LIST = 0x08,
>
>         __LIBBPF_STRICT_LAST,
>  };
> --
> 2.33.0.1079.g6e70778dc9-goog
>
