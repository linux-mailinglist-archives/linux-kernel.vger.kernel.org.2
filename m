Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A93B3927FB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 08:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhE0Gth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 02:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhE0Gtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 02:49:36 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E077C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 23:48:02 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id o3so2911215qke.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 23:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kuo+m7Yk1S3LJ2W41PMgCMD1//1O3UdWnc2ikHzk9kw=;
        b=PpPuN9Vw8cLDeSeKENGpOcXvwDlQWjZLS88ElW4mi3H/3IIl0wONjEO4jX4Pba+FJw
         EVs3tdgNmzLc0n5MqLVjd0Q5LxsPB/anNMM3a8ceeZDpMbHSVsQl77w2nXVmzhcFtnv+
         9k/yHnlVrii5/FKL70JaiEWwXMi16NIz2xwGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kuo+m7Yk1S3LJ2W41PMgCMD1//1O3UdWnc2ikHzk9kw=;
        b=r3EbuPg2tdiQdQ7CjCRRgzWz+FTkKabn04DCpuKYzOyk4kcg7E+p1XxpFeB+owYxIy
         oQY8lV+3H98B+BX0BlEvn2/ukKNrB+tGac60aAjsTkHQ2BqTIWo7DxYYYdysrzouFOyp
         EvQf2fQ5j6lIQzuKXJQYkSxykdjkvwSfVuoVtBECcWfGDj3vZ001XNxwziliFEH+jGP7
         iuryiR1NjVHo5X4g/b52BDLivVpCaae00agsDWuNesRbZJFlsXBzdpGpecEvLZzgpr3G
         WfESKYm9vG4CMSsAQgMNrmJa9obwy5MKokSoW+bOiAk/m5m94UsvF8R+EJ71noBC5vUr
         bGWw==
X-Gm-Message-State: AOAM533EHXB5k3j9UpxT/uIim4Ketb9hwbA1Y3FPvCLfcrmMz9CSKPQ1
        ciPvZBIyg4aX9uwLl35zZDs489IlM+GbcgglsAoKGNza
X-Google-Smtp-Source: ABdhPJyoyPk7TxuyMYdICYGcA+CBvayD7DmQYwyc2a57Yx1Vkoytmt9+2yVhmxmx1iKE6S779YxUAMEthggkEfNmxt8=
X-Received: by 2002:a37:6442:: with SMTP id y63mr1902267qkb.273.1622098081437;
 Wed, 26 May 2021 23:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210329151344.14246-1-eajames@linux.ibm.com>
In-Reply-To: <20210329151344.14246-1-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 27 May 2021 06:47:49 +0000
Message-ID: <CACPK8XdDXFGq-jGwekdSEG4zSnrVQBrprXECDoTay+8GttmQ0g@mail.gmail.com>
Subject: Re: [PATCH] fsi: scom: Reset the FSI2PIB engine for any error
To:     Eddie James <eajames@linux.ibm.com>
Cc:     Jeremy Kerr <jk@ozlabs.org>,
        Alistair Popple <alistair@popple.id.au>,
        linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021 at 15:13, Eddie James <eajames@linux.ibm.com> wrote:
>
> The error bits in the FSI2PIB status are only cleared by a reset. So
> the driver needs to perform a reset after seeing any of the FSI2PIB
> errors, otherwise subsequent operations will also look like failures.
>
> Fixes: 6b293258cded ("fsi: scom: Major overhaul")
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

I've got some other FSI fixes that I will send out shortly. I will
include this one in that series to ensure it gets applied.

> ---
>  drivers/fsi/fsi-scom.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
> index b45bfab7b7f5..75d1389e2626 100644
> --- a/drivers/fsi/fsi-scom.c
> +++ b/drivers/fsi/fsi-scom.c
> @@ -38,9 +38,10 @@
>  #define SCOM_STATUS_PIB_RESP_MASK      0x00007000
>  #define SCOM_STATUS_PIB_RESP_SHIFT     12
>
> -#define SCOM_STATUS_ANY_ERR            (SCOM_STATUS_PROTECTION | \
> -                                        SCOM_STATUS_PARITY |     \
> -                                        SCOM_STATUS_PIB_ABORT | \
> +#define SCOM_STATUS_FSI2PIB_ERROR      (SCOM_STATUS_PROTECTION |       \
> +                                        SCOM_STATUS_PARITY |           \
> +                                        SCOM_STATUS_PIB_ABORT)
> +#define SCOM_STATUS_ANY_ERR            (SCOM_STATUS_FSI2PIB_ERROR |    \
>                                          SCOM_STATUS_PIB_RESP_MASK)
>  /* SCOM address encodings */
>  #define XSCOM_ADDR_IND_FLAG            BIT_ULL(63)
> @@ -240,13 +241,14 @@ static int handle_fsi2pib_status(struct scom_device *scom, uint32_t status)
>  {
>         uint32_t dummy = -1;
>
> -       if (status & SCOM_STATUS_PROTECTION)
> -               return -EPERM;
> -       if (status & SCOM_STATUS_PARITY) {
> +       if (status & SCOM_STATUS_FSI2PIB_ERROR)
>                 fsi_device_write(scom->fsi_dev, SCOM_FSI2PIB_RESET_REG, &dummy,
>                                  sizeof(uint32_t));
> +
> +       if (status & SCOM_STATUS_PROTECTION)
> +               return -EPERM;
> +       if (status & SCOM_STATUS_PARITY)
>                 return -EIO;
> -       }
>         /* Return -EBUSY on PIB abort to force a retry */
>         if (status & SCOM_STATUS_PIB_ABORT)
>                 return -EBUSY;
> --
> 2.27.0
>
