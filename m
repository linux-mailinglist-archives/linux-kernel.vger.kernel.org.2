Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9AC45139D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 20:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348513AbhKOTxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 14:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239535AbhKOSBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 13:01:12 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A00C0431AB
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:30:40 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id m11so17556846ilh.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bRo3GfQOGlOhHmaugQGUBVx0FY3UaFOwwxtB2WLL1m0=;
        b=dW48OQ8ehZyO95PbFFOxefMxz46NPJTlhyBo89wN4Em78JpxWG/hlPsJloMu5NFX4B
         WOvvjWtiM95F/K1nALrX+E38n5oJKavkMKvrhL63PdjFIsTca1jW28TjMn7lSlmjPnBy
         25CVv0btP/k3kSTRJL3EWzg/nCxXdVsFgpoLZlSi3celhzFEyOj/6K58sneg/2Z5XXgx
         iDA/8m/BONh94izIOefnYYo6qyLHuhh8fZcx0Q0JIGoMw3cErEOpxqKCJBLqW3DNjlyr
         wXvOi7hpqnoWVJ9ENfc4ep9XXGoUUZKlMDNau+RkkbeO6R5O/N/WDsLGupzckrtQrDDr
         ptPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bRo3GfQOGlOhHmaugQGUBVx0FY3UaFOwwxtB2WLL1m0=;
        b=Aghg3yxBcA3CWQARHcX34dMKIcVn+ssUOvQSyERX4IXUoNdck4H1jsd6LruAqKZhv3
         x8y6cHCEtsEWpBKKSzOmtPoX7jQ15I6uKirMQAeZKeIa6/F4pFbxkUej25rH4U5/9SYS
         8sqM3LIjVU1WQrE5POVGtS7EKTRcPocF27ffNsdtPM+3EiIMKUqNpJmORoIr6g6NHxDu
         llYJp4gbLAsn1JI4NYjBbiR6IZ2h+IoeW7GCiarBxowhFTBKEXCEZcTTlmvBjM/HLjzi
         F/fldjtTQJMvC4jzYiYKBCg06X45VOyEbHRbH3z+VORzly5Gg3GenG1lLLlndteTTvIv
         QiGw==
X-Gm-Message-State: AOAM5323OJ6D8RltfaNz+eOe9k65zSrWY99B8nfp2RIdMq1zx1R0nPpr
        QjyAerjk8N4qpbm6xw40V3wVtU6QkJ7SWeB+gvFsTg==
X-Google-Smtp-Source: ABdhPJy2ruumXwxbQrfcFbvhtZCK60alnu6mTjKjgWpgw0gK6M6Nrqr7/7IhT4CpxCB0nXit7Ju1DkI6CVgqkvuSXSk=
X-Received: by 2002:a05:6e02:1c2a:: with SMTP id m10mr333030ilh.275.1636997439405;
 Mon, 15 Nov 2021 09:30:39 -0800 (PST)
MIME-Version: 1.0
References: <20211115135219.85881-1-peterx@redhat.com>
In-Reply-To: <20211115135219.85881-1-peterx@redhat.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Mon, 15 Nov 2021 09:30:01 -0800
Message-ID: <CAJHvVciEV1uU=3ZmYB7V3uEa04SUzeqh8Ljvovz0t2huEAF19g@mail.gmail.com>
Subject: Re: [PATCH] selftests/uffd: Allow EINTR/EAGAIN
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks correct to me!

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

On Mon, Nov 15, 2021 at 5:52 AM Peter Xu <peterx@redhat.com> wrote:
>
> This allow test to continue with interruptions like gdb.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tools/testing/selftests/vm/userfaultfd.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index 8a09057d2f22..64845be3971d 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -644,7 +644,7 @@ static int uffd_read_msg(int ufd, struct uffd_msg *msg)
>
>         if (ret != sizeof(*msg)) {
>                 if (ret < 0) {
> -                       if (errno == EAGAIN)
> +                       if (errno == EAGAIN || errno == EINTR)
>                                 return 1;
>                         err("blocking read error");
>                 } else {
> @@ -720,8 +720,11 @@ static void *uffd_poll_thread(void *arg)
>
>         for (;;) {
>                 ret = poll(pollfd, 2, -1);
> -               if (ret <= 0)
> +               if (ret <= 0) {
> +                       if (errno == EINTR || errno == EAGAIN)
> +                               continue;
>                         err("poll error: %d", ret);
> +               }
>                 if (pollfd[1].revents & POLLIN) {
>                         if (read(pollfd[1].fd, &tmp_chr, 1) != 1)
>                                 err("read pipefd error");
> --
> 2.32.0
>
