Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0CE43F52C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 05:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhJ2DGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 23:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbhJ2DGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 23:06:45 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477C2C061745
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 20:04:17 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id s1so33409825edd.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 20:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=21Qna8aedipM9a11qzYqQzHYUISEoYbsTLGZd0C/7I8=;
        b=UqOna1k5YHr9Ry+R1XJK/tqNlivM+pTC0RiteeptFhhW+oeuMJf2oUonwyIO9ElCfb
         pSq8R+PH47KbkA9ujxdmbllPec/Y5p3BMpLd4y/66pgbXN5zJy4wtcgvBg4UoG2et8Us
         VWe/oGbdrWaoQpstwQmpMagEkTGyDHP7lV5jI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=21Qna8aedipM9a11qzYqQzHYUISEoYbsTLGZd0C/7I8=;
        b=a45MifnOm2Q9YSaqeqE3FdaERP3FEpptr6ExwxylYECPdG59lfQTzBOveJRrFuEaTL
         YFA547FEWZbmpdZESALeX/b4xx7B94SUPllpddDPPMul8xGCkTp7qWAZG7wfJR8bo4bA
         1m+FOqgo5eDe3qSrKpMGoI3i0HJdVKCxmeKW8qepYR976CXWADCdluNzjUzTa0zz7O8f
         3v2yoYvfSeI21Fbsf1lxaZ8R2Y+vF36KymldLBD2rTbusoBoj0ZrMLvFd5P5AiJRwhGR
         bZiNOwdMz4BVf9dVTDf4WBQNlfFrZFS5WCgA1D99fNaxFmhmD+8oWuW/eWQXlCH64hDJ
         VE/g==
X-Gm-Message-State: AOAM530RLLmrRp7IZga252jntH2jDV+C0uGfDSfx+lkG9AAvf48UoOle
        1EGBoAG2JoowHLy6M2HYFsXnNAHtqyNZqg==
X-Google-Smtp-Source: ABdhPJwaVffor54RxhOQv02uciVizsVALBG0elWjRpU3GXOwRBznLtmW06VxQ/DyT9/IiAmObcycmQ==
X-Received: by 2002:aa7:c405:: with SMTP id j5mr11592793edq.84.1635476655403;
        Thu, 28 Oct 2021 20:04:15 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id d2sm2664714edz.49.2021.10.28.20.04.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 20:04:14 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id s13so6632962wrb.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 20:04:14 -0700 (PDT)
X-Received: by 2002:adf:9bd2:: with SMTP id e18mr10749368wrc.235.1635476653413;
 Thu, 28 Oct 2021 20:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211018091427.88468-1-acourbot@chromium.org> <9cb4f64e2ec3959df44b71dd69ef95697920dc4b.camel@ndufresne.ca>
In-Reply-To: <9cb4f64e2ec3959df44b71dd69ef95697920dc4b.camel@ndufresne.ca>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 29 Oct 2021 12:04:02 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BzXAO9vTm1xNmZ6iLnjnckfRC4Z2yqgxvuL+NUiHXnsQ@mail.gmail.com>
Message-ID: <CAAFQd5BzXAO9vTm1xNmZ6iLnjnckfRC4Z2yqgxvuL+NUiHXnsQ@mail.gmail.com>
Subject: Re: [PATCH] media: docs: dev-decoder: add restrictions about CAPTURE buffers
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 11:12 PM Nicolas Dufresne <nicolas@ndufresne.ca> wr=
ote:
>
> Le lundi 18 octobre 2021 =C3=A0 18:14 +0900, Alexandre Courbot a =C3=A9cr=
it :
> > CAPTURE buffers might be read by the hardware after they are dequeued,
> > which goes against the general idea that userspace has full control ove=
r
> > dequeued buffers. Explain why and document the restrictions that this
> > implies for userspace.
> >
> > Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> > ---
> >  .../userspace-api/media/v4l/dev-decoder.rst     | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/Documentation/userspace-api/media/v4l/dev-decoder.rst b/Do=
cumentation/userspace-api/media/v4l/dev-decoder.rst
> > index 5b9b83feeceb..3cf2b496f2d0 100644
> > --- a/Documentation/userspace-api/media/v4l/dev-decoder.rst
> > +++ b/Documentation/userspace-api/media/v4l/dev-decoder.rst
> > @@ -752,6 +752,23 @@ available to dequeue. Specifically:
> >       buffers are out-of-order compared to the ``OUTPUT`` buffers): ``C=
APTURE``
> >       timestamps will not retain the order of ``OUTPUT`` timestamps.
> >
> > +.. note::
> > +
> > +   The backing memory of ``CAPTURE`` buffers that are used as referenc=
e frames
> > +   by the stream may be read by the hardware even after they are deque=
ued.
> > +   Consequently, the client should avoid writing into this memory whil=
e the
> > +   ``CAPTURE`` queue is streaming. Failure to observe this may result =
in
> > +   corruption of decoded frames.
> > +
> > +   Similarly, when using a memory type other than ``V4L2_MEMORY_MMAP``=
, the
> > +   client should make sure that each ``CAPTURE`` buffer is always queu=
ed with
> > +   the same backing memory for as long as the ``CAPTURE`` queue is str=
eaming.
> > +   The reason for this is that V4L2 buffer indices can be used by driv=
ers to
> > +   identify frames. Thus, if the backing memory of a reference frame i=
s
> > +   submitted under a different buffer ID, the driver may misidentify i=
t and
> > +   decode a new frame into it while it is still in use, resulting in c=
orruption
> > +   of the following frames.
> > +
>
> I think this is nice addition, but insufficient. We should extend the API=
 with a
> flags that let application know if the buffers are reference or secondary=
. For
> the context, we have a mix of CODEC that will output usable reference fra=
mes and
> needs careful manipulation and many other drivers where the buffers *mayb=
e*
> secondary, meaning they may have been post-processed and modifying these =
in-
> place may have no impact.
>
> The problem is the "may", that will depends on the chosen CAPTURE format.=
 I
> believe we should flag this, this flag should be set by the driver, on CA=
PTURE
> queue. The information is known after S_FMT, so Format Flag, Reqbufs
> capabilities or querybuf flags are candidates. I think the buffer flags a=
re the
> best named flag, though we don't expect this to differ per buffer. Though=
,
> userspace needs to call querybuf for all buf in order to export or map th=
em.
>
> What userspace can do with this is to export the DMABuf as read-only, and=
 signal
> this internally in its own context. This is great to avoid any unwanted s=
ide
> effect described here.

I agree with the idea of having a way for the kernel to tell the
userspace the exact state of the buffer, but right now the untold
expectation of the kernel was as per what this patch adds. If one
wants their userspace to be portable across different decoders, they
need to keep the assumption. So the natural way to go here is to stay
safe by default and have a flag that tells the userspace that the
buffer can be freely reused.

Best regards,
Tomasz
