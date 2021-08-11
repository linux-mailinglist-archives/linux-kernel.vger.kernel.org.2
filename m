Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C943E98DF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 21:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhHKTgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 15:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbhHKTgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 15:36:06 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35544C061799
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 12:35:42 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id z9-20020a9d62c90000b0290462f0ab0800so4668279otk.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 12:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dLJ13OLJiK5cgt9GvddVZ9YZVCILSTnKVEEsy5eH4yA=;
        b=SIK9umf9LWQKuQwQIwUp5Uw2b8cDuZt/16JnB6hAOWrJ41FkgMu7/B9G72pL+uKEiA
         vxv21MKCZqS2wgIIz+6yAZ83WcDvMMKi93T3KHi6jCI/C0uwXnVZLsxCE2I+2Czi0LUp
         mJ11cypT7C1T5vU4FIL676QMceDBwacVpBczY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dLJ13OLJiK5cgt9GvddVZ9YZVCILSTnKVEEsy5eH4yA=;
        b=YqD6PlBp8uoHRRjhxCQ3lFEsU5Cy5bqkankZQ7UyDUDdnQjRVXQ/IO0E2UklQIeWQy
         NXwQV4Ru61n/uqG4AIfk+uvSsd06XVUvlctsmLVAHyyw3NKUETfBbV6Sb/JS55RZ6jOK
         hGPjOQSMC9Y3enXmkzKkcpH+6LiZWmtxq175evGaTAgKQivd6JZ2VYLDf42usxeU2ZqC
         Hv0+w5r0xPs37IDo3mnFesUs0AI6c3rj7Ux3XOmPLQ3GevuTiDB5L/OJSqoZfoQLLwBd
         jL9aIR4AT9zwcLT3DOW+hh0463okgKZvN2X/PWusZJWLt/n/gkPXXewfloamumSzTpB9
         Aqtg==
X-Gm-Message-State: AOAM5310xlpltQPCPh6KfP0fABxrJR7NotGDgwO5nN+bQrZCxHAoy7AO
        mPcmlo4tl111bfKdR1lEkXVwEQ==
X-Google-Smtp-Source: ABdhPJzMwUDOct7uNA0wcu787Towp66h7lpQvJaWChQj/Oxy9S04eZpkagkaFX9WP/pCtnZ+I7NvJw==
X-Received: by 2002:a05:6830:4d7:: with SMTP id s23mr449111otd.31.1628710541454;
        Wed, 11 Aug 2021 12:35:41 -0700 (PDT)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id p2sm42121oip.35.2021.08.11.12.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 12:35:41 -0700 (PDT)
Date:   Wed, 11 Aug 2021 14:35:39 -0500
From:   Justin Forbes <jmforbes@linuxtx.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.13 000/175] 5.13.10-rc1 review
Message-ID: <YRQmiy5xJUekIbB3@fedora64.linuxtx.org>
References: <20210810173000.928681411@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810173000.928681411@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 07:28:28PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.13.10 release.
> There are 175 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 12 Aug 2021 17:29:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.13.10-rc1.gz
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

