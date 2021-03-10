Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985943336A3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 08:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhCJHtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 02:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbhCJHt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 02:49:28 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5220EC061761
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 23:49:28 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id z9so14717528iln.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 23:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nAmWx2KEyvwzUF+YbYDbLiK4iBYOe+fdbgAgbi/9hWE=;
        b=VrgHTnjdvrVZlvdxmmz/j5XVfeKy0Uq3iIoz2z/Kqo+9+BNwu7ecP+Pd/BL4bT531t
         V52aW0QYL4yJgWdyAerRr6MbYRF4/oL0YUvHLsc+7qJy0oFRa3NyBZ7xvZlNFRg9MOOs
         coDHEaZ+BNE8k34GsADAQx8XVH1GRexyikeK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nAmWx2KEyvwzUF+YbYDbLiK4iBYOe+fdbgAgbi/9hWE=;
        b=S0kjBcuvP5JKGEXoSpOiqK1Wcq6H0gGUJ1cky1d/6ECArH3Q/rLRES8izBuGZmfp0I
         grZuZCsFRJxzT8nLqA6vKBxLmORHma2LtCUZleMbu4lqeLVqBq6dqJN2aLFGo3UH+/Qx
         kXy5OxJnZKLk4Kkb2C3oqNSjjFPSOxsuiQ+J3jRzCVeLbgKfO2C99RCHW9QGBx7o5l6p
         R81OLm/yx+dU/lI3oE1A6IQ8yQ28bh/mLhoflWH8Y2AEvh52yFNRjJQxqqIb/jRtLmmZ
         B8S1fsC4zE8BXQp2Fb1Xtqy+MxiAFHn9jWxEAAfxPyi5mZuHRleZmF8+RW08aOR4d1HM
         eLFQ==
X-Gm-Message-State: AOAM531Cg5cTcSJXieWEYbHRzvhR9EzwRFDwOZK1LJh16op8l5exV8pK
        n3CRArIMrfQfSVk3MEl3Blh/LVJWbQTUgRyC
X-Google-Smtp-Source: ABdhPJxrV9MgDGj6aaQ8NEcWAOWNbzj+BWtjooUHRB3zve97r44haVi0RNdZ3suEac63/gHjRfXIQw==
X-Received: by 2002:a92:444b:: with SMTP id a11mr1663948ilm.291.1615362567583;
        Tue, 09 Mar 2021 23:49:27 -0800 (PST)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com. [209.85.166.169])
        by smtp.gmail.com with ESMTPSA id n7sm8493029ili.79.2021.03.09.23.49.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 23:49:27 -0800 (PST)
Received: by mail-il1-f169.google.com with SMTP id k2so14698559ili.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 23:49:27 -0800 (PST)
X-Received: by 2002:a05:6e02:1bca:: with SMTP id x10mr1633282ilv.71.1615362566563;
 Tue, 09 Mar 2021 23:49:26 -0800 (PST)
MIME-Version: 1.0
References: <20210310074028.1042475-1-ribalda@chromium.org> <48e8ffd7-7f42-8e22-bf9d-646d9bd89bd9@suse.cz>
In-Reply-To: <48e8ffd7-7f42-8e22-bf9d-646d9bd89bd9@suse.cz>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 10 Mar 2021 08:49:15 +0100
X-Gmail-Original-Message-ID: <CANiDSCsMo7-PR2XVpw98cF9xBifedDgWbOMFxF8HhV3E9jRRDg@mail.gmail.com>
Message-ID: <CANiDSCsMo7-PR2XVpw98cF9xBifedDgWbOMFxF8HhV3E9jRRDg@mail.gmail.com>
Subject: Re: [PATCH] media: videobuf2: Fix integer overrun in vb2_mmap
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 8:47 AM Jiri Slaby <jslaby@suse.cz> wrote:
>
> On 10. 03. 21, 8:40, Ricardo Ribalda wrote:
> > The plane_length is an unsigned integer. So, if we have a size of
> > 0xffffffff bytes we incorrectly allocate 0 bytes instead of 1 << 32.
> >
> > Suggested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > Cc: stable@vger.kernel.org
> > Fixes: 7f8414594e47 ("[media] media: videobuf2: fix the length check for mmap")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >   drivers/media/common/videobuf2/videobuf2-core.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> > index 543da515c761..876db5886867 100644
> > --- a/drivers/media/common/videobuf2/videobuf2-core.c
> > +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> > @@ -2256,7 +2256,7 @@ int vb2_mmap(struct vb2_queue *q, struct vm_area_struct *vma)
> >        * The buffer length was page_aligned at __vb2_buf_mem_alloc(),
> >        * so, we need to do the same here.
> >        */
> > -     length = PAGE_ALIGN(vb->planes[plane].length);
> > +     length = PAGE_ALIGN((unsigned int)vb->planes[plane].length);
>
> Hi,
>
> I fail to see how case from uint to uint helps -- IOW, did you mean ulong?

Ups... my bad :(

Let me send a v2

>
> regards,
> --
> js
> suse labs



-- 
Ricardo Ribalda
