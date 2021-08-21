Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965493F386D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 05:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhHUEAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 00:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhHUEAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 00:00:03 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32933C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 20:59:24 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id n12so16830174edx.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 20:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R3FWEQvkULZpp+ElEzfqW3d4QazWh4E5WETIUUYvJeY=;
        b=OAFGT/cJF/l/cM8yYl0R7fRuUoMapU9L6+Xzx2eeiz8cE+ZpZQabmYz6Kj2VpB5+r6
         bmo1TYLRIu6kj8e2BdC0UI0PolOy/S8DkWaPCa30hzFvk3p6rCDylh1FsVZ1q1L+5uiJ
         /DdXrRFuMRdeq/7MN1DcgOzzZAfuEev1+bEIXPMUJCZbbinQTqA3fQrfYfEZt7tCcgVi
         zJDzK8qeYg2KwTRXk5lHFXeDiKmp8W22wvQyDC/IaHyiygfY2j/7pVd/TelPvLeEkeBv
         0byoD5dtm/B8ji2zQ+oeCmnPWEEUmhIgYrxLLvL5UoGvdt4rTkguvrpjjIt1vg47UI0z
         AOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R3FWEQvkULZpp+ElEzfqW3d4QazWh4E5WETIUUYvJeY=;
        b=YlkUn8u97hD8ZnmS6l5VYy9fDhy8K3zCpnF3e1M8oDoAtF3eC8YeUTKu8smN75yLQA
         B07jPemf9BgLlWxp84g26oDH8IOSj5QGnFdJd/ka+0AseuH4/SaAcOQfTquJtPGVBOtN
         rjNDWBcWh/Q+IJZB1mimibYoxlsaVv6uI2hu6OTYegHr51MFhR0TyWCOck6+UiSQZcmi
         R5axjfLSSuU83nLEiTNsW5SLtz52NH2c6LqgOU+mdg009Fcm9tJbWPty8HrM/m3U4FqJ
         hIn8tHuZaVQGxFCP8SuugLJ1kHGjQsdb3NW7wz4GVfn1+wOJqCh9yPVbj9eixHUxx+V+
         0o2g==
X-Gm-Message-State: AOAM532vHeaTGqisPw66HIGTR3/rQkvsbQ5Q93HqQU9s+Q+B5GGVftCL
        /M4DT3mnPCSSAFOsN6Ry9l0=
X-Google-Smtp-Source: ABdhPJwwzuTR+xcSC1RtQ5rsDP1/mV06Chr44FkedEtPsFNV3/1leiqsNpZIRgcUBRaHivPl9AgGtg==
X-Received: by 2002:a50:fe07:: with SMTP id f7mr26019721edt.11.1629518362101;
        Fri, 20 Aug 2021 20:59:22 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id u23sm4606039edr.42.2021.08.20.20.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 20:59:21 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Pavel Skripkin <paskripkin@gmail.com>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 2/3] staging: r8188eu: add error handling to ReadFuse
Date:   Sat, 21 Aug 2021 05:59:20 +0200
Message-ID: <3977072.uyyoESeOv6@localhost.localdomain>
In-Reply-To: <CAA=Fs0=xVqe=QqRwyNGzR7y03na+GF0ktrE3GNhOiD-oObse8A@mail.gmail.com>
References: <cover.1629479152.git.paskripkin@gmail.com> <0e2df1ac9e1031824a1cdb7b24594d2d1b99e382.1629479152.git.paskripkin@gmail.com> <CAA=Fs0=xVqe=QqRwyNGzR7y03na+GF0ktrE3GNhOiD-oObse8A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Pavel

On Saturday, August 21, 2021 1:51:57 AM CEST Phillip Potter wrote:
> On Fri, 20 Aug 2021 at 18:07, Pavel Skripkin <paskripkin@gmail.com> wrote:
> >
> > ReadEFuseByte() internally calls rtw_read8() which can fail. To avoid
> > uninit value bugs we should properly handle error sutiation and deliver

sutiation --> situation.

> > the error to caller.
> >
> > To achieve it, some functions now return an int, and the error
> > which could occur in ReadEFuseByte() is handled on the top level.
> >
> > Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> > ---
> >  drivers/staging/r8188eu/core/rtw_efuse.c      | 46 +++++++++-----
> >  drivers/staging/r8188eu/hal/hal_intf.c        |  6 +-
> >  .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 62 +++++++++++++------
> >  drivers/staging/r8188eu/hal/usb_halinit.c     | 20 ++++--
> >  drivers/staging/r8188eu/hal/usb_ops_linux.c   | 43 +++++++++++--
> >  drivers/staging/r8188eu/include/hal_intf.h    |  6 +-
> >  .../staging/r8188eu/include/rtl8188e_hal.h    |  2 +-
> >  drivers/staging/r8188eu/include/rtw_efuse.h   |  4 +-
> >  drivers/staging/r8188eu/os_dep/usb_intf.c     |  4 +-
> >  9 files changed, 138 insertions(+), 55 deletions(-)
> >

Please change the Subject: ReadFuse --> ReadEFuse() or 
ReadFuse --> ReadEFuseByte().

> 
> Dear Pavel,
> 
> I like the code, just a few things though:
> (1) the comments I made in the previous e-mail r.e. what we actually
> do with the errors, and grouping logically related changes (the rest
> of the usb_read*() changes being in this patch for example).

I agree with Philip on splitting 1/3 into more patches, perhaps one for each
of the three rtw_read*(), but I disagree on merging the usb_read*() changes 
into this. They should go to another patch because they are not strictly
related to "add[ing] error handling to ReadFuse".

Regards,

Fabio

> (2) I got trailing whitespace errors from this patch and the last one.
> For a v2 I would say stripping the whitespace is a good idea too - I
> have submitted many patches myself to this driver that had whitespace
> in - indeed, the original version of my patch series to import the
> driver still had a load as well :-)
> 
> Regards,
> Phil
> 




