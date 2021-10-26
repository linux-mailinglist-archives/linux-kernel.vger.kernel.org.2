Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC5643AF4F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 11:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbhJZJqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 05:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbhJZJp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 05:45:57 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C942EC061767
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 02:43:33 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id o14so801121wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 02:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7+2p05oQNdqMryM7yzyh3ArfUcmQhIgi4MURcO9pkCY=;
        b=cDyNYeZD0eE5qHYvZkTQ1FXatVBjBGgpQIpjy7PEZAm0hESeXIqpNH8uwL9VcIckNc
         Nw/G5e6ojWYcO50wS6h8pgCUfx7wSZ0EPCZlDmyB/a21I/GkXdnPGnsVDGep0RrvUyuH
         6hMFo0ncAI4yrwUE5/iwx90ANgaHEIktHwrVvAcESHq0baLlBpeiz+qh6u4ZEHCX5Fw6
         QmKG7f1HZ5N1Fyc+7wnTnGn0u35xx4M0lSU3k6N4+hN6fRyvLeXuTFZTNq6ZVqtdagfX
         2+TusB4JMMzFoD1gR9mGmqopNn1oGgTnDUZFEeBdhUDiK0S3NdkqX8+irb0iapoK+FCc
         dfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7+2p05oQNdqMryM7yzyh3ArfUcmQhIgi4MURcO9pkCY=;
        b=0xgKI/sOzYgxbyNW6uT1S799RtABc9pywDhrnHWsFH6SryFizXsNeVj8dymDLarY0q
         9OGXmCaeV1UHuL60MHc/gTNxXfDAw7JVDOfgBKcFQGs11Ry8gZh8BxhDvhR/hXgUUyCS
         T1oVk/4D2UP/XI0IqkauPjgaY+kT5T0+SSfzXja8Gwv6/t3sXFsTl8bNjbgrTQJKW87E
         tDBruq8I1mPZqKfV3ApjdzaTPYC08izdq9SOx5NEOFWP9EW21JjE/TtIHjAI4Sv0k+vI
         Y6FJEBxHNAIOsj/Te5q4YjHeoV9Rzsn7vwHjVzIAEX3KfmIy49HeDGoABS8LIcVmRFXm
         PrUg==
X-Gm-Message-State: AOAM532vsXT1yxo2pnZQ29YS+BYCiovIx4/m6WbC3T0uQwPfZj3BC551
        2rWAZdTHQlYCZYKK4KCPcgftZQ==
X-Google-Smtp-Source: ABdhPJwTI1PlvkM8HM+MxNdDu5WtYnRZ3fTiNZGc2h2fTOV87fP5ubXKinoJ0p4Wa3WJUQJ/YORVow==
X-Received: by 2002:adf:ba87:: with SMTP id p7mr30227824wrg.282.1635241411868;
        Tue, 26 Oct 2021 02:43:31 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id i24sm89536wml.26.2021.10.26.02.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 02:43:31 -0700 (PDT)
Subject: Re: [PATCH v4 0/5] Update Lpass digital codec macro drivers
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org
References: <1635234188-7746-1-git-send-email-srivasam@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <c61e8a0b-27af-dab0-0a4d-2b8a95ed1ba2@linaro.org>
Date:   Tue, 26 Oct 2021 10:43:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1635234188-7746-1-git-send-email-srivasam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/10/2021 08:43, Srinivasa Rao Mandadapu wrote:
> This patch set is to add support for lpass sc7280 based targets.
> Upadate compatible name and change of bulk clock voting to optional
> clock voting in digital codecs va, rx, tx macro drivers.
> 
> Changes Since V3:
>      -- Removed fixes tag.
>      -- Change signedoff by sequence.
> Changes Since V2:
>      -- Add Tx macro deafults for lpass sc7280
> Changes Since V1:
>      -- Removed individual clock voting and used bulk clock optional.
>      -- Removed volatile changes and fixed default values.
>      -- Typo errors.
> Srinivasa Rao Mandadapu (5):
>    ASoC: qcom: Add compatible names in va,wsa,rx,tx codec drivers for
>      sc7280
>    ASoC: qcom: dt-bindings: Add compatible names for lpass sc7280 digital
>      codecs
>    ASoC: codecs: tx-macro: Enable tx top soundwire mic clock
>    ASoC: codecs: tx-macro: Update tx default values
>    ASoC: codecs: Change bulk clock voting to optional voting in digital
>      codecs

Tested on SM8250 MTP,

Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


--srini
> 
>   .../bindings/sound/qcom,lpass-rx-macro.yaml        |  4 +++-
>   .../bindings/sound/qcom,lpass-tx-macro.yaml        |  4 +++-
>   .../bindings/sound/qcom,lpass-va-macro.yaml        |  4 +++-
>   .../bindings/sound/qcom,lpass-wsa-macro.yaml       |  4 +++-
>   sound/soc/codecs/lpass-rx-macro.c                  |  3 ++-
>   sound/soc/codecs/lpass-tx-macro.c                  | 25 +++++++++++++++++++---
>   sound/soc/codecs/lpass-va-macro.c                  |  3 ++-
>   sound/soc/codecs/lpass-wsa-macro.c                 |  1 +
>   8 files changed, 39 insertions(+), 9 deletions(-)
> 
