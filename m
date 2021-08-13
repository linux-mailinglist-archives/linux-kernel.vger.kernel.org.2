Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378013EAE60
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 04:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbhHMCHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 22:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbhHMCHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 22:07:40 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECA5C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 19:07:14 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q11so3994496ljp.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 19:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wO1M5UtLvug2A5hRgVYIWY9DDzdDk6/rku4F6KahBzI=;
        b=M3lBRyHWWH+V0YBic7XL0KW58RxXBvsq9HD7dXw5K+8C4XYDnPHRC5hFNzl/0GxeaF
         LNWxSxjk9GpTNDuZSStPk1XGVSYgH5U9viil0hj8D/iK1+rYz95LfBees0AF5iU36YC4
         ZSty7lye4qCg+zyTpkbQEX2LhsuMyXzutn05I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wO1M5UtLvug2A5hRgVYIWY9DDzdDk6/rku4F6KahBzI=;
        b=m7/u9RRLx0mI4jz7Gb6I7JCEf1BUo7uI2KEQHggolkr9CZEJSU0DAp+108eN5UxEkF
         x9R/ycZczEO52AWemLemIOOpTjFli4fVALzw2Pwq4jXgU1XYWsBuq5ybdTZbLhaP+xB/
         Y/XKBkS5Xk3B6R3dqPA3ADjP8f1HYpNQpauSH5namDrW2yfmvDD28fqSVKNNe3SL4vCi
         jJlzdrknRqarQwgPP9eZRREyiVB57cygSOh7kDPSpZogL978Gn8RRwvqF+VSMQofAZFX
         +7PTI3Vqo1WC03uNaLHKv2uC7iY3ud/SLKmqFuCeYDvSVDqFxuKqQFpRwzHEdHtrFIxl
         8y+Q==
X-Gm-Message-State: AOAM531pT9a2+STj0N4VLO8ZroJ0eTE/2roT4f7jC7V9s7nlT+aEzebI
        REjC3GhbY/kAh9qGQcRi78FRo4x+OgTiQlVbxFw=
X-Google-Smtp-Source: ABdhPJylaGTc7lgqfD5Y7gKZUH1H3lR7x69XqPof8kK4E2+FSFha+KRELIqp0wJAwJhAvBmHH6yKOQ==
X-Received: by 2002:a2e:a781:: with SMTP id c1mr57088ljf.138.1628820432377;
        Thu, 12 Aug 2021 19:07:12 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id u18sm510788ljj.2.2021.08.12.19.07.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 19:07:11 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id y34so17153921lfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 19:07:11 -0700 (PDT)
X-Received: by 2002:a05:6512:114c:: with SMTP id m12mr7300lfg.40.1628820431608;
 Thu, 12 Aug 2021 19:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210812112938.3748c7f5@oasis.local.home> <CAHk-=whHxeUjaNrWOLb0qx=-nibRZzQomwkw9xMPH_aHCf=BWQ@mail.gmail.com>
 <20210812133306.1c480741@oasis.local.home> <CAHk-=wj=8xh+AcwQ+w62-QHfVU6wXC2xW8L17VvVBaR6dR6Ttg@mail.gmail.com>
 <cef5b624-b5f8-7729-3b05-3543578c6e3e@infradead.org> <CAHk-=wiEK+RooMgy+-vUbvfJi2PXCVh2K+ENeJszo6HyzYb-Cw@mail.gmail.com>
 <a294a454-89c8-d32c-3b0a-1c53480a8ab6@infradead.org> <2f39ab4d-695f-c5ed-5991-82a3aeacdba0@infradead.org>
In-Reply-To: <2f39ab4d-695f-c5ed-5991-82a3aeacdba0@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Aug 2021 16:06:55 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgLUYU3QX_sWKUxQzFa18snv5iz_E=xsXnv27FZb+tqQw@mail.gmail.com>
Message-ID: <CAHk-=wgLUYU3QX_sWKUxQzFa18snv5iz_E=xsXnv27FZb+tqQw@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Fixes and clean ups for v5.14
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 10:47 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> I probably misread that a bit. To be clear, my patch only set -Wno-main
> for this one source file, not for the entire kernel tree, whereas Steven
> wanted it to be set to the full kernel tree.

Ack, let's just set it globally, there's no need for this to be some
surgical strike thing.

                Linus
