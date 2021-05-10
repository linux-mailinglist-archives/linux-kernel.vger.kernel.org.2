Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152B1379371
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 18:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhEJQOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 12:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhEJQNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 12:13:43 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4C8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 09:12:37 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n205so9534657wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 09:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ShNom4p6YohoONHvToqJ2TpjtKn1I+c+HwKLewaQ9J8=;
        b=ygo3eq01ALaWUIr/Y9FxhFgucwAsxbFc/bQ+nhB7VsL9wqwph455X0JwZb9Z6N4M7m
         WxXpUDA3n9DyPrqUiCWRdabsQQGRc1A4E26yx6FRd9tOtRrgEHeMNmP80UPXWbIN+ijG
         x6gr1SgOJzrHFEu3BquMmGaYhjpgeMqz5WqdnsmvkxgojjFKwg0UPfmB7/w9hIf3OX5v
         8PyIuT9dE7uQH2rpJA05xTggtW8ZKeDQzIWGmDo40sBOBUzOhtC9uYcpxhLziduKl7Dm
         3g5mF42hzwdL5cHHTG0MFI2vBsci5HCzseQViCAdC1UJbXyB8O+wSHYUb9s9rq2EG/Qw
         HUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ShNom4p6YohoONHvToqJ2TpjtKn1I+c+HwKLewaQ9J8=;
        b=eHs3qb5y+67MWhjN6JhzqP1FbVC1JrljYLpxs0SuJVO5Hb3z3ktNnHe11tbVz4woaN
         2MW6z3F6Tqn93aiM94ODIHQGUTv58yDt28LAkfindSdOWjPUwiEyZWjLnBFGOqPba4tN
         aHHyxf7YcWg3NyuofMglnTQUBkY2GZrKIxNtUynKQxMRH3Gpood+41Hvhfx3GBqERirY
         nLb2IDcOJYkna8615M/fCNq1CCf8N8tkCwI6RkfFA1n1wQSyWGcRxFERHAuzqFH7HPDE
         fnafuze4dHdRzRwNhlDESO3lSU/fN8xmbAXGHhCMpmYurH9Ti0agZTE/Lp8Hpb0+4sQT
         OP9Q==
X-Gm-Message-State: AOAM533s4zQpkijiUFm0voEK1FoGnG/yYJfS2BM6/5f3T0MXv/Xz3ffy
        CPE8iCr+jIwhXnVGJ8358EbUQw==
X-Google-Smtp-Source: ABdhPJyfOrZOX+n96cQi/alLp/ksXDmcXFJKMdRPc7Auh0+lhZK0mmEeCnbSTioYDTiV96uqWhsBaw==
X-Received: by 2002:a7b:c38d:: with SMTP id s13mr27680197wmj.115.1620663156659;
        Mon, 10 May 2021 09:12:36 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id p5sm19632827wma.45.2021.05.10.09.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 09:12:36 -0700 (PDT)
Date:   Mon, 10 May 2021 17:12:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: Re: [PATCH] MFD: mp2629: select MFD_CORE to fix build error
Message-ID: <20210510161234.GC751702@dell>
References: <20210504023218.20553-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210504023218.20553-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 May 2021, Randy Dunlap wrote:

> MFD_MP2629 should select MFD_CORE to a prevent build error:
> 
> ERROR: modpost: "devm_mfd_add_devices" [drivers/mfd/mp2629.ko] undefined!
> 
> Fixes: 06081646450e ("mfd: mp2629: Add support for mps battery charger")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Saravanan Sekar <sravanhome@gmail.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/Kconfig |    1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
