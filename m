Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C167A3BAC1E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 10:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhGDI2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 04:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhGDI2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 04:28:22 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A72C061765
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 01:25:46 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id k8so20127724lja.4
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 01:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mem7aDqrdPAoK1Q+h1MiWVWd2rSQrghSbzr5cmPA4tE=;
        b=T+e0XbVmuv9/j9Fjh+jIKG/WvWOhzEaVLBBiasfflltjEXdbclLUxmZe0Jykii0Awe
         jTOWnYhIY4OJT+q2po++qNMQ+corj1KESALoloz2MDyWCViHpttTamqGUb7NPbH+pQdC
         gWOFgtEoHCbknVjR8jx4bW0iUdhm8pGliOJlIJi/aZSh/cHNwvHAh3Rp3pea+MLo3ecN
         WLX2XuB1g2ZkRX2lCtH3cuyZ6tkNfkSKS2IW8tdVKmHkID57ixsBhnh1XTvZ2j+vehfj
         eXQiooSLrsJmBHy2vR9GbHy2PQhIlK5hoE+WdFPC46uJEbgYHz4AESQgaBC1gMsgtguM
         hW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mem7aDqrdPAoK1Q+h1MiWVWd2rSQrghSbzr5cmPA4tE=;
        b=NApdyNgQ52xXy0Ce6n12xg7KZnnyKAMY0WX8FQn+LT4tEeViKcV/qNhIvb5vZLPgz+
         m58IBFHeTzUCxuoM/nJhra/jbFPLLacW2hYmQlrS45FVcgkn9h+yB4ZEeP4q003G22Gj
         FlE2ZNTvo4SzujVtT5nq7mL6T4wIEAYNOS70i7T7ONhnst3K1IZ7FFIyBK8VVXetJPhM
         aZBIn/SpQa8Lbbt6iMvXx3sbwkzEWtECl/rUDK+HDEs9xpc0+lQOPf+rCSVemyEQ2/Ir
         1mXzL8mnH2ChTD7oC9glpD/vzVJ7VjPuyXxt66XB0IKrsDsTFbyo/G3oi4sw+ONjlac+
         jK8g==
X-Gm-Message-State: AOAM531mszbkDCkANxa6yrayAHeENkKq5ktQEEBNGkh9ZJr/tyzC2N9z
        rVnx1Lda5v2HQKlRgs85BFZkwQ==
X-Google-Smtp-Source: ABdhPJy4nvOjyXAyQrOq0glZ90aFFBPgm0fiFPwTmBp3srbuOj7LS6n5pX1iTaiwSpzDGPyAnNIQZg==
X-Received: by 2002:a2e:9e18:: with SMTP id e24mr6692205ljk.336.1625387145132;
        Sun, 04 Jul 2021 01:25:45 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id f8sm737547lfu.188.2021.07.04.01.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 01:25:44 -0700 (PDT)
Subject: Re: [RFC] Inline rotation support in dpu driver
To:     Kalyan Thota <kalyan_t@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, mkrishn@codeaurora.org
References: <1625311962-14185-1-git-send-email-kalyan_t@codeaurora.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <5dcd850a-280c-c356-32e5-35a4fe089f4e@linaro.org>
Date:   Sun, 4 Jul 2021 11:25:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1625311962-14185-1-git-send-email-kalyan_t@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2021 14:32, Kalyan Thota wrote:
> This change adds support for inline rotation in the dpu driver.
> When inline rotation is enabled the VIG pipes will directly fetch the image
> from memory in a rotated fashion
> 
> Inline rotation has following restrictions
> 1) Supported only with compressed formats

NV12, which is the only format you declare, is not compressed.

> 2) max pre rotated height is 1088
> 3) restrictions with downscaling ratio
> 
> Queries:
> 
> 1) Since inline rotation works for fewer pixel formats with specific modifier, how can we provide this information to the compositor so that
> chrome compositor can choose between overlaying or falling back to GPU. In the patch it fails in the atomic check.
> 
> 2) If a display composition fails in atomic check due to any of the restrictions in overlays
> can chrome compositor switch it back to the GPU and re trigger the commit ?
> 
> posting it as RFC as validation is not complete, please share early comments on this.
> 
> Kalyan Thota (1):
>    drm/msm/disp/dpu1: add support for inline rotation in dpu driver
> 
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 47 +++++++++----
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 20 ++++++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c      | 93 ++++++++++++++++++++------
>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h      |  2 +
>   4 files changed, 128 insertions(+), 34 deletions(-)
> 


-- 
With best wishes
Dmitry
