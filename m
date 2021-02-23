Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9202D32332A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 22:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbhBWVUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 16:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhBWVUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 16:20:23 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1BAC061786
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 13:19:43 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id y202so18763509iof.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 13:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u63oV/IsVXItCVk9ZBbkp5bGddjxsrCAdUFEq94LYpg=;
        b=XN1ZNE/m5AhEHMFgT0dtR7cxUlPCHp2KHrIMcMtCpEjpXo0j2pqdF4s3t66+miGnS8
         KbMexGoFP0SiQChJ0zNeg0+cxOQpNeTrq0GvkU5K3Li+T1BMjdARF03KsdQeGwGu93VU
         snKhQTzp6ZVc6TAlpi4LUk1xuzNYepJUEgNNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u63oV/IsVXItCVk9ZBbkp5bGddjxsrCAdUFEq94LYpg=;
        b=b97XnaxNVY77dNt3InA7FGs/omg5ac30EKfc73NEvUGe+W1wK8nAB4QoKla8xJrqIb
         haalQyZM4rRoeWlaHjMRuTHarlSBQHVz0/ySxLxTN/BtFOZdlTGd0TOKomyAv3xVKZLf
         nIomIALf5IK/fwohLj4NzE88Yo1u1I14qF4kBzB0DaZvT7SaStZhUCijs9NjDbvX+8sv
         kSGXgyVg/VUwu4eoyGVeVIQmYHtE4XPhSV6nXf5CC+on2/gaRtnIEw6vDU924RRu2T5F
         ptLIVAOJG1pDrpywCiKXrvuI1OTK36Ohnkc1pnxPLtkwCVW5P8/pTov0L5kFlOdzcg7f
         JhxA==
X-Gm-Message-State: AOAM531S+5LchVyADiwzT/yrH0N7L/EVtKq4Qx6jlyLxWX+oEjrGXNZ2
        u5JtkuQDxXA8DKRPE5gQJAvd7w==
X-Google-Smtp-Source: ABdhPJz1MpjXj3WtzAQRCXnHLGHgCLQ9eeKeCAyyI2Oc9yxElKFJWtDsA+zINcPA7NlfiIYn3nPaiw==
X-Received: by 2002:a02:2944:: with SMTP id p65mr28839808jap.91.1614115182996;
        Tue, 23 Feb 2021 13:19:42 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r19sm20003ioc.15.2021.02.23.13.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Feb 2021 13:19:42 -0800 (PST)
Subject: Re: [PATCH 4.9 00/49] 4.9.258-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20210222121022.546148341@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <79f1a1e8-505f-68ed-a0df-8bad4767669e@linuxfoundation.org>
Date:   Tue, 23 Feb 2021 14:19:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210222121022.546148341@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/21 5:35 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.258 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 Feb 2021 12:07:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.258-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
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

