Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704DB3CF100
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 02:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349101AbhGTALM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 20:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348190AbhGSXwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 19:52:24 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62121C061762
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 17:33:02 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso20005259otu.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 17:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4cied0e7SWPRlTwXlatMsADeUvpwx3t61EYsWi64Us0=;
        b=L8ycv7aXHkVjrfuYF25WVzpZnJtGGl+At24aolHZbcmW1EzjCuoBhiYPugTIQb5IJY
         IGTxF10ozs5Lt5E7wlCNgUqWyI/oe1Fq52x7HiwretLG9aVEIzfk2RYd4XB9p5uiQ6en
         DB/iVB2OUL0QSsQoyrDSSLX+3Zwo9U1BTqDRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4cied0e7SWPRlTwXlatMsADeUvpwx3t61EYsWi64Us0=;
        b=TAVf7/hNMUrCk3QI56tcFP+laVumDr9mB2agmZcyWcVEVvUPFOskoDIIN+T4i6l3sX
         e6hv7wkya1ZOKGZmFRFiW8aJHCTk6f2ArU7TRhj1Fo/Rbdy6edFrQGfjh69vKTc5GhT4
         SR5R2WjQnhs0sT1t0Au0gJzlIKfgzVvfeVi+A17Wv0XYZXzCzlooic8iAejOmWEyNk1z
         s7VWtszYHPG25YisN+beor7BXg4VsyFFZLeiyFgAtvfnoeLWIoDGZvFV7p3mFyOWUeg7
         qVSjkCDw20jHXyVlu6ApWlbJ/uj5oSZ4y0owKfdD9LVWjd0X8Xn9yrhKy9mxuh8LqNqZ
         54UQ==
X-Gm-Message-State: AOAM533bA6opjmg0lb60Tz3HmhVZU2ZE1/efWpjZX+jb6ApJ1RYLdvhZ
        k7kcsnMbIH2Cw6kg7d+kgE4nUA==
X-Google-Smtp-Source: ABdhPJzWLAplRkuJlG9zgG8nsg+/8hbutrHOINMxFWUw7ZEThhdChfa9Uo/VYsckYLoy+eBazITLIg==
X-Received: by 2002:a05:6830:19cd:: with SMTP id p13mr19770896otp.362.1626741181805;
        Mon, 19 Jul 2021 17:33:01 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d81sm2874980oob.13.2021.07.19.17.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 17:33:01 -0700 (PDT)
Subject: Re: [PATCH 4.4 000/188] 4.4.276-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210719144913.076563739@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3cb4816e-9b09-1df7-bb50-42eedb1770dc@linuxfoundation.org>
Date:   Mon, 19 Jul 2021 18:33:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210719144913.076563739@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/21 8:49 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.276 release.
> There are 188 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jul 2021 14:47:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.276-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
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
