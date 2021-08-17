Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4B13EF23C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 20:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhHQSse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 14:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhHQSsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 14:48:30 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBCEC061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 11:47:56 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id r9so33786630lfn.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 11:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=alY8uh/6wUCPRdZH1MAlluu7K/itfkn6Amur4AolX1Q=;
        b=NQibOidO2dEdyro6KFMCZxGMZBmzLSvNapwwlVJiPrJGKg0DcYgG+45B4U6OGrxX19
         fem8v8KZbLWeY4YPDdW7+PpvnHJiN8SMKtvukFTKgxT6K0/xyp8HJ2IIE4VyHfML8NjS
         9Jk162y78pcCU/wynJAsOwJN//0EeKzPFplU6TvkURRw0TOUJ1rbv5fpFrSIZL2Qe+AG
         vz2/nSuxk6xYn8vXCEmv174KhC91b13nCiYZKiaZbViZSGxhkiLvf0t4DcO5AN+KvX0f
         zQk7sapjz9bAH5QyulU7qwX2QiJEtrz+/+/wRc64Apy5mXzl8k8qkKOkgycEYqUKCduV
         y1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=alY8uh/6wUCPRdZH1MAlluu7K/itfkn6Amur4AolX1Q=;
        b=BzGouO/Gdhi+nNN7MNoUJTIzR1fALH1dUIaXGv7sBksjhF11GEBM/+qpDpp70l1v6D
         hqzTYGEX9YR+/p+QVIe4LgDWuDYVXSAPUlCVH34335EDcZVGSwMKlnD3kxtigbdLgSBo
         TDv8e3kQav3SbWNyPL1aEcH5XIPJgbGcCh81vwzstJmugwpSOal+wf/hz2FfyczuUcMf
         jhomja8i3p/umDP2J1bRtoD/iafpKbR/zaq9ouDR+rYMy7NKfhBVL8+eN5LVFUXknYb8
         1EwwJqepvbQAzfzox0Lif1MXibgSukTWsCvC2UF3+hL5IGUEY36nYMIx+Wm2j7ovXl95
         F9uw==
X-Gm-Message-State: AOAM532QoPdt1HpBXuqq5hpfgh7x0X5x/k0EtU8WiKB5DrHEmc5YAvL8
        u57QAu1RKMy/lFuBIsbmewNb5jwJglKlJw8t6vGXpQ==
X-Google-Smtp-Source: ABdhPJyzkpMY5YJFMc5oh+gGqliuDzjpgK5AvaINE4OlrENoR8Tb3y4Zy9IByOXcvHoSMi82OYaX50RN1uYy/ZDFVX4=
X-Received: by 2002:a19:7117:: with SMTP id m23mr3587131lfc.73.1629226074949;
 Tue, 17 Aug 2021 11:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <269701460.117528.1629210189833@office.mailbox.org>
 <796036867.117557.1629210288168@office.mailbox.org> <CAKwvOdkYgC4pU0Ta+vS-UkyAYFTkg8MaLuR+OAsSX63_BY+1vA@mail.gmail.com>
 <CAKwvOdk+fwHQDe23Ttva46tyB9yGGxB73zXzNPkcMCggSRWUdQ@mail.gmail.com> <ec0f00b1-04c7-9972-d28b-122964a127dd@mailbox.org>
In-Reply-To: <ec0f00b1-04c7-9972-d28b-122964a127dd@mailbox.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 17 Aug 2021 11:47:43 -0700
Message-ID: <CAKwvOdnUFuvmoywKvGyrnDMHgkVrq3vSenLSy048U=amWs2QTQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86, Makefile: Add new generic x86-64 settings v2/v3/v4
To:     Tor Vic <torvic9@mailbox.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "graysky@archlinux.us" <graysky@archlinux.us>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 11:31 AM Tor Vic <torvic9@mailbox.org> wrote:
>
> On 17.08.21 18:22, Nick Desaulniers wrote:
> >
> > Ah, cc-option can be used from Kconfig. Perhaps a cc-option call to
> > -march=x86-64-vX with a comment about which compiler versions first
> > supported these (so that we can remove the feature test when the
> > minimum supported toolchains are advanced) would be better?
> >
>
> That makes sense. Will do a v2.
> Which of these possibilities is more "expensive"?
> I remember a recent patch where some of these calls were removed.

cc-option does "cost" more than these version checks, but it is more
concise about what we care about and they can be removed over time.
They also work better for different compilers, since it's easy to
forget to check one particular compiler, or get the compiler version
wrong, or break a pre-released compiler.  We generally want to prefer
feature detection to version detection.  I sent a series recently
removing stale checks.
-- 
Thanks,
~Nick Desaulniers
