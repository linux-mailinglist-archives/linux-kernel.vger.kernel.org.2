Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9308D40EC49
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 23:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240323AbhIPVSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 17:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240269AbhIPVSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 17:18:25 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB4CC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 14:17:04 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id h20so8005124ilj.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 14:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cz0QmYX8hNrwopeVbJnfz1Qp5AgAwW9kHP7Z6OOnuIE=;
        b=EDXTu4qPZcrVHNz6JDfm3x/Eab2RBJkrazYr2ywOuSvy387ZVTxCWGfSjkM3MeOiza
         UlLbyJ5bsMHzPTNnROckxh/ZS5mks0FZAUdF6cXKTk0tJH01bpVRptLD+VqiX0X0pg8H
         Qp6LMShbred8bIe9XTMqdUaKorjFEshNmqtmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cz0QmYX8hNrwopeVbJnfz1Qp5AgAwW9kHP7Z6OOnuIE=;
        b=oF/e/ANge0xLi2DCmrsjsVOIcmo2qN0JUaHE95TG/na14Ocbut/s++G8pMLsXSM2Ep
         BqCNHPAru+pubcAbZvCbheNjslMQ1QaNv9XF8xX1h6WhT1iSrvBTPmi/tLz5ojPuF6HX
         01gppCxSKBUpZkrq1zFROeHvCOwMNN35PvjYgN43JwuvGQVfTum37qxnu5WOnbzZStVO
         5U3QaSFQ6IBdETHK2iY7BvmhqiUzxuw6GqzV7yvRer8VFhgFgxYdXOVRt6WRjb/5Zd2B
         a06xLCriA1n/SGtt97MFt9MMP2Q859H9SGFAcLhiqKpQ03TN222Mf8VIAK+oO+rTukGl
         N+cQ==
X-Gm-Message-State: AOAM533ekOUBZKj1yDmaqgVdwbk0J3tG9C5wu+rik6hTr24X8saQfJYZ
        LPcO9ZsS0V17AaCupi7oyHMUQg==
X-Google-Smtp-Source: ABdhPJxIpzNnOXR+944y+Wwww7dsqT+PDKVArThJ1wrSdu13C6tZH35Loa8KrG3JdyIVKiOwj47/pA==
X-Received: by 2002:a92:c145:: with SMTP id b5mr5250638ilh.203.1631827023466;
        Thu, 16 Sep 2021 14:17:03 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b3sm2383958ile.37.2021.09.16.14.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 14:17:03 -0700 (PDT)
Subject: Re: [PATCH 5.14 000/432] 5.14.6-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210916155810.813340753@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <03818767-05f5-08b7-1abb-4c250459952f@linuxfoundation.org>
Date:   Thu, 16 Sep 2021 15:17:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210916155810.813340753@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/21 9:55 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.14.6 release.
> There are 432 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 18 Sep 2021 15:57:06 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.14.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.14.y
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
