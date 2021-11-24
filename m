Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5BC545C8EC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 16:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343670AbhKXPoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 10:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245385AbhKXPn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 10:43:59 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7634EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 07:40:49 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id r25so12320144edq.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 07:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WOzZVb7eK7Hti0tz3GVrNqgoxIyM18tOwhZY0CXCgCY=;
        b=vNC9gnZ7Mgigz91OlFqpssnHXeE4NTqVn2epRiFQQxdiTv1Zyx+SoX5RiHdoHXSFJF
         yK2IGi2OHfIB0Htmvbhj/N8guIyjZPQ+R8EbE5mspmWnfLmTZ5IOpVHJGByMe1p7Jgvh
         wbn5I8xTUoQDFLR5iY+GBlb0TLH5XRU7LuGzN33398vHsqrAou6G59H9ERPFLLQ6rMvw
         /uNBtB403hAaDXxZ4K1/LObfQGiscsa2Z7JwJg74mZK+iC3EVn9xGxU4mGilcbJs1Zx8
         5zTT4Yd7CtZ/McV2WvasBSty1Js7RWIUGcJqlo8hkGb356A8g4jMpbsm2J6LUwFAyV6T
         xG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WOzZVb7eK7Hti0tz3GVrNqgoxIyM18tOwhZY0CXCgCY=;
        b=EhTlhRsJA2JLQfnVs2O8CpBPIISM0mDIx5qA/2R3kIAoNl0GKcBIHAbavStDWN3La9
         FtVZDxQzfL6CN74Q8hYydZ4W6e3O3Ob3nhxzfEeD5xYWr7J14QQW6sIx9EsuW6alnyPE
         R2SGxPUlUiwZfEmIU8UIWSF3AnfQFTzN20qyaw26du/7+IbsG9cmNqRyp1akiFqwoRiA
         4o24f/h8MeOl2yJWNGt1iUpqhJdqRabpm6rKZ0EibfPZu0NvxPfbCejjv1veVmLuJPE+
         shJkc4Xic4MGhRYevlY/4wLI3F9E2Pw3zjXpFxv29S+NgoprjYr0h+USrsdv7P+NlVSv
         ggNg==
X-Gm-Message-State: AOAM532/goAOhyaBFEFBhrkuKoIe7862qoAI9FVYEBJbMZXpVNcfgMBJ
        /UNncci8wKe5OsWSl40teiXP7OsUhytiEd2L5QRvZw==
X-Google-Smtp-Source: ABdhPJzsxFeT+ZbR5XBrCvJ2qn5HXrBYo4hZIOym5n1u5AfFDx5Ci4S21KmpQLhCwjNDpT1Mn1SzhzaauI28dmA9x2g=
X-Received: by 2002:a05:6402:4248:: with SMTP id g8mr26665904edb.182.1637768447927;
 Wed, 24 Nov 2021 07:40:47 -0800 (PST)
MIME-Version: 1.0
References: <20211124115654.849735859@linuxfoundation.org>
In-Reply-To: <20211124115654.849735859@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 24 Nov 2021 21:10:35 +0530
Message-ID: <CA+G9fYt_DK3Ft1J08Wsw=4YfV0iayKqNtkQt_=8vgr+A6CrC6g@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/100] 5.4.162-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        f.fainelli@gmail.com, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        stable@vger.kernel.org, pavel@denx.de, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, linux@roeck-us.net,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021 at 18:19, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.162 release.
> There are 100 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 26 Nov 2021 11:56:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.162-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regression found on arm64 gcc-11 builds
Following build warnings / errors reported on stable-rc 5.4.


builds/linux/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi:412.21-414.5:
ERROR (duplicate_label): /soc/codec: Duplicate label 'lpass_codec' on
/soc/codec and /soc@0/codec
ERROR: Input tree has errors, aborting (use -f to force output)
make[3]: *** [scripts/Makefile.lib:285:
arch/arm64/boot/dts/qcom/apq8016-sbc.dtb] Error 2


The bisect tool pointed to,

b979ffa8bbd6e4c33df7f3e7ac3d63f2234c023c is the first bad commit
commit b979ffa8bbd6e4c33df7f3e7ac3d63f2234c023c
Author: Stephan Gerhold <stephan@gerhold.net>
Date:   Tue Sep 21 17:21:18 2021 +0200

    arm64: dts: qcom: msm8916: Add unit name for /soc node



As it was reported here,
https://lore.kernel.org/stable/CA+G9fYv5fnntoa1vzXp52=TSxCK=U8fV8J-AbE+WmKH1w4ebwg@mail.gmail.com/

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org
