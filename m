Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD96F31A281
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 17:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhBLQSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 11:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhBLQSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 11:18:36 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4454C06178B
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 08:17:51 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id q7so9857478iob.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 08:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I5XGBMiYVQzPYsTEVpD7TBz8M4HLFi/2UW8Cw4sEt0Y=;
        b=cYKPviOydegN/kHFa2i6yCF1k8L0YPlYfj91gu7SBk6rNQRJoWtrRX/4MsH+pvKNWY
         NOaxK7kadAElp4ux9hkxi01kO+h/F3mvnZ5PNB3dNwFGKx7XjWroBbX51tODfpSbinzi
         0F3f3ycBJQkohQcK68VjwWxJA3i0q8sd6cqQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I5XGBMiYVQzPYsTEVpD7TBz8M4HLFi/2UW8Cw4sEt0Y=;
        b=lHHiuaiiw5lSpcN7aVQituafIuG2KM2RkxW4nscEyeyRpnpB+U1XDr9bPB5ExXUIqO
         kfbc90VZ/xLsXdYXTq/+65+I5/4FuBDFF1uTnYmnM02Oh+EPaDMFnaZELpwAFndlH5ef
         GUs4sSyX8PuFOjAWuClACpRDd/h7s6asdJYHBqTFS0K1ZW3z1FDGxjmS8RYUwBdn7sDB
         tToA6Hxc9SOgjTCRUiDUYImF53H2vEIwa0E+AIpswLfBTortpAQxV2ss3RPYavXBSkxa
         w/vVOfoGdxKjyrYaDxgIclUeYhUjp1kUM0bEQuT5H/NdtAVc5P48bcGkeyFhfJoH5B/R
         fmfg==
X-Gm-Message-State: AOAM533p1dBRjRSJ44G8oPLmENPvOzNlG50M+hkrI316Hui0XBBSFQj7
        UhrugPefJiWh+MgHhnkEJZ+oyQ==
X-Google-Smtp-Source: ABdhPJxPN9dpp/xtJvCyo2ncekeZe2AsnQp52XshSoqNihLUbHnMJDfUdZX5h0jrXrfdyIzp2jAHRg==
X-Received: by 2002:a6b:3b53:: with SMTP id i80mr2635182ioa.203.1613146671191;
        Fri, 12 Feb 2021 08:17:51 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s17sm4370146ioe.53.2021.02.12.08.17.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Feb 2021 08:17:50 -0800 (PST)
Subject: Re: [PATCH 5.4 00/24] 5.4.98-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20210211150148.516371325@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <31e8e4c2-cfce-3e24-0693-2246767aa8d1@linuxfoundation.org>
Date:   Fri, 12 Feb 2021 09:17:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210211150148.516371325@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/21 8:02 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.98 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Feb 2021 15:01:39 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.98-rc1.gz
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
