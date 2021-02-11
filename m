Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E34318C54
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 14:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbhBKNng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 08:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbhBKNaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 08:30:13 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74431C061756
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 05:29:30 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id g9so5055278ilc.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 05:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+1PGaICu35HhDzgMzO5NHONNx9MaqmRJbxjeQ/aAm4g=;
        b=RjyuLWY072LWh3cz4MddJBWKw67LrG6KF2Gn98KWQbCOiGCrLiPYw2Nza6xS4jywni
         Yn6ylocApTCXn8C1NITTuWKOU57tc8oczW+uTYBHvkbr59xszDQ/Io2zNCE0Ag/s6hGj
         JKK77s/YFzLXHPLlOhczVB55hWUjS5qPYaPHMMBILd24LurOHadnb2htZlFlPI9oF+iJ
         izrwDpU6qEdPAM2k7+2i6liwSsmumYZLcEwycs37qJCUE2acV4TQrNplB9+7ExlLMh6l
         78av5uLZRusQKp87vQLSst5JM/xoSoIPsOUkVm37PM+RWIY9mQn/HjmaW87Kc3LV01Mf
         fv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+1PGaICu35HhDzgMzO5NHONNx9MaqmRJbxjeQ/aAm4g=;
        b=dQd5xD12xRgnsRVpFnR9gb/mVzsAfs5JQDwLgNeBuyBipHEllUdUy6/vN2cJOmr1lN
         sQjOMZvOkyVcB+ZSlhU3w9RvmIwu1VMFMIWnTFzN85DvrffisJIJ/WuEdap17AkLU19m
         y3AfLUJKaBe5i9bsZmAEYms4kl5j8DM4RZHFknUeoayTuv/92xSr66nHfw8cXEcDEuWu
         IN/73CizKfKdf4g/QVttH8JlVrVCvrrWtPe6pvv9jA+LwrL8JJpdneAGT+HO4bZs9UCx
         Btm7xMaJhL0IKHZpBW/5CSF47Mdhjf9jl9gibcooX7rCwveRA8zc8HwVUNk+qpesffiN
         kinw==
X-Gm-Message-State: AOAM532v4vxi2wCaFDDN8sHgxLK8EUho4w3XZ/K/oLtJosAXOLbpsY0I
        IUm8hdhamUJBaVUF9ad6DgnTdaypGTbsRainDXyhzIMQXdo=
X-Google-Smtp-Source: ABdhPJx7BZ/fjvJqT5ulGBLAfu2CVUG6bEAiMcbbdG9h2iiY5UTWo2gsgGuj9eXcqw63RflxRg4e8HHPNYp+txWfE0c=
X-Received: by 2002:a05:6e02:144d:: with SMTP id p13mr5524827ilo.41.1613050169789;
 Thu, 11 Feb 2021 05:29:29 -0800 (PST)
MIME-Version: 1.0
References: <20210211092239.10291-1-yildirim.fatih@gmail.com>
 <YCUAy1VhLV3lwa3H@kroah.com> <20210211105704.GA10351@TRWS9215.usr.ingenico.loc>
 <YCUQtJk1XMsBRGBz@kroah.com> <20210211122324.GA10415@TRWS9215.usr.ingenico.loc>
 <YCUopYrr8dAr6yio@kroah.com>
In-Reply-To: <YCUopYrr8dAr6yio@kroah.com>
From:   Fatih YILDIRIM <yildirim.fatih@gmail.com>
Date:   Thu, 11 Feb 2021 16:29:18 +0300
Message-ID: <CAGt6v+NAmNNi8b0FbtvrvEfgnmOmait0J4O8WqadwO7bPXOqLA@mail.gmail.com>
Subject: Re: [PATCH -next] staging: ks7010: Macros with complex values
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        gustavo@embeddedor.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, thanks!

On Thu, Feb 11, 2021 at 3:52 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Feb 11, 2021 at 03:23:24PM +0300, Fatih Yildirim wrote:
> > On Thu, Feb 11, 2021 at 12:10:44PM +0100, Greg KH wrote:
> > > On Thu, Feb 11, 2021 at 01:57:04PM +0300, Fatih YILDIRIM wrote:
> > > > On Thu, Feb 11, 2021 at 11:02:51AM +0100, Greg KH wrote:
> > > > > On Thu, Feb 11, 2021 at 12:22:39PM +0300, Fatih Yildirim wrote:
> > > > > > Fix for checkpatch.pl warning:
> > > > > > Macros with complex values should be enclosed in parentheses.
> > > > > >
> > > > > > Signed-off-by: Fatih Yildirim <yildirim.fatih@gmail.com>
> > > > > > ---
> > > > > >  drivers/staging/ks7010/ks_hostif.h | 24 ++++++++++++------------
> > > > > >  1 file changed, 12 insertions(+), 12 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
> > > > > > index 39138191a556..c62a494ed6bb 100644
> > > > > > --- a/drivers/staging/ks7010/ks_hostif.h
> > > > > > +++ b/drivers/staging/ks7010/ks_hostif.h
> > > > > > @@ -498,20 +498,20 @@ struct hostif_mic_failure_request {
> > > > > >  #define TX_RATE_FIXED                5
> > > > > >
> > > > > >  /* 11b rate */
> > > > > > -#define TX_RATE_1M   (u8)(10 / 5)    /* 11b 11g basic rate */
> > > > > > -#define TX_RATE_2M   (u8)(20 / 5)    /* 11b 11g basic rate */
> > > > > > -#define TX_RATE_5M   (u8)(55 / 5)    /* 11g basic rate */
> > > > > > -#define TX_RATE_11M  (u8)(110 / 5)   /* 11g basic rate */
> > > > > > +#define TX_RATE_1M   ((u8)(10 / 5))  /* 11b 11g basic rate */
> > > > > > +#define TX_RATE_2M   ((u8)(20 / 5))  /* 11b 11g basic rate */
> > > > > > +#define TX_RATE_5M   ((u8)(55 / 5))  /* 11g basic rate */
> > > > > > +#define TX_RATE_11M  ((u8)(110 / 5)) /* 11g basic rate */
> > > > >
> > > > > But these are not "complex macros" that need an extra () added to them,
> > > > > right?
> > > > >
> > > > > Checkpatch is a hint, it's not a code parser and can not always know
> > > > > what is happening.  With your knowledge of C, does this look like
> > > > > something that needs to be "fixed"?
> > > > >
> > > > > thanks,
> > > > >
> > > > > greg k-h
> > > >
> > > > Hi Greg,
> > > >
> > > > Thanks for your reply.
> > > > Actually, I'm following the Eudyptula Challenge and I'm at task 10.
> > >
> > > First rule of that challenge is that you are not allowed to talk about
> > > it in public :)
> > >
> > > That being said, you didn't answer any of my questions above :(
> > >
> > > greg k-h
> >
> > Ohh no, missed the rule. Sorry for that, I feel rookie :)
> > You are right, they are not complex macros.
> > Besides that, type cast operator doesn't have the highest precedence.
> > So, I think we can use enclosing paranthesis.
>
> I don't think they are needed, see how these are used please.
>
> thanks,
>
> greg k-h
