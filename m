Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09473B6CDD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 05:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbhF2DPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 23:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbhF2DO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 23:14:57 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13147C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 20:12:31 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id u25so13312017ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 20:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lxpuIgImrk2Nut6t9SunWaFErLAriKV8wLW1jTaUGwI=;
        b=hQ2yG990j3/oo5+bGZ8PG7Ad+rtFl+qaXdTJwdK92hrAeXIjbzs1cxD7XGeBaU6HdL
         HAW/gdMGuY71DKtmnDthAltUG9FoX64jfVsijEj6unvklUhohgx7OKS6QCkMwyl6yOjE
         48hPTl/wyCc8n7R4B+I8BxTeIyBH7BvpzLMPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lxpuIgImrk2Nut6t9SunWaFErLAriKV8wLW1jTaUGwI=;
        b=ZbXonOVsHx2G7ePgsdirHj6VuuJkMW281SIkxHOZqX8Yl3trK8YYEbq4djC5n3zyd5
         +Wl+0lYk+XSkpAjPUexcfbWFXhvXnG+B+6lpxvpCwM2moL0rk++MhnjbpGiecMCSqZW8
         usOzTCzcc7zGszh9aG0GWFQ7ixKyi+SSjXYwmerSyUD6bLX5zALXpydSAs5Q7uerW8V4
         1bDi0xhyN8BS7Xe5JR+vXI6Aj++T6X1rx9v+Ko56VRwBEUUJahEGsuFsfqj2r2Lh68Nt
         u0p6LlA0Xg3Vo/OiZ0/DT6ilDm/PiSHQuA3P6t4REoO9QwMGJGVgla6+vOMQHmeiWmFC
         L7EQ==
X-Gm-Message-State: AOAM533Yah3ngXK+YkCy7OyIMzABOXt5wYCyrjxRu2DmV/3w0Lt5bb9x
        cjIDln945XoZXrVHXqBOAkU+N58KP3mpyJxPdgs=
X-Google-Smtp-Source: ABdhPJz4NFepjrwKbjiSQi8ARXFGwOny3jbKJDGqh5DjKrzbfupBECae0LXSwFkiN54UqwfabIpSww==
X-Received: by 2002:a2e:2a81:: with SMTP id q123mr2091103ljq.338.1624936349214;
        Mon, 28 Jun 2021 20:12:29 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id j2sm476731ljc.49.2021.06.28.20.12.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 20:12:28 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id a11so36599628lfg.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 20:12:28 -0700 (PDT)
X-Received: by 2002:a05:6512:3f82:: with SMTP id x2mr20695806lfa.421.1624936348513;
 Mon, 28 Jun 2021 20:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210628205947.GA10869@embeddedor>
In-Reply-To: <20210628205947.GA10869@embeddedor>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Jun 2021 20:12:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wik-iqVYJyDxfPsOk_8vt1BrsKF-H-nunAYHw3HHuvZqA@mail.gmail.com>
Message-ID: <CAHk-=wik-iqVYJyDxfPsOk_8vt1BrsKF-H-nunAYHw3HHuvZqA@mail.gmail.com>
Subject: Re: [GIT PULL] fallthrough fixes for Clang for 5.14-rc1
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 1:58 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Please, pull the following patches that fix many fall-through warnings
> when building with Clang 12.0.0 and this[1] change reverted. Notice
> that in order to enable -Wimplicit-fallthrough for Clang, such change[1]
> is meant to be reverted at some point. So, these patches help to move
> in that direction.

I've pulled this, but I really don't like how random it is.

Just as an example - and there are many others - look at the patch to
net/netrom/nr_route.c.

It does

                case 0:
                        nr_node->routes[0] = nr_node->routes[1];
                        fallthrough;
                case 1:
                        nr_node->routes[1] = nr_node->routes[2];
+                       fallthrough;
                case 2:
                        break;

and then about a hundred lines later it does
                case 0:
                        s->routes[0] = s->routes[1];
                        fallthrough;
                case 1:
                        s->routes[1] = s->routes[2];
+                       break;
                case 2:
                        break;

Notice? One does a 'fallthrough' to the next case that does the
'break', and the other - very much equivalent case - does a 'break'.

So the whole "add 'fallthrough' or 'break'" decision doesn't seem to
have any pattern or rule at all.

                 Linus
