Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6029C3E1F9D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 01:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242658AbhHEXzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 19:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242641AbhHEXzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 19:55:41 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8365CC061799
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 16:55:25 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id u5-20020a17090ae005b029017842fe8f82so4336815pjy.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 16:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1C+VxXWMleoDYXEM45pGL9SKotZgsC/xVSWfXxI+Hfw=;
        b=haT0giKocqtfVB9K9Fo4/r/rmhv5odvT/bDbSH1qqST7gkVOpf/o6T7xJNlL10pbrp
         voN/P4e0861KcuaT5dIrwKRqdl4QzLWqgIq8YV7Md7Zs9mHUWhSP4GzjlO4lRo/NHjuJ
         mKbMBWNq3TY6cTIFlTlp+3Cu/9zl9/ttAJTBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1C+VxXWMleoDYXEM45pGL9SKotZgsC/xVSWfXxI+Hfw=;
        b=mRukU2sRFkPvq771GRYuVZRlBuN9QwGy6lgFWKqCuzFQxNadDhaMYLuiresC/fq3WS
         9HoRTgTE89gf6ZjXljBan1hK9jyg5JBxJ60T5KkM9kb03UlTIJV0mJPfsGKYXZVQA+m5
         MEmtRfyd8EAV9keM9T+jVDeJAewGYlF2m+QMJNdUA1q8ScVvSm01rIszrABw/UhbzvcD
         BV+hplNkRLdFK7Tv56UBbFXRGdF56RM/u+3vD0IUd0ZyE+QvaZsDVNYHnvd5D7hOsnqz
         W4k+f8yY81a8cSti/F68smYeOg11ZHDftbncR7CqIA4VIsiwaldFKGFX+jOB+o36+tzZ
         dghA==
X-Gm-Message-State: AOAM530+BUY5pIZKa22/8wVveddpY66uPazVjo4/V5MO2FfRu1Tj8/X3
        bV4m1fBfED2ztDOoF9dXpXmzHg==
X-Google-Smtp-Source: ABdhPJzdxyBw/J+PaVikuCIniaWJD5K3etzXckn2Z5w/jSiCkeLEqwY/NnNDwR5lHivbEkKjvD++xA==
X-Received: by 2002:a17:90b:80c:: with SMTP id bk12mr7407351pjb.69.1628207725170;
        Thu, 05 Aug 2021 16:55:25 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:8944:bd:9484:29e])
        by smtp.gmail.com with UTF8SMTPSA id c26sm1724774pfo.3.2021.08.05.16.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 16:55:24 -0700 (PDT)
Date:   Thu, 5 Aug 2021 16:55:23 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alex Elder <elder@linaro.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, robh+dt@kernel.org,
        elder@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sc7180: define ipa_fw_mem node
Message-ID: <YQx6a+Q5uwkEZFbB@google.com>
References: <20210804210214.1891755-1-elder@linaro.org>
 <20210804210214.1891755-4-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210804210214.1891755-4-elder@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 04:02:13PM -0500, Alex Elder wrote:
> Define the reserved memory space used for IPA firmware for the
> Qualcomm SC7180 SoC.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
