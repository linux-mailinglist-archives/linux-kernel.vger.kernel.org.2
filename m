Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65AAE3EC224
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 12:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238053AbhHNKxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 06:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237914AbhHNKxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 06:53:13 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FA6C061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 03:52:45 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b13so16742424wrs.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 03:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ba4SAb2aBf6MmpZz3Xp6tADaKj/2tCplahLWQ77YhH8=;
        b=Hdq5+2+wU2tURLfgliPF1+rONdMo1n5Cb2UlAEGOG5IiMxYGeNPgkNFt0i0fqymg1c
         2mlLpylFGQh5L6RJBee2fZKdlfJB2rQtlN4kVhVS+AP6ZJfl5BQEisy+PqRUlFMbs9lx
         7DQbsOVGWep+gfcR7IaA2/0Mwd0nOCfMlAIYeizVmDTPGiFGWXi+yYiph81rMxkLbItC
         M3j4yWjAhWtG+da7rZulxg69LaV1G5QJHzwES34812r+eoGHNF1nhUT8AGR7wHi0o2wr
         ea8RPTeb6c33IODTEl1BOM/XeZ1WAfKAbZWD34qmki99FDJ5a61SrWCeWAMo5qHoO0EH
         V9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ba4SAb2aBf6MmpZz3Xp6tADaKj/2tCplahLWQ77YhH8=;
        b=d1ODGf5l1HnhHSwUQdHxbw2NnsHnwJLuS+zWhPHNFnbyHVPCj/GPt2T+MnlPtVJ80S
         27s0MOy1hrRrKXB0kCtugUV0JymVja3P5fOgXqFcFz0qrdN90fr030iVynfT6L+pNebg
         iySkqNuyGqiKlGpR+sVHQ5Zewlol0SUa2TWBe5PwsH5lZgZ1Wd1dUOFBz6xdP3v789VT
         TLedxIdGHbrgQ1J7m8xOpQs37QG44xvRxoZ5oTJEJnKkcgQlp3FZN3UriTaTBMuxXZXl
         7gI2t3+EvCp/KC5rUcIdFmzfuqyq3Km5nn4M3p/CyTCDrf56QyXRDDZoYwsMCLr1tTPF
         d5NA==
X-Gm-Message-State: AOAM531L8eaoeCiHD2Q5P/Cq5MXFGxsqDIGG5MjH1V2T5p7Qadj5gUVs
        OmsXX5ptUskzagPjmrq4GnzuVA==
X-Google-Smtp-Source: ABdhPJwWNA17tyvLVZXpoO+MinyAHNFMLJO/QCMJeMsc+Bz46vBdUHzhRbGdNnDPD5/1C08z8MedMw==
X-Received: by 2002:a05:6000:114d:: with SMTP id d13mr7838630wrx.295.1628938363570;
        Sat, 14 Aug 2021 03:52:43 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5df3:d0eb:3945:640d? ([2a01:e34:ed2f:f020:5df3:d0eb:3945:640d])
        by smtp.googlemail.com with ESMTPSA id r10sm5228134wrq.32.2021.08.14.03.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Aug 2021 03:52:43 -0700 (PDT)
Subject: Re: [PATCH 19/38] thermal: Replace deprecated CPU-hotplug functions.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org
References: <20210803141621.780504-1-bigeasy@linutronix.de>
 <20210803141621.780504-20-bigeasy@linutronix.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3375c93a-a5ee-e2b6-2259-cfe23589bfb9@linaro.org>
Date:   Sat, 14 Aug 2021 12:52:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210803141621.780504-20-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2021 16:16, Sebastian Andrzej Siewior wrote:
> The functions get_online_cpus() and put_online_cpus() have been
> deprecated during the CPU hotplug rework. They map directly to
> cpus_read_lock() and cpus_read_unlock().
> 
> Replace deprecated CPU-hotplug functions with the official version.
> The behavior remains unchanged.
> 
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/thermal/intel/intel_powerclamp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied.

Thanks

  -- D.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
