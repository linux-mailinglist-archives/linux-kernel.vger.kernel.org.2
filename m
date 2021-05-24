Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E88E38F554
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 00:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbhEXWGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 18:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbhEXWGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 18:06:34 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980C5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 15:05:04 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 80-20020a9d08560000b0290333e9d2b247so16126401oty.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 15:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fNR+dO6QuyvGAYTH9SeCyrm5Vg7N1xXwkXsJPU12OG8=;
        b=C89CdEPBMxoeRx7g0Fwf9Sd/E4sLWkhJHOUxkL1xHqZnfahulssep29N9ArhkhcJDr
         qlSvwvkubF6Sr0uPaAaO1yqcL4LsSZMEdv7ZGoNjlaTCDE9nm5qqD+Kp8xGuRCLlm/hA
         NfIV9pAHVQ5SdQwL4f7+lOkt6c+zAZNxDYmso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fNR+dO6QuyvGAYTH9SeCyrm5Vg7N1xXwkXsJPU12OG8=;
        b=OhMMueBy0P8UueufLoEtyvMdjumhcNPamdND9rsxBlZrQsn4JIJchFsNSEmSB5RABJ
         ugWx+sP7lDDlfiKhVeD62gGtlJI0evW85MyqyEt8DNM58JpT9e7UKnmZYlxazj8t0StF
         NgXt50OvdafeJsv2S/Yz+dvEbFJI0JjUqdwgDM66FZIDe3WvSA4v42AgVIV0tZ8j3TeC
         qAlBUCTCd6U9tFOIXsMeFJwkRJPR5VypeSec2M2MZUhySjRSJ/xqpc+p9UuQ/8iOA0RU
         PLuZo3XR7Khw5bQfHxVElOnmce6epihqY5xMIdhfAJAwp1s5I2fS//CzdzVBXwCSV+5p
         QYYA==
X-Gm-Message-State: AOAM533jgJ6S+LCQRG9MmUnNC2YLB3Iti1jsWrF5OTdtMUe465q1UL5i
        IM6+bnEAdkXAI9EsMCWx8kw/Iw==
X-Google-Smtp-Source: ABdhPJwSeKScnxdjeBZ+4zex4SDE6VZvmRYCVR9mXtE0E5iofhAuXAfYYuv3mCF1VLFfv21zRewYaA==
X-Received: by 2002:a05:6830:1359:: with SMTP id r25mr18401985otq.331.1621893904046;
        Mon, 24 May 2021 15:05:04 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r10sm2870216oic.4.2021.05.24.15.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 15:05:03 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/49] 4.19.192-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210524152324.382084875@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <70644be1-7d61-8a0a-a42c-41d2533540e4@linuxfoundation.org>
Date:   Mon, 24 May 2021 16:05:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210524152324.382084875@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/21 9:25 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.192 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 May 2021 15:23:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.192-rc1.gz
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
