Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC384536A1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 17:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238759AbhKPQDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 11:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238727AbhKPQDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 11:03:31 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7292C061200
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 08:00:33 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d5so38571885wrc.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 08:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vivvsuH8s0Rlwy3Rc73sEbERCHnOl4u00Z/GA/x3G6g=;
        b=nbFTZdxqyIjVmvoX+jQEDonrxfsgwvgcbWn7JBcn72B3lmU500wQqiPby9Dwjx4W2N
         d/VAdkun5xUHfOy/a6s9eW7+76tsriYEsTi85gvFEZTsnIw5NGQyIcan/VvYqbC7bgAH
         o3N3GMTH5BgniwzuS7AMq0yg+L7Si96FrP5+S7FQlzrfkIzfl0wvCfPKDqYrjrM6cTHx
         NYEzdTVngxbrDuP9OP9jmPNnNV9QvIgGj8O5R1QafhV6/IBcFgxl3sl8Vxaop2wHGT/O
         Gj8GjTLPRRh4FzfI+tHd/XpyCg1LbKxtST7/ev9qdQZtx0Tc43wQU0JO0LK+DAk2sS07
         tqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vivvsuH8s0Rlwy3Rc73sEbERCHnOl4u00Z/GA/x3G6g=;
        b=xn+BNBdMPpJpMhCduaVDE2DqMVnA5WXdtB40z6YVEYkrcHkvPDxf/5s7doUVnqKyIn
         lbCP06CX0mqAH62k6QJPNqSTPg09griWLz0ESeq+Ap+LOy/v8xVik+8PeAxGhxV+UKoG
         1CBau6iOJc5KmKLjHCxPTgy48RJFowN9+rnMDeY5AIw3TfymQgjPZ1GXsEV1wjEuKw1b
         edfz46RwN0Rmzs+W0dKp5ijD5QHlujnVuzAPH2rOMOOOjJVByfh6+ityVERwavgVXQ1O
         +7sWIa294Mnna01Wkgr/aQt52be0u8uzHz3Qu0jIozIRLnXKJKaE0oRRDD26lU+3jzgD
         MPkQ==
X-Gm-Message-State: AOAM533tc6JnIMWkQV2MasnGtdGzwFg6WokWllHjFDu32dpG4QOA3xS5
        FU1Rv62812q4n1lXuJOZlAaZNQ==
X-Google-Smtp-Source: ABdhPJyZehPq7JhDNNL/XDSuANWvtcj+10R5LKYSSihExPpAqdY0UUojx0svlCksSWQARPLgPwWa5w==
X-Received: by 2002:adf:f64b:: with SMTP id x11mr10869001wrp.4.1637078431851;
        Tue, 16 Nov 2021 08:00:31 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:6870:334:c3a9:fed2? ([2a01:e34:ed2f:f020:6870:334:c3a9:fed2])
        by smtp.googlemail.com with ESMTPSA id h15sm3377964wmq.32.2021.11.16.08.00.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 08:00:30 -0800 (PST)
Subject: Re: [PATCH 1/2] clocksource: exynos_mct: Refactor resources
 allocation
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
References: <20211101193531.15078-1-semen.protsenko@linaro.org>
 <20211101193531.15078-2-semen.protsenko@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f7dd62c9-9c4d-4130-58ee-54ec2b7729f9@linaro.org>
Date:   Tue, 16 Nov 2021 17:00:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211101193531.15078-2-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2021 20:35, Sam Protsenko wrote:
> From: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> Move interrupts allocation from exynos4_timer_resources() into separate
> function together with the interrupt number parsing code from
> mct_init_dt(), so the code for managing interrupts is kept together.
> While touching exynos4_timer_resources() function, move of_iomap() to it.
> No functional changes.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---

Applied, thx

[ ... ]

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
