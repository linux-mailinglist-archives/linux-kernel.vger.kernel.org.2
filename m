Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41EA3F540C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 02:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbhHXASj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 20:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbhHXASi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 20:18:38 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7208C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 17:17:54 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fz10so1678028pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 17:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7yibjZJUpbZ4+P8Zg5i3r1lSVJYnEnK9gSjxsDfYQ5Q=;
        b=AJtytBIeQqFlDapbL33j5fzOVo/pO9w5Tpb/y/OSsmkJ2iSk0z46mwp/PcEPIGrWOm
         aU2W7Adw64NicX6OTFgf8cnezXRb9ggRgxwWczKVpxMATQdtD6wgN4B0hqN4euAH/PrG
         IDpHB7uzmOGEk1OHok5hifIUUjlDSh5c1ptaiK26KLu9Sxef0kzsjCvOSVB1Ij1E2IXW
         Oigk3kE0ymAFRL+qOMjmLqwMJxoQFczQFokKxW5oRj9HkjWx4gPp3uphmaCk6QuTEsqS
         SAi1GIOfKV2zNSTilppo67bbxOLtXPFb6VunNMZ30gaASys/v1KJMiH1plu5xfgk28Qx
         XUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7yibjZJUpbZ4+P8Zg5i3r1lSVJYnEnK9gSjxsDfYQ5Q=;
        b=f5uz7wOC0z9MwS6+9UDaGLzwwsrla6VdjuygruFjcdMRof6b3gml0Qi4XIZnOdf/pZ
         0D/0Fvty7XsOrBziGoM49V7vm7W7T163x5MjOUwGb+0NMJW5ePwnDIHzLHfc7o5x1RS/
         64ufqdsx5POw9+/6vVFT00QDVKnV7jh9FMkZ/J3kdjBtdsC5VmlMgi+mQRRQm9imgCGy
         DdJNDotVG05aWyRu7Lhyi4Hm5jr0deJBU0WgM5It1R5oIedIcJ0n7Oxo0GtRJmoL4+8b
         qOQR4UJ6HEGQRq3WQPDIhIWrb7xgyFIjf8VJISvf7ueeD0E+hcCmvn2d2cbPCKR5OqbX
         NlRQ==
X-Gm-Message-State: AOAM5310B0V53Aeu9PsPG+7+KC1+MJm8/3HW8oJIUz2tblCVlkU3hBzY
        0CdsJ9pOq3ow2YgLFEXI3RjOaUsQdl9bz81YxsrRvw==
X-Google-Smtp-Source: ABdhPJwGGQFuHpqJSpswfjuCKkLgTaxj95DS+ddmgfEC5xoHhnOn72dJd6L3b8+sJvVpRyECZTObkKequJKSuxMCyQg=
X-Received: by 2002:a17:90a:1f49:: with SMTP id y9mr1215786pjy.225.1629764274425;
 Mon, 23 Aug 2021 17:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210823234858.2633-1-straube.linux@gmail.com>
In-Reply-To: <20210823234858.2633-1-straube.linux@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Tue, 24 Aug 2021 01:17:43 +0100
Message-ID: <CAA=Fs0=SiVhTrHNqwrXBA2PFkm1LpWTOkv9b2c7KdijaO1iRsQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] staging: r8188eu: remove unneeded header files
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Martin Kaiser <martin@kaiser.cx>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2021 at 00:50, Michael Straube <straube.linux@gmail.com> wrote:
>
> This series removes the header files if_ether.h and ip.h as both just
> duplicate in-kernel definitions.
>
> Both patches were already sent as single patches but only the one or
> the other can be applied due to conflicts, so I resend them in this
> series.
>
> Michael Straube (2):
>   staging: r8188eu: remove if_ether.h header file
>   staging: r8188eu: remove ip.h header file
>
>  drivers/staging/r8188eu/core/rtw_recv.c      |   2 -
>  drivers/staging/r8188eu/core/rtw_xmit.c      |   1 -
>  drivers/staging/r8188eu/hal/rtl8188eu_recv.c |   2 -
>  drivers/staging/r8188eu/include/if_ether.h   |  94 ----------------
>  drivers/staging/r8188eu/include/ip.h         | 109 -------------------
>  drivers/staging/r8188eu/os_dep/xmit_linux.c  |   2 -
>  6 files changed, 210 deletions(-)
>  delete mode 100644 drivers/staging/r8188eu/include/if_ether.h
>  delete mode 100644 drivers/staging/r8188eu/include/ip.h
>
> --
> 2.32.0
>

Dear Michael,

Many thanks, applied/built/ran with both patches applied, looks good
and works fine so far.

For both:
Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
