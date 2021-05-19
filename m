Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F272388C24
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 12:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239889AbhESK4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 06:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhESK4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 06:56:30 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27BEC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 03:55:10 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso3164217wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 03:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VWNn8s6uxdHuGLdf6JViqfWGURn+ws2bD0QpSQyNXtA=;
        b=jhQqXDTarQGD0aVvg49RzkHNeDpUc3l4ZBoOLERlayx2F0YWzBQtEfalRDdsri1NGS
         JT7jNemYcq4vNJgJ92e14y+frxutWc74ciybLGe6CMTCZMmyf4jksDo+d5IbGQUhVD59
         ayqsBqeS2wrt4P6ONmJumXQOZnLGGeVzVZRt6OespfiDCP/SarW3prBPo9OmsNQVG63x
         O3s4TYSHTbFoKStHWonTysh2csMfC5zHUzTWVAK0zayLngamrlErIO5HsOonSutQuRD2
         2rlxbOlQjy7HzUTctbsYzsU8VX1XcSd1YtVDMvxU6SXitpoaukCf0Fy4YAP40zncV2bY
         AQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VWNn8s6uxdHuGLdf6JViqfWGURn+ws2bD0QpSQyNXtA=;
        b=FjCMeoz+Gm1/OO24Tykyh00ShFL1fy2RW+/ddq4nEs93ILZa91nKZZ4MLxIz8D06vE
         B3ysqE/Rl+ydod8Q7SCQtXu9xSz1Mso8y5AWyZjbLGWz4zI7cq9fiJeEXMEbxQRFIYe3
         soHjZ8lGCZwN7az4OWh8i7J0Tm87CKRZJxExOnzIZvG5JXn30V9Z+72m2OW0XJnV/C4k
         G+/oQuxYvIAD1idPhwRu81nu5yfoi+KEeVpd8zfARJTRLwmTyR6Y+1wZC+pIwSVA/prC
         mPWBXADuA/E2zoq4IXVNR0KeEh62F7BRqAUvNnUn67Wn2I64IgiKEulV6Wh5ZABreZYi
         PlEg==
X-Gm-Message-State: AOAM532mNhVvLEQs6tOq9VSfiCUkMXoLA6SBsy66k72S/Xr2Vqkbba1e
        wTxnT3BtPjYOJrb2QXdzF/mOxTHzqt7QgQ==
X-Google-Smtp-Source: ABdhPJyD186uI/OTMxMaOaSteeEZiIXUIemv+KZ0cy0nRD5LukptML6Mqe+WbVHyuceCrTalwt1iqQ==
X-Received: by 2002:a1c:3cd4:: with SMTP id j203mr9633589wma.25.1621421709628;
        Wed, 19 May 2021 03:55:09 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j7sm20660467wmi.21.2021.05.19.03.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 03:55:09 -0700 (PDT)
Date:   Wed, 19 May 2021 11:55:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mfd: mt6397: keys: use named IRQs instead of index
Message-ID: <20210519105507.GB2403908@dell>
References: <20210506094116.638527-1-mkorpershoek@baylibre.com>
 <20210506094116.638527-3-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210506094116.638527-3-mkorpershoek@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 May 2021, Mattijs Korpershoek wrote:

> Some pmics of the mt6397 family (such as MT6358), have two IRQs per
> physical key: one for press event, another for release event.
> 
> The mtk-pmic-keys driver assumes that each key only has one
> IRQ. The key index and the RES_IRQ resource index have a 1/1 mapping.
> 
> This won't work for MT6358, as we have multiple resources (2) for one key.
> 
> To prepare mtk-pmic-keys to support MT6358, retrieve IRQs by name
> instead of by index.
> 
> Note: The keys_resources are not part of the device-tree bindings so
> this won't break any DT schemas.
> 
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  drivers/mfd/mt6397-core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
