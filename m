Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC5E42FA9E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242444AbhJOR76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237774AbhJOR75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:59:57 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F33FC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:57:50 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id s2-20020a4ac102000000b002b722c09046so3240451oop.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7ZGon4E8dSNWz8zPVVd4qTwSTJg6X7vbKHakOYUSXlw=;
        b=xVjIrZSY1ag4v/ZBhceOcmQPenpzdo3t1prFDjt/fGbsKpEG3DCwePoR5FT51zLL/Y
         U2FKdELYTirUdSrsZMXbnirst5GT49118+Ttxk3cAqm/9mD1Znu8+GQ4Izni3oE/3ZBr
         +shxCn6al5v0zALGnP+KrnTHD0opfhaMVFXNT3QPrUMXKRx5qzAQ9XbUpNHzDpau99Mc
         OD7vg5ofO+Af2bJ7F5n19LF+rsJ4kTU/ROy6VirZ8qh2siGgQZMMemrhEvTvASV62vTA
         OmyWnZ1sA5iU819zWoSm4MTxiZ9gg8Db0cv0MpSVP+XkmtKS92VzwEfwttEGWyRiWb1U
         kC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7ZGon4E8dSNWz8zPVVd4qTwSTJg6X7vbKHakOYUSXlw=;
        b=SRBTn5bPnMXkqOcTWH1v26SmDM9R32pO3X/XTgEvTV3JaMnikCikVxosXhVZZDCfWB
         XVzubYYz+33PVD4x5kbZjkfyKC06DDUav9mNB0+TngIb3IcIAi4ftT5cG8HAwQ9ZV5Zf
         4g2WQJTVQvEpM0nI71ZRZIMiwa7U9+94iPz5BlbqMFaWz3ShDeGThBRcRItbKYhQpj0o
         bDzwquX8oo7wz8YPY5JhKmm06eigxcpolKxP8NTk881Lyggm7TYx/px56c4xOEqr+D5/
         u6chDxWfGuhoNrxt1LTFWSQhxzfqKGlvO/xlcdCFPduPF89JWD1+FADIG9W/+CCZp9EH
         8HuA==
X-Gm-Message-State: AOAM530TRP3CCahTr7/exIaoxsb0369e0TjgSU1VG4q9Tk8JFf0i5VPn
        LQSfgdO2YHEF4TYxj2diHfAhAA==
X-Google-Smtp-Source: ABdhPJzaqufkmD1MuButXMwA+z+yrJMNNHo8oysa/oquqHG/SC/na8Pa0W8jjLdFtlg12OCfWHm70Q==
X-Received: by 2002:a4a:d5c8:: with SMTP id a8mr9560596oot.18.1634320669915;
        Fri, 15 Oct 2021 10:57:49 -0700 (PDT)
Received: from [192.168.17.16] ([189.219.72.19])
        by smtp.gmail.com with ESMTPSA id v5sm1329020oix.6.2021.10.15.10.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 10:57:49 -0700 (PDT)
Subject: Re: [PATCH 4.14 00/33] 4.14.251-rc1 review
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, f.fainelli@gmail.com, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        stable@vger.kernel.org, pavel@denx.de, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, linux@roeck-us.net
References: <20211014145208.775270267@linuxfoundation.org>
 <e1379685-c2b7-e7d3-8829-3a9db2e53bf7@linaro.org>
Message-ID: <1ae5fe8c-598f-8c78-2ee3-24fcdd566c9f@linaro.org>
Date:   Fri, 15 Oct 2021 12:57:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <e1379685-c2b7-e7d3-8829-3a9db2e53bf7@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 10/15/21 12:49 PM, Daniel Díaz wrote:
> ## Build
> * kernel: 4.14.251-rc1
> * git: ['https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git', 'https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc']
> * git branch: linux-4.14.y
> * git commit: dc0579022db410506fd874cd458c580df7f09db3
> * git describe: v4.14.250-34-gdc0579022db4
> * test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14.250-34-gdc0579022db4
> 
> ## No regressions (compared to v4.14.250)
> 
> ## No fixes (compared to v4.14.250)

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

Greetings!

Daniel Díaz
daniel.diaz@linaro.org
