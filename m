Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDE345C9F4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 17:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348767AbhKXQ2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 11:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348742AbhKXQ2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 11:28:40 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149D7C061574;
        Wed, 24 Nov 2021 08:25:30 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id y13so12815270edd.13;
        Wed, 24 Nov 2021 08:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N+0513+tPJAoiuSxQyruSWrPHQwkKTbPLjcwm6Qo8Wo=;
        b=GuLxyfcIIu5TUTlBT5R4g2Xr4EPMv4zH8Y7pUWZFR4Sti4v0kmMNYBO9Ozf0o90hYG
         TC4RqBalXwWmfgfeaWxvWjHknJPX9NvzAD2iUrQFsz4MGD4LyriFW4aX95LttaGvgUDP
         96fLQDa9R85Db/zpzf1boza5xvyhzTB4sXRhjVnjDQzTnr62IDOvKV3QP9v0jAL9XLd0
         Nh6lH4KbCpL9ja+C8PircBNhYx3fjpDnjPNPXbkr52xYATY2vaiIQV1n+1BAeIB9ioyT
         c4IxKU2ZlMRLyrFnWHbVkI3wx2aAxx8nUPFwvN1WEqay7QjN3uYIecun4cVhUTKxXPOl
         mAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N+0513+tPJAoiuSxQyruSWrPHQwkKTbPLjcwm6Qo8Wo=;
        b=hKlKEYWuV6/pFnCIXSPfqWjsPwGe/6i7mTm4N6rGkHm3iUU4HIStwGk521Uai57saT
         yNxh2iQQ/ETVLBEuAqVe5k3EaSYa6Dg/gKOGUK1pEzWHh5eBHhM78/KyS5aPXRZrhuJ6
         zxxq0U7obg4SuovppmRrYgcATuIk9bBAgG+evncLUUGpGVyq8LLWkm1cDpjp5g7bNOHz
         ZJbZm2cmFMmV/YDahgTjU1vDJHmaHCRjpp15KN0i9phvj4ssOiMje79HHR8QO4jXWsZ+
         Reg1G8oDYTqPQbA8Juo80C8Nlk5cSqGtEuNW2lP2wYLdiUTdHI1P7o/S7b0ioZc9ASyz
         ioRw==
X-Gm-Message-State: AOAM533TagcE9DlywU76dHme7J/hB8D9Q6MC2LmSXLll5+EM97drmbG7
        STvjN3uAZmgRkr29Nj+ptKnDHClJeHUPC648xDy0+BIFwbY=
X-Google-Smtp-Source: ABdhPJzrrLVjIJ9PgqdEJmBnnaAooAhDNbBsZW9KDrRRdHRgV9T0ter4KlQBRzEeuDv/uN1YH5SQ5wieaDAWu52WPl8=
X-Received: by 2002:a05:6402:51c7:: with SMTP id r7mr26644917edd.359.1637771128594;
 Wed, 24 Nov 2021 08:25:28 -0800 (PST)
MIME-Version: 1.0
References: <20211122212850.321542-1-pauk.denis@gmail.com> <20211122212850.321542-4-pauk.denis@gmail.com>
 <CAHp75VeKosontsmFJSp-fbV9mPiSWJeLUCpx90=RHy1HFfBDnA@mail.gmail.com>
In-Reply-To: <CAHp75VeKosontsmFJSp-fbV9mPiSWJeLUCpx90=RHy1HFfBDnA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 24 Nov 2021 18:24:51 +0200
Message-ID: <CAHp75Vdr+9zoWG74d0ZfGEjj_b1xkX7gw1ka_4NkGtjmvKB73A@mail.gmail.com>
Subject: Re: [PATCH 3/3] hwmon: (nct6775) add MAXIMUS VII HERO.
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        thomas@weissschuh.net, Olli Asikainen <olli.asikainen@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 6:21 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Nov 22, 2021 at 11:29 PM Denis Pauk <pauk.denis@gmail.com> wrote:

...

> > +               if (access == access_asuswmi &&
> > +                   nct6775_asuswmi_read(0, NCT6775_PORT_CHIPID, &tmp)) {
> > +                       access = access_direct;
> > +                       pr_err("Can't read ChipID by Asus WMI.\n");
> > +               }
> > +
> > +               if (access == access_asuswmi) {
> > +                       if (tmp)
> > +                               pr_info("Using Asus WMI to access %#x chip.\n", tmp);
> > +                       else
> > +                               access = access_direct;
>
> Why not:

>         if (access == access_asuswmi) {
>                access = access_direct;

Oh, just noticed above... Looks not good due to possible confusion
which means this part needs to be thought through and refactored,
perhaps by intermediate variable that defines the access and then you
assign access= to it if it satisfies the conditions.

>                if (nct6775_asuswmi_read(0, NCT6775_PORT_CHIPID, &tmp))
>                        pr_err("Can't read ChipID by Asus WMI.\n");
>                if (tmp) {
>                        pr_info("Using Asus WMI to access %#x chip.\n", tmp);
>                       access = access_...; // do you have this?
>                }
>                ...
>         }
>
> ?


-- 
With Best Regards,
Andy Shevchenko
