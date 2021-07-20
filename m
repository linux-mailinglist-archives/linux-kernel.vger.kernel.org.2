Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B069A3CF0FE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 02:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377481AbhGTAKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 20:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347299AbhGSXvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 19:51:45 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7474AC061762
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 17:30:39 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id a17-20020a9d3e110000b02904ce97efee36so8276527otd.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 17:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JBEFIV0XL2J68tzt17US2OdqB56YyMOePx3AQtfIwJQ=;
        b=K2blgaSIjlMuyqQGzioBpYDipFPjiHST190MEURx0Htl2v0Glh/2sm6Xas+k4y0MTt
         XkYsgt91nO+Dtp4+4ZFfKrPIuDN7cq78PBccpKsZkfpGEI4TYIGQsuDyvTnCu/z2IPww
         6Qx3qHiHeRVHLJ6OLYm6lRkcK/DlbDQBYH4So=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JBEFIV0XL2J68tzt17US2OdqB56YyMOePx3AQtfIwJQ=;
        b=CC72xit64PyoFflofJ6HpgxT4bceghPFq2mCnHkYnzALXwojpDVAGAzExL3Ikqwnlm
         THZgPTytzifE6zMy0u/dE9od7rJVcoUKBNKvV1mSwQV0R9NS7qHp/XuQM7om7dPTK4Qs
         Iarv5ZznK1134nIP8I/nzM3E1NsFaIXI9KWTJoIXUSY2z962Q4BLJ52RA7lNZ4xM5LBG
         34y7AsXeUP4jkpT9c6rklf27Ah7cwEeIluYq9YfZH9wSqMPvYsLxKb7+YK5/pTULFPyO
         +pKKIQvgXn+yIc7FZnGHl1dVkBbWnLTAnBHOjfa2vPBJJI03p6tIsL3qEPmi9bx/ueX8
         6cEQ==
X-Gm-Message-State: AOAM532gzfGBNsF2fLCasVq0BxopJbEvblbGOX59bXrB8uG9yFJA/Su2
        wai6pMAj+bzkWI1pWamb1AGIrg==
X-Google-Smtp-Source: ABdhPJwUWlQaf9ATPmJ2XgrLGFvvJUSa1/b7u9NQyC+EtY6EWufREDttC8UEsNFuar+wDv9VbIXIbQ==
X-Received: by 2002:a9d:650e:: with SMTP id i14mr20409210otl.233.1626741038873;
        Mon, 19 Jul 2021 17:30:38 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t16sm2928410otm.63.2021.07.19.17.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 17:30:38 -0700 (PDT)
Subject: Re: [PATCH 5.10 000/239] 5.10.52-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210719184320.888029606@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f04cb3c7-c4a1-734e-d640-6f627e5e812f@linuxfoundation.org>
Date:   Mon, 19 Jul 2021 18:30:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210719184320.888029606@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/21 12:45 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.52 release.
> There are 239 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jul 2021 18:42:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.52-rc2.gz
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

