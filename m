Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC47734729C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 08:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbhCXH3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 03:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbhCXH3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:29:08 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D426C0613DB
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 00:29:07 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id b10so20453999iot.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 00:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YfeIczbpJJu3G0wGJ/ec/80ZG1AIJtuj0h2L9wYV6TM=;
        b=IxqgU+sTQMLeFrSxPsFbt29lEJBSGbWacpIK6qsKxeMmr7R78NZ778gsooIOF7V57b
         uW5x3/2J0kVRqBygaELvMnr7SDcNp82E5kMreHlVhBLwXTD7Eg0BBGvN6AWMJ6CSi+ft
         sZ1RzApM2CZis6pP9pMCTDHjLH2K2ACSFw8ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YfeIczbpJJu3G0wGJ/ec/80ZG1AIJtuj0h2L9wYV6TM=;
        b=k2ZtvaxzqKPZJXEWPEfW0hG4zLf7A5aTqll2PC5nh9IfPzvWSEPBtwGPNCrjS1o0jX
         hMFsLk2esjDNXgFo0lDn2Osb0iTChPYDRNMyxUp7Bw/Rncy5MTzTl1h6UEYcv/ilF7b2
         W4pZyqaIMI0trrVA6OdpECMgQaqEpXYd0vEHKEU1VABARWtk7Ql52bPsPODFmJPtcmxO
         FN85ZYSSBU5qVa0Vs8vEjsNC0xdfT0DOxv/M5zvae2p9NgQhZU0ivuXZ9nAKIDyBCpMD
         EKpWOHxc94FgE8lvYV7Hc9kDGbyCSNH71UquaF1eQZeiihqE5gVPNvLi9siPxb4x/zgm
         fUZQ==
X-Gm-Message-State: AOAM531NxLCWMs99VvXbBUkT3AC4+jTSDjsW7Yxt5/gaq2vRIULoY7sz
        kUdqbRQ/qIRKwhFB1Y1h1xXJVR3LvN+uPm3w
X-Google-Smtp-Source: ABdhPJyuHSH4SPjOXK0z+zD7+LnScwwIvrPSvbbMGfdxyXkIUEeAaHyHkEfvZXEzr4lfhyvkG+TDJQ==
X-Received: by 2002:a6b:590e:: with SMTP id n14mr1442432iob.107.1616570946755;
        Wed, 24 Mar 2021 00:29:06 -0700 (PDT)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com. [209.85.166.172])
        by smtp.gmail.com with ESMTPSA id m20sm705898ilj.66.2021.03.24.00.29.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 00:29:06 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id 19so20518041ilj.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 00:29:05 -0700 (PDT)
X-Received: by 2002:a05:6e02:2182:: with SMTP id j2mr1642748ila.89.1616570945322;
 Wed, 24 Mar 2021 00:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210319055342.127308-1-senozhatsky@chromium.org>
 <20210319055342.127308-4-senozhatsky@chromium.org> <CANiDSCseJdKuPSZFDvc8VGp=PDqGEN42ZsLVGgkwhAz5hhVCQQ@mail.gmail.com>
 <YFqiWixqSuPMTwXz@google.com>
In-Reply-To: <YFqiWixqSuPMTwXz@google.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 24 Mar 2021 08:28:54 +0100
X-Gmail-Original-Message-ID: <CANiDSCujVZy93W=HW317R5rEzEtdaaR8XwA_tu-ZT4eFe1VSrQ@mail.gmail.com>
Message-ID: <CANiDSCujVZy93W=HW317R5rEzEtdaaR8XwA_tu-ZT4eFe1VSrQ@mail.gmail.com>
Subject: Re: [PATCHv3 3/6] media: v4l UAPI: add ROI auto-controls flags
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Sergey

On Wed, Mar 24, 2021 at 3:22 AM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (21/03/23 17:04), Ricardo Ribalda wrote:
> > On Fri, Mar 19, 2021 at 6:53 AM Sergey Senozhatsky
> > <senozhatsky@chromium.org> wrote:
> > >
> > > UVC 1.5 defines the following Region Of Interest auto controls:
> > >
> > > D0: Auto Exposure
> > > D1: Auto Iris
> > > D2: Auto White Balance
> > > D3: Auto Focus
> > > D4: Auto Face Detect
> > > D5: Auto Detect and Track
> > > D6: Image Stabilization
> > > D7: Higher Quality
> > > D8 =E2=80=93 D15: Reserved, set to zero
> > >
> > > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > ---
> > >  include/uapi/linux/v4l2-common.h | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/include/uapi/linux/v4l2-common.h b/include/uapi/linux/v4=
l2-common.h
> > > index 3651ebb8cb23..34f1c262d6aa 100644
> > > --- a/include/uapi/linux/v4l2-common.h
> > > +++ b/include/uapi/linux/v4l2-common.h
> > > @@ -92,6 +92,16 @@
> > >  #define V4L2_SEL_FLAG_LE               (1 << 1)
> > >  #define V4L2_SEL_FLAG_KEEP_CONFIG      (1 << 2)
> > >
> >
> > Are you sure that you do not want to start with 1<<3, there might be
> > some hardware that support LE/SE
>
> How the hardware's going to support this? There is simply no way to
> pass these flags to the firmware, the values already overlap with
> auto-controls. So I guess these flags are for the driver (C code).
> uvcvideo driver is not doing any "lesser or equal rectangle" magic
> for ROI. No such thing is defined by UVC spec.

The driver can implement se/le.

>
> I can move these flags to entirely different value range and do
> remapping to uvc auto-controls values in uvcvideo.
I think that is more correct in this case. Yes it is annoying, but if
more devices support this....



--=20
Ricardo Ribalda
