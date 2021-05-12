Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61D737EEE7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 01:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbhELWYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 18:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443389AbhELWSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 18:18:02 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DACC06138A
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 15:13:27 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id p11so23176494iob.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 15:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1clSlFD68O20p4Y5ZkdY4NsvUgo94JLDLObr9UbRmHo=;
        b=a0EWdWzx8+oGVkOPVhGM7IeDfXokt9QZJSqvW4sbRSd5OgcISioX74hXKf1p8aEK4f
         /zVs2DegHIefsduvk6pRxLuDYiQgE7UiHO7uThmZUXgsOCN78x4eod18nfPZ02q8Aq0Y
         eLwBHec4q70h3T6xqvB9qFfdq1ntZX5wldF5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1clSlFD68O20p4Y5ZkdY4NsvUgo94JLDLObr9UbRmHo=;
        b=YYcgDKAjnm7XKip0n3srPuK5nywix8AvlFJyIKHDPFq/oEFQSs2ldYgdALRACbEEpP
         /uNqsa/kcY7uQCJTiacLSbd+2vDUbzS4jSDIpn7+Ndd6WdpNWBjMUn5AHoc5S7+i8G0m
         O8sSlbUAYUpnltPeWnZJCVeIqN4y0Z0AbAtYQNNhgvRkMl+ILLM8nsb9gbx4BKTSljyB
         Yqlx8E9IHTyT1KPbZlOYClr+sswSbAg4pWiteJnGojQEKRuTeggRdaMwbPAq77cd+Y4b
         eGN1tTHrU7zKZLmsmj7ROOzeIrFIYQC2UM173iu1dp/kiZ5FLLnR/B1WKRVudzdvy+DZ
         aXtg==
X-Gm-Message-State: AOAM53319Xa4qLRonofj+Wjr45i/3A5JCSzs8gsHp1JRgNtj/dOfOvP7
        HtqCNjj5V+6jYNSdbh6F7gY8nQ==
X-Google-Smtp-Source: ABdhPJxckEnUmG6/RZEDyLzNSGIybLU6ra6GC4QFHzQhTlKohG5YCv6qVrbAFgsnxIukPt5QFDhaCg==
X-Received: by 2002:a5d:848a:: with SMTP id t10mr28677843iom.68.1620857606957;
        Wed, 12 May 2021 15:13:26 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s17sm508671ilt.77.2021.05.12.15.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 15:13:26 -0700 (PDT)
Subject: Re: [PATCH 5.10 000/530] 5.10.37-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210512144819.664462530@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4c283d7d-42d7-b3a9-eda0-3a42de98d7d6@linuxfoundation.org>
Date:   Wed, 12 May 2021 16:13:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512144819.664462530@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/21 8:41 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.37 release.
> There are 530 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 14 May 2021 14:47:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.37-rc1.gz
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

