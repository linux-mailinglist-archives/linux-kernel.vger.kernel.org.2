Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8B2445C1A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 23:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbhKDW0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 18:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbhKDW0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 18:26:18 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCF3C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 15:23:40 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id k1so7701316ilo.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 15:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Me1pFtgM/7yd8RWKM4siEk1oZSnMYQP2DSM8Aq0h2u4=;
        b=cqgBty7Y+ZgFCKgq5D3x3icxLTtV1DoHFkSoDt9GwPmhs6gWC3++lmLmVWtk5oXpq6
         ASvhmoSOAVh7ty5ttuyT6ZkQ3me0kd8vE4zE45MSF1mp9vu9T5XJCDAc7dAQxc4KHbQn
         YKbZXLMsQ9PqYFlEEDuBlSZIaeFXwKcxxDnSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Me1pFtgM/7yd8RWKM4siEk1oZSnMYQP2DSM8Aq0h2u4=;
        b=b7af4AJw/CD4cdpB8jBv7rUHuwLlcQB3CyYV78U8MlvZ2yQ/yig+RdecZvHVVpQIsX
         5baJQ49+21iMH3bmsFABTR04tGa9PWLcvvKXxdKCofSXKzVLeeeVeBEI+3L0NmQBmZoR
         DCFxADm51DctwllJObS49V9qfqI7RTy91MMsA2FGoiNsMJ3pREb7/5FebWipl55rbCLc
         6nHtueh3Z/MeLy5KWNBBv2NrA5FgH3BwCLrSypxAqgeMFMHflVvN+Pxibk7frDqyvHNg
         kjyv5wOvMQltHGTlPtVrA34Rkmz2TTNKYZrU3mgwGkjZF9srLQZ/kSOk6rrbPJUzjF7k
         vg7w==
X-Gm-Message-State: AOAM530xaRPkoY5SenRaHw9MTpb33SCmc5TDLQodjcxVj8Djbn2E2kM8
        +8fgZv9aYZ56A7Wi3Pqcs7q5kQ==
X-Google-Smtp-Source: ABdhPJxXTOCA0rK8z+sJjJK7cO0rdXkLThvdaHHbvVCxAparwpJcBjzDJZ1lApMny+pd2EP2OR0aNA==
X-Received: by 2002:a92:ca49:: with SMTP id q9mr17111673ilo.49.1636064619870;
        Thu, 04 Nov 2021 15:23:39 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d5sm3966024iow.46.2021.11.04.15.23.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 15:23:39 -0700 (PDT)
Subject: Re: [PATCH 4.19 0/7] 4.19.216-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211104141158.037189396@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ed2dfbf1-1503-40d9-6a8c-ccb4dd7681b2@linuxfoundation.org>
Date:   Thu, 4 Nov 2021 16:23:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211104141158.037189396@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/21 8:13 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.216 release.
> There are 7 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 06 Nov 2021 14:11:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.216-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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
