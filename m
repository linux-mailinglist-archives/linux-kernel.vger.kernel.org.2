Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653CB442287
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 22:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbhKAVXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 17:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhKAVXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 17:23:16 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC01C061764
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 14:20:43 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id g8so21889038iob.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 14:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zoMevPyJdrYBIROPtkN6HOlKlyDL8HBD5E88Dm87gxk=;
        b=g2l9yeRFrB91L6CL9UO1GNm6NtPyLpKV/z/gFcEryoDYkJv9GG+rXYtAoiEDJ/8H9q
         1jQRpCYgLvQT3FWBlBVY13eWU0Il4UUegKs4+Wtv5kC68w1TUFuYwZD/pNwo0mh5oB0/
         iuRBeSRxhMdNQxbXc8Mn/HRushTOMYCDmuCOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zoMevPyJdrYBIROPtkN6HOlKlyDL8HBD5E88Dm87gxk=;
        b=Gu45LT+uWM7ZRZVngwctOH7eOsZeGoW8ULXJYCEfUr2S5reb44BONsAVuX/UJo8I0k
         kSJltzQBB03gQLcRY+EqyjAzsOEv5IpFyRw6fcJBHj/exnv2ky40rbs+ORpxO+IefE6t
         atRITQprIaQoxVg54FmLZ7xfZxckTdH4PDF50g8mA3ER51uMU9qa/poQquIFuNfXrlcO
         5DHK88OkbIira/eSm8qvu+xsLjwff46dOdHHCgc6mYmOuUZRTLzjVG/0AazXTiUe83vq
         GXXonlICs193+ISiKFaPlEw3JubJ9e/8R7fyykfC36y3ANnAVhGuW/w5eRqGiyUG18rE
         +M3w==
X-Gm-Message-State: AOAM532kp0MiCdhb/+ckPb6Tl+YZE2aycMKTxcW4raGjobOk47pO9reA
        udHytvkpsfcAWzcrJrl8kaafEg==
X-Google-Smtp-Source: ABdhPJw7BWG00UuE9Oq980SBDlh96drTz98spy25uqQpifDx/XGUzusdKNUs2p3xFEWFhCqNzus0/A==
X-Received: by 2002:a02:950e:: with SMTP id y14mr23122725jah.88.1635801642445;
        Mon, 01 Nov 2021 14:20:42 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r14sm8405817iov.14.2021.11.01.14.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 14:20:41 -0700 (PDT)
Subject: Re: [PATCH 5.14 000/125] 5.14.16-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211101082533.618411490@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1abb2653-075a-f279-d997-7b8587ef9906@linuxfoundation.org>
Date:   Mon, 1 Nov 2021 15:20:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211101082533.618411490@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/21 3:16 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.14.16 release.
> There are 125 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Nov 2021 08:24:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.14.16-rc1.gz
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
