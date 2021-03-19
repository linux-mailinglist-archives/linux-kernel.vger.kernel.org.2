Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4BC1341DCF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 14:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhCSNLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 09:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhCSNLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 09:11:07 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42390C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 06:11:06 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id b10so5996993iot.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 06:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FomIKOx2mj7TAYUlB1ZCPvBZagtXVL3wiwg1FK3ni7o=;
        b=jkjDkZmIHc+1If7PMRab98D25OkHQM3Ug/BrFz+I/RViiODUTN9gnLIpSwOdnfEv78
         uCOHFXbSmbKxWkwbSeep6hYaHMiXSJXmwD+lYMiQyHgtFsbQimIvSCp1edMGW2ieDrmI
         XKdQN7Xooeaq77YRPyPwvoxQ4KBkmmBE/Rxug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FomIKOx2mj7TAYUlB1ZCPvBZagtXVL3wiwg1FK3ni7o=;
        b=tMybsq/07dxO7lNzTZxHhoP8A2+Nh6n6cs5JMe7kwAkreajlsrjrAqyDairntr7TkN
         OE7ug+MsgRbvm7gym1TIvhzacLwRuyoJidAQLXCDFW1OMgZN2AA7K7ixmq0yZmauj7Tp
         W666Xq/Aaf9kdx8emGfNRk1eO1EdrxoB3ICUIinBWQT/z0nBTS3R2qKqmMWeHyyKAPVc
         KpmAKlPm0xZwhN5IkGnBTXLEUIxhLlqK0LcyvV8onwrn9WPu8lnf2YQR+9SEx1jSUlw7
         TQgp9JO2jorAJrssV7szufIi0mE1YPdVfqdh5c8px8vZ50q0E6zgwwbrhvcmduhbkSW3
         4w5w==
X-Gm-Message-State: AOAM531jBgb/FT84jc0YWJHwks+9SWk0SiUwfajRrQaLjqot4uxXp8us
        2ZzERGEXFxk+M2MnIR7M1s2yOZGuz/3lcv8H
X-Google-Smtp-Source: ABdhPJxotdGUSmBxczUqudjecucEoBYO6gx29UEgKr3Ix1NqiyZSzSsqhwQsev5ekZ/W69/OSVVfpw==
X-Received: by 2002:a5e:841a:: with SMTP id h26mr2751424ioj.179.1616159465457;
        Fri, 19 Mar 2021 06:11:05 -0700 (PDT)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com. [209.85.166.41])
        by smtp.gmail.com with ESMTPSA id u5sm2602174iob.8.2021.03.19.06.11.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 06:11:05 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id v17so6008680iot.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 06:11:04 -0700 (PDT)
X-Received: by 2002:a05:6602:722:: with SMTP id g2mr2702953iox.1.1616159464446;
 Fri, 19 Mar 2021 06:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210312235521.1408503-1-ribalda@chromium.org>
 <CANiDSCunsYwjB=PYYJnpaEnB3pg7No40gOE1jTVwxJkJJpE2Nw@mail.gmail.com> <20210319131011.GA3372@lst.de>
In-Reply-To: <20210319131011.GA3372@lst.de>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 19 Mar 2021 14:10:53 +0100
X-Gmail-Original-Message-ID: <CANiDSCsid-gcq_HWWh=M0mOT947F7bj1QYANo4i0TwUSEkkEbg@mail.gmail.com>
Message-ID: <CANiDSCsid-gcq_HWWh=M0mOT947F7bj1QYANo4i0TwUSEkkEbg@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] media: uvcvideo: Use dma_alloc_noncontiguous API
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Sergey Senozhatsky <senozhatsky@google.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph

On Fri, Mar 19, 2021 at 2:10 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Mar 19, 2021 at 02:05:21PM +0100, Ricardo Ribalda wrote:
> > > +                                   uvc_urb->sgt,
> > > +                                   uvc_stream_dir(uvc_urb->stream));
> > > +       return usb_submit_urb(uvc_urb->urb, GFP_KERNEL);
> > > +}
> >
> > We should have mem_flags instead of GFP_KERNEL here
> >
> >
> > Is it too late to fix it in your tree? Do I need to send a patch to fix it?
>
> As far as I know we don't have anything that has pulled in the tree yet,
> so I can just fold the fix in.

Ohh good :). Thanks! and sorry again.



-- 
Ricardo Ribalda
