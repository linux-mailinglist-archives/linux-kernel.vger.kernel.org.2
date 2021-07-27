Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C75F3D7053
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 09:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbhG0HVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 03:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235867AbhG0HVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 03:21:22 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E229C061764
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 00:21:12 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id v8-20020a0568301bc8b02904d5b4e5ca3aso11729009ota.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 00:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yQhhZe+MXmpfkLnh85/Z8tkXEKIvw/AuYXzOfTRKZJE=;
        b=PZr5f2UnPFBMoWR1tobduCnk9rwIYH0AijHubObKP5CcIUo3ugfnpdz8aVEMsOP23K
         Y2TcJTFda7LwyNcdNmPEuuatoLOHYMFBp2l57/E+W7SnNQbsFDxhBY3xolhgqQLVpLK2
         tqh88JtVCKyHcU5COG4k7DTjKfZtpF9i63jgeht4qDJBACzdSN/jgRETxx6JWIM7jYFx
         TtYLW0uQjewgHIp4TmrFS2DH68l5DIfeQgkF1k8OZxujnje6oJG7+iADiYrt86fgOJg5
         Zl//iEWZqJJyRiz77b2rLlQy6pgL1QWy6/xXQK8wSCDPDlwC/RcSjV/FHf5haFD243yl
         lgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yQhhZe+MXmpfkLnh85/Z8tkXEKIvw/AuYXzOfTRKZJE=;
        b=DqcQzGvtP1F5A8+vtuP7kbFIhUfXAGTzrataazCqQxkDQE/2HPM/h5rZBZFIsgJhJQ
         CXl5QgqklFHF1XInqZweWQKRT/IXgl0N8e2VuFpfdt0QXriqhCSJe/jvtzKwTDv8GCPM
         3dyCMXgVvm+auZT4D/Yli5fHDelF6TEwPFeSH8VOQCujwDN39yWUqLqFN8AISDqa3GD3
         dA/QBIR2Rgf6ZWUdwjWlA5K3PkRCktqQRTbIfMnRW0z4Ko5dxqrUt0ypdGt4LEqXUGeZ
         2nONNMG+b6oVti6BDMCpzMZpJbTUMinQLi7VyfwRdg7fYsISp008mXYfv8tnVnlg6SP9
         2r9g==
X-Gm-Message-State: AOAM531MpC8TxvKETNEJ05pfeV6XdfUIDVh45MneWWpDiwQyy37gbdkY
        IhUtdIVTa3vU0jgjUrtj+PLWjHfgw6Kz57XN1GUPGw==
X-Google-Smtp-Source: ABdhPJz4sT4HTIASRu0q2t8NdjaqXI6ESVvlLRb0xkzVD7J1pd9jPoZvaxTYZ/B5e777xfunN9Qvkpz/1DYXmfkKJTY=
X-Received: by 2002:a05:6830:23a7:: with SMTP id m7mr14536006ots.17.1627370471381;
 Tue, 27 Jul 2021 00:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210727040021.21371-1-Kuan-Ying.Lee@mediatek.com> <20210727040021.21371-3-Kuan-Ying.Lee@mediatek.com>
In-Reply-To: <20210727040021.21371-3-Kuan-Ying.Lee@mediatek.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 27 Jul 2021 09:20:59 +0200
Message-ID: <CANpmjNNOkCspsf4=gPLLw=29vtv4qEDaErB1i1sz-p+bzLxNKg@mail.gmail.com>
Subject: Re: [PATCH 2/2] kasan, mm: reset tag for hex dump address
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Nicholas Tang <nicholas.tang@mediatek.com>,
        Andrew Yang <andrew.yang@mediatek.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2021 at 06:00, Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com> wrote:
>
> Text is a string. We need to move this kasan_reset_tag()
> to address but text.
>
> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>

This patch also makes sense (I think), thanks for sending. But it's
unclear what the problem is. The fact that when the address is printed
it still includes the tag? Or a false positive?
It'd be good to clarify in the commit message.

Here I'd also use a more descriptive patch title, something like
"kasan, slub: reset tag when printing address".

Also, I think this patch requires a:

  Fixes: aa1ef4d7b3f6 ("kasan, mm: reset tags when accessing metadata")

So that stable kernels can pick this up if appropriate.

> ---
>  mm/slub.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 6dad2b6fda6f..d20674f839ba 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -576,8 +576,8 @@ static void print_section(char *level, char *text, u8 *addr,
>                           unsigned int length)
>  {
>         metadata_access_enable();
> -       print_hex_dump(level, kasan_reset_tag(text), DUMP_PREFIX_ADDRESS,
> -                       16, 1, addr, length, 1);
> +       print_hex_dump(level, text, DUMP_PREFIX_ADDRESS,
> +                       16, 1, kasan_reset_tag((void *)addr), length, 1);
>         metadata_access_disable();
>  }
>
> --
> 2.18.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20210727040021.21371-3-Kuan-Ying.Lee%40mediatek.com.
