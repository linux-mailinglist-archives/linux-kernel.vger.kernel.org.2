Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFCF3EDF80
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 23:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbhHPVw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 17:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbhHPVw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 17:52:56 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20700C0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 14:52:24 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id n24so6909424ion.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 14:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WM0RiCzaiSp39KfoeBuYCtjssF5wMkgccPnpXtLujk0=;
        b=c8nQlHuxo4ppeF36f/J9zfRczITAMVfVL+AKJR4BOw8an0ESKehiASvrxInlRBCz0l
         vftB86HuBMI/Md0gOJTwGnAt/Fd5zp+ELm/z5a5LqQGf+MkjXYFcBz7V3ihKxdiIhztr
         0d9iXRQGfBwEzAO58b4KIFrZVq4sV17epHymM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WM0RiCzaiSp39KfoeBuYCtjssF5wMkgccPnpXtLujk0=;
        b=XEB6hwOhe5yBmZGP854aM5CzevV0dAZB7nDJ6Szfpq2GpLfm45KovHStI72ku9EjkL
         H2zNb7AcimEEb6jFJdOmeYbR13GWifW0YNfTq4n/NvCoWHqFYYfF9FDSoI7vpnAP2ZsX
         73cTmj2ntI93krAa8aaoU8xnddHEZtdXjTpSWPXpYLDsuOMYW4KT357aOn7g7kT2BC+R
         0G5KgDJul6yNfQG+ptmPFkPSy9Ui+Ol08rXv8dCVHZJo8FAwScbDMF1VWpJWXF4AnOVi
         sxjeL3vK9XABvpto/Ehc02Wjk0cv3DXCGrbGD8rAxuG80OPK+JvmUV2m685onHfv0PMX
         WeTw==
X-Gm-Message-State: AOAM533fQ4sXPu5gqdzKzP2CReRMPKfY3EnU4i7W4lQAfiD8sddYnkqN
        jpkNRInNAqFTaVWvk1IOcuu/Cg==
X-Google-Smtp-Source: ABdhPJwyZ8KmcNnpd5BdV+bYC6EN/OpcFxaLlo7mIYl3c6924r2yD7QvJENE6I7+zYSTS0sLLr0rug==
X-Received: by 2002:a05:6638:521:: with SMTP id j1mr175jar.122.1629150743490;
        Mon, 16 Aug 2021 14:52:23 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m1sm51826ilf.24.2021.08.16.14.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 14:52:23 -0700 (PDT)
Subject: Re: [PATCH 5.13 000/153] 5.13.12-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210816171414.653076979@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <fb044d0b-1af2-378e-ffed-229b6b9980c4@linuxfoundation.org>
Date:   Mon, 16 Aug 2021 15:52:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210816171414.653076979@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/21 11:15 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.13.12 release.
> There are 153 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 18 Aug 2021 17:13:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.13.12-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.13.y
> and the diffstat can be found below.
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

