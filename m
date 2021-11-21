Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F2D45858F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 18:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238614AbhKURtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 12:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238600AbhKURtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 12:49:39 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A8DC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 09:46:34 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id e3so66545271edu.4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 09:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VSsN2HX9wYE+1anh5i16IzKQM5BVIaPiR81SjlOBpzI=;
        b=I42O535hVim3UE7KiZiLXxrha1EwFKyLmyYcmz4MaD8vjKbIZ6R0k0BrPTlH/HYmmD
         74kbJJODdbr70lMWg2CovoNLbdLxtCamhlo6cJtBUV9ljwzKUeqK4IUlZNOjdP5iQ5il
         PhVe4pMzqJCvxi8Qn8ER/TlX3oxgNOW4TAII4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VSsN2HX9wYE+1anh5i16IzKQM5BVIaPiR81SjlOBpzI=;
        b=Q9mhlvf14O4ZNA5KcUwXT+DixqFvufyzB0AbAfz5dHNzJLfxmMUqzJC3vyWO2Gj6gK
         LwJOR36pLPBZ87Q2aGK5Csm6BUruUGzqqR1LmVlotY9thT6NI8lxoKZvSDMXct8aS5cb
         Ie7e3ZQZPl7b2fGCbBCeYfY/iLWXt72pPpUfFleoZUQB58eDtp0/G504dFjq5Ne96sn5
         gC/7zOnDPYENV0oYLrNdda9t0B3DEVStpHm+BVVqCrv/CgOQmGUBWaBE8fYVt/SjeVPK
         1ObwioPm0k/9Z0cygAGjzHWEk3wb1l3NZikPS0lkp4Qnp/fBwI5wkD/SXue7Aklta5rI
         eDBw==
X-Gm-Message-State: AOAM5330BXKHj12bI3Nd512di5rkVMk1ufcp3h5BgFcu9/rwDXCXrrxQ
        3+WwLTMKOE1c50mGMvqTUOvD9IA1wgaamYdl
X-Google-Smtp-Source: ABdhPJzGiXtMN9t5/maOKOpt0NRkWlX4RyFyGfOKEgqCA+ZNNlxUYwKMRrVYsurNNet31xEjzS5uLQ==
X-Received: by 2002:a17:907:7255:: with SMTP id ds21mr32993779ejc.42.1637516792723;
        Sun, 21 Nov 2021 09:46:32 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id jl8sm2599414ejc.59.2021.11.21.09.46.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Nov 2021 09:46:30 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id i5so28356777wrb.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 09:46:29 -0800 (PST)
X-Received: by 2002:adf:dcd0:: with SMTP id x16mr29652752wrm.229.1637516789746;
 Sun, 21 Nov 2021 09:46:29 -0800 (PST)
MIME-Version: 1.0
References: <20211116181559.3975566-1-keescook@chromium.org>
 <163710862474.168539.12611066078131838062.b4-ty@kernel.dk>
 <202111181026.D7EF6BCED@keescook> <CAMuHMdX6Su_4G4H5GEjy17a0xkZrqPj0kh9Tg++-2-=SGSsj_Q@mail.gmail.com>
 <f278c6c4-dca2-fd8e-57ba-1568e13db156@kernel.dk>
In-Reply-To: <f278c6c4-dca2-fd8e-57ba-1568e13db156@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 21 Nov 2021 09:46:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgCMwdrsFv=jvpX8Krgiq49PeiQbMeUB-WA0JKS2LHkGw@mail.gmail.com>
Message-ID: <CAHk-=wgCMwdrsFv=jvpX8Krgiq49PeiQbMeUB-WA0JKS2LHkGw@mail.gmail.com>
Subject: Re: [PATCH] Revert "mark pstore-blk as broken"
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Colin Cross <ccross@android.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Christoph Hellwig <hch@lst.de>,
        Tony Luck <tony.luck@intel.com>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2021 at 5:36 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> Sorry, missed this reply. Kees, can you just send this one to Linus
> directly?

I took it from that thread.

Thanks,
             Linus
