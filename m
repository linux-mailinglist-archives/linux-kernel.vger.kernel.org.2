Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B4D3421BB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 17:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhCSQVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 12:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbhCSQVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 12:21:44 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646B0C061760
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 09:21:44 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x13so9695711wrs.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 09:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q+7JtPWrzoVq9IfYXX5dUkVFHCMG2f/RW7isFZzxLUA=;
        b=kCDrU+/pozRLTw7JfiUzllg727f/Dvdtxcp8fBXJF3uJb/k0xBeZnoAfeakD1/zqha
         ki8k8iPrQ0TsHckjaXnoHA7IEaELvBJqrGMFvvz/bRO911SmVjhw70Zmdp3QJAmYgls9
         9wCw6Ysb0dcSXlUD0e9FC2LQXRROzc3lHgbjnDvnKBMeC/9IzVNglJaL0nEpQGQyytbC
         OTkqJni8+tuM+i/0xr9j1Dgl594p8Qqofbhe5eKjUHEJKpnvkRpfJUMAtrzxRxKSQMRj
         TBcb23H5QehIEdQ/d/ppbt/PZ7ncFbEAMj4JTAnpntFzj9nJC4j2MJwplqRdfx9JwWgQ
         5r6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q+7JtPWrzoVq9IfYXX5dUkVFHCMG2f/RW7isFZzxLUA=;
        b=ttpSjch8pk1LLi1lsjR9rXVVq8ibAhqF+gkO+Iq0Kz2JQkZsRiXXX8kJU9mWfa/Kh2
         pgvyXqAgbEN/fGLbJ2vip2TKnOu0Zt98BQRR6kXWL6QuAnw6R03GvCxx7IW+uZGDHIc7
         HiUdNXi2T7MwVw802v4CSnzzYAuPZBXIR3FbsgMu4fCv/lnS39SC+NA53JZBJWSRItqi
         4/YzrdCwH9ErZ0A2D21UQy0BLxPoFCUugMJSRkdS8XuiWcHPL1fJQ5gi8VXvEydJXEWG
         ccwm3ku//pHV8D8ltGSrN1RK10W9bknGr64LZlp6uUaVFEW2CrQNjgFuBDPdneUsqeuc
         SWTw==
X-Gm-Message-State: AOAM532iZhbDU6/P02WlEtNEQKiuOi3p3v2BfGIj9J2ezGm/ZY9MXrc6
        4VlodXpYp0OimZVTE6HELlsBJSEeLIKv6Q==
X-Google-Smtp-Source: ABdhPJzwBl5xKMtGiYizYyniDg1e76b+/vRNVyIXX1Ak+IcQQbjKxiJPZGQ3JYHmvmwRqiBJGUrS8g==
X-Received: by 2002:adf:e5c8:: with SMTP id a8mr5497712wrn.352.1616170903054;
        Fri, 19 Mar 2021 09:21:43 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:ddd7:1eb:a66:7a85? ([2a01:e34:ed2f:f020:ddd7:1eb:a66:7a85])
        by smtp.googlemail.com with ESMTPSA id w11sm8812705wrv.88.2021.03.19.09.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 09:21:42 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Add co-maintainer for Qualcomm tsens thermal
 drivers
To:     Thara Gopinath <thara.gopinath@linaro.org>, amitk@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210319153711.2836652-1-thara.gopinath@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0688c116-bcde-7980-6535-80000fac5afb@linaro.org>
Date:   Fri, 19 Mar 2021 17:21:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210319153711.2836652-1-thara.gopinath@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2021 16:37, Thara Gopinath wrote:
> Add myself as the maintainer for Qualcomm tsens drivers so that I
> can help Daniel by taking care of/reviewing changes to these drivers.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
