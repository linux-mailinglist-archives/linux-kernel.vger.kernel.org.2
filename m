Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FE63B4CF1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 08:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhFZGPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 02:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhFZGPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 02:15:12 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD4CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 23:12:49 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id gd24-20020a17090b0fd8b02901702bcb0d90so2512287pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 23:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z3D1KelqTQqcByU+iX/g4zMb1AQ1QyzDSkN4oTccG6E=;
        b=dPYF37dHsGEYSEl9eqOPnMnSYV23hgoNW6zFFCEdWj5Q1w4OSIZ374aV2gk9AR51sH
         4QhogOUV0JirtFhghh4Sx4J7XwTYVMRFXKsFzP6gdNmxkPDTn6w8BfKYRi8dFTN6JbSf
         hBlzTMo6KZE2D3sg78jc5Rf9MdUxh59Adb2yQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z3D1KelqTQqcByU+iX/g4zMb1AQ1QyzDSkN4oTccG6E=;
        b=FgzglP/rOtgzzSpQ54VC5jb6jd/wTPw+MgGifT2Z9zdHi9TTvJakzW1v7+gH3wGf7D
         KPKV/h4McvRP5kBw9kguqoUDcVOur52QNuby8AXVsn4Y4yBntmYg/Ef6bh6ZYjk5v9Q9
         7JbCVgRSN/LbUru3Q14uAV4yyTxdWaHVtsropno63Cs7v570IHPEzA3B+Gb2AQ+5MZIY
         C9/pblRHowfWO/dDR+uDM/Pzj7qutOLPyw7SgYwi1G+4U9odavshFfagvOaij7UYPESX
         jw4Zldr78uPLWHKyCNmDBG5E4JtI2xaBXPL2dF23H5pv8wlbcZ3sILuv9yr7QFrIKm6W
         mdOQ==
X-Gm-Message-State: AOAM531FunMxcd7uDW5Z2VWzVE+3gXEQ7KqJbe0ufYgFhfW2fmYhCIVW
        W93fikOicnHa+MTcpv9DRxuDDg==
X-Google-Smtp-Source: ABdhPJyf87SbQDubTJ9J8aMC+55dXrh4eLcutSx+3zpg0JmnRltlhc687c4pmI8apq44mFLXSlbVNQ==
X-Received: by 2002:a17:90a:194a:: with SMTP id 10mr24743998pjh.188.1624687968729;
        Fri, 25 Jun 2021 23:12:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c24sm7895781pgj.11.2021.06.25.23.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 23:12:47 -0700 (PDT)
Date:   Fri, 25 Jun 2021 23:12:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Laight <David.Laight@aculab.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        kernelci@groups.io, linux-kselftest@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>
Subject: Re: [PATCH 0/9] LKDTM: Improvements for kernelci.org
Message-ID: <202106252311.14501F2F@keescook>
References: <20210623203936.3151093-1-keescook@chromium.org>
 <030c022b-985a-16eb-b9d7-73b6fed2d5a9@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <030c022b-985a-16eb-b9d7-73b6fed2d5a9@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 07:22:01AM +0100, Guillaume Tucker wrote:
> On 23/06/2021 21:39, Kees Cook wrote:
> > This is a bunch of LKDTM clean-ups to improve and expand testing,
> > given feedback from testing at kernelci.org. Adds a few new tests as
> > well.
> > 
> > (If a pull-request is preferred, please let me know.)
> > 
> > Thanks!
> > 
> > -Kees
> > 
> > Kees Cook (9):
> >   selftests/lkdtm: Avoid needing explicit sub-shell
> >   selftests/lkdtm: Fix expected text for CR4 pinning
> >   selftests/lkdtm: Fix expected text for free poison
> >   lkdtm/bugs: XFAIL UNALIGNED_LOAD_STORE_WRITE
> >   lkdtm/heap: Add vmalloc linear overflow test
> >   lkdtm: Enable DOUBLE_FAULT on all architectures
> >   lkdtm: Add CONFIG hints in errors where possible
> >   selftests/lkdtm: Enable various testable CONFIGs
> >   lkdtm/heap: Add init_on_alloc tests
> 
> Tested-by: "kernelci.org bot" <bot@kernelci.org>
> 
> 
> This whole series was tested on top of next-20210623, here are a
> couple of sample results from KernelCI staging:
> 
> Clang 13 on AMD x86_64:
> https://staging.kernelci.org/test/plan/id/60d4a5ce3d2bc535d924bf25/
> 
> GCC 8 on Intel x86_64:
> https://staging.kernelci.org/test/plan/id/60d570711a3d6beefe24bf26/
> 
> And this is where the series was applied:
> https://github.com/kernelci/linux/commits/a9f4387015268e426c77fd51ed846c9756938828

Fantastic! Thanks; this looks great. :)

-- 
Kees Cook
