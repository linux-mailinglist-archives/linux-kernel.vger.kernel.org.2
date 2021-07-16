Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585C23CBBAB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 20:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbhGPSLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 14:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbhGPSKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 14:10:54 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C39C061760
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 11:07:57 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id s18so15173789ljg.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 11:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=la3VY4BX+aLIya8DFhmm4lsPFouObr1MQVIqGHV1haM=;
        b=V5IgJX7qk9FOKmWrEPUq3X8QcEKSnfNd7zCeCtbaLY0k8Q/Y6yXzaNyWL1szPNBeoN
         00Jvw9tYc6Q2BmPQR4l9+qfRP+5w3nQFFulhhD/7g9a9d+kjSsA5xl63651acPtoBV5F
         ya5WSNhbjkI1gJfk0JKG7f2M9rt3cil+GoEwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=la3VY4BX+aLIya8DFhmm4lsPFouObr1MQVIqGHV1haM=;
        b=YL+vS0o/RMU32OQ6DqfMvmlJmLqBrCEQ5YSnfHTGB4VV+tKJOZlwvQC2Vs/sDkMtQT
         w6ulwLLbrVWMpLoPtHhZmdDRAuy5k/oFTbOE0FJvUSF/QcEzoEKnVN6E3JWu5O5UUHwo
         FB5la71xJDK1sMCkQUxEMKquza3eKjBZIqylE7NZIm0hI1L2VsyjAFbIqTrprHZ+t2FM
         31f4azZ6YP3WoqJy9F+4LUAE5Lcy4i9MaXLtW4r8VJ1nzaXgSqsSoNwf1+VhfJ70ibDT
         CFCxhP5H9reu7jDdlsYghOv8WdVgOQblcSL917rw+K2MfXPxfmL2l4bGj+xwUIjIsP1j
         RB+Q==
X-Gm-Message-State: AOAM532UBt7GtXEwBcoXJm7r59XHWAdgDwx1V7kesxb8wGWLA7Ro7sCN
        t4kQuHgypg9yhsi68NOUHF8zO0c3jFxuUayX
X-Google-Smtp-Source: ABdhPJwoEHQHTLYWy1bHQqQWW/ZsM5nlWIU2Xv8Tlrrrfxgl5slR/wVzU84nBKRA4Ys8YqySAtC7Ww==
X-Received: by 2002:a2e:a412:: with SMTP id p18mr9632998ljn.434.1626458867026;
        Fri, 16 Jul 2021 11:07:47 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id o18sm1034115ljc.25.2021.07.16.11.07.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 11:07:46 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id i5so17426059lfe.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 11:07:45 -0700 (PDT)
X-Received: by 2002:a05:6512:3f82:: with SMTP id x2mr7981304lfa.421.1626458865567;
 Fri, 16 Jul 2021 11:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <4e8c0640-d781-877c-e6c5-ed5cc09443f6@gmail.com> <20210716114635.14797-1-papadakospan@gmail.com>
In-Reply-To: <20210716114635.14797-1-papadakospan@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 16 Jul 2021 11:07:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfeq9gyPWK3yao6cCj7LKeU3vQEDGJ3rKDdcaPNVMQzQ@mail.gmail.com>
Message-ID: <CAHk-=whfeq9gyPWK3yao6cCj7LKeU3vQEDGJ3rKDdcaPNVMQzQ@mail.gmail.com>
Subject: Re: [GIT PULL] vboxsf fixes for 5.14-1
To:     "Leonidas P. Papadakos" <papadakospan@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     zajec5@gmail.com, "Darrick J. Wong" <djwong@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 4:49 AM Leonidas P. Papadakos
<papadakospan@gmail.com> wrote:
>
> This driver is already in a much better feature state than the old ntfs driver from 2001.

If the new ntfs code has acks from people - and it sounds like it did
get them - and Paragon is expected to be the maintainer of it, then I
think Paragon should just make a git pull request for it.

That's assuming that it continues to be all in just fs/ntfs3/ (plus
fs/Kconfig, fs/Makefile and MAINTAINERS entries and whatever
documentation) and there are no other system-wide changes. Which I
don't think it had.

We simply don't have anybody to funnel new filesystems - the fsdevel
mailing list is good for comments and get feedback, but at some point
somebody just needs to actually submit it, and that's not what fsdevel
ends up doing.

The argument that "it's already in a much better state than the old
ntfs driver" may not be a very strong technical argument (not because
of any Paragon problems - just because the old ntfs driver is not
great), but it _is_ a fairly strong argument for merging the new one
from Paragon.

And I don't think there has been any huge _complaints_ about the code,
and I don't think there's been any sign that being outside the kernel
helps.

               Linus
