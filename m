Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA4836BC50
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 01:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbhDZXrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 19:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbhDZXrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 19:47:15 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35C1C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 16:46:32 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id a11so5394427ioo.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 16:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JMBhcXT+HqfLp739NL+n0eO/wpxKpYbd0B0X7WUl5/o=;
        b=E6j2YM6RMEQPoyRPWV9+wFEbEgT4CG/Ix+ual6y4Prl6ywU00IcDstS/3mH8X44/UW
         dMXg1rY2mIaqRLe/0vX/PmDlM2XFf1kyp41SpJANDCdJv359H6MJLSFjfvmML5fP0Jjq
         7wWSrOlCnW37MXVPNXG1tcBsJaXqLrVvhLm4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JMBhcXT+HqfLp739NL+n0eO/wpxKpYbd0B0X7WUl5/o=;
        b=JgV83JCHal2cDY6eHsZJA6i5Br2ZDatzogsrHZFhuL3cTPieRUVBpFMamst6lDujSy
         lRvYy7qhvMEVVUvZTIjpUJjXo21Fsh/9aek+zIOu7y+adY85OzYxSlZ+M3NSsf0JXuTr
         wJIHrfHRU9oSqEWC2dMlrKDpyVZExnk0m1grEiBXLcj6aB55bs41TStu9eaSXzwG7baL
         ZAWMPnolT80iVfVyTUkmVKZRQ/+eklNAsVdqA2nOUodnCsilzHSdlGYVgy7elyFZke+g
         LpQPUHlDjMhlmV+q5zzMpZAjHaDHmZhWAKi3T/VPF/z8r9ds99qjPyfU7hjLqw/x6kgL
         nU9A==
X-Gm-Message-State: AOAM5328B5s7oFjNoEh/RHL8SMxveiwmQIthmDyp3p7ilRZoAylK4/jn
        Yxm+itj0GS15bPvbeIg7u+60xg==
X-Google-Smtp-Source: ABdhPJwr2vuKRfiqpdiaGQpdq9rnKG6vSBMF5mLPnoEflDFUtv8me6R4UiGiOOzDhd266+TQzRCOYg==
X-Received: by 2002:a02:94e7:: with SMTP id x94mr18912173jah.106.1619480792161;
        Mon, 26 Apr 2021 16:46:32 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u4sm601730iln.36.2021.04.26.16.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 16:46:31 -0700 (PDT)
Subject: Re: [PATCH 5.10 00/36] 5.10.33-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210426072818.777662399@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c62dcf27-307c-228b-98c1-1641f4aeacfc@linuxfoundation.org>
Date:   Mon, 26 Apr 2021 17:46:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210426072818.777662399@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/21 1:29 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.33 release.
> There are 36 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 28 Apr 2021 07:28:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.33-rc1.gz
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


