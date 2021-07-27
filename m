Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2854B3D6B1B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 02:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbhGZXzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 19:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbhGZXzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 19:55:20 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5B9C061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 17:35:48 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id x15so13130140oic.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 17:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N4sHPqFO+0UnuIajq1CrRbZYg945sBNoYL5FHc1bius=;
        b=AhccOk5/4mvoSZgyOGBI5bdwH+y1ro8E2e18YJMCZjZmbFN5QlIN0+GJ/m2VLrqtx6
         7xEF7zi+FfvNM/voLxApxNfMNwcb7CPrOyXFppTybm+yBXmhqNI3LaHD3F0BsfqsvwHv
         8B9kYmUkWN5sxrEQvdWzBqjif2tupvtoFbT88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N4sHPqFO+0UnuIajq1CrRbZYg945sBNoYL5FHc1bius=;
        b=cRqCp+5X9StH0fzI+qybaj3zmWV6ZzSZnnYHhZUUBYyfXzsBD6QNUYA09D6qRMO4H6
         tUAPqjBszf7QV3iRslKQQFKu+a/sneizi5aR4N+HBDUIY5XfOv787U3c6Mxjq52VleOY
         bQUw1Ahh9oFXLkWyQ1aUv2hifxFBk5WrMUQZLOfE9hCNIyVftpmZ+21kjfP8YqlDCwXB
         WnttxYn4Alp3FpmmF4O7q7H65eU2P4A0I3qOfb6I4AeR3RwumhH5fhUEsESY0cEGyr59
         vHrwMSSVf4lmoV9Vm1mJ39BT51BQnsCm93zjzvf0cWmqnqiMXe1lUBb4LHYiwlRilExM
         WSTw==
X-Gm-Message-State: AOAM533W8EZ0fRPXH2YD7uVtvC/yjQ1PsuFWgGjBzrzwca2yNF1MClRS
        4jz+PSbwWsN+CcGposRCxLKYBg==
X-Google-Smtp-Source: ABdhPJwfNJs9v1D+e6mx51sqjGc6w94Xc7N1ihTD5nwba3hk0SJTSo64D7NSveJkdO7KYgLINVYH7A==
X-Received: by 2002:aca:5f8b:: with SMTP id t133mr1126873oib.15.1627346147529;
        Mon, 26 Jul 2021 17:35:47 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c26sm265077otu.38.2021.07.26.17.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 17:35:47 -0700 (PDT)
Subject: Re: [PATCH 5.4 000/108] 5.4.136-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210726153831.696295003@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <bace032a-c6e4-ab5f-0d38-c2a1bd48b037@linuxfoundation.org>
Date:   Mon, 26 Jul 2021 18:35:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210726153831.696295003@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/21 9:38 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.136 release.
> There are 108 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 28 Jul 2021 15:38:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.136-rc1.gz
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

