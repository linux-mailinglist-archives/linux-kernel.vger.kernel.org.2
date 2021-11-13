Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C62444F536
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 21:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbhKMUTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 15:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbhKMUTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 15:19:17 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F25C061766
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 12:16:24 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id v11so52627142edc.9
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 12:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fUJ4RyiarGckKo6VaSVoc1S73NVAy1M1UHBUtVn+dXA=;
        b=EaXFmIPMUnTgemqp00jPWEfQekTJEO+Ri6p4PaQ/16UHBdOb9ItZ0WOZOFZUkNiiRi
         FZyi/kGYjiDPRfQKh3bwlsZq+60tiJynG7F3+ibuuppJcsSf9a30BqwExZcV38EvafA8
         JIIu4eL7YOOKdKpH1945V2GZXkPy7E8ziEZDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fUJ4RyiarGckKo6VaSVoc1S73NVAy1M1UHBUtVn+dXA=;
        b=MS079tyGo3PB1T2G7DjSvd4Get3YhP8pXz40eSf1p32axTa4XujsNxmt1VWsl2FK2I
         X3qbHEZI+BXUQmXOkyPvFJnwmKKsEFmYDUFpnm40wthFW96HOCjrd9SQ4qFVxwyizJX5
         X0SUswWlXTr0Bdh1Ir6W+RFFJpoGP7eCNpL3v/whvxdKRLpKwrmmbBqubSx8X6v0bsM8
         cgha6xiy8pLyRui7jIHbavTOThBu0B0RyRCZ4AIzZpqBAuCACSs2K4X78TjraQlM0XnI
         aLrRk9xNLH5UMb9lb1pY0pQov/1V+P25cqyUKhII7lleSwqGKOaip3nrObXOlmmSWWMs
         X+4w==
X-Gm-Message-State: AOAM533w0BsErr/I+OHdJzneyFuRtYkERtGT7ITHTwNuEU9aV1MIHHEO
        MPTjPHcoVrRl7Twf/zSDAtRQ6zpy3/xiWzUo5SU=
X-Google-Smtp-Source: ABdhPJxZs71NW6EjRRZkFPupSev2l3mRsRIGUsV52lS5301wy4PS6dNAQNXDlX76isafhb9OOmROFw==
X-Received: by 2002:a17:906:e85:: with SMTP id p5mr32183164ejf.159.1636834583108;
        Sat, 13 Nov 2021 12:16:23 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id s16sm4689583edt.30.2021.11.13.12.16.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Nov 2021 12:16:22 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id o29so10538688wms.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 12:16:20 -0800 (PST)
X-Received: by 2002:a1c:7405:: with SMTP id p5mr44079154wmc.152.1636834580292;
 Sat, 13 Nov 2021 12:16:20 -0800 (PST)
MIME-Version: 1.0
References: <20211111084617.6746-1-ajaygargnsit@gmail.com> <CAHP4M8V2WEQ0LgHp7PHdBMYFp+_frn=7GLQVF7=faqapojQ+2g@mail.gmail.com>
 <628a49dc-f6f7-5aa4-8a4d-4f2ed19b7f3f@kernel.dk> <e87601bd-21c4-00b0-9500-054bca8abced@kernel.dk>
In-Reply-To: <e87601bd-21c4-00b0-9500-054bca8abced@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 13 Nov 2021 12:16:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjgZVY-skWP1vW2Cw+His+3eESATM_+QDYp=wFEsVv=qw@mail.gmail.com>
Message-ID: <CAHk-=wjgZVY-skWP1vW2Cw+His+3eESATM_+QDYp=wFEsVv=qw@mail.gmail.com>
Subject: Re: [PATCH] mm: shmem: do not call PageHWPoison on a ERR-page
To:     Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>,
        Yang Shi <shy828301@gmail.com>
Cc:     Ajay Garg <ajaygargnsit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2021 at 9:21 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> Maybe Andrew is out - Linus, if you follow this thread, there are two
> proposed fixes for this. It'd be nice to have one of them in -rc1.

Neither of the fixes were sent to me, and honestly, I think the real
issue is that the original commit is just too broken for words.

The error handling in that commit is just entirely lacking.

I've reverted the commit rather than try to fix up the breakage.

Because at some point it's just better to say "that was broken" rather
than try to fix it up. And that original commit was too broken to be
worth fixing up. It already had one fix for uninitialized variables
before it even hit my tree, and then caused problems and had obvious
broken error handling.

             Linus
