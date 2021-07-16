Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A113CB534
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 11:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbhGPJXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 05:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbhGPJXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 05:23:13 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C017AC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 02:20:18 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v5so11298213wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 02:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=K8jKAtfsD8Dso/Nb/D2+fe50ZjKqaNK5zqUd9Ii1CJA=;
        b=vbLCXbClAuFvWqGMXq4nOWCmDMtxtqzY42Ia2T/WkLVc14A6QzUxJG1PXEi/A9wwXc
         DLFXDG4kjVNShZ/qXsnFLmOoL9YLOLmwbRrExVjLkPkT60ILIQ81EV/nVuVxxc2EdWwB
         QoXSyylx+IDYnwDxaX4mQRTKdvHmyF7xURiI/Ccwh/IHmmUQbLg3VXNBKKRzZA9nAoIS
         iFBeJ270be5ML5NDWSefXHbsNK9MgY4izQnq/1IWDv0svU4fXx/PH762+FkAjNkVL67i
         5Hr53XvYiqcZEr0hHaLh/cgBnJEfCtpTeMKQyI3xo+O7W9O6kx4NfSDH6Ab/OY48isZ1
         Q1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=K8jKAtfsD8Dso/Nb/D2+fe50ZjKqaNK5zqUd9Ii1CJA=;
        b=U1aSq4XTzKd/35jEJHN+1+hG3xexzxoMJQ8IG7qie8jTtVHY9j1QWKm8loBikoMkKq
         nINEPijiiMFGUvnHAtnDeii6PwObcmXrUsDH8NAVtQYT3SkBYRVaIhEcIEungDUY+3Zs
         hOqk20IlYaaqPE0Hgzxe4s5qMtxiRRuF6F0gtMLACLhYWHaA4zGHwkSoBHByIALzKu/M
         iuHSnB9GgJ6qTfPsyKLToA5IHNkBshNFuVDg/x5ZvYeCaWirfcaTkfbfp4xrq/F7tnqJ
         HGa6E0u7XVc1EtAaf9bZTbYb63HONLxddMfpxDqIX0tbfwz1PJpaT/bQwdXwHUdvhMYb
         ICwg==
X-Gm-Message-State: AOAM530GoXEwG9PRBxZ9KKbKQJMQ1uFfVaFTOATHeS7/NTSF8AkGUlb9
        pc876SvDZRtPcR7sXrlcJJ0ESQ==
X-Google-Smtp-Source: ABdhPJxAT+l4MM6TKgAyPAGSpJy6KJw+Vsk6A7ZXF1E+fljGhsyZ//VIkOQguE2Db0heYN9LhbbvOA==
X-Received: by 2002:a05:6000:18c2:: with SMTP id w2mr10908600wrq.282.1626427217381;
        Fri, 16 Jul 2021 02:20:17 -0700 (PDT)
Received: from google.com ([31.124.24.141])
        by smtp.gmail.com with ESMTPSA id h15sm9117073wrq.88.2021.07.16.02.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 02:20:16 -0700 (PDT)
Date:   Fri, 16 Jul 2021 10:20:15 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] TQMx86: TQMx110EB and TQMxE40x MFD/GPIO support
Message-ID: <YPFPT+5z5J43kBzL@google.com>
References: <cover.1625227382.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1625227382.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Jul 2021, Matthias Schiffer wrote:

> Updated patch series:
> 
> - A number of new patches (more hardware support and a few fixes)
> - Patches 1-3 have gained Fixes tags
> - Patch 2 depends on 1, so maybe we can push the GPIO patch through the
>   MFD tree to keep them together?
> - The change in patch 7 was somewhat controversial. I've added a
>   warning, but it is the last patch of the series, so it doesn't affect
>   the rest of the series if it is rejected.
> 
> 
> Matthias Schiffer (7):
>   gpio: tqmx86: really make IRQ optional
>   mfd: tqmx86: clear GPIO IRQ resource when no IRQ is set
>   mfd: tqmx86: remove incorrect TQMx90UC board ID
>   mfd: tqmx86: fix typo in "platform"
>   mfd: tqmx86: add support for TQMx110EB and TQMxE40x
>   mfd: tqmx86: add support for TQ-Systems DMI IDs
>   mfd: tqmx86: assume 24MHz LPC clock for unknown boards
> 
>  drivers/gpio/gpio-tqmx86.c |  6 ++---
>  drivers/mfd/tqmx86.c       | 48 ++++++++++++++++++++++++++++++--------
>  2 files changed, 41 insertions(+), 13 deletions(-)

Patches look good.

Could you please collect up Andrew's acks, remove the suggested Fixes:
lines and resubmit please?

I'll quickly apply them once resent (probably Monday - if you get them
out today).

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
