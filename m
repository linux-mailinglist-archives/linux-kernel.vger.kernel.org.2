Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDB43BDF7A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 00:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhGFWrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 18:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbhGFWrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 18:47:39 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DECC061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 15:44:59 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id a6so710173ioe.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 15:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oy/NbPha7b/BONvLyNa1xrM1PBZ2k6dYZjtt+utPBZM=;
        b=JGZ9ksaddAO9fnE5nnkcHxs0/dp1klhlPuH1Z2t+KM6YWDmKADig6x30c7IQzPtH3m
         dIBO2bH+abJaIRrvH+GOZOkhZnf7i9HW4a8UWvXl6PT3VGzisPOBiVhgWhAqtmWlkknv
         b06XfGCsqM9pV8PF7CS6yVxMkyBuv2WpBI9Ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oy/NbPha7b/BONvLyNa1xrM1PBZ2k6dYZjtt+utPBZM=;
        b=R77iNYMzPPOa2the3sGFlbk6apwA1ijo59EsEz/vgZeEW0XxkguPKGmUEtGR2jjo2w
         aISSyAT9666qSdeDs90mCY0WEAQ1RWhm6q3fI/jmseVuArNS+Mi82hi4fxdakaD+6/lr
         vMkoYwVkjRsr74Q5q4Ny3V29Mtc8ZTo2ZQOJP4+Z4ezPf96AUzgMj4b2CbdcUWgD9e8Y
         4mMhEUI/r70jcA3DyeHYFQsKqwl31ZwqWWViEAsseyCM3P5YtbCSf6m2U++zEsgGz1Wn
         JtmMWsdrQuDlZRpEIJOa25J96w28kk32JsSEZ3hW+snKYigBF8Tdy4V4qpdJtOl9OHRP
         bskw==
X-Gm-Message-State: AOAM530NNVh1bwpWs0nHIqNoouadjWZOuHeGwYJip9dvq0xEXrzEvHHl
        UmQj9vRrLUXnyX/plf/9e2fG4g==
X-Google-Smtp-Source: ABdhPJyhe/fo3HRhK6AzpN3ofWSJhebcPRa5pE552qi6VAcK16E/JoN3r0HfvekOjsOzYVi1rYtThA==
X-Received: by 2002:a05:6638:501:: with SMTP id i1mr10242846jar.67.1625611499449;
        Tue, 06 Jul 2021 15:44:59 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id q7sm7370504ilv.17.2021.07.06.15.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 15:44:59 -0700 (PDT)
Subject: Re: [PATCH 5.4 0/6] 5.4.130-rc1 review
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210705110029.1513384-1-sashal@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <86ad6fc1-b7c7-7fa8-0d61-cbafbbfddda9@linuxfoundation.org>
Date:   Tue, 6 Jul 2021 16:44:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210705110029.1513384-1-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/21 5:00 AM, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 5.4.130 release.
> There are 6 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed 07 Jul 2021 11:00:14 AM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.4.y&id2=v5.4.129
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
