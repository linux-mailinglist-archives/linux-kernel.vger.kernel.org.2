Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAB6355A70
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 19:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240642AbhDFRdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 13:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbhDFRdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 13:33:02 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2ABBC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 10:32:52 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id z136so7717524iof.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 10:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sn7eNVjhwGVeUQHooMwpCkybSStg97YRL/7YW6+8S5g=;
        b=d8tLbxn3hpAhshTUubDh+pFOZIC5ByibaqvqSp+367kP2VTYmgf1HfQhjW+k66Phu2
         qfnuUmliqKLe1e3LDhaE6LZKq1n1ZU/kidNCvAINzOw+QmZ+6FpGza3+lu5cxCrLwYac
         yA2gwgl2UdQFEuOcYOeI7JILyAmPBXO1V6MQzfV+nMsmj0mdQ0DVvy1PyJK2tyYSZCgv
         kOj0eLqwNE50CghcD2bJ+hGfUosR92XWM5qMMTvkT4vBF32TLEvBhPEln3hFkqCioV+f
         q2UFyiq0boEGVWOg5yQoKTAlGwHs3tDZPQWxkijyZiXnohNE11aueoExmLvidfIoDl77
         YO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sn7eNVjhwGVeUQHooMwpCkybSStg97YRL/7YW6+8S5g=;
        b=H91m4ja7IpKW6yasnemgn0pgfquFlwAQJQBmi51bI5aEdGvryNLNx2J1C+lKEoOVZD
         OCgiRDWR8+Vo9NeK7G9rlSPK2SBhlIjXCax4U5AxYrWavpqe7PBRiVSJ732WSrMute4o
         Uk/rWA892V2rSE4jrncxllx4Qce+AVzhCwaN28N5BcUfaYDKhE7S+7Je4hNhTKOQZmHi
         lylsYfm08G/bJs/uspeQIkOdPQeR0ZiTh/gjFEFW+UsZT29R2hZwR7+3xPmuAHZ6ogVW
         +UnJB80UlluXRtjncEPdg3pKuXGonnwbqkuL4XuykNRVkSmW6E6N4nebqn0DL+x8Civ2
         qUyw==
X-Gm-Message-State: AOAM53076wLJmv5hFA2h993J2uyJbhTRx37y8te85/6LjI47sd2i3rza
        pZzzj40L9coGKfnD0iiY/kK09Ymwe62Jusr4XhCZAA==
X-Google-Smtp-Source: ABdhPJy32AglK1hAaezC+y+WwRlu+kiKw5qV9ZjDk/G7wriqcq0j1vmY1/VHAYSsA/acnM8BDrgMpDo4VBV6mnxb3R4=
X-Received: by 2002:a05:6602:2432:: with SMTP id g18mr25105828iob.86.1617730372258;
 Tue, 06 Apr 2021 10:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210406202357.6e4bfeac@canb.auug.org.au>
In-Reply-To: <20210406202357.6e4bfeac@canb.auug.org.au>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 6 Apr 2021 10:32:41 -0700
Message-ID: <CAGS_qxpLOMKCS8QwOQN3ZFY-XO6MvXQOdND0pd6wYXw21CTEYA@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the kunit-next tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Uriel Guajardo <urielguajardo@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the catch.
Should be addressed by
https://lore.kernel.org/linux-kselftest/20210406172901.1729216-1-dlatypov@google.com/

When I was testing the CONFIG_KUNIT=n case, I added it to a file that
wasn't being compiled (CONFIG_UBSAN=y is not sufficient for
lib/ubsan.c to be compiled...).

On Tue, Apr 6, 2021 at 3:24 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the kunit-next tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
>
> In file included from lib/kunit/test.c:10:
> include/kunit/test-bug.h:22:28: warning: '__kunit_fail_current_test' defined but not used [-Wunused-function]
>    22 | static __printf(3, 4) void __kunit_fail_current_test(const char *file, int line,
>       |                            ^~~~~~~~~~~~~~~~~~~~~~~~~
>
> Introduced by commit
>
>   359a376081d4 ("kunit: support failure from dynamic analysis tools")
>
> --
> Cheers,
> Stephen Rothwell
