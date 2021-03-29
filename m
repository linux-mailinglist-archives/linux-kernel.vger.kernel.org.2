Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8726834D4B7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 18:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhC2QTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 12:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhC2QTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 12:19:01 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AA6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 09:19:01 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id w70so13640661oie.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 09:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dpc6o0chlwIbhRlz5dYZ65nY5i+tAhRScag3cQC9KCU=;
        b=lsKKRTeLXQG4Eg1NLEEMA+Zk86CF5v6OH1/fm8nELXeyQXirtTKrrnEx0rCJCa+sSi
         9CuEDlm/5P6yAzwH2tOneGiL4sdeWK6SARQ6ZG3P8HUeEpVArDfzLI7HLTzn/oIiIqFa
         kmN8XxWpOLIuMCBGHx45vYwP67DqKQkPuso4bOUD04DuY/BHSEkqisTfVJfOrkaMGO8Z
         LVZugf9haPxdUSWYdjlwIKZttFrDvZqJymXWVqCNC/IxkU5YgYqOgFjTRwQrcLCXaS4K
         CyXWOGi5NjGazfDePZE81Qe/V1Yq/eIoYjrAkcED6E1E27G0RGHzNI/S9mqXC01u2lSi
         cpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Dpc6o0chlwIbhRlz5dYZ65nY5i+tAhRScag3cQC9KCU=;
        b=aYbKpL4cSfLEG/RWdihGGbMDvqUMXUZAXer6MTfrNwb7ComgiJHqvTeyKHW8SSlbDE
         FcJ8aFdz7uA6XGHPqR3PnMbF+LumdatErE9JvKhHTPw0B9CguXDUIH/lQb737BAEhr1o
         os9hJ0VkOe1fXSN0Fj8zBciG+/mrOfJ7rET0YkPNNOmpF1VkMgyE8KswRGPCz7AhTw3N
         ae1OBQ1m0j7ihy+njPwRIH1FlaSCKvJBIMnDhbntJ3oKEAOzVBJO8thgNM/29USti1e4
         g5OmSl/j/ogR+Xlu5YhcIHnFL1mHTfhZNgXayfJWEyatNqrhED8D/jMb09DGteqNo+Sg
         +wnw==
X-Gm-Message-State: AOAM533UJhvsq10qDuy/inF7ttPGN58TmtT1G2zImGHIJxNfHc9JlgeJ
        mo14JMI0B7zIuT10qk5HVJ8=
X-Google-Smtp-Source: ABdhPJz9FTR2pFrie5pvztJ2dB32VGD05hyfX8qWAa7QmN7v+AmGj5DpRCKJKiWxqq9TM6wH5LOJog==
X-Received: by 2002:aca:2103:: with SMTP id 3mr19389863oiz.80.1617034740525;
        Mon, 29 Mar 2021 09:19:00 -0700 (PDT)
Received: from ubuntu-mate-laptop.localnet ([208.64.158.253])
        by smtp.gmail.com with ESMTPSA id h59sm4466951otb.29.2021.03.29.09.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 09:19:00 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: iio: adc: fix unmet dependency on OF
Date:   Mon, 29 Mar 2021 12:18:50 -0400
Message-ID: <8129691.mkIHu9ZmaV@ubuntu-mate-laptop>
In-Reply-To: <CA+U=DsrbZN51cR6tbyNuwQ-zZnauOrmqetGa6T8+RtcC58mxFg@mail.gmail.com>
References: <20210328035159.47259-1-julianbraha@gmail.com> <CA+U=DsrbZN51cR6tbyNuwQ-zZnauOrmqetGa6T8+RtcC58mxFg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, March 29, 2021 2:42:12 AM EDT you wrote:
> On Sun, Mar 28, 2021 at 7:08 AM Julian Braha <julianbraha@gmail.com> wrote:
> >
> > When AD9467 is enabled, and OF is disabled,
> > Kbuild gives the following warning:
> >
> > WARNING: unmet direct dependencies detected for ADI_AXI_ADC
> >  Depends on [n]: IIO [=y] && HAS_IOMEM [=y] && OF [=n]
> >  Selected by [y]:
> >  - AD9467 [=y] && IIO [=y] && SPI [=y]
> >
> > This is because AD9467 selects ADI_AXI_ADC
> > without selecting or depending on OF,
> > despite ADI_AXI_ADC depending on OF.
> >
> 
> Hey,
> 
> Thanks for the patch.
> This should have been fixed a bit differently with patch:
> https://patchwork.kernel.org/project/linux-iio/patch/20210324182746.9337-1-aardelean@deviqon.com/
> 
> Can you check if this fixes your setup?
> 
> Thanks
> Alex
> 
> > Signed-off-by: Julian Braha <julianbraha@gmail.com>
> > ---
> >  drivers/iio/adc/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index e0667c4b3c08..7606c9b1630e 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -248,7 +248,7 @@ config AD799X
> >
> >  config AD9467
> >         tristate "Analog Devices AD9467 High Speed ADC driver"
> > -       depends on SPI
> > +       depends on SPI && OF
> >         select ADI_AXI_ADC
> >         help
> >           Say yes here to build support for Analog Devices:
> > --
> > 2.25.1
> >
> 
Hi Alex,

I can confirm that this works for me. (https://patchwork.kernel.org/project/linux-iio/patch/20210324182746.9337-1-aardelean@deviqon.com/)

- Julian Braha



