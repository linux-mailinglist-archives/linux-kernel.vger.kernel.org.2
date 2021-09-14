Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4865D40B432
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 18:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbhINQJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 12:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbhINQJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:09:45 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CB3C061762
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:08:27 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id w19so19667958oik.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qlzi8X+fHynAZe5knqS6ngFanCxQAZ6aTwOuu0uysUk=;
        b=cZS0cmEcIKL92w98fkjndCHE20YN0nwdIQJ5SEE2/JoT/WBiFQIDM6bOjKcVZaoc0w
         iwKWMvk+qF4zQrTkuddHfOJy4GaspVwYBtIYs8YErM3lMG1A3u9FGXodZPEyWelejV8r
         d2zCm0ARoxj+dWhnSpkyWREof32qwfNkQz7Ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qlzi8X+fHynAZe5knqS6ngFanCxQAZ6aTwOuu0uysUk=;
        b=6h8KFiJGHLPbZiYb3IlFt0jS9b1WbZiNPQ/vPkvRlE1dAvcfGqMOAy7oDeN16qZifa
         V3y5Yt7YOAjU3EGQDgsLlRCc17eEMHj2l9aAx3QPvrXdIyUgSo2kbHOlG6SuVKslGS7b
         U87akTSyN+83/x0tP518CgsDOYNfB5gwcdbKttYRH+aP1miXeWaj+zBnkXaI7N+EE9Yp
         b8rJXsa8J2XWvSHVb4NT8XTj9OsO/k+edi0PflBkKCSf2qveq2hpdCd5MklTNiwnt7vc
         NtSjkbAlr9O1OADi0Og/iwk37bEbPw/iJ1JRTqHV9VeoZ8imT0vXUjc5U0pwYrvlYmsz
         cWJA==
X-Gm-Message-State: AOAM5327aj76W8+tlXkj+xB41HmUgNnjAzvqS/fFLeGpBBn4K2wIwbNJ
        BB+RKXWU2IHwAz6+46tPdMg2vQ==
X-Google-Smtp-Source: ABdhPJxURUk077VNA63apO/42cIWMjGJjy+jmOG1cz+LQV75UmFUwY2fo5g6PHUcpauYb6Ma9g9/Zg==
X-Received: by 2002:aca:1c13:: with SMTP id c19mr1993929oic.93.1631635706967;
        Tue, 14 Sep 2021 09:08:26 -0700 (PDT)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id u15sm2783243oon.35.2021.09.14.09.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 09:08:26 -0700 (PDT)
Date:   Tue, 14 Sep 2021 11:08:24 -0500
From:   Justin Forbes <jmforbes@linuxtx.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.14 000/334] 5.14.4-rc1 review
Message-ID: <YUDI+NHVB+cEiLzc@fedora64.linuxtx.org>
References: <20210913131113.390368911@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913131113.390368911@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 03:10:54PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.14.4 release.
> There are 334 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Sep 2021 13:10:21 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.14.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Tested rc1 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
