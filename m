Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD71391D29
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 18:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbhEZQiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 12:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbhEZQiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 12:38:17 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F44C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 09:36:46 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso1562304otu.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 09:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PqiiB2G3pVfVu3uT5QnRvz4iGCt2i0rxruRa8X05O5A=;
        b=AIMczX2yp7RTipMdxkCl+Y/HpljemIuaEY6JBpbtxDIFufKjOkMt7Az9akxHPBlRrF
         tv5THCfwxaArndbv36+qeYJ3AL4CuIfPs4SpXW6HFTPsWpSZCq+Xd/x5z2u/IADP7pX8
         E9I3kby1gka6PAXCHMleSaOk/lvn2+P9ORVzEqG9R8/UZcIVIHPUaEvMqWSrTaJ5GsyH
         lt1r2/k17Ht/VrZL0Q68620TUD2FAbpa3Rknm6sKc4oLYymxiC09tCQ7L5hG8hoF4587
         s7Gmr92x1Dra8L0a4mbvdlwqufQN4FUkY3L+Mbr67iuZhwDdYI7ZkKQcTZ5rPXOws5jd
         hz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PqiiB2G3pVfVu3uT5QnRvz4iGCt2i0rxruRa8X05O5A=;
        b=jWNvLVYSdb19XXttP7nFJmmYgCswGKo2JFq9YzwWkPXC3qBIZxvVz6PYWirsZIPEFx
         WETKqPHi/c6FUR5C4Msmo9m8CTFN+ckNaLcgFeBZBNli+a6gQvBqT+HElW+aZvwmEpOO
         IKd4NdPuLYTT+UCGNSeROO/BSH5mZWkiEieGhoQnbKJcK5n0T6cq02UAx179lS4LUVlR
         eJOdV7kr1hn4YLkgNPykq2xlb8DCcIGixwipdaN8QQHrIE9Q309eItvqNYTBEmWnqAOQ
         v1EESmBSr/GuP6pbD49mjO/P+6E7s+3N/+MrpTjWnO5qlwqO8uOmyMsdjrf51G8GyrOd
         be9g==
X-Gm-Message-State: AOAM532PdcNcW/57LLLse3Q54IqmjYWAKgm8a2jnIn6g+ZtXKhYEMo7y
        FBC6SG1vm8j4NeoKssKeVwd33cNKdP4lNa9OV+FRpe0SY2f0Ag==
X-Google-Smtp-Source: ABdhPJwRU8B/LoV6InTDOFtujtBx8Z2ldAmR4Mgo+9YcsIWTisl/DZn4f3BLX3/kcqduXoKFe7dWHTs2QFoxBLf51Jg=
X-Received: by 2002:a05:6830:3154:: with SMTP id c20mr3125482ots.233.1622047005273;
 Wed, 26 May 2021 09:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000fa9f7005c33d83b9@google.com> <YK5tyZNAFc8dh6ke@elver.google.com>
 <YK5uygiCGlmgQLKE@elver.google.com> <b5cff8b6-bd9c-9cbe-4f5f-52552d19ca48@gmail.com>
In-Reply-To: <b5cff8b6-bd9c-9cbe-4f5f-52552d19ca48@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 26 May 2021 18:36:33 +0200
Message-ID: <CANpmjNP1CKuoK82HCRYpDxDrvy4DgN9yVknfsxHSwfojx5Ttug@mail.gmail.com>
Subject: Re: [syzbot] KCSAN: data-race in __io_uring_cancel / io_uring_try_cancel_requests
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        syzbot <syzbot+73554e2258b7b8bf0bbf@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2021 at 18:29, Pavel Begunkov <asml.silence@gmail.com> wrote:
> On 5/26/21 4:52 PM, Marco Elver wrote:
> > Due to some moving around of code, the patch lost the actual fix (using
> > atomically read io_wq) -- so here it is again ... hopefully as intended.
> > :-)
>
> "fortify" damn it... It was synchronised with &ctx->uring_lock
> before, see io_uring_try_cancel_iowq() and io_uring_del_tctx_node(),
> so should not clear before *del_tctx_node()

Ah, so if I understand right, the property stated by the comment in
io_uring_try_cancel_iowq() was broken, and your patch below would fix
that, right?

> The fix should just move it after this sync point. Will you send
> it out as a patch?

Do you mean your move of write to io_wq goes on top of the patch I
proposed? (If so, please also leave your Signed-of-by so I can squash
it.)

So if I understand right, we do in fact have 2 problems:
1. the data race as I noted in my patch, and
2. the fact that io_wq does not live long enough.

Did I get it right?

Thanks,
-- Marco

> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 7db6aaf31080..b76ba26b4c6c 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -9075,11 +9075,12 @@ static void io_uring_clean_tctx(struct io_uring_task *tctx)
>         struct io_tctx_node *node;
>         unsigned long index;
>
> -       tctx->io_wq = NULL;
>         xa_for_each(&tctx->xa, index, node)
>                 io_uring_del_tctx_node(index);
> -       if (wq)
> +       if (wq) {
> +               tctx->io_wq = NULL;
>                 io_wq_put_and_exit(wq);
> +       }
>  }
>
>  static s64 tctx_inflight(struct io_uring_task *tctx, bool tracked)
>
>
> --
> Pavel Begunkov
