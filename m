Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8A1429ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 03:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbhJLBTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 21:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbhJLBTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 21:19:15 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F43EC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 18:17:14 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id i11so18949931ila.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 18:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=22UDNeDQRMRsf4J6KSBgPECViTea6fN+IAAnb/JuSlc=;
        b=SjLODv5Jn/O9FzbTwh1WCfNXMTx0SIj330RMvgLmpATICkOY08usw3MJe2TRwMiee5
         g0ZfL5EOuz/bZ1EHOQxZxz58QBQxqbeEfNWfNkUnSzVEINgotLmh3VbinnfosZFOmr+e
         st0IEwpqZ1RvsGokrdYU2F335rZwayYGmRw30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=22UDNeDQRMRsf4J6KSBgPECViTea6fN+IAAnb/JuSlc=;
        b=GtdE2QpiewxywEQ4nlqDrCPwQ41hNTw5yfjD+FnOqvgTaGbqVdjPeD8UQpmnb/fbHz
         ty/L0CHW3BjJtKKDBDIDY452I67JeKZW4EoOXpm1bskJt8/oP00W+ZqNq56fkVidnwrJ
         L0RETd9A+yckoKN/SDj6Xwo/dLxiEy5L5LKl4aLoJbhcxbnVCLU4daMWau6jocpew5rH
         PPXChSqaQfTAX5+U93Xp94bGL2Jqr2MMPVipEy+jlrgKItL2jsnsZz7g/UbWzrV1eb+v
         B7b1Y5ywk7d0kHpyXrD4MLwN+eTn1eKYe0Jsl52gXKcVvMFFvyvH08By6cAddP/n6qGe
         ItBQ==
X-Gm-Message-State: AOAM532aLuTvjw7zx/WUHBZy9GORI/4fL8VjuOKcNiXjv9EaqwTxp7+G
        LaU6qsLlNM4VW27N+Ej79depYQ==
X-Google-Smtp-Source: ABdhPJztuTgkv9nhNSbSOJTSmjyAOegunllGZPDp0IWj93zJDJF6pG76UysWYHEQjVpN/zkdSHvNmg==
X-Received: by 2002:a92:c7a1:: with SMTP id f1mr4210756ilk.263.1634001429616;
        Mon, 11 Oct 2021 18:17:09 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l18sm4596634ilj.12.2021.10.11.18.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 18:17:09 -0700 (PDT)
Subject: Re: [PATCH 5.14 000/151] 5.14.12-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211011134517.833565002@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a4d5ca5a-50f9-bf9c-f39e-6d23bb543fe2@linuxfoundation.org>
Date:   Mon, 11 Oct 2021 19:17:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211011134517.833565002@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/21 7:44 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.14.12 release.
> There are 151 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Oct 2021 13:44:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.14.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.14.y
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
