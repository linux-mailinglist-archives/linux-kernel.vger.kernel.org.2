Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F08C422FEE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 20:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhJES0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 14:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbhJES0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 14:26:16 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936CCC06174E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 11:24:25 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id 134so13856iou.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 11:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yvwYrUNiZmzPktECDvyllDmhFEqWCa15ZA1nSo55nds=;
        b=DdvzXWhbX662+v7+GDdf6jRWJfdzjnwI4uxbMM0JtMNiJvTMWyGYUGcr8trU8kSint
         +SHawZc5NWIazvJbUAUM8wQte+T2AEau56VToLHp7LAVGedU+cIgdh4B0rSkq91L7hw9
         kbrkS0sU05EH7w5VH01oKOY2yG/gST/1Oc9pQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yvwYrUNiZmzPktECDvyllDmhFEqWCa15ZA1nSo55nds=;
        b=tmhy8FiGDjE/K/VoLVvP7kryISRn2llubdMoNWnyOUTMUXKtsBmmpZLsscBNsNxSy+
         CUoDI9XIp0E1xD2LIr7buzTXU+QLiGH0lBCNq3zMfkd9bmTRLej5xxzWo23uc8pA5jn+
         XNl7adk+x10XyLuuYWOMXpZUtAp9hzXEYmz1drlMngb0FVMXpsasDnbvqZ04sJxOgf33
         jHYGdkpXagvjsTcSB/EN5M92dpwUp2d/JFFoByj2WYAf/NCtsDSZ0Sdw/jCvndtEGnnT
         8g101j++5b6zK8+ptHJ4QHE6Nshqo/qxZRyyJJL8Ki/8rcAkUx5Miu7x2JSuleB7PVAI
         f7mQ==
X-Gm-Message-State: AOAM530adnPkYcOLQQfzsObVXNSqHkPjtKmR95RuaSnKJhklHb7FuXEz
        1YZ1/IGmQ4QY0cpprglw7HRW0g==
X-Google-Smtp-Source: ABdhPJwfSddRXNSZw/7LClxEePTrb1tYTfcbcSj8ZOy1ezwWAL91V+hndcMrN2AUC65wWnTHEyDgVQ==
X-Received: by 2002:a6b:6b08:: with SMTP id g8mr3455097ioc.199.1633458265066;
        Tue, 05 Oct 2021 11:24:25 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f7sm11286621ilc.82.2021.10.05.11.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 11:24:24 -0700 (PDT)
Subject: Re: [PATCH 4.4 00/41] 4.4.286-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211005083253.853051879@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5a83779b-134f-b22e-ba5f-4d202d40acf6@linuxfoundation.org>
Date:   Tue, 5 Oct 2021 12:24:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211005083253.853051879@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/21 2:37 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.286 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Oct 2021 08:32:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.286-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
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
