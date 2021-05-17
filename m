Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C33383A18
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 18:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245603AbhEQQh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 12:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245260AbhEQQhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 12:37:52 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CD2C0816F9;
        Mon, 17 May 2021 08:38:07 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so3929264pjv.1;
        Mon, 17 May 2021 08:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Bg9e5GSjj736fnDp80ETYuzRsaqdlxSaM386v8GCn0=;
        b=BwE2XYtDeFP72pRAlxQnf3Aj2GR5JRoQoDXL2f3UNT8wNr46YXt0joCH7FaK8Edf/Z
         to7ojMRwXfx+tVIne2L7eRw+s0OeHqqBIGiqb0oyaLBJc4LD0dCqIz1LUfjHxlJRZrWw
         r1NU3xHCe0aXmg4rlA9R8kldYdZ5ysABNCxgKM2PYOZg87JU8gN+1SECC7ocepNh/8UZ
         CwXufZGR7HxMPKT+iQY9vgT/wNHS1L8/YCIFgKmFGuhLauSjSG125bvAP83Yr8ElKJma
         Egv98Q2q7aS2C9IFaS/v0OVf1TsmWViej3UUOJ4XZNCKCxF6XmCZAQsjHWBzk+QBj1Ta
         OtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Bg9e5GSjj736fnDp80ETYuzRsaqdlxSaM386v8GCn0=;
        b=RMihzRIWkc3EkK/17ONjukopononx4ZbMKYJU6b649d/S8u57I0IxFnO4kXHG7jNpy
         LSpKOqpcf0+zUO6ewneqfm3eg8iuEDDlKBF9zNVAQrDIuAJlvhLtjMRjz5URVrturIsV
         cpH85i+cmRWjPwb/QZWzRnHhxxwxBTlSbutJoP/4ZgWjVEErKP7oMnTar12lRzNZH68s
         LKI7ILrufj0GhHq4K3xhtQyzQfju8jcD5E8oGkQttghHoqcgW8tlUKpn9r3kO2q1xSXC
         s1n4Ojcv0cDUGW15oXDOWRsmy0UdEd6CdgEivnT5+AC6QYVQDNcGO0vv+dR1tU0H/nns
         KJzA==
X-Gm-Message-State: AOAM530KpVZ81WSSK8OR9a2D37K3eaon5GAYDB/rZDSN+I998vCDadfN
        bCi143//BmSGTNLT+P3rVJR7CiyYRZMC9jIk5HU=
X-Google-Smtp-Source: ABdhPJz34+noXoLLnWMqlFwNc9eDg9UvjNflkG+CYO21Qf9/Zv5MGNS2kk3tvRlxLbN+4F2LNTBYdOfY7nhJ91+HN9Y=
X-Received: by 2002:a17:902:264:b029:eb:3d3a:a09c with SMTP id
 91-20020a1709020264b02900eb3d3aa09cmr643155plc.0.1621265886581; Mon, 17 May
 2021 08:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210516034730.621461-1-bjorn.andersson@linaro.org>
 <CAHp75VdfnM+Vr-8__zHPaQ5wDyv8Eg=DMQ0+HRCpWWrSQBZniw@mail.gmail.com> <20210517151416.GT2484@yoga>
In-Reply-To: <20210517151416.GT2484@yoga>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 17 May 2021 18:37:50 +0300
Message-ID: <CAHp75VdmTKLnGrm19UF5TqYDcNtqCmjt8NWVEDv__5qHsvnF3A@mail.gmail.com>
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

On Mon, May 17, 2021 at 6:14 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Mon 17 May 04:13 CDT 2021, Andy Shevchenko wrote:
> > On Sun, May 16, 2021 at 6:47 AM Bjorn Andersson
> > <bjorn.andersson@linaro.org> wrote:
> > >
> > > In typec_mux_match() "nval" is assigned the number of elements in the
> > > "svid" fwnode property, then the variable is used to store the success
> > > of the read and finally attempts to loop between 0 and "success" - i.e.
> > > not at all - and the code returns indicating that no match was found.
> > >
> > > Fix this by using a separate variable to track the success of the read,
> > > to allow the loop to get a change to find a match.

...

> > > -       nval = fwnode_property_read_u16_array(fwnode, "svid", val, nval);
> > > -       if (nval < 0) {
> > > +       ret = fwnode_property_read_u16_array(fwnode, "svid", val, nval);
> > > +       if (ret < 0) {
> > >                 kfree(val);
> > > -               return ERR_PTR(nval);
> > > +               return ERR_PTR(ret);
> > >         }
> >
> > This changes the behaviour of the original code, i.e. nval can be
> > still positive but less than we got from previous call. Some fwnode
> > backends in some cases potentially can _successfully_ read less than
> > asked.
> >
> > Perhaps
> >
> >   nval = ret;
> >
> > or drop the patch.
> >
>
> Per the kerneldoc of fwnode_property_read_u16_array:
>
>  * Return: number of values if @val was %NULL,
>  *         %0 if the property was found (success),
>
> @val is not NULL, as we just checked for that, so the function will
> always return 0 on success.
>
> I don't see anything indicating that the number of elements can be
> different from what fwnode_property_count_u16() returned.

Okay, I have checked the backends of fwnode and indeed, OF case (from
where I remember such behaviour) deliberately does

if (ret >= 0)
  return 0;

Otherwise the rest return 0 directly / explicitly.

The only exception is _read_string_array().

> > >         for (i = 0; i < nval; i++) {

-- 
With Best Regards,
Andy Shevchenko
