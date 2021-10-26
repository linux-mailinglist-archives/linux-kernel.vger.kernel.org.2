Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C01643B015
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbhJZKfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbhJZKfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:35:39 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52080C061767
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 03:33:15 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id d204so18238517ybb.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 03:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/K8qRfWz6WWnF1FBtemCSJ/+bgi/DzOjq0Ewdft0ykE=;
        b=ci1iwdu7guUxzCoYsuDdjBgySP8gXtcqkgQueGBwXsrDB8txBq1LcsLAIYwygM8tJV
         9eQ2gogUmsPJQSu6I3q4ouqvQKo7D0mSHEKw/2Xpo3C8la3OupZN4I+pYSECb3wRAZxX
         3y/pgn6kb01k9igShzYvVxv8AvhV3ikrHUKTF+KwCfKdBFb8+i0LINxFeHL+IkLyR0yz
         TmJ70h1aek3rnGwvcjDV8aQAA7ZpzQFJFTgMd/tb8D9x5lJUZ43htNIyq17p/BmFzD9l
         6rHpqEiPavWv63TdftPSHrZ11MyRD5unS8Ep0+Ss73sU8HMN5S7yMHE1t3sCkEHLfbck
         AF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/K8qRfWz6WWnF1FBtemCSJ/+bgi/DzOjq0Ewdft0ykE=;
        b=DIPlDFan1z0ePBVMhBXNihVIdidWu1y8UesjgrfiIBBS/clpunb5xi6xnjQ4lTOcPz
         w6NVQ9Ft6eQJbH1CO+miLdbybGo7e1CbZ1l+cn78hUS5iVPLz9PpWWx918b61w/1itJa
         I8Tsx/Z53qyL/36X1E6X61bTK9qsBgOFVRKZCbpIPqXijRo2yfVF5NK4W3e8No0hgzzc
         a1HlcGNFYmEcIEA1qoaByBQYu7M4uLcLmgbwZbTMnz3yOWkV+MYkMvDt6GaWdAEnEmP3
         NBE10Pa3Q5oMp30KzMC8AWLmHvezXrD9G0aEXE9mhfTs42Yw58xAui+gE8idPjl6Mcm8
         N0fw==
X-Gm-Message-State: AOAM530MU8VC3pbytGx6H8BROd29K2ZnlCo9BynBre6F9v1Wz4m9L24O
        FDt9QTfax6zw469J24NpaXEB2qob8uSWyYuh+N0+tmf1rfoM1Q==
X-Google-Smtp-Source: ABdhPJx0hMX0lwPetHg9MgsT5TyVvVJGwRpb9keYjE9mznzxA4MWUGRj85dix2FR3dP6TFMJ2nAFMyw6m9l06kb5EhY=
X-Received: by 2002:a25:fc08:: with SMTP id v8mr24492265ybd.404.1635244394513;
 Tue, 26 Oct 2021 03:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211026032304.30323-1-qiang.zhang1211@gmail.com>
In-Reply-To: <20211026032304.30323-1-qiang.zhang1211@gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 26 Oct 2021 18:32:38 +0800
Message-ID: <CAMZfGtUXq=nQyijktRaP7xp=sAmVCryTjU4Jo5Z=ufed8arnKQ@mail.gmail.com>
Subject: Re: [PATCH] io-wq: Remove unnecessary rcu_read_lock/unlock() in raw
 spinlock critical section
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, asml.silence@gmail.com,
        io-uring@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 11:23 AM Zqiang <qiang.zhang1211@gmail.com> wrote:
>
> Due to raw_spin_lock/unlock() contains preempt_disable/enable() action,
> already regarded as RCU critical region, so remove unnecessary
> rcu_read_lock/unlock().
>
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> ---
>  fs/io-wq.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/fs/io-wq.c b/fs/io-wq.c
> index cd88602e2e81..401be005d089 100644
> --- a/fs/io-wq.c
> +++ b/fs/io-wq.c
> @@ -855,9 +855,7 @@ static void io_wqe_enqueue(struct io_wqe *wqe, struct io_wq_work *work)
>         io_wqe_insert_work(wqe, work);
>         clear_bit(IO_ACCT_STALLED_BIT, &acct->flags);
>
> -       rcu_read_lock();

Add a comment like:
/* spin_lock can serve as an RCU read-side critical section. */

With that.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

>         do_create = !io_wqe_activate_free_worker(wqe, acct);
> -       rcu_read_unlock();
>
>         raw_spin_unlock(&wqe->lock);
>
> --
> 2.17.1
>
