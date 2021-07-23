Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11D43D390B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 13:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbhGWKZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 06:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbhGWKZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 06:25:24 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D0AC061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 04:05:58 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so8347292pja.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 04:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G2/HRjwzSuyEQQW5d/BrTJVNVV2eltDeN7HjganBwLU=;
        b=wXVTyIsfBoE8IVkuM/NNxjJ/Ozl5NI2B6ea8KhEt9PRd1X2A8/Uyv2O5KLGEfIkBr9
         UHklLmQyYDH6sxp/2hvDs4VofWICGVMv1w37Y8rDJCpcAYGKlgwXb9sFkNq3Gl1xy9kr
         hL7Hd4eYqilDK81myZdOx3eCctTdc0eh5DhZSCPE3PDjqIb5CDM17v+guuunKAXppZbw
         vTovAsWUAf+rdfXFFrTzfYxU3WjjjXprZpk/841VxkSAaxvAbW0MhRecXFtsqJ9e5DBe
         ZyWreFRdDI0ESe04S72mIM2pgnKEerjrqMEdPy+0AFHaaeHJS1hJrDgeIaTJecdUVkZM
         0X6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G2/HRjwzSuyEQQW5d/BrTJVNVV2eltDeN7HjganBwLU=;
        b=uFNdWxNTeDloK9SFEj39XlTYqkjFBOPuInALMg/QnwKrF1Bc3D2DF/HUzSnXiztaKb
         CZWHUvaTNGlsYN8hY66bgqBZnyGMl1UIUj3nxgTeMQe4EuxJW3s7qZ89yvv+qz6+fRTI
         VPZjlTUCVd9CUzkL02stGwyvR+Yoy+ZNKOEHO/yXcACYR8bOoGYL7k5XHIoSDME+StUY
         UXsJm3mkd+O5ZKfx3X+uCW4H+fAm7wraalD20KUlcm0aD7De0WUuwty6uNhSeWskAgBM
         5VaKLtzfz62bgDxgDpM/E1FreF0YR5pYROxjaRDHv05ic9uMX86Wh69o+WO0ctFWH4L/
         Qiog==
X-Gm-Message-State: AOAM533RWpKVHuslsA1Lag3txUDXCXYLGM7+ny+F8+qMQ3nBZ23AlYoU
        0+ZujYzbrhdnu/HK+gv9azASSl+iVkvZ4b+v1Eu0BG73cmQ=
X-Google-Smtp-Source: ABdhPJzgzffhDy77yRXYZ3+R0nXiOZf2sC2IBuoxaJ9FAjQwkUe/Gemm8mzdaiDAD+E7fW8pmcdFxTMTMvdrwA0U1PU=
X-Received: by 2002:a17:902:f704:b029:11a:cdee:490 with SMTP id
 h4-20020a170902f704b029011acdee0490mr3664805plo.37.1627038357645; Fri, 23 Jul
 2021 04:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210723004214.912295-1-phil@philpotter.co.uk> <YPqhmjYDj0rq7V7r@kroah.com>
In-Reply-To: <YPqhmjYDj0rq7V7r@kroah.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Fri, 23 Jul 2021 12:05:46 +0100
Message-ID: <CAA=Fs0nU6686F=g136n2VzHrcVbctAkh09WF1m9-xSouhMv80w@mail.gmail.com>
Subject: Re: [PATCH 0/7] staging: rtl8188eu: replace driver with better version
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev, Fabio Aiuto <fabioaiuto83@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jul 2021 at 12:01, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jul 23, 2021 at 01:42:07AM +0100, Phillip Potter wrote:
> > I had to break this patchset up a bit to get around the file size limits
> > on the mailing list, and also I removed the hostapd stuff which is
> > userspace related and therefore not required.
> >
> > The driver currently in staging is older and less functional than the
> > version on Larry Finger's GitHub account, branch v5.2.2.4. This series
> > of patches therefore:
> >
> > (1) Removes the current driver from staging.
> > (2) Imports the GitHub version mentioned above in its place.
> >
> > There is plenty of work to do to this driver, including to its Makefile,
> > but it is at least buildable/usable for now.
>
> Looks like it failed to build :(
>
> And does this replace the 0/2 series?  If so, is this a v2?
>
> confused,
>
> greg k-h
Sorry, think I screwed something up. It was a v2 yes - should have put
that. Will do a v3 tonight (and properly) - Larry mentioned there is a
better commit I should be importing from, so just waiting for the
info.

Regards,
Phil
