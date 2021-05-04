Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3443727B1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 11:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhEDJCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 05:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhEDJCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 05:02:40 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2266CC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 02:01:46 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id f24so11995874ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 02:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/BEtiHEyLUH0pHUzx4+zlxAJRANLxFJIE2T50Nx0vuQ=;
        b=eEhoA9OgAL3QwPqmzGoQ5J/vgDLmh59eBzeVStjZNQFW1WVZ7zmwHYS4bHjqXROkTJ
         oz9wR9HvE5nssKpODv77U8N+v1YdmKuEaYFNpob0ThWN/GzKV0lGeB4Q6e52PnxfV4k2
         Utlh6DJhVA+lhxwTqFyi88TlVxIIfwnm/io1tuMqEFrzApTRouEvUi1tJZ+CJZoXmEIR
         SUh43X7p+a1UL5HScIFnrFISbnOvhM1nvBXBcHv/pNgv1t84V0N5MuRleVz4X98zWEHE
         /E+vfo6TZ2AVLoLOIreuY5fkfEm/6FMoskfOlT/YIL/fXNZg0Nh0uu7KWEe7Vt0Svbg6
         C45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/BEtiHEyLUH0pHUzx4+zlxAJRANLxFJIE2T50Nx0vuQ=;
        b=RWvmx8wF2fQQbp45usfIDd9I6W1jsR5WMNK9c5/ptKUeg4Yr+VMP0aBnUGmeQYGFRr
         duIfiewE4LBNvi7w+kO3dEfNJGLqfs65zpFlqq9cyc7A0rb5B7UnQcGBDV1opTTZnmcQ
         snexphjhV7ig7bLAkqymaTDhGQiPKR0ufqj1YD3AjET9PPfPR/fu+8uhc0GQKgcEedRI
         rtzrgNUyx4LQ8oKpD+PTARjjYI+NdVJLxIVs3zrSx0xKnYaxgmmsrC3iwwuGv/KCOGrc
         XDC+7GRzUcwBHZ8xnhEO3F1vzrkLHn0HvKwfWMhH7SsQ+CCwpjtvIE2b0E9ei2Z8gVte
         scDA==
X-Gm-Message-State: AOAM530P6BYLA3pwUCjIQIh5vD12F4mwwl5nD0O/4EqHgdoh55xXIKtZ
        abP7+AQvuErdcPKwKk7EFRDd//NEFPBaaRgL6lMAhA==
X-Google-Smtp-Source: ABdhPJwYCCkP7QeC+gMHOoz7QkyDAFfSnVjkkSq44sDb0VpvaWMaw/HktvAxD5fp5zv08oi0tdNeJzF2poAgNO49GpE=
X-Received: by 2002:a17:906:2559:: with SMTP id j25mr20412002ejb.42.1620118904443;
 Tue, 04 May 2021 02:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210429130510.1621665-1-jackmanb@google.com> <CAEf4BzY7sx0gW=o5rM8WDzW1J0U_Yep3MMuJScoMg-hBAeBPCg@mail.gmail.com>
 <CA+i-1C2+Lt7kmwsZOEw6D8B_Lc+aJdZoUmPDh08+7y_uMNW+kA@mail.gmail.com> <CAEf4BzY1bftPAj_hjE4SBVv2P1U7twW3FdRsvNP9kPCMe_NOjA@mail.gmail.com>
In-Reply-To: <CAEf4BzY1bftPAj_hjE4SBVv2P1U7twW3FdRsvNP9kPCMe_NOjA@mail.gmail.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Tue, 4 May 2021 11:01:33 +0200
Message-ID: <CA+i-1C1V4b3LvB+pwDn5zomGG1ehSppX=r6TMfPutbgaoG_53Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] libbpf: Fix signed overflow in ringbuf_process_ring
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 May 2021 at 19:46, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Mon, May 3, 2021 at 5:01 AM Brendan Jackman <jackmanb@google.com> wrote:
> >
> > On Fri, 30 Apr 2021 at 18:31, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> So while doing that I noticed that you didn't fix ring_buffer__poll(),
> so I had to fix it up a bit more extensively. Please check the end
> result in bpf tree and let me know if there are any problems with it:
>
> 2a30f9440640 ("libbpf: Fix signed overflow in ringbuf_process_ring")

Ah, thanks for that. Yep, the additional fix looks good to me.

I think it actually fixes another very niche issue:

 int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms)
 {
-       int i, cnt, err, res = 0;
+       int i, cnt;
+       int64_t err, res = 0;

        cnt = epoll_wait(rb->epoll_fd, rb->events, rb->ring_cnt, timeout_ms);
+       if (cnt < 0)
+               return -errno;
+
        for (i = 0; i < cnt; i++) {
                __u32 ring_id = rb->events[i].data.fd;
                struct ring *ring = &rb->rings[ring_id];
@@ -280,7 +290,9 @@ int ring_buffer__poll(struct ring_buffer *rb, int
timeout_ms)
                        return err;
                res += err;
        }
-       return cnt < 0 ? -errno : res;

If the callback returns an error but errno is 0 this fails to report the error.

errno(3) says "the value of errno is never set to zero by any system
call or library function" but then describes a scenario where an
application might usefully set it to zero itself. Maybe it can also be
0 in new threads, depending on your metaphysical interpretation of "by
a system call or library function".

+       if (res > INT_MAX)
+               return INT_MAX;
+       return res;
