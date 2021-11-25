Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D295C45D3BD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 04:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239760AbhKYDuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 22:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238956AbhKYDsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 22:48:50 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAFEC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 19:45:39 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id t5so19758347edd.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 19:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NPCCVgKoqd5UkFOmCiW3dUpNAf1NDeGSPn0h/jK+fCE=;
        b=bYMNAs/Nf0y8syqh/djSsRr65HhzI1EOoQA6aFXCxnYOwovmgZ+glglUeg4dG81O7q
         WMAOMZXPl5fXnNVASgKmfdAbnD0ZeNSz/Fafhr2Rv9/w1uudSeZ0MzUJt/bUk2YHOYZZ
         01qCcEv155kuP2Nk8A60mkI14EMS7C0C6bF7ijnADmk87EzjCGD9PDXwv5B6WKEiFbes
         EPGoPt6itO8sZjMl0Wwck+Sd3u24qIaYdbSp2L5suMJ4nptXG5GZO349b9ya4IAct7gL
         ldl6WhSpZEEPKpBGp6ygVGz7UOmEhe9jkVEusyKVztazOZCTJ+XRRCaXIk6syFlqvej8
         d2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NPCCVgKoqd5UkFOmCiW3dUpNAf1NDeGSPn0h/jK+fCE=;
        b=lGi6FnAgnHIf21q45anojcLptif5bTB25q1FJM46S0HSnuTjsUFEwh7l/519XPiU9a
         /bEeMREiAPZwn0gODE5Z+MACCVjtrhcg9mSUEu03DeVIA4gY4VGlgrA5tk7UbfoH913L
         oQ0rai139Mos6K4gMBDcabtHg9LyWWaQCf4XP+UY120um+TlcHOpJj270Aw+WfPEOEtj
         wITw75REJLRD8aofLUYwia9fdYXnuBI2HuAIooFDvr33GpPZa7qs2P1x1UtSJqX3Y6+E
         GEL+r6ag/7duHnUH3JJaBkYnyM65uNA9jGbSu4eOHBzaUs6lGuNc25PGkYTqEhmnU3lf
         geaw==
X-Gm-Message-State: AOAM531a4ok+KKoG1b5d0UDj3T9hSj9r11vgBbLQ5Zb2oJ7gquGkcnS8
        yi/peQkR7YukJAtvDfA14CwzW99+w5v5/TRjUOXdqw==
X-Google-Smtp-Source: ABdhPJz4YV1uifAxwKlolSDZgdDf7P/9UObGQ35IL5BIKDXabBuc/ln7H2YfG1TNtPmQOaFwSAgwnLW+kODe3PgFUgY=
X-Received: by 2002:a17:906:4791:: with SMTP id cw17mr27547585ejc.493.1637811938368;
 Wed, 24 Nov 2021 19:45:38 -0800 (PST)
MIME-Version: 1.0
References: <20211124115718.822024889@linuxfoundation.org>
In-Reply-To: <20211124115718.822024889@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 25 Nov 2021 09:15:27 +0530
Message-ID: <CA+G9fYvxnPa4HXXqcF-2Y-dW2VEer3ZZ9Wa9P5fKy8b3qUB89g@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/323] 4.19.218-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        f.fainelli@gmail.com, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        stable@vger.kernel.org, pavel@denx.de, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, linux@roeck-us.net
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


FYI,
New warnings on Linux 4.19.218-rc1 arm and arm64 (defconfig+7) with gcc-11.

drivers/soc/tegra/pmc.c: In function 'tegra_powergate_power_up':
drivers/soc/tegra/pmc.c:429:1: warning: label 'powergate_off' defined
but not used [-Wunused-label]
  429 | powergate_off:
      | ^~~~~~


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org
