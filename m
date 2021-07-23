Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58903D4161
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 22:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhGWTe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 15:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhGWTeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 15:34:25 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71899C061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 13:14:58 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id z18so4107848ybg.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 13:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JW/rwU7b6kzp3YJbh941iVFxl/dOjxShWSeuq57arn0=;
        b=ejuCBxTHWoDQk2rpo3CBOdisKE1Idn1+7jR7tmspL4j95vYcWJKKFbcfRnk2ovHRKA
         HKkN9ZlHTqU3TWNnvq+NoX4qQq5Xct/bm2s6VZluUEnzpXuSddd2jEDmB7+w6x0x4Psu
         MdhYeED/cqsTIeNpHVEsSENL6O5N16imzeylZp7NFGjFJO4S2nVScbECYhBuS6g8+6Jt
         /wjXgNHDvrMu6HXfNZhhWMHst9hTvn1KqJXVWZEPafheEXztF3V4L43TrPahw97T/O0D
         2sO8vpMKo4e0y+Y0YGaR8/Qzm5kKgMQRChvpuurwT8wgNBam0ImxXlQh1u1YnekkY3sH
         Psvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JW/rwU7b6kzp3YJbh941iVFxl/dOjxShWSeuq57arn0=;
        b=Gw/BORaAHYfP6IIer4ET8fLvJClxqDqJK3z3VuM0RHSmZKV+KkdzHQpUamlHR07OEq
         v1KyHZwgS82Oo+4KScCy4IrmV5rutSAobhavZfmFzKAlJ79FeY6qUw/fnmPhdrtQTe+h
         mV99+MqPMVyU4/9yd3k8NomwobOEoUZmYBMPTA/sDvuCnVgpQCJL7zCn+sNGRVwDw6Go
         QRV3FwP01IfumgT9jtXNUCGCR2hcCl4+Fb/pChN2rhW07lKt5E8uWRV6iXQfZDalwXmh
         U85QANChSnEYsNcNhaY4sJMx+Roy/SNG1tTdrB+biJKv8LcucetFUoODPWzHxzdWgAhf
         VASA==
X-Gm-Message-State: AOAM5310Qk5xe5YuxhrjOQE+9bJmYbrik0MFW6S9zz4IkfuDdXDoYWNq
        cUoUi+ztdjun1ASj/h2xQ8+1zy4BVrkZnp5PW2rR7w==
X-Google-Smtp-Source: ABdhPJz77EfUvYsyDTWGOFgpEtmRaxbSsmh1wSynvlFpZ5iu4xrBUExPDobX8h47Xs9+dj6RzdBF4mHzsx2bI9LTF8s=
X-Received: by 2002:a25:2e49:: with SMTP id b9mr9041411ybn.250.1627071297518;
 Fri, 23 Jul 2021 13:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210723200514.10139-1-fmdefrancesco@gmail.com>
In-Reply-To: <20210723200514.10139-1-fmdefrancesco@gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 23 Jul 2021 13:14:46 -0700
Message-ID: <CAJuCfpF37KXw2SG37_XoRyhGWc+uueU0NaxcEfU1=FH-rRm+bQ@mail.gmail.com>
Subject: Re: [PATCH] staging: android: Remove set but unused variable in ashmem.c
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 1:05 PM Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
>
> Remove variable 'inode' tnat is set but unused. Issue detected
> by building with warning option -Wunused-but-set-variable.
>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/android/ashmem.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
> index ddbde3f8430e..606e988d3f63 100644
> --- a/drivers/staging/android/ashmem.c
> +++ b/drivers/staging/android/ashmem.c
> @@ -406,7 +406,6 @@ static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>         if (!asma->file) {
>                 char *name = ASHMEM_NAME_DEF;
>                 struct file *vmfile;
> -               struct inode *inode;
>
>                 if (asma->name[ASHMEM_NAME_PREFIX_LEN] != '\0')
>                         name = asma->name;
> @@ -418,7 +417,6 @@ static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>                         goto out;
>                 }
>                 vmfile->f_mode |= FMODE_LSEEK;
> -               inode = file_inode(vmfile);
>                 lockdep_set_class(&inode->i_rwsem, &backing_shmem_inode_class);

How about its usage in the above lockdep_set_class(&inode->i_rwsem,
...) call? I'm guessing you are building with CONFIG_LOCKDEP=n.
Have you tried adding __maybe_unused in inode variable definition to
get rid of the warning?


>                 asma->file = vmfile;
>                 /*
> --
> 2.32.0
>
