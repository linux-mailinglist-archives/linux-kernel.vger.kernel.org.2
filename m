Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5258D33316E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 23:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbhCIWRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 17:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbhCIWQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 17:16:54 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC012C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 14:16:53 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id e20so3818995ljn.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 14:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sTpm9iCrhHx5qhHqqdwnHB9UkiKkjNMhFzqoJDcE6mw=;
        b=UuQvh/U/otoDbmtBPbgzKFcO/S87mNzvoBlapc6yS0OCfhumkCQm92511oZsriYF0O
         DBK/6dpSK3wVNLOZdHPuucypwYmOq7kahceyEJNCD9cIihTYIociel7zlwRFD6jFDXFP
         jWZ3YT+RgICuBw3LiaBZboHHqsFx+3Cisx13g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sTpm9iCrhHx5qhHqqdwnHB9UkiKkjNMhFzqoJDcE6mw=;
        b=KmBAGyaYkyZU6N4iqhANcffzm13rWeuMhUghwWh8S6c/E4u1z5tDZWn9sTYovKJfYo
         Cl4zUHgJSl+iPUZAOHf6C3HXe1qPG8ohJTpEizxHWxQAnqLwnAUGT34LwLIMVNa1W6gG
         6dIqkXO8JAaPBDZNE1wcaDlEznckmsSxUsjzGDr+Wo8Pbm8o/5nonmzxx6t8Ek4I8GBF
         5IPwVcZPhkZqTZah0sO93yE7oPYbF0uDng7c7zmSs5ApEodufGMk1WvMiHoSlrdZItqd
         l8yURfFjwk6Vl3yf9evMNtbBd1ZAf/dlOTrrw9rLI/uT2dB/jMa0fAnCiIwWduuQn3Kc
         hTuQ==
X-Gm-Message-State: AOAM531JCUrr8023/kvZPlVMeZcd2e+WOI1T8z4ezltgXpWfV4yJd0Im
        V6ek04RatlAYkImVmKrAfkG9hrBOZ7Mtyg==
X-Google-Smtp-Source: ABdhPJwf33ldbzrkNmJxV3kt3a+npIq1E5RJcv6VOVa6HoIROj+cV7CsQrEpNFYSQCmK1AvIq8/lhQ==
X-Received: by 2002:a2e:968c:: with SMTP id q12mr17764932lji.317.1615328211942;
        Tue, 09 Mar 2021 14:16:51 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id m16sm2208293lfh.109.2021.03.09.14.16.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 14:16:51 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id q25so29917708lfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 14:16:51 -0800 (PST)
X-Received: by 2002:a05:6512:33cc:: with SMTP id d12mr75176lfg.487.1615328210832;
 Tue, 09 Mar 2021 14:16:50 -0800 (PST)
MIME-Version: 1.0
References: <20210224142909.2092914-1-linux@rasmusvillemoes.dk>
 <20210309211700.2011017-1-linux@rasmusvillemoes.dk> <20210309211700.2011017-2-linux@rasmusvillemoes.dk>
In-Reply-To: <20210309211700.2011017-2-linux@rasmusvillemoes.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Mar 2021 14:16:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgfMQyYSkdRkCuHOQEcvoyw=fN7q+0cU-s9dNqDHkSmrw@mail.gmail.com>
Message-ID: <CAHk-=wgfMQyYSkdRkCuHOQEcvoyw=fN7q+0cU-s9dNqDHkSmrw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] init/initramfs.c: allow asynchronous unpacking
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 1:17 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> So add an initramfs_async= kernel parameter, allowing the main init
> process to proceed to handling device_initcall()s without waiting for
> populate_rootfs() to finish.

Oh, and a completely unrelated second comment about this: some of the
initramfs population code seems to be actively written to be slow.

For example, I'm not sure why that write_buffer() function uses an
array of indirect function pointer actions. Even ignoring the whole
"speculation protections make that really slow" issue that came later,
it seems to always have been actively (a) slower and (b) more complex.

The normal way to do that is with a simple switch() statement, which
makes the compiler able to do a much better job. Not just for the
state selector - maybe it picks that function pointer approach, but
probably these days just direct comparisons - but simply to do things
like inline all those "it's used in one place" cases entirely. In
fact, at that point, a lot of the state machine changes may end up
turning into pure goto's - compilers are sometimes good at that
(because state machines have often been very timing-critical).

Is that likely to be a big part of the costs? No. I assume it's the
decompression and the actual VFS operations. But when the series is
about how this all takes a long time, and I go "that code really looks
actively pessimally written", maybe it would be a good thing to look
into it?

           Linus
