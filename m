Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC74142E44B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 00:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbhJNWkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 18:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbhJNWkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 18:40:32 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6144EC061755
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 15:38:27 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id d11so5135716ilc.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 15:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m7H19zP+cEHxkuoLJR67ShZQWgJUHHJdRrdcqwcoos8=;
        b=PwQOHLfRKmcgBS5VnSzlfvPCtOWrWvtFsOP5yhgySVGSn/2t1Tt64jCRUZAJhemv5j
         ZOGEm/pE7nrQPut0l1W4RI4AjKbZFTG4ml3oKkTg6unpbQGKrbUax5PGVNxGOjaEZN+l
         LZ2Du03AjdBu5bem7vtCPRTVCIfZnOnlttuPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m7H19zP+cEHxkuoLJR67ShZQWgJUHHJdRrdcqwcoos8=;
        b=uqHGhixDWCNAIt49RdxJcjs8xtwB8pBMvGY/yIzX63sCvC/iZqVvEvNPeros/7XOqd
         QnGusWMQd/WiBcs92076/pktsvixVCjFo1fuk/g+uAe5BB93NBrXZtKq6o57dwMukFPu
         ErTcEEKRSF74nb6tixwOf5HrXfOlHbjwKckERgSyxyMclj07ZWlRRkmMg4e4YHTFT1Ie
         8pkGx0xH1ho9nEuBozaqjjjEAiRZDIBmc/9jANhV8xFcNs3NR5KbiG7Fpxo1Lz0gMjNt
         FsIm5QOcM9iNQhQmtMcPKwUIjDgHPkmWHT4NHJS3TC3zDp7E3W0KhdbTJcbN5Zu0sfSV
         IqhA==
X-Gm-Message-State: AOAM530To73lh6nHRIfBY8Ny11VLu+cIPn3OuQKd5gzo5UKjyWj7B6l/
        aFgDDga5So8ruvkvS3k98uoIzA==
X-Google-Smtp-Source: ABdhPJyLWHGMJFSqjV5eZmKgx98PkcDLmrS3NMUCz8w7eEoxAPe1UhaXMgUm8zYhz8T8XzuDJAavig==
X-Received: by 2002:a05:6e02:144d:: with SMTP id p13mr1203128ilo.15.1634251106698;
        Thu, 14 Oct 2021 15:38:26 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r18sm1863515ilo.35.2021.10.14.15.38.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 15:38:26 -0700 (PDT)
Subject: Re: [PATCH 5.14 00/30] 5.14.13-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211014145209.520017940@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e27707f3-4fba-7bbc-cfe8-e383b83e2789@linuxfoundation.org>
Date:   Thu, 14 Oct 2021 16:38:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211014145209.520017940@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/21 8:54 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.14.13 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 16 Oct 2021 14:51:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.14.13-rc1.gz
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

