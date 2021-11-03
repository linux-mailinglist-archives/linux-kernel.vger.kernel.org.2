Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889FD443E39
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 09:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhKCISB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 04:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbhKCISA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 04:18:00 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0599C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 01:15:24 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r28so1764277pga.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 01:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6/g1pCDTYXPMrURdzvLf7qrNknIjaeuJnxxrL+FZ9xQ=;
        b=O49XbIrWjvZnx0vLC9YDkreq6WhyMYf04C5NHPd8/mqQ4bDStZ7todPtLnkRY+r5kg
         v+L+6OS3PEVr7t6vTFleAryPoRuIlCdzVXUgeWyjyRXH5/qpB5Kbtc7/vWX7PcY0p1FA
         dy5jXs9LJmV9hD0L0UhynsLXccwkvs1d3t/DJLUnxrnAeCvI/16BHNFOIR+I2/D/EQbO
         rZfbp/siZI4vyz28d7zt+koXRxalh+9nAt4X8d/EV1DUlllRBnznyHsiKWdtRnFCZHdl
         KGK3OW54ucSxqbEBhkppHjZpy1V0D4vZn71QHR/rtdT6TImJsCqjbHngpQVOcOXqoNoM
         DAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6/g1pCDTYXPMrURdzvLf7qrNknIjaeuJnxxrL+FZ9xQ=;
        b=VKojWKdO6D7o8NihcCcwRBu/fuyJj9FYUX9XK6A8PhzegeP9gFL1vK35OiA2zgYYxn
         QOsPlZATrideFx8gvu4RkpEmQdBS2B8OfLyiVb2TNQRli63t6SL1lA9CGDG7mPbaFkz+
         h4tXOapDMeawBHxvSrwZceOyoX4qiim1OKFKLV6ZlXbeZIGbEbPwRVw+XMOtYle6+ptc
         u8nFIiRgRQMvlxDR2gfwoiv0P8D50d+L4KNY7OpLCp8jhkUiA5+iy/p0azZXLNpx42Uc
         PVsm/euWDjT82CmbRBjehbwzsjN55lRN1KqA1SSSKT7HYfadvHs74gX4L1/fMauweDmg
         lIuA==
X-Gm-Message-State: AOAM5305nYPkT8LGpdgHnZSZV4iWCfNYMvVR/4eu7aAqXeS3g9hfgtes
        gC969ix9VsiE4Lop5WSvRs26H8ZZU1Lj7tJhiNBUBPyimf1Vfg==
X-Google-Smtp-Source: ABdhPJyn9YxhU1yLGSGKZzbhqhNMhFMhTVcsFjJ2ueKZny5pWstrpNPNRyT/P3oyAZa0qbkZTraZrRVKqjA0GKyxiUI=
X-Received: by 2002:aa7:990e:0:b0:480:ff8f:d655 with SMTP id
 z14-20020aa7990e000000b00480ff8fd655mr22595770pff.18.1635927324220; Wed, 03
 Nov 2021 01:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210824031847.GA23326@raspberrypi>
In-Reply-To: <20210824031847.GA23326@raspberrypi>
From:   Austin Kim <austindh.kim@gmail.com>
Date:   Wed, 3 Nov 2021 17:15:13 +0900
Message-ID: <CADLLry4fgoj5CVeZ8M+QmzzvQ=GTj2AheBJA3eMeSTZT47scNA@mail.gmail.com>
Subject: Re: [PATCH] cachefiles: remove always false 'datalen < 0' expression
To:     dhowells@redhat.com
Cc:     linux-cachefs@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?6rmA64+Z7ZiE?= <austin.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2021=EB=85=84 8=EC=9B=94 24=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 12:18, =
Austin Kim <austindh.kim@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> From: Austin Kim <austin.kim@lge.com>
>
> Since 'datalen' is declared as size_t, the 'datalen < 0' expression
> is always false. Where size_t is defined as below;
>
>    typedef unsigned long __kernel_ulong_t;
>    typedef __kernel_ulong_t __kernel_size_t;
>    typedef __kernel_size_t size_t;
>
> So it had better remove unnecessary 'always false' expression.
>
> Signed-off-by: Austin Kim <austin.kim@lge.com>
> ---
>  fs/cachefiles/daemon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
> index 752c1e43416f..1cfed9e0812a 100644
> --- a/fs/cachefiles/daemon.c
> +++ b/fs/cachefiles/daemon.c
> @@ -225,7 +225,7 @@ static ssize_t cachefiles_daemon_write(struct file *f=
ile,
>         if (test_bit(CACHEFILES_DEAD, &cache->flags))
>                 return -EIO;
>
> -       if (datalen < 0 || datalen > PAGE_SIZE - 1)
> +       if (datalen > PAGE_SIZE - 1)
>                 return -EOPNOTSUPP;
>
>         /* drag the command string into the kernel so we can parse it */
> --
> 2.20.1
>

If you are available, would you please review this patch?
It will not take long.

BR,
Austin Kim
