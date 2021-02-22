Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713EE321187
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 08:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhBVHqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 02:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhBVHqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 02:46:08 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC2BC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 23:45:28 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id b3so1128124qtj.10
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 23:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5i8Tn1SlVaWO4Nif6cMWUKjsN8bsR6wBD1bT+KmM76w=;
        b=DuMSarBrnx4B6AqWFhGoDdpcXJDyC3kVP+sWmN+7pTZPoRcEVLcFm7fGPFUAk/UC2d
         MzfIdD4DWvD81phjIs1yir/GWAliE/qd1fVNVMbKCgak+d8dGJ3c4dN0h98rVIFl3GG1
         1SqYBQ6TQ8bfy7C+enpkUCEhfUZI1TenhQOhuq7R2k23uaHDQS+tRyKyZ3sNH4lBK1DS
         Z27+PpqNytAVgxD7N1MWzamCyZPIRTJlLQDo/bdwQU5o7jKf8+ifeXe2VH4IPEcfDuXZ
         7mw9Oz9TKrBuk+IPwFPDJK1TQxDIea8GJhQf5hyPNTgz84C/YoY3aV/IXWDDOVPEunbm
         yT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5i8Tn1SlVaWO4Nif6cMWUKjsN8bsR6wBD1bT+KmM76w=;
        b=Pfs1NqIQ7uLB9vHIqL3G+RYCfxvWw/Dxu0aJ20+pTOfqQ36+1Dv6XpGYOhn32xGqdP
         iorT1tYFMCD3KuD80PJKLVTiTxhqC6cOIvjKyysG0uHGSAd6ZkHtKPVOBYYkJzeuI4nD
         6M0yMNQ0hWqYiXgZEPyJ64GPt0k9U3TyePpmGXbwqoO8/fyYYNf++q3A8lMaP6bQ5Zf4
         /GcRhZsAlLIDQgclh6goQddUy/zxTisKyMU8wGAzl46CAe+K02y6TYj3wUbmn31KTOaK
         x5vReqbAn6v6KuZXhRVKQWbEZxoNfN45fJZY/uKdIW4RyYD0S8ByEaz9+xFOwbUZLMMq
         arUA==
X-Gm-Message-State: AOAM531/p+oj+msQdhF7Hu/mns8n2rzh+DiwT3Qu2OJGnXvt9EC7bRON
        411HCMXNiPA1DbSAlc0tsGHlAzYd8uwMbITK8K02OQ==
X-Google-Smtp-Source: ABdhPJwO4Ki99L1sEVcKwWhaw/oUf4d+mZNVNa5xcQGmaM6uFuYo31RnwPH8F/uwUGT1xa4+hc3Nh3Ik+sgMP9MwPa0=
X-Received: by 2002:ac8:6752:: with SMTP id n18mr4841157qtp.8.1613979927541;
 Sun, 21 Feb 2021 23:45:27 -0800 (PST)
MIME-Version: 1.0
References: <1613970647-23272-1-git-send-email-daizhiyuan@phytium.com.cn>
In-Reply-To: <1613970647-23272-1-git-send-email-daizhiyuan@phytium.com.cn>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 22 Feb 2021 08:45:16 +0100
Message-ID: <CAG_fn=WqixC0B+dW50gRFn3Qm63rQ5x6jP+2eGVAkRcuBOwQ6A@mail.gmail.com>
Subject: Re: [PATCH] mm/kasan: switch from strlcpy to strscpy
To:     Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 6:10 AM Zhiyuan Dai <daizhiyuan@phytium.com.cn> wro=
te:
>
> strlcpy is marked as deprecated in Documentation/process/deprecated.rst,
> and there is no functional difference when the caller expects truncation
> (when not checking the return value). strscpy is relatively better as it
> also avoids scanning the whole source string.

Looks like a good thing to do.

> Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Acked-by: Alexander Potapenko <glider@google.com>

> ---
>  mm/kasan/report_generic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
> index 8a9c889..fc7f7ad 100644
> --- a/mm/kasan/report_generic.c
> +++ b/mm/kasan/report_generic.c
> @@ -148,7 +148,7 @@ static bool __must_check tokenize_frame_descr(const c=
har **frame_descr,
>                 }
>
>                 /* Copy token (+ 1 byte for '\0'). */
> -               strlcpy(token, *frame_descr, tok_len + 1);
> +               strscpy(token, *frame_descr, tok_len + 1);
>         }
>
>         /* Advance frame_descr past separator. */
> --
> 1.8.3.1
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
