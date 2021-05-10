Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38576377CE7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 09:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhEJHHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 03:07:40 -0400
Received: from mail-vs1-f45.google.com ([209.85.217.45]:34426 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbhEJHHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 03:07:37 -0400
Received: by mail-vs1-f45.google.com with SMTP id l4so1053194vsa.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 00:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w4b5xZBUbFwH3cFjEhdPC36TlJkVTjnlDMkhS61w7hA=;
        b=igUgktZTE5m7Elvp2/RZ1BIbUc0CdzG1Awyjff+Gm17hCrHqunftbtupA743xb4tQZ
         M+Cueq8shQM9cUGIguoTVgpsjM8/JbMuPph1LJKsBjPoisXyvK/IcxsL56+aACp9vkqJ
         CVBQm0uDnbIhW16bIlN6nysSMy8wZNgEWs0aMAu0PgndWCQ087mzfQHPlCY7DwA9QB1e
         RUwzqvApRNczFY1Hrs4GhhaZgIuRKrJd3keaSqyHmlAuWZvQi2nIsmuszR4dyf9l+BQL
         gFrOCs4uRvjrZYd94zAcT6+XUhBu6Gad3lSPI0jQ8hn8e/ox3BtIGS0cvJuVIPBnr1zl
         TeIw==
X-Gm-Message-State: AOAM531vOFq/GACoE0a6dVuDwN+TLyvM+EhZYB7qU4Y+dtKJYdvrPJhw
        0K8HKzC9H+93I6Ay3Q97h+zAc6YM63zwwgP7LtH94Hfy
X-Google-Smtp-Source: ABdhPJxtyIX8XLzN+P+pUoZEK0JN7upG+8+1PT+Mkb/GwnjUoZoy4T+TBC+i1jtUiImMOYiRBJVbX4wBT4fvTMVEins=
X-Received: by 2002:a67:bc6:: with SMTP id 189mr10633385vsl.3.1620630391862;
 Mon, 10 May 2021 00:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210510030836.11834-1-wanjiabing@vivo.com>
In-Reply-To: <20210510030836.11834-1-wanjiabing@vivo.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 May 2021 09:06:20 +0200
Message-ID: <CAMuHMdUB-fqw=h+VGvbT1NKzWWAw6e_A_j7sv2Jnciikh7FNGw@mail.gmail.com>
Subject: Re: [PATCH] m68k: dma: remove unnecessary include of asm/cacheflush.h
To:     wanjiabing@vivo.com
Cc:     Pekka Enberg <penberg@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kael_w@yeah.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 5:08 AM Wan Jiabing <wanjiabing@vivo.com> wrote:
> In commit ca15ca406f660 ("mm: remove unneeded includes of
> <asm/pgalloc.h>"), asm/cacheflush.h independent on the MACRO
> was included at line 18. The include here is unnecessary. Remove it.
>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.14 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
