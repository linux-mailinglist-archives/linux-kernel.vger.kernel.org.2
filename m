Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD08457970
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 00:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbhKSXUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 18:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbhKSXUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 18:20:44 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D5EC06173E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 15:17:42 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id l19so11812373ilk.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 15:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VxoPoCC9cObbyv624yFsho4myl9q3IV7NWPGVGoX05Q=;
        b=hF961MXX3VhZdSeNiwmKk7q4iv+7cIm5RGC9xSMSJDb6+kOOVBY36jelF6W1m/Rwrh
         Daf+8OAGdJ38SKzkI5hmCkRohKIgF/LWY/wmKQ2cvpGn2WPpZhqePL7XRc3Kb4nbPMnw
         k9LGM9CDnLX+12APTu2mHB/+yyKKPn2LPmkX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VxoPoCC9cObbyv624yFsho4myl9q3IV7NWPGVGoX05Q=;
        b=dt2y+fEXXawxedx4iV280XHHiocw5mTc8o5LC0AXxq4K8x89KHYm2nKFrskw7iop1W
         acl1w6oq8vIK9oNWNV/wEUx166rCOegOiuIVMaMezx3akA5dIBM2MT3sfKNn+VQnr1UE
         BmsD3JQCJbk26If0Y4tQMJwTN2BAJop3bLw6NwSgKcKmgybUSxclP3jQJT63a9T3RwE9
         ROI5O+px5h6o+jIixPE/fRkn9XlxfhIL8NkfyHNBxbymdBSIaJVH9FW2D6vAwRVLJ7A9
         Bha9SaBSCVvaTIm124k7OS/0an9Sc37b/yoO1YjQqiSn31sFKEl4OLC4wZZv4+qwm3rV
         e/4g==
X-Gm-Message-State: AOAM531pR3VYfUYtYxxDI4LGVHqqsHk8Ky3AHifOVtjpGFIwqOFC+/ok
        m8vRTT39y3YlwFSWY843pkc7qg==
X-Google-Smtp-Source: ABdhPJxu83UIDq15n0gB/UlpT0oEfwILMKyWTG8DekVMC2TQj51UzeFbc2C+LtEA69a+k/C2YKBaJA==
X-Received: by 2002:a92:d14d:: with SMTP id t13mr7781167ilg.194.1637363861976;
        Fri, 19 Nov 2021 15:17:41 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u10sm794231ill.73.2021.11.19.15.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 15:17:41 -0800 (PST)
Subject: Re: [PATCH 5.15 00/20] 5.15.4-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211119171444.640508836@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <355c0430-13e2-41c3-8dd9-783df7b29264@linuxfoundation.org>
Date:   Fri, 19 Nov 2021 16:17:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211119171444.640508836@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/21 10:39 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.4 release.
> There are 20 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 21 Nov 2021 17:14:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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
