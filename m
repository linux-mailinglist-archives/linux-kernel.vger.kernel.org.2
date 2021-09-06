Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467E2401520
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 04:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239143AbhIFC6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 22:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239097AbhIFC6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 22:58:30 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E85AC061757
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 19:57:26 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id lc21so10489918ejc.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 19:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5YTZ2RkafZfVjiJtTzGEZcR88e29Lqe/N2xb8mNlQS4=;
        b=sEJX2bQFIIJYlR2IOutmw3yJDu4xHrI34I4rcrVOvXAOiX1F4jQX5NmfwyWZWH+QvL
         PM3Q4cZQc4Q764WA5QiOtGsoKPs1k861QMx0y2tPqLmLRaeX/d1rJQC1D25R9Y/P716q
         aHcVhTy3zkr5Cvl0S7pCiR8WGTvVTfWaRqRnxTPZdloMgL87B40Nb0xBKRRY82Q2JouJ
         yR64fgfHj7inGb9pmBogAgsyqe7tCT2JS+tGobU+aw+lauXtv+lHPQa4cgsuNs64/a3k
         A7Fi2a1vvrVb1OAQ1raRsmTo0OSBLstckl5kn3pw6P7I17PDBa50j8c0DbFQ4/aedgen
         PObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5YTZ2RkafZfVjiJtTzGEZcR88e29Lqe/N2xb8mNlQS4=;
        b=OBLwe5nfUx5kZ7Yz7rk6QJmMjtdcHEqngk06wlq3oN0+6OpHLtXClivBjbXYG7Vj5L
         kUuGh0//9B9To5q80n+yE1QJ1DcgbfDGAAgPq7VKIuGD7+YjihZymqOLoB1crb7cDVg9
         XiXkXYdzMqmmy1Wz+yb80GXrNOKKzMoYUYzi/Qi1AxHVi7Z61a1+0udZwSTpNgN56Ik8
         CA0Leb+2FglsV9jhAjQEmWgAdS8BnGfICDH2kZFT78F1XBFJn5OO1+G3Hw8kmUB+7ToM
         yO/oFh4vONDGmVyj8/A8AXeszKMH6//brE5TbnwO7DKY/2i2rsBi2SKp9Ccj1JfScnCg
         bOeQ==
X-Gm-Message-State: AOAM5334Gpov8QOVKvDugoqR69BV4ThAl/S/rL+3uHRzmk/e9xNqPnsm
        U2kGzGqXLa4f3WbVjDluphuHFa1ue/ZluHf55827
X-Google-Smtp-Source: ABdhPJwbFN1NkmsO8ACKX/jAOjIwGdI9FTX9FJt+/KE1sGoN0dyB1YYxU3cmTNPo3gv+zWwAcC3B6Sg6hRNRAVfVZYo=
X-Received: by 2002:a17:907:1c01:: with SMTP id nc1mr11417929ejc.504.1630897044884;
 Sun, 05 Sep 2021 19:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210906124954.55ece6e8@canb.auug.org.au>
In-Reply-To: <20210906124954.55ece6e8@canb.auug.org.au>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 6 Sep 2021 10:57:14 +0800
Message-ID: <CACycT3u6aOwgPhcKUhnDOL5JxkBt3=k69hHPUASZSr3iU8GXVw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the vhost tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 6, 2021 at 10:50 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the vhost tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> drivers/vdpa/vdpa_user/vduse_dev.c: In function 'vduse_vdpa_kick_vq':
> drivers/vdpa/vdpa_user/vduse_dev.c:489:6: error: implicit declaration of function 'eventfd_signal_count'; did you mean 'eventfd_signal_allowed'? [-Werror=implicit-function-declaration]
>   489 |  if (eventfd_signal_count()) {
>       |      ^~~~~~~~~~~~~~~~~~~~
>       |      eventfd_signal_allowed
>
> Caused by commit
>
>   b66219796563 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
>
> interacting with commit
>
>   b542e383d8c0 ("eventfd: Make signal recursion protection a task bit")
>
> from Linus' tree.
>
> I have applied the following merge fix patch for today.
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 6 Sep 2021 12:43:32 +1000
> Subject: [PATCH] fix up for "eventfd: Make signal recursion protection a task bit"
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 59a93e5b967a..5c25ff6483ad 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -486,7 +486,7 @@ static void vduse_vdpa_kick_vq(struct vdpa_device *vdpa, u16 idx)
>         struct vduse_dev *dev = vdpa_to_vduse(vdpa);
>         struct vduse_virtqueue *vq = &dev->vqs[idx];
>
> -       if (eventfd_signal_count()) {
> +       if (eventfd_signal_allowed()) {
>                 schedule_work(&vq->kick);
>                 return;
>         }
> --

LGTM! Thank you for the fix!

Thanks,
Yongji
