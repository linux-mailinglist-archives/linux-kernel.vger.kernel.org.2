Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B2834DD71
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 03:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhC3B0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 21:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhC3B0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 21:26:25 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D42CC061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 18:26:25 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id f5so3921617ilr.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 18:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TCQToEaPk7wziftb26RMDBcSiURdsQu7+MzspxXjaNI=;
        b=ZsTZwny4hWbrZD7G444M9tf5+HC1el7W6USU/6S+baHwJlGU9N3vdcttRNNxDOFSSl
         MK2rIN+/fKFlI6KqCnYzC6KtJwtPAl6+OQU3pgL8vh2dVcrmQob2mgO/PkQ7ONq9GsEe
         koxOE6+to5l0pR8JzW7v4uP5cjBZdGUu1SQPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TCQToEaPk7wziftb26RMDBcSiURdsQu7+MzspxXjaNI=;
        b=HjFCXjty4SesSqG7DOrNplj4WqUp7SzukeeS4zE7QqSu57cG6NPIiXHRy98+IXl9lo
         AeaYPeBzFKycZJf3hGZPBS7k6qQm6tr6r2c9wIXnz2uQY+M6qWJPEATxai0IRUrVWw6W
         t/CnEczA8hAj8Ssxt3J0SjZ9F+QKDGVgRroA2KiPyh5LYkYnppHGTk8aWFPQTLqiAJGg
         ljpY3CHfssWe612QUfSUOcyUnMvwj6SVQQwo674s2p81dD6wpkySDPO4ROyF4FBIu4/6
         OeIIBRN4urqQdHZ+aQ6LXbE1Fr9Za/2Q2bfymi/1fDFbs98YgcND1VaACJkb4ylvk/SP
         QBLw==
X-Gm-Message-State: AOAM530N7s6KZoV/VP229TTkojXuONGf8g4ttJemr6EEY0cje/xnAyXG
        SbhYc3KuqVVIcmUkd4dgCCT6nw==
X-Google-Smtp-Source: ABdhPJx6b2XHKssQIs6smF6PX/rVJagueOEIMUyyUwlhMdBfOiNZLz7F41Gso0PMj1sKgDGXwB+G+w==
X-Received: by 2002:a92:b70c:: with SMTP id k12mr17846091ili.156.1617067584965;
        Mon, 29 Mar 2021 18:26:24 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z10sm10543363ilm.19.2021.03.29.18.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 18:26:24 -0700 (PDT)
Subject: Re: [PATCH 5.10 000/219] 5.10.27-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210329101340.196712908@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f9605c7f-fbd6-a669-149e-6d0392797eca@linuxfoundation.org>
Date:   Mon, 29 Mar 2021 19:26:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210329101340.196712908@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/21 4:14 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.27 release.
> There are 219 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 31 Mar 2021 10:13:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.27-rc2.gz
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
