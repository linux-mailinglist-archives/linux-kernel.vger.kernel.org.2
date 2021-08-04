Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749D03E0162
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 14:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236842AbhHDMqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 08:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238177AbhHDMor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 08:44:47 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FEDC0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 05:44:34 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id p21so3299493edi.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 05:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zWvy8sh/+lRbS7C72TP9P5YTqZkTi8RR/qpbQTwlVag=;
        b=L8CPcLBLfXrFwcb4XrQhaX62u6eGIqzHpEeaRRcOLVMygMXRcZkS2VhopsFWbJpRJU
         RNLuTOEJoz9lgbbucOd7iaoLZtgLZ/f3Sd0A/afoxBpoZv6gVjlUyyIRdfPDfFUttTVz
         HORx9g6juclSgD8FhRl9ECPwVnIn6rfCJFxNFZrorO2J2BPah8rMIjmw/nIF0LfTowW9
         eL7YgG8ldd6Pm90HH7Av8A5hntUIpf0QOmQZe/apiHcmzxvuozEfHHzy+SRdQeBlE2jp
         y/jWYs0K5WrByOzc49GinBCXyILrf5OX6bUtFMc+juwS5mJhFuWPPlK65fvKo6cTYHn2
         9yfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zWvy8sh/+lRbS7C72TP9P5YTqZkTi8RR/qpbQTwlVag=;
        b=qDoZSyNFB/w1Y2H2hqyCS4Zaq/OQoYNnNPCKrM88unn8LVcLaJ0R5UkZMsfnz7/fBc
         DGXi5KLrz9u+P8vxrfgm+uvm+Y6ulxIiCxWavNPXVLzK250G0p6plenZ3GZADte7S8/W
         ObS2rcd6wi67hbvw13VUU6PLAhR9TVuQw07Nc52PB6zz+M+Jkl0+lcoXzItY+hzeEHkv
         TTwKYzVpf/oMM0l5s+Fn0hDV5WC+eXCdIHzkQ0l85C3bqv5ASTjhwsajjzN79jDUwMOY
         +O8uUWc46N/iIbF5p6XWSgnrDbYAs1S+CjsXuOe2K9/eMMkcZf7SlI96Xs/AQpfmhLJQ
         phFw==
X-Gm-Message-State: AOAM530eUkuu9ewBT2MHGcvUG0KWmGQWf719r9tRZ8DLlsRs4lcyJHYX
        PcrZDtiK582HfvDCoA6DkaOekTuKMCh5eUs3vWw=
X-Google-Smtp-Source: ABdhPJyqZwWb8jhlSwZs+oxLbWbZf8TnreNbEQ/FtBwKpWytABRTwqEkItzzs798ZiC4vXeEOos3WPMLkVOZ68tFzL4=
X-Received: by 2002:a05:6402:430b:: with SMTP id m11mr32140537edc.55.1628081073404;
 Wed, 04 Aug 2021 05:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210804090957.12393-1-Kuan-Ying.Lee@mediatek.com> <20210804090957.12393-3-Kuan-Ying.Lee@mediatek.com>
In-Reply-To: <20210804090957.12393-3-Kuan-Ying.Lee@mediatek.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 4 Aug 2021 14:44:22 +0200
Message-ID: <CA+fCnZd6d9yFZZBM-zPOC54ZiHGnCxV-XiYrCfbCTzzhRV8H1w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] kasan, slub: reset tag when printing address
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Nicholas Tang <nicholas.tang@mediatek.com>,
        Andrew Yang <andrew.yang@mediatek.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 4, 2021 at 11:10 AM Kuan-Ying Lee
<Kuan-Ying.Lee@mediatek.com> wrote:
>
> The address still includes the tags when it is printed.
> With hardware tag-based kasan enabled, we will get a
> false positive KASAN issue when we access metadata.
>
> Reset the tag before we access the metadata.
>
> Fixes: aa1ef4d7b3f6 ("kasan, mm: reset tags when accessing metadata")
> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
> Reviewed-by: Marco Elver <elver@google.com>
> ---
>  mm/slub.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index b6c5205252eb..f77d8cd79ef7 100644
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

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks!
