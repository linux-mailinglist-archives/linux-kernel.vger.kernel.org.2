Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858E93CB3AD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 09:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237085AbhGPH73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 03:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237035AbhGPH7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 03:59:17 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EB6C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 00:56:21 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u1so11047723wrs.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 00:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uVR/Jck5v49z+8mpV1Vad40sYJAyKAQCRBapDHKnLq0=;
        b=b173FmM3z/kDXtJkwwpSOdu/0g6cpW7zpOvbLBco/CZeWD6AqepnPtzBG5gG4+c9Qq
         7Qu0jnHuDXsn7aK/PyTqTx+kh/VdIahhyG/JjJtmllOMoH8P3CmptiIdCpyh1r5vELO6
         W+D8QXvBv+5RigjXbKPMIbGHopL7HSUMSVFNb/dE4bevZ9kvndHTUzo05SIkwQyKBOlB
         n8JEzsW5eVebvHJLz9ducXQnO0SMZHZUplG/Q0/+eLlmTl4ZWnWAP+j23t7SEKiS/8o0
         JIFCYcljOpw++5nx/W6NaWMzqTHB+YPkCNttLeOoO+pl9NJ25Vkl0jwzkY0RL/ci12xo
         w4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uVR/Jck5v49z+8mpV1Vad40sYJAyKAQCRBapDHKnLq0=;
        b=I7/PZovLjW7wEbU3PeACiXzDVIsUNfYJTs14GQzCMWDJjwvAhtTkX9Lq871MSQYCpx
         6gIwzjgcmBvfiCAksZXbLcAibVKWeXdu1Il4UAPL6Z9AUN4ARAkzv86fQwjZJpiva0G6
         YHXwSo6MoVresknrqK3pIklECnD64765i48xDMVlXHd+fgmzBMJZctlC1DfEVjKxwgRH
         EsAWnbYNr2sTX2wphAlJ66jac9KIUaTx6uM/E3DVlxozSyGJr4o1E4f92twK6CG5QsNO
         hjB6T+q8TiDevQwobBh1BSZj+UdE0G7Cl7ezQ0x762E8mhOHPgRz+dU+k7lBrHfwHrRU
         pzCg==
X-Gm-Message-State: AOAM532HDbgvRc1w1t8iM3wA0SjdLFDWTyqz2J38I9HevDcUTA4Q3c5/
        /5DkNG75b+lMgpr5XKkpiLrfuQ==
X-Google-Smtp-Source: ABdhPJzASykD3R2CXs24CTU0MqQNY5E8qoccE8Z0FhyLoh+efaGHiDUdNcuDK6UwFWGbWEMK/4M3bg==
X-Received: by 2002:a5d:46cc:: with SMTP id g12mr10357001wrs.136.1626422179823;
        Fri, 16 Jul 2021 00:56:19 -0700 (PDT)
Received: from google.com ([31.124.24.141])
        by smtp.gmail.com with ESMTPSA id l14sm8810302wrs.22.2021.07.16.00.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 00:56:19 -0700 (PDT)
Date:   Fri, 16 Jul 2021 08:56:17 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Brown <broonie@kernel.org>,
        Martin =?iso-8859-1?Q?Hundeb=F8ll?= <mhu@silicom.dk>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 3/4] mfd: intel-m10-bmc: add n5010 variant
Message-ID: <YPE7oUflWYJt1IoD@google.com>
References: <20210629121214.988036-1-martin@geanix.com>
 <20210629121214.988036-4-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210629121214.988036-4-martin@geanix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jun 2021, Martin Hundebøll wrote:

> From: Martin Hundebøll <mhu@silicom.dk>
> 
>  The m10-bmc is used on the Silicom N5010 PAC too, so add it to list of
>  m10bmc types.

Please refrain from padding out the commit message in future.

> Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
> Acked-by: Moritz Fischer <mdf@kernel.org>
> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> ---
> 
> Changes since v2:
>  * Added Yilun's Reviewed-by
>  * Added Moritz' Acked-by
> 
> Changes since v1:
>  * Patch split out to separate mfd changes
> 
>  drivers/mfd/intel-m10-bmc.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
