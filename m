Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D209544F718
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 08:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhKNHSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 02:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhKNHSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 02:18:22 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53381C061746
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 23:15:28 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id e3so20166015edu.4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 23:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bDLqVMD46uiMsWehvbC08aW5fVyYhTP1JwwUyTmh/Z8=;
        b=yLVowLrs6mCkTdQfHv7zS1ONJi082eZCq1Aari0B2GrOvsxpws3h8DvcOPkHOb3EiH
         vSYXNoDoBnHjgy7Yy7DqqH+u/jv5zPGmaHF6NdQOiQNjOepnrHS6DlBn0rl+SfHah3RL
         5z3IH6fZzC1MJLrPW2sWizYzIhYb3zvL+8n/UVpDmLHiPj2nb+8Fy2xpM9ZQSjUEv31r
         Ad3lwsvy3z1x5AsZZ/qEi4ug7qebXz/Rdp73+EcEiggDfy5zELRWD4LbeWABVlFo6huQ
         +gwyNzupKmYw6hQBfysEHiZzWKj1uQeN8URhmAKX2Zf16ASRx0xfl3uME8yUKPmb/IdO
         GNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bDLqVMD46uiMsWehvbC08aW5fVyYhTP1JwwUyTmh/Z8=;
        b=Vi/0FVpIvg95iUWq1OaZ7n3EaTwgHn3DGz8iFSHRT1xMrmaJ/31682wXHk50kMwQjO
         RAZe5KekyeHOd045kwUP/MJ+BG+P7cJn6KRMgdnx/3/VxXOSUCvc0ie8QP4kthAxNjlV
         E1UqrZvdY7xir+NNIuT1psuwjBWJVlS0L6oUv0MuuNnOmNpTZLB5mPKeM267QfqvWtpm
         gj6Cy3rHGQljzpKqs5m1Fo4SWSjQFNcCEak3jXem0FLETaCSd8upM2O3HBHjN06kyL9x
         qhj6HFyPnuAHf96I5Sf83z86qA5ybj72RdX2Wh8FbVWZoZil9P+WsZ1Uz3u5sBKnKqIZ
         omsw==
X-Gm-Message-State: AOAM5302w/qXwXcTsl7C1ODm8aGZj8XHmuwCOmdxvrGmTSPm4SiqAI/T
        UZRx/cU60Ojb8gVJwlIF24bb2ziOhsBGAOZY8cieLfmRfw==
X-Google-Smtp-Source: ABdhPJwys5QCeONa+O77IsHuk8ZQoANDuLgPaz85EZaoDnCk2VJAxVAqGJNqA9Cx1ehqJo7gDi6VvDKgP5gZtUM2+SI=
X-Received: by 2002:aa7:d80d:: with SMTP id v13mr14429309edq.7.1636874126935;
 Sat, 13 Nov 2021 23:15:26 -0800 (PST)
MIME-Version: 1.0
References: <20210913111928.98-1-xieyongji@bytedance.com>
In-Reply-To: <20210913111928.98-1-xieyongji@bytedance.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Sun, 14 Nov 2021 15:15:17 +0800
Message-ID: <CACycT3ugx-wwPVb+Euzhj6hWn0fXO+jvfsUCew6v1iBaB8SZsQ@mail.gmail.com>
Subject: Re: [PATCH] aio: Fix incorrect usage of eventfd_signal_allowed()
To:     bcrl@kvack.org, Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping

On Mon, Sep 13, 2021 at 7:20 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> We should defer eventfd_signal() to the workqueue when
> eventfd_signal_allowed() return false rather than return
> true.
>
> Fixes: b542e383d8c0 ("eventfd: Make signal recursion protection a task bit")
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  fs/aio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/aio.c b/fs/aio.c
> index 51b08ab01dff..8822e3ed4566 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1695,7 +1695,7 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
>                 list_del(&iocb->ki_list);
>                 iocb->ki_res.res = mangle_poll(mask);
>                 req->done = true;
> -               if (iocb->ki_eventfd && eventfd_signal_allowed()) {
> +               if (iocb->ki_eventfd && !eventfd_signal_allowed()) {
>                         iocb = NULL;
>                         INIT_WORK(&req->work, aio_poll_put_work);
>                         schedule_work(&req->work);
> --
> 2.11.0
>
