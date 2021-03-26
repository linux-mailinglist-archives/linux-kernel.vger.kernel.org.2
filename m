Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B008234AA85
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhCZOwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhCZOve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:51:34 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BF3C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:51:34 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso5059944wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8uOA9ZquKblNGmy/7sTv9dg7ylqzXSuAXyBkUOEnh5k=;
        b=pKXAOE60LaWTojAdVYXYkaBjTHg7CVglS3GveCQpFM8Dt4mjaXDdQ7ZAXNkiuW5S0Z
         YKKBVzs/4AEuZy2f3Nl00cQT4hNbz/WothHEiizOs8QORQvw1nDfDnQSRPOlANPAeCn9
         U8cjvuPBOQ5rreJa9JZjxQiNQAUc3zegWvVl1KGGUSPzfocZ+eS2+u9hAVbXiNIMz/Vq
         qm4OV50j3OwYy8Ilb3AZvBEN4N0asl5yo4uGUJyARsaJwXOK8v2ZdfFszsS5B2YUCy5w
         Dhpv9qVL9/IitCq2e8z7T1J8/0VQDKiLa87iTBvjiQazaLoiAQTI9fu+sA5gxQRin/En
         gpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8uOA9ZquKblNGmy/7sTv9dg7ylqzXSuAXyBkUOEnh5k=;
        b=KoBbKyupVuFOFzucgZstEl+DFjUPWtR8h1lK2OT2++p8eRXiQr+J2Ys9bBNpbINokX
         bk9FZ8HjGyQIa1EoSk81/cf6vQFVFoBg/MoSVOs7g1LaDfMRV23OdqfjTZdXPupIEK2v
         wpPQOtqb3BSqehn4yczKLiGrv3iU/WW7XN2sqbIL/78pDYC7WTcVe4u8Y38nVRK/SQil
         iylAnFkv6C2P2/96qf3IXPXWciMR09vYRb1z8QPtiRNpdb3T64DwlLWT/rTZ6wqcBibw
         OILicE6o4bsMkEpmHyQD5ej02qC8PhfqgBAK4I4Oxw3RqZp3nihYlF5Fx2E3hKvxM6RE
         xbwQ==
X-Gm-Message-State: AOAM531OrMrXiJfSgtzCzLRbxjWlqZJimNrvajS+TawA0+Ce4lam7b2T
        WtctvV+/+c4PVVc4L4TwaB06/g==
X-Google-Smtp-Source: ABdhPJwnF8qDqrTwfzJqDqtoEa9Nd/AMCd5XgieRpJIxwnqAX+ege0yTIaULP09O1vCFG+hTHIrGxA==
X-Received: by 2002:a7b:c92d:: with SMTP id h13mr13483344wml.147.1616770292990;
        Fri, 26 Mar 2021 07:51:32 -0700 (PDT)
Received: from dell ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id s20sm11412107wmj.36.2021.03.26.07.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 07:51:32 -0700 (PDT)
Date:   Fri, 26 Mar 2021 14:51:29 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 1/1] mfd: intel_quark_i2c_gpio: Don't play dirty trick
 with const
Message-ID: <20210326145129.GB2916463@dell>
References: <20210326124842.2437-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210326124842.2437-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Mar 2021, Andy Shevchenko wrote:

> As Linus rightfully noticed, the driver plays dirty trick with const,
> i.e. it assigns a place holder data structure to the const field
> in the MFD cell and then drops the const by explicit casting. This is
> not how it should be.
> 
> Assign local pointers of the cell and resource to the respective
> non-const place holders in the intel_quark_i2c_setup() and
> intel_quark_gpio_setup().
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: eliminated bar parameter (Lee)
>  drivers/mfd/intel_quark_i2c_gpio.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)

Neat.

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
