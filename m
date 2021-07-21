Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286B03D0A6A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 10:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236600AbhGUHgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 03:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236383AbhGUHb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:31:29 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A3AC061574;
        Wed, 21 Jul 2021 01:12:03 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id z9so1403871iob.8;
        Wed, 21 Jul 2021 01:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=pL2C9kVjJUNoadYQaAKSPZ98TvYLySVH4tRSkOmd6po=;
        b=fo/NxuLkx8GcFXYS3VVuLCjl4ki9ob6lizBHGdDSitZ10DmW5vaKYGWAt3LbvoSCwX
         kVlWdvMTfrkcf/9O7AeyPiUWkAFfJBzeHpc6IOBFNCB1mfUng5/YU61/Jx+LmYgXLeBl
         iILgVv4K7xVCg3ezgjzA96EwwMZPwX4RPcYlc5bJ8gyIEu5RISlTOSUbF1xNCBmb44LL
         2LEjwGXSJC3Qbv7diUtmwPuYQrB5xfL0vDoZCn3T6wz5s/rd226RGChmeIi9Eu3utTif
         tRCXS8XsRIGusF5Ufx3RhGzLTA0i/z30GHjI0Ba20muC3zpXFwodbKo+Y8aYgxeBFPiT
         hYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=pL2C9kVjJUNoadYQaAKSPZ98TvYLySVH4tRSkOmd6po=;
        b=euo1IhuaI79aP0gl8B2ypy7EFol6ofnQwWvFvtrrK8cmiM4NJ50tpNePzIMelny0Em
         Lrt6qGw0qjwAwjUzMgWfLmke7V4G17dii5z0SKi3+4Xs3j/cMEl3h3GGzhozbuu5UJ1N
         5468Q3E6ZPnj9uB7/ipchq/8KH9vCWoP0d+p32u5uQ9rSlIOahvRwejRhUeqchKYe42Y
         TzZbgBkJE3+LSQ9rhHqIxUCjTfrFMaKDix9vThwbTMTJkiuJa0Vcsc8d+Sinzw+9CrOp
         Zk0jabSpXH26IxoKpau82LWpHixPZZbQ8HfgbUfvEzZp4uiS1pFXbY5vYLSZRzsJHyZr
         2Yow==
X-Gm-Message-State: AOAM530gDLSfb6oUE6ks+fBB0e3id/8ji3INfDQUxVYM83WBA+pmbL48
        HIYqxG/RsIxeaEhFCxzbgvr/8cIgsGd/cU4eOA+Rvn1cX+qWFA==
X-Google-Smtp-Source: ABdhPJztKrsz6lAR+YpujrMMSlaT3nT9BUhbavspkBABheJZkliR6NnmksVys2h3dE9SfgBLBlOF8A5LIUzYH69sKh8=
X-Received: by 2002:a5e:8d16:: with SMTP id m22mr2457103ioj.60.1626855123253;
 Wed, 21 Jul 2021 01:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <1626430843-23823-2-git-send-email-dillon.minfei@gmail.com>
 <202107201305.FPUQWvWk-lkp@intel.com> <CAL9mu0LVdt1wtKzBa=201AJ-Eb4BdKtVx18hzQfaB0-Ga0jx9g@mail.gmail.com>
In-Reply-To: <CAL9mu0LVdt1wtKzBa=201AJ-Eb4BdKtVx18hzQfaB0-Ga0jx9g@mail.gmail.com>
From:   Dillon Min <dillon.minfei@gmail.com>
Date:   Wed, 21 Jul 2021 16:11:27 +0800
Message-ID: <CAL9mu0JVA-jvExpQyZVfqC61qtsXJHgFbeo5LBjaxFF-PYzHuQ@mail.gmail.com>
Subject: Fwd: [PATCH 1/2] dt-bindings: display: panel: Add ilitek ili9341
 panel bindings
To:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kernel test robot,

Thanks for your time to test my patch.

I did the dtbs_check on my side, and got the same warnings.

But I guess these warnings do not come from this submission,
So, I will not be going to fix it at this time, but will at other submissions
to fix these, add arm,armv7m-nvic.yaml ... to describe compatibles, etc.

by the way, i did find a warning from the stm32f429-disco.dts and fixt it
in "[PATCH v2 2/3] ARM: dts: stm32: fix dtbs_check warning on ili9341
dts binding",

the warning:
arch/arm/boot/dts/stm32f429-disco.dt.yaml: display@1: compatible:
['st,sf-tc240t-9370-t'] is too short

my make command:
make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml

Best regards
thanks

Dillon

On Tue, 20 Jul 2021 at 14:12, kernel test robot <lkp@intel.com> wrote:
>
> Hi,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on robh/for-next]
> [also build test WARNING on linus/master v5.14-rc2 next-20210719]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/dillon-minfei-gmail-com/Add-ilitek-ili9341-panel-driver/20210718-103113
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> compiler: arm-linux-gnueabi-gcc (GCC) 10.3.0
> reproduce: make ARCH=arm dtbs_check
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
>
> dtcheck warnings: (new ones prefixed by >>)
>    arch/arm/boot/dts/stm32f429-disco.dt.yaml:0:0: /interrupt-controller@e000e100: failed to match any schema with compatible: ['arm,armv7m-nvic']
>    arch/arm/boot/dts/stm32f429-disco.dt.yaml:0:0: /timer@e000e010: failed to match any schema with compatible: ['arm,armv7m-systick']
>    arch/arm/boot/dts/stm32f429-disco.dt.yaml:0:0: /soc/i2c@40005c00/stmpe811@41: failed to match any schema with compatible: ['st,stmpe811']
>    arch/arm/boot/dts/stm32f429-disco.dt.yaml:0:0: /soc/i2c@40005c00/stmpe811@41/stmpe_touchscreen: failed to match any schema with compatible: ['st,stmpe-ts']
>    arch/arm/boot/dts/stm32f429-disco.dt.yaml: l3gd20@0: 'spi-max-frequency' does not match any of the regexes: 'pinctrl-[0-9]+'
>         From schema: Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> >> arch/arm/boot/dts/stm32f429-disco.dt.yaml: display@1: compatible: ['st,sf-tc240t-9370-t'] is too short
>         From schema: Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
>    arch/arm/boot/dts/stm32f429-disco.dt.yaml:0:0: /soc/crc@40023000: failed to match any schema with compatible: ['st,stm32f4-crc']
>    arch/arm/boot/dts/stm32f429-disco.dt.yaml:0:0: /soc/rcc@40023800: failed to match any schema with compatible: ['st,stm32f42xx-rcc', 'st,stm32-rcc']
>    arch/arm/boot/dts/stm32f429-disco.dt.yaml:0:0: /soc/rcc@40023800: failed to match any schema with compatible: ['st,stm32f42xx-rcc', 'st,stm32-rcc']
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
