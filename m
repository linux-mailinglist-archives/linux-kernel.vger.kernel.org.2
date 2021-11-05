Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8068E445D80
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 02:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhKEBtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 21:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhKEBty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 21:49:54 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A929C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 18:47:15 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id o18so15598895lfu.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 18:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fFtNxulykeZOJh/+EoHUpNc3awrU+sZTNAA9MYX7v5s=;
        b=mAWFDjHsGmZ4SgKaHQ5gYyw/if9ETe2hBN17fNG9OHf0bd5qDaC+thIqYR1ugNMgQy
         fuA3UlDA4ZtemBg8GmTZQs7y6jw6qMWCCo2fu+dJkwn9vAXXZnH7OKtKXWCN4CyZVDqr
         Wjd4AvI1UeVjk+fFFNVxLIZm/of9AHZuot16xDXeBX2cDCRM+jPabuEhMC1G0wW+8Uzg
         p0DEp4VGlyFRwP4/V67f95Y8bGpHqcgbsOOBljURfcMiCTE5+QUuqixnK4IliyAERUGW
         XodqFhZMajcLrJLb/faze7b8wtYg2I2/2+A41qhotC6Ed6HVdNKFTfBLmGGhZ5vIcky2
         ZvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fFtNxulykeZOJh/+EoHUpNc3awrU+sZTNAA9MYX7v5s=;
        b=Y3XbnzhmEVKNcm7Rjwq34IVRrzBs0TTDTc0iNiWr/yWalw1oEtqi6KJ255kIkfST0C
         prkK8+4eEygyZp33VdvrKXqyN57iFbC78dL7UUnBXTfrqoXpZ826TM5FU8X3srGbz8jD
         AT3rCOOZO0aAdL7l5NcWSivx9uhA4yagfwfeth4+T1pa314R7Vz1uQFmwvQ5zQFV4sme
         aF39gxLYqi5YLgy9mfuwtvPPmSyh76ehprVB4HJBV/lXNu4399UOtNRSIy2DiWktvhx9
         ISArL44L0Imx7U0iAMl+SAZN9w9m0SDXK10ZM1FaBUHabhiRcoOJp1uKrw3/cKV2dCuU
         AWuw==
X-Gm-Message-State: AOAM531L54FNjYX+ojxtFO0VITLGsHBTtGO14xdgHQOngFat9NPI6fRH
        swgNWWM5DBNe4COC37nS1VD2W9bIEIjn6uWW740byw==
X-Google-Smtp-Source: ABdhPJws3413F7L/y672t9JWv/lYGAlogwvZyALLtS39vIVLJojamzzzN+kwfeATdeUednSh8x6zBYPWdsKkQGmv/Is=
X-Received: by 2002:a05:6512:2341:: with SMTP id p1mr52103521lfu.243.1636076833611;
 Thu, 04 Nov 2021 18:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211105005955.107419-1-osk@google.com> <CACPK8XcXR=V5-Q+sC4MniNJZJgvbiysFD-5yu6v30_2BwDRTSA@mail.gmail.com>
In-Reply-To: <CACPK8XcXR=V5-Q+sC4MniNJZJgvbiysFD-5yu6v30_2BwDRTSA@mail.gmail.com>
From:   Oskar Senft <osk@google.com>
Date:   Thu, 4 Nov 2021 21:46:57 -0400
Message-ID: <CABoTLcS=s0XuM9jiisYW3=1gXtiwP8WeopqTOeBwnTX1XCky9Q@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: aspeed: tyan-s7106: Update nct7802 config
To:     Joel Stanley <joel@jms.id.au>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel

Oh man, this is embarrassing!

> I applied this and tried comple testing, and got this warning:
>
>   DTC     arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dtb
> ../arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts:217.4-14: Warning
> (reg_format): /ahb/apb/bus@1e78a000/i2c-bus@40/nct7802@28/channel@0:reg:
> property has invalid length (4 bytes) (#address-cells == 2,
> #size-cells == 1)
> [...]
> You need to add this to the nct node:
>
> #address-cells = <1>;
> #size-cells = <0>;
Oh yeah, of course. It's even in the example in the binding that I wrote.

> Did you see this with your testing? I'm building on top of v5.15 and
> my distro's dtc is 1.6.0.
I built (as part of OpenBMC) and ran (on actual HW), but these
warnings don't make it out to the console. In my "defense", I did run
checkpatch.pl, though.

Is there an easy way for me to see these types of warnings? Or should
they really come out as errors?

I'll fix and send a PATCH v3.

I'm really sorry, this shouldn't be so much work for you!

Oskar.
