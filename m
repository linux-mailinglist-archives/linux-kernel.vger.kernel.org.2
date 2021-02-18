Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395CC31E45F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 03:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhBRCqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 21:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhBRCqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 21:46:12 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17365C061574
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 18:45:32 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id i8so535909iog.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 18:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=issyEretnL4YU2kc5lxIH+N6UN/Vgx9OGH50vdazNXE=;
        b=Hf+CKR137/YutetOFvzRBciuBJbeM9jnIdPvZuqG2RuNCHzSb7wUikgjha8dk6vn+I
         iA5RnH4eakgcSPeWczlrUF45kMb0Q0qIzVi/dM2CaUGBT9CB4DG0dZQdYDZrn6y6lGSF
         mMDcyIX9luLoDnfVaMncmu4U4EW5UvLdD+lqiecFXhYB6GkSR/V3oTMV/BX7Zy/7ORqX
         HEfJET70C0xD708s7ZpO5m3bibM55cKprvD9LjWGYAetp0d5FnF7KUhewJDEoLutg1Ks
         AY9HeqJISJ/rsOuj7rS8G1UJA06INpaymDhK9JMcYRvdb3FCCPlOEYg/yQBHzp2A1omE
         3/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=issyEretnL4YU2kc5lxIH+N6UN/Vgx9OGH50vdazNXE=;
        b=KYrRWAOkGfoi5a96A9dfMhPOc0Pnn2izr1EG4qtN/n2NncZBrGMcMjivQ2vjviCzl9
         MR+U4ygIRb6aipGDzgOqjHU9l1PPGbqUpUNAtiLw/r1vsqhs3tbbOWeEASvBpn1B64Vd
         5XvJxlATNN1eKEFZwOStRHRHp2O+7QK+k9evrz2cMitAWPSGlf7Ad7qpKOp12+cczHXY
         N6t1+O2vRQQLvjcsAHHa5X9z8GwGgOHgXCc+bK/udgIHMLSfZPXz3XJ09QaVvJVQUtte
         TbXgdM4GZ+BNiXEo39gvFQbvJUDF3TZpDsiIIdSoAzkYJ9sQSoQdswkwp5BDfoiUWLC9
         uLIw==
X-Gm-Message-State: AOAM531WUar6sQe3JbC2ffZ98JrE2BRGs6E4X7wEqyxrOZJ7ANhfV6Sf
        ly22m6GzCanXYO4HWbeaZhCEyOvBDjdtKlwvfeQ=
X-Google-Smtp-Source: ABdhPJxS18hXSDOwZ9BmD01EpGC+Ld0UCKo05Ymq/5bJ84evRO8TNXuinvP+71p1DTbYtu6k93SFTl69txoXCiMy8LY=
X-Received: by 2002:a02:3948:: with SMTP id w8mr2433084jae.43.1613616331363;
 Wed, 17 Feb 2021 18:45:31 -0800 (PST)
MIME-Version: 1.0
References: <20210211082351.178536-1-qiang.zhang@windriver.com>
In-Reply-To: <20210211082351.178536-1-qiang.zhang@windriver.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 18 Feb 2021 10:45:20 +0800
Message-ID: <CAJhGHyA6gtufYfZ5CmFnS-Uyu8VC0G9uFoiJQO6-ZTTUBB-eXQ@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Move the position of debug_work_activate() in __queue_work()
To:     "Zhang, Qiang" <qiang.zhang@windriver.com>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 4:24 PM <qiang.zhang@windriver.com> wrote:
>
> From: Zqiang <qiang.zhang@windriver.com>
>
> The debug_work_activate() is called on the premise that
> the work can be inserted, because if wq be in WQ_DRAINING
> status, insert work may be failed.
>

Please add:
Fixes: e41e704bc4f49 ("workqueue: improve destroy_workqueue() debuggability")

The code looks good to me.

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

> Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> ---
>  kernel/workqueue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 0d150da252e8..21fb00b52def 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1412,7 +1412,6 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
>          */
>         lockdep_assert_irqs_disabled();
>
> -       debug_work_activate(work);
>
>         /* if draining, only works from the same workqueue are allowed */
>         if (unlikely(wq->flags & __WQ_DRAINING) &&
> @@ -1494,6 +1493,7 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
>                 worklist = &pwq->delayed_works;
>         }
>
> +       debug_work_activate(work);
>         insert_work(pwq, work, worklist, work_flags);
>
>  out:
> --
> 2.25.1
>
