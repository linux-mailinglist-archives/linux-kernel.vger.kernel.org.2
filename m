Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656AE33B095
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 12:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhCOLDS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 15 Mar 2021 07:03:18 -0400
Received: from mail-ua1-f50.google.com ([209.85.222.50]:36369 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhCOLCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 07:02:50 -0400
Received: by mail-ua1-f50.google.com with SMTP id o8so4052205uar.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 04:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=luUI1y7TeItItv6lcgdhrz6xW5IIMYrJljt0a6PyOsI=;
        b=QMGYeBfh5K5suOQHKk08KYOG7nvjNGI45JmN0dheVXqlj2JhxV2WgUE7EBn0U5yYnM
         VFgFCFnghT9/T48VYiZ6ZNrVkNppp9gS8eUTuIZxBs7TcaUv0MJvkqR8LbXO3iMHMxqG
         MUywhEG5W+s55fGT7BomX8TSvQ6+6u36rIuR/U0EN95EDpEwCkYM48KZw0PRldHh2ltq
         UIzV5CRDN27TD95GzcyRu4t6Riy6wc9inPceJ6rfHz+tCDp/Da6nyi1l3tf0/z7t/8P4
         ANXlv1wUsFxgxOeDPedB++TikczYqGoFohWpW8E5L9Z3udnrCISfjagMlmYIYEFpSmeP
         lwOw==
X-Gm-Message-State: AOAM531l6TNf6KlnjcbVR3fSmio02yNN7UwNR6nam89NNHeGuAmfzx6w
        9Z6K1Efa5XKSamyhhNBVUiAhnfM3aneSL7lKDvVJiM5p
X-Google-Smtp-Source: ABdhPJwPc7mvd0FdJocPWpgaceI9gdWFckR56CTV+7TuC43r6wmKuXqJ5ZeaHIO9vTmiuBEaxjh+uUOW0JKpCIRDJ6w=
X-Received: by 2002:ab0:20b3:: with SMTP id y19mr4290646ual.2.1615806168140;
 Mon, 15 Mar 2021 04:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210315104409.1598822-1-geert@linux-m68k.org>
 <CAMuHMdVJFprsj9njwv13jWTBELuq8RcXOmR7AoR9dqDdydLcNQ@mail.gmail.com> <2c123f94-ceae-80c0-90e2-21909795eb76@csgroup.eu>
In-Reply-To: <2c123f94-ceae-80c0-90e2-21909795eb76@csgroup.eu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 15 Mar 2021 12:02:37 +0100
Message-ID: <CAMuHMdUMjN9TW-ggAgOtj3V36kzNCfoG5o-Bcj=Lk9diJciS=g@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.12-rc3
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Mon, Mar 15, 2021 at 11:55 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Le 15/03/2021 à 11:49, Geert Uytterhoeven a écrit :
> > On Mon, Mar 15, 2021 at 11:46 AM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> >> JFYI, when comparing v5.12-rc3[1] to v5.12-rc2[3], the summaries are:
> >>    - build errors: +2/-2
> >
> >> 2 error regressions:
> >>    + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_248' declared with attribute error: BUILD_BUG failed:  => 320:38
> >>    + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_249' declared with attribute error: BUILD_BUG failed:  => 320:38
> >
> > powerpc-gcc4.9/ppc64_book3e_allmodconfig
> >
> > So we traded implicit declaration errors:
> >
> >    - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:
> > error: implicit declaration of function 'disable_kernel_vsx'
> > [-Werror=implicit-function-declaration]: 674:2 =>
> >    - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:
> > error: implicit declaration of function 'enable_kernel_vsx'
> > [-Werror=implicit-function-declaration]: 638:2 =>
> >
> > for compile-time assertions.
> >
>
> You are missing https://github.com/linuxppc/linux/commit/eed5fae00593ab9d261a0c1ffc1bdb786a87a55a

Which is not part of v5.12-rc3.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
