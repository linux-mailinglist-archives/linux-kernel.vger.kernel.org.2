Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A06350520
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 18:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbhCaQwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 12:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbhCaQwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 12:52:11 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF044C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 09:52:10 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id c8so20348781wrq.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 09:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KW7KuRreeb79kGzMH/vng/RjmZZIp935J4i4tM6jC6g=;
        b=qnEUvEjj/xzG8LrnVtSeDVPIyff/heHBpXfIkbkH/Wf/QRY9vZDobrQMVTMn3Suj9A
         7mhQtaRY8Xe+yVBM5I8ndcXNbzXWMUTz4TreYTYeGaI8UTiMtD/+JFkNYn61ZHVqh9xo
         gssil2FijNu3h/w43eQIznzwojZ5y7RpmYZ8W3pO+gie+F6QAEitTpUuR1IJzm6wnZM3
         b5cKmwG5TWezMtr+B1GIBQ3Zo/JHK0R7Dc3mngUzjPX0Us+95Vr8MIiav+Q279merITh
         DdmskatNl3UogH+0LAyYI1Yrjo51MlJXWEZgdQVEaQYPjrcTfyPTPXkWUwBUXnPy99ny
         PUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KW7KuRreeb79kGzMH/vng/RjmZZIp935J4i4tM6jC6g=;
        b=RvBzbHMaLhb/XCN9fqgD6xLB77cCKqVks3E8sahRkAJh1i++Tb6Tg1v6vL2SdzmzMz
         kSukvJR+5Qykaxhp90MOywh7OaZbqeQNDtS1GXkpbRTex9eQIMMOVt3kQYXRunUs/4zl
         HP+QKjWZd+wtmGtfN0hDeYrtDo4sdQDClgKWgFPLwyU7lHtQFVVY11KL/Us+m9+J36q1
         J8Bl/UxDSX1tEsTO7Ul6Rk95m/1h2fAXmrtbEvjBvAPGpI/kUW2e95T5uX7DJb41mCoq
         qgax/hpq6RnKHVN0N49NGofNy0YsiUXtvrQV6qwRjdOIm1BZBuJVoTGCb6w4EU++jugY
         pE3A==
X-Gm-Message-State: AOAM533p8bCmbQv4Ers+8uOv1LmEKTRU0NX4S0TAyGrlP9RfYAigMiz6
        qA8Y+pznjatkjwLM2BG7VrLaRg==
X-Google-Smtp-Source: ABdhPJybpgeOKHptSYn9F2ESwHc1TgEAW+9Xq8rONln/zJYDOUEWbiNr6PP9E51rmgYdxVMr2HRyqw==
X-Received: by 2002:adf:dd0a:: with SMTP id a10mr4892008wrm.145.1617209529503;
        Wed, 31 Mar 2021 09:52:09 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:1573:1dd5:899d:6362? ([2a01:e34:ed2f:f020:1573:1dd5:899d:6362])
        by smtp.googlemail.com with ESMTPSA id c8sm4681718wmb.34.2021.03.31.09.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 09:52:08 -0700 (PDT)
Subject: Re: [PATCH] thermal/drivers/hisi: Use the correct HiSilicon copyright
To:     Hao Fang <fanghao11@huawei.com>, edubezval@gmail.com,
        amitk@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, prime.zeng@hisilicon.com
References: <1617086733-2705-1-git-send-email-fanghao11@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <549a6349-c05c-9170-a288-59e3be8e5627@linaro.org>
Date:   Wed, 31 Mar 2021 18:52:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1617086733-2705-1-git-send-email-fanghao11@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2021 08:45, Hao Fang wrote:
> s/Hisilicon/HiSilicon/g.
> It should use capital S, according to
> https://www.hisilicon.com/en/terms-of-use.
> 
> Signed-off-by: Hao Fang <fanghao11@huawei.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
