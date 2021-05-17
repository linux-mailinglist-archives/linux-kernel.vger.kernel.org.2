Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A40383A2E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 18:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242873AbhEQQkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 12:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245726AbhEQQjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 12:39:15 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4B2C043143
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 08:44:36 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id t17-20020a4a3e110000b02901fab2f46a48so1562756oot.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 08:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vKjbNm+qWDtQMfOdoaa4ZDvCZPDo9ZFKDTV49+Bk1MM=;
        b=LDYOVo7bifxw9D07bYJY2Sb9XkbfO5vweyr2XB84rtmrbRmZq7zbZqM094rNFBCafx
         pG9FzYuOPNef3W4Qf/a8jrQELLT+eBE8LbdmjDmMNRivPNAFS7nqLQhWsnLn5r1IWu8F
         QP6Yr1qKT55Lejuv7E2IMR+D/StwrNy15NDe0bMmibpTSkwQ9dK/HZkSRcL+tfORv9IE
         22nAyZfG1yjn6fCE4J8eBJRcrY3k0oZ3kxO01zgycWXEJOGVqjiKdFL4jE5q3uzUqz5n
         kFLoWdP0mFHniBAUIwYe1A8Gg+gK2CVBSg/Iq8Yq2bIRENYHNWwwu/kB/SVswqYOhcdM
         rpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vKjbNm+qWDtQMfOdoaa4ZDvCZPDo9ZFKDTV49+Bk1MM=;
        b=NL4Qvb4HVRR0eE3NJFvdo2zrJYjMPmKwQvRVp1kjZR3OLD5FkKQ/xAWIWhbwW03NWP
         U5RybsD10mbGADP9IE4MrlwevKkucf3FBpLDNmATkJeubcYFlpGKGSxCzGXerT2P/H0k
         fcVTsavB2ptdrZC/bj+V/ZqLlVRasTl1ZjpkoFbsjdG26PYS2f+gi7flOWiFEZAQZK/C
         52C0QCWUCHgDk9iD34hA7uz5XT8Pom7FEW1rI2m/4kiQv4lJEb/1tTTxo1ZTi2ECuVry
         c8mOOdVLXFK0Ard2NCgPhYCsOt8i9jSyMM8WFHlkKGYDZdXOSy/7vfJAdy9XUKMyF0DT
         9H6w==
X-Gm-Message-State: AOAM531G7MMr3J29l1a1xa+YgAhw1q9PJz0r1JyhXaPAL+Qc+b9x05KJ
        8o3IAtptEvf2QWdz/KyYB/8SYg==
X-Google-Smtp-Source: ABdhPJwXJLwB0dkG7wxydNRP3vXW/ojAZ7j+qvCQgIDrrL9la6cwoeXOoISDWo/M22Tsx61v19LHYQ==
X-Received: by 2002:a4a:bd04:: with SMTP id n4mr416419oop.29.1621266276028;
        Mon, 17 May 2021 08:44:36 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w66sm3118066ooa.37.2021.05.17.08.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 08:44:35 -0700 (PDT)
Date:   Mon, 17 May 2021 10:44:33 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jun Li <jun.li@nxp.com>, Hans de Goede <hdegoede@redhat.com>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: typec: mux: Fix matching with typec_altmode_desc
Message-ID: <20210517154433.GU2484@yoga>
References: <20210516034730.621461-1-bjorn.andersson@linaro.org>
 <CAHp75VdfnM+Vr-8__zHPaQ5wDyv8Eg=DMQ0+HRCpWWrSQBZniw@mail.gmail.com>
 <20210517151416.GT2484@yoga>
 <CAHp75VdmTKLnGrm19UF5TqYDcNtqCmjt8NWVEDv__5qHsvnF3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdmTKLnGrm19UF5TqYDcNtqCmjt8NWVEDv__5qHsvnF3A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17 May 10:37 CDT 2021, Andy Shevchenko wrote:

> On Mon, May 17, 2021 at 6:14 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> > On Mon 17 May 04:13 CDT 2021, Andy Shevchenko wrote:
> > > On Sun, May 16, 2021 at 6:47 AM Bjorn Andersson
> > > <bjorn.andersson@linaro.org> wrote:
> > > >
> > > > In typec_mux_match() "nval" is assigned the number of elements in the
> > > > "svid" fwnode property, then the variable is used to store the success
> > > > of the read and finally attempts to loop between 0 and "success" - i.e.
> > > > not at all - and the code returns indicating that no match was found.
> > > >
> > > > Fix this by using a separate variable to track the success of the read,
> > > > to allow the loop to get a change to find a match.
> 
> ...
> 
> > > > -       nval = fwnode_property_read_u16_array(fwnode, "svid", val, nval);
> > > > -       if (nval < 0) {
> > > > +       ret = fwnode_property_read_u16_array(fwnode, "svid", val, nval);
> > > > +       if (ret < 0) {
> > > >                 kfree(val);
> > > > -               return ERR_PTR(nval);
> > > > +               return ERR_PTR(ret);
> > > >         }
> > >
> > > This changes the behaviour of the original code, i.e. nval can be
> > > still positive but less than we got from previous call. Some fwnode
> > > backends in some cases potentially can _successfully_ read less than
> > > asked.
> > >
> > > Perhaps
> > >
> > >   nval = ret;
> > >
> > > or drop the patch.
> > >
> >
> > Per the kerneldoc of fwnode_property_read_u16_array:
> >
> >  * Return: number of values if @val was %NULL,
> >  *         %0 if the property was found (success),
> >
> > @val is not NULL, as we just checked for that, so the function will
> > always return 0 on success.
> >
> > I don't see anything indicating that the number of elements can be
> > different from what fwnode_property_count_u16() returned.
> 
> Okay, I have checked the backends of fwnode and indeed, OF case (from
> where I remember such behaviour) deliberately does
> 
> if (ret >= 0)
>   return 0;
> 
> Otherwise the rest return 0 directly / explicitly.
> 
> The only exception is _read_string_array().
> 

I wasn't aware that the string array behaved difference, and the
kernel-doc gives no hint either. Thanks for pointing it out.

Regards,
Bjorn
