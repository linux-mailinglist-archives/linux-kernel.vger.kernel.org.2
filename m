Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F9E3549B3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 02:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243000AbhDFAaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 20:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238058AbhDFAaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 20:30:15 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C904C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 17:30:07 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id c24-20020a9d6c980000b02902662e210895so12525428otr.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 17:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9wPz/0R6k2Ggjgt8hXGO+XHYLGtpOuoz08N3wBP9Tk4=;
        b=MvtUmQyBN2iQk0LBkOnoUnvI6LZqkMVgd/prDR6zylDuXZuyFQezD5QuX/UzCEldc5
         5kKc9TRxX4mh1iIolZse5QcYN9Q7p+oZUIfrWQp8JC/BCoKTIbxM6pdDW2LKALdHFBNw
         6duj7FkSrJ7EYlI4RSDVzBWzadLV+ymjEiJyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9wPz/0R6k2Ggjgt8hXGO+XHYLGtpOuoz08N3wBP9Tk4=;
        b=q42xI+MqcSSUw1vWqEl6cd1tDJkTO65LpIDtkFcVjaVOSE2Qzqnfg5eBNss6pwjInI
         MdbxrWezSo/6fCcNlEdtpRbY6Kx+Y3bCa/SV3hM59eBih/Uplv36dCBaFBoUaFrKcXv3
         0FAIa2552qKbw71/s/zSOVcl/fR2QSAIra9eqtz+01d+yzZUvb/MjIunHEGSymaZF5fM
         v+vITfPfaCQhfUSgjhBgR7P7Fw8e6aGRDNecQTUx/hJNerQsYc0VKqgR3vgWq0KCmx5N
         HvVINh3rif+L5gW8+wI5KylKIqw+gpragchhzUp23YqgXsyJP4RY9OQfvm7S4jDDE6Sw
         3btQ==
X-Gm-Message-State: AOAM532qyPKizMmA++DL2ZSogQ2YSpvFT9n9Bnj0jXQ6LvBzNfLXxPv6
        degwaZdrmpLumodlUsDwUL9itA==
X-Google-Smtp-Source: ABdhPJxpYM2UV/i+c3ooZd4Y6u6kdBfEJM3VdDfNSWq+pxePP0wlP/cYguomdy0FENHIHxQcvvg25A==
X-Received: by 2002:a05:6830:2336:: with SMTP id q22mr24576682otg.346.1617669006501;
        Mon, 05 Apr 2021 17:30:06 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id p64sm3430963oib.57.2021.04.05.17.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 17:30:06 -0700 (PDT)
Subject: Re: [PATCH 4.4 00/28] 4.4.265-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210405085017.012074144@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e022cc60-efb4-815b-279f-c0278c9cfa6f@linuxfoundation.org>
Date:   Mon, 5 Apr 2021 18:30:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210405085017.012074144@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/21 2:53 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.265 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 07 Apr 2021 08:50:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.265-rc1.gz
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
