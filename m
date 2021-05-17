Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A3D382824
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbhEQJVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbhEQJVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:21:09 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBD6C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:19:53 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so4733576wmk.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JveUaCD+efnuYINYNZzFU57ymSEM8lkwbJtftOrzs38=;
        b=c1NRkpfNoTQ2ubo97dlVoGvHr381ZWyGte2Rdo7kYBJXKHi1qXl8GLI0RJW6Xqycg+
         LXXuVHNZhSlP1ohtYLMPQNNk20QykYx6fBlsi/7P2Lj8/AtdOCB0KXvFKFfP5EZdWQn/
         DZWkRt39Rf8BDNsGzcWyY5v21ydI3o85TWmM/EfvXNkYjrqAoNQbtaoMIUuiDl3wZ/Gs
         7VagiNIfLPYHtqLwTl2nuVazS6ADNhyqiuPdkZlvmY3zCwzNa+DNgvm8Ced6Ryxpm8FP
         NiBAxvud7XVmE6PgzWnU4+HF8EY5PBw4nfq/qbItMizDBSKqqDON99cyKUDMButOnUIF
         Q2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JveUaCD+efnuYINYNZzFU57ymSEM8lkwbJtftOrzs38=;
        b=Jl7O7mqDTV5F4zKedoOQQIl4914IIl7aN+VgafN2O13aOoDJf4/dAMh8X3ADIaXmzi
         /wOGZPDvFRtA6UoH9vchyX2OD2tYljwVonWC9OCimdQu9tsTjn+dZM8H6a+SZQ3mVHcG
         ppIqU6jG5XKxrAJR/G9LA0Rm7nZd/z7juQ+PXqtfYiF6f7DdlWWLrdIR1bo7OT8ZWdvD
         9rTrPymAM2baJxU6rt3fKrSw55Ox3WIC6itPnuVINEGBLqgwxJOreBDgP/5JDOQ+9NLo
         ylkjsYv6Wghs1XUAnech8rUd34lxV74+xivY5+/W6t/SgZh4f0HLVLTlHwWrVDCTEE/C
         JiIA==
X-Gm-Message-State: AOAM531tYe1JthtYpB/Ljw7ij2JEetLFqxeSeC5t2r/M/WsMgnErsEgT
        z0rdDmzCLp+OeUlZNW14gamf1SDV/3qDM3fH
X-Google-Smtp-Source: ABdhPJwYU2WBpg/VKPW/++1vBdLdiZTNkEBUrylnRAT2gKVoK/eLE2rbSBU9cW29Ua9JhAbKAxpafQ==
X-Received: by 2002:a05:600c:4e8e:: with SMTP id f14mr20014410wmq.65.1621243192202;
        Mon, 17 May 2021 02:19:52 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id y2sm6887998wrl.92.2021.05.17.02.19.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 May 2021 02:19:51 -0700 (PDT)
Subject: Re: [PATCH -next] nvmem: sc27xx: Add missing MODULE_DEVICE_TABLE
To:     Zou Wei <zou_wei@huawei.com>, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <1620790594-15772-1-git-send-email-zou_wei@huawei.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <67ff40ce-b031-5ab4-9ea5-bcc4cec1427d@linaro.org>
Date:   Mon, 17 May 2021 10:19:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1620790594-15772-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/05/2021 04:36, Zou Wei wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Applied thanks,

--srini

> ---
>   drivers/nvmem/sc27xx-efuse.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvmem/sc27xx-efuse.c b/drivers/nvmem/sc27xx-efuse.c
> index c825fc9..7f9bd21 100644
> --- a/drivers/nvmem/sc27xx-efuse.c
> +++ b/drivers/nvmem/sc27xx-efuse.c
> @@ -262,6 +262,7 @@ static const struct of_device_id sc27xx_efuse_of_match[] = {
>   	{ .compatible = "sprd,sc2730-efuse", .data = &sc2730_edata},
>   	{ }
>   };
> +MODULE_DEVICE_TABLE(of, sc27xx_efuse_of_match);
>   
>   static struct platform_driver sc27xx_efuse_driver = {
>   	.probe = sc27xx_efuse_probe,
> 
