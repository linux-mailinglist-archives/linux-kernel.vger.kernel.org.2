Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83B934760F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 11:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbhCXK0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 06:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbhCXKZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:25:53 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB49BC0613DE
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 03:25:52 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x13so23842891wrs.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 03:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qjEhgUPFvwHb5+KHxn+4KIpYVjsta8J6wYKjuqn9+OY=;
        b=rvQRQbS4/rCHwEFif0ZFK5f3O0SGZ/Ss44DgwLb5AuTXF0CYUzNuOXl3h32QUjpKcI
         kFsHT95fPWak1WLfF0nS45Gce97wDcuPqWGPTfrvTGkxtMu84zNS0owdT8OYBbxtgUaU
         j0jOgGxHZV+s3ZZkbjqyupq6ySlFYY3g3VjO2B7JaWQhusUn8PPNEv9ngsgrvdp+K8Va
         1tb09sk3fU/kYXMB0Rt9lxrmN4k8ZFVXDHySZiWgaDPNzgXlW3oljKlJOsEnDHjEOhK2
         KMkRSgQi7jaUeIL6TnkGi/xOR9rQTws5wSXdLcAogTSS2zcNkNSXZQGafNhD4tQ5kgGJ
         wgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qjEhgUPFvwHb5+KHxn+4KIpYVjsta8J6wYKjuqn9+OY=;
        b=Ls8zZLLkY+zISJcZFIez9lJWnn/klBdbclisnrKDCON2KM1YzOomdz4AvSwrb73IiR
         dqVnj84BP+pWjqUlFtxZypdZdEZ+2kUxHDq6thAQRfaAo5Z04QLK5rnjaNmsFvrCXsig
         6Zp+0XnDpuRxagujDKTjIiJWuYjwWlfkG1P21kj21m5G8HwrUR9OVntXuuUnFmIk8cln
         YzR2TPOAYxlXPuQzym+bFhfWm0oBDByePthnJ4po96SbD6nmIBKfEe60HKmUjokAdTnB
         YTytxbaML8T99ZbdyTd3D1D0267W1blcQR+32R7Gg2Rv2UZqlLiHV1oW19mMDu5COc43
         FlHw==
X-Gm-Message-State: AOAM531q3RKd5eQ1ArnSctt8xP7Ns6wHY3RN2bbADzMSf8QI/m0YJNei
        nlNrv0a92oNnw/40ip1u6UOpsQ==
X-Google-Smtp-Source: ABdhPJwk1MI1RHY8Sea3Ygvccjb7QoWKvckxXv3Q1peFwFf8ZqsaAQtquqPmyLzeOrfpw/KcUaTUSg==
X-Received: by 2002:a05:6000:23c:: with SMTP id l28mr2758231wrz.251.1616581551495;
        Wed, 24 Mar 2021 03:25:51 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id h21sm1777683wmp.10.2021.03.24.03.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 03:25:50 -0700 (PDT)
Date:   Wed, 24 Mar 2021 10:25:49 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     j.neuschaefer@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mfd: ntxec: Support for EC in Tolino Shine 2 HD
Message-ID: <20210324102549.GG2916463@dell>
References: <20210315191832.16842-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210315191832.16842-1-andreas@kemnade.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2021, Andreas Kemnade wrote:

> Add the version of the EC in the Tolino Shine 2 HD
> to the supported versions. It seems not to have an RTC
> and does not ack data written to it.
> The vendor kernel happily ignores write errors, using
> I2C via userspace i2c-set also shows the error.
> So add a quirk to ignore that error.
> 
> PWM can be successfully configured despite of that error.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Reviewed-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> Changes in v4:
> - rename subdevices back to v2 (suggested by Jonathan)
> - initialize subdevs in switch
> 
> Changes in v3:
> - remove have_rtc variable
> - rename subdevices again
> 
> Changes in v2:
> - more comments about stacking regmap construction
> - fix accidential line removal
> - better naming for subdevices
> 
>  drivers/mfd/ntxec.c       | 56 ++++++++++++++++++++++++++++++++++++---
>  include/linux/mfd/ntxec.h |  1 +
>  2 files changed, 54 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
