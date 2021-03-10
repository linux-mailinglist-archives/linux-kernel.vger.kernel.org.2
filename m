Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD64333681
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 08:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhCJHko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 02:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhCJHkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 02:40:36 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821D9C061760
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 23:40:36 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id u20so16874437iot.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 23:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cq2aReYAb1NZEVYoZ/NXyw9vsJhlnWLU3P0pndjoTAE=;
        b=DLlBEv1FlGiqLVy6NzkOd9B1PaTLbdBPBDA26CrI+8Ac08za+k724bSm8tYj8G6iUN
         URNdXo+Ytnx63SWNCmWLe3ybgChdYoC3xHLbY/FM888J8RPDSqWbPG9FWgkRxhZ8fuiA
         7DUw3VXOqIlTcqHEednvFtpo7p0QhXG0XkW8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cq2aReYAb1NZEVYoZ/NXyw9vsJhlnWLU3P0pndjoTAE=;
        b=foxe7EHv21WtGi2ApAsCv2zwZXqeYaXB2rVsPssdIB5Z6r4EodEpLRTIaumYg7DwWQ
         ZrRCH3oBCfp+ru63aMey401C24JqaveMIx9UofUrqutFmAYy/cxiItHwyNLVofmCwHJE
         sjBC5KrO7+Ev3dyz790O52+lumWIefmLCM6Sde07XRFD0XeeSTydQBZnPJZ0HlirKuV/
         yUw0Om5wdppPtz0zkTQUvcm/rJSzQI+6APQUCXvZUL0r+ePNnaLmqDShHy2iouR8zEJ1
         ZGvuD9xO4lwHMqfMPlqU33kzYM7VpMgFmVMIWDq1L8B/DiI+jbslNWn+YEFx6j8RkRRr
         5Iwg==
X-Gm-Message-State: AOAM531aPrKEbFqzmhGJdxGmoSwKUXeO3JSS9Gm+Ik7/YtjAr59CoOZH
        L8RhxwAWcXudxjQBYe4Z480G6FcyJcElvw==
X-Google-Smtp-Source: ABdhPJzYRhQh0w9NunupKwrdPSIBHkVEZT20wQFz4L9ZuADzsxWKLJPcBwzFurVzDnolv9t+XCeyRw==
X-Received: by 2002:a02:a691:: with SMTP id j17mr1960407jam.14.1615362035705;
        Tue, 09 Mar 2021 23:40:35 -0800 (PST)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com. [209.85.166.51])
        by smtp.gmail.com with ESMTPSA id a16sm1599562ild.82.2021.03.09.23.40.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 23:40:35 -0800 (PST)
Received: by mail-io1-f51.google.com with SMTP id z13so16884000iox.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 23:40:35 -0800 (PST)
X-Received: by 2002:a02:a303:: with SMTP id q3mr1925364jai.32.1615362034751;
 Tue, 09 Mar 2021 23:40:34 -0800 (PST)
MIME-Version: 1.0
References: <20210309234317.1021588-1-ribalda@chromium.org> <YEgj61iAt4Avnp6d@google.com>
In-Reply-To: <YEgj61iAt4Avnp6d@google.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 10 Mar 2021 08:40:24 +0100
X-Gmail-Original-Message-ID: <CANiDSCuVvhRXGHch0EvJ22mU+bfVs7ZyT2vrnWPxNu0z-ja_1g@mail.gmail.com>
Message-ID: <CANiDSCuVvhRXGHch0EvJ22mU+bfVs7ZyT2vrnWPxNu0z-ja_1g@mail.gmail.com>
Subject: Re: [PATCH] media: videobuf2: Fix integer overrun in allocation
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey

On Wed, Mar 10, 2021 at 2:42 AM Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
>
> On (21/03/10 00:43), Ricardo Ribalda wrote:
> > The plane_length is an unsigned integer. So, if we have a size of
> > 0xffffffff bytes we incorrectly allocate 0 bytes instead of 1 << 32.
>
> Hi Ricardo,
>
> > @@ -223,8 +223,10 @@ static int __vb2_buf_mem_alloc(struct vb2_buffer *vb)
> >        * NOTE: mmapped areas should be page aligned
> >        */
> >       for (plane = 0; plane < vb->num_planes; ++plane) {
> > +             unsigned long size = vb->planes[plane].length;
> > +
> >               /* Memops alloc requires size to be page aligned. */
> > -             unsigned long size = PAGE_ALIGN(vb->planes[plane].length);
> > +             size = PAGE_ALIGN(size);
> >
> >               /* Did it wrap around? */
> >               if (size < vb->planes[plane].length)
>
> Shouldn't the same be done in vb2_mmap()?
Indeed, I was having tunnel vision focussing on my issue.

I have sent a new patch.

Thanks!
>
>         -ss



--
Ricardo Ribalda
