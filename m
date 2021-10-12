Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84207429FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 10:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbhJLIWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 04:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbhJLIWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 04:22:13 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA22C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 01:20:11 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r10so64369590wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 01:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HgRA1/1kXQ99OO6bGrSBSSC6XgjSYEzTLUO0dij04QE=;
        b=JaR4yOgB3YfcRNpHtYYPg+gbo7Tbu15kZQAzZPM8lQ5XROdaYH5aBJVrmq/HBp7Dms
         hXCMMkybCfdumf9kXHvOCPAD6ODk0jCFt031OMHU3QGQVpyfpraPkHDkZ3xWf4y4R7Rq
         TpZxuROoC7zSOcSEnZJdSiTdUwHfpgj0rTA0/mRRMJVQEoYjf538Ni0/sBmYWfWt8Fi6
         UZeofiS0RqHMhCbS8MfdxuLAzag4bXoUqOvGUI9J3jZYN6fOb6Q7MpZdNlCxfwcBurYk
         K0MJh16TCLXWlpO/dO+nAucXvbt6H0kdS81rLeKxKkfWWLp7BXKSyZ8CknhubEyybxsN
         pMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HgRA1/1kXQ99OO6bGrSBSSC6XgjSYEzTLUO0dij04QE=;
        b=z5/MPDTLU1nDwE+zuBpvils9OSEnEjTJz45YZAQL/64VhQNYoLc+9yLlSWmtpIbOy7
         5hvuEjzgbBS1LjbTQMWcnIQ9BAb4DKB6ItA9RXx6AImyikqybMP6Bbxc4irdCdPseyIK
         ajcZrBGXpX8MHcTKz2nKJg731n4PyjwlXFneKSeTTfL/9n4wVUvweBHRyHJVHNa+M2BN
         TPC9I2VOIa5bgUvqYkgSXFIUoCl9EsaE/qleF4ZQmaV7RgXMFX054gVnZ9JtiCCEJEFd
         09eaJkRO5R7D745kn7+/hTIDbtxGThP9OYQwAfk+uryikJsm8b44BxAc9YS+SCbUslfY
         VrAw==
X-Gm-Message-State: AOAM530EhS3/eLwvMHj8j3N9mDMU0Gu8JEsQMLUT69wAsObaXc1F0P1C
        8s9g/jwfO51kchwJquEN4SEDUrSC8djIdQ==
X-Google-Smtp-Source: ABdhPJz3di4QULi6YW+vE8ih1cumFadfpMx3qwYanr0e/C6Br+2S68XWOrtFZQH/wtpzsUIAzcD3ew==
X-Received: by 2002:adf:c00a:: with SMTP id z10mr28921062wre.315.1634026809994;
        Tue, 12 Oct 2021 01:20:09 -0700 (PDT)
Received: from google.com ([95.148.6.175])
        by smtp.gmail.com with ESMTPSA id 25sm1766789wmo.18.2021.10.12.01.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 01:20:09 -0700 (PDT)
Date:   Tue, 12 Oct 2021 09:20:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v2] mfd: arizona: Split of_match table into I2C and SPI
 versions
Message-ID: <YWVFOH506nyLxiWX@google.com>
References: <20210928163035.23960-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210928163035.23960-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2021, Charles Keepax wrote:

> The Arizona driver has both some devices which only have an I2C
> interface and some which only have a SPI interface. Currently both of
> these share an of_match table, but this means inapproriate compatibles
> are available for each interface. Tidy this up by creating a table for
> each interface listing only the appropriate compatibles.
> 
> Reported-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> Changes since v1:
>  - Drop inappropriate fixes tag
> 
> Thanks,
> Charles
> 
>  drivers/mfd/arizona-core.c | 13 -------------
>  drivers/mfd/arizona-i2c.c  | 14 +++++++++++++-
>  drivers/mfd/arizona-spi.c  | 13 ++++++++++++-
>  drivers/mfd/arizona.h      |  2 --
>  4 files changed, 25 insertions(+), 17 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
