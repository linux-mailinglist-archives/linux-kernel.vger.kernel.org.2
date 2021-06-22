Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94E13B0045
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 11:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbhFVJcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 05:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhFVJcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 05:32:03 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0FFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 02:29:48 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id x21so6385726qtq.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 02:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=58zdBT4iccY3hk8j5TcU5G4OItRSttrTmPDv2LwwaDM=;
        b=I8nT0GICPLPZ1Jhb4B9W/QQIYPbvEQrVLYwutlY2c2qEMSCirWGRIwHKuF8WAivTLK
         /LpLwAJ4FKBILv7vHY+BKVUCTgnU9VDqokmEBuXWh61+figaMbqizpO7F0P+kLjpsq9M
         24zUBztp9upMyC/n35LdB09iA/ZB+bpCEv8elrpP6Vb6Vt6P6+r+9QBwR3+5MsXGXIf/
         2WKf+aa4TfFuWtl3C/WNaxcRMjz8R1hlISaW2IbA4EzdUbpSeZZiTsTNzkStWqRZRMcJ
         Qzh0ozt8SJrDCqvmSYYrBo1NUf9TpLcMwXRCrSRBV0a2YSeRl3lALxiXCjQddkx+hDSj
         9P9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=58zdBT4iccY3hk8j5TcU5G4OItRSttrTmPDv2LwwaDM=;
        b=ZGT7Nstdz40ExllIderbfS4tBvDASVkinBr1k/yh3GFwN+yQbupHYG0BtofON8M5PX
         o18ggeQ04xcgo7JBQ/rJW7gIaAx5JB4DQT42/LW8CZTNDrJZnxhkSyBVxzcG5Xh82dYl
         zaGN3vNwEPAklHq6wmjM8KqGWbOkZN3o7POTllyd3mRWVdY5ebCrNmajREBpc1RRQ/bw
         UXsHt6c3Y54bs5fI/dVgw2efcPWTXU/xMHhmiul/YvUbMMUyuo4dBionUB6Zpy/svtNL
         dDvfnixS3OesMreq9zPQ4KSkmNvEZ1de6tLObqYSQF1BY90KQBiZpl7XkYDfPVKtwy9V
         1zEg==
X-Gm-Message-State: AOAM533AGpw2XbmdxY/S2+pqKmJaFBC6K1ALyrWAh2DuY/cw/U0Op+x7
        2N6MPfpgLD0g9n1gEKqmjLPsqH3TrfPP+E5crzXerA==
X-Google-Smtp-Source: ABdhPJyMpRmME/HlkaV4EXqY+IqFB3RLpLD0Aahei9VXIQwOIJQdCVp1+s1OII9DHkhpOgFw6W/vTi4gxUbjIB+r3KI=
X-Received: by 2002:ac8:5dcd:: with SMTP id e13mr2542822qtx.175.1624354187077;
 Tue, 22 Jun 2021 02:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210620114756.31304-1-Kuan-Ying.Lee@mediatek.com> <20210620114756.31304-4-Kuan-Ying.Lee@mediatek.com>
In-Reply-To: <20210620114756.31304-4-Kuan-Ying.Lee@mediatek.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 22 Jun 2021 11:29:11 +0200
Message-ID: <CAG_fn=U0_VzgqBtuyB4JnSMRiHg=C85e-m_4X+=QY-o_u-k9Fw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] kasan: add memory corruption identification
 support for hardware tag-based mode
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        chinwen.chang@mediatek.com, nicholas.tang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2021 at 1:48 PM Kuan-Ying Lee
<Kuan-Ying.Lee@mediatek.com> wrote:
>
> Add memory corruption identification support for hardware tag-based
> mode. We store one old free pointer tag and free backtrace.
>
> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
> Suggested-by: Marco Elver <elver@google.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Alexander Potapenko <glider@google.com>
> ---
>  lib/Kconfig.kasan | 2 +-
>  mm/kasan/kasan.h  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index 6f5d48832139..2cc25792bc2f 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -157,7 +157,7 @@ config KASAN_STACK
>
>  config KASAN_TAGS_IDENTIFY
>         bool "Enable memory corruption identification"
> -       depends on KASAN_SW_TAGS
> +       depends on KASAN_SW_TAGS || KASAN_HW_TAGS
>         help
>           This option enables best-effort identification of bug type
>           (use-after-free or out-of-bounds) at the cost of increased
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index b0fc9a1eb7e3..d6f982b8a84e 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -153,7 +153,7 @@ struct kasan_track {
>         depot_stack_handle_t stack;
>  };
>
> -#ifdef CONFIG_KASAN_TAGS_IDENTIFY
> +#if defined(CONFIG_KASAN_TAGS_IDENTIFY) && defined(CONFIG_KASAN_SW_TAGS)
>  #define KASAN_NR_FREE_STACKS 5
>  #else
>  #define KASAN_NR_FREE_STACKS 1
> --
> 2.18.0
>
> --
> You received this message because you are subscribed to the Google Groups=
 "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kasan-dev/20210620114756.31304-4-Kuan-Ying.Lee%40mediatek.com.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
