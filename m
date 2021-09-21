Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786CD41363D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbhIUPe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbhIUPe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:34:27 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D877C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 08:32:59 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id b10so27634884ioq.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 08:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bL16pFILLI7sZq6nf10iD0lwwRn+opkgSs4x3jW2RD0=;
        b=PbleIqAmd7+YlbuCzKHC42gZhpjVsoOYXoFBA9S5yi8M0Bkx4FzAscIeiTFMxrWjjI
         btY5iA4HnxtNOEkYe/EJXsu3F33gYWdhegvZseojbPWon1qwyNZq0z1PzixoHZGuMQcC
         F+u+qh2E8FLXSgrdfQtzMAvUdxLt6/kvF21rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bL16pFILLI7sZq6nf10iD0lwwRn+opkgSs4x3jW2RD0=;
        b=M5G+WKWCod4F6alK4lkgJsngGTxyzm3NCo5/zCmhgc8N33/nh+yvsy0gZt7SnQQlZl
         FF3PNMLD1FirlLLkbO+2/SX6GaseVSH2BrNDktwxFO5wGB17VddEal99feOYWstH2jpD
         XO3QLynyCtkshP3l+Pzg1KfiQ3bHA2GgwyxDh5oNPcRpj/HpxrW3m3CCgLYwrBNAznNL
         WbO/5iMlV11dzguBolYIUu4d8eMvSZiDsqhOv+n+qmYt9E5hY2b9Ee1EQYN47OYmPJok
         b73F11dWKZs83xTY5/5+/LHMorIM+tdsD0N46sEE6jA3rbsLNlC3HdkoGKad9uJYueuo
         AUUA==
X-Gm-Message-State: AOAM533wYJYOSLZ+9DdsN7CZEe7OrgRqnVsPqdt1hKdUCg+KKT3H7YC5
        MjXqjE7pGSDJl7GlwF6CkBwAkQ==
X-Google-Smtp-Source: ABdhPJxRpH6XSJmMj8LRn32zn7CjdGDY3sHP6isGaL9VMOFUV6s3DAf+KXASBcueUOnxxp1dzH9JRw==
X-Received: by 2002:a02:cc21:: with SMTP id o1mr524451jap.110.1632238378832;
        Tue, 21 Sep 2021 08:32:58 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id p73sm7351075iod.43.2021.09.21.08.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 08:32:58 -0700 (PDT)
Subject: Re: [PATCH 5.10 000/122] 5.10.68-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210920163915.757887582@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f3a9bd3e-1e01-1a70-0c3f-77729f4b44c3@linuxfoundation.org>
Date:   Tue, 21 Sep 2021 09:32:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210920163915.757887582@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/21 10:42 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.68 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Sep 2021 16:38:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.68-rc1.gz
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


