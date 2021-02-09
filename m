Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCDB314664
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 03:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhBICcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 21:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhBICcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 21:32:39 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A879C06178B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 18:31:58 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id f14so28911302ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 18:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mTfGi8L/4CClRzVPopUo6ym2s0FBZL3P9CuXWX9APaM=;
        b=AvpvsLLoyj2RMvQKuZdRWp3N2Rljv2I6Xl80gQO51Qp+z7414zu8O1UN5G5sartw6D
         +IhkKyoj7zV4VyavWWOQ6a6KtSVb3pUmU4NEu3YZrrNizjNIIIQmuUH0x9Lifyks8z7f
         pwtMQ+RC9wBmRk+NcgEPKOMJ6tvIxUZFBMzQdAdWxFrvuRG7TtqTH3o3Kyi9DmCKcfk2
         +xNTn30tAaGakVdTPUy/amTU5SVkkS9lVgMew8ktr0zeTvzWHZuN4cF2OZWlM2fYi3Ce
         pEP6sDdhqBpesMewlMcX+/HzK8E8vOslrSn+RZFUrI4MvfUsXSzQFNu28F3chTPwMpEq
         Xbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mTfGi8L/4CClRzVPopUo6ym2s0FBZL3P9CuXWX9APaM=;
        b=RX4DeTVPAnHqla+FhDfbu5ROioFSXtX3q2vRCfIgue2tOMB+sBtkuphjM+t8FbPa0G
         R7mpwZqfVe6W3B91BI1jNiOKGnUBHwK+wdl515TgfkEW0i3fA+dReM37XQ3dJrHjEt+D
         vjXqK7fKdsAmo3vuirekg7uzlaY1Emi26pS+Iie47/e2754C729kCd0vtoHazsmAdioI
         sSC551ya27mBfu2WXWwTjnkLrjVVVoyF1/ljQIPDm2q45wxi69sgzPBIGA8Qmge6aYPW
         2LeeWoMqwDQiUINxJPavpn9E3Not2oDgj9W2D+OflBETZdkaAPkXJdlTvDm2VPvTpnJw
         3nnQ==
X-Gm-Message-State: AOAM530ICl5KX5twBtVbdRLo2qPOB05fPfECWfVbVRoDxxBZ0deGdOiZ
        EcX1af2/hjtf99Ho7T2SvAP93hUBVz6w9Qur2t0wNQ==
X-Google-Smtp-Source: ABdhPJyPqGgUhxoMWPs2L7UW1Jz9zUd86P5RnbK6VvIdX/xhbV1j3UzNgC6kJP1XsWoG0pHkFlPFl1LzpBH2fQn9Dz0=
X-Received: by 2002:a17:906:ca0d:: with SMTP id jt13mr19524040ejb.170.1612837916543;
 Mon, 08 Feb 2021 18:31:56 -0800 (PST)
MIME-Version: 1.0
References: <20210208145818.395353822@linuxfoundation.org>
In-Reply-To: <20210208145818.395353822@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 9 Feb 2021 08:01:44 +0530
Message-ID: <CA+G9fYsjJ+K7w-PQ4gp=L3QO_VSaUMr6syvAS77--aFbfZVK-g@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/120] 5.10.15-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Jon Hunter <jonathanh@nvidia.com>,
        linux-stable <stable@vger.kernel.org>, pavel@denx.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rolf Eike Beer <eb@emlix.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Feb 2021 at 20:44, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.15 release.
> There are 120 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 10 Feb 2021 14:57:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.15-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Due to the patch below, the x86_64 build breaks with gcc 7.3.x
This issue is specific to openembedded kernel builder.

We have also noticed on mainline, Linux next and now on stable-rc 5.10.

collect2: error: ld returned 1 exit status
make[2]: *** [scripts/Makefile.host:95: scripts/extract-cert] Error 1

ref:
Build failure link,
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-stable-rc-5.10/DISTRO=lkft,MACHINE=intel-corei7-64,label=docker-buster-lkft/64/consoleText

> Rolf Eike Beer <eb@emlix.com>
>     scripts: use pkg-config to locate libcrypto

From 7658769759718950f5eda0079e84837738d8fda8 Mon Sep 17 00:00:00 2001
From: Rolf Eike Beer <eb@emlix.com>
Date: Thu, 22 Nov 2018 16:40:49 +0100
Subject: scripts: use pkg-config to locate libcrypto

commit 2cea4a7a1885bd0c765089afc14f7ff0eb77864e upstream.

Otherwise build fails if the headers are not in the default location. While at
it also ask pkg-config for the libs, with fallback to the existing value.

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
Cc: stable@vger.kernel.org # 5.6.x
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
