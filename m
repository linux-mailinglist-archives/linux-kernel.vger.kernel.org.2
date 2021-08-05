Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993383E10A4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 10:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239748AbhHEI4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 04:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbhHEI4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 04:56:13 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08E3C061765;
        Thu,  5 Aug 2021 01:55:59 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id x7so4336409ilh.10;
        Thu, 05 Aug 2021 01:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gzmhApPj8HKqYSRf21gqLOYpahW4Hf0SxEjn45dssUM=;
        b=TOTf9psJWunXK13kHgtY8TiWSVBgt5Vzq7W3W8AQ6vfyunOVZEh0Qg4+gWIaULVC0g
         U3YhP0DGAJBbmfrkgJEG1F3KzQp2r86sDY8FA4NRqzJFZVplKdW1VXiss+CkUgIVFlHY
         1AScnG9bhXvzFieoJZX0UsqLYilrjUrI/OQe5yDln9R0bPAl+gjRmsFEH07AqF30YWzf
         ITB/9oa3eXMfGlktXJpWD/8UHgFfsPXBT3zWtvvJCNHBegdJVKz1bP3KPigPDera7nA5
         ViBZAMJxF0nDwi4qDAhUT12fx7jCiepxmlN3eWPhh+rNERgLcXgkD/ePxOYnQOfNRHWn
         nplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gzmhApPj8HKqYSRf21gqLOYpahW4Hf0SxEjn45dssUM=;
        b=iYQcSkEEN+wvYRGP6jF+uT8lHPQSWPRFvb9Bx21zdtX5Prbsq/A5xohDHHkbmmWidH
         mupVSJ2IHpgG8N81vmUF7cmTrHi9UnLMGdWpfjZ4SCwRHK6v+Cry/MD6yK8exp2KlKhK
         VkhcgvMwObv+Kc0YQKp08zxLnqtQsK48tzmmVKkhtg+7GJ6Q6TNb7xQu4NRKrSRtcp4x
         rOlK1f27Hah4YV/SeJku28CgvddveRC+1PeyFTSl6EueN9555oqePvbsFmy30jWBy9xr
         CdZhJu7tp/GC5Wzk2qxj70tUXBN86xXcCgbw087sxfGN2DZk6UAtjne+W+n75xxC59O5
         vFQQ==
X-Gm-Message-State: AOAM5300alSulMHxyOkYWkiIRUG5T9ZOecyUn90/ivmFwWLVMyYccM8k
        kK148kfHQcWLU4x7Jl7KnjhST7IRu+mY6TodWPtiYRwof63CfpjJ
X-Google-Smtp-Source: ABdhPJwE6/hjmNRFCTdKVvlJC0gbv70mRmlYMEcT7G0uSTjPkThFyytPoqX7/kmL1I7cGXdcgbE94sArd3GVW8kQtzU=
X-Received: by 2002:a05:6e02:13b3:: with SMTP id h19mr244834ilo.218.1628153759089;
 Thu, 05 Aug 2021 01:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <1627098243-2742-1-git-send-email-dillon.minfei@gmail.com>
In-Reply-To: <1627098243-2742-1-git-send-email-dillon.minfei@gmail.com>
From:   Dillon Min <dillon.minfei@gmail.com>
Date:   Thu, 5 Aug 2021 16:55:23 +0800
Message-ID: <CAL9mu0+P4U+2tyA7CGCcP6riWXzKSpCWpNxKi3MvTt8Abiwtow@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Add ilitek ili9341 panel driver
To:     laurent.pinchart@ideasonboard.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Peter Robinson <pbrobinson@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All

Just a gentle ping, thanks.

Best regards.
Dillon

On Sat, 24 Jul 2021 at 11:44, <dillon.minfei@gmail.com> wrote:
>
> From: Dillon Min <dillon.minfei@gmail.com>
>
> Since the st,sf-tc240t-9370-t dts binding already exist in stm32f429-disco.dts
> but, the panel driver didn't get accepted from mainline. it's time to submit
> patch fot it.
>
> This driver can support two different interface by different dts bindings:
> - spi+dpi, use spi to configure register, dpi for graphic data.
>   st,sf-tc240t-9370-t
> - only spi, just like tiny/ili9341.c (actually, this part is copy from tiny)
>   adafruit,yx240qv29
>
> I was submited the first patch last year, you can find it at [1].
> this patch has one major difference from that one, which is replace the low
> level communication way, from spi_sync() to mipi_dbi_{command,
> command_stackbuf}() interface, referred from Linus's patch [2].
>
> both the two dpi/dbi interface was tested on stm32f429-disco board, if anyone
> want to verify this patch, you need apply the clk patch for this board first,
> you can get it from [3].
>
> [1] "drm/panel: Add ilitek ili9341 panel driver"
> https://lore.kernel.org/lkml/1590378348-8115-7-git-send-email-dillon.minfei@gmail.com/
>
> [2] "drm/panel: s6e63m0: Switch to DBI abstraction for SPI"
> https://lore.kernel.org/dri-devel/20210611214243.669892-1-linus.walleij@linaro.org/
>
> [3]
> https://lore.kernel.org/lkml/1590378348-8115-6-git-send-email-dillon.minfei@gmail.com/
>
> v4:
> - fix m68k-allmodconfig build error which reported by lkp, thanks.
> - add Copyright 2018 David Lechner <david@lechnology.com>.
> v3 link:
> https://lore.kernel.org/lkml/1627013203-23099-1-git-send-email-dillon.minfei@gmail.com/
>
> v3:
> - add Fixes tags.
> - collect reviewed-by tags from linus and jagan.
> - replace DRM_ERROR() with dev_err() or drm_err().
> - remove kernel-doc markers from struct ili9341_config{}.
> - reorder include headers.
> - remove the struct device *dev from struct ili9341{}.
> - restructure the ili9341_probe() function, add two ili9341_{dbi,dpi)_probe()
>   to make it more readable according to jagan's suggestion, thanks.
>
> for the full drm driver exist in drm/panel need Sam and Laurent's feedback.
> so, not cover this part at this time, will be update later.
>
> v2 link:
> https://lore.kernel.org/lkml/1626853288-31223-1-git-send-email-dillon.minfei@gmail.com/
>
> v2:
> - replace vcc regulator to bulk regulators in driver, from linus suggestion.
> - fix dtbs_check warnings on ili9341 dts binding check.
> - add bulk regulation node in ilitek,ili9341.yaml.
> v1 link:
> https://lore.kernel.org/lkml/1626430843-23823-1-git-send-email-dillon.minfei@gmail.com/
>
> Dillon Min (3):
>   dt-bindings: display: panel: Add ilitek ili9341 panel bindings
>   ARM: dts: stm32: fix dtbs_check warning on ili9341 dts binding
>   drm/panel: Add ilitek ili9341 panel driver
>
>  .../bindings/display/panel/ilitek,ili9341.yaml     |  78 ++
>  arch/arm/boot/dts/stm32f429-disco.dts              |   2 +-
>  drivers/gpu/drm/panel/Kconfig                      |  12 +
>  drivers/gpu/drm/panel/Makefile                     |   1 +
>  drivers/gpu/drm/panel/panel-ilitek-ili9341.c       | 792 +++++++++++++++++++++
>  5 files changed, 884 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
>  create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9341.c
>
> --
> 1.9.1
>
