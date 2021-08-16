Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8F13ED42F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 14:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236360AbhHPMnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 08:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235754AbhHPMm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 08:42:29 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D6DC0612AD
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 05:41:10 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id f5so23346638wrm.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 05:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Dd2RvTZ8gfpygtsaCzyWPhxOJ3nDcTnkRmNkdPIycPE=;
        b=MN80BPlTMUSdGRt9o4zUkk6ciSKkUoDM5z8fqGbgjtuUeHQHeJtWULk47nDTEuSH4X
         kclPHJ6EZWwlXgJ83NzAwgzt8phoVAnrObLpRRTCzL1MCfCGS7qw6DMFr5CPiAu0zwJE
         dt59c0quohqlXl5X71m1sFXf92Juklkr3eL/YKdOFP1ACi/7H9JyFG/8WiysxvhymUXT
         Am4QMChg5zWcjLAmop9ZTTGwJa+g17/5svJEkfNkx25JzJPeJeZBJlKxXAZEkh36O9I/
         iugcvle5bfF0zkQSyYQwqDYpQ5CFMHfskAO3A9fhWx9FjxFZPmBYwKqJ4slIdTYqoZd0
         85Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Dd2RvTZ8gfpygtsaCzyWPhxOJ3nDcTnkRmNkdPIycPE=;
        b=UaYa4x7sUUhCBjpJJmcVL/46aL3ZcvZsYOkqzDQVAssKfN6sLdY9Op/bJaehQJYTYC
         TdQWwFP5xwGvvXbbwiy3HLmnciqINT3bh4py9Bbbd1c7fetYUcIZld+ce2HilePRmeq9
         8xaPqOGJjQUhuiNFBnrg9wEITgBfE1YKp/dgzwZsmclUA1EnIl4/TF8Y82ABqOHT2bTN
         UjIK1aHxLCo77t2Ibe+D5gb3s76JXHKw0LeTu8PuQ0iOn/X28lbQW6+cBcKk0A95k4GG
         FDEen/Rir0EhL29882WhJLifiHLUG+S3HlKzvcH6izE1SnLiaXnyIRiZti7uVR+fQ4kh
         7hTA==
X-Gm-Message-State: AOAM530JGBUX6oYZDMy7IER7BPA42Govx2UMkT+2bEX9NzoNR759K/Ua
        bJuipYU/M4WDKJp44IgW5RLgKg==
X-Google-Smtp-Source: ABdhPJzCaVGtA83Fws9GgfQkHtlFDfu5aVDPplXc1yQxTUf27mK6sgXSIb97EvM/JH/WIE9f8DpE2A==
X-Received: by 2002:a5d:6d82:: with SMTP id l2mr18369118wrs.225.1629117668801;
        Mon, 16 Aug 2021 05:41:08 -0700 (PDT)
Received: from google.com ([2.31.167.59])
        by smtp.gmail.com with ESMTPSA id i10sm10195719wmq.21.2021.08.16.05.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 05:41:08 -0700 (PDT)
Date:   Mon, 16 Aug 2021 13:41:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] mfd: tps65086: Add cell entry for reset driver
Message-ID: <YRpc4jajnsEaGbeW@google.com>
References: <20210727092554.1059305-1-kernel@esmil.dk>
 <20210727092554.1059305-5-kernel@esmil.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210727092554.1059305-5-kernel@esmil.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2021, Emil Renner Berthing wrote:

> The only way to reset the BeagleV Starlight v0.9 board[1] properly is to
> tell the PMIC to reset itself which will then assert the external reset
> lines of the SoC, USB hub and ethernet phy.
> 
> This adds an mfd cell entry for the reset driver doing just that.
> 
> [1] https://github.com/beagleboard/beaglev-starlight
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> ---
>  drivers/mfd/tps65086.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
