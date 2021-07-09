Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091D93C2B6A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 00:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhGIWeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 18:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhGIWeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 18:34:11 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE2FC0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 15:31:26 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 53-20020a9d0eb80000b02904b6c4d33e84so2326578otj.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 15:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=upnsK0auCIcTjX2QtwPLQv5a6TArKtIxfo8S37Wtnfs=;
        b=Qft4v/xwBCfQcddpia9jMHw5kKnmLVllVM3y6HuoDlppu5J2Ni8Fd8PHGnXdfWdTNL
         NhWvJHzGzaZJKL3XioV/TUQ4PHZJIsnexyKu2vP5L1zUffD7lFef+rCAOfXVcmOc2XfX
         K41/iQqEwSMif1obLWxAmgbGfBN8jzZYl+fuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=upnsK0auCIcTjX2QtwPLQv5a6TArKtIxfo8S37Wtnfs=;
        b=lAHktNtc0vBIUAA3MBm6FQN0WDx9fZ14+3XjWgO0qScBhsb7trlb40CQi+r9SM9kGL
         s1ozdnyNcTSa2d9UHbLWlu/nuokl98RCQMdRKYAVotx5XZR9TT+k9191X1nDT3p+rxII
         V3fFulPAbED7guaRl2NJDknq1n3M/USgB87p27LmatIzAqmBBRseBsqkvVOPdLEaj6Aj
         u4HdR3ZO+JzMVz0uwK0oiv/TC2I60jhb4FTGIJwuwRicFuyzlf+4G1rFpCMRuJDcX4+3
         +VpmL8iVqUca/90Y+x97R39fWD/rjD4wS2ypFkcpnq2AGaNWqX+4V5sXNJs265TeaKHC
         cUcw==
X-Gm-Message-State: AOAM532Dxem0LPt+/zizjGwxXoy6SKOD7Q/m62GJQUVFUyVjjOGvhDiv
        rYQ7ZZXDtIl5NZczF+ZxlnZ7rg==
X-Google-Smtp-Source: ABdhPJx1FIPZQPmZES91xkjfzCpLwt8JsT5qoan7BcrRjah1PiaY+zBPiZqvGYZJ/JEOj0zXxU/svQ==
X-Received: by 2002:a05:6830:2487:: with SMTP id u7mr27068811ots.48.1625869886226;
        Fri, 09 Jul 2021 15:31:26 -0700 (PDT)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id w15sm1459523oie.21.2021.07.09.15.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 15:31:25 -0700 (PDT)
Date:   Fri, 9 Jul 2021 17:31:23 -0500
From:   Justin Forbes <jmforbes@linuxtx.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.12 00/11] 5.12.16-rc1 review
Message-ID: <YOjOOxDbRF34EXke@fedora64.linuxtx.org>
References: <20210709131549.679160341@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709131549.679160341@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2021 at 03:21:37PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.12.16 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 11 Jul 2021 13:14:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.12.16-rc1.gz
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
