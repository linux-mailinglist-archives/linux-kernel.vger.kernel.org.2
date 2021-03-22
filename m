Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A90E3440A7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 13:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhCVMRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 08:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhCVMRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:17:16 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFD2C061574;
        Mon, 22 Mar 2021 05:17:16 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id o66so6319837ybg.10;
        Mon, 22 Mar 2021 05:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=djp6rAThn/JMZBuvzCFDPT3cc+3P/h3ppC7XfOEilpc=;
        b=s/Ibu1OQbNoAMX6Sb18/aqu/7fDNdN9Pdh1Z/GYhAGHyDWfxxpx6YMeLa89s7FbDbS
         YNQbVrfVKI9AiKOm3YtwtUr0t0mTyhcVBYlSWgTgVYVvUvnAD8ubcINwJxaeSGpXaN6r
         +9q0isev61wYM8SZCczNkt4NIhoLW2/jmFfqizDgmN5EeYW//104utVdHWgrqa/3WAVd
         JqquNfCk/lzbBZf2XuyA0ZJsrRG3TPRD+YYXBaiq0fxW+1Kj38lePTdqjQPAChHEPMG5
         5+PoYway+I9B6BxBdu/Bg1/C506cud+6dxBNL+57j6YJfLxOrXhGA+lHm7HfnUV/kaZ9
         3p+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=djp6rAThn/JMZBuvzCFDPT3cc+3P/h3ppC7XfOEilpc=;
        b=ZlAuecw8xxHFBI/fB25O5wj1rSaGYRhYI1xrO3ydtJHqX13RtQEsR84E0IalhcKhUF
         D/Mc92yoKoBNQ3PIQkLGpdf+AWMxmq9TA1s0JWgWwdrJE7VD3aGEnUOyM8b+38M+DdQi
         Ab6LoVvl1G/ekQt40F1G0j4UC8O59tC/oTO8dwgIEqLaJkMEEK5lYdcJgobhjALyg1QC
         6fixIh1Ee2+nUasWr/D6M++hllAeRkxUxA/E8w0s3+zacXjyl/NH//lEnih7tVAKfkoT
         P6xNdH6YtCXzhf6TwgGIu6WRPkolYZ+d17LhoLZHlJ2LaJogiSyf/PTpM7+8Fm8Vx2PH
         040g==
X-Gm-Message-State: AOAM532KBsdc9T8wjEyybu2ds43b7B/8neGXb4ydXUAhKGOOAWDbzShe
        YCm/J2xuZet9ONneEHIW2z0pqch7uypdNX1l9Zo=
X-Google-Smtp-Source: ABdhPJxsBHGCizKsS8vwffPbH+Xz5DUB5+jh84r9t85iyZOhIqse7/znhjmdqpCpQC3t+uHe41LBE8vZPazsMssgt/M=
X-Received: by 2002:a25:d94b:: with SMTP id q72mr22707676ybg.135.1616415435700;
 Mon, 22 Mar 2021 05:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+bdXrFoL1Z_h5s+5YzPZiazkyr2koNvfw9xNYEM69TSvg@mail.gmail.com>
 <20210321184403.8833-1-info@alexander-lochmann.de>
In-Reply-To: <20210321184403.8833-1-info@alexander-lochmann.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 22 Mar 2021 13:17:04 +0100
Message-ID: <CANiq72n+hqW5i4Cj8jS9oHYTcjQkoAZkw6OwhZ0vhkS=mayz_g@mail.gmail.com>
Subject: Re: [PATCH] Introduced new tracing mode KCOV_MODE_UNIQUE.
To:     Alexander Lochmann <info@alexander-lochmann.de>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miguel Ojeda <ojeda@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksandr Nogikh <nogikh@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Maciej Grochowski <maciej.grochowski@pm.me>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On Sun, Mar 21, 2021 at 8:14 PM Alexander Lochmann
<info@alexander-lochmann.de> wrote:
>
> diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-tools/kcov.rst
> index d2c4c27e1702..e105ffe6b6e3 100644
> --- a/Documentation/dev-tools/kcov.rst
> +++ b/Documentation/dev-tools/kcov.rst
> @@ -127,6 +127,86 @@ That is, a parent process opens /sys/kernel/debug/kcov, enables trace mode,
>  mmaps coverage buffer and then forks child processes in a loop. Child processes
>  only need to enable coverage (disable happens automatically on thread end).
>
> +If someone is interested in a set of executed PCs, and does not care about
> +execution order, he or she can advise KCOV to do so:

Please mention explicitly that KCOV_INIT_UNIQUE should be used for
that, i.e. readers of the example shouldn't need to read every line to
figure it out.

> +    #define KCOV_INIT_TRACE                    _IOR('c', 1, unsigned long)

Trace is not used in the example.

> +       /* KCOV was initialized, but recording of unique PCs hasn't been chosen yet. */
> +       KCOV_MODE_INIT_UNQIUE = 2,

Typo? It isn't used?

PS: not sure why I was Cc'd, but I hope that helps.

Cheers,
Miguel
