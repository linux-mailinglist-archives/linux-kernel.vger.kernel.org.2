Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A7442E455
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 00:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbhJNWmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 18:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbhJNWmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 18:42:11 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A677C061760
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 15:40:06 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id f15so5165265ilu.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 15:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tgRouR0K41wjS0/qgbAU19e8MpLk78cPkqyVudQRewM=;
        b=DlCovtphzpB6kRJ2kkn0PBv1TO05zjaVyBnC5SZoIluVkhDG72EA4XC7Ia2DnuJo9J
         Sm95J5OA0Njj6Mw+jRxOS4bEQrsLJconDhnLU/zMBLCBm41qcgB6r52RhxZs26iOCafu
         NckeWPsdTt6OZzs1Al2XRZQOAjoGEUgcvmf78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tgRouR0K41wjS0/qgbAU19e8MpLk78cPkqyVudQRewM=;
        b=GVKV+8mKHmvqdVedtWmRXta/0/7HLg3W5yEX7u4klDR6Hu1eQhjKdJQbqF32hTA7vW
         eO18Wx1xbIh7nBKnuD13zUmGksnrNJcHiEs1qv7ulGWB/nka9UFzS8X0i4SrU6U7ovnC
         yJaGbXZYVWviYl1RoibQCGq8A7GERbxq6Wda4jI/gQQ7p0hlR4+/pdzXq2/0Hh8NsKhV
         qKCo5701M43ZuHTR1OR0j3FfXHvd+jQ+2dqsYl45lwJ+B9QU6p6AZxl65VDYOg2UN21a
         JoegPyqZkjHr6K9SQz3shxA9S7LufSM5Y6v8PdeDHoN5ukfWZyDXEA4qvbZ4L/zu9uYR
         HSFw==
X-Gm-Message-State: AOAM530xo5H85J44/KHuidDWi+Cx1BPkSy7UAfzmwbz1OC4LJlHIZgO9
        0g7xeG6+k9tprrvm0vGE8eZfGg==
X-Google-Smtp-Source: ABdhPJyPz3w1GJm2YmjNfAauDSSMhDWS3cKMlYMvsqL+K3J6eaqQoyG3Xiq1MPEgDXxApWmO+ZY5Jw==
X-Received: by 2002:a05:6e02:1c43:: with SMTP id d3mr1271834ilg.153.1634251205668;
        Thu, 14 Oct 2021 15:40:05 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c5sm1798825ilq.71.2021.10.14.15.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 15:40:05 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/25] 4.9.287-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211014145207.575041491@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1431b13f-8144-7577-2f1b-cb3fe607a91a@linuxfoundation.org>
Date:   Thu, 14 Oct 2021 16:40:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211014145207.575041491@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/21 8:53 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.287 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 16 Oct 2021 14:51:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.287-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
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
