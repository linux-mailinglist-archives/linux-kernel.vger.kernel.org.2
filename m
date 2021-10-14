Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6446942E452
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 00:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbhJNWlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 18:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhJNWlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 18:41:44 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3509AC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 15:39:39 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id y67so5595272iof.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 15:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uKloB4m1mUGaEalzS8CHQJ18hD01xslCX3l9Ey7k5Fc=;
        b=aVm8SmvXTsmO0z+mnoXzRaGw08xrX1/tGTftgHHzyZy/7nslxurBrp+lXyPigADCzp
         7GFIqqMJPN17KEZquTZYGMc19EOa9kJzuR8l4uVoTPVssP403FKkhjb7vdilC6j3XiDt
         E4ncHwBDTLJVoTwBwn/uMf1OlQmDlbpRHvEA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uKloB4m1mUGaEalzS8CHQJ18hD01xslCX3l9Ey7k5Fc=;
        b=Tqm0WyilLjBjGnrl7PCKZ2SnC5xFMpd1wUMcwZxRfo9LbTVrGWLfEH6fXMB6x1a6YV
         Np/NQn2tXprmtC6Tm/jqSmZ2TLWpMz9nvamTGIN2t6PcopBQucCuWL8nSREFqe01BckT
         sPB59HCfPJSLEw8VxVDQTpx7HhA093O6p0wKOKy2dkRVWhzIZ9IFMJme+WYb+VPgcw34
         2f/SPyRFuNZd3MIXDKzfutbApuEw/e9ifqZ4avSLI4K4NhucDWChyaI0z4SyaSIESv8e
         Z2+zHd504gKSLu/9sI73wR2lJdBiteS8jZuwzibsyytMYrRuxYKImlYBKLc36OACl9/q
         kKQg==
X-Gm-Message-State: AOAM5326Eh0K8eEMrRyTqHdplriwPXkcQtU04pS9DSNbEoIdvZc2BAt4
        sX9h2kK8szQnGP/hpg5/R5LEdQ==
X-Google-Smtp-Source: ABdhPJxnoJSuhFuPAYlW5MRe++XygYOobdvKb+K8reC2vfpGkW9cVNJWuu1xhScLQmZ7+KC6MH7FBw==
X-Received: by 2002:a02:c731:: with SMTP id h17mr5942734jao.93.1634251178638;
        Thu, 14 Oct 2021 15:39:38 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h2sm1671004ioh.14.2021.10.14.15.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 15:39:38 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/12] 4.19.212-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211014145206.566123760@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f32e65c9-cee7-5c5b-277c-a6e30fab1c54@linuxfoundation.org>
Date:   Thu, 14 Oct 2021 16:39:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211014145206.566123760@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/21 8:54 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.212 release.
> There are 12 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 16 Oct 2021 14:51:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.212-rc1.gz
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
