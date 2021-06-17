Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422373AAFCE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 11:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbhFQJfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 05:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhFQJfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:35:33 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA3AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 02:33:24 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v9so5964833wrx.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 02:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=J/+vcuBc8bymPMNx/GbDiK5qW8QgKkIlkchq1oDH3As=;
        b=l/cOEQsCwf3RYIXnqg/dUZgFz59rluZo++RmrFoERVhD2bd/NKDcCC5EtoKQUNNpxQ
         M17Ypmsp7rWzpxKeytwtAYPcYJqprwrUs/R04XNjL4NjpYYOzQG9X2Scb4PFgjc67GfZ
         fbqsqhzei2M3YPP7wywhfIeti7RQ4urjrKeUsbhAwxTiDg60JjJYM92SGiDl0vbvGVpo
         uanKcie22+ouGvsUBIu11OSkCAA8B46FGfMnXNk1TOQmkrAzVJ1rj0oVIbqIFbDvL7VJ
         JdP0nuAnh1yx6O28p+GnqoWAOeLeNf2NGyxLLv8+CpAPvpHGrjYDI1kiqSmTMibGaYxj
         9Gzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=J/+vcuBc8bymPMNx/GbDiK5qW8QgKkIlkchq1oDH3As=;
        b=mzZ4U00mVMRT0bGzuJfV2Fnr8WWnszcCPJSmL3hn3xVHM2EDJVTjapKg7v9XiZcDL1
         Ia7PcIjFuTB+Qh4eyWSctEiQNOCLKyH7d65/gMgbM5SHmHuj5OV1hBT5bgeNfPMNGUSK
         zsjyUZydiQ6jqhOnO8A9ms+IfKcfNAtJCfec51seCo6uRVeZjt8jCPrSKqRDrr7nV3fb
         pxmIxYbT1iCEOgK+6Y5OGYfs87UIpSOJx6N56gABh0V4IBaDrOb4Bl1/g+GecZiRaxNA
         u2rfP9dXbdJwGroVW7poIJhUma+hh1Dg45R9RYL5f1YW7FgPMAHVbhgFysuC6J+/1yfD
         /9WA==
X-Gm-Message-State: AOAM5306V1j+dWiKPVNm6TE0LIIiQI98QCTarvazn3dmrWD8UQ2vZrg+
        IPB0gJY9iR5pvJDRpze7pDQUjg==
X-Google-Smtp-Source: ABdhPJw+bYEfRB3+YieH8Fbx51nH+uBGBVoK6wNpmOLBRuRMkf3pdrx1I2LkIZXkfwNHnPJo2rdIcA==
X-Received: by 2002:a5d:42c2:: with SMTP id t2mr1545262wrr.382.1623922403305;
        Thu, 17 Jun 2021 02:33:23 -0700 (PDT)
Received: from dell ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id o3sm5744984wrc.0.2021.06.17.02.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 02:33:22 -0700 (PDT)
Date:   Thu, 17 Jun 2021 10:33:21 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Daisuke Nojiri <dnojiri@chromium.org>
Cc:     vpalatin@chromium.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] mfd: cros_ec: Add peripheral device charger
Message-ID: <YMsW4QZ8SmGM7dj+@dell>
References: <20210616185131.1792509-1-dnojiri@chromium.org>
 <20210616185131.1792509-2-dnojiri@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210616185131.1792509-2-dnojiri@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021, Daisuke Nojiri wrote:

> This patch adds a cell entry for PCHG (Peripheral CHarGer). PCHG is a
> framework managing power supplies for peripheral devices.
> 
> Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
> Acked-for-mfd-by: Lee Jones <lee.jones@linaro.org>
> ---
> v2
> * None
> v3
> * None
> v4
> * None
> V5
> * None
> V6
> * None
> v7
> * Rebase on torvalds/master.
> ---
>  drivers/mfd/cros_ec_dev.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
