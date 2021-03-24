Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9513474BB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 10:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbhCXJdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 05:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbhCXJdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 05:33:10 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4F9C0613DE
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 02:33:09 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id p19so12499554wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 02:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DW7EouFyCURbwP8jZhQOeWE4+yb9VH28DAGEEY1uTLA=;
        b=lhn/sZFHW1OaA3bqg8UVcZ/oMlJ+b8RpnbPoZspt1bkNo1nCSELiJQR3O7k95jUnSI
         MjaoXMrXtaey+USMhrCC8a0RE2d8YvdZ+BJTCk7zlbGTBW74zXEPKj28zgcXMhTZ3o1F
         8o3OEKNnyQbOzImZMvFm7DioR1yiHpL+6jZ8GKX9lw2xsKYDTOo5Db70RqNWv7M0FX7R
         DNHTX5jPHtmh2MuwnmRmTkOM24VyeVvLYuFA4/tMCoB6/0Yr4iw3cJUv1wnawSK3RRD2
         5j+15et5Wzqw8FKiuSA32ANxHacxCjgFHtt1TMpFTvaEqnbuMM2BIWTfRHN585bvfXw4
         2GWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DW7EouFyCURbwP8jZhQOeWE4+yb9VH28DAGEEY1uTLA=;
        b=A/2rlHw25HA4w2AUDxlKqbh1vXjllCOKqIvAhRmDQmobcsLtPIfN8hqVJWdb+0aPnZ
         9PjSJO33rgszJXsNCkuFjmARlbVILBNFmmynsN1Gqvmh5kOa0F25V8Au8+3FNkRnaZ7f
         +CxqGPEuAdTmDm1bQh+1Tj4hByyWqE5BcISwWfxtBnZDOO+xzI4tGfmnJfwr+J3utGAL
         gFBGhNaW3S+KtWFb+HOj3rEw9z2rbxXuWbH6VhDurQ7oOtmx/h5CNoqDzrdJyv+e9UM1
         DDXqe3ptXJ/OSaWXRdlErzhiELl4yokEJZqP1b9USrOUplwPjkBE5LXMqwL5WXQZS72L
         d9gA==
X-Gm-Message-State: AOAM531YAy4GqS2farqkA2IICmZGp0cT2RfpwkrWNfSjzVNl2LMS7L7w
        fmwo4UNTnTYRf7rS2nZ9FTPf8/747PRU7g==
X-Google-Smtp-Source: ABdhPJxF3U4EiJ3OdXNHJk9Gnn8tzPqKMzJhY0aBsV3veUekqp0YrdrPt8sxtV0BPlDt/64JKfcT2Q==
X-Received: by 2002:a05:600c:1992:: with SMTP id t18mr1969565wmq.125.1616578388410;
        Wed, 24 Mar 2021 02:33:08 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:91e2:6a05:a4ac:7d0a? ([2a01:e34:ed2f:f020:91e2:6a05:a4ac:7d0a])
        by smtp.googlemail.com with ESMTPSA id n4sm1595499wmq.40.2021.03.24.02.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 02:33:07 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] arm64: sunxi: Enable the sun4i timer
To:     Samuel Holland <samuel@sholland.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210322044707.19479-1-samuel@sholland.org>
 <7bb14a82-5dc9-cefe-4b58-1d2c83974965@linaro.org>
 <64f6d712-11fe-4626-aa24-8e31c21a8ad4@sholland.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0b3689ad-6bb3-bd7a-46be-0c4d3d7de268@linaro.org>
Date:   Wed, 24 Mar 2021 10:33:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <64f6d712-11fe-4626-aa24-8e31c21a8ad4@sholland.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2021 04:51, Samuel Holland wrote:
> On 3/22/21 9:18 AM, Daniel Lezcano wrote:
>> On 22/03/2021 05:47, Samuel Holland wrote:
>>> In preparation for adding CPU idle states, hook up the sun4i timer.
>>> Having a non-c3stop clockevent source available is necessary for all
>>> CPUs to simultaneously enter a local-timer-stop idle state.
>>
>> Why simultaneously ?
> Because the CPU providing (the hrtimer providing) the broadcast timer
> cannot enter an idle state which would stop that timer. So in my case,
> with 4 CPUs, I was seeing at most 3 CPUs enter idle at any given time.
> This prevented any cluster-level idle states from doing anything. After
> applying this series, I was able to observe the whole cluster powering
> down when appropriate.

Ah, ok. I did not realize this fourth CPU was acting as the broadcast
timer, so allowing at least a CPU power down. This setup is unusual.

The changes make sense.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
