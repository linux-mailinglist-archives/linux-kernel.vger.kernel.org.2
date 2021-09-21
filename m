Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2831141364A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbhIUPgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbhIUPgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:36:32 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A364FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 08:35:03 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id h129so3369153iof.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 08:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EFKnpS43fwn48BD80tHzZxeIwy1O/BCN+n8xE9k5iHg=;
        b=KtKzvbyZRsnagBgftd5f+xfvX/lF14XDK30YObjwPMQDGsV1L1Hj94HP3FAC7JvUff
         dlEP3Mwd10Z66ML0ycprIPNmf/iZjnCgwLkJJdyzb5CN0DH3ZREbY3nVi8OJUUUFaT5b
         dhvA/w0nPsoUOqLtRO+16K+Xy4XN58DPZx+Lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EFKnpS43fwn48BD80tHzZxeIwy1O/BCN+n8xE9k5iHg=;
        b=SWSXSjiInwJWynWKDlKT8JsXLXyP7PWaS00SzPmmEKDwMB2duWyz6qp9zoqVJwPdMy
         /weDjdXXBtKr0G7I2McDDsi7zUHcbWxC5xlfzgd95MKB1pkpJAFiCppn0hZuS5hldhJW
         8ve4qEl5HKxbfeI0G+N7fWLUcfc3Xw8up3kHpFf1z1FJstjJGlgMmWn8v8yU+x+F/0uX
         dsiPwbCaWQT3W5CyUpiEXu8Mdwsg40aqO6DYBIoEYrbLNSeP9xJpW5zSI/ftgwraWanv
         7w6sgo2szaumralZIPCnfsuRAt3Vbu/id/dK5J3eWs3uzm+z8ge4DUow+WjXwtrN/4tc
         3bDQ==
X-Gm-Message-State: AOAM531sFt8mop/evyG8mNbvfeebwbWVoYqzHM+7Hv3r+8HheVns4Smx
        i6X5FR+v4oK5H8sNvTFa/8k4hA==
X-Google-Smtp-Source: ABdhPJwpBBfnWbHAoTMtpkNQb+f7X/bZUtVRuCdDstbI1Wd8oU7BjAL1G5IzR1cDhs/R5wV0EO1rxg==
X-Received: by 2002:a6b:be02:: with SMTP id o2mr473498iof.103.1632238503098;
        Tue, 21 Sep 2021 08:35:03 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 3sm10548696iln.79.2021.09.21.08.35.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 08:35:02 -0700 (PDT)
Subject: Re: [PATCH 4.4 000/133] 4.4.284-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210920163912.603434365@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <56a3b451-e971-7b49-db5f-9e5955f1c688@linuxfoundation.org>
Date:   Tue, 21 Sep 2021 09:35:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210920163912.603434365@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/21 10:41 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.284 release.
> There are 133 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Sep 2021 16:38:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.284-rc1.gz
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

