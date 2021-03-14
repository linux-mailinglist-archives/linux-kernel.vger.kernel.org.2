Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F01033A500
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 14:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbhCNNW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 09:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbhCNNVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 09:21:52 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B418C061763
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 06:21:50 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 124-20020a1c00820000b029010b871409cfso18613396wma.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 06:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ucTfiKz63mieQ2tKfaqkdxMrnodecmrh893BEUs65ok=;
        b=hv1GfEBb+CHLRssqjP3rFGdeIms/TE2Ynr+K1Sneoeb44ZYw+jz+IMIl/bSC1scy4O
         K0SG8Ezq8WxmzfbQ71yC6Li6x9URxPmTtRbj/FgC0s4U+uIrF7FaHJ+Pq6O/mWmNiuaT
         kLXLgZ371lSVjSLk+TjJzwpFbVxBtom4GuGFbTCw8pa92kAGLrSCTZ4BGN2XWOy4yw8/
         3F94HMyA9HCV5LTMIRd/7xnPtZYg/+hSgY2DYreEkZdml8UH6gAalUFghv66Md+XpoO6
         M1noKS4/tyNFDvtUqnYb8avVENW9fTtwEBvQ0SuVpz45GOM7uYec+QRTQmAyeGj8rxFl
         UgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ucTfiKz63mieQ2tKfaqkdxMrnodecmrh893BEUs65ok=;
        b=c5gcmIch58ihbLQGbouWAvgXuj6A43aW5XbARJqgh/qCXodWSQgwGMoHf5sEv7NMkv
         4zPkc+gyWbOvHA8XILiAvR1d/zXJy21xSMvvfQdHYorJYztwgSYdqrbi6n6r+11HLrfU
         mWx0fqXrmD86EKrtEEshdqLk2Zx1LCzqo+XdjWNIjgzPtWL87XyycXD9B6FuhunBFJyK
         1kF7y9HtlKP016UI3xauo2wQ8WgjJF84UocpiHRq7+QJYQPx7gYqEEhip2sMyxLt8pA5
         IpIgl/IfkC5ObVC3Qm6SEtEnOxGstTgjaBN9foxcQfHxr0aQSr/kvGpVjyA/jd5swjJI
         +D1Q==
X-Gm-Message-State: AOAM531YWmS2iF40g9YWQa5bMFVPRSrL1t8Q/KZ+AtCvyOCNrEscm2vQ
        javZBjEcfAfHiW328OdM5hKWmQ==
X-Google-Smtp-Source: ABdhPJxLSXm8H6VsJLH45IRO7grdpD6tgv3nt6DMUuK88i8e8EngFuX8RylBZVgi/ib9h5nPUGF9mQ==
X-Received: by 2002:a1c:1dd4:: with SMTP id d203mr21453627wmd.83.1615728109313;
        Sun, 14 Mar 2021 06:21:49 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:1ed:80a3:b8d6:f6d3? ([2a01:e34:ed2f:f020:1ed:80a3:b8d6:f6d3])
        by smtp.googlemail.com with ESMTPSA id f7sm9260216wmq.11.2021.03.14.06.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Mar 2021 06:21:48 -0700 (PDT)
Subject: Re: [PATCH v3 1/5] thermal/drivers/core: Use a char pointer for the
 cooling device name
To:     Ido Schimmel <idosch@idosch.org>
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, lukasz.luba@arm.com,
        Jiri Pirko <jiri@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        "open list:MELLANOX ETHERNET SWITCH DRIVERS" <netdev@vger.kernel.org>
References: <20210314111333.16551-1-daniel.lezcano@linaro.org>
 <YE4FyiFgwM8cf5xe@shredder.lan>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ba701ded-39e8-9e36-e828-a0ad14ba6caa@linaro.org>
Date:   Sun, 14 Mar 2021 14:21:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YE4FyiFgwM8cf5xe@shredder.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2021 13:47, Ido Schimmel wrote:
> On Sun, Mar 14, 2021 at 12:13:29PM +0100, Daniel Lezcano wrote:
>> We want to have any kind of name for the cooling devices as we do no
>> longer want to rely on auto-numbering. Let's replace the cooling
>> device's fixed array by a char pointer to be allocated dynamically
>> when registering the cooling device, so we don't limit the length of
>> the name.
>>
>> Rework the error path at the same time as we have to rollback the
>> allocations in case of error.
>>
>> Tested with a dummy device having the name:
>>  "Llanfairpwllgwyngyllgogerychwyrndrobwllllantysiliogogogoch"
>>
>> A village on the island of Anglesey (Wales), known to have the longest
>> name in Europe.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> 
> Tested-by: Ido Schimmel <idosch@nvidia.com>

Thanks !


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
