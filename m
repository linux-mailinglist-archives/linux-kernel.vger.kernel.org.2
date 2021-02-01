Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929BB30AC0C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 16:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbhBAPxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 10:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbhBAPwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:52:00 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0187DC06178C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 07:51:21 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q7so17081740wre.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 07:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hW4zbPjEI4/zS1ugenZya9710di15wb/LEVwBwRfkQE=;
        b=RZt6EQ19yq1+Zt438AyIJcgifQcWsqhHemxUK6rZJzEc2rnxcRXyhhFxTcUm0hK02v
         BRhnHSTUpYhWaOO59zKmUJkdLPyn/tJ/Rj1u3CCMe+jxbpzcXxiKZamu0QoUaSF1FTJM
         uAaVWKeWyJLqABxx5P5Cy1QjccDfKUSK4QXrwyrkoXfGUiwWmItHq20LuLKpFwZM6rRd
         kDE6fko0ltQ/mIPLlDMH1TjI8BenP5ujutcL4Vpo14KIkclYjyKpj9OrwoLB7Ewf//3t
         S0TIsL9htfmEeHvcnnWUUPX6vF7ACJNw557YdCOsv3dYya+/AYzA3tcpmHdGR0G57g4u
         RVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hW4zbPjEI4/zS1ugenZya9710di15wb/LEVwBwRfkQE=;
        b=sxHGIkFOw/JaA1XJ/KfJraaqeNyN0rC+TUtBYFXEE+UhmPX6UFSabTDW96rmKTf0zF
         l7/rh5WoqnNmTjNjqA3O8iNNqpnQwpQB4x262ogUehnvz6EgiOfpJik3VH696U0AW+E+
         9PBcrzvO65I3bvwU8lkTp8/sh0X+5PiCzeT3mWkt93M0wWGUhkDXC+z36v1dYWN2F+qa
         /uES1krzI46Kjr49p1i+Q1l+LpZoqs+9GWkOxhs/ZsNlHhKHqYSGrRXt23NseN1c61RI
         /HLEgcVD+2O7IBIMFAAG3scof/WgnxTheOOBOX+I5+ha8yIOLULMmwQBROJXwIfQteUJ
         Tpsw==
X-Gm-Message-State: AOAM530lopt+bzLus/fVP0A+NcRMuoTfwo1CXpB/e8qt71cYAOuColQT
        wOB+cJy+Oxwku8d136/1czxZFQ==
X-Google-Smtp-Source: ABdhPJz5Pc3Ab1nDFM5/3jz4Ydwz7X4TkyNPu0nzMu54J/QBEjD/IIewPGdNk1u3t0eUkdzyYJYK2Q==
X-Received: by 2002:adf:df12:: with SMTP id y18mr19036592wrl.141.1612194679756;
        Mon, 01 Feb 2021 07:51:19 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id m18sm26854336wrx.17.2021.02.01.07.51.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 07:51:19 -0800 (PST)
Subject: Re: [PATCH 6/6] soundwire: qcom: add support to new interrupts
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com
References: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
 <20210129173248.5941-7-srinivas.kandagatla@linaro.org>
 <95d3b143-6ba7-e6eb-4f44-9a8bb05b7fb7@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <9707a9b9-1e10-e7bf-aea3-4da164c31ee1@linaro.org>
Date:   Mon, 1 Feb 2021 15:51:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <95d3b143-6ba7-e6eb-4f44-9a8bb05b7fb7@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/01/2021 19:38, Pierre-Louis Bossart wrote:
> 
> 
> On 1/29/21 11:32 AM, Srinivas Kandagatla wrote:
>> Add support to new interrupts and update irq routine in a way
>> to deal with multiple pending interrupts with in a single interrupt!
> 
> I can't parse the wording after 'update irq routine'.
> 

So, basically if we get an interrupt while processing previous one there 
is a chance that we might miss the new interrupt!

This was a bug with existing code, which only showed up with recent 
Headset Button Tests!

> 
>> +    swrm->reg_write(swrm, SWRM_INTERRUPT_CLEAR, intr_sts);
>> +    swrm->reg_write(swrm, SWRM_INTERRUPT_CLEAR, 0x0);
> 
> what does this second write 0x0 do? Usually interrupts are W1C, and you 
> didn't have this before.

Digging it bit more seems to be an HW work around for one of the issues, 
recommended by HW team. Will remove it from this patch and add it as 
separate one with more details!


--srini


> 
