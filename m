Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1593339D21
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 09:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhCMI6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 03:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhCMI5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 03:57:52 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F584C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 00:57:52 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id p8so57849630ejb.10
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 00:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NfopcM7e7FULIgFg/DNsdzygJHayYXk44PBuqsZGESI=;
        b=BpYngydZZEENcL2xCAnFTsKhxbD50LBfPWrIDDxWPaXNjZbqsD+ThOvJuisFiQMcKW
         UwOvr4yMiOF2mB77tWifmvCrRmVsglSPlpzcuRnqE/JxP5l5cyh5mjzSc68TkANeb786
         zVtYcA5YhqFVf/gqZ49wGy853jfNe8YjIKDwQhwDJGkg/MEvxEQwXt+MTCrvIAg7kYzh
         8StXv5+XcDvpZWidhgEEDB8KQGHPD7Eqhsh7e/vBXwlmNfu4aXqHVfy8QGUMpnqH//ZA
         AUeJrHEFPxVUHZ3A2cgrnA72zYzzDMK7oobRwsMpFEw7DpP00sR/9KcZYDo0snkGvoh5
         r8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NfopcM7e7FULIgFg/DNsdzygJHayYXk44PBuqsZGESI=;
        b=Zw/VStYmwiZTPDkFAXkQzZg6401+W7oz6k12+gcys4ZDxbAsQnINY88Y7DEoOmhMdi
         bPCLqrKSAtoZWZx892SaNG+9ptbyciJfHjdHDM1C6loooO9C81kuzZj3jcROn9moKquJ
         Kv6yZt0+z2qvF55FnlaU5dwaZdDKeplDbfFlwjVRy/+rvUhqSmMiUcQPi7UEqzN/IzM/
         HVPGSi3leNmN34B4B21V/E5WWUBgRURY/1KAwcxh/BMq9kDujBPoMWI8EHm/SL04eVOk
         UyVKf49WUqCRI1SthAN7XsqQiBu80FLM2hUqowxTlWYBDg80zg+XEucmCV2b1AIlgCnI
         8XOA==
X-Gm-Message-State: AOAM530360df9+mlf/nr1WewKsB2DbsGVb0spYgI3al6OJQtzOd+/pjw
        +lprTOamtMD2zojHmR1umF3uq3BqKNQhWmJ4LnPWxmk5
X-Google-Smtp-Source: ABdhPJwfVyA6oCv7ap/msM94zVIf10yLesmM8yd0mQHmMbfW8vkdxgCCs0aNFmip6W07OLiBa0mZmdCjZl3jdg9WLUE=
X-Received: by 2002:a17:906:30da:: with SMTP id b26mr12941090ejb.376.1615625870579;
 Sat, 13 Mar 2021 00:57:50 -0800 (PST)
MIME-Version: 1.0
References: <20210312151411.101942-1-masahiroy@kernel.org>
In-Reply-To: <20210312151411.101942-1-masahiroy@kernel.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Sat, 13 Mar 2021 00:57:39 -0800
Message-ID: <CAMo8BfL3Zx2_uYD6yJQgju90JJj5=occjsDtcXZY0E2jmqUhow@mail.gmail.com>
Subject: Re: [PATCH] xtensa: move CONFIG_CPU_*_ENDIAN defines to Kconfig
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 7:14 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Move the definition of CONFIG_CPU_*_ENDIAN to Kconfig, the best place
> for CONFIG options.
>
> I slightly simplified the test code. You can use the -P option to suppress
> linemarker generation. The grep command is unneeded.
>
>   $ echo __XTENSA_EB__ | xtensa-linux-gcc -E -
>   # 1 "<stdin>"
>   # 1 "<built-in>"
>   # 1 "<command-line>"
>   # 1 "<stdin>"
>   1
>
>   $ echo __XTENSA_EB__ | xtensa-linux-gcc -E -P -
>   1
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

> If I understood correctly, xtensa compilers can support either
> big-endian or little-endian. We cannot change it via a command option.
> Actually, it does not understand -mbig-endian or -mlittle-endian.
> (Is this correct?)

This is correct. The idea is that specific xtensa core has fixed endianness,
but it can be either little or big. The toolchain is configured for the specific
xtensa core at build time, so there's no need for a runtime endian switch.

>   $ xtensa-linux-gcc   -mbig-endian  /dev/null  -c -o /dev/null
>   xtensa-linux-gcc: error: unrecognized command-line option '-mbig-endian'
>
> I see -mbig-endian / -mlittle-endian in old GCC manual.
>   https://gcc.gnu.org/onlinedocs/gcc-3.3.5/gcc/Xtensa-Options.html
> But, I cannot see them in recent gcc manuals.
> So, I have no idea better than checking __XTENSA_EB__ or __XTENSA_EL__.
> I just moved the logic to Kconfig from Makefile.
>
>
>  arch/xtensa/Kconfig  | 6 ++++++
>  arch/xtensa/Makefile | 9 +--------
>  2 files changed, 7 insertions(+), 8 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Please let me know if I should take it into the xtensa tree or you will
carry it in the kbuild tree.

-- 
Thanks.
-- Max
