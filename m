Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5583273B0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 18:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhB1RrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 12:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbhB1RrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 12:47:17 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BDFC061786
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 09:46:37 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id y12so3760232ljj.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 09:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PYbd8W2ERsYmeYVUmOtaj2jhrGyioWCUfE9oukXAhNE=;
        b=ESt51xZ6j8z3R2C13hvhPuz4+dqFbpWeLIYeBC/785+e7TMpGjVvwbZTyBbXYiywNg
         tUHY8gJUP0ZFuwgthF/ITRSf89SQUxz6/1OZcinYsJAnQktW5vMYNpGD6j8iTXw9vQic
         +l1XcmZmM6okfi0xWyf/k8Pd9YahI3rTnu4CM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PYbd8W2ERsYmeYVUmOtaj2jhrGyioWCUfE9oukXAhNE=;
        b=ex3q6IJ71ttgW6vLuumF51Ek4xW/5fvkVpbhiUXJIa83XdBiyJRo224VCfXAruYgNj
         LIENC/GwvjYeObnJceeAMfuhLpsG63gmZ5zLG/Xs38VfghJRG57rpcPD2VZLJjz2Vf+x
         YIPV2weZo5W7wnk2gXHcU1NoCKem4UZJC53l+aYF5/pPhCX37WS+njoGNLIRi9nRfPdA
         Heg0JtkwalRl6epNNLYEu4lLD4q0yMBNLDmWJqwt8K39b6sSl38TzHsqm7K9fkR8HyHL
         bYlDN6eSkcc7HW8Nt25ZOM6/mwBT90p/denP8BUdk0kTsyD0Ha/bVW5xZEFOJG0hjxz8
         gh6w==
X-Gm-Message-State: AOAM5317Qsdclsu7TtvC35dPKWtu9h2EopkMS6C/9PcSt8hQnSymqHqM
        IsWV5Pgb+Nf592ndJhL1s8QxZuGWjgHNBg==
X-Google-Smtp-Source: ABdhPJxHEpRFENdYE8+3N8zKYks1TQGJui96x4OkctTfiWi5WR62F/BavwDU+xzSvluHxOwN9tOv2w==
X-Received: by 2002:a2e:8047:: with SMTP id p7mr1124490ljg.8.1614534395099;
        Sun, 28 Feb 2021 09:46:35 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id t142sm1812154lff.255.2021.02.28.09.46.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Feb 2021 09:46:34 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id p15so7766852ljc.13
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 09:46:34 -0800 (PST)
X-Received: by 2002:a05:651c:3c1:: with SMTP id f1mr6158938ljp.507.1614534393744;
 Sun, 28 Feb 2021 09:46:33 -0800 (PST)
MIME-Version: 1.0
References: <YDvLYzsGu+l1pQ2y@localhost.localdomain>
In-Reply-To: <YDvLYzsGu+l1pQ2y@localhost.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Feb 2021 09:46:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjFWZMVWTbvUMVxQqGKvGMC_BNrahCtTkpEjxoC0k-T=A@mail.gmail.com>
Message-ID: <CAHk-=wjFWZMVWTbvUMVxQqGKvGMC_BNrahCtTkpEjxoC0k-T=A@mail.gmail.com>
Subject: Re: [PATCH 00/11] pragma once: treewide conversion
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 28, 2021 at 8:57 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> This is bulk deletion of preprocessor include guards and conversion
> to #pragma once directive.

So as mentioned earlier, I'm not 100% convinced about the advantage of
#pragma once.

But I decided to actually test it, and it turns out that it causes
problems for at least sparse.

Sparse *does* support pragma once, but it does it purely based on
pathname equality. So a simple test-program like this:

 File 'pragma.h':

    #pragma once
    #include "header.h"

works fine. But this doesn't work at all:

    #pragma once
    #include "./header.h"

because it causes the filename to be different every time, and you
eventually end up with trying to open   "././....../pragma.h" and it
causes ENAMETOOLONG.

So at least sparse isn't ready for this.

I guess sparse could always simplify the name, but that's non-trivial.

And honestly, using st_dev/st_ino is problematic too, since

 (a) they can easily be re-used for generated files

 (b) you'd have to actually open/fstat the filename to use it, which
obviates one of the optimizations

Trying the same on gcc, you don't get that endless "add "./" behavior"
that sparse did, but a quick test shows that it actually opens the
file and reads it three times: once for "pramga.h", once for
"./pragma.h" and a third time for "pragma.h". It only seems to
_expand_ it once, though.

I have no idea what gcc does. Maybe it does some "different name, so
let's open and read it, and then does st_dev/st_ino again". But if so,
why the _third_ time? Is it some guard against "st_ino might have been
re-used, so I'll open the original name and re-verify"?

End result: #pragma is fundamentally less reliable than the
traditional #ifdef guard. The #ifdef guard works fine even if you
re-read the file for whatever reason, while #pragma relies on some
kind of magical behavior.

I'm adding Luc in case he has any ideas of what the magical behavior might be.

Honestly, I think #pragma once is complete garbage. It's really is
fundamenetally more complicated than the #ifdef guard, and it has
absolutely zero upsides.

I'm not taking this pramga series unless somebody can explain why it's
a good thing. Because all I see are downsides.

               Linus
