Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8A83CECD4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381550AbhGSRiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352439AbhGSQBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 12:01:38 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58341C04E2D9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 08:57:49 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so18750395otl.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 09:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XKdo9XusaOXvhRc1xDgAMMd4cCrJog3x0IHEZRiACfU=;
        b=t/hCSbnnvABr5EzDl9o3nonZhzA04ztVlFeVHI7WAATO7zlVCfcD+foj6R+5UTpvz9
         WJaRaH2V026Wh9NY8YUpQiGPnBgKv97S2DMrJkQUeF8w78gRoeHH/7IXBVkJpqwa5UEd
         e2t7/SV6YnIaEo6JVFKzSXHHbvTbOXDYAPAxDGD1cWnCwDHVYmzrT8PIKQj50IpB8HXS
         buJTY6H7wa3HiKOTb1y77Q6aAUmfV5PDuMzzcnUgRGT2lNEtIO5HmgobU5VHfUpKUvXz
         9Zb8arNSaGb/uounuGWRGic7XahTFScRk//weodeUNRiMhd2XNYWdGFoX7ppe05YWLTw
         ycfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XKdo9XusaOXvhRc1xDgAMMd4cCrJog3x0IHEZRiACfU=;
        b=YWMM3uhCUBAvakOwN4sJzPl0znfF58OhXn7kKkR8dJkRpaJfaOYlaa6oQF4vVQ4LKT
         9pwUHF31l22nqBY8W+aJnTuf3YdfFrznDXPRBKYw6aT1ckW8EYBchBRahz+iI8GciVnc
         fu0BihSjSktIFLRXanscx61f855friR/hQRec/9DgLGLwyuq/BY03Fe2WFH5IdL1BNXK
         ElnBdjnaHZEq1zZkzN/TjRqJZCKmJmNYNzqJW3mSVdz+TbqAUsPPT7kVU4XXC9XKgug8
         ASuT6Wy3hWaQKMmZ5VWll3imzoC0/gdeYW6RRICEpFKle+v9Amrx+wNQ77J5kIIM+Anl
         cIrw==
X-Gm-Message-State: AOAM533u3hgG5TUGvJlwJ0Gteg9cuiNnoV0fbB/0Sx/sjB2f0EfWTh0D
        lyKt4xAU74TQYg3W2FxXBbTlX+OpKQuL6Mhw8E0e8A==
X-Google-Smtp-Source: ABdhPJz6IB0jLV0YEJvPVkTTOBrKT+6C26cjZrilbAk9BMlPd7TqiUEOfzoOdoy68/NHC8BMktzyeQ7NsfCU7PPZPww=
X-Received: by 2002:a05:6830:242f:: with SMTP id k15mr19790859ots.72.1626711722713;
 Mon, 19 Jul 2021 09:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210719144901.370365147@linuxfoundation.org>
In-Reply-To: <20210719144901.370365147@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 19 Jul 2021 21:51:47 +0530
Message-ID: <CA+G9fYuH=9=ssubxox8vpC2p-qMw45cH8Qta_dTs=Mae7A4W+Q@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/149] 5.4.134-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Pavel Machek <pavel@denx.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jul 2021 at 21:19, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.134 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 21 Jul 2021 14:47:42 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.134-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Following build errors noticed on arm64 architectures on 5.4 branch

> Petr Vorel <petr.vorel@gmail.com>
>     arm64: dts: qcom: msm8994-angler: Fix gpio-reserved-ranges 85-88


error: /builds/linux/arch/arm64/boot/dts/qcom/msm8994-angler-rev-101.dts:34.1-6
Label or path tlmm not found
FATAL ERROR: Syntax error parsing input tree
make[3]: *** [scripts/Makefile.lib:285:
arch/arm64/boot/dts/qcom/msm8994-angler-rev-101.dtb] Error 1
make[3]: Target '__build' not remade because of errors.
make[2]: *** [/builds/linux/scripts/Makefile.build:497:
arch/arm64/boot/dts/qcom] Error 2

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org
