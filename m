Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21DE333898
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 10:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhCJJVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 04:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhCJJUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 04:20:50 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38A7C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 01:20:49 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id u187so6608773wmg.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 01:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tWe8BBy/Grpe76XE/g2ZHEzNebNipo5s14kvH6ji3n0=;
        b=iV29gzW2+PaN/fUAydh0RYmuW30QVJz/q90S6gWPpH5P5qO00IgO8T/PoJOy0EvGwX
         pkHuy98buZUaQNtY8VNR/tiNYnAtTwIrr9OZ03GFAVsRHmWMZB5RLIi0boIO6Yjr8tvg
         P42xZE+BAhEXddAXcEhpgBh6+obyq3Obe7Nq/okXmoYuCfThyKKghGV1YjWfMD9KcEU+
         B6JwCP/t7Fz/mgWT6t0F7WqcVP4A2DOr0lyVMpe7HsQPBfs6mEEYDI7ypHblHrpsZRDC
         /YkejYbGKKG4tB5LKwwGbqGdJkWj1/uEXkn+c2snehxlQNiz1dQQEPvgpo2RUfAG1+MO
         m5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tWe8BBy/Grpe76XE/g2ZHEzNebNipo5s14kvH6ji3n0=;
        b=KvgbbgZNE+TrEjXEsAPzyJ9lgEjm8A8NW26sq7Cp9s0Cg6hX9g1KKMnRza9WxTkF2b
         UqL8PHvRLPUU0m5TXEaB1JPJUNY7w2cgfiaKb24+0bRaYQAdNLECUUalDhzeAIfugiYm
         3wBhiBsNTFjGE3lssUzpSshKGR+/K/zOyoneGE5RYiTEnkZAvQFBoeYEH2OfpKX15FBC
         vQNbHEpDRtUKC4/Qbet0sxjHuusCYsiFR65YS12z70HzZP6SB9ww0e/X4h8KNn9Vbhqp
         t3ymcOanWa4YLk06/6P+zzDoELrOMcSRx7aTKj+gstnKoMbhi2/yYVmvdR/53cRngqiv
         2T4g==
X-Gm-Message-State: AOAM531CvabhQZm1qgzVzupq5ohtrMoXl+NUQfPW8G4Vpzbc5tfIDE0y
        w3fi3+EECob6f9jz0WA8v+IClvnInTwQsA==
X-Google-Smtp-Source: ABdhPJyEitYe1kT60YMC2lFQpM7Na/RhDsTp4v/CvInEUBG8HKN4rdsdgmFXdibppd+8oGfzFmfXSw==
X-Received: by 2002:a7b:cf2f:: with SMTP id m15mr2297330wmg.177.1615368048614;
        Wed, 10 Mar 2021 01:20:48 -0800 (PST)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id x13sm28108821wrt.75.2021.03.10.01.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 01:20:48 -0800 (PST)
Date:   Wed, 10 Mar 2021 09:20:46 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mfd: lp875xx: add optional reset GPIO
Message-ID: <20210310092046.GN4931@dell>
References: <20210226142852.19632-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210226142852.19632-1-luca@lucaceresoli.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Feb 2021, Luca Ceresoli wrote:

> Document the LP8756x-Q1 and LP87524-Q1 ICs reset pin.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  Documentation/devicetree/bindings/mfd/ti,lp87524-q1.yaml | 4 ++++
>  Documentation/devicetree/bindings/mfd/ti,lp87561-q1.yaml | 4 ++++
>  Documentation/devicetree/bindings/mfd/ti,lp87565-q1.yaml | 4 ++++
>  3 files changed, 12 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
