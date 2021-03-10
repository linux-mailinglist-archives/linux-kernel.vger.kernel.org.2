Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB383339CA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 11:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhCJKQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 05:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhCJKQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 05:16:43 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7447C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 02:16:42 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id i18so14993473ilq.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 02:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YnjTlCzPSM64YPwZtIYFy5lAVDG5f9v4P0vMMvdQJ4g=;
        b=d0SaJGU+8Urml23wTMTDfhpGRRTwD+zpckGUZVMl+sVOy1WZYmEJ452QYDEt+HEMPH
         IgYQZsfm5TUykrsjmeIEmLfHZGFzcwLIgOiDgolB3dDU+UugpwZSaiyTCDiqkBCrQWWh
         l7f5WKbbFlEUefe7S8uASrebDK0rSAdB2PHd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YnjTlCzPSM64YPwZtIYFy5lAVDG5f9v4P0vMMvdQJ4g=;
        b=NVPCbCfCnepj23g+qggVggwEe95F8yEUfIhOYTVA4DRcmLo3fsnzyE+KNsDDabWfsv
         kl4qnMMrUqRON3TG3zsLhfoISY+xTHjeInfUMsEfugk2oO0rAUWzlrqyRqycKdCGcak+
         +O05l8ykYf36FXkQxO1IrBxLQV3NRg45MViOUboI2ohzt4V4hvxN89GWx8i2gOBpwzJJ
         FoxNYDOgO0fr/Rc+Mww9nW8py3oToFtV1Pt1TrM4YXbHwLtIjsCNscOzEdgdVscKk5vO
         SNcFhE//bnD/vRs0o7/jWLSxk0pdrHZK4y3q2MUFwHGsEr245KquBOFMKCHAqwYaqviA
         73Hw==
X-Gm-Message-State: AOAM532XchAP4y8z43+3d4JNelYL7FsBYQWNuYUBIGsIXtX6UzjQdze/
        Uq6COikEC8q/DMwtW7HSNEK2+jmZ1F14t3/q
X-Google-Smtp-Source: ABdhPJzrcJk9sK1gPX0/UH025e0tpB5Dh7fn7gGlBVIQ/vP9JzX1gMNHunDKkmk+vQ4oOKzwFjkSkA==
X-Received: by 2002:a92:50c:: with SMTP id q12mr1996907ile.59.1615371402033;
        Wed, 10 Mar 2021 02:16:42 -0800 (PST)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com. [209.85.166.169])
        by smtp.gmail.com with ESMTPSA id x17sm9155574ilm.40.2021.03.10.02.16.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 02:16:41 -0800 (PST)
Received: by mail-il1-f169.google.com with SMTP id g9so15039279ilc.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 02:16:41 -0800 (PST)
X-Received: by 2002:a05:6e02:194e:: with SMTP id x14mr2059514ilu.218.1615371400880;
 Wed, 10 Mar 2021 02:16:40 -0800 (PST)
MIME-Version: 1.0
References: <20210309234317.1021588-1-ribalda@chromium.org>
 <YEh6AIQPa75MzP+8@pendragon.ideasonboard.com> <CANiDSCuz76q0Ukq5UfrgeRH_JFWKQ9hCpMqZTHUtiwHxpEd4oQ@mail.gmail.com>
 <YEh/ZsfC34+aGI0Q@pendragon.ideasonboard.com>
In-Reply-To: <YEh/ZsfC34+aGI0Q@pendragon.ideasonboard.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 10 Mar 2021 11:16:30 +0100
X-Gmail-Original-Message-ID: <CANiDSCv7q1iY=QrtG2ssC_Y1Z1EiiWegfXmd=ha-=2vmngW_dQ@mail.gmail.com>
Message-ID: <CANiDSCv7q1iY=QrtG2ssC_Y1Z1EiiWegfXmd=ha-=2vmngW_dQ@mail.gmail.com>
Subject: Re: [PATCH] media: videobuf2: Fix integer overrun in allocation
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

On Wed, Mar 10, 2021 at 9:12 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> On Wed, Mar 10, 2021 at 08:58:39AM +0100, Ricardo Ribalda wrote:
> > On Wed, Mar 10, 2021 at 8:49 AM Laurent Pinchart wrote:
> > > On Wed, Mar 10, 2021 at 12:43:17AM +0100, Ricardo Ribalda wrote:
> > > > The plane_length is an unsigned integer. So, if we have a size of
> > > > 0xffffffff bytes we incorrectly allocate 0 bytes instead of 1 << 32.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: 7f8414594e47 ("[media] media: videobuf2: fix the length check for mmap")
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > >  drivers/media/common/videobuf2/videobuf2-core.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> > > > index 02281d13505f..543da515c761 100644
> > > > --- a/drivers/media/common/videobuf2/videobuf2-core.c
> > > > +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> > > > @@ -223,8 +223,10 @@ static int __vb2_buf_mem_alloc(struct vb2_buffer *vb)
> > > >        * NOTE: mmapped areas should be page aligned
> > > >        */
> > > >       for (plane = 0; plane < vb->num_planes; ++plane) {
> > > > +             unsigned long size = vb->planes[plane].length;
> > >
> > > unsigned long is still 32-bit on 32-bit platforms.
> > >
> > > > +
> > > >               /* Memops alloc requires size to be page aligned. */
> > > > -             unsigned long size = PAGE_ALIGN(vb->planes[plane].length);
> > > > +             size = PAGE_ALIGN(size);
> > > >
> > > >               /* Did it wrap around? */
> > > >               if (size < vb->planes[plane].length)
> > >
> > > Doesn't this address the issue already ?
> >
> > Yes and no. If you need to allocate 0xffffffff you are still affected
> > by the underrun. The core will return an error instead of doing the
> > allocation.
> >
> > (yes, I know it is a lot of memory for a buffer)
>
> That's my point, I don't think there's a need for this :-) Especially
> with v4l2_buffer.m.offset being a __u32, we are limited to 4GB for *all*
> buffers.

I guess I will convert this patch into a documentation patch, so we
explicitly know the limit of the API
(1<<32 - PAGE_SIZE).

Thanks!

>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda
