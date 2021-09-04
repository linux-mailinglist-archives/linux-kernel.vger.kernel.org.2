Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0124F400AA8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351152AbhIDJmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 05:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbhIDJmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 05:42:07 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF3EC061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 02:41:05 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id z18so3117669ybg.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 02:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B95LSNh4DxANXXI32CweDKSCOVhWFK+5AxEuGEObjTo=;
        b=I8bYMiYxp52sImFm8KTy5Q3CtcxU/gRVW3iRfJnOrpJ/0CJ47Rb426ypeQJSX7Lzoj
         /wA/gQEjfwP0TVNrtxjtmUQhhRbwxcNWmzl4peW87JQ/sFASGLcRW5jfCewE0GYXN4DL
         oeIz3Gn0mwVG5YKRQ41eLWBdFm0BmEZAcGWmYQitP83PYpJ3xy05FsE88duQeD8VmFyZ
         KR3OdoXF183GUzMk1Ajt0EepoWpY47yqRKw+9FC6WFHJP1sLlfeGbigXqSlsrCFQ9h5v
         tIUZ/gjHfWwd1XSQIF6/VdANd5o0p8PyYyZN5nT3l3sUkXNZOd0MyEIpoL3AEnb394qd
         gyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B95LSNh4DxANXXI32CweDKSCOVhWFK+5AxEuGEObjTo=;
        b=O4KaDDW7bbgiO4rPcqsOQ3hKE8EpKguumrKTiaTOVZQ2cAQUuo407MHoyiLcePb0vQ
         8vzyPIqr3Xv5kmGDwj6sN70k9Q8P1EnwIGRTrKyFeSPurbsIs+LbUplEdeAvmeMQniIj
         EkqNHl5SXXXNVvSRUEy4QsRmjp+5jWw/rW9QiuZGnHjhYawWkkspwtNMHsWbqZ987gkO
         KPZNkeR5ThS1TZBHRo8prx2Q6zrD0hfM0cOI6jehIruRFzHE12rqPNrnB6Ol98F/pd49
         bS/myS9G94bQf7txmDXFCZ8Hurq1WGgOmvBxev2E5oi48JE0OhhQqKO2YLLTsiukCxHx
         nOkg==
X-Gm-Message-State: AOAM533AuBuqeAU4MTRAMhCQCWhT5jgkTgwMUkdbdI2ouIQMvqtCqDHT
        KZ2ET8GrxS8YfYWHPf6OurXaN+HbVs7uDhbuqfBnOiyD
X-Google-Smtp-Source: ABdhPJyL+jc3gZ+32uRvD6od+WdDpuc5qSGezU16V5La0Q9GEf4VAGj1CONuqVc67Qx+CKjP29adentsxn38xpfxPEI=
X-Received: by 2002:a25:5444:: with SMTP id i65mr4189456ybb.277.1630748464907;
 Sat, 04 Sep 2021 02:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <CADVatmPB9-oKd=ypvj25UYysVo6EZhQ6bCM7EvztQBMyiZfAyw@mail.gmail.com>
 <20210903160302.yh42vpkuob45dbpb@gilmour> <CADVatmMqT1yq3YHBzt4-VsL8uVHUULmy2gpaH27rAqimao2i_A@mail.gmail.com>
 <20210904091050.g5axxctgelciihjn@gilmour>
In-Reply-To: <20210904091050.g5axxctgelciihjn@gilmour>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sat, 4 Sep 2021 10:40:29 +0100
Message-ID: <CADVatmN+9euG5Fegor1+kaSPewbW8vRwBgnxmr5SsK3mOE6FEg@mail.gmail.com>
Subject: Re: Regression with mainline kernel on rpi4
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Sat, Sep 4, 2021 at 10:10 AM Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Fri, Sep 03, 2021 at 09:09:50PM +0100, Sudip Mukherjee wrote:
> > Hi Maxime,
> >
> > On Fri, Sep 3, 2021 at 5:03 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > >
> > > Hi Sudip,
> > >
> > > On Thu, Sep 02, 2021 at 10:08:19AM +0100, Sudip Mukherjee wrote:
> > > > Hi All,
> > > >
> > >
> >
> > <snip>
> >
> > >
> > > >
> > > > You can see the complete dmesg at
> > > > https://openqa.qa.codethink.co.uk/tests/76#step/dmesg/8
> > >
> > > What test were you running?
> >
> > Nothing particular, its just a boot test that we do every night after
> > pulling from torvalds/linux.git
>
> What are you booting to then?

I am not sure I understood the question.
Its an Ubuntu image. The desktop environment is gnome. And as
mentioned earlier, we use the HEAD of linus tree every night to boot
the rpi4 and test that we can login via desktop environment and that
there is no regression in dmesg.


-- 
Regards
Sudip
