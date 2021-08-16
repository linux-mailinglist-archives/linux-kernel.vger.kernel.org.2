Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB67A3ECF78
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 09:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbhHPHi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 03:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbhHPHiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 03:38:55 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1BDC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 00:38:24 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id e19so19794102pla.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 00:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5VrJu85JawDJ3CQf26LwvcJItsb64t/VJnjpVpHgnxk=;
        b=B1k94xNLEn4C2LuwESfZzOpmqfs3i0/4PQUQEn/2H7HzV2sLehF7kpyB+1JauVOQg5
         c9ykrXyuMd2p4edU/fIdbayrnTil50b1pNU+0gQ6HyQR/Ldsw1syEQYXDZBsAsEAGi0W
         AiRafNwAQAitm20W80EDQ6lxfst9Cdc/8vy/Fh/nTrd5z/Fiz/cilg90rkmuINT6UBju
         iWJHd9nq4rv3MyJB8KP6quvbvMZJ59witkuqTBQLAbGpd+dFhBqfI3yQjiERYzyw0OWk
         erF9cdepqq3kywhmE911Vao6P6CzVLjsxxxriwI05+4fu02QUgbSZjUMtcTkrNSVb8p/
         sQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5VrJu85JawDJ3CQf26LwvcJItsb64t/VJnjpVpHgnxk=;
        b=A+UJCkVKSMrqx/LGiQxPRuANY7gaa2B2KfS3xZw0R8RcfEL+VPaaei3DlbZPNoplPu
         /u9mr3LXqU8VC4VeNt/VBXNxAAvIOxdJ9IH/zk7fRcnvz6+hpid95mwTEZd2C1W+wdWS
         /3Q+k9r2mpIOCR05BCbJ1x4o/OpOgcN11LwWJr4pgxTuOM84Kjo+YhLqPRyPUCk/dagE
         vTx6cbwa51no9wbMTEprDh25tvkKuZK3/d4vDgckCK9GQmCTVgy9VxOoOH1LwVZ+YGjW
         tbioHTIen+R2hfnsY5A4ryJL7japhxz4LDrKY9gljbR+ZTfF+e0O7Qrr9nnYg7IxRGC5
         hR/w==
X-Gm-Message-State: AOAM5329siicCwBVa2mWL2FqDwg7HPTaoYD3IjAhbL4rXCqCEtqTx8Qh
        bgUvf5PzNNFlFKI0u1bmRaEGZoSwzly1BnEad2w94JG18js=
X-Google-Smtp-Source: ABdhPJxFAGi2odbOaRgI0K2SQLqyth4cpZO53gpPBvUZNU3F9bPY8RlTxM6oX+DdW3DxJBxlLSKKBB2c0/05WyF9hP0=
X-Received: by 2002:a65:6a0a:: with SMTP id m10mr14833760pgu.82.1629099503333;
 Mon, 16 Aug 2021 00:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210815230518.91656-1-phil@philpotter.co.uk> <11475165.p2zfeMNkXv@localhost.localdomain>
 <325822103.EpFXLVovdo@localhost.localdomain>
In-Reply-To: <325822103.EpFXLVovdo@localhost.localdomain>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Mon, 16 Aug 2021 08:38:12 +0100
Message-ID: <CAA=Fs0m4sGcGfWcaV3mVkNigaZZ9gxxEhOZAhXESsHMscRxgWw@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: remove unused variable and DBG_88E in hal/rtl8188e_cmd.c
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2021 at 08:01, Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
>
> On Monday, August 16, 2021 8:55:06 AM CEST Fabio M. De Francesco wrote:
> > On Monday, August 16, 2021 1:05:18 AM CEST Phillip Potter wrote:
> > > Remove set but unused variable init_rate from rtl8188e_Add_RateATid
> > > function in hal/rtl8188e_cmd.c, as it fixes a kernel test robot warning.
> > > Removing the call to get_highest_rate_idx has no side effects here so is
> > > safe.
> > >
> > > Also remove the DBG_88E macro call in this function, as it is not
> > > particularly clear in my opinion. Additionally, rename variable
> > > shortGIrate to short_gi_rate to conform to kernel camel case rules,
> > > and improve general spacing around operators, some of which triggers
> > > checkpatch 'CHECK' messages. These are not related to the test robot
> > > warning.
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > > ---
> > >
> > >  drivers/staging/r8188eu/hal/rtl8188e_cmd.c | 22 +++++++---------------
> > >  1 file changed, 7 insertions(+), 15 deletions(-)
> >
> > Dear Philip,
> >
> > I'm sorry but, although every change here is fine, I cannot ack your patch
> as-
> > is. It shouldn't address so many different issues all at once, according to
> > the best practices in patching and the kernel development rules.
> >
> > I understand that you think that, while you are at the removal of
> "init_rate",
> > why shouldn't I address all other trivial issues at once?
> >
> > Even if the patch is short and it probably doesn't require particular hard
> > effort to review it, that mix-up of different works shouldn't be done,
> mainly
> > because this attitude could potentially lead you to add more and more
> > different work in future patches. Where is the limit? Why not add some more
> > different works next time you find some more problems into the same file/
> > directory?
> >
> > If I were you I'd, at least, prepare a series of two or three patches:
> >
> > 1/3 - Remove init_rate as reported by KTR;
> > 2/3 - Remove unneeded DBG_88E macro;
> > 3/3 - Do some clean-up of rtl8188e_cmd.c;
> >
> > Perhaps patches 2/3 and 3/3 could be merged into one, but I'm not really
> sure.
> >
> > Thanks,
> >
> > Fabio
>
> Furthermore, I forgot to say that the "Subject" should summarize with few
> words the whole work you do and in this case it is not what it does.
>
> Fabio
>
>
>

Dear Fabio,

Thank you for your feedback, I shall prepare a v2 series.

Regards,
Phil
