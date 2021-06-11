Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A033A4AC5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 23:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhFKVvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 17:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhFKVvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 17:51:31 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4EAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 14:49:32 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l9so8797966wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 14:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=FhdlQOs8218L6C1WKAPZ8NIT7azafYcWg3ypPA+F0qk=;
        b=blFJgmXvns61TkW3h1lP7L5PCLy0nmd1IjK+a7jueM8N+Ii082jg9EkiI1p3v2ztOO
         rmbCvnGOnemuoByjc6mo+BWzQWqobs9IIULvNLDq0059ABYoh2O+8kHj1iJ7btlHNFks
         mgb1VAwHdLOSoehbdLad0x5OCRjORBeSEfXjq8STvn8sHW/Kk1u9vWVCM09DjNikVq06
         uJgOAS6m6NCiKa5LzwZAF56nTr54WG7eHfjTrCQT598fxvn6xAqJz45+rape9dSdSBhQ
         m0hAVMWUV86JJ9GDyGXHnCz+NQuZXQc2mgtqiAOiT6gT4B/UPhbtAD1Muy+vESzosbRR
         /qyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=FhdlQOs8218L6C1WKAPZ8NIT7azafYcWg3ypPA+F0qk=;
        b=cHtRqPMBimREBsjFr0GkBO4TMvoADH2MeQCiGGqB1oi+8+ZPqAxaUI/prPiz7C4/78
         1NBjtDPks8SQzT3sHu/Fzx1lK1aMNetK9nBgrQJyBYKLhQzZJZ6c4D2h+e2TAmkldmqD
         LngAqO1UZejl69QHagPGBFK4tfZNEA9j1I1VcIVcebM5iQ9TnQrbM5D/D8AQIUFmCFrV
         Br2KjyAg+ySH7YZodDNpmBy4lMum48ECfIdti4cT8uVhjHkAmJe7Wrg7YlTI+JEDGPju
         dwzK2YJ86c0wxiOwbCysB9MwYp8vZqXA+06raiV/gUDlcjDTEbZsEhMQQhDuhSYtWctt
         Vqzw==
X-Gm-Message-State: AOAM532bEylkoILQVustcxumevUss5HFfSb6gKM1BDMXTKPO+N9hbgRO
        R45zeEFpGE2MvfBMI9sZzOg=
X-Google-Smtp-Source: ABdhPJwaF2nqG3494Aa1pe/CMXELzEstWNyCEYwUeXHYt9hs9E4pjJMD8GhTlxkMHwkzjG0tzWl+Bw==
X-Received: by 2002:a1c:b783:: with SMTP id h125mr22400117wmf.182.1623448171193;
        Fri, 11 Jun 2021 14:49:31 -0700 (PDT)
Received: from pevik (gw.ms-free.net. [95.85.240.250])
        by smtp.gmail.com with ESMTPSA id 89sm8564612wrq.14.2021.06.11.14.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 14:49:30 -0700 (PDT)
Date:   Fri, 11 Jun 2021 23:48:56 +0200
From:   Petr Vorel <petr.vorel@gmail.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        linux-mediatek@lists.infradead.org, drinkcat@chromium.org,
        hsinyi@chromium.org, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Guido =?iso-8859-2?Q?G=FCnther?= <agx@sigxcpu.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Max Krummenacher <max.oss.09@gmail.com>,
        Michael Walle <michael@walle.cc>, Nishanth Menon <nm@ti.com>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Luo Longjun <luolongjun@huawei.com>
Subject: Re: [PATCH] arm64: defconfig: Do not override the MTK_PMIC_WRAP
 symbol
Message-ID: <YMPaSD45DOFMsNFW@pevik>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20210423075201.2616023-1-enric.balletbo@collabora.com>
 <cb9c85d5-3467-c235-93cd-be23fb6e0a03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb9c85d5-3467-c235-93cd-be23fb6e0a03@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

> On 23/04/2021 09:52, Enric Balletbo i Serra wrote:
> > Commit 'fbbe38309d56 ("arm64: defconfig: Allow mt8173-based boards to boot
> > from usb")' added the MTK_PMIC_WRAP config built-in. It needs to be
> > built-in in order to be able to boot from USB or the MMC without needing
> > a ramdisk, but that symbol was already defined as a module so now we are
> > getting the following warning:

> >   arch/arm64/configs/defconfig:996:warning: override: reassigning to symbol MTK_PMIC_WRAP

> > Remove the MTK_PMIC_WRAP=m from the defconfig to remove the error.

> > Fixes: fbbe38309d56 ("arm64: defconfig: Allow mt8173-based boards to boot from usb")
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> Applied to v5.13-next/defconfig
I'm sorry, please ignore my useless Reviewed-by: tag.

I was searching in arm64 git [1] and overlooked the date.
I see it was merged into Matthias' git tree [2] month ago.

Kind regards,
Petr

[1] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/commit/?h=v5.13-next-defconfig&id=f0e70d4946332c681ceaba940652f30c7c33473d
