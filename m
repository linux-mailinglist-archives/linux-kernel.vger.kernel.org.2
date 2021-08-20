Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7DC3F3772
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 01:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238315AbhHTXws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 19:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhHTXwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 19:52:47 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082D5C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 16:52:09 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id u11-20020a17090adb4b00b00181668a56d6so2120104pjx.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 16:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7a7pr5fcERkUw6OUxCu6Pi6Dvka3zNiGFTz7cgPMCq4=;
        b=Jhuhy1hiJYwkPASf5kx5v9//OFHdZH3ukTgAqvjXPa0cbrH0YLNSZxdWo33VLN6Y8E
         cmpoJoplP0cba+qV16kp+yvU5qSJzik8AICpXI33WjiQHHSHkqcjZeNDn8fpPa9JKWmW
         zeWBgTOz6uS6GbFAlSe4j5OcTaWDYvAazg96UfU+UJ4dxH9vN0JqY2eo+xxG9lmSRk4G
         QxVKwyQ8xTRJ6baahEPMt19dYtdGJsxB53LYeqA5AgreSAKwL+QxX7XVX6JMA2IxVo6O
         jKJShSHjErWSZKV0oiY6tQ/c33zkTvHJlyPZ7cKsdjWXW/3sfmMAwUYmL+PM1EqDT9wD
         SGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7a7pr5fcERkUw6OUxCu6Pi6Dvka3zNiGFTz7cgPMCq4=;
        b=ERSbC8n8i0Gn702Nhvtl7WoHrbTCwr3PuwYZj2XiaoqRUHL8u39ofaB+XYppyoWDDE
         B8qKEsfhaA1BGSU2RpabcktmgkXBBo+c//T0wwV7TK9ttkobuzWxwuwvNZ8AmYOMwvfm
         +NUcWN+fmSUo3R0tcK74hLwLnaSfRKxCzrtCLlFRcR0RA+aZIj+e77y6BJDz5YmR5A3Y
         Wb0Q+yCRh/EeQvD4BRmzgFv9BaqQDnoAjp3KMDJPafosLYx8DOw3Mi0FRzpDXyz5X3wY
         hjNc4vg4d67Qp+RarJCKFy6HYgcfrA1r5z2HtL3zbJAwg7ikeQ2aDdF+0qCHLzBF/rEO
         5c6w==
X-Gm-Message-State: AOAM530H4HbZ2L1dILW6Hia9VDwbz1ZeKxvn8U+QSP3L1AU0Yll+Fq09
        NAtTYhVvmnxirwbyCow4F/cbq7doHkNcoLjHSKLeyw==
X-Google-Smtp-Source: ABdhPJykm1WZbuaKnzPgpoWymSbBAfEjvJasZps8xZocpTe0mKrTl0kVWZOm2C43IMr+90baGNlU3BPHqAWy60VT4dc=
X-Received: by 2002:a17:90a:6906:: with SMTP id r6mr7106659pjj.162.1629503528537;
 Fri, 20 Aug 2021 16:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1629479152.git.paskripkin@gmail.com> <0e2df1ac9e1031824a1cdb7b24594d2d1b99e382.1629479152.git.paskripkin@gmail.com>
In-Reply-To: <0e2df1ac9e1031824a1cdb7b24594d2d1b99e382.1629479152.git.paskripkin@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Sat, 21 Aug 2021 00:51:57 +0100
Message-ID: <CAA=Fs0=xVqe=QqRwyNGzR7y03na+GF0ktrE3GNhOiD-oObse8A@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] staging: r8188eu: add error handling to ReadFuse
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2021 at 18:07, Pavel Skripkin <paskripkin@gmail.com> wrote:
>
> ReadEFuseByte() internally calls rtw_read8() which can fail. To avoid
> uninit value bugs we should properly handle error sutiation and deliver
> the error to caller.
>
> To achieve it, some functions now return an int, and the error
> which could occur in ReadEFuseByte() is handled on the top level.
>
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_efuse.c      | 46 +++++++++-----
>  drivers/staging/r8188eu/hal/hal_intf.c        |  6 +-
>  .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 62 +++++++++++++------
>  drivers/staging/r8188eu/hal/usb_halinit.c     | 20 ++++--
>  drivers/staging/r8188eu/hal/usb_ops_linux.c   | 43 +++++++++++--
>  drivers/staging/r8188eu/include/hal_intf.h    |  6 +-
>  .../staging/r8188eu/include/rtl8188e_hal.h    |  2 +-
>  drivers/staging/r8188eu/include/rtw_efuse.h   |  4 +-
>  drivers/staging/r8188eu/os_dep/usb_intf.c     |  4 +-
>  9 files changed, 138 insertions(+), 55 deletions(-)
>

Dear Pavel,

I like the code, just a few things though:
(1) the comments I made in the previous e-mail r.e. what we actually
do with the errors, and grouping logically related changes (the rest
of the usb_read*() changes being in this patch for example).
(2) I got trailing whitespace errors from this patch and the last one.
For a v2 I would say stripping the whitespace is a good idea too - I
have submitted many patches myself to this driver that had whitespace
in - indeed, the original version of my patch series to import the
driver still had a load as well :-)

Regards,
Phil
