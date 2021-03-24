Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094C0347630
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 11:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbhCXKeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 06:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbhCXKe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:34:26 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD00C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 03:34:25 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b16so27050464eds.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 03:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xbhw/ZDmJTjBytyPJI4UoxBWXtQ1ngIRpvlPehMK2p8=;
        b=K5eF6tArEz7YZ2z0SVz1j+SY3aWkpkm/lMhGoxxmkXIldsJwPb5kfAzOSN0zkPVgwE
         xq+o94WZliHVWgIsTUQY8P6nSgPdrIumCDyXVJd8Ledi0nEjytIuL05OvkIS+wi6C+dx
         uyu5K/7mJsQrZNNyiR2L3gCLKKfHRrykP00+GgjWrhqYm0LyY4iYvUJZ50y/pyReWft7
         MqyjC1I8FU2kdmepFT5TA6QTL1nd1MLkaHElSY9uexyV1WRz2w6YgSJbq3oyWtNRF/OO
         f859NY9Xx9u6gRS/WJd0PGyrbdCxM0q3Sn5uu/nHScF63Esgw/e8CtvIEmX391Z7Cgv6
         ltQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xbhw/ZDmJTjBytyPJI4UoxBWXtQ1ngIRpvlPehMK2p8=;
        b=TOxLjv7VwbI1tbYvQB3G0LK7SDBdOLZEPWTI9pSh1PmM9fpHlwLZ12Js3kL891M0eD
         Fe6KymIIfYG/xvpqXcuxAiqfd7Mw2TLAXU6DbguPRUpknTg5EfoSc6Pq+HZA7xVYfB0L
         w1ooIXi69H48Xucsvcbi6ddIAz24H/rYJD7Y+QEsStZaCNJe3X86S97JPh/PtjtSdZj4
         OfFlSmUmEXN5pysUliACT/q8Z/ajzC5xaud2xRDDdtmpG5WoyR576eE1ZRgB0zak6kuz
         V8SKHAIM1wE6oKU9KuIiE6XMvlzw43OWAX23cywlB/koUkYOUd9qj/oUH97U1A+aE2m2
         mv6g==
X-Gm-Message-State: AOAM530A/MtGvM/EijiOnH9ryYQW7snEvcCe37l+m02Fcz2JbA1O5GWm
        2mRNC0nOIiCxtFsXHS5rTHilrqZtY0K4MsUYPUUf+w==
X-Google-Smtp-Source: ABdhPJzd+cqvYyBPZHJeB8/Vy81pM52Ij0bfN/tp45Qzn+7LGL6qmwPViYVX7+JE7pz+I6/Hr+AfwXfKBsXlE5DyyxY=
X-Received: by 2002:a50:f38f:: with SMTP id g15mr2652251edm.262.1616582059297;
 Wed, 24 Mar 2021 03:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210323125535.1866249-1-arnd@kernel.org>
In-Reply-To: <20210323125535.1866249-1-arnd@kernel.org>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 24 Mar 2021 11:34:08 +0100
Message-ID: <CAMGffE=XZ_5ibx2jMxC_kLLKSLmV882XGk6yHAc2B4y2VRvTrw@mail.gmail.com>
Subject: Re: [PATCH] block/rnbd-clt: fix overlapping snprintf arguments
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Colin Ian King <colin.king@canonical.com>,
        linux-block <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 1:55 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The -Wrestrict warning (disabled by default) points out undefined
> behavior calling snprintf():
>
> drivers/block/rnbd/rnbd-clt-sysfs.c: In function 'rnbd_clt_get_path_name':
> drivers/block/rnbd/rnbd-clt-sysfs.c:486:8: error: 'snprintf' argument 4 overlaps destination object 'buf' [-Werror=restrict]
>   486 |  ret = snprintf(buf, len, "%s@%s", buf, dev->sess->sessname);
>       |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/block/rnbd/rnbd-clt-sysfs.c:472:67: note: destination object referenced by 'restrict'-qualified argument 1 was declared here
>   472 | static int rnbd_clt_get_path_name(struct rnbd_clt_dev *dev, char *buf,
>       |                                                             ~~~~~~^~~
>
> This can be simplified by using a single snprintf() to print the
> whole buffer, avoiding the undefined behavior.
>
> Fixes: 91f4acb2801c ("block/rnbd-clt: support mapping two devices with the same name from different servers")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/block/rnbd/rnbd-clt-sysfs.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
> index d4aa6bfc9555..38251b749664 100644
> --- a/drivers/block/rnbd/rnbd-clt-sysfs.c
> +++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
> @@ -479,11 +479,7 @@ static int rnbd_clt_get_path_name(struct rnbd_clt_dev *dev, char *buf,
>         while ((s = strchr(pathname, '/')))
>                 s[0] = '!';
>
> -       ret = snprintf(buf, len, "%s", pathname);
> -       if (ret >= len)
> -               return -ENAMETOOLONG;
> -
> -       ret = snprintf(buf, len, "%s@%s", buf, dev->sess->sessname);
> +       ret = snprintf(buf, len, "%s@%s", pathname, dev->sess->sessname);
>         if (ret >= len)
>                 return -ENAMETOOLONG;
>
> --
> 2.29.2
>
Thanks Arnd, We have a same patch will send out soon as part of a
bigger patchset.
