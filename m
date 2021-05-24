Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C113F38F550
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 00:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbhEXWFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 18:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbhEXWFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 18:05:31 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDB3C061756
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 15:04:01 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 80-20020a9d08560000b0290333e9d2b247so16123871oty.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 15:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7Jx6T7AUStCN+yMAsUD0+8vxHJiF2x/A73kJOCfbeY4=;
        b=LiSWdOxdo3oz4OEzihp+M0twlw1UyOEllmO80RZZhkCJh32kmQmyZbG0cyAA88T8xL
         8okNyhrmVdHZplDa+aE47L/bB9k7CwtN8AM0cjsEE1x/nJzF/enAD1+psKZnBEwP7Vxa
         cRHVY6Pql3QMBmTp3sYRMy5wHZ2HPr6F0avvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Jx6T7AUStCN+yMAsUD0+8vxHJiF2x/A73kJOCfbeY4=;
        b=bPZJD34LidtbzeGkY5XrGfn1pKd9o+mO1ymtMGpaSEAg4HITPyLOFWdpBqB216gdjM
         K9TSeUxSZNqr7g1NzEczJMHoAQCyzHXvXvYr936z7W238Gkcg6bmW9bQeXNsxZvRtHNf
         RRbldLbGUfoaoobtj5d34s6t44VC3psVs7QgOa2NcQs24LUe67VBJOksV4Dhlu7MIrkD
         /Cdv0tns4VqirWmdu17BPlAIIJ0dSDCUVjXNS4sEUZWEG03a7PXq2FFCvuLnKn9pWdqs
         AUN8hNEkx4nnttSUUHlg3IN2QEOFncTGiqDpJNKvI71Y1pyqCrB7uIKJfMCfB9eSJLao
         7e0g==
X-Gm-Message-State: AOAM532/02gI6p4Htn7euG2o3r45HerWAVchsQvt7bOtzMlsHXK9wtQ0
        6ZhddGiI3AHpDyXVIeCVVRHYkmuE/asxhg==
X-Google-Smtp-Source: ABdhPJw9FcU7UGzEiPTnark6sTZqLVsQq5rIcmG2Kv0BuNusScdG+vbwcwXi4Dl69HezWulxWhrwzA==
X-Received: by 2002:a9d:71da:: with SMTP id z26mr20879971otj.41.1621893841159;
        Mon, 24 May 2021 15:04:01 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c18sm3389317otm.1.2021.05.24.15.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 15:04:00 -0700 (PDT)
Subject: Re: [PATCH 5.10 000/104] 5.10.40-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210524152332.844251980@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9f42496a-c5a1-0d52-f0c7-b6bec3cce33a@linuxfoundation.org>
Date:   Mon, 24 May 2021 16:03:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210524152332.844251980@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/21 9:24 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.40 release.
> There are 104 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 May 2021 15:23:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.40-rc1.gz
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

