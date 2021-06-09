Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81683A0A52
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 04:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbhFIC54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 22:57:56 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:38815 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbhFIC5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 22:57:54 -0400
Received: by mail-oi1-f172.google.com with SMTP id z3so23710295oib.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 19:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CO+LsH7d9cfyl3RY3UHmP44EdIbBjX1g0aWsb1i4cwM=;
        b=MRDJO/sDB+2ucNkIhDb3MFiuH2t2qYs+7qfejNx/Hwjj3KRj+Vds3vvf/L0CQQ4USv
         TykJpLNK6hoL5nGdcgJiI7JU1Y7souVzS4DxcQN/qGIEwH3Q4YWNUQpVTlnoOGP4Sri1
         G8fcog706PliAgUbrMMhB4HqXZmbdP/guyxAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CO+LsH7d9cfyl3RY3UHmP44EdIbBjX1g0aWsb1i4cwM=;
        b=BnWSNFLB4/2dquZZbDc9HzR9yJJvJ/ktYrW4QBHEQiHOawa/plr0BQ7MXx2X8iuD8O
         yJTljhRL72OOyG+cOl9C0AeKzTaczBt1QVGRaHenObFsKeMVlMttr2G+Dc4NRUPdS4qX
         YrCK5QDUMfaH97tvTNsTNaLUP/fTy/treeG90rHpZtWTw7hkDA/XVg8DRivz9Ht+X6xZ
         1Rri8e4yXXnxaCS3+6kd2yUci8rUWKYF0otTbVE1fPezEqI7fTQnv1JlhvIPDbVYHgV0
         6EMEzaPUCov7cHIs5EDYv3wErS7kAWvj1ztpFVmnXRIMmhnxr99E0TllvKQlaiIcQ3dd
         mXLg==
X-Gm-Message-State: AOAM5325slT1qLu/OBzHqzcoPamCrwnFbsQ1OCg+D+Kc1XDXqkYvXT9Q
        RKnX7AM+MvW9Od1yQmTzdLg5XA==
X-Google-Smtp-Source: ABdhPJzHSiy231ihTVnssPr+IxSm3wFV43iz4hCuisshCI+YxuOPBzSwKwUvFz1JXwS3+cZeO1RWMg==
X-Received: by 2002:aca:4d3:: with SMTP id 202mr5028934oie.9.1623207287589;
        Tue, 08 Jun 2021 19:54:47 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b8sm3531371ots.6.2021.06.08.19.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 19:54:47 -0700 (PDT)
Subject: Re: [PATCH 5.10 000/137] 5.10.43-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210608175942.377073879@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <04f9d9bd-dbc4-483d-8294-71a920ccf01c@linuxfoundation.org>
Date:   Tue, 8 Jun 2021 20:54:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210608175942.377073879@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/21 12:25 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.43 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Jun 2021 17:59:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.43-rc1.gz
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


