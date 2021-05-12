Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4D337EEED
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 01:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbhELW2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 18:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443373AbhELWSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 18:18:00 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C964C061763
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 15:12:23 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id w7so4770746ilg.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 15:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xk6WM9Nvnsf73gG/Qhb/WbqPx0KiByksmM78DUQUftc=;
        b=RrZMGIt8Lw8iuJ5x/JtUZOPHBGNLsxUVkODWlrCYpZAZlo6/bkQWIbhfDpfOFm0z/c
         VY3bYAkB0Eu5Btxk9FVzNbbpqNZz968TnZ/8yAJqTnzzI3xqaz0PFyRgs0cENBFBcptZ
         emihTpb+IwvRjEinuP/CA9bCut2QVAj7W/8t8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xk6WM9Nvnsf73gG/Qhb/WbqPx0KiByksmM78DUQUftc=;
        b=JBVzQ625WhAY+ObQZ3cuau4jlKqYUJsNNLiZORLfhYe7GdyGwm+7Nt35OgL3hBXBU4
         zN18f1VSv9RUc4rEhSHnJaeB3ydvFj++d3XiBv16CXppqdREJ6aS0VX4ZDQ9DcZLEQUw
         ZNHD232/m7O3UIgLI9qhnBPyge3S10OImaC6sHH/FMybjDOk2xdO4jLi7B42PACSqAoh
         1HUvps0Wl81id0Qs0+3zxMzdYOoNbzX/4pzGmlpcRYf3+GIIBsbx6vWu/jsfGA+pRzKy
         EZQtn81/XT4my4A5uHKAS+nylVNLR1DtA3hUGomZYuCW7/4AJjLvGs/VWcXAlS1EIS/G
         q9Rg==
X-Gm-Message-State: AOAM530jD6rTpyDMQqAUle5JBqPKf5nci/SnNqJ0yut+rTVxUK50Akru
        umHNujuJOPOUEVTJg3akNEgsLg==
X-Google-Smtp-Source: ABdhPJwt6CKlC4qc1V1O5YVcEjRrAkmvWviZLxNS+9FHeu2Veav5Ep+6dXTXcZrIOPCuuRZTgDZqVQ==
X-Received: by 2002:a05:6e02:1291:: with SMTP id y17mr32375316ilq.112.1620857542905;
        Wed, 12 May 2021 15:12:22 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a16sm431911iok.31.2021.05.12.15.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 15:12:22 -0700 (PDT)
Subject: Re: [PATCH 5.11 000/601] 5.11.21-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210512144827.811958675@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0a3398f2-836b-c9dd-5f17-b41e6b31ea0c@linuxfoundation.org>
Date:   Wed, 12 May 2021 16:12:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512144827.811958675@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/21 8:41 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.11.21 release.
> There are 601 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 14 May 2021 14:47:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.11.21-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.11.y
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
