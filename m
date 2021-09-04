Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F65400C41
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 19:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237191AbhIDRXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 13:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237110AbhIDRXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 13:23:47 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB071C0613C1
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 10:22:45 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id m4so3842415ljq.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 10:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=98jOqbKpX72E4sPthsn4i3f66mKPjIJDIcd25lirePI=;
        b=eG78AXkrvMPYFu6Gt5/vrTdbimFDR9TXxplLlMw1nHmpyJUrQcTh/9wCJeHztK4N/O
         YH6b6mzsWGz7vhhhzfSL8IebU3Rub4K0pwZno/LNvT//BotGevQQBUiOT3pV0qZM6otl
         SWBcPAB7k8Xg5RezMwEmNMsTPJcn+HxEyK5cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=98jOqbKpX72E4sPthsn4i3f66mKPjIJDIcd25lirePI=;
        b=D/cgKMgJKkUrFsaLjdf7dDWfahmZM7wMIx+uTUwAd6qLeiczmeC6+NKSmRQ0fUu/Pn
         bR4ypjfW1gZDBgRFx4jTBckEflXpLrfdNS5RW4kvrBuvqxIpoVa0+CHVpYrp1L7ybqcL
         iPGp7fPE2sHsqJ1NRH1A5eit4Z6XnBU3l2hqpyheWI9km4hLdmpLKfvAwP20PhYHJI+U
         TaBSRud2h7Tai5acUa87yinl5NtT5tGJUA1uTtGdJ9ZYiMVCCIhUsimXOruq8lqQagyB
         hS/3mQOibWfERP4kpxD/o9DzuZmg3Z2QKVEOHCMs9ZsBPgaVrBOvPCKJb41Xip2SfGii
         Qz7w==
X-Gm-Message-State: AOAM530Cyzz7D9OaASYBuZkRV9Zf9NyNdEVfPeyRSvks6PjUYnVdHlPs
        h7hyjexoqElCNGzi8SPuEN8CXD0kKuGoZ8ZM
X-Google-Smtp-Source: ABdhPJw4Pxco5zUbueUv71/VXG7aJmQxSWCXO+fZM48nLgOUGnBd0h3FKeqb/nkc7JdhPTCF66JHPA==
X-Received: by 2002:a05:651c:2006:: with SMTP id s6mr3558342ljo.171.1630776163492;
        Sat, 04 Sep 2021 10:22:43 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 23sm289203lfp.47.2021.09.04.10.22.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Sep 2021 10:22:42 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id i28so3839182ljm.7
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 10:22:41 -0700 (PDT)
X-Received: by 2002:a2e:a363:: with SMTP id i3mr3513230ljn.56.1630776161685;
 Sat, 04 Sep 2021 10:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAQ0Q6CdXaD-dVGj_e3O3JYs_crpejWKpXHYQJYxyk-1VQ@mail.gmail.com>
 <CAHk-=wgoX0pVqNMMOcrhq=nuOfoZB_3qihyHB3y1S8qo=MDs6w@mail.gmail.com>
 <3b461878-a4a0-2f84-e177-9daf8fe285e7@kernel.org> <878s0c4vng.fsf@oldenburg.str.redhat.com>
 <20210904131911.GP1583@gate.crashing.org> <871r644bd2.fsf@oldenburg.str.redhat.com>
In-Reply-To: <871r644bd2.fsf@oldenburg.str.redhat.com>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Sat, 4 Sep 2021 10:22:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi+XKYN+3u=_fm=ExqpEaHdER0XuKxVauHYVCPKpKR97Q@mail.gmail.com>
Message-ID: <CAHk-=wi+XKYN+3u=_fm=ExqpEaHdER0XuKxVauHYVCPKpKR97Q@mail.gmail.com>
Subject: Re: [GIT PULL v2] Kbuild updates for v5.15-rc1
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        llvm@lists.linux.dev, linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 4, 2021 at 8:19 AM Florian Weimer <fweimer@redhat.com> wrote:
>
> In any case, it would be nice to know what the real motivation is.

I don't know about the original motivation, but the reason I like that
patch after-the-fact is that I've actually been in situations where I
test out self-built compilers without installing them.

Then it's convenient to have a completely standalone kernel tree.

Nobody cares about things like <stdatomic.h> They are completely
irrelevant for the kernel, exactly because we've always just done our
own, or used __builtin_xyz() for things.

<stdarg.h> is the only actual core header file that we have always
taken from the installed system headers - because historically it
really was required. Everything else we can just do ourselves.

                 Linus
