Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3895E44DBF4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 20:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbhKKTJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 14:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbhKKTI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 14:08:59 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ABCC061767
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 11:06:09 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id 64-20020a4a0d43000000b002b866fa13eeso2188508oob.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 11:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OHWtm1P0sBfPh3OQsKrKMkyvna9UCfN/p2JGxMsM1ok=;
        b=WjI5Bq9ZSwvAUveSkvIRiMuDQ7GVda3f+iOHFy8odz+c4qFh54GX8NqImH62vwC2be
         6SBc7jk7upFAHQLEXWQZr1h9cExOWcT7bfZg4diJ+YXMaEvyemS1HGsalUHEPPmRPe3z
         PjwgVa13LQG+jmBcKOVyWzfCrGp3Gvn5rVq7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OHWtm1P0sBfPh3OQsKrKMkyvna9UCfN/p2JGxMsM1ok=;
        b=aVGK3Sm97BloztLs8lZSr0NsiXzDf7ZXeQWLYponAgPVwi+JdIQv/AF+CNfR7Q5MNy
         keW3/R5ClcwXtJpummdQa1F++eU6kBnnn8fj0kM9oiCXouQ9HUXuBjv1ZDUvMSnfV1Rj
         VOGIRztW83pJV5CczD81qTcPFGMchCxN21msLJ34cI9PPXkROhsRImnziWMtZP+rhN0T
         LFucxEE5cdSpspXh4a1lJSXOFzKKkfN+uWkUTJI7XDWy5od9jqWat+9PYGTGqa8rV1ao
         AJK5jCerbW29xsbZKWuecqu1WIuL4edXYEst5ZksuY6OOu+NfXnuef/dACY+ZC+4KHZL
         A6OA==
X-Gm-Message-State: AOAM531n9WMjOBDquatGktTZ15bREpg8hCxpLWTt4DnVrblBWhmKyicZ
        AlYHH7ryPB8bXkjo9PY5ueCw8GKZclQLLQ==
X-Google-Smtp-Source: ABdhPJzKX3e7y/2FkH9L+UWWwC9WbPR/EOnHWaKWQzSB0D9O05MG6TBl8K4DwiNc5Rl6ZLD9tkag4g==
X-Received: by 2002:a4a:d453:: with SMTP id p19mr1040386oos.85.1636657569056;
        Thu, 11 Nov 2021 11:06:09 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f10sm895552otc.26.2021.11.11.11.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 11:06:08 -0800 (PST)
Subject: Re: [PATCH 4.9 00/22] 4.9.290-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211110182001.579561273@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c6a7c206-d854-bdb9-ea8c-16edf07fe6b3@linuxfoundation.org>
Date:   Thu, 11 Nov 2021 12:06:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211110182001.579561273@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/21 11:43 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.290 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 12 Nov 2021 18:19:54 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.290-rc1.gz
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
