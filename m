Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6F8346F9B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 03:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbhCXCet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 22:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbhCXCef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 22:34:35 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC733C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:34:34 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id bf3so25873798edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3/tPoD35zw5EpWxZC5d80CVQfmjQQVATTl9B5CWjRNo=;
        b=kxAnCU7o8LZMAzUf62eCyvsXvoYuMM5vNkRG1v1l2XDgtwNMhD00i5DN7sNeV3f0xT
         j705//jCC1652IobRypa3/MYe/9/QzETBhuhpa26SDXfbjzDJsWLjUD/tIqQUJ4JOIqb
         kvswotXYIW4rXIDBBVHLSNjCYSC4/cHclmR9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3/tPoD35zw5EpWxZC5d80CVQfmjQQVATTl9B5CWjRNo=;
        b=GKtJibaJx/9CRgo7Qtw6uptAjoZyTbg6GkmYV4UdoZ7RQ58isaC7ODmBqNce30OJvO
         pLO/PJT4H7R3aTsHjBGl+5ckp/4R/0dOCujnQqmY+oe2t/lBbVKoXAyc1cm7F5HG+UW6
         DfLVIsMwnDUyPPaK+PoQJ2veIQCMq0j8/dgcUFjUq1CQWa9T995PoEHcG/kaGTwnW3PS
         HH1E+m2cLDE4wjAmgs0BasepH8LY9W41Gh+zprdhYD/wD3Pld4wMIXusE20TYNRmQTHp
         UnNnFrj8LbLK/31brUJ6yzbRHe+pusX5fyEMHjJlLqD+9QPVOo40EdqwIRQuKL+W8sXG
         rmDg==
X-Gm-Message-State: AOAM530u3rRlX9Pw7AdLjuwG5U58Hn6uKrnel0ycdsFwzg/4BvILRTIL
        gk4AQN5yJqYatu4BaOrUe2+7wSNr9ywcNg==
X-Google-Smtp-Source: ABdhPJycz/afSfqCvzYuVyXBgHZZ+YM03t8vCEWIGJKleWapgUav1hCuJDPuP+s4UcNitnOFFRCRBQ==
X-Received: by 2002:aa7:c3c4:: with SMTP id l4mr890700edr.335.1616553273239;
        Tue, 23 Mar 2021 19:34:33 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id b22sm379253edv.96.2021.03.23.19.34.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 19:34:32 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id v4so22844617wrp.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:34:32 -0700 (PDT)
X-Received: by 2002:adf:ea8d:: with SMTP id s13mr899073wrm.32.1616553272193;
 Tue, 23 Mar 2021 19:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210319055342.127308-1-senozhatsky@chromium.org>
 <20210319055342.127308-6-senozhatsky@chromium.org> <CANiDSCt72o_E=gRBRhMWWmta-H2WGmDqg5_PBGHBrVCG4iepZw@mail.gmail.com>
 <YFqdaHCQak5ZM0Sf@google.com> <CAAFQd5DaDZA8==HPrL1v1M=1a5g3DgY58nuq7KnA8USQ6UuiTQ@mail.gmail.com>
 <YFqkaumASvjrYP/n@google.com>
In-Reply-To: <YFqkaumASvjrYP/n@google.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 24 Mar 2021 11:34:21 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AdJfNLoXwDEgCf90cm5e30rT98SO5CRJ=oR8Do_T566A@mail.gmail.com>
Message-ID: <CAAFQd5AdJfNLoXwDEgCf90cm5e30rT98SO5CRJ=oR8Do_T566A@mail.gmail.com>
Subject: Re: [PATCHv3 5/6] media: uvcvideo: add UVC 1.5 ROI control
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 11:31 AM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (21/03/24 11:14), Tomasz Figa wrote:
> > > > > +static int uvc_ioctl_s_roi(struct file *file, void *fh,
> > > > > +                          struct v4l2_selection *sel)
> > > > > +{
> > > > > +       struct uvc_fh *handle = fh;
> > > > > +       struct uvc_streaming *stream = handle->stream;
> > > > > +       struct uvc_roi_rect *roi;
> > > > > +       int ret;
> > > > > +
> > > > > +       if (!validate_roi_bounds(stream, sel))
> > > > > +               return -E2BIG;
> > > >
> > > > Not sure if this is the correct approach or if we should convert the
> > > > value to the closest valid...
> > >
> > > Well, at this point we know that ROI rectangle dimensions are out of
> > > sane value range. I'd rather tell user-space about integer overflow.
> >
> > Adjusting the rectangle to something supported by the hardware is
> > mentioned explicitly in the V4L2 API documentation and is what drivers
> > have to implement. Returning an error on invalid value is not a
> > correct behavior here (and similarly for many other operations, e.g.
> > S_FMT).
>
> Well, in this particular case we are talking about user-space that wants
> to set ROI rectangle that is knowingly violates device's GET_MAX and
> overflows UVC ROI rectangle u16 value range. That's a clear bug in user-space.
> Do we want to pretend that user-space does the correct thing and fixup
> stuff behind the scenes?
>

That's how the API is defined. There is a valid use case for this -
you don't need to run QUERY_CTRL if all you need is setting the
biggest possible rectangle, just set it to (0, 0), (INT_MAX, INT_MAX).

> > > Looking for the closest ROI rectangle that suffice can be rather
> > > tricky. It may sounds like we can just use BOUNDARIES_MAX, but this
> > > is what Firmware D returns for GET_MAX
> > >
> > > ioctl(V4L2_SEL_TGT_ROI_BOUNDS_MAX)
> > >
> > >         0, 0, 65535, 65535
> >
> > Perhaps the frame size would be the correct bounds?
>
> I can check that.
