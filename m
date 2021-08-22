Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16153F4030
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 16:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbhHVO7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 10:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbhHVO7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 10:59:03 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EECBC061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 07:58:22 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y11so13098267pfl.13
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 07:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZrJiEr09vjMy6mI2+ykFgIl7I69Q/36IiW2OvUK4i3M=;
        b=JV2eL7bMtmTEu9p+NkW2Y+dtmfBXQSZN/f6twwLfwEuZ0awNYucAku/VdQ0BeA55ZC
         LXUk4YnujCrbS7A3SYzgnTzECEgp6cPurpOQ9gBFsUrvV3m9+ujV+ACYAciQxch3l1mf
         E4BI94IO5Xc2BMJwgWJ81JYKRaEsanTlP3kTxSmEmX5+Ixv+Q2DSsIHE3L9gsuwgZ/hp
         blTOeRR9Vxt/QL9PllYE2+chNVI0ZmGdg5SfrE6fxv2EvQ//2nHx7MSRhMzyXs/AfpYQ
         SmR0FTE1phpqfnXSypN8upNPdtJpTKHKyc5O6T/pp04Y0uFxqpzDNNKT7Ui62rktHb8v
         oXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZrJiEr09vjMy6mI2+ykFgIl7I69Q/36IiW2OvUK4i3M=;
        b=Z3tnYtN1eACJ4CNRmlz54gQ8IHdPzVFun/pX8ZaovvFFR4gBhXkoRtKf4t3z3+MpWc
         pz2j8ibbuxrQXjIy5G8JKUK87o/YiMJhOZIQ6V8GDX6fs6I1aWX9iuh+PE824FLflQ7A
         uQcwWXVHQIt6QNjV0gGKptL6qRC18GUnaExDrg0U3qB7CJZBnu45X9wv+hOgzV4gKkZ2
         aJLPoFkxyBbWRi9vj0IzhmU3CwshfZiXsdgX7r5vniS2DqwkuFDl/uyNSSJ9vsqLwJDr
         Vd/dqkfo3+k/hsa1e9u3y+RYQLHiURN+NszrsPlxSFbv7GztIqm1xe1EaPH2WNzG8FyL
         BOTw==
X-Gm-Message-State: AOAM5333t0YOdaciZDIOOv30MUj4e1BXgASZsxk/8UgROZUXY7foSs6j
        jl9njhzZCtzVR9D00qJ8+ns3Pr4oojzJiuSlEwoBVA==
X-Google-Smtp-Source: ABdhPJyXKWs7oBUytsfLTRz6W7adqsBqkpsdGnWsMugoiyviBLbLvjl60mL4kUzkCah9Kgx0vmR09o3NwN1E05IQBOs=
X-Received: by 2002:a62:5c6:0:b029:341:e0b1:a72c with SMTP id
 189-20020a6205c60000b0290341e0b1a72cmr29600516pff.71.1629644301902; Sun, 22
 Aug 2021 07:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <YSFgrLUfXzgcT6k4@user> <CAA=Fs0kByg1NztU+Nf__RUzTHuVh_q2hvcyh+3JqXiVgn+_VeQ@mail.gmail.com>
 <1821445.fzUCeO1EU3@localhost.localdomain>
In-Reply-To: <1821445.fzUCeO1EU3@localhost.localdomain>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Sun, 22 Aug 2021 15:58:10 +0100
Message-ID: <CAA=Fs0mu4m04_Be4-f=W+=_hhGn5oJ2q=KOmZdRrMyGhMgqc-Q@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: core: remove condition with no effect
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        saurav.girepunje@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Aug 2021 at 12:06, Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
>
> On Sunday, August 22, 2021 1:58:10 AM CEST Phillip Potter wrote:
> > On Sat, 21 Aug 2021 at 21:23, Saurav Girepunje
> >
> > <saurav.girepunje@gmail.com> wrote:
> > > Remove the condition with no effect (if == else) in rtw_led.c
> > > file.
> > >
> > > Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> > > ---
> > >
> > >  drivers/staging/r8188eu/core/rtw_led.c | 5 +----
> > >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > Thanks for this, looks good.
> >
> > Acked-by: Phillip Potter <phil@philpotter.co.uk>
> >
> > Regards,
> > Phil
>
> Dear Philip,
>
> Before acking, please check at least if it applies to the current version of
> the tree and check if it compiles without adding warnings and / or errors. :-)
>
> Thanks,
>
> Fabio
>
>
>
>

Dear Fabio,

An Acked-by merely signals acknowledgement of the patch, and that is
looks OK to the person offering the tag. Please see the following
quote from the kernel.org documentation:
"Acked-by: is not as formal as Signed-off-by:. It is a record that the
acker has at least reviewed the patch and has indicated acceptance."
It is not, to my knowledge, a commitment from the reviewer that the
patch applies to the given tree at that precise moment in time.

I reviewed the patch, and indicated my acceptance - the content of the
patch is fine. Whilst I will often make an effort to merge + build
test many patches, I will not do this with all of them, I simply don't
have the time due to other commitments. You can be assured that if I
have offered this tag I have at least read the patch and it looks
correct to me.

Particularly with a driver as in flux as this one, there are going to
be many merge conflicts. Advice such as this to me is not particularly
helpful, as I can promise you I'm trying :-)

Regards,
Phil
