Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCAB435EE1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 12:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhJUKVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 06:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhJUKVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 06:21:18 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFF2C061760
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 03:19:02 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id y3so305215wrl.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 03:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Y0djprC9mY30OPHD+iNKkD0xnonXT90bDZyTcvx9erI=;
        b=Lfzy1SC5aOCRSNUuktzzXQfKA7oZhL/aP/i0m6kKy4wKIrk/+7F5fhUg1TXk6d4rAT
         N6nr7v5FUG6RPRdLF5VobS7nKHewcjmuuQOjR4FSNG0putY+L8lO2zq1fKh2Tu6IW53C
         d2MQDNoN7AtjyWxw1Gu59IymvXoEefQ7w+P0KcI6RfstawuoziyvdPIAY1MMtX47G4je
         odyv7Z4jvLx7bBv9Y3eXrElBkdGyi+1ngcq3MMSl7aRKdpY/8JpvofFXF3Lv2VgY+7I4
         BU1ujIEpNwb97LOyN3Uzqq5Wy1RHHrLsMcBL43z5FXtxk6ioHQ0byoONz9K5OIia0ezi
         V7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Y0djprC9mY30OPHD+iNKkD0xnonXT90bDZyTcvx9erI=;
        b=sJn+w6cNYh/hS/cOjfWueIbg78HJkzFFYiHqIRTwr7fngmvPjTaYNNuFi4cOxqkItP
         d7eX+7wqC5/Mfw4P7z4e8XEiDO+mGM93oSi0TXkxUZOCvUvFkZEvL1w3SsiKAY9g7DqU
         bAA4qH4agB+ntUSTcxj9vlajYqlPsTuduaWdkJtOSXDd1hFZj6lZ/ea6r6sjrDPVhCcj
         T1bijEFSg5iiGgvnYVevvJZPXdShicY0MwkT18INJc3ZV7P5OwTC6MvofHUYTt68nkRQ
         YnHeeuxhIVNgFtXr/Dq5ep7f6MJ/doW+1QkQub+GEoPcWwCV0sRd9S+E3VyWN6iFwYAX
         QIxA==
X-Gm-Message-State: AOAM530jOYMPenjTwLlEzeTswbNXZ/vCiK11/V11CgsMs6XvErnahKNH
        9XD6sxu4Xu3CDna/JclV247y87biuUQLCg==
X-Google-Smtp-Source: ABdhPJy/+IXZ2PdMviB6+ECuMAc2lv2U9mfPV1WFV3+IW2lLldHPZ2PEVAyPG6Wzzj9hMZz5V0NsnQ==
X-Received: by 2002:adf:d23b:: with SMTP id k27mr5695587wrh.144.1634811540689;
        Thu, 21 Oct 2021 03:19:00 -0700 (PDT)
Received: from google.com ([95.148.6.207])
        by smtp.gmail.com with ESMTPSA id n6sm1271311wme.23.2021.10.21.03.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 03:19:00 -0700 (PDT)
Date:   Thu, 21 Oct 2021 11:18:58 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 08/20] mfd: mc13xxx: Make mc13xxx_common_exit() return
 void
Message-ID: <YXE+kl66fr8DfcNr@google.com>
References: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
 <20211012153945.2651412-9-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211012153945.2651412-9-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2021, Uwe Kleine-König wrote:

> Up to now mc13xxx_common_exit() returns zero unconditionally. Make it
> return void instead which makes it easier to see in the callers that
> there is no error to handle.
> 
> Also the return value of i2c and spi remove callbacks is ignored anyway.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/mfd/mc13xxx-core.c | 4 +---
>  drivers/mfd/mc13xxx-i2c.c  | 3 ++-
>  drivers/mfd/mc13xxx-spi.c  | 3 ++-
>  drivers/mfd/mc13xxx.h      | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
