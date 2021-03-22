Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B90034488B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhCVPDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 11:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbhCVPDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:03:23 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C07C061756
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 08:03:22 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id w3so21819687ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 08:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=O31QmdEPE8zfYm16iYoljOKE1QkyhLPgMVq0vAViQFo=;
        b=R0mtls9VfFObvOXf8+wZV934gS6d+0c2O9zLGZkxmHGvOU1rhP8acTqAxzmOTpghs3
         vShbYjAo+gUljVu5rWQtSiFGdxjPXdLw4sKaNPGqDZzAFG7lweHrp4FLBGnVYCXJx9aX
         30mIkETX5EcakVx/bG9nviiGh29GiJOAwpREMUKVSdllIjA029lx0MhGW5GHoGrtEbkR
         RkK4FqXPzYt19HdCxQwQcqy1KfLgnF0Iw2LL7biGzFeDaJGiKnmWAvPrrJML52ajoarB
         29Oy2B9FId2BQEGG95egOxxBCtq0Zpall5dOteJrfJRIcbBqRWVgdJjKq+h1l4QTFokr
         yMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=O31QmdEPE8zfYm16iYoljOKE1QkyhLPgMVq0vAViQFo=;
        b=VrRw0WnClVtVTe1fHa7kbcu05tavab7yvDo5hHmgAqRQ9Pig5OGRrYfSuMUI84riQ7
         izglWBsZx6TtaR6qfkpL25KtqecjPGCNdZ6PlclgOsb+icvqxSRMddCDMixdNZp/O4DP
         XMnm4MSkJ09Dcwv50so1PmCNOgBOdKRzX7UJ9MhcQUzTcwVrkgkVR0YzRW494l6L61Xn
         CnjHtuHy1VMPNwNDDytWRKyrdcUOfUZxPTFoKkS+RXDI9wbfwbz/Uwnc1xjqlH3Gt+kA
         t9HS81Rbe3UPEhuT+2qpQh3EpuvnHCvelIclQ9taX7ju/10eHxk3QRAF5ZIoEuZacjtv
         bH2A==
X-Gm-Message-State: AOAM5306MJQ0/GOGEeky4cywu7AECJ22oM6nOfkTMiSOEFBtMhwOEPnX
        hvXomGClvJqcs1N/Gc462HBHXcamH0YFEw==
X-Google-Smtp-Source: ABdhPJwyBpi7zVzM9YJCyvxKjxLhikKRHzovcPsGaVR5YGucdcH2d6knkOTlZ8DSQtGF4ZqJHOq+/A==
X-Received: by 2002:a17:906:a1c8:: with SMTP id bx8mr140079ejb.381.1616425401186;
        Mon, 22 Mar 2021 08:03:21 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id g7sm5434470ejw.51.2021.03.22.08.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 08:03:20 -0700 (PDT)
Date:   Mon, 22 Mar 2021 15:03:19 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     min.li.xe@renesas.com
Cc:     sameo@linux.intel.com, grant.likely@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH mfd v1] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Message-ID: <20210322150319.GZ2916463@dell>
References: <1616254985-28920-1-git-send-email-min.li.xe@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1616254985-28920-1-git-send-email-min.li.xe@renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Mar 2021, min.li.xe@renesas.com wrote:

> From: Min Li <min.li.xe@renesas.com>
> 
> Add support for ClockMatrix(TM) and 82P33xxx families of timing
> and synchronization devices. The access interface can be either
> SPI or I2C. Currently, it will create 2 types of MFD devices,
> which are to be used by the corresponding rsmu character device
> driver and the PTP hardware clock driver, respectively.
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
>  drivers/mfd/Kconfig              |  27 ++
>  drivers/mfd/Makefile             |   2 +
>  drivers/mfd/rsmu_i2c.c           | 344 +++++++++++++++++
>  drivers/mfd/rsmu_private.h       |  32 ++
>  drivers/mfd/rsmu_spi.c           | 371 ++++++++++++++++++
>  include/linux/mfd/idt82p33_reg.h | 102 +++++
>  include/linux/mfd/idt8a340_reg.h | 817 +++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/rsmu.h         |  42 ++
>  8 files changed, 1737 insertions(+)
>  create mode 100644 drivers/mfd/rsmu_i2c.c
>  create mode 100644 drivers/mfd/rsmu_private.h
>  create mode 100644 drivers/mfd/rsmu_spi.c
>  create mode 100644 include/linux/mfd/idt82p33_reg.h
>  create mode 100644 include/linux/mfd/idt8a340_reg.h
>  create mode 100644 include/linux/mfd/rsmu.h

I'm pretty confused.  This has been sent ~6 times already.  What is
the v1 of?  Is this a different driver?  If so, why does it have the
same $SUBJECT line?

If this is not actually v1.  Please provide a change-log.

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 49bb445..1202301 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1196,6 +1196,33 @@ config MFD_STW481X
>  endmenu
>  endif

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
