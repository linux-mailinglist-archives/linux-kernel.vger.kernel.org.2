Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4327843F411
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 02:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhJ2AqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 20:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhJ2AqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 20:46:02 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F09C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 17:43:34 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id v64so13421755ybi.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 17:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W2sy9b06AAoqRje0Ctkj6Www73b/rcNnA5x0L9/UX24=;
        b=osfMTnSDFdSoxQMi2MmCecni4PyI67lbooODz48BxYWr1pwuE0/PX4UF0WK+KoSkSY
         wGpPs4cVmKT5VDujNetRIUd1AdMGsxJyaFDCn8V55Umw63HDY45H858hK0pVZ8mxMV/k
         qUz9YsmW2SQ7qFalwdw8/o7v9oOiYNiYpo6Tm6DAVmJJJlceIL2b7aIkDWLSoh+lrSof
         V9Ev6Ns9rjz+wfQ2DDu1hFxyD4Jf77ZZ0T9kgj6TvLJ54KqJV7RxZXCQe17W+lRB+PDY
         4PYQf2E8LgTU+0yLY5GyygG7U1hJxMOi1wmpUJu04J2aJDgy76W5n13/xeKP13QSeAKa
         5mkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W2sy9b06AAoqRje0Ctkj6Www73b/rcNnA5x0L9/UX24=;
        b=0jCPGfrcQnItSGVJ9k0bEd7ZTaNkaU1odrSIIrQ0w6qtv6yoZZr5IhGkLHuHPhdZ3V
         zIgDgbOkwuNtksZ5gYwboqjFNfavYFJYFjQv44X0zAEUv0r3jzy88fsTnyFTPuv85nPU
         seZZtRv2fEGrm7sSx7IO6L0D3Ekq9M1aRLe9Z/8ncCk7LkvuIhPRwKys8dlxu9t8/4cs
         K5Yh47thZJ12Bj05a+JiY6wfE0k0R8zHjUClpK7zOtr7Hwdci0oIKLO52w9xd5JJdWf2
         VoIKnhFIlmuxXslI8uP8JAP73xHEw+HB8e8Wie7W1O4Q6fbyQsAauJhrlZJiivQWt24f
         zPKA==
X-Gm-Message-State: AOAM531ktUsnXPASgynDYg9SihegdPOdkfFXDWVomR9FxYpQ2JilMye6
        va7KX79T4XL+MNV/k+QxVkofHYmSjT60hia0JexSfg==
X-Google-Smtp-Source: ABdhPJwNox5NrYrfvm37cnp2haAAo9v6DPFpH4WK42VlmRPgngm67ZOV5PVSYD5rQEW4YQAocdZjhMHu6kvrWdg84Hg=
X-Received: by 2002:a25:50d2:: with SMTP id e201mr7747127ybb.296.1635468213277;
 Thu, 28 Oct 2021 17:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <9ac22d4d-c841-651a-fdd5-9fb3a65c57ab@gmail.com>
 <e72cdd44-c027-e51c-8b57-24f39bf21d87@kernel.dk> <3b7dbb90-7fd5-d30f-cfe0-dd83f2cd4482@kernel.dk>
In-Reply-To: <3b7dbb90-7fd5-d30f-cfe0-dd83f2cd4482@kernel.dk>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 28 Oct 2021 17:43:20 -0700
Message-ID: <CANn89iJv6cRbK95Gwj=rrz2+X+Q4KQ7EtEcpz0Md0Vs1_iABPw@mail.gmail.com>
Subject: Re: [BUG] About "io_uring: add more uring info to fdinfo for debug"
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Hao Xu <haoxu@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 5:13 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 10/28/21 3:40 PM, Jens Axboe wrote:
> > On 10/28/21 3:24 PM, Eric Dumazet wrote:
> >> Hi
> >>
> >> I was looking at commit 83f84356bc8f2d
> >> ("io_uring: add more uring info to fdinfo for debug") after receiving
> >> syzbot reports.
> >>
> >> I suspect that the following :
> >>
> >> +       for (i = cached_sq_head; i < sq_tail; i++) {
> >> +               unsigned int sq_idx = READ_ONCE(ctx->sq_array[i & sq_mask]);
> >> +
> >> +               if (likely(sq_idx <= sq_mask)) {
> >> +                       struct io_uring_sqe *sqe = &ctx->sq_sqes[sq_idx];
> >> +
> >> +                       seq_printf(m, "%5u: opcode:%d, fd:%d, flags:%x, user_data:%llu\n",
> >> +                                  sq_idx, sqe->opcode, sqe->fd, sqe->flags, sqe->user_data);
> >> +               }
> >> +       }
> >>
> >>
> >> Can loop around ~2^32 times if sq_tail is close to ~0U
> >>
> >> I see various READ_ONCE(), which are probably not good enough.
> >>
> >> At very minimum I would handling wrapping...
> >
> > Thanks for reporting this. I think on top of wrapping, the loop should
> > just be capped at sq_entries as well. There's no point dumping more than
> > that, ever.
> >
> > I'll take a stab at this.
>
> I'd probably do something like this - make sure wrap is sane and that we
> always cap at the max number of entries we expect. This doesn't quite
> hold true for CQEs, but honestly for debugging purposes, we only really
> care about the sq ring side in terms of stalls. Or if we have unreaped
> CQEs, which we'll still show.
>
> This also removes the masking, as it's better to expose the ring indexes
> directly. And just dump the raw ring head/tail for sq/cq. We still
> include the cached info, but I think dumping the raw contents is saner
> and more useful.
>
>
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 17cb0e1b88f0..babd9950ae9f 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -10065,12 +10065,11 @@ static __cold void __io_uring_show_fdinfo(struct io_ring_ctx *ctx,
>         struct io_overflow_cqe *ocqe;
>         struct io_rings *r = ctx->rings;
>         unsigned int sq_mask = ctx->sq_entries - 1, cq_mask = ctx->cq_entries - 1;
> -       unsigned int cached_sq_head = ctx->cached_sq_head;
> -       unsigned int cached_cq_tail = ctx->cached_cq_tail;
>         unsigned int sq_head = READ_ONCE(r->sq.head);
>         unsigned int sq_tail = READ_ONCE(r->sq.tail);
>         unsigned int cq_head = READ_ONCE(r->cq.head);
>         unsigned int cq_tail = READ_ONCE(r->cq.tail);
> +       unsigned int sq_entries, cq_entries;
>         bool has_lock;
>         unsigned int i;
>
> @@ -10080,15 +10079,19 @@ static __cold void __io_uring_show_fdinfo(struct io_ring_ctx *ctx,
>          * and sq_tail and cq_head are changed by userspace. But it's ok since
>          * we usually use these info when it is stuck.
>          */
> -       seq_printf(m, "SqHead:\t%u\n", sq_head & sq_mask);
> -       seq_printf(m, "SqTail:\t%u\n", sq_tail & sq_mask);
> -       seq_printf(m, "CachedSqHead:\t%u\n", cached_sq_head & sq_mask);
> -       seq_printf(m, "CqHead:\t%u\n", cq_head & cq_mask);
> -       seq_printf(m, "CqTail:\t%u\n", cq_tail & cq_mask);
> -       seq_printf(m, "CachedCqTail:\t%u\n", cached_cq_tail & cq_mask);
> -       seq_printf(m, "SQEs:\t%u\n", sq_tail - cached_sq_head);
> -       for (i = cached_sq_head; i < sq_tail; i++) {
> -               unsigned int sq_idx = READ_ONCE(ctx->sq_array[i & sq_mask]);
> +       seq_printf(m, "SqMask:\t\t0x%x\n", sq_mask);
> +       seq_printf(m, "SqHead:\t%u\n", sq_head);
> +       seq_printf(m, "SqTail:\t%u\n", sq_tail);
> +       seq_printf(m, "CachedSqHead:\t%u\n", ctx->cached_sq_head);
> +       seq_printf(m, "CqMask:\t0x%x\n", cq_mask);
> +       seq_printf(m, "CqHead:\t%u\n", cq_head);
> +       seq_printf(m, "CqTail:\t%u\n", cq_tail);
> +       seq_printf(m, "CachedCqTail:\t%u\n", ctx->cached_cq_tail);
> +       seq_printf(m, "SQEs:\t%u\n", sq_tail - ctx->cached_sq_head);
> +       sq_entries = min(sq_tail - sq_head, ctx->sq_entries);
> +       for (i = 0; i < sq_entries; i++) {
> +               unsigned int entry = i + sq_head;
> +               unsigned int sq_idx = READ_ONCE(ctx->sq_array[entry & sq_mask]);
>
>                 if (likely(sq_idx <= sq_mask)) {
>                         struct io_uring_sqe *sqe = &ctx->sq_sqes[sq_idx];
> @@ -10097,9 +10100,11 @@ static __cold void __io_uring_show_fdinfo(struct io_ring_ctx *ctx,
>                                    sq_idx, sqe->opcode, sqe->fd, sqe->flags, sqe->user_data);
>                 }
>         }
> -       seq_printf(m, "CQEs:\t%u\n", cached_cq_tail - cq_head);
> -       for (i = cq_head; i < cached_cq_tail; i++) {
> -               struct io_uring_cqe *cqe = &r->cqes[i & cq_mask];
> +       seq_printf(m, "CQEs:\t%u\n", cq_tail - cq_head);
> +       cq_entries = min(cq_tail - cq_head, ctx->cq_entries);
> +       for (i = 0; i < cq_entries; i++) {
> +               unsigned int entry = i + cq_head;
> +               struct io_uring_cqe *cqe = &r->cqes[entry & cq_mask];
>
>                 seq_printf(m, "%5u: user_data:%llu, res:%d, flag:%x\n",
>                            i & cq_mask, cqe->user_data, cqe->res, cqe->flags);

Note : you probably want to replace  (i & cq_mask) to (entry & cq_mask) here

Otherwise, patch looks good to me.

>
> --
> Jens Axboe
>
