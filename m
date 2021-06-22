Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A6A3B10DF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 01:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhFWABV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 20:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhFWABT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 20:01:19 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583DFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 16:59:03 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so193610oth.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 16:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BhbBwc//KduXdZRjlGjn3H8K+2RWn0DDN821jLw2+yo=;
        b=S84QglCpigVfDiOcQKNrdjgnYejdvh4B66yyn1lOBemGiQXgSuOf+rx+JyWiihJY0M
         zt2IwmZc08VQIAZ9hyjXC6OjB1Ljq7JsmH4DzzVCvLle9Vla6Gh5Fl0UiOMmirWgsWVl
         m+1Cs+IKhpQ4l9saUyPsdAJsaJx6obufkV3Us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BhbBwc//KduXdZRjlGjn3H8K+2RWn0DDN821jLw2+yo=;
        b=eKOK3xCGIe6r1f3r6owxwG5RT4m3aH/jubLioc+ZY9W8I7wAS0o6wKkalnhqt7XWRw
         dGdGZitBfoSYbkC+Fl1ZgjL51bkA9mA08TUlFrnLcIzO8kk1y6PkCMMJ7BO+jSGP+hUp
         r0MC+jGa/cdCY2gn599W7jGFejiwSi9ba3rtvbVoQXnQ2A5hr9TFzi8yCyMY7jjtj9RE
         WrFmZklHIZjNJF6++xzEbJ9vCPVGHY7P+UlKSoDMMPhZH9bONBgCHgIPkqK+2kR3oStM
         Cj9J1lYAlyU9dj9ToxlBtzx/0ZI5mZAYTgbBNZxArK8H1U6CzAm5byrOz0y7NRqAXqQ4
         wecw==
X-Gm-Message-State: AOAM530MFIEPvZ9EcFrwN4/NwgFEbv/5l5s14Kq001moM9CSwRWQ7zXW
        kGgW9LsYnW3Uu7LscJt97o2Zmw==
X-Google-Smtp-Source: ABdhPJy+PipDCUJZD8cIo8IcN+L4nKBbDX2YLhWl5ZyTYKUcXzKcR4NaFA3Xb/kfDsjHbAc8iQ7s8A==
X-Received: by 2002:a9d:354:: with SMTP id 78mr5247856otv.297.1624406342736;
        Tue, 22 Jun 2021 16:59:02 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c1sm207317oto.34.2021.06.22.16.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 16:59:02 -0700 (PDT)
Subject: Re: [PATCH 5.4 00/90] 5.4.128-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210621154904.159672728@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <620a40dc-9f6b-e3b0-664b-be53158dfe41@linuxfoundation.org>
Date:   Tue, 22 Jun 2021 17:59:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210621154904.159672728@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/21 10:14 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.128 release.
> There are 90 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 23 Jun 2021 15:48:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.128-rc1.gz
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


