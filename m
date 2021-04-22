Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1BB3685FC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 19:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbhDVRb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 13:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbhDVRbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 13:31:52 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2F1C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 10:31:17 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n10-20020a05600c4f8ab0290130f0d3cba3so4532310wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 10:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JjH0N4u84i2kUtGXb6DG44zI1EAiUl6sphKFWcq3aTA=;
        b=IrdybW9YAjNtB11yng83aD53tGpoovVbA0BZtCyeN9KIHMW0NXo9GF4XaVKMYAMblP
         UFj+A+yD5Sz8U7L+3LoxgDBVcM7cc7owGZjtrhbnw+nYkBInOzwOc0oo406/ScAlCMeU
         bw9BiCzVgN8EeekNXcFOgCHKs91llkrl3gx3ueq9PzdMqC6d6oMbgKpzkKjsyprQRSt/
         K8vvjSBNfkW2t+NsliAmZmAXlG4I3scSADmSo/YEqglJ6H4P+MKzmtB4oxzvYZp0alSS
         yheIKmNTBUVgRTtlXJWYQVYHW12Mthwn787wlWs2p0zBYbtp9Kq5vZv/ldDJO3G7Zt/S
         Cmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JjH0N4u84i2kUtGXb6DG44zI1EAiUl6sphKFWcq3aTA=;
        b=J2jjeMvt5kJvb9HmL3bAT/26YPjnr8SsXtbfYXqtxj0rcU3n8AKGAqa5yCQwe2gIx6
         3xzuCGAtdXTKABB7BOfaPW0JAJtGsd15d7UhfkiWViyoDsvXFcz0pE1s+AmaVF331ZFg
         56iU4+7oZE+vUX8DKVBnxQY3qRAvPDT/oZf/S5jHY8UDv4Xp6nR9sBZpV4o0nOMYAevB
         FMNTffupm2d4ke6OPlKI50P7TDFEyjAfEPqTcBtBUbegyVt9urPK53Dmh6OLFrTCwGu/
         bRc0pM0VmrVbtZnoq04t1AxgzqLwwdNf3irgORXn7a1UqkhgjbiDCP+Y+LKzoY0sWPin
         /8mA==
X-Gm-Message-State: AOAM532X9fVzKImQG3cd5tc4tshWTPIBfkTP4JfMODH2w5mYgWETumMU
        rnQlv3E8H8Ag/vFIN+FQWTK+rQ==
X-Google-Smtp-Source: ABdhPJy2/zFYniqBFxEe8gPpBhYqvD6bAfncAqs/NgONbw3MBuSXWbv7/IAqcAZOV35K7DNFVE2yDw==
X-Received: by 2002:a05:600c:4fce:: with SMTP id o14mr1135971wmq.121.1619112675963;
        Thu, 22 Apr 2021 10:31:15 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:2191:9b4c:c38f:a1a9? ([2a01:e34:ed2f:f020:2191:9b4c:c38f:a1a9])
        by smtp.googlemail.com with ESMTPSA id o1sm5066847wrw.95.2021.04.22.10.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 10:31:15 -0700 (PDT)
Subject: Re: [PATCH 0/3] Thermal governors improvements and a fix
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, amitk@kernel.org, rui.zhang@intel.com
References: <20210422153624.6074-1-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <25ceedef-f3eb-0187-7397-9d4ca30fcb93@linaro.org>
Date:   Thu, 22 Apr 2021 19:31:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210422153624.6074-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2021 17:36, Lukasz Luba wrote:
> Hi all,
> 
> The patch set introduces one fix (patch 1/3) and two improvements, which
> are possible thanks to the new helper function [1].
> The patch 1/3 with a fix for fair share thermal governor is also sent
> CC'ed stable, but it's hard to point a particular commit, which back
> then was for fair_share.c.
> 
> The patch set should apply on top of [1].
> 
> Regards,
> Lukasz
> 
> [1] https://lore.kernel.org/linux-pm/20210422114308.29684-2-lukasz.luba@arm.com/
> 
> Lukasz Luba (3):
>   thermal: fair share: lock thermal zone while looping over instances
>   thermal: fair share: use __thermal_cdev_update()
>   thermal: power allocator: use __thermal_cdev_update()
> 
>  drivers/thermal/gov_fair_share.c      | 11 +++++++----
>  drivers/thermal/gov_power_allocator.c |  3 +--
>  2 files changed, 8 insertions(+), 6 deletions(-)

Applied, thanks

Two users left of thermal_cdev_update ;)


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
