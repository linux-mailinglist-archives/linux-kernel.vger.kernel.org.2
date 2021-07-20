Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCDCA3CF0FC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 02:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355444AbhGTAJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 20:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349794AbhGSXvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 19:51:45 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112B4C0613DE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 17:31:11 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id j1-20020a0568302701b02904d1f8b9db81so420697otu.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 17:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JOBhjWKj1PUbCW6WLaow7ILNU4H/kkQEKISBPfj9fKE=;
        b=LMU13zUA9UzHpb9GsAQt5iZB1jBm208OpQeIMrOTGT3/+vxy5Q903r9OaZrrLclNwO
         2CJZie6vyXj7oh5e5KEm7Yr/h3akNp9D4w+SlTitD4UDiyAclLteQ6hVDeOQp8TOEs/V
         tlzMC1PX4KTyFBkfcefYNVhkwzilmrvH0a8pI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JOBhjWKj1PUbCW6WLaow7ILNU4H/kkQEKISBPfj9fKE=;
        b=YLbmGlRe03ldqIRp+uYAN3vNNNJXoSmKPJ2b6qYiFpcdC3HRVsh+6XZ59pouZAUzcm
         ULgeu/4fhnfGr+9acMe0DBpuh+RTWqava9IFap792sSfr3CnHRYmpue/dNUcR37KtMeJ
         yHc8ixlUByOJx2AigDh63b3fFdvZrP0PQnP104Y/AjYUKDwFQjrc4qbM37cfXAmKB0Ry
         Ucpi9FHCUXCbswJMgNza2fm42FhqTiYm81TbnKvTNucQWAO/MIfdzgea/Gao+YZ3DhWg
         3+Fj2TJoAf1QLgu9tXzTctI2WLdESRhgZ4UnLa/70Xkw0Hfm9tZWVG4Wm7UoV6CR7Onx
         rr2g==
X-Gm-Message-State: AOAM5305BloOGLb96Efx/APwqfn7Y+JLG7PmSicZq1Av49ipRbaGaqpD
        4Gaq9uxs0CWDszJVUJ6UEjRHtw==
X-Google-Smtp-Source: ABdhPJwuS2ziddGiyO1Dq9gJlVeHTI5occ9LTE7SVfwmtOPNsAdcPStTPXn6UlV6ynlk4RFSZguc9g==
X-Received: by 2002:a9d:6848:: with SMTP id c8mr20540159oto.364.1626741070468;
        Mon, 19 Jul 2021 17:31:10 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w27sm3759018ooc.17.2021.07.19.17.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 17:31:10 -0700 (PDT)
Subject: Re: [PATCH 5.4 000/148] 5.4.134-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210719184316.974243081@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <daf4f023-4e28-601c-bf36-b54e9eb95284@linuxfoundation.org>
Date:   Mon, 19 Jul 2021 18:31:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210719184316.974243081@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/21 12:45 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.134 release.
> There are 148 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jul 2021 18:42:54 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.134-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

