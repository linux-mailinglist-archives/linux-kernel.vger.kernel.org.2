Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537433BDF78
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 00:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhGFWrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 18:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhGFWrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 18:47:15 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63581C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 15:44:35 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id j12so433573ils.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 15:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ah8H7xJBllOpFH6dhVLuUDUqST9fWV1SaPDsst0DPE4=;
        b=Jhu0OJ7t9HeDfOpwojeYJ85Zm/K7lbXmzvMDmLn3axcMph7IY8zMWNTpXuLhJ8Hcxg
         lawQmjkx73QhvmCHOvvChSdsCVOd0fN8eNJj0cFODk0PTU3zKt1eG6AWz6NE/37+vT5a
         Hnz3fIXPveYYcmteE97P2C6HssNbLHtY7/tqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ah8H7xJBllOpFH6dhVLuUDUqST9fWV1SaPDsst0DPE4=;
        b=WE4jMgYKD3B2ruafagQwkRvEBx6jnddgWkCJO5SvmJCYRP3J1NtseaGiI1u1IE5f6J
         gUgvtAJMjNrXzaofMbu63UPYfCjuzsaKyM4ff/0PaeXrappIp0NaEXxOmrjEILz8Sd+2
         kQBaHY7TatZhVRr84LP4gARw3C2y5lHNHBrgP91QapHemZA5n8NyFv2yI7ksd7/e/aNT
         1F0HxNWaTILEUNwOD8a2lNs/d3kujlt9fjOGzoz3ns0k/LU3OSuo2ZcpapCjXTxkC0MC
         KMiLYmFW1t7waPj7hOAyrVY/5dnJsCAuGJ15L2iu5W5SciIXtrTq0mi4vztUcKv4n25+
         Dktg==
X-Gm-Message-State: AOAM533v2RFn0ABH9I0ZLrWQuyFCSwaLtl38Lz9dRs9eUbs3pr03zemV
        T3Pr7RTCh+02bMGcXcbBWP40Og==
X-Google-Smtp-Source: ABdhPJy0G48xTxvkntwpR90zm7b8S85RFeJcErLwAlUftDR39Zh/0soQDY/UtPcsDRVeqZ4lkekZdw==
X-Received: by 2002:a05:6e02:1a2a:: with SMTP id g10mr14245312ile.204.1625611474883;
        Tue, 06 Jul 2021 15:44:34 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i7sm8658237ilb.67.2021.07.06.15.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 15:44:34 -0700 (PDT)
Subject: Re: [PATCH 5.10 0/7] 5.10.48-rc1 review
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210705105957.1513284-1-sashal@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <81c00c09-92a2-55de-02c0-6bfc06d60b03@linuxfoundation.org>
Date:   Tue, 6 Jul 2021 16:44:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210705105957.1513284-1-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/21 4:59 AM, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 5.10.48 release.
> There are 7 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed 07 Jul 2021 10:59:49 AM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.10.y&id2=v5.10.47
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

