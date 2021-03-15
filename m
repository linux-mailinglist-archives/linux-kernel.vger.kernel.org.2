Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF19D33C93F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 23:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhCOWTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 18:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhCOWTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 18:19:37 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15448C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 15:19:37 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id z8so18143727ljm.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 15:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JHuD9L12GwXv9CMjuewy7NJi4UEeZj8gMIMY0fXoMjo=;
        b=S+PBvkiNvoS7h8zAD5cjsSRJz4FVPn0bUbOW1vAx3cSOxv0XYlgWOMD63ht2EW+UvG
         WqRwvdt1hEocnp30SVofJDviTh5NFMlDuAZFdZ0CFQTPQzKAvpCn4FZXTYX5F2Q7x0TA
         w6hkZe/5rBy3BNMBjtwIU8r7P3WUEjnalDrr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JHuD9L12GwXv9CMjuewy7NJi4UEeZj8gMIMY0fXoMjo=;
        b=Ir5+9cbqpbIRKH1EBJ3UALwD7MFhoYawcGo0X0asjUzbnpUyI4MkifShLT1FHn7Px3
         UnvKuK3PcVgF1LRRXZC/iNt5QdpxDW3eS5gogRRNUVHrDovubaz5My4Zf97inzWTzN6o
         6ll2q5DIMgUhhuimzcPWg7jMNKVMHp07iuToaWS/T9xEzcUwMu0lPYuQZCD41fByEfY4
         mFNkWilRZICkGhBISVBgX6xB1CkPJJatrnVruELSjnTCiX00QYXRFPCnRpic4oWXedu5
         uMTloTd25DD3dWYkP4ZtB5NumKVUMPUMq0bod+dtxZAyBHVU+UEujPEjo9xJaFnhS6C0
         /QZg==
X-Gm-Message-State: AOAM532Tpt0z7tyoOBpZ2SH1oEJqLzv+Dht2tvbblvFSo9wVLnfLcHwL
        ocxmD6haL2YwEkwbj9PeQi9X2xnF3XG6jg==
X-Google-Smtp-Source: ABdhPJwQeGqOUzwRbczG5clWaW5b5d7l0vraN9AIOxzAqqI79ZC4SeeesnV2VqV9iwcY4aY22ubUoA==
X-Received: by 2002:a2e:9055:: with SMTP id n21mr704367ljg.248.1615846775226;
        Mon, 15 Mar 2021 15:19:35 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 192sm3011870ljj.95.2021.03.15.15.19.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 15:19:34 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id s17so18149693ljc.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 15:19:33 -0700 (PDT)
X-Received: by 2002:a2e:a589:: with SMTP id m9mr729361ljp.220.1615846773296;
 Mon, 15 Mar 2021 15:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615372955.git.gladkov.alexey@gmail.com>
 <59ee3289194cd97d70085cce701bc494bfcb4fd2.1615372955.git.gladkov.alexey@gmail.com>
 <202103151426.ED27141@keescook>
In-Reply-To: <202103151426.ED27141@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Mar 2021 15:19:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjYOCgM+mKzwTZwkDDg12DdYjFFkmoFKYLim7NFmR9HBg@mail.gmail.com>
Message-ID: <CAHk-=wjYOCgM+mKzwTZwkDDg12DdYjFFkmoFKYLim7NFmR9HBg@mail.gmail.com>
Subject: Re: [PATCH v8 3/8] Use atomic_t for ucounts reference counting
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 3:03 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Mar 10, 2021 at 01:01:28PM +0100, Alexey Gladkov wrote:
> > The current implementation of the ucounts reference counter requires the
> > use of spin_lock. We're going to use get_ucounts() in more performance
> > critical areas like a handling of RLIMIT_SIGPENDING.
>
> This really looks like it should be refcount_t.

No.

refcount_t didn't have the capabilities required.

It just saturates, and doesn't have the "don't do this" case, which
the ucounts case *DOES* have.

In other words, refcount_t is entirely misdesigned for this - because
it's literally designed for "people can't handle overflow, so we warn
and saturate".

ucounts can never saturate, because they replace saturation with
"don't do that then".

In other words, ucounts work like the page counts do (which also don't
saturate, they just say "ok, you can't get a reference".

I know you are attached to refcounts, but really: they are not only
more expensive, THEY LITERALLY DO THE WRONG THING.

           Linus
