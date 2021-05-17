Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA70386B2C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 22:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238914AbhEQUTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 16:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238894AbhEQUTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 16:19:41 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A31C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 13:18:24 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id o10so6181744ilm.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 13:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ByP8S3nCBesZxYz27rdsJMAikFVXljxFJ6WpTEUMsyM=;
        b=TPp9JgHusSQuOXXzCXSIX+/eGynLkL3YPDgwfSU5ZGv/KQ7RacuYCsGMdVIBDub99V
         6K+YVvz+QOoI0f6AFIpLKfDkZG9xO/ZOXfSRmtjnoYbYXZolQlApGckLUX+Mg+jtqzNg
         PXA8ylSdY1E52tku/+qtUdnppTvfKvQwqUIdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ByP8S3nCBesZxYz27rdsJMAikFVXljxFJ6WpTEUMsyM=;
        b=FMApPGtc/+jUxWw1A6FivnYDBOaqsg3Qhr8YvhdUVWTIGy23vAjQHGqhxGImkbOMRc
         T5iWNQJrgZl948kFxnbJTm0QY3zk3aYC9JaMbjkfuX3f49gSna9uwgChLN92SZi6h+8f
         jVkcn7yDMSvzx0Rgv+2PEyMMz54BM8GuxRDYPVVmPy/F71sgmogXmRkGRbEwC6b/dWvP
         BXpBnbZ6S11m6ER4HUnIXjO82IrewTc6zpIYiAZdfGUbwxeoxyvxEyeyJ2/qeWlVb5ue
         W2UnYXVlrhUr2DzOxN1P7+RQ6AQ8rH+WbEq/w8cPNVCNQmpPUuIHpWLzDHV0ns40LU9P
         iAZA==
X-Gm-Message-State: AOAM533P3FBpBUP7BQLP+3qSZNVbRK8CnkruscjzZNGV+6Efg3Aq1ysG
        /2c9ALv0PMLI8tRGsxso/QLYvg==
X-Google-Smtp-Source: ABdhPJwuHVdNbWWKmsw/ckrefrahug4G51n9gcHu4iWAWf4NS411tltxYmCGqcS/edL88ErW4H2x/A==
X-Received: by 2002:a92:d689:: with SMTP id p9mr1191722iln.242.1621282703847;
        Mon, 17 May 2021 13:18:23 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m8sm3486778ilh.38.2021.05.17.13.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 13:18:23 -0700 (PDT)
Subject: Re: [PATCH 5.4 000/141] 5.4.120-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210517140242.729269392@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <aa1094c5-8038-124b-5848-de5c76916e34@linuxfoundation.org>
Date:   Mon, 17 May 2021 14:18:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210517140242.729269392@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/21 8:00 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.120 release.
> There are 141 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 May 2021 14:02:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.120-rc1.gz
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
