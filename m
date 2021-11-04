Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689B7445AB9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 20:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbhKDT5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 15:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbhKDT5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 15:57:16 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CC2C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 12:54:38 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id q203so8119170iod.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 12:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+LSaJI5eVpAo4OvNrEaEBw8K4N2W7nDPdNitVD57bIk=;
        b=Iqby8P73LFWyoTnSn0epChXbQSKlPcCsGS7vXeCJGMPPdLaqbz3XQFGEP7N7PpJ2MP
         lGve1tkDA+WunjBN8IUqy7N7hVFVg6X6zMjltZspMVQKQ+hUlMU9YDSaqLLd0uT3cEOB
         R5KRluefSfUXRB3k8YMvPoS4sjcqcxDasVNJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+LSaJI5eVpAo4OvNrEaEBw8K4N2W7nDPdNitVD57bIk=;
        b=VKD5pSQcpfk433W45/3EQIavpPUp6uxQyGLtxpY42Mc6CTlqVO64F0sE4lIaB912wN
         5jt8oNE7Nu2CaYoPeTwPNYpvEn3xNZhNJ+uQVa9wuBP96j2TESj5jqtsN45scKkQ3DUd
         5FlvJ6YXpJr2QgFt9/oet1AjrL5OHqDfCRKxICfW38UZUfk4wYUB9guaMaRJNS5YFT5W
         DwFZoK+akWDSyn3yiwdfe7AGkPa7sdIis+k3z2SLSWrINTt77sGTVXmUxceh08tFuFLw
         vkDppX/MZtDgMG2MRgO4mQ0PVhZu8UrkboLFpWqT2qFZgxIGBwAdR0Fqs9Dh3bUmSUa+
         olaQ==
X-Gm-Message-State: AOAM530z6pcXDxKuUdSTfDPJrFFPiGXyHw324OKJYjiME35EaRrsZF1s
        9VvlQQqCGFwT9KNJxV/HjmZ/Xw==
X-Google-Smtp-Source: ABdhPJwpunAdkJjgKyCTwLLmAvSIWGaGu39dhS0qPvY68uP/7fr1I7x8+VlKhT2n1Xmt5WIz1lcnVw==
X-Received: by 2002:a6b:db0d:: with SMTP id t13mr18995692ioc.171.1636055677815;
        Thu, 04 Nov 2021 12:54:37 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u12sm3306078ilm.1.2021.11.04.12.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 12:54:36 -0700 (PDT)
Subject: Re: [PATCH 5.14 00/16] 5.14.17-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211104141159.863820939@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c4d54834-cee0-80bf-42b3-31e6e3f38710@linuxfoundation.org>
Date:   Thu, 4 Nov 2021 13:54:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211104141159.863820939@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/21 8:12 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.14.17 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 06 Nov 2021 14:11:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.14.17-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.14.y
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
