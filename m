Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06BB835269C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 08:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhDBGmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 02:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhDBGmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 02:42:45 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6D9C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 23:42:45 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id n198so2283180iod.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 23:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=yj6+vSRZLkkm8CHfCAHYPtQtKWMqvTFnQ6YMhgNKBnc=;
        b=qiWYH2oiUzVi6Ex79pPXPik+XUkqKcMptn6lKyCdQ4wWCJM0GnNPshmRPPcepCqNIV
         KJsBYAdAY9MSRQ4CTfQkneOFzz1VJsSD3/tBljlj/FhfzWQuPl30qRz9uKAtyOqMzMEx
         hHk3GOHDKTZpIqqzUEnS2McEvzxfr62M8OJq3U07xz6djly/pR9cutjbG9sPTuF2zncJ
         3eni8RIBZwp7KcrPwzIclWXS6x5U4o7uiS5ZK5oEkAwf0rWmULB86Xiz0QqB80WoGNpx
         7x3uAyU6KPrqOnIG2z96sU0c0V7KeV+3djxtfZvdibuF6bhJTmNhXT82h9ajmBGzcMH5
         dENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=yj6+vSRZLkkm8CHfCAHYPtQtKWMqvTFnQ6YMhgNKBnc=;
        b=qKxUHJYdJpySewWNcmKy6Jd9UuM9Y0yyibg4nzoROJsKhBJLvH731NJprZT7tdmkU3
         vhl1DQD30BrBZu1LMfmytt3MCHGD7k+C89opxb6tR/qH/pbcD/CueDB5gHbs8OG+lhpO
         kyd8Z03DQPzHuVYFGvvUA6vjYu7LdZ2BOAak7e6Wm6FOiGAdRv8PyDLDOU4qs/k+XpM/
         WyLK/3W9i8t+SWP6/k21HuZC+Oo2Q4TGTYmZS+KRO9XW3RKs5NXSCxdV55B47XWKRxnL
         RbPGYILMZRx89MTePwLK9EbWEsqaoUBUw30fuQRA1AYphx6sfX+7BD7LvVVTwi5cHYwi
         7IdQ==
X-Gm-Message-State: AOAM532fINM7OgWjH6bnQ+3qOgtV59emGw5p4cFifrByKTklTEAN3QRL
        fMSFDx9+ga6qIj+baPQJ0ya4oG2/A3WTJ67CArdz5EMStOG7Ng==
X-Google-Smtp-Source: ABdhPJz9e8u23bdl9W6P7q5ULqjRON5XoB6/o7v2BH97tDP2SNEtZQUtlKLox/z8j+wgSbu43gbCKyvpHGWIpyBE2ng=
X-Received: by 2002:a5e:8610:: with SMTP id z16mr9600257ioj.57.1617345764402;
 Thu, 01 Apr 2021 23:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210211194258.4137998-1-nathan@kernel.org> <161428829728.2305454.15456455443457551559.b4-ty@chromium.org>
In-Reply-To: <161428829728.2305454.15456455443457551559.b4-ty@chromium.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 2 Apr 2021 08:42:07 +0200
Message-ID: <CA+icZUWdeWSy52bU4cjHau1hn5NiFAozaHgDb=geaaCYOET9+w@mail.gmail.com>
Subject: Re: [PATCH] qemu_fw_cfg: Make fw_cfg_rev_attr a proper kobj_attribute
To:     Kees Cook <keescook@chromium.org>
Cc:     Gabriel Somlo <somlo@cmu.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        qemu-devel@nongnu.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 10:25 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, 11 Feb 2021 12:42:58 -0700, Nathan Chancellor wrote:
> > fw_cfg_showrev() is called by an indirect call in kobj_attr_show(),
> > which violates clang's CFI checking because fw_cfg_showrev()'s second
> > parameter is 'struct attribute', whereas the ->show() member of 'struct
> > kobj_structure' expects the second parameter to be of type 'struct
> > kobj_attribute'.
> >
> > $ cat /sys/firmware/qemu_fw_cfg/rev
> > 3
> >
> > [...]
>
> Applied to kspp/cfi/cleanups, thanks!
>
> [1/1] qemu_fw_cfg: Make fw_cfg_rev_attr a proper kobj_attribute
>       https://git.kernel.org/kees/c/f5c4679d6c49
>

I have queued this up in my custom patchset
(for-5.12/kspp-cfi-cleanups-20210225).

What is the plan to get this upstream?

Feel free to add my:

Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

- Sedat -
