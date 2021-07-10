Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0653C3650
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 21:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhGJTTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 15:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhGJTTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 15:19:13 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2916AC0613DD
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 12:16:26 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id i20so23599979ejw.4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 12:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8nodBAC64Gyqtfmql1e40Caz7cCmdDoy7IjMy2zV/mU=;
        b=Z4f7VBkIzlcYRr+YbTfERtR4Ux7GGD5MiCn0XFXoW7diN7D/aHyKvr/p+pwo2s/scl
         aoGkW5rmoQ0KH0jQQX4yz8BjO8S+8+wKHOAkKK3nk1F4DBsywU+Yn3XNfY3v0LLTMWaX
         sZ4vB+5hf4gF2eagmxi30VdRNw7DeYu+xZdbCxevJSaw5rkDDTz7cm47/XGM6a1cKqgk
         8jXnnaoZQBQsiIq/2ceNQYpYMBsi1IbzbhgLHz7XlGfO+kG0zkzxXqnnESroopMzvLMW
         8Vluw30Hv8Ic9qVujq7PEnlbXKvRTrKwMZT+l4xV4pzowcv2gR3QEleNjPZN2eM+oYlS
         8WZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8nodBAC64Gyqtfmql1e40Caz7cCmdDoy7IjMy2zV/mU=;
        b=fPQQequPO/TUVRHqH/XJhIyUmM7IgBw60qCF02Ql6MruxuLC6xCOaOGZKCeP0d5b6G
         6L2/T8qOlFJgDldYFE/KTCidFNcsdpWeAkj/ZIFtamLBLmKFqdCHjtEOCuXsGvSbDKCG
         W71lrIK57NH5OHCd6R9FU0oie8IOOAtao9jGtytd/Iy2rWgRwVlzzTPxyZevdzMaN1iF
         Kcc4NPRfLVQ0T3MNFXO3iA4dsH0sw7wX+yfzBxkjnP5s8PtTjsL+dcdGM+efeWIFUU5H
         Jr58HtacoymJn09Uvpa8OiiH28DHNqIIvCyl3+yW+EZXqH9tK0KnIhEsTEU2vx2bcV6U
         uhUQ==
X-Gm-Message-State: AOAM531DAgdDMNWobqcI9NgPl9UYt7qpPgZ9YZfWwiNBBZiCQlftbBju
        wnnP4CMk/ucTEW2x8qh5xPiIIqDP9oVdAW8MbR8=
X-Google-Smtp-Source: ABdhPJyQ8SvVwGswC37G1weWxDpS+Y3lxCitTlDDr2BEWZh6aU0jb1VwqRHJnz+tx5PgFC4PUuALzXeW0z7fQIVTLWs=
X-Received: by 2002:a17:906:660f:: with SMTP id b15mr45125075ejp.443.1625944584624;
 Sat, 10 Jul 2021 12:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210708144411.25467-1-mark.rutland@arm.com>
In-Reply-To: <20210708144411.25467-1-mark.rutland@arm.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sat, 10 Jul 2021 21:16:14 +0200
Message-ID: <CA+fCnZdHADek_3bFcLdkk7=XiRL25F0n6VaGGOrw-uUpDLxYYw@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix build for CONFIG_KASAN_HW_TAGS
To:     Mark Rutland <mark.rutland@arm.com>, Sam Tebbs <sam.tebbs@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Will Deacon <will@kernel.org>, Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 8, 2021 at 4:44 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> When CONFIG_KASAN_HW_TAGS is selected, <linux/kasan.h> uses _RET_IP_,
> but doesn't explicitly include <linux/kernel.h> where this is defined.
>
> We used to get this via a transitive include, but since commit:
>
>   f39650de687e3576 ("kernel.h: split out panic and oops helpers")
>
> ... this is no longer the case, and so we get a build failure:
>
> |   CC      arch/arm64/mm/kasan_init.o
> | In file included from arch/arm64/mm/kasan_init.c:10:
> | ./include/linux/kasan.h: In function 'kasan_slab_free':
> | ./include/linux/kasan.h:211:39: error: '_RET_IP_' undeclared (first use in this function)
> |   211 |   return __kasan_slab_free(s, object, _RET_IP_, init);
> |       |                                       ^~~~~~~~
> | ./include/linux/kasan.h:211:39: note: each undeclared identifier is reported only once for each function it appears in
> | ./include/linux/kasan.h: In function 'kasan_kfree_large':
> | ./include/linux/kasan.h:219:28: error: '_RET_IP_' undeclared (first use in this function)
> |   219 |   __kasan_kfree_large(ptr, _RET_IP_);
> |       |                            ^~~~~~~~
> | ./include/linux/kasan.h: In function 'kasan_slab_free_mempool':
> | ./include/linux/kasan.h:226:34: error: '_RET_IP_' undeclared (first use in this function)
> |   226 |   __kasan_slab_free_mempool(ptr, _RET_IP_);
> |       |                                  ^~~~~~~~
> | ./include/linux/kasan.h: In function 'kasan_check_byte':
> | ./include/linux/kasan.h:277:35: error: '_RET_IP_' undeclared (first use in this function)
> |   277 |   return __kasan_check_byte(addr, _RET_IP_);
> |       |                                   ^~~~~~~~
>
> Fix this by including <linux/kernel.h> explicitly.

Hi Mark,

Marco already sent a fix for this. It should be in the mm tree.
(Although the link to it in the Andrew's notification email doesn't
work. But they rarely do :)

> As a heads-up, there are some unrelated runtime issues with
> CONFIG_KASAN_HW_TAGS and the recent arm64 string routines rework, which
> I'm looking into now. If you boot-test with this applied, you should
> expect to see those.

+Sam, +Robin

Looks like the new strlen routine is making accesses past the allocated buffer.

The guilty commit is 325a1de81287 ("arm64: Import updated version of
Cortex Strings' strlen").

Thanks!
