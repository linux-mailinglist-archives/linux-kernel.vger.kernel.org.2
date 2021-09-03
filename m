Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326953FFE3E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 12:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbhICKe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 06:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235058AbhICKe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 06:34:57 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BB5C061757
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 03:33:58 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id z2so4770852iln.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 03:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qp3yBEGztW/IVnSK9RLezfX6LccfvbpJN7FvTSFuOOU=;
        b=NF3qbplL9tYzocYNGkzd+qx3v+y1Lyx+n2oo88ai79U82Sc+oJorAwNHZ7D84X6TEJ
         dM5BUGmPz49wrWyIL3iHs5w8DJ9hdinB8f7IsPLSx6hYoHYD1PAymQEy+a45Z8wSL6sI
         XMG4gOEOyjE/NnuSjzTsEyGMmnTPQAsQZq53k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qp3yBEGztW/IVnSK9RLezfX6LccfvbpJN7FvTSFuOOU=;
        b=KonLPb1sAVT5A35hh/xBhyVnBKVYMQwmRWlzj4EHRhFRqK50X6n55Yjh7vK9DYHvk2
         rI707CUISZliMFVoBltTPCDpYlcYiUQMg8mA71nTHa+rOvYbL1ql2PFc3/gmglTqJnkA
         04B37wXLpnq6njJmvCPclsQSaX7d5Xm+0Q4mPnkdPSv37NFXcLKDmaA4KOV8PQfiicZR
         RckmjjY25IsdrRzoG4Xkq4tkOwtEop0EBa+KIXrH1lZA01ze7T9RxBfrDilx0lrovcwp
         oreP5WrxChEnejK2b8GYQEmChzldHYYf4ugOCqw0s0AFAq+IYrRWsu75kLhzva/g41UN
         tmHw==
X-Gm-Message-State: AOAM532o0ABTTvW9OEErpToTAsTTjxa6k6e2t8dNX55WXsCqHNEY5ADK
        l4mziq49w0f+xqbSwctR57sl0vCc8FaXXg==
X-Google-Smtp-Source: ABdhPJwjhwCG/COkdL3K5GUlPq4bY2v0ifX52WdYorpqsbbcrdcYRiW5HqdJd1DlK/eWyq481DB9Zg==
X-Received: by 2002:a05:6e02:160f:: with SMTP id t15mr2172442ilu.60.1630665237132;
        Fri, 03 Sep 2021 03:33:57 -0700 (PDT)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com. [209.85.166.46])
        by smtp.gmail.com with ESMTPSA id i14sm2625171iol.27.2021.09.03.03.33.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 03:33:56 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id e186so6135749iof.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 03:33:55 -0700 (PDT)
X-Received: by 2002:a6b:8d08:: with SMTP id p8mr2473043iod.150.1630665235439;
 Fri, 03 Sep 2021 03:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210618122923.385938-1-ribalda@chromium.org> <20210618122923.385938-14-ribalda@chromium.org>
 <20210903121057.7279d964@coco.lan>
In-Reply-To: <20210903121057.7279d964@coco.lan>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 3 Sep 2021 12:33:44 +0200
X-Gmail-Original-Message-ID: <CANiDSCtZ8RbsR0_jwWbRiMayum2Q4+1wj=PQgC8Vu2boJeihng@mail.gmail.com>
Message-ID: <CANiDSCtZ8RbsR0_jwWbRiMayum2Q4+1wj=PQgC8Vu2boJeihng@mail.gmail.com>
Subject: Re: [PATCH v10 13/21] media: uvcvideo: Use control names from framework
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, Hans Verkuil <hverkuil@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro

On Fri, 3 Sept 2021 at 12:11, Mauro Carvalho Chehab <mchehab@kernel.org> wrote:
>
> Em Fri, 18 Jun 2021 14:29:15 +0200
> Ricardo Ribalda <ribalda@chromium.org> escreveu:
>
> > diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> > index 9cdd30eff495..28ccaa8b9e42 100644
> > --- a/drivers/media/usb/uvc/uvc_v4l2.c
> > +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> > @@ -40,7 +40,13 @@ static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
> >               return -ENOMEM;
> >
> >       map->id = xmap->id;
> > -     memcpy(map->name, xmap->name, sizeof(map->name));
> > +     /* Non standard control id. */
> > +     if (v4l2_ctrl_get_name(map->id) == NULL) {
> > +             map->name = kmemdup(xmap->name, sizeof(xmap->name),
> > +                                 GFP_KERNEL);
>
> Where are you de-allocating it at driver removal/unbind?

It is also in this patch:

@@ -2462,6 +2448,7 @@ static void uvc_ctrl_cleanup_mappings(struct
uvc_device *dev,
        list_for_each_entry_safe(mapping, nm, &ctrl->info.mappings, list) {
                list_del(&mapping->list);
                kfree(mapping->menu_info);
+               kfree(mapping->name);
                kfree(mapping);
        }
 }

If there is a standard name mapping->name will be NULL, but kfree
checks for that.

Thanks


>
>
> Thanks,
> Mauro



-- 
Ricardo Ribalda
