Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156813C2AF8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 23:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhGIVqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 17:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhGIVqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 17:46:51 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18216C0613E5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 14:44:07 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id u11so13980205oiv.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 14:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NtJKIdAw9icG9Nsajry4Foamg7xSDmE8pPvjonOc6FQ=;
        b=EdjIlc92MffRg7Yia4brOr2NIudRy+iU6UMoTAiDq5f8r/D95NtaAQFkso6MSdW3M9
         UZoJIHLyMl13YYqaWWgNBI02wjlvNLZR/Injz0+OKdI72rNYvTilbQXxsujjmhn0YO12
         onvHIURQjbGuhP6UN3ESrfyXyACSQcky2JqD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NtJKIdAw9icG9Nsajry4Foamg7xSDmE8pPvjonOc6FQ=;
        b=bp4vqNDe+3PHjcQpoyIehvzvXx5P37y+4Gwa+zhVZ18TwvXbRtvjrdfciagDJr33E9
         00/J2eUWLMbO5+eRNnU+PeV77TdAoQx+8fMXsT4snOXkFyqZ60Jvaoz5NB1wzUlQumeT
         v81yyH+dDLkN1YJ2XROQgVwGQ1o2L+oBpTHc6EfnPRKYotgaGb2QoibeC84MbhwKWhs4
         iPva5AFTyKT3UKv3sl2Q9V6ELqiphIDIZRUUAtrmBp1gqESW7Gbc1D1wKYVrO4E0Xk1e
         AUGF+wiK29qQjCRFDlm/RWVf/k3CiNx9icLyUPpSs5GhDYgI0rZRRVo4l4TtVsBwDZIv
         Nkeg==
X-Gm-Message-State: AOAM531AmVnDsioyMVM5wPNmSuwz0aGNj6n8nZbtXy2SjVyBtPYv/DfI
        EqOf9D5Re4RH1JgclS4tMeHvrQ==
X-Google-Smtp-Source: ABdhPJy/Zv/q/WiFzlN9R6YUz9my2iBR+anwMHQVCk/dUyHPWwPcZo8STwZMTO4sAJ+EjktepWvPHw==
X-Received: by 2002:a05:6808:b14:: with SMTP id s20mr770475oij.101.1625867046519;
        Fri, 09 Jul 2021 14:44:06 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x20sm489834otq.62.2021.07.09.14.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 14:44:06 -0700 (PDT)
Subject: Re: [PATCH 4.4 0/4] 4.4.275-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210709131529.395072769@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7cb2531e-925b-60c1-31b0-70b7a1b9b77d@linuxfoundation.org>
Date:   Fri, 9 Jul 2021 15:44:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210709131529.395072769@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/21 7:18 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.275 release.
> There are 4 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 11 Jul 2021 13:14:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.275-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
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
