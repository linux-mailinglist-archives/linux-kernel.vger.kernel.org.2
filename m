Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE9B3E10E6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 11:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239075AbhHEJLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 05:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhHEJLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 05:11:01 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A403C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 02:10:46 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id z2so9773469lft.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 02:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GJwSqkoynJ2MGVTaxaCF6tjvxxMA2tETgRViwoLL+uA=;
        b=BdFbpdP8kIg3G9AXQcWSIAeuhscjDoUZNHs6tTtydjVKNUqX6XH/PSRXgAvDDkibyH
         5y1QnI6iyG41rUI4BShiWsjCdK9reMem48YfsrqtBHdjkZ/XH+7NfJ+Fp2W+rvSiXgIj
         KDzQQqJGe57bSr7SJNVLID1dJ7Ja1FgI6yo4Qu25gQia7UNjomXH2lFAS5NmjX7WzsWP
         7yol4EFp/gL0Qs9PjkuGiH0wi/O1hWWB9WpeJuEpUYm4b83BPy5lLxvlRxVq3VWu52AX
         EJs2V9pNjHHKlGmtbjwr7Ripm4xap7zc2hd36d6NtjMcalc9jcX66PggfAmfrUt4wDpy
         6L3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GJwSqkoynJ2MGVTaxaCF6tjvxxMA2tETgRViwoLL+uA=;
        b=VWZK36s91M4cy4PapWJLim+Zf95QW3KhPpxsEY6zWd9J6k7TAMLMtyqJv/zlZm2JYW
         1xNoC3dN0BFj9/k9WZYqduPuxhfCZRaPjQDFkHrAuKHVgRWgVWtfaa7l2UXKojaNtRhs
         JaDGVG8ABUTx2X+ZxJMTNCxW2zMBAzA5lhqIyTgtgzh06s1TDVOFHh+QA9aVarzzcOa1
         cp3x9kpY4xDsYesmyGWC+s9p+MEg9PrDGYbNYh0xlnQsCuUtzjQo/wa3uP/zpUBg8I5P
         mBrta8yRXYoPb4zPH1Xc2AQCRtr5gJZ2MeGDy6FDQqYjy+dCJIMQ7bnwcpLwnhbD+EtP
         +Gdg==
X-Gm-Message-State: AOAM532PvB68O5wd88sSmF3RK5zWZbk1+0HBq8kTt7IKPbuqpRDIkl5o
        DFGWfM1wrxufnRp8qij/1UyLlzso2K55FO5+Q+0rgQ==
X-Google-Smtp-Source: ABdhPJzZpUm8mUiTLlF2l2RaGugFmMpQMMqoQ5ipZx5ajfXnBZ534P16n8WUxjIaWbrbZLOd9+eZHKDTwonxKjv8meI=
X-Received: by 2002:ac2:4d0f:: with SMTP id r15mr2833139lfi.649.1628154644990;
 Thu, 05 Aug 2021 02:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <1627098243-2742-1-git-send-email-dillon.minfei@gmail.com> <1627098243-2742-4-git-send-email-dillon.minfei@gmail.com>
In-Reply-To: <1627098243-2742-4-git-send-email-dillon.minfei@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 Aug 2021 11:10:33 +0200
Message-ID: <CACRpkdYzrpHgDCW2UXNnFk-NpC_yM5xeSe_jBDJMGa6==5SHXw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] drm/panel: Add ilitek ili9341 panel driver
To:     dillon min <dillon.minfei@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        kbuild-all@lists.01.org, linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 24, 2021 at 5:44 AM <dillon.minfei@gmail.com> wrote:

> From: Dillon Min <dillon.minfei@gmail.com>
>
> This driver combines tiny/ili9341.c mipi_dbi_interface driver
> with mipi_dpi_interface driver, can support ili9341 with serial
> mode and parallel rgb interface mode by different dts bindings.
>
> Signed-off-by: Dillon Min <dillon.minfei@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> v4:
> - fix m68k-allmodconfig build error which reported by lkp, thanks.
> - add Copyright 2018 David Lechner <david@lechnology.com>.

Patch applied to drm-misc-next

Thanks for working on this driver!

Yours,
Linus Walleij
