Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51964347621
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 11:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbhCXK3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 06:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbhCXK3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:29:46 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AD7C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 03:29:46 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso855299wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 03:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+f6qWTgMcrQYgGkjK1Qu2KgMBWxonfZuC4YtmXixTSo=;
        b=ewfVPqyqPqNADrJSpngplAZa7qw3K/v92hurFpJ0zyJYulxiR1/CE5uqEEWskUNlZc
         FbV5hYm4I62/KUYruxe76LmqKVAbvqyTsBQgAIvPDrAgqvKdnXNZ+sOZpc9HCkSZOWmK
         zkCCsY7AxFAp5hrA1rOR1dFm1KERNjEg6eFYsgev0/au6aBUlJ6Z0vfkTCF7vqpkTgxi
         iw7L/z70R4Ad89fpMhqHXn7rishCwsmBmHb28fidNyxB3ejq/iYl49veTwrqCizgiray
         YAfVT3V13MIymsf45iquuAM4IlMNlho6hf1eBLaAYCk7wXX8+hPlKsF2K+HrNe2dGDVU
         uzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+f6qWTgMcrQYgGkjK1Qu2KgMBWxonfZuC4YtmXixTSo=;
        b=NPiG4yRUaL9z2tKjsiaUGDaEzERhGGNoJgvNV8ZDas9wJ0WhnhLs2z5tt3kcrqNuvX
         CLSC0NRhBYdhRRMBEOVVdXwY0bC/y0aB6kJc0FpWkw8krn0vV5Qi6CPIprCJTyt2k+Du
         VoW7zXMPsUWjFA/FYMUeal/CRG5KtD+dm1jfN5R+nf+Y4ZK6b0DUjosi138O/iJMQ7L0
         oCQ49knsJ0kJIewFJxP5A6Q9B9A1ApfrSFn3bQ2CeZD6vPqlAs67Xs3gOSqo780ok+UI
         THS3Nll/2J/TDS6jEX+r8LgJCLFlfA3YpIOkOeiPLiZ3O3sILIAQmJTm+p5PVOv/K1AM
         H0dw==
X-Gm-Message-State: AOAM532mfhlP7ToiDbAE8Al3/P4ksLSj2QrX8rAPISSnRlEYzJDjgOar
        VFcDlJk2c7XiiQ6mymmVWhFIL+bBMUPV8w==
X-Google-Smtp-Source: ABdhPJw5h4Bf9hf0P3D9FwIHcna9GqMBSf2gfH8QfmRAtP89TOxZtjRaPR96+hJ82KCajVM48lef6A==
X-Received: by 2002:a1c:2016:: with SMTP id g22mr2181401wmg.137.1616581784881;
        Wed, 24 Mar 2021 03:29:44 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id 9sm1837773wmf.13.2021.03.24.03.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 03:29:44 -0700 (PDT)
Date:   Wed, 24 Mar 2021 10:29:42 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mfd: intel_quark_i2c_gpio: Reuse BAR definitions
 for MFD cell indexing
Message-ID: <20210324102942.GI2916463@dell>
References: <20210323123433.45371-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210323123433.45371-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2021, Andy Shevchenko wrote:

> It's convenient and less error prone to use definitions to address
> different cells in an array. For this purpose we may reuse existing
> BAR definitions.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: used explicit indices for MFD cells in the array (Lee)
>  drivers/mfd/intel_quark_i2c_gpio.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
