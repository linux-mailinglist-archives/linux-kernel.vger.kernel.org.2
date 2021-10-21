Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B196043607D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 13:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhJULq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 07:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhJULq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 07:46:56 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55ED9C061749
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 04:44:40 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id z11-20020a1c7e0b000000b0030db7b70b6bso6605298wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 04:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BQghDj/yxu+BYKgp+pewmhnc8VbRAWzyyq3pG3ohJ1c=;
        b=alOuexoeOEbr2u8pleBfmWODBwtFG2z91Gz8hmXndjHSCaea+xFC+IrALsOsA/0slB
         TTDJdjFp8rx1Xgg9DbjskOOC8liEuGxs/9kUDJgnvPdAc4WfnkuUX8TVfIgCutB4u8IP
         MMKl/KUsSmAQex8Rgvz71iUWPzpJAl0O8OhmfIJGik1X+VtT0PJiEA9Fkoo0BLC2YaLO
         /JIeRhZ4htghC9+ZhNeeDv5tdB0t50F6sN5aIvxSHSCEZLlWivsPQfvApPHuIN6l0jm4
         zegbvtVcjysF4fcEOhe/xRiQVbLxt4NtLQ/XqiDrbO/NgnMYiI8td/gzWHgrOGJJ4mT+
         eSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BQghDj/yxu+BYKgp+pewmhnc8VbRAWzyyq3pG3ohJ1c=;
        b=Q1zVRhfahVkTa5N6bDvFzDs+mQsi0osujHapg2TYGxQBo7d2CvsPHhN1HW5aVT4dr7
         aN7aXWOoT95nFuJfDpamfcCjdN/sP6CkLXIj7c7l1N2xYU/ivkSpdCAvWm2llSChsNmX
         DBu9d6MX0IDMDCbfaVR7Xrf5lGhvO94QM8AKPAFCNxOe0UmBgNlf/rqIPLWnEn1ttjuM
         AJ4948v3QxcilF7zoynVx8bci7SQAPZv9IG7pHFt9wA8cWzdPsoLFz7CM6LqABmwtXul
         xqMpXlVALDhux+KtiNQp959pYBd/wnjny+YKZi3Ye8nIb4BNpzNdJGLNVogdI0Roq/VB
         +piA==
X-Gm-Message-State: AOAM532Z88bxElfYhVC9xfSVsDktnR/rZHjsKKyWc3F8H7fzkZEZQ/Qq
        /sQK23TvTnQeUzkpVdTo99H2fQ==
X-Google-Smtp-Source: ABdhPJw7ZyD5LBmoz3xrLWqdu8YqVeD4Omz4svKdSjfuWID+h+2qKj3oUHCPZYTIsfW60MV/5c7IZg==
X-Received: by 2002:a1c:20cc:: with SMTP id g195mr6321718wmg.22.1634816678970;
        Thu, 21 Oct 2021 04:44:38 -0700 (PDT)
Received: from google.com ([95.148.6.207])
        by smtp.gmail.com with ESMTPSA id c17sm4619298wmk.23.2021.10.21.04.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 04:44:38 -0700 (PDT)
Date:   Thu, 21 Oct 2021 12:44:36 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] mfd: qcom-spmi-pmic: Sort the compatibles in the
 binding
Message-ID: <YXFSpGfOOF3pk/OY@google.com>
References: <20211017161218.2378176-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211017161218.2378176-1-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Oct 2021, Bjorn Andersson wrote:

> Create some order in the list of compatibles by sorting them.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changed since v1:
> - New patch
> 
>  .../bindings/mfd/qcom,spmi-pmic.txt           | 30 +++++++++----------
>  1 file changed, 15 insertions(+), 15 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
