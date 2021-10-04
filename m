Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915A14217E3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 21:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbhJDTtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 15:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbhJDTtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 15:49:03 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DDCC061749
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 12:47:12 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so23046824otb.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 12:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sq3OEOBQ9Aa9wq4P9SuI1xrzqA0OykM/3/KU5+ESv0o=;
        b=hhaJ5Quq/ycTKhxcWatDKR40BZG5tQAofuTxmiBxPWww+jA2RAD9O3ZXPvktVkJBMq
         Ye5UtJdQnstfuOFUWSBbWk84kKHOrYpgmYoTRJ+iAIw1YiyQQSjGwLop0gtg19N1neH+
         A3WUJ3ffyQc+Opa/vdwv1YGh6MQMiHzYIbh6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sq3OEOBQ9Aa9wq4P9SuI1xrzqA0OykM/3/KU5+ESv0o=;
        b=nRrdEj1VWfVtau8WgD0Xuig+SenASlHxdtciX/V5KksU60gAbU6aqA66ZsACY/xttB
         ikkMJWFA1z/MeVzOVOdNqMdEQGxfgwxr+Y4AEj2lr2sfkpXsTQ4RaoLoGz9cvhkNcjKq
         9H0lrR3Twt9D4oz71J4v51GCOElLrtN+YrwzVmPKH3/OEZaQEqBW2yeK1xrIjsj5wZkT
         K9RHf8+o8TSev5Uo7RFb7hzudwnlpml0y/AQE5QM1yIuf4d9xOlR2HPIhVJWRfF4/qnl
         Bgf53QqFRoUIPFhiFk8ACjV+pc4NNBYr1iYB27//B7rCYoSSTa+tYRi8PNHfGzfhp4ct
         weUg==
X-Gm-Message-State: AOAM532ncScP282z6ECoBLXvr+pI5a++pWkNbW/Yj8kzNL5wbYWTkZ0d
        I3t/h6pPCK1wWZGos2ThiYQhgfwhl7Qw5w==
X-Google-Smtp-Source: ABdhPJzM3xbMrgAoZwoiekNKn4UmQbKx5w7v2Lh75MBJIVsDkdByBC1pq03Ed8WipGxAQWd71HZO4Q==
X-Received: by 2002:a9d:71c5:: with SMTP id z5mr3978981otj.375.1633376832237;
        Mon, 04 Oct 2021 12:47:12 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id q20sm3016056ooc.29.2021.10.04.12.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 12:47:11 -0700 (PDT)
Subject: Re: [PATCH 5.4 00/56] 5.4.151-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211004125030.002116402@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3ef62560-6e9f-d2a6-6221-c12d1dd15bda@linuxfoundation.org>
Date:   Mon, 4 Oct 2021 13:47:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211004125030.002116402@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/21 6:52 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.151 release.
> There are 56 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Oct 2021 12:50:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.151-rc1.gz
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
