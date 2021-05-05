Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4893749E3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 23:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbhEEVHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 17:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbhEEVHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 17:07:02 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F5AC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 14:06:04 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id p6so2368428qtk.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 14:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mefZcb1pNDWUeUshjW1gdp4/6sJZQmHB9uptTn/JTsM=;
        b=b/yl1HCmwF+IovbU2KdNTFUYQKvomccBdoOy0h5igW+Jfj/AA8JhuY+byu9fokqH+9
         0uV570RfkmRKTQ2YVgSuVbPMH24L9RXTZC9HvitdxE8oMySv0+WeJxU5BndioS6YO4SQ
         2irO1EYhOJ4fFmP8J9AxUshpvjExNnFsRHIFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mefZcb1pNDWUeUshjW1gdp4/6sJZQmHB9uptTn/JTsM=;
        b=WKJw/5L6wk1OjSFJ26KKJ3RkEOAIspHcpfEMxC75Gp5PmD0xfajYJpoLyGxpGrpFe4
         VogVmINZNZhAhQstRRe6Zc0uwBzi1LrE6SVDU47OmchitTBQ+9VVOzb+qBnpNdD9jbbp
         DzOssZYCTsveZjDKH68lOTj3j1+hHGWsnyOJ7TOSeU24LAmTzkIPptZLgkaFm6RM+YQI
         mrFNuh7Ckh0F2FQRYvC0dA9EKds04+iM8b+/AgxyAuCy1OTZAEHfpgGkhbfvPB1W7Uv7
         4mcsaCyK08QvDUBBqOdO2zVmyuN0B1xGL+moyz3BrUp7Oy+RQjaK/NVyiNX2/w/NSDqK
         U76Q==
X-Gm-Message-State: AOAM530au2bY1qJWAaDM6SvKiuy6KEMdTaQZFFy6bf8HgeE8tHG98FR8
        5KXljXEVQpwYv2QMLHZw1q74vg==
X-Google-Smtp-Source: ABdhPJwwDEzSbkM/2Qq9tzFSoxDPmWMGdSygadAbYCrcOaVOYbR+UEK6FRlWHF1GGdLJF51vD6Inlg==
X-Received: by 2002:ac8:6909:: with SMTP id e9mr576403qtr.338.1620248763926;
        Wed, 05 May 2021 14:06:03 -0700 (PDT)
Received: from [192.168.151.33] (50-232-25-43-static.hfc.comcastbusiness.net. [50.232.25.43])
        by smtp.gmail.com with ESMTPSA id a10sm442040qtm.16.2021.05.05.14.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 14:06:03 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/15] 4.19.190-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210505120503.781531508@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8ee68f50-1300-bb0c-3f87-4c6bd5129b3f@linuxfoundation.org>
Date:   Wed, 5 May 2021 17:06:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210505120503.781531508@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/21 8:05 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.190 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 07 May 2021 12:04:54 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.190-rc1.gz
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
