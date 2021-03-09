Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E920E332E0E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 19:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhCISRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 13:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhCISR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 13:17:28 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6570AC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 10:17:28 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id f12so17579307wrx.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 10:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=E2H0Vyvaz315tDwhjzi69+8Sz+mC0Vpp4i0UyuyRi2U=;
        b=OOOCffOshjfg7+dvyZj59QRnaxsN4ELj/3FpNu0L7www0KXU24C602V8W53cP3q1h8
         YOznA5A8YJ8+PXMvIpLiR0tJxCB97xVjEzjjv96krTWoURtbCi6+gBxLZ99MryYRRuxV
         EEh/mgkmc8+3ZkCXHwreG6QtWdFM9lfX9r77/7wIpUeIcvJ4nMmyVbi357w5DHLolyx6
         qQDzymqVvyUG9mQwZmHIsC/28Bsiw+kQnk5xrXAyBiyuneWdnaXH8F59l9IaYUFL4kIJ
         YwRSUtuiuUrVinGSOd+bTncAFloBSmj51TdwGFVWY0ZAhxyfKyLNBGsDjxf79PuQDflr
         hxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=E2H0Vyvaz315tDwhjzi69+8Sz+mC0Vpp4i0UyuyRi2U=;
        b=kN1F1f2u2Qqkst66/bltKwObAefETkGeyzE9jbCkkAFNCdUwgvK2oRM9KcGZao/cYU
         SxiJGg4wgcPEwSLjaNIkNl4U89xvy+01RRn0SpHG7T7h+hfYVyoSSXPkYneXqAQhizpI
         RQPaERTeyEy++bXjFIdO1rwl7OUtJZ9+NHSVBtNHqPJqAcslA1wYECYQhfXD6QcL5uOO
         zd7v1T7c1x8MttpljbG/XwO2vrfUBe/wfLP/VzrHvRbrQsy34gLEw6qhbcwtSN7cWSTC
         Le4Yn11mE/ePQUHSw1DxtYiwkQMp98Yt7LpwI16+r1K+HX176oU3TfW/vN54ETlcwxOK
         JbIw==
X-Gm-Message-State: AOAM533DwInPllJykkSfOa3i5NtG5EKloIqc03Ardg4YyIAwdgLBbWW5
        D8qJ+QV+kcL55QiZ1pbHh7L1pw==
X-Google-Smtp-Source: ABdhPJxFquNSN6BBhA1UcWqdovNTR3F+6NiI5iWL1dYGNi1OySoTQxoOH3OPGovMK29FhpkUKWg1vQ==
X-Received: by 2002:a05:6000:2cf:: with SMTP id o15mr29146414wry.184.1615313847207;
        Tue, 09 Mar 2021 10:17:27 -0800 (PST)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id j14sm23269096wrw.69.2021.03.09.10.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 10:17:26 -0800 (PST)
Date:   Tue, 9 Mar 2021 18:17:25 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] mfd: stmpe: Revert "Constify static struct resource"
Message-ID: <20210309181725.GX4931@dell>
References: <20210304230709.3217-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210304230709.3217-1-rikard.falkeborn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Mar 2021, Rikard Falkeborn wrote:

> In stmpe_devices_init(), the start and end field of these structs are
> modified, so they can not be const. Add a comment to those structs that
> lacked it to reduce the risk that this happens again.
> 
> This reverts commit 8d7b3a6dac4eae22c58b0853696cbd256966741b.
> 
> Fixes: 8d7b3a6dac4e ("mfd: stmpe: Constify static struct resource")
> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
> Changes
> V1-V2: Add comments to the structs that they are dynamically modified
>        Rewrite commit message.
> 
> V1: https://lore.kernel.org/lkml/20210302234710.74455-1-rikard.falkeborn@gmail.com/
> 
>  drivers/mfd/stmpe.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
