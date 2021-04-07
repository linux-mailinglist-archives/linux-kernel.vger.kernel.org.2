Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C1E35735A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbhDGRlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhDGRlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:41:50 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA584C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 10:41:38 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 15so21754721ljj.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 10:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7+euRwjWu1ptFFLYu9J3PaklSiZs0mpcK4M0WlO9vvE=;
        b=npDspJwONAe+/L94WQy6vf1aEKtnmWsk6PTfq/9dBJQAHKzRE0qYg9zac3WxhuStGl
         xVFOZn+JC9tKGy6o3OKM5reYnYdfaq1NzoTCE92F8vtbMpqGf0/DrIoGYqfkwfchLk6o
         dJoZ0uSF4XjZ5e0nbl9X/xVVqq9pfQ1L7tcWk2rNB0BnYFJnEacSyxdCBNYwKKkPgqea
         KUkeq5qrWJW78DZoIk9XiN8Ad35EUd68gx2vrDTXCTJdV2Wdh604uj/Fid5p6HXaGyEd
         fROb7IY4ipU+4rpPlOMJqKUU749ic/QJWqgSi60w6FX5DBp5omc4uB1QQmV70dV/1tOy
         3GGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7+euRwjWu1ptFFLYu9J3PaklSiZs0mpcK4M0WlO9vvE=;
        b=UW+e2qJNgBHNHmSVEGe2a6fcXJUAjVxm9uQ5UbPJ2YYFDMWYD1edDt2bAkk2pN9Pqi
         4j8PD07irIKim3wuKNl8oVtE2j41U7yuB/Oe6YTiFDJZTvn4xHykpTWliJ85HjKmcbtF
         F+pFyYCsEtI9+ZvYYOLEb2nMYWSVlA+ONHkKANVDctzlDHjq2K4h0epFGo66sK92bzsS
         2k4WFNNpgzDU5RxiZ8sR7cw55sI443CER0Swg3NcTYya/AW/leSMUD3rdIvrFUGFqO6n
         gSDEiZr1dWVQH1DHRADCYuc4axD+HUQDS0ljiRj/v7XLE5H93Yj1EpxM2C67p2VnourR
         iajg==
X-Gm-Message-State: AOAM533s/MKXpPaT3JM4ThZJwby7xIBYji2viD7GYKRWVqwoh2qcRf05
        CzxOL0o+Lx5prj7Q7Rgg4U5HPcFcumyaQdwFI8HcBA==
X-Google-Smtp-Source: ABdhPJxN/y3Zs7Ebzs1yeKvipltG1HX3XkeV5bZ0HqyurRqwqZ2iJLcJmIYhA47n58rrUYT8MOfyz/9YjJGsQmaEbU8=
X-Received: by 2002:a2e:3603:: with SMTP id d3mr2801174lja.495.1617817297133;
 Wed, 07 Apr 2021 10:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <1617177624-24670-1-git-send-email-yang.lee@linux.alibaba.com> <20210407120239.GD25319@zn.tnic>
In-Reply-To: <20210407120239.GD25319@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 7 Apr 2021 10:41:26 -0700
Message-ID: <CAKwvOdnuKazNhqXAM9Qj7DgCW=PqVHkyyfYWytmkyBzv0QeYsw@mail.gmail.com>
Subject: Re: [PATCH] x86/kernel: remove unneeded dead-store initialization
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yang Li <yang.lee@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 7, 2021 at 5:02 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Mar 31, 2021 at 04:00:24PM +0800, Yang Li wrote:
> > make clang-analyzer on x86_64 defconfig caught my attention with:
>
> I can't trigger this here using:
>
> make CC=clang-11 -j16 clang-analyzer
>
> I get all kinds of missing python scripts:

<snip>

> FileNotFoundError: [Errno 2] No such file or directory: 'clang-tidy'

You do have clang-tidy installed right? `which clang-tidy`?
-- 
Thanks,
~Nick Desaulniers
