Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8645133DB68
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 18:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbhCPRvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 13:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbhCPRug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 13:50:36 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576EDC061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 10:50:35 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id f10so13498054ilq.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 10:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JtrNAHIlNGqyu7tY2KgHDa90TRR2iABoGQSIvstGdZs=;
        b=kN4jETKpOsMT8ujABTKX/KoA1MUTlDRb+Z9NHUYVnpAh0syYrBtdaNgzA3IIHB602i
         HsTlTbMAjEyLIPblDWQdvaFB6Q6U8xj7Wm6Qa/UJmkrU/ZRuins9KWZSKS1KwDBsxG0K
         uk71bJAwFyqxS1ex5mOipRhoh7DVGXgqio8WQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JtrNAHIlNGqyu7tY2KgHDa90TRR2iABoGQSIvstGdZs=;
        b=gBiU8gBPLj2/GWH5m1Jz2wkxwAkR0AmVa3R8XRVbYqYQktsEn4uPnZqvWpqHmC4RJY
         CVQK9MXZBGXzjkn/mP3j6IVXyr5KhRIM7oLIXkvyhwtpE8HzbjZ8nYzAdLblS+OctyAB
         wPZJ2w4WqRRsLj++RUtfMU+vBmzNfuuUKWbe6D/8PY0B8lS9vJEQYWEI5FHPXKUn0Zmf
         xhJL8yx9iTx9USdGAH3zkgnawq8BSK1sTWDMB5xmFgu6hBU/EPxKgR0O1Q9JUYvDUjZy
         7e2AHRV/M+KFl5RfH0oc+hOJGnOUsmlzwyTYLAlUGYlNdUbMuWsbA4OgTj8Iqm84hJ98
         XuqQ==
X-Gm-Message-State: AOAM530GiCVo5PLUq1GiHt2qUKi1NP+8j6NnQZNRdvWoLI/OXlrX7KjO
        YHz3Zt0L6O4exetfVzEF9HHDyNPq/QeClw==
X-Google-Smtp-Source: ABdhPJx3jNSKWyMKGoAfd/07MSeXlLqkuN/c5kV7cTMm07q6XgC7HqnfPrnM377tkhhCwipUC7vWLw==
X-Received: by 2002:a92:cda1:: with SMTP id g1mr3205483ild.141.1615917034520;
        Tue, 16 Mar 2021 10:50:34 -0700 (PDT)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com. [209.85.166.52])
        by smtp.gmail.com with ESMTPSA id b12sm9760065ilr.55.2021.03.16.10.50.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 10:50:33 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id 81so38104172iou.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 10:50:32 -0700 (PDT)
X-Received: by 2002:a02:cb4b:: with SMTP id k11mr15230940jap.144.1615917032400;
 Tue, 16 Mar 2021 10:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210315123406.1523607-1-ribalda@chromium.org> <34c90095-bcbf-5530-786a-e709cc493fa9@linux.intel.com>
In-Reply-To: <34c90095-bcbf-5530-786a-e709cc493fa9@linux.intel.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 16 Mar 2021 18:50:20 +0100
X-Gmail-Original-Message-ID: <CANiDSCvMvYVN0+zN3du2pJfGLPJ_f7Ees2YrfybJgUDmBjq2jQ@mail.gmail.com>
Message-ID: <CANiDSCvMvYVN0+zN3du2pJfGLPJ_f7Ees2YrfybJgUDmBjq2jQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] media: staging/intel-ipu3: Fix memory leak in imu_fmt
To:     Bingbu Cao <bingbu.cao@linux.intel.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bingbu

Thanks for your review

On Tue, Mar 16, 2021 at 12:29 PM Bingbu Cao <bingbu.cao@linux.intel.com> wrote:
>
> Hi, Ricardo
>
> Thanks for your patch.
> It looks fine for me, do you mind squash 2 patchsets into 1 commit?

Are you sure? There are two different issues that we are solving.

Best regards!

>
> On 3/15/21 8:34 PM, Ricardo Ribalda wrote:
> > We are losing the reference to an allocated memory if try. Change the
> > order of the check to avoid that.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 6d5f26f2e045 ("media: staging/intel-ipu3-v4l: reduce kernel stack usage")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/staging/media/ipu3/ipu3-v4l2.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c b/drivers/staging/media/ipu3/ipu3-v4l2.c
> > index 60aa02eb7d2a..35a74d99322f 100644
> > --- a/drivers/staging/media/ipu3/ipu3-v4l2.c
> > +++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
> > @@ -693,6 +693,13 @@ static int imgu_fmt(struct imgu_device *imgu, unsigned int pipe, int node,
> >               if (inode == IMGU_NODE_STAT_3A || inode == IMGU_NODE_PARAMS)
> >                       continue;
> >
> > +             /* CSS expects some format on OUT queue */
> > +             if (i != IPU3_CSS_QUEUE_OUT &&
> > +                 !imgu_pipe->nodes[inode].enabled) {
> > +                     fmts[i] = NULL;
> > +                     continue;
> > +             }
> > +
> >               if (try) {
> >                       fmts[i] = kmemdup(&imgu_pipe->nodes[inode].vdev_fmt.fmt.pix_mp,
> >                                         sizeof(struct v4l2_pix_format_mplane),
> > @@ -705,10 +712,6 @@ static int imgu_fmt(struct imgu_device *imgu, unsigned int pipe, int node,
> >                       fmts[i] = &imgu_pipe->nodes[inode].vdev_fmt.fmt.pix_mp;
> >               }
> >
> > -             /* CSS expects some format on OUT queue */
> > -             if (i != IPU3_CSS_QUEUE_OUT &&
> > -                 !imgu_pipe->nodes[inode].enabled)
> > -                     fmts[i] = NULL;
> >       }
> >
> >       if (!try) {
> >
>
> --
> Best regards,
> Bingbu Cao



-- 
Ricardo Ribalda
