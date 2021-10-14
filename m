Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBD042E44E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 00:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbhJNWk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 18:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhJNWky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 18:40:54 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1679C061753
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 15:38:49 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id b188so713756iof.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 15:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z0DR1ziaZ/jWjzBisu0A6kzB2Fuv+t/u1aPTkoQpiOg=;
        b=eZgge0O6dRky7f4BfOHPbWprkd9ePMW1nwq/lxMMjnBFR3PC8IQ0WHjJ5DIoon77GF
         i+h5MPc4j8mHTtG2LSvtMTua1JQjwtsfHuzf+H+XizkM/7fvkL62KPuWiprn1CexYx7K
         7QSD7OphLRZitRbe1TLQ1ZfZT/nWf0H9VQwMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z0DR1ziaZ/jWjzBisu0A6kzB2Fuv+t/u1aPTkoQpiOg=;
        b=6jfVyboj7JxU+YrEkvxT1ed8DgAp4yxL8p/my+SO89T2jWsT4r5JSS4oOs2nXKNyAS
         Y864a8OUQ0vzk8yWY/+g++98slaV+zX0GUzXKbLMH5Go9EnlVU85TaHkV3X6Xmko5LZl
         9/r5oMUYa8z9lJRMBOiulZcmXQYT6b+S3we2oYwR9ce7erhVFaa+HrqYG83F9b0tZ0sm
         o/7fTNqMeegSWRvqZMIHAi/saZoUMapkzF+NbO08hNVLHnCKudmdzHLfYuX46TPC8acY
         ogTpOamGLAdUcQkVD3LNz66ZTxfBsO4HGTIKo+SrFq+tZ7fhZHAZrUDovG/oveaGJm90
         WAqA==
X-Gm-Message-State: AOAM532yShwl8Ufaxo3CoUetP+0MZGTNNBEtnv9EWpauOrXlGLp2g1Zj
        xLKVPlC9SSPdzAErN562frqA/A==
X-Google-Smtp-Source: ABdhPJyek8Rw/rz6GBBriw3qfvzV/iYW7pMNJmcaU7YWpeSJLRYe7Z+mjL5yTCvaffpSpYTBPsu3ZA==
X-Received: by 2002:a5d:9d82:: with SMTP id ay2mr1259403iob.128.1634251129137;
        Thu, 14 Oct 2021 15:38:49 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y5sm1790839ilg.58.2021.10.14.15.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 15:38:48 -0700 (PDT)
Subject: Re: [PATCH 5.10 00/22] 5.10.74-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211014145207.979449962@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <df6c9903-7370-57a3-80a6-05a94d04f0e8@linuxfoundation.org>
Date:   Thu, 14 Oct 2021 16:38:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211014145207.979449962@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/21 8:54 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.74 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 16 Oct 2021 14:51:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.74-rc1.gz
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
