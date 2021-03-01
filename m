Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CE5329FED
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574900AbhCBDvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239973AbhCAVol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:44:41 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804CDC061797
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 13:44:01 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id g27so18113752iox.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 13:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sq973GXnxonVqs7o59SCDe9kUa1tHJX4sSXdLEk5IFU=;
        b=RUWcerz7q2K7w+AxtJNcjcSnvnpu4TIGjjVoY0jDDzciqXVHoMKKp/wB3lHvqC2iYn
         L4VUzD9YBUQQv8C7SxFSuzcM3xa2LVk+2naeAbwy4s4GG8o2et6Fbh8WswpepS3vPNBH
         rVrOq0wpSldlI/2TAb/qsyRxAETt+dJwvFNFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sq973GXnxonVqs7o59SCDe9kUa1tHJX4sSXdLEk5IFU=;
        b=SmmbHr0falfx637uPduEA/m+M9w+g2e3jbIFBIJFSaCF873CZZV/rH5sDAY0vDIO4l
         q1Fx84aAkEW329ifNQ1m6fszky6DDPTWgcgggDbwVaOK0rsUeOXwuegx5yFSOsd+1OfS
         PnnybWEIjTq0d5h5ywHFQ6KkPsFcuNoGOL6ygDs3yDISjLEA26MOLXpeHnrRkqDvuEw2
         cDONneZelXa9PX+metNPjNrQZsRl6C+bI+DgoM4ONHlS3waVRgnNZZbfCMc8VKObexDs
         NH1gEqfMs6/iDisi/7xhRh5EMrjO8saZbR4IYOUks85oAP9+MCwUfi92aKZjRPz9VxU2
         U04w==
X-Gm-Message-State: AOAM532nrP1HXb0wPOkcEnUUdm61MB5K0irXRedXZt0mWY+KtkVrCeiQ
        EW2eKTZG2SbFCxP5helJXAV8gg==
X-Google-Smtp-Source: ABdhPJyNJe7NsbxysLUjyaL84haRGQgaLejOLyHUcm4jC0YLE+O3zhnjLe6TLeHOf5fRZgAFYpUxWA==
X-Received: by 2002:a02:3e16:: with SMTP id s22mr18475180jas.72.1614635040943;
        Mon, 01 Mar 2021 13:44:00 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k10sm4662617iop.42.2021.03.01.13.44.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Mar 2021 13:44:00 -0800 (PST)
Subject: Re: [PATCH 5.10 000/661] 5.10.20-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210301193642.707301430@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a2483945-2983-54ca-45b0-a617288c6001@linuxfoundation.org>
Date:   Mon, 1 Mar 2021 14:43:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210301193642.707301430@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/21 12:37 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.20 release.
> There are 661 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Mar 2021 19:34:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.20-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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
