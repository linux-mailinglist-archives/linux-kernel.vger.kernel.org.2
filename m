Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451873CF0FD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 02:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358467AbhGTAJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 20:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350074AbhGSXvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 19:51:45 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D7AC0613E8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 17:31:49 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id j1-20020a0568302701b02904d1f8b9db81so421906otu.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 17:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zmZ0y16KpU9tqH6eNeRasdUun6lIcbxCmSbgaJY3WJ0=;
        b=ECQ7KIYdMa9HcLe01fFNykR3q0l0e9uyOofLpKbqdQ2jrxq3hrwJaEdG0ZpGNT1h4i
         aL6lWiY/reEdng9t/N3ZoeKIR9JzZq7r0pRNNN/p9QspLB2z+ZtOy0D1DVSlcNINp7p/
         8CW90j2iaw9rqsNpvyP6euLdScTNYDKYv5MS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zmZ0y16KpU9tqH6eNeRasdUun6lIcbxCmSbgaJY3WJ0=;
        b=TTXENCf7DmrF1RwxJJaECWlErS7xgp90TIIB17iuCxYi2gZVvku7O8WGhs6q5gWu/0
         ZIl0DajvsFLh2SEJvNmahmr17IKZqy5h+MaKS3CiJn5KwBfnCJHNZPANLiCeu4hyjpQZ
         yNYQdG8eRkFK9Ishql2YOVB76tzBGUR4IXQWrxUHoB4Mv/QKKOucN6btG+U5DWiSBsOD
         yq/Qtj2KOyQtGYgmoCCGH5qgMvK2ujY3DFM+8wnS9GEw+n1wKkOLeFRkoJ4SyM/foTr2
         PbalO9dfRcleVcSjAT+MjTb68Mrn5pI70g5H8XV+JyqSfeHnVB+aXHzMKT6myqKkI0zp
         IUYA==
X-Gm-Message-State: AOAM530ZK8a6q/GY7ejVgYhP3c9tkvyKx9GpiSgjQXJAMXMYQA/oSiOr
        FkWjeB2yG2BCGEmNSsK55QLSrw==
X-Google-Smtp-Source: ABdhPJwZd9PYNH8nWBLGXcjkmhShmio/KkpGGlr5wCTtHNFt4tJOA9EfFjGOc6/pBvkv+0+378C4aA==
X-Received: by 2002:a9d:6851:: with SMTP id c17mr6627193oto.89.1626741108733;
        Mon, 19 Jul 2021 17:31:48 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x20sm3941708otq.62.2021.07.19.17.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 17:31:48 -0700 (PDT)
Subject: Re: [PATCH 4.19 000/420] 4.19.198-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210719184335.198051502@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8e761ba8-9b02-9209-ec0d-9be79f840c5a@linuxfoundation.org>
Date:   Mon, 19 Jul 2021 18:31:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210719184335.198051502@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/21 12:45 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.198 release.
> There are 420 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jul 2021 18:42:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.198-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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

