Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8290338E6A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 14:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhCLNMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 08:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbhCLNLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 08:11:47 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8F2C061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 05:11:47 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id s7so24119000qkg.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 05:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iwzo0YXF8Wjs0+r/brLS8Xn8OgIC+M4fxdQ/Xk6iPEU=;
        b=FZsvLdjzemdcwcZPfArdW10+rJ5e2aOF12GMadhw8QFJs1uJkhnz9FLeShIwtbAHwM
         AAMN6ucUProggtC+ogS6rVyM7cQNMqxUArMneZht5XG8z5HqCJPPuKcl8yWNFQinMfJw
         ndk67LbolPFr0XZ7MDEuEWTHZ18qjkuDWTFGh9RzhjmRzqvOQ2vTK2qGp+Jq0O7ix88t
         z4d4YFo5VkczT1qsvTwfw53N8cSef1EYiK8W3IxU5ImKVGYT30NBIyqkaoqj4AiVLwBK
         ZtOGIg5Qcc889XwFDiVXq7IYPBtgaDRTftlJMg9YuzmwdpQxWh53RSlVm4QOdh0K7RMq
         OD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iwzo0YXF8Wjs0+r/brLS8Xn8OgIC+M4fxdQ/Xk6iPEU=;
        b=dwlKTZPJZs8yZfU/P4zth7kQX6c5oxhVJHAbFlOCg4ITrDZzQWsBJejVGa0kp1CpRM
         xiUoBJNfAzJ2Pt9t0AozOxqUQ8dJbIhMTjTx5QtjlaKQTW+c2oLETJwHPkVV6MkP02Y+
         ZFIh9fayaA0LHnlHUiupn6cpQzc2Pyu/3GrpWBvDdd7x1tiM8dZvjPpaLu/N1UJYuF3T
         z/4Nd+7XzGGfRbPgVMGQMxfM/5qkvM+SdlMhgAfN/dFf7gacoCc37XTzuKZV6i3Lcsis
         aYsLgTORT8R2uwnKzJ3e2FXfwn3/UvIWqazb5tQoAdpLfKL1Rcpqiyysj1HDuyY51XVQ
         TNuw==
X-Gm-Message-State: AOAM532C6YVXlVH9d4wg1AAZd04aAbMhg/y+19gMj3ulKDleGmtXa2TE
        o3CKCc9r/s6pDTOmcZu42iB5gEzRX/ywbIS0PJjYFQ==
X-Google-Smtp-Source: ABdhPJxMgU8ym1jkJpj9aNV6ccFWydjqSmzRVp46ZJeTCQx1z6xaBIlXvRGmRrwpixVsTi1I2BPp5x++YD0sjVdf3qw=
X-Received: by 2002:a37:630a:: with SMTP id x10mr12286451qkb.326.1615554706426;
 Fri, 12 Mar 2021 05:11:46 -0800 (PST)
MIME-Version: 1.0
References: <20210312121653.348518-1-elver@google.com>
In-Reply-To: <20210312121653.348518-1-elver@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 12 Mar 2021 14:11:35 +0100
Message-ID: <CAG_fn=WdpzPxbvzqkpVXjyrUu=GprA2xMBiJdhJqM8cNhABWmw@mail.gmail.com>
Subject: Re: [PATCH mm] kfence: zero guard page after out-of-bounds access
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 1:16 PM Marco Elver <elver@google.com> wrote:
>
> After an out-of-bounds accesses, zero the guard page before
> re-protecting in kfence_guarded_free(). On one hand this helps make the
> failure mode of subsequent out-of-bounds accesses more deterministic,
> but could also prevent certain information leaks.
>
> Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Alexander Potapenko <glider@google.com>

> ---
>  mm/kfence/core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 3b8ec938470a..f7106f28443d 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -371,6 +371,7 @@ static void kfence_guarded_free(void *addr, struct kf=
ence_metadata *meta, bool z
>
>         /* Restore page protection if there was an OOB access. */
>         if (meta->unprotected_page) {
> +               memzero_explicit((void *)ALIGN_DOWN(meta->unprotected_pag=
e, PAGE_SIZE), PAGE_SIZE);
>                 kfence_protect(meta->unprotected_page);
>                 meta->unprotected_page =3D 0;
>         }
> --
> 2.31.0.rc2.261.g7f71774620-goog
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
