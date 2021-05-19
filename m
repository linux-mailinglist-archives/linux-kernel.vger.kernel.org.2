Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A28388D63
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 14:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353045AbhESMCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 08:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353047AbhESMCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 08:02:43 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4F5C061761
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 05:01:22 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d11so13722238wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 05:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DTl0F3yp42r8Hj6JjZeWk7rdRBuq5rsdsLvB4gVnalA=;
        b=PNDLiEP3mR0Zdz9Tvm97CMbIjSWSVT2j2gI+KaqNxAfI9OVufIdc69haoYSTswemXG
         IwfZSqiL1ytBvX548Td3QL1KkFx/rPVXVS3gNKRPjDqPAB8tPMHePzGASZAzKVlLSo9N
         FnKI0qr3y2EUYg46bQNzWVK8tm+XUCfVafq6XHHM9ULoxqb2ABLj0pnlyLdIkzmtMQK0
         nA4N7/RzWdFuN7+iX6FXUD8QTbwFFnLSDiKo/o5vnDyWpC09Lv3vl56T8YPcM8rfOaRC
         y0MqFjYqCMn7gumguRN5t6OWvfY2SbJI83MsS+h5DRjyEjxgAqNCA9KNguIyqZgu96Os
         4ALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DTl0F3yp42r8Hj6JjZeWk7rdRBuq5rsdsLvB4gVnalA=;
        b=Fj9bPYjvTuIssz3PBkZZCKHOUc/N/UPgHsVuuSyIIBH6ORKFS5lEXQbfrf71Xhtkqy
         KlKIYrCKLbyDJBXHBhagGiKo0imEHY+Hcnv9WhD4WWcEEWzti2LEYYsoRp0C1ZyxxrKv
         Oib/gv/GlqROni0avs9SwqiNbjf1EEyhP7ZvdaxARKZDD3UnZLo4BaMYS5QMfwQHcvM9
         +4/GASffK1WR55mp/2obJ1BYAZcc7QwBK2YrsDnkpFoPzJw/uSZ3WU0d++c4gqMR0WF5
         Nm8nf/6ReNN6te1nald11+3W8VW9f1mG/V9G2Ou4Ns150l0jjZtDeRFC7N0NdTdkTqtb
         YfCg==
X-Gm-Message-State: AOAM531BkOcVctBkCAxBogWcc8yO12fh+NA8kVvw9Ta+zjSrghzljb5i
        UlnBKM08c26T7xB8WieZ8Imkyw==
X-Google-Smtp-Source: ABdhPJw3phIJj3ZJW7j3BDfv0U37nRSkdLSUimbXSjhW9l+GHM3Xs/G57Z9R43uvGvB0XxQ0EEKZzA==
X-Received: by 2002:adf:d20a:: with SMTP id j10mr7729779wrh.188.1621425680724;
        Wed, 19 May 2021 05:01:20 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id y14sm25819485wrr.82.2021.05.19.05.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 05:01:20 -0700 (PDT)
Date:   Wed, 19 May 2021 13:01:18 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 2/2] mfd: wcd934x: add additional interrupts required for
 MBHC support
Message-ID: <20210519120118.GG2403908@dell>
References: <20210510091239.2442-1-srinivas.kandagatla@linaro.org>
 <20210510091239.2442-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210510091239.2442-3-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2021, Srinivas Kandagatla wrote:

> WCD934x supports Multi Button Headset control which enable headset detection
> along with headset button detection.
> 
> This patch adds interrupts required for MBHC functionality.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/mfd/wcd934x.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
