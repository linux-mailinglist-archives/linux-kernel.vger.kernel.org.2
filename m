Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2025A423963
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 10:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237653AbhJFIIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 04:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237384AbhJFIId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 04:08:33 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C945C061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 01:06:41 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id s15so6085250wrv.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 01:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fvIucBpgLb5urp2y4+FQx5eGnf/AA+oX0Q/cwSSdTJI=;
        b=QJoZsSQZNCk29F70qK2gc4Kjyjw2DfxrqEFLpNY3gVH1Dc4RDpbf1rvxEDA4yVIOJY
         Z55AseKsCZHIvrZBaGTJxawO5is9QmuTk/JjKRwrtWWcUGz+JxHxC1p3k6et1v9E6a6e
         xGceuuq9c8dUwhG1XYSwXrHjMuCl5RITV/U2KguA/gOpP47RV6MwyyeSqSAL70R+B46c
         2aPYFnBPkHsfS8hpNn5vd3b8ENnAbKh6ocAw4jG8NPC/vZNRFGdr6HLW+mtt5tx0u70K
         RZ7+FFSIHmB5AB8glfbeRJukTXZsC+HignGnMhBwnuifVKrN9SV7poTsd46WJPb15M/u
         aqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fvIucBpgLb5urp2y4+FQx5eGnf/AA+oX0Q/cwSSdTJI=;
        b=AYKwDxGe3dZKte8s97V76AbnXid+vf32WDubFgAYSF/GKnkiaV3TQK+e8yo6Zc8d9L
         tmyRlOXfFluSssB6OKXijSy90COXvnUXzHvkMQhaxuDKjVJ5XUMWbwR7DBZ44q7Layxu
         2nbtH/HDThLx6CzmiP1NCYHd6WFoJgepS6z+nekzis9iRX8wczsXOsBHu1mMcxR4RmGB
         Yei2I8ISoMljvbdiS9vzzR+qUb+/TCjzE0g78V6M/GobDnEFGYz7yr2ibt+svtaNtFom
         HxwC0gAb5v4dHwUzpzj21G0vZXlXRAEIhKUqi3fZ+G7MDf/VIdJzWo7OFMqHWrRYEkcj
         2y3A==
X-Gm-Message-State: AOAM530RMMdzd6uPD5PAy6PRXTIkZmlsiMmsTqY8neKOvTNLBONuQpTv
        X/7Ltiy4b6msEuci1387kEDy8Q1EhSFvIA==
X-Google-Smtp-Source: ABdhPJwjTF6jXxR1knkyfVaREqHXzQcTmnf97eLGyIqwORpwd+yZFeXVHL4HFxSXXbfXQmXJOxWURA==
X-Received: by 2002:a05:600c:1d05:: with SMTP id l5mr8393790wms.119.1633507600017;
        Wed, 06 Oct 2021 01:06:40 -0700 (PDT)
Received: from google.com ([95.148.6.175])
        by smtp.gmail.com with ESMTPSA id k17sm20134919wrq.7.2021.10.06.01.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 01:06:39 -0700 (PDT)
Date:   Wed, 6 Oct 2021 09:06:38 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mfd: cpcap: Add SPI device ID table
Message-ID: <YV1ZDpXrgwb0MiSF@google.com>
References: <20210924143347.14721-1-broonie@kernel.org>
 <20210924143347.14721-3-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210924143347.14721-3-broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2021, Mark Brown wrote:

> Currently autoloading for SPI devices does not use the DT ID table, it uses
> SPI modalises. Supporting OF modalises is going to be difficult if not
> impractical, an attempt was made but has been reverted, so ensure that
> module autoloading works for this driver by adding a SPI device ID table.
> 
> Fixes: 96c8395e2166 ("spi: Revert modalias changes")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/mfd/motorola-cpcap.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
