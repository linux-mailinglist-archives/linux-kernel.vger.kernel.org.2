Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9523AA8F0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 04:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhFQCZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 22:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbhFQCZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 22:25:06 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F61C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 19:22:59 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id m21so7598194lfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 19:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ywwa6u4sTr+zeKk1ysqTC07YLMqs/Myvu552O+A55QU=;
        b=QjibWlabOJRVrWNgl08ALqiFaEWwJeHYkyJvTOYvbOgmMApForHbVK/L05PvyKykI6
         EoDSni/cyCwbBIz5A+6nkDgtG3sQDXjPYB/2Vt+5LnYzsoTuWWv0/3xkI/6khmhlqW7H
         uBoT8aheuvMXMV+/q5jiPWV5UJkaXfDYMbUxz+7RQRJi9W8YqwfY/T+X696Oww8Dog+c
         o7i9y6qjbmJnIfFBaTxqMgd/sLKKhKZvpdfZzCE2GSXlajQbhMivpoSmTY2EXPND/wR8
         HZGlMYuBS961BprJxHfbZBpfFtskCEA53B3K/Jzi9hgOl1S/50uksnHka6qeKwuGQcqS
         SCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ywwa6u4sTr+zeKk1ysqTC07YLMqs/Myvu552O+A55QU=;
        b=EEeJnssOu/HzYFBNVTuxOJ76sx0OijHOHAif8DghKWKFIoFEJsHFaoN7jr6ZjnvD6R
         MC2TcSISyJFJvU1dprxl+KKOyPunq03oBiE8GOaayTLH3IoL8S5yspOSccE5/rl74GRq
         +Wko+yCFamaJh02wO6E4qyv2wWoJ/zwb1MgDxZkUgOG/rxRW4GuKsNznQH2ZEQasXKGT
         /JIyw/NRxKwnYAV2+69CMmlFag9fgdtAkbnyb7Pw4JMK6UCxVyEnQ7hNCU7fYKULawuD
         ry63ZABu5fl6qIqsnOlDp4qrUgbguXveEx0dii1ifWjbXTEiSyPBy6n++WYejq30NT3P
         OCGA==
X-Gm-Message-State: AOAM5335ws4rKHZnvkJXZCvcdg294rniDD4dqpV7qpC8QMaYoLyOvBTZ
        Hrqp+pgdssvnxjUxEYuLNKnQzythohf1lHhSvW8=
X-Google-Smtp-Source: ABdhPJzTqo9j3T6yaf6+sND79wnPEhuqbVPO8UyBOnw92SeR8HhgdeU6H27MqMC7rXKv8zsjH/K8h8YNqqPjKk+vMV0=
X-Received: by 2002:ac2:419a:: with SMTP id z26mr2095725lfh.307.1623896577716;
 Wed, 16 Jun 2021 19:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210616144210.278662-1-sxwjean@me.com> <20210616144210.278662-2-sxwjean@me.com>
In-Reply-To: <20210616144210.278662-2-sxwjean@me.com>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Thu, 17 Jun 2021 10:22:30 +0800
Message-ID: <CAEVVKH8n5ntPVOP=X9bPGoK4xdE-Z-XHKSFsoGOaLpke+uZoqg@mail.gmail.com>
Subject: Re: [PATCH] locking/lockdep: print possible warning after counting deps
To:     Xiongwei Song <sxwjean@me.com>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, Boqun Feng <boqun.feng@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this patch. I will resend as  Longman's suggestions.
Please see https://lkml.org/lkml/2021/6/16/949.

Regards,
Xiongwei


On Wed, Jun 16, 2021 at 10:42 PM Xiongwei Song <sxwjean@me.com> wrote:
>
> From: Xiongwei Song <sxwjean@gmail.com>
>
> The graph walk might hit error when counting dependencies. Once the
> return value is negative, print a warning to reminder users.
>
> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> ---
>  kernel/locking/lockdep.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 7641bd407239..074fd6418c20 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -2028,8 +2028,12 @@ static unsigned long __lockdep_count_forward_deps(struct lock_list *this)
>  {
>         unsigned long  count = 0;
>         struct lock_list *target_entry;
> +       enum bfs_result ret;
> +
> +       ret = __bfs_forwards(this, (void *)&count, noop_count, NULL, &target_entry);
>
> -       __bfs_forwards(this, (void *)&count, noop_count, NULL, &target_entry);
> +       if (unlikely(bfs_error(ret)))
> +               print_bfs_bug(ret);
>
>         return count;
>  }
> @@ -2053,8 +2057,12 @@ static unsigned long __lockdep_count_backward_deps(struct lock_list *this)
>  {
>         unsigned long  count = 0;
>         struct lock_list *target_entry;
> +       enum bfs_result ret;
> +
> +       ret = __bfs_backwards(this, (void *)&count, noop_count, NULL, &target_entry);
>
> -       __bfs_backwards(this, (void *)&count, noop_count, NULL, &target_entry);
> +       if (unlikely(bfs_error(ret)))
> +               print_bfs_bug(ret);
>
>         return count;
>  }
> --
> 2.30.2
>
