Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F6140EC54
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 23:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240126AbhIPVUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 17:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238340AbhIPVUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 17:20:09 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C64C061766
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 14:18:47 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id p80so3024679iod.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 14:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=23av2RsDxVsTdcjbqWTIADtubLaRLLB9MuBeHkSa4CE=;
        b=fHnlBv91dRfsxKIAZn94WkcufRAa5NVK6eHA8jUpLIGSWESrnjhDbT+cOa2C6GCgiU
         GtYt50fUITCgP+6eqwAATxzx0HyhMjjS8+EXBmd5mEmLJDJSz91aVBqSiDPMO9Dsg4nA
         0ZXDWc2WYWlZZ5CPNPl60TodF0oc9QeGymYho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=23av2RsDxVsTdcjbqWTIADtubLaRLLB9MuBeHkSa4CE=;
        b=D3C8WEFVPOLyhDL3VmBTxLanUm//quWyErEnsPNlcQl3rOo1vvlMYQMb48PzGj0OIE
         z0ebg8qg/0fKE+enkRrCWs653eGsVdffwr/67wVs+FA8J3vwER9LptdX0r0NTne5/Unp
         vVBJcw6QOkoIvvJfKPz789qZdWhM6oyvJk5P5R30bfpqYQV1+rf0tRY9JSfMSjvcJ1qJ
         w00BT4k6niGafB1uGz4WCpAWLld+Fae6ooMK6E+nZrAbb6Zn2n5dGS2fFwbGZIl4WC0S
         bp740LpALsCicZk1tWpRPD1S5v+t4JR4O7vHmQHfaBV4dgJ+qDrUUEG6MNt40jOvxLPj
         6HCg==
X-Gm-Message-State: AOAM533tMa9qPIduRq2xLUFahDVKR9zh6SR9yfJZCVXcfZ7FpnosAlu1
        aLkZVk+EQL0GNb7Pcb7vgwhwjA==
X-Google-Smtp-Source: ABdhPJyMCF4xAQqoJbazuBFjXrScpYBswluZ2KWgDqtovafbxDzWrvxyjPCaNsRiCXpK9Lyy89gT5w==
X-Received: by 2002:a5d:8b59:: with SMTP id c25mr5931908iot.190.1631827126674;
        Thu, 16 Sep 2021 14:18:46 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f17sm2384953ilq.44.2021.09.16.14.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 14:18:45 -0700 (PDT)
Subject: Re: [PATCH 5.10 000/306] 5.10.67-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210916155753.903069397@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4dd04f95-f383-e16c-e50f-f00a54649dc7@linuxfoundation.org>
Date:   Thu, 16 Sep 2021 15:18:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210916155753.903069397@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/21 9:55 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.67 release.
> There are 306 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 18 Sep 2021 15:57:06 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.67-rc1.gz
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
