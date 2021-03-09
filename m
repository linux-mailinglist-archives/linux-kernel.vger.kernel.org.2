Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6DD8332054
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 09:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCIIP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 03:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhCIIPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 03:15:31 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FDCC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 00:15:31 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id a15so6352686vsi.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 00:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zt/Qo1WuohJnN8BsEHz9cxnvtJashQ/NC/B5GNdt0Vw=;
        b=xTMuS7ToMWt37R/E2TwMkIlTyw/OnDiCgFudLcVzRWMSo5w4RdGfYHysaMdM/p1NTM
         /fqG/hW6BZDUtUgCO1V3seC2X6TEO0zAQWMWvFIatAc2w/rS757Rr+QoLDwCAZudOklN
         rKGr2+ojXgZPf867xtn+jGgS+l/xekob1NmvS0r1aYibZoE9XIGrR4cHObok+kU5TrAk
         MprRVuBqMFuG6neSTkuAyQQlG5hEKPh+ZfOZ8ujoA9opxP+AtZh6gqFknJNahGMTgson
         midmLZwd521PiW899MPbJHiWpD/79d5cW2IU7wdkBmMqCs4Kxhk3I2o16pSfzTtc/tE9
         WRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zt/Qo1WuohJnN8BsEHz9cxnvtJashQ/NC/B5GNdt0Vw=;
        b=cOA2Bz8p8wfH6JwxjSA2DP3VVZrVI35GuQTW3n5W+qz+JOOpjDzrcifFNQnVZfQGwv
         WpKVmlXFF1Ct50QZWpxdvvvy7GLXILH89Frzjks3wn053C4Cv2chgaYuho00/fBuo21N
         bMutHZuvUHsl7xxXlZOPWa1nZCwQyPnKeiOgb8+ssTMoOPraoIgmSUcBeGFvh5OfyK6N
         XDyXw88fxdfFjbLIHUE9IhpErAvftt4A8a+CohZm6zYWefactfLCVLNERY1T0YZjJvom
         D9/1TxIaKyxz1zRIyX675i6MweNwo3EZb7TQz+UrBfoFSJOXxF+qARLMWcJ+C0xY5N5e
         q3JA==
X-Gm-Message-State: AOAM5334YCJH2d7keu0p+CawLcuf8kU3rSMkpDzLo3lWqL2oNf3V+Ks5
        jXk0tMnFx6hSjmUPItN+83PkTp/1aeYx7ttSoi5BuA==
X-Google-Smtp-Source: ABdhPJyIREswXY8HIMohbytoDNg1hEAh37OQLrBbhEhyA1hgNSWz8OdncAaF+NnykgRA5ocddH6xzrc2+bGXFLcbPYs=
X-Received: by 2002:a05:6102:7b0:: with SMTP id x16mr13806738vsg.34.1615277730169;
 Tue, 09 Mar 2021 00:15:30 -0800 (PST)
MIME-Version: 1.0
References: <20210225095216.28591-1-nsaenzjulienne@suse.de>
In-Reply-To: <20210225095216.28591-1-nsaenzjulienne@suse.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 9 Mar 2021 09:14:53 +0100
Message-ID: <CAPDyKFoN6WERg=wq7Fo-iykDSp6w7eC1aRFi4Qih0wZ=LSR4XA@mail.gmail.com>
Subject: Re: [RFC 0/2] sdhci-iproc CMD timeouts
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2835..." 
        <linux-rpi-kernel@lists.infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>, phil@raspberrypi.com,
        tim.gover@raspberrypi.com, Adrian Hunter <adrian.hunter@intel.com>,
        Scott Branden <sbranden@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Feb 2021 at 10:53, Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> I'm seeing a rather odd behavior from sdhci-iproc's integration in BCM2711
> (Raspberry Pi 4's SoC), and would appreciate some opinions.
>
> The controller will timeout on SDHCI CMDs under the following conditions:
>
>  - No SD card plugged in (the card polling thread is running, CD irq disabled).
>  - BCM2711's VPU clock[1] configured at 500MHz or more, lower clocks are OK.
>
> There is no specific command that will time out, it seems random.
>
> Here's what I found out. The SDHCI controller runs at 100MHz, by bumping the
> frequency to 150MHz the issue disapears. Might be pure luck, or maybe I hit the
> nail and it's proper interference. Can't say.

As you probably know, I don't have the in-depth knowledge about this
HW. Although, let me provide a very vague guess. Could be that the
controller needs a higher clock rate to stay within some spec, for an
OPP/voltage domain for example?

In any case, assuming you get some confirmation from the Broadcom
folkz that this makes sense, you  need to update the DT doc bindings
to add the clock-frequency property. In regards to this, please take
the opportunity to convert from legacy DT doc format
(brcm,sdhci-iproc.txt) into the new yaml format.

Kind regards
Uffe

>
> Regards,
> Nicolas
>
> ---
>
> [1] For those who are not aware, here's the relationship between VPU's clock
>     and emmc2's:
>
>          osc                                    54000000
>             plld                              3000000091
>                plld_per                        750000023
>                   emmc2                        149882908
>             pllc                              2999999988
>                pllc_core0                      999999996
>                   vpu                          499999998
>
> Nicolas Saenz Julienne (2):
>   ARM: dts: Fix-up EMMC2 controller's frequency
>   mmc: sdhci-iproc: Set clock frequency as per DT
>
>  arch/arm/boot/dts/bcm2711-rpi-4-b.dts |  6 ++++++
>  drivers/mmc/host/sdhci-iproc.c        | 10 ++++++++++
>  2 files changed, 16 insertions(+)
>
> --
> 2.30.1
>
