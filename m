Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A03B3827FC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235944AbhEQJQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236055AbhEQJPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:15:55 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F34C061345;
        Mon, 17 May 2021 02:14:03 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 6so4214754pgk.5;
        Mon, 17 May 2021 02:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y6Pn9mx0oa+zZOR1RR5HsAVqA5vf2WVvZJFn6cIRn3Y=;
        b=bk2ubwLcnz9XD9HYt/P3H/Exsf1giR1Z53CCh6ZfnzPxlhfo11b0bYMHJdiL/eIkry
         7YEPMWWTHuHUqJkZICFM1PTD+vgX/FYQrdPRbA29t/pymZKjo6MMk9IECVCpZijqkEL6
         4I2KCSFbttOI305WKfAA9Uxz/UC/ckaUFk0FZ0CD0RsNEUhLZXVsmHQSzhSjRxXnVS0b
         QPtDRelH7ZJqgJmUtUBPunynOhWy1ZZuQ2WO1hFKykvSSOnPHBbQjwFZiIYWuSy9Trkt
         eKKEtkLndUqFbJD9pdRGTIhC0jIe8TNBhah1gM/F1G66F4Mndv4RvVT6rIpRvnspDSoG
         2IcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y6Pn9mx0oa+zZOR1RR5HsAVqA5vf2WVvZJFn6cIRn3Y=;
        b=MXsLB/l+EMEmSxYYLGY6srYUKJMXX4jhSKmmlUfo13UhmRn8H+8vT50xxZoqVv9sXH
         6V/a+8/2xIhxBPEaEr65VVDMaiFX0T5aRHj6EdN2OZQhXIcJjMlTEr7K0F4nnaeQKDTa
         lpokUjbsTmMvadpttML9XT7U15WAHZ98daZgOHNcNeNRnelQQhj6lx8/bV8Rg4DKl1Lc
         Qta2mJgg0nOdOkWHNB6lZtE0OkLryfc6DxO2QSSDMrm67QOUp/2Q3Zsa7gh78efQEOQ8
         5DAiZtv22iknD5XTs5Xe0Fp+OEF1j21C8mWspurR9YNHEZZysvJc65ur2g5S9GBcWMg8
         ECmA==
X-Gm-Message-State: AOAM532DayS+Pdl+oQXI9KPLofn+8X4mlK0p1rCZfc9fQm8K9CmVQWso
        RuvpNczEjvaNkG13avt33Vy+7UKOkBWo/+7VfJM=
X-Google-Smtp-Source: ABdhPJz0MRXMOypn+UFBhKbHbrC57AMWMbpyv/JFcsDJFcnIRWj5yYuJ4VGMxKiloxebjn+yB7zZGtKZW/sCWozi78o=
X-Received: by 2002:aa7:985c:0:b029:2c4:b940:f77b with SMTP id
 n28-20020aa7985c0000b02902c4b940f77bmr36446374pfq.73.1621242842553; Mon, 17
 May 2021 02:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210516034730.621461-1-bjorn.andersson@linaro.org>
In-Reply-To: <20210516034730.621461-1-bjorn.andersson@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 17 May 2021 12:13:46 +0300
Message-ID: <CAHp75VdfnM+Vr-8__zHPaQ5wDyv8Eg=DMQ0+HRCpWWrSQBZniw@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: mux: Fix matching with typec_altmode_desc
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jun Li <jun.li@nxp.com>, Hans de Goede <hdegoede@redhat.com>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2021 at 6:47 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> In typec_mux_match() "nval" is assigned the number of elements in the
> "svid" fwnode property, then the variable is used to store the success
> of the read and finally attempts to loop between 0 and "success" - i.e.
> not at all - and the code returns indicating that no match was found.
>
> Fix this by using a separate variable to track the success of the read,
> to allow the loop to get a change to find a match.
>
> Fixes: 96a6d031ca99 ("usb: typec: mux: Find the muxes by also matching against the device node")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/usb/typec/mux.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
> index 9da22ae3006c..8514bec7e1b8 100644
> --- a/drivers/usb/typec/mux.c
> +++ b/drivers/usb/typec/mux.c
> @@ -191,6 +191,7 @@ static void *typec_mux_match(struct fwnode_handle *fwnode, const char *id,
>         bool match;
>         int nval;
>         u16 *val;
> +       int ret;
>         int i;
>
>         /*
> @@ -218,10 +219,10 @@ static void *typec_mux_match(struct fwnode_handle *fwnode, const char *id,
>         if (!val)
>                 return ERR_PTR(-ENOMEM);
>
> -       nval = fwnode_property_read_u16_array(fwnode, "svid", val, nval);
> -       if (nval < 0) {
> +       ret = fwnode_property_read_u16_array(fwnode, "svid", val, nval);
> +       if (ret < 0) {
>                 kfree(val);
> -               return ERR_PTR(nval);
> +               return ERR_PTR(ret);
>         }

This changes the behaviour of the original code, i.e. nval can be
still positive but less than we got from previous call. Some fwnode
backends in some cases potentially can _successfully_ read less than
asked.

Perhaps

  nval = ret;

or drop the patch.

>         for (i = 0; i < nval; i++) {


-- 
With Best Regards,
Andy Shevchenko
