Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE8732BF6E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835467AbhCCSDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382004AbhCCPWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:22:04 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29546C061761
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 07:08:37 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id l12so30384997edt.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 07:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ma0aLe7L7wfc2EcnaVyjvoNiREEF5DORKFdfo+QCWX0=;
        b=CiV7tOZtuvuWalzzsFt6r7jq9QI429v5CtstMoU2Mlw5gsHzio9Rdi9Qei8nTJmNC2
         UZcMSJ7vOAqYq9RgLfGs3RhYh7LrMX1BZzm3Sa4DMjNAiSv2ZCQsYT903mkCoAsC+sc4
         d1Vufc9PByAn6O+VJVCeDzkb2+8QUuI1j5ZcwGfusUYjAfllOENS5VATrJREFRKOFu2r
         KxptPp7mLsOK/kAr5hZUQSijC08U2vc1uT4CwmpaSuiidh/nHwiHMIicJlQxuD2jJr2x
         KIdiWAxX8hjn0hNs5jFDrf1pOJC4Ax/D1L3mFKLy42aZPIVMwoT19c7sqvR73vTjxlNq
         Swbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ma0aLe7L7wfc2EcnaVyjvoNiREEF5DORKFdfo+QCWX0=;
        b=VIaJBWmNpYuuOCRzy8UJIsMs0n6GaOsa2DgglIZ6N7NMwKmRaxJ/tkeckoDGY1LaCA
         SFNi5WBZF/LDLYk/5YysiTELMVb5tHJGRgX8A9itIjFKJ7qzJQaGS73drLwSKJ0ophpr
         OQ0A56yE4lR6rfrTQ6UzdP8BY0YFNucOaRB8KMaNAztE9B/rtFtp8WY3tjCjxRbLrfv9
         ylbm6t/dObFPDOxexyFOo8OwkuPn4gXn1g2VKZcOHHeAKUAZEqj/jT6IXkTorICzxvsb
         JGJRzjGr9uvEHOgFKklIuOJ/QYRs5fbCT4N2fBresed/PYeQG/6pZGxInzlmt8gTqEBi
         +qEw==
X-Gm-Message-State: AOAM531nBQ7ZVsFa56i74arhJEdS3Rk+KEjVOaJ37UjeLicE9cU70ZLO
        GHZS/aRkU3Wp5rYcFxAT5Xc5ve3EfYSKXWswxnVJPQ==
X-Google-Smtp-Source: ABdhPJybVSS6YuAyjr24XGif6t4uCJxDSC8Dg1F94QRJFCb33vMmF58z4GFFNzf14hSLatqaLJEyS70Y970qbVtg2D4=
X-Received: by 2002:aa7:c3cd:: with SMTP id l13mr20074891edr.52.1614784115667;
 Wed, 03 Mar 2021 07:08:35 -0800 (PST)
MIME-Version: 1.0
References: <20210302192550.512870321@linuxfoundation.org>
In-Reply-To: <20210302192550.512870321@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 3 Mar 2021 20:38:22 +0530
Message-ID: <CA+G9fYvxnS5iiQJEe2dHbKJjQyeU=G_YWDYJK-e1UL_C6hPvLQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/246] 4.19.178-rc4 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Jon Hunter <jonathanh@nvidia.com>,
        linux-stable <stable@vger.kernel.org>, pavel@denx.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2021 at 00:58, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.178 release.
> There are 246 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Mar 2021 19:25:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.178-rc4.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

Summary
------------------------------------------------------------------------
kernel: 4.19.178-rc4
git repo: ['https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git',
'https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc']
git branch: linux-4.19.y
git commit: 26e47b79f5ec2ea5c7a46e578dc0b46b9073effe
git describe: v4.19.177-247-g26e47b79f5ec
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19=
.y/build/v4.19.177-247-g26e47b79f5ec

--
Linaro LKFT
https://lkft.linaro.org
