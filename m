Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFC13DDF07
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 20:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhHBSW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 14:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhHBSWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 14:22:25 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B482CC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 11:22:14 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a26so35270541lfr.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 11:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qEMNnzSOXFkx4zqOs12jH8ZYvFJqk18OmR+HJSOJ3W8=;
        b=MIXKdn7N1OctHmKnkjaXeGpZ7kxCpE5a9R8Sr/w5NP1d2hyTxn0YW6RnRf3Jmn6fkS
         k5VD3rULzx0+Y0G02giLP2xvLgl4RYMRrJiRQ7SHJgekX6G/BbQjKF1LaKNQppxqz/ir
         ZH4B12s4cMQ0S1cmBY60Qn4fM6aW+P5vEM2/BQh/HoYlmyXbqo/EWkGqeK245k5iMnMb
         mTIroyETOjUXYuVfHeTDFMujuzxvo1qaeHZnSAK9msf8dRCDgS1w0BqlVSiR0nqTbnDM
         fFBKDADVBS2dolO/2XIuCTuRs/IoQytJLB1jJWxb0N6vCG0BJ8ep6BU8R7frJQscjm7g
         rFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qEMNnzSOXFkx4zqOs12jH8ZYvFJqk18OmR+HJSOJ3W8=;
        b=UXoknadBNyfdMxM629UomGTvl6z/FFgbKNEP+058rkzQX+j2FZMMZR5UzKgAN7Sq6H
         DfBmnM41nshTrjVbnTnJryaMurAti+c5UW5ZuXHHS6YwMoXV8bz8y27umu06mfnElQJy
         UkWBlP137HjD2Azq9d1ATKOdnyO3C67Vqw+JYyW725r3JtzT8JxNMDmeCPFhLf4pKc2O
         7e2XBojsq0JCOi55lz+GAS9nhdDtzcRim0Espa8Kib+2y23ig309C+EyoqOVbvqaHrvq
         9JSlGUgbpmzcASikX891+fmrTNqP4CaSSLExZxiKzz/0mPbpYwIcjjVr1zzxuqZDg01v
         0DWA==
X-Gm-Message-State: AOAM533+9RSI/sbDuAvsRWQySgjho1lTSgFai5EmLISj4RuyVxziE9ZJ
        37qXrC4V3k3jFS0ZGLW1JGvtnl/IRgIpfCWJWz8+NA==
X-Google-Smtp-Source: ABdhPJxcYlGXtYmUroPjvcUEK5ZmY95Amr81xUD17/YhUMojtwlLtT0Bv1ZxTPAQaIVYfuHIgM1WAF+Mx2tHIFXoR0k=
X-Received: by 2002:ac2:4105:: with SMTP id b5mr13446968lfi.153.1627928532714;
 Mon, 02 Aug 2021 11:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210802174139.1908760-1-ramjiyani@google.com>
In-Reply-To: <20210802174139.1908760-1-ramjiyani@google.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Mon, 2 Aug 2021 11:22:01 -0700
Message-ID: <CAHRSSEzUcSpWxQzjhGoDsk3uTm=anFri2jHVKDoLrCXVY8i0WA@mail.gmail.com>
Subject: Re: [PATCH] binder: Add invalid handle info in user error log
To:     Ramji Jiyani <ramjiyani@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 2, 2021 at 10:41 AM 'Ramji Jiyani' via kernel-team
<kernel-team@android.com> wrote:
>
> In case of a fail transaction to the target node; user error log currently

nit: I'd rephrase this to something like  "In the case of a failed
transaction, only the thread and process id are logged. Add the handle
info..."

> only prints the thread and process id. Add handle info for the reference
> to the target node in user error log to aid debugging.
>
> Signed-off-by: Ramji Jiyani <ramjiyani@google.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index bcec598b89f2..d9030cb6b1e4 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2547,8 +2547,8 @@ static void binder_transaction(struct binder_proc *proc,
>                                                 ref->node, &target_proc,
>                                                 &return_error);
>                         } else {
> -                               binder_user_error("%d:%d got transaction to invalid handle\n",
> -                                                 proc->pid, thread->pid);
> +                               binder_user_error("%d:%d got transaction to invalid handle, %u\n",
> +                                                 proc->pid, thread->pid, tr->target.handle);
>                                 return_error = BR_FAILED_REPLY;
>                         }
>                         binder_proc_unlock(proc);
> --
> 2.32.0.554.ge1b32706d8-goog
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
