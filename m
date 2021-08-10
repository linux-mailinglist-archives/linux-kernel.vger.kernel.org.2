Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7E03D8B25
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 11:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbhG1Jwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 05:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235520AbhG1Jwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 05:52:42 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3716AC061760
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 02:52:41 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r2so1776853wrl.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 02:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5hDeXwpJyKURq50wfzauS4hu5pTy3wZxNYdg9RntuFc=;
        b=VjifoDFAfPiRzuJdVeW7lO2ILMptRQxqU5m0WRREkIhn3MY8wANO1uZLNA0z6x8ClO
         elUsWBHOsKOUuPfvHXSGCjDFwpZA/96G6rCGBnlpiJ4eOzXVPbQnOlgp17geNeA3GSRV
         5qj1v81GI7Jd8aXTJbj0d4wZnT2//flnZqjTYDmGcf0aAt0+YXkS0PHoCH4Yh3GH1CGW
         0o1EufLrvD7U5Esk131zL2G8F7e586Mc+30oAExqhbSKci/0P0fKYV8MgKZH7i1gx+7Y
         j5LjSQYy/A6OF2iJprBVIBHcSWa3u4rU9IjDuZ9DlNsSSzyk+9mrSOxV8lEZtWyrsHcA
         W4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5hDeXwpJyKURq50wfzauS4hu5pTy3wZxNYdg9RntuFc=;
        b=JVgFr0720e6SBji5Ynq3B2XmTYKl2mmNCMsU5tx/k2lkxzEMxtRmHfPeoa5uPY+1ra
         PmdSN3cFUZtvuivP/hIE2aTTF3vY8+Qv4634QOAiYjmGqJ8yEoKbh/lysOMEC/WFKO/W
         9yc2h7slBhoLNFKVWZyGbAe+WhvWT1HIftL57rmNYGzIGrFaI3ZxbEAHhkc1rYrJz5h9
         LssJ//KseEP/2bd9mo1VFY3usyakbf2M56WJKRqi/Xkslvx1iyX+MacL7lNdQY+wb51l
         K29WJ8UXTFLXEro/XreA8a2dTpp2XL4JXGQJfkHjUkGaOM3AxME/OEM4KrDr+SBs6Pje
         g9xw==
X-Gm-Message-State: AOAM532Ys+SbD0OsDnnL9/sCaZb8gZfRbAqMzveheJktQBu6opHeDPXE
        Y5rA9MprJNBLFEO+fT8MBZptVVPGq2IW4g==
X-Google-Smtp-Source: ABdhPJxTZ8t9+Gkh3xWt85XdFCnerigKEY40F4bt9W6br6cNTg1uv6frN0H7UY8IlHorAQPizxBPHQ==
X-Received: by 2002:adf:d22f:: with SMTP id k15mr8657726wrh.335.1627465959835;
        Wed, 28 Jul 2021 02:52:39 -0700 (PDT)
Received: from [10.10.6.131] ([109.120.209.55])
        by smtp.googlemail.com with ESMTPSA id f26sm6274961wrd.41.2021.07.28.02.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 02:52:39 -0700 (PDT)
Subject: Re: [PATCH v3 0/7] media: venus: Enable venus support on sc7280
To:     Dikshita Agarwal <dikshita@codeaurora.org>,
        linux-media@vger.kernel.org, stanimir.varbanov@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org
References: <1626246068-21023-1-git-send-email-dikshita@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <2146cc2e-a975-7d6c-2f19-65d73d056189@linaro.org>
Date:   Wed, 28 Jul 2021 12:52:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1626246068-21023-1-git-send-email-dikshita@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dikshita,

Could you please rebase the patchset on top of current
linux_media/master branch and resend it as v4?

On 7/14/21 10:01 AM, Dikshita Agarwal wrote:
> This series enables support for 6xx venus encode/decode on sc7280.
> 
> The driver changes are dependent on [1]yaml and [2]dts patches.
> 
> [1] https://patchwork.kernel.org/project/linux-arm-msm/list/?series=484019
> [2] https://patchwork.kernel.org/project/linux-arm-msm/list/?series=484727
> 
> Changes since v2:
>  - no longer considering client buffer requirement to calculate
>    output buffer min count.
>  - addressed comments on v2 (stanimir).
> 
> Dikshita Agarwal (7):
>   venus: firmware: enable no tz fw loading for sc7280
>   media: venus: core: Add sc7280 DT compatible and resource data
>   media: venus: Add num_vpp_pipes to resource structure
>   media: venus: hfi: Skip AON register programming for V6 1pipe
>   venus: vdec: set work route to fw
>   media: venus: helpers: update NUM_MBS macro calculation
>   media: venus: Set buffer to FW based on FW min count requirement.
> 
>  drivers/media/platform/qcom/venus/core.c           | 54 ++++++++++++++++++++++
>  drivers/media/platform/qcom/venus/core.h           |  2 +
>  drivers/media/platform/qcom/venus/firmware.c       | 42 ++++++++++++-----
>  drivers/media/platform/qcom/venus/helpers.c        | 26 +++++++----
>  drivers/media/platform/qcom/venus/hfi_cmds.c       |  7 +++
>  drivers/media/platform/qcom/venus/hfi_helper.h     | 14 ++++++
>  drivers/media/platform/qcom/venus/hfi_msgs.c       |  7 +++
>  .../media/platform/qcom/venus/hfi_plat_bufs_v6.c   |  6 ++-
>  drivers/media/platform/qcom/venus/hfi_platform.c   | 13 ------
>  drivers/media/platform/qcom/venus/hfi_platform.h   |  2 -
>  .../media/platform/qcom/venus/hfi_platform_v6.c    |  6 ---
>  drivers/media/platform/qcom/venus/hfi_venus.c      |  4 ++
>  drivers/media/platform/qcom/venus/hfi_venus_io.h   |  2 +
>  drivers/media/platform/qcom/venus/vdec.c           | 42 ++++++++++++++---
>  14 files changed, 178 insertions(+), 49 deletions(-)
> 

-- 
regards,
Stan
