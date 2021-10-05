Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAF1422FE7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 20:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbhJESZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 14:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhJESZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 14:25:22 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028E5C061753
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 11:23:32 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id w10so289352ilc.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 11:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=na80cm/xXJaN3w1jwQi8PxEvi7ju29iCsJLHTVI1DjE=;
        b=BgVSEVGuKQ2B0AWjc5WdAtRV4yzgf0DlZxJBPXniLeQngvmNYg+5Ef1G9/1peo1AjQ
         ucKTBMJY9t779crpoVHD2Nm9dMbkYjcDyOYLkXazIY9iSj7MvfOnejPMaMiiTBuqr2At
         CoaeF3fPyjXqpayvjaQXGWLG2Bmq4B1ex/KGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=na80cm/xXJaN3w1jwQi8PxEvi7ju29iCsJLHTVI1DjE=;
        b=Scuwt+R+qZVHKS1zMMG2IOZ5/qNM8A0a2zbAEXsUoUzdGlkB1FPO+cz9Qe92wR5uzO
         XUzFmSBwheuwPnO+KGM+JfM/x/EFVjlni0eWACeenCsnCW+bIHj+UCstUB4vNJMXad2l
         y5meld/pnfz6h7eTkFyjiNjooMdyrLO6L5XZM7N28/1qrNZghP1OoNzZOfgZ/cm/Rzjz
         YSmQ5NrelxJSgxZJyxwxJB18NNz4fCLjTAMsW4wnNciaKsFWtvzFKAhgPOsmS5gkK0EL
         dWpwYAOLyToh3836IInI+fZDIWAHnBlJRpiGp0oTfGMPLKwr3TWZl7ovoylFaDS7tlhW
         4mMQ==
X-Gm-Message-State: AOAM533OaI0RXDSDHq9tDKTJOjm2Sy5jYFB8FutOPqlyVZfzjAUBEw2X
        SDG6v5RSMF1AVVrEsoZ02t0M1w==
X-Google-Smtp-Source: ABdhPJy39xzp+WWHqdQxowHBz6hv9Uf+zM8FDOfU9Oz8lyxp0+lQ1aY/cyW5GNMs+EYoJ+xpO3zrgQ==
X-Received: by 2002:a05:6e02:8ad:: with SMTP id a13mr4405577ilt.136.1633458211342;
        Tue, 05 Oct 2021 11:23:31 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c11sm11127583ile.22.2021.10.05.11.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 11:23:31 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/95] 4.19.209-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211005083300.523409586@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <07b44a7e-b488-801f-025e-c875e8ebe3eb@linuxfoundation.org>
Date:   Tue, 5 Oct 2021 12:23:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211005083300.523409586@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/21 2:38 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.209 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Oct 2021 08:32:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.209-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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

