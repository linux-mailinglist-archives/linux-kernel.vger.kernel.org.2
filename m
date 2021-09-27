Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F8F41A378
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 00:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238074AbhI0XAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 19:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237903AbhI0XAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 19:00:50 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D23C061604
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:59:11 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id a11so9805632ilk.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vwSbvNE8SFizMBN9MdufQScN0qnWB45/icxok2QC3vc=;
        b=NQKNt/hcDLBvDewYKq5qLZKO6H4ZeoPmqga71BE10kwp2KQIRs/KoUR0Mx+mNCaNHj
         yybVqUYLJmMt9XJ6cf+s+IUN6T5A2wKtPudUdTYF9k7bQ/7hAYoE/jIojApWzrV+WqlB
         LB3Js/R0zKFNSVSf1RLs5+ouZvJbqA/zTX7Lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vwSbvNE8SFizMBN9MdufQScN0qnWB45/icxok2QC3vc=;
        b=0e23D/7uS8PntTi+jjVWvBrgTAU0IwX3TMMr/y0Hyp7CQsjuIpjQCNInZ17nndGA+z
         h0A9LgfGt4u/aEvTopYCKQRFOztb8w2sHK3FSwmTauoAcTunJoxSly48lSrThvB9abQ6
         IAm4r2+0kN8zHDelS+j8yCT9GXLBCx1MCrGBCH7P7jTXeLGhplePBI3JilrZ5MjMZ4L7
         1MLumnRH9wVHdXRlwx7IK2ok7kt3iTqPV3epqxSQ9ng4ofGJZVfvDwEVTurQ9Gf8r9Hd
         zoX0wYNKjjTYXLe752J28hJSryEkt/UX0NhKbU0TiY8lGHqWrzlYVvLXBXje3+wRav4y
         0lsw==
X-Gm-Message-State: AOAM530t/3Gxw8RyJrgahnbcaBNzqMXx/FMvR6EWspqRbkPeUqygYvP0
        +8N3AqYgg+O7vYudvD+oSubyiQ==
X-Google-Smtp-Source: ABdhPJwBEuIvATf8ZvtYH+QFdkZFKFsiI2ouqWydcEp+plseXhkKTPhPawEJPSFK5qJG1770GsSaiQ==
X-Received: by 2002:a05:6e02:1003:: with SMTP id n3mr1776667ilj.279.1632783550994;
        Mon, 27 Sep 2021 15:59:10 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s18sm9777762iov.53.2021.09.27.15.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 15:59:10 -0700 (PDT)
Subject: Re: [PATCH 5.4 00/68] 5.4.150-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210927170219.901812470@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <001c370d-3532-d91f-b742-a0f85145b13c@linuxfoundation.org>
Date:   Mon, 27 Sep 2021 16:59:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210927170219.901812470@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/21 11:01 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.150 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Sep 2021 17:02:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.150-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


