Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1754D3839E0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 18:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243228AbhEQQbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 12:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343950AbhEQQbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 12:31:04 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6D0C0651C4
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 08:14:19 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id g15-20020a9d128f0000b02902a7d7a7bb6eso5816383otg.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 08:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EDmDAQbTIinTvjWFWpqOaAxVq/YEvYPcL1bzV/Ywkm0=;
        b=oeFAkAu1p8MtK3aVQGciBo679NPgetFpY81WLkIyYfkq1sxsjlTgBcM/pHtG5a6hqZ
         1GW706FHuvO5V7DVJd9CyGAOyBRM6SzF9qAzLVKvdZIdpwjtEjjdzWLXe7XEv4iLUdyg
         4vADS2CoJxysIbx6aQ/6+rlowLBQid1fDf6B+KsDRRYtPlqt9XShZKjfTDnLMFd4tSCi
         laB/gtTrPvXyQ2jA/U66KR9GqDE1ELRhY1mBD69pfOC92Os7sGOqo0tg0pbGWXEBALBu
         G5fKng5l2wz50rwqbegiQeeai29IZZzs4eFpqeDZm3zkYq6/V9PjGqlerHAwm7cVCs2g
         6zfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EDmDAQbTIinTvjWFWpqOaAxVq/YEvYPcL1bzV/Ywkm0=;
        b=KBDlF/EuLkOiIRF8B2QsXLPvrvUnGUUBQ4/JUm0RacOpcM1Pkrc7I0dEw2+vLqkY91
         /0I/HNcNFKZNrh2Z9NH5avYwTZfn+fOUGnZ/b4wT2nycvTKm/A6EWFCnAwRkvMrV+Egc
         FNs7iWCkO421loiidm19++C3rtrh+8s88cwEZAWnxsj7DaCwt69aimTrzNzVgQAxYJUN
         7dMNywhpI34iYi2C9S+d+AlCruo5tFRYxMpArXvx/VvwVtlSc5FcwzuT8atXyuywVbe8
         lCJVxANgG8pMXeA+eFiax79Gje9yjFo+QNBM23FF4XVDB8UHc614xtqmFpIG96OSekNo
         DYUA==
X-Gm-Message-State: AOAM533dch3/SZ+yKXUv0e8LfnGfSHQy7T8xzEtiWHJpPr3Fd/fnO/yU
        XEeIg/SlnyT3pvfeDzesq3nJIg==
X-Google-Smtp-Source: ABdhPJwDePRSDx9sYD5pOhBkO2VKs3hyLmNMR4BemKZkIWXGoA8kzlLPIV+fEy7ohWNG8xlbobMY6Q==
X-Received: by 2002:a9d:170b:: with SMTP id i11mr53200ota.161.1621264458755;
        Mon, 17 May 2021 08:14:18 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z4sm3191624otq.65.2021.05.17.08.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 08:14:18 -0700 (PDT)
Date:   Mon, 17 May 2021 10:14:16 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jun Li <jun.li@nxp.com>, Hans de Goede <hdegoede@redhat.com>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: typec: mux: Fix matching with typec_altmode_desc
Message-ID: <20210517151416.GT2484@yoga>
References: <20210516034730.621461-1-bjorn.andersson@linaro.org>
 <CAHp75VdfnM+Vr-8__zHPaQ5wDyv8Eg=DMQ0+HRCpWWrSQBZniw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdfnM+Vr-8__zHPaQ5wDyv8Eg=DMQ0+HRCpWWrSQBZniw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17 May 04:13 CDT 2021, Andy Shevchenko wrote:

> On Sun, May 16, 2021 at 6:47 AM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > In typec_mux_match() "nval" is assigned the number of elements in the
> > "svid" fwnode property, then the variable is used to store the success
> > of the read and finally attempts to loop between 0 and "success" - i.e.
> > not at all - and the code returns indicating that no match was found.
> >
> > Fix this by using a separate variable to track the success of the read,
> > to allow the loop to get a change to find a match.
> >
> > Fixes: 96a6d031ca99 ("usb: typec: mux: Find the muxes by also matching against the device node")
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  drivers/usb/typec/mux.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
> > index 9da22ae3006c..8514bec7e1b8 100644
> > --- a/drivers/usb/typec/mux.c
> > +++ b/drivers/usb/typec/mux.c
> > @@ -191,6 +191,7 @@ static void *typec_mux_match(struct fwnode_handle *fwnode, const char *id,
> >         bool match;
> >         int nval;
> >         u16 *val;
> > +       int ret;
> >         int i;
> >
> >         /*
> > @@ -218,10 +219,10 @@ static void *typec_mux_match(struct fwnode_handle *fwnode, const char *id,
> >         if (!val)
> >                 return ERR_PTR(-ENOMEM);
> >
> > -       nval = fwnode_property_read_u16_array(fwnode, "svid", val, nval);
> > -       if (nval < 0) {
> > +       ret = fwnode_property_read_u16_array(fwnode, "svid", val, nval);
> > +       if (ret < 0) {
> >                 kfree(val);
> > -               return ERR_PTR(nval);
> > +               return ERR_PTR(ret);
> >         }
> 
> This changes the behaviour of the original code, i.e. nval can be
> still positive but less than we got from previous call. Some fwnode
> backends in some cases potentially can _successfully_ read less than
> asked.
> 
> Perhaps
> 
>   nval = ret;
> 
> or drop the patch.
> 

Per the kerneldoc of fwnode_property_read_u16_array:

 * Return: number of values if @val was %NULL,
 *         %0 if the property was found (success),

@val is not NULL, as we just checked for that, so the function will
always return 0 on success.

I don't see anything indicating that the number of elements can be
different from what fwnode_property_count_u16() returned.

Regards,
Bjorn

> >         for (i = 0; i < nval; i++) {
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
