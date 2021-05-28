Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC533939E5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 02:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbhE1ACX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 20:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbhE1ACV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 20:02:21 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E710C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 17:00:47 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id o21so2338542iow.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 17:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ljSzjBpLO08RTVC/SmajITBY80h8dDg5ABRIUSJP3a4=;
        b=a/NZBSFJLI2NSzZKistpWfK+Q/KrokILHyQRUnUkxStcv7hT32+B+HsZpBrK7Ceaa4
         gwVukz61EtzVvkO2PJJWXlzXIr9Wp1C4kVdXOxM/V73rJR2Cj0p3h3HnbF7ItNlvO/26
         VoUBVnILofr9d8U/Xf1BiyECxgZ+DKL1pSg+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ljSzjBpLO08RTVC/SmajITBY80h8dDg5ABRIUSJP3a4=;
        b=fQe4yUi5XBZwoYDdwErpbcZ3hMlmEDheyXYtcJsQ14OZYORwpzThJJGSk/kkeed3Hv
         W3b359wM/gS1VYSbsN292uLIsiVks9DeuSAV0IuKeNP6NLZJpWUNi7BJInhAdgmRKhtQ
         CQXOf87lq3VO3Hk0iBHH3of5OPhkFPczKkXLrbP6OAvfCHFNVmMx0t8msjmiBRfSsu07
         FWZJsreb3tZTb8YpwNMz4VyRMyn69LBtr0YriFDo5XtpoA6fATGtZXU+EnZoXF9dxyJL
         q0wdzKjnJjVZJQOa0DY5qKzYnDlXv965svcAOlk+KGh5fUWH5Xg/btcgvDHJmtsmm7kd
         YO2Q==
X-Gm-Message-State: AOAM531ulEZEKanQhQ8Ks9oAcJl8CeYfFP9et2UhAwifW8PohQoV4+Bb
        nPOWuLC3ur9nxvgCUzgL3AC1Cw==
X-Google-Smtp-Source: ABdhPJyGQNyh44gU0Cx3ddDvrl8sfLOEPvpx0lhiuzLLWYLdApJSv/5edEVXab2Xcc9MkooHE1P7kQ==
X-Received: by 2002:a6b:7901:: with SMTP id i1mr4889264iop.41.1622160046942;
        Thu, 27 May 2021 17:00:46 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h15sm1491621ild.61.2021.05.27.17.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 17:00:46 -0700 (PDT)
Subject: Re: [PATCH 5.12 0/7] 5.12.8-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210527151139.241267495@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <caed6d8f-2fe0-a02b-3d37-edf5b1d04e27@linuxfoundation.org>
Date:   Thu, 27 May 2021 18:00:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210527151139.241267495@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/21 9:13 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.12.8 release.
> There are 7 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 29 May 2021 15:11:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.12.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.12.y
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
