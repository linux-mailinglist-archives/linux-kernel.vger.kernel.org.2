Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1F835EFD0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350126AbhDNIiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346738AbhDNIiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:38:06 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE0BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 01:37:45 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id e14so30103717ejz.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 01:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dg8FS+bLDkB10N5Z5KnKd2eYRzDk9ID1rsN2vEPTbU4=;
        b=GGOjZ7BVkPzalD3FUyVu39H4QrFG5tUQc1m1z9OkiFvXJSHHOUtcbZFJ2RMrgoL+M+
         t/E5EH1PteIEwws9YYapeHD4xmlg+U+MSAJj8hbHRA1a+5XrbsECm7PJdbIZhcYmtzty
         7ieyTaCKb5OfbrUuK1zqlam1HFoGG77x+btIa0uusnk5ImMtuWbcYqlyhYHDGl2CYj+b
         KIDf5KtR/hqzWDo51x7EVHRbr9qaf0iYKTo4MvtfExqrx5FgJrBMrZIAi35Jgvz7v+By
         wTK9LgjFUY/rZwvqg7GoCzMi2fStbj3qN3d12cb/GJumBG4kmscI5N3HG5B+bM0dm7Ld
         sg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dg8FS+bLDkB10N5Z5KnKd2eYRzDk9ID1rsN2vEPTbU4=;
        b=MfEEgRmyjk0NKpLBYTwa+W8ELRxvMEmM5+7teu2f5q4TLkBy6M5+p8NdDGAp3w/bx3
         k0NMGV2LwAkDRkdUvxo8c2RSyNEVJ72ejloh0Q9H8h1OjPOnRrD3WlHQ3oUbPCMiWQp1
         Xil3LEiM5BMjz1webLJ8hyifTdMmNvM6gS5mnlWi6seqX1GbnMuo4/VYh8lYPZ1yy7Gg
         FU/9SqCmUBvwZYq/sK7KzK1eqwgQMVOsXgxLjoOfS8mmpFMUVRf9zxYf6gHRWpeug2cR
         f2FXwgKwQ/8I7tal7xR+9QVOq8nDrW5MnPAEGTnZJrid/qPl+mIztfTLPWcOMD7rD/TI
         jIzQ==
X-Gm-Message-State: AOAM533b1sL+kQcMGKTSMW70JK/zNTOkSRk6QJIlH4XaBKDUys0pwK5d
        4zS83aXn4X4z3tSW4HdH2BLOVA==
X-Google-Smtp-Source: ABdhPJzcX935JREkGggRLRsEljVM25IyhSty1cnoTr37gYdkGR5gD6pU1kOHq7KK12mn7gdmhJ8Mnw==
X-Received: by 2002:a17:906:6789:: with SMTP id q9mr37394692ejp.295.1618389463848;
        Wed, 14 Apr 2021 01:37:43 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id n14sm6148221ejy.90.2021.04.14.01.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 01:37:43 -0700 (PDT)
Date:   Wed, 14 Apr 2021 09:37:41 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-rtc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kgunda@codeaurora.org
Subject: Re: [PATCH V2 2/4] dt-bindings: mfd: Add compatible for pmk8350 rtc
Message-ID: <20210414083741.GG4869@dell>
References: <1617976766-7852-1-git-send-email-skakit@codeaurora.org>
 <1617976766-7852-3-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1617976766-7852-3-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Apr 2021, satya priya wrote:

> Add compatible string for pmk8350 rtc support.
> 
> Signed-off-by: satya priya <skakit@codeaurora.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> Changes in V2:
>  - Moved this patch before conversion patches.
> 
>  Documentation/devicetree/bindings/mfd/qcom-pm8xxx.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
