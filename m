Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73EE3B7640
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 18:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbhF2QLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 12:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbhF2QIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 12:08:15 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDE2C061766;
        Tue, 29 Jun 2021 09:04:56 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id j11so6496530edq.6;
        Tue, 29 Jun 2021 09:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mSMaKeRnKB2oNlMP7+IS/2ZtzKYmdtUtkqxJbkL2T2k=;
        b=ngM9W5N2paWWM2+rpyaTLcjFN1N38663nn69udGelKAcal77EX3val2Y6ts8pvhpmT
         9p1m8sV2vPV2DBLdEI0Dvq80UbjPDfYzkssVhnA9VhmiCd1nH1U5k4/18HcUQb15ZSwH
         mwf9jnmgIgyjU6gwHYpfx5KcRtYx/c4zGUQqubTnRr0Kp74KgcN8arF+3N8RIdhs8NGD
         /1FD/7rZ+qWQwFGR2s8VtX8hjXU0YJaYr3ctPzunw5tGAmreTBO+ATjU4QNHrcu5+DFN
         Q6JzbYFpx9RpGjrGlYTpKJRLuyUAqf2yVcv+xF6l7hqTABQpPHQjtwZCKxBcGTwjc+8h
         O2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mSMaKeRnKB2oNlMP7+IS/2ZtzKYmdtUtkqxJbkL2T2k=;
        b=JtK2uk2OsUzttUopfjbf38OUMUKM3oDZqXMtbf4/Zzk39w8MfceGA3yMvWMPdI+sqU
         58VMjMVdZxmwzLd8ErylUwmWtH6vNFg8xbmmd2b+CGi8amCwMRTcJ6R+WOmL45PXp7yY
         2wo2MArMyzz/d3aHpxQFSXGhBHLoFBc0UBjSJCXZ2hJ5yuiMNZJ6nOfo+m5m1UkZ5Zed
         nlaYTcpYkawPbUfSVuVr9pulSOKbGwJPdUdtmZsU2GzdxWjTEgV1LybqLoeQihLS0reE
         s7TTV2M+y51AjrTWOWqV9zirT0gIT/D1MGyXML1gyWyvsTgUV5ShErsZ++q0+QMOvAxJ
         ZafQ==
X-Gm-Message-State: AOAM533CgNXpoNribFUlwPu7MI30Yv/sXqnQ9WwqcVwOzqtdYpNhmBga
        /gKRnhtC1xlczcYcfxJfGbUAZZ8SaAYlQJJ3HdY=
X-Google-Smtp-Source: ABdhPJyBHEpuzEymX76+Mx6swN/2YyM7JkqD0xhzNhKytAogRq9nQTi/CZio/kVrUB5BqYa3tTaMsKrhfnc6IIyv98U=
X-Received: by 2002:a05:6402:b83:: with SMTP id cf3mr35497334edb.130.1624982695390;
 Tue, 29 Jun 2021 09:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210629121848.6527-1-linux.amoon@gmail.com>
In-Reply-To: <20210629121848.6527-1-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 29 Jun 2021 18:04:44 +0200
Message-ID: <CAFBinCB8Gnj++2YKD3hf-8zyLfj5KyE3twv58XKV9L7-2jRmJg@mail.gmail.com>
Subject: Re: [PATCHv1] arm64: amlogic: Fix the pwm regulator supply property
 in node
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

thanks for investigating this and for sending a fix!

On Tue, Jun 29, 2021 at 2:19 PM Anand Moon <linux.amoon@gmail.com> wrote:
>
> On enable CONFIG_REGULATOR_DEBUG=y we observer below debug logs.
see my comment on the previous patch

> Changes help link VDDCPU_A and VDDCPU_B pwm regulator to 12V regulator
> supply instead of dummy regulator.
>
> [    4.147196] VDDCPU_A: will resolve supply early: pwm
> [    4.147216] pwm-regulator regulator-vddcpu-a: Looking up pwm-supply from device tree
> [    4.147227] pwm-regulator regulator-vddcpu-a: Looking up pwm-supply property in node /regulator-vddcpu-a failed
> [    4.147258] VDDCPU_A: supplied by regulator-dummy
> [    4.147288] regulator-dummy: could not add device link regulator.12: -ENOENT
> [    4.147353] VDDCPU_A: 721 <--> 1022 mV at 871 mV, enabled
> [    4.152014] VDDCPU_B: will resolve supply early: pwm
> [    4.152035] pwm-regulator regulator-vddcpu-b: Looking up pwm-supply from device tree
> [    4.152047] pwm-regulator regulator-vddcpu-b: Looking up pwm-supply property in node /regulator-vddcpu-b failed
> [    4.152079] VDDCPU_B: supplied by regulator-dummy
> [    4.152108] regulator-dummy: could not add device link regulator.13: -ENOENT
>
> Fixes: d14734a04a8a ("arm64: dts: meson-g12b-odroid-n2: enable DVFS")
I suggest changing the subject to include "dts", for example:
arm64: dts: amlogic: ...
(note: lower-case arm64 is correct here - even though it's different
from the 32-bit ARM prefix)

$ grep -lR pwm-regulator arch/arm64/boot/dts/amlogic/
arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi
arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
Are you planning to also send patches for the other board .dts as well?


Best regards,
Martin
