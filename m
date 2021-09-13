Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E70409DEB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 22:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241312AbhIMUJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 16:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240230AbhIMUJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 16:09:01 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3C0C061760
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:07:45 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id g9so13790408ioq.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xrSjRouShDxh+cd6XLeGxO72TkXUz58vPuKNHHgsT2M=;
        b=fkVD1OVQBqE5rue2HNLdLXb2O6GomcPIbu1yCsbf4XiAXGO3u38T+b1ZDzyivogyhn
         mihR2Z4w8F/zgPdtvITK14y65ok/se+sstNSG+IjuHK3KO+QTvvYWN8+is/gvkzCvb0U
         zBBabR/npj1jzXSu/EAXo0FJTpZs3VAnDVCp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xrSjRouShDxh+cd6XLeGxO72TkXUz58vPuKNHHgsT2M=;
        b=emBRI+2hGNfshOInOu9X2XazZk9WvxWXutEHMc+YDJ5B4EZ0HiqQVvCkJMAMEL4sbv
         35r0O4XaqNIcYu+MxS3blqxM7DlKX1P7d+I+YoK6jt16QQBbt+OFh9YfG6NI7JU/HH7I
         5JxKHfcGraszxDc9iYN8ziW5pd0hCGpXcW0Eko10ZUi8NuohUxk0PMxw/B5F7D7w/Ltz
         P9zcpXjKuaiyvSgdnLnHOKM5cHW6AY7dnLmyym6jz/u7KeyfRs935y1NtBQ9T6ug/QoF
         KdvhelP4Tk9OcwdNa/rczrI9J6UYG/NG6YKuN8JZ/yVyqkCmd4uSb0igoIaF4vanhTzs
         kAgw==
X-Gm-Message-State: AOAM533qUYQibL+8Zy98BC3TgAwz4F0ciE9h0i8me4w5RimOMOiPqn7m
        SNdMVl/7YS6r/yiPaeg1O/Sf6A==
X-Google-Smtp-Source: ABdhPJwA1tbFlbu7nAMGCFjmH4dJumFGRQZext6NRWKa5WClpGED3Ez/93YY45oGsKjMnQ/lqc1TFw==
X-Received: by 2002:a05:6638:2191:: with SMTP id s17mr11386371jaj.87.1631563664862;
        Mon, 13 Sep 2021 13:07:44 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y15sm3938706ilc.32.2021.09.13.13.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 13:07:44 -0700 (PDT)
Subject: Re: [PATCH 5.10 000/236] 5.10.65-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210913131100.316353015@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9c65bb97-7996-f018-60fb-8112c871ed39@linuxfoundation.org>
Date:   Mon, 13 Sep 2021 14:07:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210913131100.316353015@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/21 7:11 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.65 release.
> There are 236 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Sep 2021 13:10:21 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.65-rc1.gz
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
