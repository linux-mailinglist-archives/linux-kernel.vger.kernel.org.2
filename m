Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99EEB3D95F9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 21:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhG1TUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 15:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhG1TUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 15:20:40 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB747C061765
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 12:20:38 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id z24so3351105qkz.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 12:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gpiccoli-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d6qfKqRI6m4WTJASM6iTIDEeVp83gFU9fVe84XKYU6Y=;
        b=A3zB2BxrkshfLj1hul36dmsxR83ZwIIx8IATAiVAm18rAErkeotKTlhDn7xT5TnALE
         SsHLnr8y7ODufgkIr5xPzIWTu+TI10wW2RiIV6aLPlOn5SbgAL5YjwaDF1weKkx6biRQ
         VtPPWGqI2tJrPVDooy6TLnjaipm3AXs+KjeNLCj92QcUm4f/WFBnih3T6X8GzhRA7uD3
         vZaQPwDwSvfH9nVUhgfJf/w2pH/A8rjXZOSgOD/Kn37j4JPETTgm4YZc6egdcFFsIlZN
         FSD43Tci/OHWigGmrPz5HiJzhxtp44aHmXYXANlgGNmGipYYpFxcMAhjsc2IwmqHb9lQ
         nqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d6qfKqRI6m4WTJASM6iTIDEeVp83gFU9fVe84XKYU6Y=;
        b=Dqi5533QUsQE/AVwodSp2zy/k2Rt7X67fRzU9iGhNIcYhZTjXo5ocu/dvTSrZ/uDOE
         TqnZcDUGhHWu5yExK2aGZy8CyusnlLtIFSUv/tSQJZHuIOjBaD0pc40b0ex/gXPGyJr4
         QMgZcjfHlrJzDiNlpEQtP9vqtlh525HUkpSOzCsRpuvawGyGX2Kiex6gSRIGl2Gpm9/v
         ycQPKK3et2pgphO3QpbojFo3baMbjrferS0yFafloo1wohgKxxy7ARxjQZC4c2U+7v0f
         0zk1aCKv64D+23I6KodDZtFaE+90EDlcq0SXFGE+fhE0VnRykoZxVK8Jr181+z9dC8IO
         SKzw==
X-Gm-Message-State: AOAM5302hEOUkCy5FL6EzXDGs4zQEW+KcivjlOiSq9LvEdRv+4YeTIKr
        AfNIH5XUB1sgsuuF6+p+3ra9JpKu8Ilehd4dR7Tg0A==
X-Google-Smtp-Source: ABdhPJxANaAhzZ3UvkSECqZTlZDB1UlnPJDdf7/FGnsQF5G3JjPaM70ed3s6veVwwGXMnJVtULZ62m95/1pevSBIiU4=
X-Received: by 2002:a05:620a:1319:: with SMTP id o25mr1256137qkj.396.1627500037010;
 Wed, 28 Jul 2021 12:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210715202341.2016612-1-mcgrof@kernel.org> <20210715202341.2016612-4-mcgrof@kernel.org>
In-Reply-To: <20210715202341.2016612-4-mcgrof@kernel.org>
From:   "Guilherme G. Piccoli" <kernel@gpiccoli.net>
Date:   Wed, 28 Jul 2021 16:20:01 -0300
Message-ID: <CALJn8nOWtFBnuzqPpuOH6nqikUzZGUYWEnvwCFvmrCrC5MWSmw@mail.gmail.com>
Subject: Re: [RFC 3/6] md: replace GENHD_FL_UP with GENHD_FL_DISK_ADDED on is_mddev_broken()
To:     Luis Chamberlain <mcgrof@kernel.org>, hch@infradead.org
Cc:     axboe@kernel.dk, hare@suse.de,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 5:24 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> The GENHD_FL_DISK_ADDED flag is what we really want, as the
> flag GENHD_FL_UP could be set on a semi-initialized device.
>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  drivers/md/md.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 832547cf038f..80561bca1f51 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -766,7 +766,7 @@ static inline bool is_mddev_broken(struct md_rdev *rdev, const char *md_type)
>  {
>         int flags = rdev->bdev->bd_disk->flags;
>
> -       if (!(flags & GENHD_FL_UP)) {
> +       if (!(flags & GENHD_FL_DISK_ADDED)) {

Thanks for the patch Luis! And thanks Christoph for looping me in on
the last iteration.
I think specifically for md, both flags are interchangeable - if
add_disk() is not completed, I'm pretty sure we cannot have the array
properly working hence we shouldn't ever reach this check for such
device. Nevertheless, technically speaking Christoph seems correct and
we are checking here in fact if the disk was del_gendisk'ed().
My opinion is that we don't need to change this usage, if possible,
but I'm not strongly against the change if you feel it fits better.

Just double-checking - after del_gendisk(), this flag is removed anyways right?
Oh, and if possible, loop me in CC for next revisions, using this email.
Cheers,


Guilherme
