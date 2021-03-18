Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAB5340FBD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 22:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbhCRVU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 17:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbhCRVUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 17:20:17 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31726C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 14:20:17 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id r193so3858819ior.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 14:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6KpGZSBcMfAsB9sB3LQc2YQC+eRv7jGWQhlLgVTI9EM=;
        b=HDr3ykGBYgm/GKZroq679kqawcZYb0fFdMSN/uRHfOR8WpIRNnr78Lv1NFwRbI9Zpm
         r82GjAoGo4FxfEkOGWro4HbUf75hLFU/2lWPXrWUe5d6AFwfNs13Ws4TzrJFfkJ5vC0V
         Bpk5LgKLZZhNLFhsfZCCLXE2HYTeW1sjE+25Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6KpGZSBcMfAsB9sB3LQc2YQC+eRv7jGWQhlLgVTI9EM=;
        b=OS2urL1etAGhfIwQIo7hRzYrGg73N6SoLDxG7j+bRHxQfw+eZG1egvFbQ/Y3azOy4H
         Ee5wWWgcJ5N4SzPnY/KK5EHK+mgKiyc0Jw4P6ZGKh0RTpPBYTe6tSAUY2JfakLU1JM84
         sJ0B1Zfg+hTZRXdE44TgBfuLXsYLyw13hk+MmKqzJrtEpAEg2UiffsRc20ZfJZcs6s4w
         gHwLQNuwyNEN6I/sNHLjrhtGPeihQa4yOAJQIHwsg2nBxpOOLWbjPn2IjWPFfdVc3+B6
         HifiT73vrap4x3spJa/pHrdkyBmerh4pTkRwEHia0HQf6e53i4CietiqYqJQBLKVpT3S
         5KCw==
X-Gm-Message-State: AOAM531eu0LMojL0kkDbWwKc685J+ZGQknCoeqCl1N7D+j0O4hVXOGDP
        boCXPSqP31b360qSly670L4c4o8WVXMVFR1Y
X-Google-Smtp-Source: ABdhPJwKk4dIbHjz6QbJPWWLxxfX1TDie1tUx5Joc0rUw/xVX61srGkaabnmTgyYY4YwCe61yw4/Wg==
X-Received: by 2002:a02:9042:: with SMTP id y2mr8780283jaf.94.1616102416514;
        Thu, 18 Mar 2021 14:20:16 -0700 (PDT)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com. [209.85.166.48])
        by smtp.gmail.com with ESMTPSA id m9sm1522656ilh.5.2021.03.18.14.20.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 14:20:15 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id v17so3854683iot.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 14:20:15 -0700 (PDT)
X-Received: by 2002:a05:6638:2711:: with SMTP id m17mr8664936jav.115.1616102414737;
 Thu, 18 Mar 2021 14:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210208051749.1785246-1-sergey.senozhatsky@gmail.com>
 <20210208051749.1785246-4-sergey.senozhatsky@gmail.com> <CAPybu_10Uz0Eb2U5ZohNV1t0gf98ZBZOa3KFCzdi1RJ0k3c1yQ@mail.gmail.com>
 <YFFiizDjNBMG3uI+@google.com> <CAPybu_0ruoc-w3402j-vVNs2-xq8=-_XzVKSxiG+iuyB=eNimA@mail.gmail.com>
 <YFLbYjm0VyzaEMkr@google.com> <CANiDSCtCaVUxrYeceWXEJ3o61ze8uNyce69xW_KcQTirhWfZaQ@mail.gmail.com>
In-Reply-To: <CANiDSCtCaVUxrYeceWXEJ3o61ze8uNyce69xW_KcQTirhWfZaQ@mail.gmail.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 18 Mar 2021 22:20:03 +0100
X-Gmail-Original-Message-ID: <CANiDSCuX_Pc46mHOAYKDuMO+Ef5cTdwxQAAcMFbD7oSA0BdYeQ@mail.gmail.com>
Message-ID: <CANiDSCuX_Pc46mHOAYKDuMO+Ef5cTdwxQAAcMFbD7oSA0BdYeQ@mail.gmail.com>
Subject: Re: [PATCHv2 3/3] media: uvcvideo: add UVC 1.5 ROI control
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 10:19 PM Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Hi Sergey
>
> On Thu, Mar 18, 2021 at 5:47 AM Sergey Senozhatsky
> <sergey.senozhatsky.work@gmail.com> wrote:
> >
> > On (21/03/17 08:58), Ricardo Ribalda Delgado wrote:
> > [..]
> > > >
> > > > GET_CUR?
> > > yep
> > >
> > > >
> > > > > https://www.kernel.org/doc/html/v4.13/media/uapi/v4l/vidioc-g-selection.html?highlight=vidioc_s_selection
> > > > > On success the struct v4l2_rect r field contains the adjusted
> > > > > rectangle.
> > > >
> > > > What is the adjusted rectangle here? Does this mean that firmware can
> > > > successfully apply SET_CUR and return 0, but in reality it was not happy
> > > > with the rectangle dimensions so it modified it behind the scenes?
> > >
> > > I can imagine that some hw might have spooky requirements for the roi
> > > rectangle (multiple of 4, not crossing the bayer filter, odd/even
> > > line...) so they might be able to go the closest valid config.
> >
> > Hmm. Honestly, I'm very unsure about it. ROI::SET_CUR can be a very
> > hot path, depending on what user-space considers to be of interest
> > and how frequently that object of interest changes its position/shape/etc.
> > Doing GET_CUR after every SET_CUR doubles the number of firmware calls
> > we issue, that's for sure; is it worth it - that's something that I'm
> > not sure of.
> >
> > May I please ask for more opinions on this?
>
> Could you try setting the roi in a loop in your device and verify that
> it accepts all the values with no modification. If so we can implement
> the set/get as a quirk for other devices.

as a loop I mean testing all the values not the same value again-and-again
;)


>
> >
> >         -ss
>
>
>
> --
> Ricardo Ribalda



-- 
Ricardo Ribalda
