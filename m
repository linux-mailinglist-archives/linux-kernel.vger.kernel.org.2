Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3391645C8C3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 16:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241195AbhKXPhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 10:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbhKXPhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 10:37:09 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECEBC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 07:33:59 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id w1so12278097edc.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 07:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bqdy2HwxAM57gqyODn8plZfo9eD0lB3qkfbcuNYfcg8=;
        b=nhcCKtCgns6UCVdGy1m0lnvLkFL64LlxL+wuM971cNyAzyZx5bWFIRxf/xI+2SwLVD
         5fkY3F37gP4s4ZJEeHEmSp4ONH6zbGLC65oDql7egG/JlYAvbijiSSeZHNMNlYBn+LDA
         6hnZo6NQnMm4XMuYsxW2lxrI/x0bzBjbcRaIuj29YUkeMUyZKnRulHTyeYklurS4YWZf
         OVF3j5IWhE1v1KqNmpQ6FRNXsgd6/d/1zaf/fua2Tkhr/XEt2bHJBzHZgrScr7Yvm/gz
         xwe2s2DooJIy9rX2V1N7NnTLPLaVvyHarB4fVQ0pcW030KrkWqE0VAkb6oCSFMUNzomQ
         N9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bqdy2HwxAM57gqyODn8plZfo9eD0lB3qkfbcuNYfcg8=;
        b=EYS+cHUvJ/Rk9BwiNKr+tdET+dUWTMmj+hjXcVqdeaHWhML3k+kcaa3OZLQVpL8Q1X
         iUTrsSptbCXPAQGE+Nm99uYUu2MJPJU0cQ1c521f+dS3WGuxN59p/yP2+ICvxPvTUovC
         Uuyd2ns9A2gl26Z6esyXQrK3c58lE8KL+mU9mmrF5RtoKXMXWui2spg4UUoaAp+vaaj7
         c9SoABW2AGkgqi6CIh7sT9C9cEqwgaDR9nw/JnhTIwmGFybISBl/Wv9pgClzuVPFY3C0
         OIj/rl3LhTQuEjsCDIFKUYa4bdMlElc0/p5u+4l/XsEjK/dYIDM5xo94I7kVZfgvp5bS
         haPQ==
X-Gm-Message-State: AOAM532p1oSQMWl/dFfAAxzMrNe1PCaymztwzDrGYOU7pdBJKw3ts+Ul
        NcVmKV1w4f8s4djvHJ8QHrFokwOL1hBhn2dsvIhFeg==
X-Google-Smtp-Source: ABdhPJyxVvYyfWLjSfk0lklRT3neqnyZWMKWUnhVTAd7lHQohE9ZcH3gUHx7zsl6YW5isIhQ3In/IjXCD0pmCNO0GsM=
X-Received: by 2002:a17:906:489b:: with SMTP id v27mr20892553ejq.567.1637768038273;
 Wed, 24 Nov 2021 07:33:58 -0800 (PST)
MIME-Version: 1.0
References: <20211124115718.822024889@linuxfoundation.org>
In-Reply-To: <20211124115718.822024889@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 24 Nov 2021 21:03:46 +0530
Message-ID: <CA+G9fYt4wOWx5fEkMdYmT0JO+G5+6KBgdDDS7oS_2ox8X_JF4g@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/323] 4.19.218-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        f.fainelli@gmail.com, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        stable@vger.kernel.org, pavel@denx.de, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, linux@roeck-us.net,
        Nadav Amit <namit@vmware.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021 at 18:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.218 release.
> There are 323 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 26 Nov 2021 11:56:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.218-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regression found on s390 gcc-11 builds with defconfig

Here it is reported,
https://lore.kernel.org/stable/CA+G9fYv+SjDwfvP=Zgf-gr2RngkrzHO_w6OQzH7wqzU-dOW9+g@mail.gmail.com/

mm/hugetlb.c: In function '__unmap_hugepage_range':
mm/hugetlb.c:3455:25: error: implicit declaration of function
'tlb_flush_pmd_range'; did you mean 'tlb_flush_mmu_free'?
[-Werror=implicit-function-declaration]
 3455 |                         tlb_flush_pmd_range(tlb, address &
PUD_MASK, PUD_SIZE);
      |                         ^~~~~~~~~~~~~~~~~~~
      |                         tlb_flush_mmu_free
cc1: some warnings being treated as errors


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org
