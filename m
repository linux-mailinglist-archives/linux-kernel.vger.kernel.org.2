Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6AA3803D3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 08:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbhENGzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 02:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhENGzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 02:55:48 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C975C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 23:54:37 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id j75so27609574oih.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 23:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=4ituoYZY0a60j/6tm4un1ieSF6zfaw1oTWT8ndCeilI=;
        b=EOL3Td469Vi7wasRj7HwPm55kgMeeKUzsfEVTPqpNC5KSXFdoCoDT0EfM6s2ABK+jB
         xUKZHmZwxmqOP4oL9Zzma5IPIBQ3CTdo2CrDgBDhP9nkJ6NQWaTK/YDfx81Ru68hqFgt
         l/L5l3PoeVFUbJM/BabLNI7IZMTRiNg600iQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=4ituoYZY0a60j/6tm4un1ieSF6zfaw1oTWT8ndCeilI=;
        b=YGvxiFCRolJEszeJjXJe+W9HEpu05YNTaWoZD+LzfcqMyBDfVWmdACNTnHCdccP1XO
         2BIhUx93+W1SHbap4IdVEMlIvmiEn7sT8Yqb+ZRQN7gJSrMyXePwKoqKJDxQNYr1IBvV
         fEXx/BFuj4BQz0j8NjvC13xEyTQ5adaH0WMR49y2cvxQDJG1x8CDsgJNVSO6AeMRcqXI
         lPw7Qd21KgpXulLN0Q1+QcielegCKZcRdXj2shtNZwrUly3Z7TJrNGGWQWEwKrxfFbsC
         Vvm6NLpdfAcj+3uSzI9RnvVj3EHNQs+eV3OHl/HmyJvDQFieumljbWoPyOEAnqbYruKN
         wkoA==
X-Gm-Message-State: AOAM532njwUeOnvsH0QbJs1UtqknzNOHqpuzAUAVmTVhhp3tCu+E3ZmD
        0FUtuIMcxg33GO/X404bqm2/APC9jJ1sgZUzhcthDX0yd/Q=
X-Google-Smtp-Source: ABdhPJx0jn5KtIDSYq04/BCF2iULXfS9W6E+Gs4BrLz3ZvMspHeXEgpQWmd5zP8guEMwHVpZNmxbX/oA3JIJWWuR//Y=
X-Received: by 2002:aca:654d:: with SMTP id j13mr5711761oiw.125.1620975276719;
 Thu, 13 May 2021 23:54:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 14 May 2021 01:54:36 -0500
MIME-Version: 1.0
In-Reply-To: <20210513171510.20328-1-rdunlap@infradead.org>
References: <20210513171510.20328-1-rdunlap@infradead.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 14 May 2021 01:54:36 -0500
Message-ID: <CAE-0n52mEv36FceSSC+DuWmXroVqubSwQKrgHNGhmawePtxkQQ@mail.gmail.com>
Subject: Re: [PATCH -next] buildid: fix build when CONFIG_MODULES is not set
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Randy Dunlap (2021-05-13 10:15:10)
> Omit the static_assert() when CONFIG_MODULES is not set/enabled.
> Fixes these build errors:
>
> ../kernel/kallsyms.c: In function =E2=80=98__sprint_symbol=E2=80=99:
> ../include/linux/kernel.h:53:43: error: dereferencing pointer to incomple=
te type =E2=80=98struct module=E2=80=99
>  #define typeof_member(T, m) typeof(((T*)0)->m)
>                                            ^
> ../include/linux/build_bug.h:78:41: error: static assertion failed: "size=
of(typeof_member(struct module, build_id)) =3D=3D 20"
>  #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>                                          ^
> ../kernel/kallsyms.c:454:4: note: in expansion of macro =E2=80=98static_a=
ssert=E2=80=99
>     static_assert(sizeof(typeof_member(struct module, build_id)) =3D=3D 2=
0);
>     ^~~~~~~~~~~~~
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Thanks. I didn't realize that there was an ifdef around the definition
of 'struct module'.
