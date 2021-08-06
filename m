Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9539F3E3224
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 01:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244296AbhHFXpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 19:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhHFXpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 19:45:23 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9F8C061798
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 16:45:05 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 21so14370627oin.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 16:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7uDg6jFLvRkTYq8x3SnFRVInhxVHK9HGR6FkEOQKiKs=;
        b=R+A0C3YPwgKvSK8Hsi4O1qoXS4Kp+O94WW3OMP0wmPQQ2kichwFUD0aphj0FkkJEoJ
         olo4fsFhBKcaZfSozG1+zX9bdir8PZt7o40lZFkILlYzTX0VXThfLlMzZ2ez9QF6HPlN
         9s5R1qAV6ZXSGQbLX/jbfZpmixfU6gEK+ZlnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7uDg6jFLvRkTYq8x3SnFRVInhxVHK9HGR6FkEOQKiKs=;
        b=Q2RW0qD0nu+mxJGzxBWo6Fz5xV97j0qmwvOKuvRKJCE03knBq5G8FjGkSG9DKTHYku
         wpGG3LSMcsJIUurUUp2dpIwJ6nlwx/vMu0V0bjAzEKaQsyiWsqXgrrZR3pQ3lEP7Iz8u
         PiNLzjs44wCD9LxI+qsBeAAhOKcYDIoU8UB++MQY93EowzyvmCtuPKyvhu7Nn5bBHdYw
         vBKQdMs8fn8Ho5aB0JvM7NCniaarUTqB9C7dwH4RVPUI9O62hIzh9cNmN/ES5O690jXC
         7rTam+PIcbwdnYBNlhXEuW3/YwO87d1CcxaJ7xR60khK1OYNsJDsqOA8nJ1dEW7lyXsV
         EeBw==
X-Gm-Message-State: AOAM530tsUK1W6P4yYFBbnnIDpGWaBYMWddAe/I2C4d/THdhOrN19laG
        OEcA2Aho9YwxJFq8TIye9/iZhg==
X-Google-Smtp-Source: ABdhPJxOOmdT/lEM6Bn/i403OclsZVFzhjFz1B5+AqyXOkIuRQsiMiSKyz2H6CwkvjKUH87d4DD/4w==
X-Received: by 2002:a54:4705:: with SMTP id k5mr4554118oik.71.1628293504972;
        Fri, 06 Aug 2021 16:45:04 -0700 (PDT)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id a23sm1760821otv.79.2021.08.06.16.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 16:45:04 -0700 (PDT)
Date:   Fri, 6 Aug 2021 18:45:02 -0500
From:   Justin Forbes <jmforbes@linuxtx.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.13 00/35] 5.13.9-rc1 review
Message-ID: <YQ3JfvH1r1yTzKlc@fedora64.linuxtx.org>
References: <20210806081113.718626745@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806081113.718626745@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 10:16:43AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.13.9 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 08 Aug 2021 08:11:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.13.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.13.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Tested rc1 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

