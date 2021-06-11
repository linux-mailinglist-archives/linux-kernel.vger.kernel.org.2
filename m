Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C273A4AB1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 23:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhFKVl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 17:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhFKVl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 17:41:57 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5835FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 14:39:58 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id o3so7429324wri.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 14:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=0QDb2/kUHVW8lv82h4iuCL3pJ9emh15XA/S11XTDQlU=;
        b=aeE/8vx6hRhekLT8QJRfxZsP54LVoH27wVXdVczEOp18demzyLWosFwxkXSrNB0Ckx
         Kg6SGhhbM0vloRCkHxlLUlXBg56/oETyUvFMwgdKI2qpr+oVVvBpI/1ZZ5bbuU3ijiGT
         IbmnXttBiQAyCGPFGvHtnDW246AvcS36WzXQvTbZmFhzpYTiYjrFnlA/nCRKBrIiuDhr
         +6r0kku4GCfJjO1BnGtVdOZTGslENKPYiaGhyPnR/QlcmJlPAOIYVdkaI9BN6erYOynk
         I7kCvA+OPOtXMjKzp88/KFEuP97nbbc9i5vDb18EQ7FDmARh9Nc6m9SRbrIJwogru54x
         Il5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=0QDb2/kUHVW8lv82h4iuCL3pJ9emh15XA/S11XTDQlU=;
        b=bSqIXao5AAviCG2vY8+pb81248fQyr1o5ZcjNkmy3zRzGx/9QZ9vL1cRvXokPIVqBF
         ZBBd07wkvqeVsOFwlTBoBLBospl1Si2/wDj3Oe6DEo3vthsCId0YUNxCjd//l33nWGQV
         q30HyeuvNNPQ6+As15zsAGxDYUnow7fuSMWqiM9FUiH3p6dzNoflV7RN1vkpUdQh1MDV
         hTtDplPf+jdhvRIgVMm9XtcQWhCuq4GYhNH2Nim3OAS5b5Tmp+wYSPNPvGOyjNOSyb3M
         z+m9oUQu7EtSxAKgjY2D/jKUIR7/Flgaj3x4pyeeA4jpUh2/GU7IQZE6Kf9Le93706wE
         fvEg==
X-Gm-Message-State: AOAM533/luaScAaIfs0+YpBQYtQLg2sfZ43NmcJ7znrGRiJ7GOABh80i
        g/baNoO6CIcErnNM0Ru1U/mGtV2CKcxSdA==
X-Google-Smtp-Source: ABdhPJyca1xqNDS4eR9mwmhPXtMUXQqUGW+nIBEEgdkTQOMljFYGGjj1IJ+VsiXyuF/Ke+MQ/g+fIw==
X-Received: by 2002:adf:b64a:: with SMTP id i10mr6097620wre.169.1623447596907;
        Fri, 11 Jun 2021 14:39:56 -0700 (PDT)
Received: from pevik (gw.ms-free.net. [95.85.240.250])
        by smtp.gmail.com with ESMTPSA id x3sm13522666wmj.30.2021.06.11.14.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 14:39:56 -0700 (PDT)
Date:   Fri, 11 Jun 2021 23:39:23 +0200
From:   Petr Vorel <petr.vorel@gmail.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Luo Longjun <luolongjun@huawei.com>, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sangyan@huawei.com, ningyu9@huawei.com, luchunhua@huawei.com
Subject: Re: [PATCH] arm64: configs: remove redundant CONFIG_MTK_PMIC_WRAP
Message-ID: <YMPYC5OAEh5vJQwv@pevik>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20210507182410.10515-1-luolongjun@huawei.com>
 <20210511172020.GB21033@arm.com>
 <6ef5c7a0-3596-a67c-c99d-c8e0def8a96a@collabora.com>
 <aa3d0bf1-8330-42e0-d11b-c554194c3b81@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa3d0bf1-8330-42e0-d11b-c554194c3b81@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Hi all,

> On 11/05/2021 22:04, Enric Balletbo i Serra wrote:
> > Hi Catalin,

> > Thanks for cc'ing me.

> > On 11/5/21 19:20, Catalin Marinas wrote:
> >> On Sat, May 08, 2021 at 02:24:10AM +0800, Luo Longjun wrote:
> >>> When I compile kernel in ARM64, it produces the following output:

> >>> *** Default configuration is based on 'defconfig'
> >>> arch/arm64/configs/defconfig:1018:warning: override: reassigning to
> >>> symbol MTK_PMIC_WRAP

> >>> After checking defcofnig, I found two CONFIG_MTK_PMIC_WRAP options.

> >>> Signed-off-by: Luo Longjun <luolongjun@huawei.com>
> >>> ---
> >>>  arch/arm64/configs/defconfig | 1 -
> >>>  1 file changed, 1 deletion(-)

> >>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> >>> index 08c6f769df9a..9907a431db0d 100644
> >>> --- a/arch/arm64/configs/defconfig
> >>> +++ b/arch/arm64/configs/defconfig
> >>> @@ -491,7 +491,6 @@ CONFIG_SPI_S3C64XX=y
> >>>  CONFIG_SPI_SH_MSIOF=m
> >>>  CONFIG_SPI_SUN6I=y
> >>>  CONFIG_SPI_SPIDEV=m
> >>> -CONFIG_MTK_PMIC_WRAP=m
> >>>  CONFIG_SPMI=y
> >>>  CONFIG_PINCTRL_SINGLE=y
> >>>  CONFIG_PINCTRL_MAX77620=y

> >> Adding Matthias and Enric. This change looks fine to me but I think it
> >> should go in via the arm-soc tree. Commit 9fd5449e061e introduced the =m
> >> option while commit fbbe38309d56 introduced the =y variant.

> >> You could add:

> >> Fixes: fbbe38309d56 ("arm64: defconfig: Allow mt8173-based boards to boot from usb")

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

I was going to send fix myself, I'd prefer also y, but weren't 100% sure sure.

For a record:

* CONFIG_MTK_PMIC_WRAP=m committed by author in 2021-01-04, merged 2021-01-31 15:31:01
9fd5449e061e ("arm64: configs: Support pwrap on Mediatek MT6779 platform")
sent: 4 Jan 2021
https://lore.kernel.org/r/1609747703-27207-3-git-send-email-argus.lin@mediatek.com
Applied to v5.11-next/defconfig 31 Jan 2021 15:32:26 by Matthias Brugger <matthias.bgg@gmail.com>
https://lore.kernel.org/linux-devicetree/5d5a67a5-ac2d-9ef9-b20c-66cbd55ebb8f@gmail.com/

* CONFIG_MTK_PMIC_WRAP=y was committed by author in 2021-03-31 11:06:57, merged 2021-03-31 12:12:59
fbbe38309d56 ("arm64: defconfig: Allow mt8173-based boards to boot from usb")
sent: 31 Mar 2021 11:06:57
https://lore.kernel.org/r/20210331090659.4169966-1-enric.balletbo@collabora.com
But originally sent: 9 Feb 2021 10:11:11
https://lore.kernel.org/lkml/20210209091112.2075478-1-enric.balletbo@collabora.com/

Kind regards,
Petr

> > I sent the same patch some time ago [1].

> > I agree, either land this patch or mine. In any case,

> > Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> > Matthias is this something that should go through your tree?


> Yes, this should go through my tree. I'll take care of it.

> Regards,
> Matthias
