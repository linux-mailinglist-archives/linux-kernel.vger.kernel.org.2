Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C59319BB4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 10:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhBLJQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 04:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhBLJQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 04:16:52 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC520C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 01:16:11 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r21so7029191wrr.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 01:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kUYv2KevXMCG7W+75jCv+dsU+nPEnb7kuNg7HUmjQ5o=;
        b=m6CghIaDlsvS9RXTSKN/UkJVG3PaNDlKvEdGnZ+ExwFnX+73cen1AO8a538AlBr3qj
         RyEK9pMH0HdTV8whKNq1HDs70mxgUkwsip76e/yrFEaAYYqUYIncB3U8HEOnya+H7Fbc
         VYmIxykXFS+ZQGBQYZ/gfpG/eM6SiNikkKx0chmEjtuunKxhI7/EFqzgaH5tnE1qC9gQ
         8Ct+FhIhBrZXX7zf8Mtm1ZFAbm6GMKWItBTLVLlK2ftl2lGwRO/hngTefp6LyGmmXrOt
         WWFVF7/rrk7cDqGOdnLcRJkV6F/1Ug9W+C0f1BW13y2E9Wrjah/5T9Uf7/Qxc74SlNdi
         chxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kUYv2KevXMCG7W+75jCv+dsU+nPEnb7kuNg7HUmjQ5o=;
        b=A7FQJUxvWcV0fPObpW3ZRN/iwrUv3sLE0Jwn9KMHjkFuJvx3saQnFIeI9mUpC2svJv
         D5clt7WWdXIEbPb2GDQIxDkZQXz+i3VHwXgWC3uP2zxIDGbOAYOB1NKec2W7odwv+c7s
         oS0VDCcfA0Py0lmsdzUUcoBQPXxGo2IKkurXCy9x5LcpeJ6J69jaR1xa1h6MgSVVKsnt
         C0ko1L+yjxoVl7lFajYE92XErsreMQi3da/Kjir+HRfVWxFbylARy0RX/aAXzF4PpJBO
         ui51vHkUf3Dhj+69Ohb0V5H96aK2BOBjWKsIkRvpbGhPv45i+QTxlmKhitZ7VWMA8YUa
         Aj/A==
X-Gm-Message-State: AOAM530XJ8S9jIc0Em73J4OssNVx2R/Uft9eltLbd2G02VGp4zY3/kVs
        kwtZ4m/ROy5a0ZWFET8N940OmQ==
X-Google-Smtp-Source: ABdhPJwi+/Zi/g169w9NfyU42rrojhBzuaCKhfJVczRJIosWKsRgUpH/BV9df/ROMScChFxAtXc1lA==
X-Received: by 2002:adf:8365:: with SMTP id 92mr2306295wrd.23.1613121370571;
        Fri, 12 Feb 2021 01:16:10 -0800 (PST)
Received: from dell ([91.110.221.187])
        by smtp.gmail.com with ESMTPSA id f7sm9258623wre.78.2021.02.12.01.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 01:16:09 -0800 (PST)
Date:   Fri, 12 Feb 2021 09:16:08 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-power@fi.rohmeurope.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] regulator: bd718x7, bd71828, Fix dvs voltage
 levels
Message-ID: <20210212091608.GE4572@dell>
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

Not sure what you mean.  Isn't this patch part of:

  [PATCH v2 00/17] Support ROHM BD71815 PMIC

... which has just been reviewed and is awaiting rework?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
