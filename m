Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9A83EDF83
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 23:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbhHPVxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 17:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbhHPVxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 17:53:42 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F202C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 14:53:10 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id h29so3497784ila.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 14:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7CIrFtnNaIDsfpDOFOm0ZVbPEF1sRclAJ9nGB5sECM0=;
        b=Bh4VLOHOHVp2Bc5njuRkcmRbFJFFOW7K/rg9l0uQd5UhPzmsA9lhPpUIFRWpo5VzSv
         +pO9nXj/365E4odcZimrwHNARzmfBt6TarK/PR4e/AijJQB8fiJ6jhXI7+95mx6xt+Pb
         +eXsg9wtHJwoNKC80gpofbnTd9FSRsEFQm770=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7CIrFtnNaIDsfpDOFOm0ZVbPEF1sRclAJ9nGB5sECM0=;
        b=cqwjDQf7ObxXHxsJMiap9+U1K7CMha3h21SW5hV/nTzN7fM5VtVJLcr3qpGmsKcXYs
         yKITc9JKgx4VAHlYTzRwqorxv6nsmvhSFtcZskYhM/2cZG+fWQtoSP4aAAo1pJ9npQp6
         eMlMm5dsGL5oFuYe3ItTuHsaggPz4vIOgVjpLQfsDNusiD2tib9QaAzZ60FBOYQ3W608
         je/UNRveJTc8fHGFIa2SyPmteKhKfOTWNjZA8kVko4COCuOA2FoFCEVhXlgL4Fkd9H89
         7F6nkhFh7KdCSH0W33nf2k8wr0l3jBTluNwWwagtnPx4ZPFEGmbP4Rzwr+s3edTXm5Gx
         lt0w==
X-Gm-Message-State: AOAM530E1NTXc2UWcNjc6e0WQteagtJklfOxd+JPl2FH9/M0sVigTAKX
        AKNsIpLl6iVWxDegnhGR2CElEA==
X-Google-Smtp-Source: ABdhPJy/fHwPa3SBSjZ9rmxdn739vjsV2cJLxZ5cgLnintIU521MjBY8Niu6yibxhDcFGWsClifOgw==
X-Received: by 2002:a92:d70f:: with SMTP id m15mr83002iln.162.1629150789723;
        Mon, 16 Aug 2021 14:53:09 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u14sm88200iol.24.2021.08.16.14.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 14:53:09 -0700 (PDT)
Subject: Re: [PATCH 5.10 00/98] 5.10.60-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210816171400.936235973@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ec6840d8-7e31-ffb4-74ac-bd7c5b1dd8e5@linuxfoundation.org>
Date:   Mon, 16 Aug 2021 15:53:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210816171400.936235973@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/21 11:14 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.60 release.
> There are 98 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 18 Aug 2021 17:13:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.60-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
