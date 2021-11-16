Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0F54528E8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 05:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241110AbhKPEEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 23:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240779AbhKPEEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 23:04:00 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47153C07AF46
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 16:52:15 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id i11so18520649ilv.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 16:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GzOo5+lsZod50PestiKUsRLSwo+BSgSaswB9xMUzGjM=;
        b=bliEN3dBZC+OnBh8XSeqU/6dS+Fmzhm4BUHCFJTG0rQ2diDB2OwAQm8dBL3/8+//ym
         f3yZTNBHhh4qKSXtjWIVN0odqD6R1yDTlN4A26aj6aupy/hFmYmFQZJi865nKm6BwOVt
         sAE7gRVUVRWkhmcbdijaAOl4Fwj4uDGrjoc6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GzOo5+lsZod50PestiKUsRLSwo+BSgSaswB9xMUzGjM=;
        b=KM9MZCLWZmOX7O8AZ6pTxCxwvBe9e0E9j7SEBauaoPifMOtH2ButDV/14EFFEIVEf4
         9NuvmmUlrjgRlO2VS8V3bauY1vPOGEQyIgEVHoDupSeSUneOA6xnHRk85Ply06mNkfRp
         oE+7lpmzNYRzjFgJsVp28yD3or2ckLLzYOPANbeXdztcDWSQ4pkmGxjMMW7JKhIUXJvl
         EVl0OE6WpSknMgjUWGh80ABPnGu24TGFbE7SuIMFaTbIyu8uvrX4wGkPy2CXP5KxNXVU
         OSe9y+YwXq6Zy2Dljs0Fm23chdhBt9b06LfzwDx8WtSuYqNai8OFUOqoo5UQve/r39Yq
         nFuw==
X-Gm-Message-State: AOAM530viWL9NdDAcTutjLdixC+i1Qk/8pmT5jKmnUvH13WiMvCsLdi2
        xpiz6Ojliqqm6mryIZQui2/ouw==
X-Google-Smtp-Source: ABdhPJyn5PW+A+XcT8b8UVCVYQJY2FBOD3P7vA+t45hacPh+Wyp2LOjWF9NYfDCgw/pmPwtWoNztwQ==
X-Received: by 2002:a05:6e02:1048:: with SMTP id p8mr1931455ilj.174.1637023934737;
        Mon, 15 Nov 2021 16:52:14 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w15sm11275791ill.47.2021.11.15.16.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 16:52:14 -0800 (PST)
Subject: Re: [PATCH 5.10 000/575] 5.10.80-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211115165343.579890274@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ff63c8cc-bec2-7a4a-4da9-1293c02b65cf@linuxfoundation.org>
Date:   Mon, 15 Nov 2021 17:52:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211115165343.579890274@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/21 9:55 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.80 release.
> There are 575 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 Nov 2021 16:52:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.80-rc1.gz
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
