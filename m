Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C0236BC52
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 01:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237113AbhDZXrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 19:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235749AbhDZXre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 19:47:34 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61237C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 16:46:52 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id g125so3466874iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 16:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=//iXKNljqOsTTQ/4xWFpGyiiJiVWhmaCKFN92fR0b7U=;
        b=YcLa3BRm2/953qrQr0D0JtyQ0+YuCrjM50Vj4zfrDRu+V74UgoMXh6iY9VYihxC75Y
         VlGetmnqAfzobHSJOIBiY2CO4L/u0KLlzSfvLKKAOMfBERo0uxqaCrLgCUI758DoV648
         AvBhzp1mTI7uM/UmxNsaoWr+zdhQrLbz5P/KA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=//iXKNljqOsTTQ/4xWFpGyiiJiVWhmaCKFN92fR0b7U=;
        b=AVznT4cwSxeCBjDgvJS0n3pCIgBc7fB1NSGDSSAOsuEFvRNi7Pfhe1+N3MwH99MxZH
         KliLoFDYp4xD1JwkxhFoRGnYjKoi1seFXa5P70kDyFnTDIMz/hqxnztc6l7bsIFWg2kl
         enM3ujDasX0YODGfHgTDkcN9o3WX8QxTwPXzZzWEPWJ8zeudv1dx4z/fvH2DTlUxJ/qT
         dm6oAH3c1cduW1gSLWsT/ExuLaa07z8/c75uRm1pQ37MD6u++y7CDGzvx1mYLGTZhXEI
         lAjZAJj4d9QWKU0dP4SU+VXHXtmX3q90MjiTddTGdViLJJC+9M+pBbqw3BLi/KqBOBN+
         pgCQ==
X-Gm-Message-State: AOAM530ZmvLDLcKiyzoIfOlfUiA2XxoyUw4hGRN8Ol/bwv38nV77ZH0/
        0QOM61N7KIeLxKY6nw383858Dg==
X-Google-Smtp-Source: ABdhPJyw1amPkgyi6yH/hz2OV0MRo0HIYdM9HDbULglQHI1bVHpSslnnW3oiO+QitACPI1uiotGKoA==
X-Received: by 2002:a05:6602:2f09:: with SMTP id q9mr6496569iow.207.1619480811501;
        Mon, 26 Apr 2021 16:46:51 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i17sm628615ilj.75.2021.04.26.16.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 16:46:51 -0700 (PDT)
Subject: Re: [PATCH 5.4 00/20] 5.4.115-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210426072816.686976183@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0901b0ba-53af-d48b-71a1-b3533f0a409f@linuxfoundation.org>
Date:   Mon, 26 Apr 2021 17:46:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210426072816.686976183@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/21 1:29 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.115 release.
> There are 20 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 28 Apr 2021 07:28:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.115-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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
