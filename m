Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEBF308077
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 22:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhA1VYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 16:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhA1VYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 16:24:11 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBD8C061756
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 13:23:31 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id i187so9574486lfd.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 13:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jge7+SvmIdKe+EfDsylHdHVfqtQTNyBnCxA66lMfr8Q=;
        b=GKpFrPZDfYQUHeDe8AiNPoLglZsvu3aI1Sjxe1zQpscy0OefqeOSO7vpuRBjPUHgch
         uZa9un2c41uGZ1Ypv2M8fQ1YK2gfkNTOb006i65jGkgUDz1VqOtBn3I8eOsRirlffDrr
         KWsmj8ulLnPpn448pe29K+RrQ+xS9kL9Bh3v4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jge7+SvmIdKe+EfDsylHdHVfqtQTNyBnCxA66lMfr8Q=;
        b=AtvHCbL9XMnZ7ghfVnViRfE2kUjjrz3Rzjeq/d7f3BXOnVcQHDvs+t4ISfxANAkZ9w
         jG2yggYavlw+xQ4EIiLOU6FRCGNUrGjjeJw2bwcHb6bUElTg7cSnfiUt1yeslkZAsQCi
         bIYCEEkVxOUOeVng/rHZtJTPZ+yJiRZBNo+7ZavQbIojtmvkp7DNnhDEGtBXsn9eVhQv
         JdFohFW8Xob+dY4rwlgh6W0mJTTNOrPqafWD6cLr5s8haWeAheaxB1VAR6nh933B5Bk5
         sXMqpgFvpZkGqeU42PI8IRB6R5j6W9tkV6pNQOoRzBm8A4i6eAZxeJ88SEHJzhZl326Q
         gDsw==
X-Gm-Message-State: AOAM53299t5LjK2iL4U8euanq38RUeMuhirHPY07xkjG/Hr2YDpMa54B
        VJk1tauKDdBbSjsRMNNMBkjOrMfhCxrR4w==
X-Google-Smtp-Source: ABdhPJzOctWCElzm7gRe4euEZk2DFvTAbxXaQ9VvxtwJfhWc31xazgR+U3aYN+dCEFoWXRYMUk+aSw==
X-Received: by 2002:a19:c56:: with SMTP id 83mr494950lfm.325.1611869009520;
        Thu, 28 Jan 2021 13:23:29 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id s3sm2258879ljo.41.2021.01.28.13.23.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 13:23:28 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id p21so9555456lfu.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 13:23:28 -0800 (PST)
X-Received: by 2002:a05:6512:516:: with SMTP id o22mr109829lfb.487.1611869007726;
 Thu, 28 Jan 2021 13:23:27 -0800 (PST)
MIME-Version: 1.0
References: <fff056a7c9e6050c2d60910f70b6d99602f3bec4.1611863075.git.jpoimboe@redhat.com>
 <CAHk-=wih0rLHsPXodpXJw_0F3bJqu=Pb_YNmPCSsYU_huoMwZA@mail.gmail.com>
 <20210128205207.awdbh4bmx56pxxjl@treble> <CAHk-=wgh4DaZvTcFfBcDMKc1QXkKjwny_Z0H5JfzdwMTNTBkSw@mail.gmail.com>
In-Reply-To: <CAHk-=wgh4DaZvTcFfBcDMKc1QXkKjwny_Z0H5JfzdwMTNTBkSw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Jan 2021 13:23:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh+3PWi2NuoQ0hbSyLpOHjaBWKcgX6N7+PfPkXzNAfMwA@mail.gmail.com>
Message-ID: <CAHk-=wh+3PWi2NuoQ0hbSyLpOHjaBWKcgX6N7+PfPkXzNAfMwA@mail.gmail.com>
Subject: Re: [PATCH RFC] kbuild: Prevent compiler mismatch with external modules
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Justin Forbes <jforbes@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 1:03 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I really think the whole compiler version check is purely voodoo programming.

.. but there are obviously potentially things we - in the kernel - do
that may make certain compiler versions incompatible. We long long ago
used to have things like "you can't have an empty struct because gcc
version x.y.z doesn't support it", so even a UP spinlock would be

       typedef struct { int gcc_is_buggy; } raw_spinlock_t;

but only if you compiled it with a version of gcc older than 3.0. So
compiling one file with one compiler, and another with a newer one,
would result in the data structures simply not having the same layout.

That's not because of compiler versions per se, it's because of our
version checks.

THAT workaround is long gone, but I didn't check what other ones we
might have now. But the gcc version checks we _do_ have are not
necessarily about major versions at all (ie I trivially found checks
for 4.9, 4.9.2, 5.1, 7.2 and 9.1).

               Linus
