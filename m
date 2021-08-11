Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6DB3E9AD7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 00:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbhHKWVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 18:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbhHKWVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 18:21:02 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB05C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 15:20:38 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id h63-20020a9d14450000b02904ce97efee36so5253387oth.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 15:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aa5xJRw1QAPbyZ/ewtMuNqZfuZMoN2uMDlkGv7HDM2M=;
        b=D/3OYhFA0l+yYIFmZvk9DbrhT950ye/RVqhsbTW7ILaQtsW2jqO4i2nFrO4ZYpGSRn
         xOpL74L6UGA94deZVuhiz3yJnPKRqoLYB58bDrayqyWNtPIKwLPBkPJ+QQoPO5CYhMsJ
         IANsJOlpCC2xRvi2HA8nfvauLJVCCOIGjfd/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aa5xJRw1QAPbyZ/ewtMuNqZfuZMoN2uMDlkGv7HDM2M=;
        b=tGq6eHHMp7LPmOmYpK3p/vz+Cr8hYV1vu/+lCUoJpWZCwqgncUxuqQAJmau2lEpoU/
         6gfJyVJ21J3N6/lZV5u6zetv2y6SZ4k6+Nrs8cZOrnaJQ5fzPBAbo2JwnC0kjxkDmSEE
         sovaOkyVeEIJyvzpXo0nEJga2T+k0l35cnJFdAiB1wP12GO3AliHYxoQo3iMsAnpd5rI
         LxFZVMe66Zb+f7/3toY/DTAT2oNYqG5J9xVhhvCATaNondCo64gW0gLcJ+vAbY7/2IEe
         xsT/GeFVoxZ/5lpxOGwdRbYxKw3aSteyoG6lH7pn3RQ7p6wxi1Vkt6/eVYCNakhVARL2
         HAjg==
X-Gm-Message-State: AOAM533D+yxNItGccba/YgQXU9aQ09VjY1clBUZk3XwtL0xsyQyABLFv
        hpjFo0kyLVyMoTLzZe9JRAdHTw==
X-Google-Smtp-Source: ABdhPJwzeQo6SSGMV9d/qMDULl9DGYIjVHyKsolX0R8n/9l/JcLvQXbmSgKJeEKgCyIXz3dF5nPRQw==
X-Received: by 2002:a05:6830:40c2:: with SMTP id h2mr946160otu.56.1628720438130;
        Wed, 11 Aug 2021 15:20:38 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l67sm204669otl.3.2021.08.11.15.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 15:20:37 -0700 (PDT)
Subject: Re: [PATCH 5.13 000/175] 5.13.10-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210810173000.928681411@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c7085eda-4ab7-3e48-575b-c21c95381752@linuxfoundation.org>
Date:   Wed, 11 Aug 2021 16:20:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210810173000.928681411@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/21 11:28 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.13.10 release.
> There are 175 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 12 Aug 2021 17:29:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.13.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.13.y
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
