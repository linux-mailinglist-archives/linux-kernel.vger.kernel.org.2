Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0BC3A7DF3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhFOMQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhFOMQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:16:45 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1770C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 05:14:40 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k5-20020a05600c1c85b02901affeec3ef8so1647973wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 05:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=G6BVkS+vIlC58x7Bd+pyGbu+DV83UBCpNAU/JdLNZfY=;
        b=bkWl9wn4BMueF+YmK8orjAHsPaqJz8jQgnvgv4+gJIm5lAy/t/gtZuV8AeTlCNoBvw
         0vi/q2r6ZMVA516/HGQYjD+uepQzzbHkcs8DDVIMne16u6smmxXIxBpNPf9cZujmgbPg
         dO+2asuBX+aJbAjqpwFUbf2UfROLCo4AfHydUOKXKcu+VrZXlD1qsRgPGMRImSDlQiqA
         nunNcUJKC0QAYILXG0NTuWRUD/D4APvHJrGeK7w3lhDOUzTijDiftV03tGTOodjtwS8c
         xR5swh+1ooie6aLH+OaovexR9kiNJjeTV4DWMMbK77WkJsxxarTEXcoT5z/Pcl7CkfI0
         vPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=G6BVkS+vIlC58x7Bd+pyGbu+DV83UBCpNAU/JdLNZfY=;
        b=oE4kKg1AQO+ASNPhBOQwXkDQFzrQ0n76H2lHBd6XH6qF0yLVohqzZSWONo5YR7aTeO
         VxhC4BY8dVlnLEI6e0jvfdwTH72zOOO2q7V1EF9pzug5dYoUq0+WGMek3oVW0hfvIhUd
         IC8tWy7OCUy2lCcPPUSoRniGPZ1UlSabO6rMPXawdaObt9jpLPU1LhrwDbdXktiPeZp+
         qSilFv2OgQR2D0DbwZmcUmdtCjCRrNe1BX7RxCRVeIIwE2GdgKhrrhB6Ib2s+R3i3Elw
         d1S53Pzy0QozkZWc8KZxAu1fL5CYhMlLhR/JeQIL89Zb3drJOoSsQtcX+R391lf55D03
         +1pA==
X-Gm-Message-State: AOAM531D9EEbvIJcP3sT4jY1wknYt7HJWrEKRTfAIEnhd1TT5kKhY03p
        FWbTq0xp5yMuCIXeFMusRVPhXw==
X-Google-Smtp-Source: ABdhPJxciyrDaIWvU7dhDq0VZAfOMdPeW1M7WmdZ40qendDz1p5ll/zWpxhguQ5xI+1hGjP0OAKYCw==
X-Received: by 2002:a1c:f60f:: with SMTP id w15mr22184835wmc.71.1623759279201;
        Tue, 15 Jun 2021 05:14:39 -0700 (PDT)
Received: from dell ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id l31sm15399693wms.31.2021.06.15.05.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 05:14:38 -0700 (PDT)
Date:   Tue, 15 Jun 2021 13:14:37 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     patches <patches@opensource.cirrus.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/9] mfd: janz-cmodio: use DEVICE_ATTR_RO macro
Message-ID: <YMiZrXYjnPIJin4k@dell>
References: <20210602114339.11223-1-thunder.leizhen@huawei.com>
 <20210602114339.11223-8-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210602114339.11223-8-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Jun 2021, Zhen Lei wrote:

> Use DEVICE_ATTR_RO macro helper instead of plain DEVICE_ATTR, which makes
> the code a bit shorter and easier to read.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/mfd/janz-cmodio.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
