Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703BC3F3BBD
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 19:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhHURaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 13:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhHURaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 13:30:02 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E292C061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 10:29:22 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id oa17so9340379pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 10:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mbXBY1K+bIvnA7frC2S0y5jy3wcA1bKUpmFcBQ25Dzk=;
        b=gsJG7hvUkpDh7HD4EmjVP9kdPG/PBNSMtqxEQjtRhtNGQ51sQIFDH09dvZCRrm0ZGe
         8TBCXzuO8EmNXisaQsSEcKbaMsQDM6rhEgfaCIf+WlbdazIZLOCa6L23gYxOeCSKKL6t
         UjAzMmoPWxDHbDiPFuaqPVd3bZog257iuf+RkwxvkNg8vkumTB76kzmkUvhxEPRGkZGX
         1liadzA5DWBQVo2Cvwnnn9qPXGXzv4yqX0uSLwtdbecDZJnG70LOM/NUlCzclFmaxzPz
         W0IvxluupVJ77xnsSocopNlpxMqjA/WXKxZUjKsy9zN52ehe7T4wfybI2ZDrdxvQQz+/
         Ygow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mbXBY1K+bIvnA7frC2S0y5jy3wcA1bKUpmFcBQ25Dzk=;
        b=BNaHSilWYgVUBmfagmZuH+AW4esaxcdsJjLKX0IwbVx4/9JGBpLO+qe1dyjgZvQ15t
         8nlnjM+JV5b9o90L+Q6rdkqrppf7qFRXPAyG6sMnSzPrNd7MkeZh8g/fII4QwhoBDDrR
         yJQETyi1cQOafrLjHv6nCIGH4WXfxnve11yCU6VDtqCUW/bBaacRlsYgwkCML4taa959
         pSAkvLOOq43RNg/Ai3ZurCNzd61PShsP6QeXoXTeo1l1NAdivVa/bPKdNu7BY0OpLMAW
         IBe434iRajluN+lOrXg/ZONLv0prAh/I2HB6UBqH+RRgE4XfV7qaYA2Cvo1TuIYYD+V8
         0KUw==
X-Gm-Message-State: AOAM5300uI8pd/WBSKF+JO5GnQ+Jwb39/QzIuWZpkn6h+ROPylJ+Q+B8
        YaD5UXA/SXwTTY4ng79mak/NbOLs+LIdv8WXDYZlwQ==
X-Google-Smtp-Source: ABdhPJx1PxpMu3bCnSml7ds1DFejoVvBh/9mDosyuXScV3s3fY4Hx/L75JY8mwkXgGQLkKO0Cg7ytx+JWkInEquHMc4=
X-Received: by 2002:a17:902:8c81:b029:12c:ee37:3f58 with SMTP id
 t1-20020a1709028c81b029012cee373f58mr21366030plo.45.1629566962001; Sat, 21
 Aug 2021 10:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210821164859.4351-1-martin@kaiser.cx> <20210821164859.4351-5-martin@kaiser.cx>
In-Reply-To: <20210821164859.4351-5-martin@kaiser.cx>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Sat, 21 Aug 2021 18:29:11 +0100
Message-ID: <CAA=Fs0=BzFpONB+Dtj-xTbk-YieqXvP8qHtLdUiv2MwsPjxq_w@mail.gmail.com>
Subject: Re: [PATCH 05/10] staging: r8188eu: remove an unused enum
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Aug 2021 at 17:49, Martin Kaiser <martin@kaiser.cx> wrote:
>
> The VENDOR_READ and VENDOR_WRITE defines are not used.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/r8188eu/include/usb_ops.h | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/include/usb_ops.h b/drivers/staging/r8188eu/include/usb_ops.h
> index b6a1cd536adf..c53cc54b6b87 100644
> --- a/drivers/staging/r8188eu/include/usb_ops.h
> +++ b/drivers/staging/r8188eu/include/usb_ops.h
> @@ -13,10 +13,6 @@
>  #define REALTEK_USB_VENQT_CMD_REQ      0x05
>  #define REALTEK_USB_VENQT_CMD_IDX      0x00
>
> -enum {
> -       VENDOR_WRITE = 0x00,
> -       VENDOR_READ = 0x01,
> -};
>  #define ALIGNMENT_UNIT                 16
>  #define MAX_VENDOR_REQ_CMD_SIZE        254     /* 8188cu SIE Support */
>  #define MAX_USB_IO_CTL_SIZE    (MAX_VENDOR_REQ_CMD_SIZE + ALIGNMENT_UNIT)
> --
> 2.20.1
>

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
