Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAFB31F95B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 13:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhBSMVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 07:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhBSMV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 07:21:28 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA409C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 04:20:48 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id o7so4345815ils.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 04:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EEb1UJDvgCRWaCo3f0yPJzWzHS0WltOW5+cgoN1g8l0=;
        b=Rsn1RPwp1k60poOFHRWlw9M0/3JIL7NmKup0Ycj2Y4wQ5N9BYDy4RrtoLGbCOdKSBn
         ofgbLOTOCrbuFYub/HgUpaduHvVVUg05A6aUTdOwdwLtsi8qNOo5TGn6FhiYdAwutOgE
         CJF0ECtGRrWb7NyqjaOhFfmnFZJI4pbF/HiRbkrhrvnpXM3fbzP5bq+7KQ59NFZ2nGo/
         YbjgH2n8wIm1czRnP5vawyWPAyRRqgncy9Kf9ubY89bXf+3yGfRrDWt6Pozm6I2Kq7kA
         fawGTEk14rTx+74R1c2/1H1lftOFttqJeianooi/h2DhgOXnaNCD0kB9UC13kiWGECqy
         IoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EEb1UJDvgCRWaCo3f0yPJzWzHS0WltOW5+cgoN1g8l0=;
        b=GA/QPCOEyJHNiAqY+Z6fza0JsAn5yZ8QqzPwI1jCpfpJRyl8fwVs490gPZxLjxJN/y
         M5XGMEd8Ml4MfA2K0vn3dqhAmlAl3WP7JGtyCBSVQJcXBQyBUIkY2TVoiukKEyVy0sMX
         qzO8MMxkvA6HCw6vLH46bgMcRqWlUbtBrbDexh2CpyxFPpBn/g4RRgyKeTYJDOKIFQRo
         NDyZ7u/pF2TLOWWSFfi7DLNQ/5uPX7W3rQvElJOV/LmGHy5nV/8mkiYIRKn0s+Hk59QT
         cJfqdEbqqMX/c56sfzvJ/Pg2EZUipCynUEaxtXxdnZSWVNJIlQjgUGdHmfycPglM4c4z
         TSPA==
X-Gm-Message-State: AOAM532pPf4uoXgnOHqAaCLrdS7lZ2POWowJ9uFa3vZEvcuNAI/jqNv3
        49Bt/SdHJy5MgPSLHAEBS9cOAtPF3GMnalSljtA=
X-Google-Smtp-Source: ABdhPJw5G19nuIDpQC28jqcYTsaptWnbhNgKMn4wtxZ1408VLOIBY66rOT/CjgJZRXEIEMrWCtgMmmvtLxmRvIXQVNE=
X-Received: by 2002:a05:6e02:20ca:: with SMTP id 10mr3793892ilq.14.1613737248080;
 Fri, 19 Feb 2021 04:20:48 -0800 (PST)
MIME-Version: 1.0
References: <20210219095835.9687-1-selvakumar16197@gmail.com> <20210219121219.GZ2087@kadam>
In-Reply-To: <20210219121219.GZ2087@kadam>
From:   Selvakumar E <selvakumar16197@gmail.com>
Date:   Fri, 19 Feb 2021 17:50:37 +0530
Message-ID: <CAD=cR89QCJ_6a20Pn9f2V6Zc5dTx86MbdwyrokjHbg70KmC1qw@mail.gmail.com>
Subject: Re: [PATCH] staging: vt6656: fixed a CamelCase coding style issue.
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        tvboxspy@gmail.com, oscar.carter@gmx.com,
        devel@driverdev.osuosl.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan Carpenter

Thanks for the feedback, I'll work on the suggestion and come back with a fix.

Regards
Selvakumar Elangovan

On Fri, Feb 19, 2021 at 5:42 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> You're not asking the right questions.
>
> On Fri, Feb 19, 2021 at 03:28:35PM +0530, Selvakumar Elangovan wrote:
> > This patch renames CamelCase macros uVar and uModulo into u_var and
> > u_module in device.h
> >
>
> Is "u_var" a good name?  What does the "u_" even mean?
>
> > This issue was reported by checkpatch.pl
> >
> > Signed-off-by: Selvakumar Elangovan <selvakumar16197@gmail.com>
> > ---
> >  drivers/staging/vt6656/device.h | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/staging/vt6656/device.h b/drivers/staging/vt6656/device.h
> > index 947530fefe94..6615d356f74a 100644
> > --- a/drivers/staging/vt6656/device.h
> > +++ b/drivers/staging/vt6656/device.h
> > @@ -385,11 +385,11 @@ struct vnt_private {
> >       struct ieee80211_low_level_stats low_stats;
> >  };
> >
> > -#define ADD_ONE_WITH_WRAP_AROUND(uVar, uModulo) {    \
> > -     if ((uVar) >= ((uModulo) - 1))                  \
> > -             (uVar) = 0;                             \
> > +#define ADD_ONE_WITH_WRAP_AROUND(u_var, u_modulo) {  \
> > +     if ((u_var) >= ((u_modulo) - 1))                        \
>
> The \ is not aligned any more.
>
> > +             (u_var) = 0;                            \
> >       else                                            \
> > -             (uVar)++;                               \
> > +             (u_var)++;                              \
> >  }
>
>
> This macro is rubbish.  How does the wrap around even make sense?
> I hope that if you review the code a bit I think you will find that the
> wrap around is impossible?  Just fix the two callers and delete this
> macro.
>
> regards,
> dan carpenter
>
