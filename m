Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95545375C0C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 21:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhEFTzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 15:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhEFTzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 15:55:00 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A248C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 12:54:01 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 124so9517405lff.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 12:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=30CCgRPWxvchjmWLKh8S/1Eg8MBxi4LpEXBf19yEkNs=;
        b=YTAkjewGOi8gt2P1w9sSLqLI3jPEmSoeaw8J5R7o5y2n0/novjCZG8DgFeNcJFafxS
         pso4Y5zjbzcLxnWTb9s7WTyQ3iVM3JMXus0vYj/qlxLIEa8yqWjfwZfsOF1dq/uAhmpi
         espfpwFokGkbu2llorB4ly3wSvfyMzsC7mckEyHMeFQg5yx5KTgvgYin9VgnVxss2oQy
         8wYObbk/dYQXhPB2iXpcC7Mx4kou2ZiSf7WES0hOZsUq7PLnufpDl2c5ztN9Tw7jxr9a
         SO/89Z6jR/CRLfauuuVzNDqvqKXFuyhrakl4W0up0/oWcGeQSfkrtcTFEjXVtUHkmol9
         7O5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=30CCgRPWxvchjmWLKh8S/1Eg8MBxi4LpEXBf19yEkNs=;
        b=H1APgr9B0vlXQE/eXaMzYHnU6BGS6m/cP1QgzgJMPQaKHlx+6WxAG0NP57XJnbIeOb
         5oo11Ezj8TJOZj3Ohwt5hGkuBt4Iv5euN9m9hcpm8mlcrHvace/8Q953sd3/kQzCTHpb
         cN1lq1xFle75Zu6tRr3FrMP7e5p64C5KASRXMm+dxyWY4GS6Runm4IKQ+RZpxRCfjqFD
         8j7eJ/bS9dw24lViKEqzdmdO4Ql3rRUApJV+6Kob5K9AiUI+ueMwshKGtmsbBiHlii6P
         995t9pLN9b7v41xncoB+gGBihHAS9uTq5d2o2NUTTPWnrSmkn9TtdnQMZifsabgBqH4l
         d1rA==
X-Gm-Message-State: AOAM531Qw+lm/64lVyOyN37mycT7s836w76Iica+z1uUDRVYU1uXQb/Q
        +icbB1smS4t8Je9/aFFcrpFyWVNND0T3ZLjBI4chmA==
X-Google-Smtp-Source: ABdhPJzfQQtyEEHoP5goPbCYkjIaEtd1HoZpMtF8BFgu+FpVm3DVGo90OJaVgrn2MYtujN0YmtYQaZA7FRWn1Fbd248=
X-Received: by 2002:a05:6512:104d:: with SMTP id c13mr4167245lfb.59.1620330838982;
 Thu, 06 May 2021 12:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210506193726.45118-1-luca.stefani.ge1@gmail.com>
In-Reply-To: <20210506193726.45118-1-luca.stefani.ge1@gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Thu, 6 May 2021 12:53:45 -0700
Message-ID: <CAHRSSEz3=xUwFay0coYv+xC8xi54kAJkkTUOMYfotAV_AEQ00g@mail.gmail.com>
Subject: Re: [PATCH] binder: Return EFAULT if we fail BINDER_ENABLE_ONEWAY_SPAM_DETECTION
To:     Luca Stefani <luca.stefani.ge1@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Hang Lu <hangl@codeaurora.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 6, 2021 at 12:37 PM Luca Stefani <luca.stefani.ge1@gmail.com> wrote:
>
> All the other ioctl paths return EFAULT in case the
> copy_from_user/copy_to_user call fails, make oneway spam detection
> follow the same paradigm.
>
> Fixes: a7dc1e6f99df ("binder: tell userspace to dump current backtrace
> when detected oneway spamming")
> Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 61d34e1dc59c..bcec598b89f2 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -4918,7 +4918,7 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>                 uint32_t enable;
>
>                 if (copy_from_user(&enable, ubuf, sizeof(enable))) {
> -                       ret = -EINVAL;
> +                       ret = -EFAULT;
>                         goto err;
>                 }
>                 binder_inner_proc_lock(proc);
> --
> 2.31.1
>
