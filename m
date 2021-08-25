Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE1C3F7EB1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 00:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbhHYWhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 18:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbhHYWhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 18:37:18 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EADC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:36:32 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id v20-20020a4a2554000000b0028f8cc17378so303862ooe.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d8md7ioYZl9GV7mUuUBl7JQ1HgtGE6JeFMZVVYUrQlE=;
        b=P3ATd0JJBzQZXX/5e5ilkz3BqMtt6o3CSmeqXM26MOEEVP64SS21zDRNyFtbgP+vhg
         C7fkoT3XOXwVgWEU7HgimEYg329WdtfG+gtxtLJ1O/KqhtdyehPpAuwIDhgnYHF5rwaT
         e69hoGQ8sBwGWiqoVolV8KmozEZADsvrJ3iQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d8md7ioYZl9GV7mUuUBl7JQ1HgtGE6JeFMZVVYUrQlE=;
        b=Rk1Mne+PbpjtKtwpEanRnLM6S3cY7jsbyk5vSvbmbIG4KW5tp4HQdA10QpjzZl2QdD
         KEaM+KgsBn/KQ68Au76osJe8XfsyBpLFLyUmSodyap8uGozb64CNrEko1ichWST+KiHK
         xojBuCptyfPaa88WSrQ0AlHfjRrfiiJG9pKfG1GkGZhcmyF9dWsNKdNpn1Ub8I+z45lC
         5OZsnTisyc2SECeeDzL5x29Umt/CUQyZ+SVr4NGWAA2VUxYzJj/9oAehER7Zo7HvQWF7
         c9aKvcz5dmIEKLYFZLlWbL2vPTLXLLco3iHmvoMANOUuZ9xmJbFAPrJzEaC0YdLdnXmm
         OoUg==
X-Gm-Message-State: AOAM532X81NIXu7Y15dZEeZ2dtzQ6K9Rng0bwxujgZUo3iwJndKCDvLa
        mA/R0JqTD0lQPm9gHlCcP+Jg7g==
X-Google-Smtp-Source: ABdhPJyjs/F5tqdOl3OP+JcLmmpSKoJm97EzhRwdA3KuVcrO7rvAJDSbkDR57GjxS3fnk0ZTHwo7tw==
X-Received: by 2002:a4a:94e2:: with SMTP id l31mr508751ooi.62.1629930991873;
        Wed, 25 Aug 2021 15:36:31 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a6sm232791oto.36.2021.08.25.15.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 15:36:31 -0700 (PDT)
Subject: Re: [PATCH 5.4 00/61] 5.4.143-rc1 review
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210824170106.710221-1-sashal@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <290fd199-2d38-30f9-6430-3c97308896d6@linuxfoundation.org>
Date:   Wed, 25 Aug 2021 16:36:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210824170106.710221-1-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/21 11:00 AM, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 5.4.143 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu 26 Aug 2021 05:01:01 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.4.y&id2=v5.4.142
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
