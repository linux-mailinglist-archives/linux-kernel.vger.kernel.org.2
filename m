Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFE73615A3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 00:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237250AbhDOWoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 18:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbhDOWoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 18:44:38 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD69C061756
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 15:44:14 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id d2so21512681ilm.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 15:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bM0GJUz7EeI8fLWH+TtYrvFRkhckSsQfBWTt1TPM9Ww=;
        b=ZoQ1y99csx19bj16W78ajXkJtj1E3q/iL2vB7upe79Bh4hAYiunqORgZtkmQJhvCpE
         4Xb0ycaxU0VXXiW/fzq+d1lebucf4zesvWwFj5PXYyT69uMPtL2rn5bKtPhOUmXLbiMn
         hi0pRkZc69QMnE+9UFujF/fuR7uhUTliTf964=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bM0GJUz7EeI8fLWH+TtYrvFRkhckSsQfBWTt1TPM9Ww=;
        b=ODyPji5SG6p3boa6P3xXS/GATbnrNOG54qFL16ZgXYloy95aKQeSQyqQAg/fOHyMbj
         vYOyEuJcZ175rRsWMkJJQkUFkyyVAe7jG5VmP5gv0bykjvRWjzulzuv3bKDoTLMb+lkn
         M/eM9sFd4zqapRlpZcO0yF6i41/8T+fIVcY/+tPt3onogd2dGwDy8ZrEyh394MPp9tvk
         bhV1QVMzeXdVP6/lQYtZNfjRiO+NAKXGniFOYNILygqXdwdK449xZNyH/7/blMvNAP4q
         4JSdM7XHUqKH3ltmeAoNcs2wPowXrs2LbDrdEaqXbOWbr8Mr+kuqt/Jl694m0TJnXUoR
         soIg==
X-Gm-Message-State: AOAM533B1AW+BLi4Q6LSbhXy9WM4kXERnXZ5zIE+/vvI/ll4Dg2FTeBm
        W8fMN48Kg0u3vfKfx/7qF7Qd0g==
X-Google-Smtp-Source: ABdhPJzpbowzjekEbQbbwYmbOYuD+HKOOryCp0HjLLnqMsAJ6uzE8cLMhNUolQUl8BA042SL+M0F7Q==
X-Received: by 2002:a05:6e02:1b81:: with SMTP id h1mr4644659ili.157.1618526654238;
        Thu, 15 Apr 2021 15:44:14 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l5sm1841133ils.61.2021.04.15.15.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 15:44:13 -0700 (PDT)
Subject: Re: [PATCH 4.14 00/68] 4.14.231-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210415144414.464797272@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8e5c3d2b-63b2-be3f-6368-4e163c28b539@linuxfoundation.org>
Date:   Thu, 15 Apr 2021 16:44:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210415144414.464797272@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/21 8:46 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.231 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 17 Apr 2021 14:44:01 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.231-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
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
