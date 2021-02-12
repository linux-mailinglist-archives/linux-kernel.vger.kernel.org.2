Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E9F319C3D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 11:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhBLKA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 05:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhBLKAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 05:00:20 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8C0C061788
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 01:59:40 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id b3so7190444wrj.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 01:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=F0QgjlcZo1NCERygwIl1ZxHTWyVzChNPkk6OPsL65A0=;
        b=hxmqQjd4fIdH4bnTMyec3YULt0F4C/lr+66bjv0bP260Wa194Xkrq5xz+zI6n7hfSa
         RLMks9SpHcP7M/INs9UsDIAyNtGRBqQ5AhxEhm51UXlWINg2vGqJM/u+u/qqgdcKQkoK
         nXgXc8MtcpyiD/q4y8YFyRBJ9yFwuwo0drfqFJ7svIqeh4Spcl2iG8jYdaIGEQ6ZSr4h
         PfT1KQA0x/EdIhhs9Hz4WMZrmf4o1e8e2u7pVdHol7eBwRpcIWKxg/cpPoDwD7PTQjqF
         OCAP8MpaJieMykrqlj6RbdZkRRtsj4Gbt73jPGDPErPXNwnBvxMFB1/5WafljNQZKlns
         TT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=F0QgjlcZo1NCERygwIl1ZxHTWyVzChNPkk6OPsL65A0=;
        b=XJn1D/oM39nxuhcuDL1HV4nrtPYBdoFBTa4Mp01IaqQxe6C1yeiQqjwuVxn7mslJCj
         JfQLyzclvI2U1X1Mp6BexOr7a3fDc760pfRpXBDVr/8U5b14gW3dzgFpo8LWjRXV1O3S
         fHv5acQUHZ2imc0DdQ90Ux2b5CXSJ+VddajkSr7Goo4PDf9fxG9eYfByLHuMj0qblYXZ
         09HPyf2x1EzN5kirN1VRqDJnXmdmchMg7t1wrM36u2tcsZJViAthvnPKX3fcWG23Vtm2
         yGCfOe/RlJj4c4PwlPms3JZ6IVDdVCWUiq5mrt323Llke5X0WrdCgZ7dffokdl5KFxkY
         ErrQ==
X-Gm-Message-State: AOAM531kkR8smoKCa/iGZuQwiTuJ3MW3s7zxsleoBu/ZB6kKr1JSJUOb
        EpLWncAWRpKXtoQ1VkAhkQ43lA==
X-Google-Smtp-Source: ABdhPJzcU93uASa8zO0DhBUnqebplXpxTM5+Fj8QkL0hsiRpabJKHjLHx0g4xRRjz22UBrX3Fw5kAw==
X-Received: by 2002:adf:f648:: with SMTP id x8mr2407663wrp.34.1613123979188;
        Fri, 12 Feb 2021 01:59:39 -0800 (PST)
Received: from dell ([91.110.221.187])
        by smtp.gmail.com with ESMTPSA id f5sm14235320wmf.15.2021.02.12.01.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 01:59:38 -0800 (PST)
Date:   Fri, 12 Feb 2021 09:59:37 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-power@fi.rohmeurope.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] regulator: bd718x7, bd71828, Fix dvs voltage
 levels
Message-ID: <20210212095937.GA179940@dell>
References: <20210212080023.GA880728@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210212080023.GA880728@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Feb 2021, Matti Vaittinen wrote:

> The ROHM BD718x7 and BD71828 drivers support setting HW state
> specific voltages from device-tree. This is used also by various
> in-tree DTS files.
> 
> These drivers do incorrectly try to compose bit-map using enum
> values. By a chance this works for first two valid levels having
> values 1 and 2 - but setting values for the rest of the levels
> do indicate capability of setting values for first levels as
> well. Luckily the regulators which support setting values for
> SUSPEND/LPSR do usually also support setting values for RUN
> and IDLE too - thus this has not been such a fatal issue.
> 
> Fix this by defining the old enum values as bits and fixing the
> parsing code. This allows keeping existing IC specific drivers
> intact and only slightly changing the rohm-regulator.c
> 
> Fixes: 21b72156ede8b ("regulator: bd718x7: Split driver to common and bd718x7 specific parts")
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> 
> I just noticed this fix never made it in-tree. So this is a resend of a
> resend :)
> 
>  drivers/regulator/rohm-regulator.c |  9 ++++++---
>  include/linux/mfd/rohm-generic.h   | 14 ++++++--------
>  2 files changed, 12 insertions(+), 11 deletions(-)

Happy for Mark to take this in:

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
