Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC723A1E47
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 22:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhFIUu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 16:50:29 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:35641 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhFIUu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 16:50:28 -0400
Received: by mail-oi1-f174.google.com with SMTP id v22so26492079oic.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 13:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vag9/8FGjqghdTKqiSl5++HoCdqg8Zzpy0nJ6KQYlnM=;
        b=Gk46LPTsRJwhdO4Mq0mczuTqy9D71hvSrzLmzsONzqmFveakXEoJbycoXHWqyPOADE
         ZawIb1zHD43HYqE33YpUBKQ+3haAmnTaD4DaylWOc8sb+0BPey4ntvo59kOmdawm1u+3
         ReJ3sl72BAv7W8zyQtJ3L1mwzrKsul9pj98Ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vag9/8FGjqghdTKqiSl5++HoCdqg8Zzpy0nJ6KQYlnM=;
        b=UaIwHOruCq0zPJMzd5ApsLDg7NdvxZlwF1A/3Ouu9OcOMG4jW5JgwiI7bzhJJh+vtf
         LsljOkiSpWi6U67Q1x0Fo2cDIIa6Dz3ek85/OIUGjWWhR2Blhc1Jh1KkbUt5nNTESm2T
         6nUMdlMFOo9okDfdd7eh9SLAS3yx5JQ3yby+v2PH/kVfEo+QbmowUTt2G7jfzC2O94u5
         NyHHxdybSJ/+jTJIp/+0own6WsdRKi5qKVa6O+vf4Lxgll/h9UkyQu4d98mlnQlM+LdI
         Tu5ECSiQ+Hqetfd7YcHkTBTV6Pp6nk2GJy96GD6Q3AHI8T8e2aAVxtBJ15qBvslG/52v
         cKjg==
X-Gm-Message-State: AOAM533k2YFYy4jtTn9nYjjTN8IREgx4Poa4wiy7YTn0kslRObGuQzXY
        hmbpvplzd9RCTrSjOJ2s6js6J+o91/kREHVs7Ts=
X-Google-Smtp-Source: ABdhPJyCT9ck33g0zuGnxXSHtj1f7rz/k3dKU1Ck2ttC50/KWazu1v0WwUj5hUl/9SGgavMOVzoz6Q==
X-Received: by 2002:aca:4bd7:: with SMTP id y206mr1020458oia.40.1623271653388;
        Wed, 09 Jun 2021 13:47:33 -0700 (PDT)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id 22sm225896otv.8.2021.06.09.13.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 13:47:32 -0700 (PDT)
Date:   Wed, 9 Jun 2021 15:47:31 -0500
From:   Justin Forbes <jmforbes@linuxtx.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.12 000/161] 5.12.10-rc1 review
Message-ID: <YMEo40AhQipABk3u@fedora64.linuxtx.org>
References: <20210608175945.476074951@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608175945.476074951@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 08:25:30PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.12.10 release.
> There are 161 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Jun 2021 17:59:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.12.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Tested rc1 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
