Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24BE035D4E0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 03:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240516AbhDMBfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 21:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238448AbhDMBfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 21:35:22 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A18C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 18:35:03 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id v123so8599306ioe.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 18:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7to+rPzO0p3n5dVCoP5w29TQ+/88jNgtwi+oKXvpZJE=;
        b=DgLYMCEzB3mAalYAfjNAhQm4tW0m/r8NlRweHjlGLX5QcbYk99kc2xayQwGV6TRPwo
         LGIEo/3C9s5ywB/XT7MHl6wwusXU2CM4JS7fPhN/baFaQxcFM5Wow/UFBmj3ppMTRl3Z
         ZBO1BhTf1zLquBP22GgBKnffj87pohOOdXBjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7to+rPzO0p3n5dVCoP5w29TQ+/88jNgtwi+oKXvpZJE=;
        b=LBq/IvToJDvLThqjxFGbhvBUIM7uT3QzVxAEneLuvzNrKYvP4YfX4SyzsTMwptJFit
         3XVcuk4Dgau3CL2rYQViTsAZ7TeqxIE4JwHyKTziWPRXI1n5VtDY4zp34NeejOTrV7L7
         0hyR7QkqZ3HoNXa2CLu2wbA5wK5UXUqgSJOPxh31i6MR00X7eQYq+s1QnNLTTpe/jq6H
         +7UCBEDlKbrXwHOytFFbDipmbJQjaexl3G+TD3poMnF6gUEy0dkt4ID6tQSZotveENas
         Bzwh+1wtNfGhu/IhQ1AlL4xM01ZsA1CpghWq92I2GRZ+zEqYTkki3lsAq9JosXchW9aL
         Gy8g==
X-Gm-Message-State: AOAM533dUydlryzN9z6/En4rROGsYgd4QG32nLcxi7l9MsK37ruV0d1r
        kzjyScreIYM8K/TN3f8umUTbMA==
X-Google-Smtp-Source: ABdhPJxA/a6f74XNSmYly9NElbTnsQGNHAbe+Xvs2fWWC9tnKC1hej6eRT4UlvxruBK3K1plDKqvAw==
X-Received: by 2002:a05:6638:f03:: with SMTP id h3mr6061208jas.58.1618277703012;
        Mon, 12 Apr 2021 18:35:03 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l7sm5971469ilh.49.2021.04.12.18.35.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 18:35:02 -0700 (PDT)
Subject: Re: [PATCH 5.4 000/111] 5.4.112-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210412084004.200986670@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <694f7de3-b03a-6516-c81a-0986e3517c1d@linuxfoundation.org>
Date:   Mon, 12 Apr 2021 19:35:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210412084004.200986670@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/21 2:39 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.112 release.
> There are 111 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Apr 2021 08:39:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.112-rc1.gz
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
