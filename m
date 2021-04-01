Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84AC35126D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbhDAJhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbhDAJgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:36:51 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F499C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:36:51 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e18so1127630wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BGMa2gbqogbTba4AsXedNoo7A0vaWKxlg6Zr9So19iU=;
        b=PXLoncE+D4wZXMYMRa28lu6fr5HlwCebUsGcNrwGgiPrddc3ANQVg/XSaq2Xp4XYMv
         2oZZKpdSWgjOqWmfqDCMwKFvPyVPYAklWfDutTCV7MpuiH/7TNAWYcR6LVUiT1bg9Anp
         z4rChQ+zA4zNKG+gLAIjtiSAofipjZPs/Vcr1SDWOlkwgglveAlLCtaT+Y73wnLOg0PD
         bseFM4B3+L8BWgVlOmQQbBdbMFVWt2a1q6PvZudE6/kXGgoA7Ksz4iOR/G+Fks8+LMBA
         bGbbJImVgfUklbjr+Y6Puxuj8HNBpWOv/AA1/H4zWa+G1u8R5WYn3c0YISbdXKkXtXtR
         ffsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BGMa2gbqogbTba4AsXedNoo7A0vaWKxlg6Zr9So19iU=;
        b=n/c48sbPg9WaWQsuzNISYCBv0wmq/O7F0cq5oihURNYAbWT7J+maYQkJbXsNBTBQzc
         8BW6TpsRw3lysWUqBj1nbFm4YX6No+Hers1lbF7OI6eNNMJJowj5ihEqRrndQgjN6Hs8
         h4OWSuTPEx6CnGmBPzhjXEA6CO2COgnjMT7QFK6BSH2ZBHE4ViUHcw+B/hHutvu06otS
         SfgH9d2Vl1HAd5RHPPoVGMAhMR9Nw1nK8THUrS08SWJ4+wKQsntOqP3PyhBIrKe+861c
         8K78nAI7igN35jM2QdnWMxeooPwT9ESzHnQpPitSZalSN/zSkhNznVjKx/GMcEzaRnBr
         xaxQ==
X-Gm-Message-State: AOAM532wFgz6vi9jYLD8sL0iPanKKCtA9ItguNA93/JPRyDeRXriV2k4
        7HEzA3nYKZh7AAbl1Doj/dDtOjCNlgyAdQ==
X-Google-Smtp-Source: ABdhPJwIkZmH3EUPGnZx4mX8XedNJ8j2SKpSXNkHezJYHbygkyNzoHgvzqSp4B1St8ISWd/sS9rydQ==
X-Received: by 2002:adf:f083:: with SMTP id n3mr8367727wro.134.1617269810135;
        Thu, 01 Apr 2021 02:36:50 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:1573:1dd5:899d:6362? ([2a01:e34:ed2f:f020:1573:1dd5:899d:6362])
        by smtp.googlemail.com with ESMTPSA id n1sm11434746wro.36.2021.04.01.02.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 02:36:49 -0700 (PDT)
Subject: Re: [PATCH] clocksource/arm_arch_timer: add __ro_after_init and
 __init
To:     Marc Zyngier <maz@kernel.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210330140444.4fb2a7cb@xhacker.debian>
 <87zgyipfsl.wl-maz@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d0188aa6-5682-6b0d-0221-f96f4ef77505@linaro.org>
Date:   Thu, 1 Apr 2021 11:36:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87zgyipfsl.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2021 10:31, Marc Zyngier wrote:
> On Tue, 30 Mar 2021 07:04:44 +0100,
> Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>>
>> Some functions are not needed after booting, so mark them as __init
>> to move them to the .init section.
>>
>> Some global variables are never modified after init, so can be
>> __ro_after_init.
>>
>> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> 
> Acked-by: Marc Zyngier <maz@kernel.org>
> 
> 	M.

Thanks Marc


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
