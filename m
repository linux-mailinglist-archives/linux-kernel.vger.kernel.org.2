Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC96E3C2AF0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 23:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhGIVnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 17:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhGIVnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 17:43:10 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF412C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 14:40:26 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id j10-20020a05683015cab02904b568e08dccso4719809otr.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 14:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QIHH0Vr7DE52Bl4e9VjhaMJuatVGStHYfexDRtUfJ00=;
        b=GqXKV+DNuQ07bSjVKx8TFl4qGL1nQIWAEZY9Z0b+TP+o3gB80KjT8Y/Y3+TYsaF+kV
         ef6A1QJpTo/dbGqpyX3J+hgnTs2BKmDeuCenyfspBVo+iUyus/uVDdL4yAiPTFhm20wN
         L+DwkPGkAa5HBjft9kl1BV+/U/QuLxNt9irKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QIHH0Vr7DE52Bl4e9VjhaMJuatVGStHYfexDRtUfJ00=;
        b=OgzIe2htUnXXWMV9edUs9Qb2uTJ3iCRwPRdZFIwLBuE5TsudHdDW4TFY+YWfxsqu3f
         vzfk8IBvMTSNBDNwat2bOlt+zXzWKPqUGeLNTPcsGb0NJi0o863yLuvXyajeZZ+FAHJ+
         D/bRefmGDnyliOni+LHCTgNRTqjfQ+Lperjpp6xmf1qAuYOb/FN77I6oNKsoYcXVx/PH
         FwZF7sxtNYZalzVLfBHH2ZqaIYCGG0hI0QjmxJfMcamRicn3CGllAtLYb7n5yAGrl+CE
         9UXFRRBbj80gqVxiKVyE+szxBrcvOJJ56F37YKzNDKS/z/ESOvugc42CxDAQRP8iq7mb
         qggw==
X-Gm-Message-State: AOAM530MjpdNZpOw5OBWoRWvBljOzZewm7rAkonie0Gd8P4WT8m/wQGP
        iaSAXCY3ldHpJnvN/LgRJf1NtA==
X-Google-Smtp-Source: ABdhPJxAU+wi0ijHJjllrZ+C0AOM+8hnReuCo5y87yK3KrxeHioDmrw7u4wKsCmEi51PAya54ZMD2w==
X-Received: by 2002:a9d:6a81:: with SMTP id l1mr22090200otq.239.1625866826225;
        Fri, 09 Jul 2021 14:40:26 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z6sm1406038oiz.39.2021.07.09.14.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 14:40:25 -0700 (PDT)
Subject: Re: [PATCH 5.10 0/6] 5.10.49-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210709131537.035851348@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8ea08d36-c3bc-6080-2da6-b1a287bd993c@linuxfoundation.org>
Date:   Fri, 9 Jul 2021 15:40:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210709131537.035851348@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/21 7:21 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.49 release.
> There are 6 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 11 Jul 2021 13:14:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.49-rc1.gz
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
