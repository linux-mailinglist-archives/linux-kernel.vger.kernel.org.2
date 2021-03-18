Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A72340FB9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 22:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbhCRVTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 17:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhCRVT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 17:19:28 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9379EC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 14:19:28 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id z9so6195137ilb.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 14:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MbJIq0ucB8f2n4fhwnTv/rVAUGxtBZm58m8rbeIBX9U=;
        b=fKB/ZVWXLTeHVUyzK8JfoJmHacbDh3PUwyCUZgAhyPH4FBrESDbFeAKqzrci/2/ZOO
         c/wn4jTfEM6x6E3+uuRm4VEb/st8pqNXlME4V+QXdFz/YlVdg2OPIBJcWTN1yLeo02JC
         EOSxAeBit/c1KD+dKrtrJX5fBDT2WGAHLUyj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MbJIq0ucB8f2n4fhwnTv/rVAUGxtBZm58m8rbeIBX9U=;
        b=rG72oLteH1dqpj0z1yCyY9ctDMeaZ6LlvwX9cNg3FKqCPnmmkxm53GyGnwtu9qafLP
         Zx9TBRATO7o/T6RQBglqbh4w4/Ffsxiqs7H8478bQdQGwU4NH0rfpFtJawl9OYA1WWYO
         BlKg1mAfJHx9ljgrJ3W75wuSGXMiZXpTJHKwQhs11hDbltAUGFOoBVPxcaypq/IGqv8K
         F+JDGJPNuTtviXu3CTZwel9t9n4A1rDLSdBti9pOidvg6NK0lhyTXBEfevNOTUGDnZYy
         5oLPagQvFCCL2u7+vUrYgcEHH+i3FDhOEBYYcH9/i5uU2I3bo7t2HgYvMi+S8imb3juE
         OyMg==
X-Gm-Message-State: AOAM531HvpJ+7XS4guutAE7Htk763iTtcoElJIYm5HnIAoTEQp6yH+h6
        cQrDCj1nYi7NPYDsM+vd+fzKq0o3QCX1TW8o
X-Google-Smtp-Source: ABdhPJxiRecziEKDibLb34avmwpMfw7jYASJH6elEslR+0idIQOVDvOT6rYDhvyKAM8mWTyVchwRgw==
X-Received: by 2002:a92:730a:: with SMTP id o10mr437356ilc.160.1616102367833;
        Thu, 18 Mar 2021 14:19:27 -0700 (PDT)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com. [209.85.166.173])
        by smtp.gmail.com with ESMTPSA id d10sm1598126ila.47.2021.03.18.14.19.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 14:19:27 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id t6so6213687ilp.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 14:19:26 -0700 (PDT)
X-Received: by 2002:a05:6e02:dc5:: with SMTP id l5mr434497ilj.218.1616102366490;
 Thu, 18 Mar 2021 14:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210208051749.1785246-1-sergey.senozhatsky@gmail.com>
 <20210208051749.1785246-4-sergey.senozhatsky@gmail.com> <CAPybu_10Uz0Eb2U5ZohNV1t0gf98ZBZOa3KFCzdi1RJ0k3c1yQ@mail.gmail.com>
 <YFFiizDjNBMG3uI+@google.com> <CAPybu_0ruoc-w3402j-vVNs2-xq8=-_XzVKSxiG+iuyB=eNimA@mail.gmail.com>
 <YFLbYjm0VyzaEMkr@google.com>
In-Reply-To: <YFLbYjm0VyzaEMkr@google.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 18 Mar 2021 22:19:15 +0100
X-Gmail-Original-Message-ID: <CANiDSCtCaVUxrYeceWXEJ3o61ze8uNyce69xW_KcQTirhWfZaQ@mail.gmail.com>
Message-ID: <CANiDSCtCaVUxrYeceWXEJ3o61ze8uNyce69xW_KcQTirhWfZaQ@mail.gmail.com>
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

Hi Sergey

On Thu, Mar 18, 2021 at 5:47 AM Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
>
> On (21/03/17 08:58), Ricardo Ribalda Delgado wrote:
> [..]
> > >
> > > GET_CUR?
> > yep
> >
> > >
> > > > https://www.kernel.org/doc/html/v4.13/media/uapi/v4l/vidioc-g-selection.html?highlight=vidioc_s_selection
> > > > On success the struct v4l2_rect r field contains the adjusted
> > > > rectangle.
> > >
> > > What is the adjusted rectangle here? Does this mean that firmware can
> > > successfully apply SET_CUR and return 0, but in reality it was not happy
> > > with the rectangle dimensions so it modified it behind the scenes?
> >
> > I can imagine that some hw might have spooky requirements for the roi
> > rectangle (multiple of 4, not crossing the bayer filter, odd/even
> > line...) so they might be able to go the closest valid config.
>
> Hmm. Honestly, I'm very unsure about it. ROI::SET_CUR can be a very
> hot path, depending on what user-space considers to be of interest
> and how frequently that object of interest changes its position/shape/etc.
> Doing GET_CUR after every SET_CUR doubles the number of firmware calls
> we issue, that's for sure; is it worth it - that's something that I'm
> not sure of.
>
> May I please ask for more opinions on this?

Could you try setting the roi in a loop in your device and verify that
it accepts all the values with no modification. If so we can implement
the set/get as a quirk for other devices.

>
>         -ss



-- 
Ricardo Ribalda
