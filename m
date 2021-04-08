Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1980535855A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbhDHN4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhDHN4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:56:21 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F401C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 06:56:10 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id d13so4179193lfg.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 06:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DdaKYAD+3uox0bnZyMc0CsziZH9vJmOYjQVhGpA3+bo=;
        b=YVghXLhw3Z1qU+4wuVKseRBYeubkYqgAsKCgA0PxXp6D+PFpFAqS9YyfftG/bJcAOe
         tfR/28lkz8QJ0zOYBx6bCWSNSAHVV2Hc3wLV94wD7EDkgsUtqfGRN2GENGFACqN9QhE3
         eDKrudUengMXc/PEE+vIrkJlxaeoTr8L4SCvioqPpdZOegqqMS7A2X5dc3yrhYXqVykb
         8ybpP5k4ITTpptf/kANs7HKh5UAmHvtoO9AiO0rwpcDDJNeR5FrjBKah8bsKRaKNZ31Y
         ZQ186ms7DHjsoxRYYyOc5bsDEf7mdZvubUrwnHJ6D5bCDWwvz38CmH0WUGx0KX/gp5j3
         68gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DdaKYAD+3uox0bnZyMc0CsziZH9vJmOYjQVhGpA3+bo=;
        b=GBV1+EAsBC2LH8AN9YsXL2PIADRtkAmbnFDUDUWV0lGJgM0uwfKeJoLqP/mAq+VQL0
         kCgjxi/CTfwhnq/q83RyQExU+j/ZyA6RmOzp/vlaogRBlYYYBR5isZE1Yrhqq+2vN439
         w8BGNsdqybj3wXDs1ImfXsQlbHx/cIJoGt1wJv4CBrd8D/JUtvH4wapWsujkG5Mqf58a
         6R15zPcShCCsTRcNl0U28BtESqCgUs4MURbXUWviLnhvFyeD1BuekVzFc1hxgozelLDx
         0UIAtfVj9zMYpGYZUlzqHKemp12FrFBg621Rfzc7kQSf/qsxSZZkrh/d97L9Yabkw2yu
         cLUA==
X-Gm-Message-State: AOAM533e4lyK82inFPIc3BZs47tZWH4bt7M7KunZR22r8KstIxcYYquz
        7jOYfyiVX+G5+SvmC1RD2JVB1brDfkOvlQU7bKjcZw==
X-Google-Smtp-Source: ABdhPJycTGo9B/FZL0du4dld8W6D9Zxj3z3lWKgajccSdIPeTFaPJjD+54DfV1FLl972qg+8JKE5ENgx5iKvvmlQYgc=
X-Received: by 2002:a05:6512:3a85:: with SMTP id q5mr6435636lfu.465.1617890168968;
 Thu, 08 Apr 2021 06:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210324081923.20379-1-noltari@gmail.com> <CACRpkdZE55ixxSp6H1SKx19trGE_uVGgkLttzAVQuLzw4=Jutw@mail.gmail.com>
 <609f038d-3037-5cda-b489-f0816eb95658@gmail.com>
In-Reply-To: <609f038d-3037-5cda-b489-f0816eb95658@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 8 Apr 2021 15:55:58 +0200
Message-ID: <CACRpkdZubgHyBqPnZxOw7QXgf=AHMcb1E0Y7bj5v3v_Am+3Ttw@mail.gmail.com>
Subject: Re: [PATCH v9 00/22] pinctrl: add BCM63XX pincontrol support
To:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 10:57 AM =C3=81lvaro Fern=C3=A1ndez Rojas
<noltari@gmail.com> wrote:

> > Now, what about a patch set for the IRQ support? :)
>
> If you could give me some guidance on that matter it would be much
> appreciated, because your comments [1] are now outdated since I switched
> to GPIO_REGMAP
> [1]
> http://patchwork.ozlabs.org/project/linux-gpio/patch/20210225164216.21124=
-3-noltari@gmail.com/

I think it mostly holds: GPIOLIB_IRQCHIP should always be used if there
is a reasonably straight-forward interrupts whether cascaded or hierarchica=
l.
Very few exceptions there. If there is one IRQ line per GPIO
line, the hierarchical support should be used as outlined. GPIO_REGMAP
should be mostly (famous last words) orthogonal.

Yours,
Linus Walleij
