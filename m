Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35013376A77
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 21:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhEGTHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 15:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhEGTHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 15:07:51 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377DCC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 12:06:51 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id j10so14120047lfb.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 12:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gh0B3WSFNAOfleCfnt2flKLSf30MwVsP2ZwOKpp82cg=;
        b=L9XM6lPCsR5SHe/yUVKrYoqK1Ves/gBOL1CWHPlhDT+6bNo/qx0S6DRRVt7dEXa0h1
         GWWo0lgKavlZBY9zlJFVG83v3PUZHzdMPeVfe7bgYAKX+03k2WBamuthGdgpFjkORL/G
         xWCFEYTl+e9SaO/+8AS0mz4kTkGvCpeLoQwBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gh0B3WSFNAOfleCfnt2flKLSf30MwVsP2ZwOKpp82cg=;
        b=uRFGb2H9+IXIwXvl02oP/oWwZZKo030Dx1MceNABExcOHHxK40Fw5vkv6PKQE1BrRu
         GqNA0YDoXpWMtN4mvVl86WsGAiOzdQ/g4wiUlZRYOtXzrKKfnwP1ROTGdPj7hUXAEwvr
         g7V1h0G8kFZ8norbxKeOFddUDgAHdz9ArRrYe8EI11PwA55dNGVVNdPQOUBxpG2AVTsM
         va9jbYiOjUcJCX//vF0qLWUO+X9vBD19JD3QQxWRABK2uxK4IAuXgN9OI4mX6kjctAKZ
         iuwFozqnJX8nplY8v71lv5JCbGIcHg2gBPuzxBWIDiBtsjamVJXXdSGEWhSZSuEwNKO7
         EGiw==
X-Gm-Message-State: AOAM533gG03XoUT1h8qKS6M1LUS/ZlqaWGHDt2yVf3mmInEbA1knuGSA
        iVWUdQZacBOuIjBIAwXQB78na72P37F1ftUVgUM=
X-Google-Smtp-Source: ABdhPJyEWbY55qhmd4nf/piwT7L2AQUUZRHUWB7eUMwWl8RaA5V9rQcLGeh1Lvv+tJ5QeAUmdf7OZA==
X-Received: by 2002:a05:6512:3d20:: with SMTP id d32mr7194645lfv.648.1620414409498;
        Fri, 07 May 2021 12:06:49 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id d7sm1442777lfa.48.2021.05.07.12.06.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 12:06:48 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id u20so12840380lja.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 12:06:48 -0700 (PDT)
X-Received: by 2002:a05:651c:3de:: with SMTP id f30mr8768618ljp.251.1620414408470;
 Fri, 07 May 2021 12:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <2add1129-d42e-176d-353d-3aca21280ead@canonical.com> <202105071116.638258236E@keescook>
In-Reply-To: <202105071116.638258236E@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 May 2021 12:06:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=whVMtMPRMMX9W_B7JhVTyRzVoH71Xw8TbtYjThaoCzJ=A@mail.gmail.com>
Message-ID: <CAHk-=whVMtMPRMMX9W_B7JhVTyRzVoH71Xw8TbtYjThaoCzJ=A@mail.gmail.com>
Subject: Re: splice() from /dev/zero to a pipe does not work (5.9+)
To:     Kees Cook <keescook@chromium.org>
Cc:     Colin Ian King <colin.king@canonical.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 7, 2021 at 11:21 AM Kees Cook <keescook@chromium.org> wrote:
>
> So the question is likely, "do we want this for /dev/zero?"

Well, /dev/zero should at least be safe, and I guess it's actually
interesting from a performance testing standpoint (ie useful for some
kind of "what is the overhead of the splice code with no data copy").

So I'll happily take a sane patch for /dev/zero, although I think it
probably only makes sense if it's made to use the zero page explicitly
(ie exactly for that "no data copy testing" case).

So very much *not* using generic_file_splice_read(), even if that
might be the one-liner.

/dev/zero should probably also use the (already existing)
splice_write_null() function for the .splice_write case.

Anybody willing to look into this? My gu feel is that it *should* be easy to do.

That said - looking at the current 'pipe_zero()', it uses
'push_pipe()' to actually allocation regular pages, and then clear
them.

Which is basically what a generic_file_splice_read() would do, and it
feels incredibly pointless and stupid to me.

I *think* we should be able to just do something like

    len = size;
    while (len > 0) {
        struct pipe_buffer *buf;
        unsigned int tail = pipe->tail;
        unsigned int head = pipe->head;
        unsigned int mask = pipe->ring_size - 1;

        if (pipe_full(head, tail, pipe->max_usage))
            break;
        buf = &pipe->bufs[iter_head & p_mask];
        buf->ops = &zero_pipe_buf_ops;
        buf->page = ZERO_PAGE(0);
        buf->offset = 0;
        buf->len = min_t(ssize_t, len, PAGE_SIZE);
        len -= buf->len;
        pipe->head = head+1;
    }
    return size - len;

but honestly, I haven't thought a lot about it.

Al? This is another of those "right up your alley" things.

Maybe it's not worth it, and just using generic_file_splice_read() is
the way to go, but I do get the feeling that if we are splicing
/dev/null, the whole _point_ of it is about benchmarking, not "make it
work".

            Linus
