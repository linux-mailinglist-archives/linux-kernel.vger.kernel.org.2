Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A676B402161
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 01:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhIFXGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 19:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbhIFXGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 19:06:35 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA89C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 16:05:30 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id j16so6621842pfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 16:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RsnUjT2+lUd00F759XigVRFI1hNrAY0fPM7J0dBz5Ak=;
        b=kf8ERraXpY7/9DjZhN2LY8R3OBm2l4f4d41PW8s3L2lEqxeGjqwzu2Qjt/stfq8cgL
         56qKqdFX6vfgJ5Y4h0AKSrTYyQOtLs0m11njbI/0hI48xw+JkeVRU2/WlsWtDtqwG8fQ
         C+VFDvrF9zOmVJWV74mKVg4KXCMnEPXO3oESxojPsZX+ULrmKhpQJEG3QwrfCC7Ba31H
         GuRm9DXurfxNFTW60Q0p8XIbzE5LK21LhdCPQU2NJhy6XOXx8I+5L82rlNSmmdT21l1c
         IOYq8ggVaZTOJBj7D140CRwfzMNGYOsNyKs5UMS7aAmozHfOiQia19JeHJ/KrOwFbe+L
         c69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RsnUjT2+lUd00F759XigVRFI1hNrAY0fPM7J0dBz5Ak=;
        b=AZAd5VSey5+k5j0Qyd5mKJhyZ+MfkqnWdVg1N10LZbx9tP7WbPEWdmimyqQRlFZdJc
         WQ9W7j0s/gQ9UA8WctPRCNE3ZjzNpXdxRTBQXMWrTJnw5Q5SyDqnEcNyf/i1/olC1xCw
         jNki/mxpeqFoDEcEouAahpck0NNsChZ4zrk0B83JxVhKLhdC95OXkbFiI28PDRwJ1aZF
         pvtJt4UP/o3/bEzFbAWrRs5AfWkb8hml5LswsdWWfuOy4SW7np6NHYhT5BOwlLj+xafA
         Xec5P/tRGhoQuaxEsruGHM/XDFR+9QbWX0eY+tu2xWnseEcwBRcjKHfHxPRAFbg7Qx13
         HcPA==
X-Gm-Message-State: AOAM533NwTjEoPMSIK5b9zBIGy85HhWkwURK8XwkZok6lgYsDhYuBxmL
        oj86RLdcUSkFc0V5WtqcyKx1dZU//I4db3SnDhTxfA==
X-Google-Smtp-Source: ABdhPJx5QMGl5O2ZTDIzcGZe6FnwUGR+4uvnqa4pSiPXomY+JNiWgpEPk42WblCceXMK5OcHIFzFWnYGwEYWTLFo/a4=
X-Received: by 2002:a63:ef58:: with SMTP id c24mr14002991pgk.299.1630969529846;
 Mon, 06 Sep 2021 16:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210906010106.898-1-phil@philpotter.co.uk> <20210906010106.898-3-phil@philpotter.co.uk>
 <20210906082535.GK1957@kadam>
In-Reply-To: <20210906082535.GK1957@kadam>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Tue, 7 Sep 2021 00:05:18 +0100
Message-ID: <CAA=Fs0mxo5Ty9RfrWBuq53ycaay5xuw9_wk=Z11J18gpeGnW7g@mail.gmail.com>
Subject: Re: [PATCH 02/14] staging: r8188eu: remove hal_reset_security_engine
 from struct hal_ops
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Sept 2021 at 09:26, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Mon, Sep 06, 2021 at 02:00:54AM +0100, Phillip Potter wrote:
> > Remove hal_reset_security_engine function pointer from struct hal_ops,
> > as it is unused.
> >
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > ---
> >  drivers/staging/r8188eu/include/hal_intf.h | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
> > index 5612274dea4d..3cbe6c277677 100644
> > --- a/drivers/staging/r8188eu/include/hal_intf.h
> > +++ b/drivers/staging/r8188eu/include/hal_intf.h
> > @@ -250,7 +250,6 @@ struct hal_ops {
> >                                 u32 bndy_cnt);
> >
> >       void (*hal_notch_filter)(struct adapter *adapter, bool enable);
> > -     void (*hal_reset_security_engine)(struct adapter *adapter);
> >       c2h_id_filter c2h_id_filter_ccx;
> >  };
>
> I love these patchsets which are removing the HAL layer, but it would
> be better if you folded patches 1 and 2 together because it would be
> easier to review.  That way we can just say "Well, if this patch isn't
> correct it will cause a compile error so let's assume it's correct
> unless the kbuild-bot complains."
>
> There are other pairs in this patchset which are the same way where they
> would be easier to review if they were merged. 3 & 4.  5 & 6.  Etc.
>
> The patcheset is fine but for future reference please fold them together.
>
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> regards,
> dan carpenter
>

Dear Dan,

Thank you for the review, much appreciated. I will endeavour to do
this in future.

Regards,
Phil
