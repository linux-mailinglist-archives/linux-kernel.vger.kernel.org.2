Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA39354E57
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 10:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbhDFIQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 04:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbhDFIQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 04:16:13 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22427C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 01:16:04 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id b4so21344199lfi.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 01:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=isZ5kV3hcGyVHNx3xikshGr05T2fizU/DZiP3qKBK38=;
        b=xt7xX1sxO+zKckULPY9hGfIdjtQlAEODi6Anjq6kzJ2pdqY6UIq9Hl/PRdM6+amm9+
         mmojXPazGYpsaVAa3tYF7N0jAMD3CEtRgeMUczYZ952hDturVQmbqrjLRmbTwXQYeGho
         6g5bGSPzrA9pfGFp5ZGDHPnLB3Id5CgC7SUuJZHiN5JntF0nyWByMYfs7FozN3amOrBy
         knllXWukmSvQElREjw/RAQFDNul95IRh1WIgCVW9do1Exn0WXSVjbSC6IpDuAWZF5t+v
         UIjmuhzGIS8G8w3en36frU5+2lRQz8C0jJJE0Of7CWxdmN0M33CMuvBHXemInrEDglRK
         OpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=isZ5kV3hcGyVHNx3xikshGr05T2fizU/DZiP3qKBK38=;
        b=t5CNeB9M37FmWBGrSumpDoCpkLDAFTQv0VDohS4s5CfLYE04NwmpqQOcn8qsnfdTML
         zNxzdDMHivAxfXUVBfaVEfbN4E6yUGSuQyh/xCxL698H1DIu1MnJHVRH+H3NkgemHtKW
         CDYhTEMAeQSQKGjlUAJIuiO+SYuV8gIuY1VGhoKQf4EyfkmU51j0+DuGnIrMMnMehktn
         SWmt8wj9G04GkDFUXOaeliBQc6cCo2MfreqzqJBVTAIEuUEEgv/2HWQVjxB8uWaIhfRw
         bkqFgMfCT5Iue6PtOHrmWcNTxvwMOrApCeyYBTGt+nZRshOrtpUlRn87qtylpQgp0jNV
         mUuQ==
X-Gm-Message-State: AOAM531SMOzYfe5rWHW6xJmR5Gcq8UNobR7j++lWKrKokoe3qXO/5C4h
        R7PxUT4UJaFtIr/57Pt1gNpK/25jJ0mVN/+u+kzEEA==
X-Google-Smtp-Source: ABdhPJwxS7CHhzRoQDnRr3aeh9w4hgYoOYYNMDiEWtk2i2LnkDyvmFz59K5jVqWPK6TCRTr0VOnQ/YAGAyXMn0UG7hg=
X-Received: by 2002:a19:ef18:: with SMTP id n24mr1928131lfh.291.1617696962602;
 Tue, 06 Apr 2021 01:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <YGtZeofmBv7hXK+a@Red>
In-Reply-To: <YGtZeofmBv7hXK+a@Red>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 6 Apr 2021 10:15:51 +0200
Message-ID: <CACRpkdZ_barDrLvD2UBKo+GA-F+g72uMQx8CfRK2YLRodpeyUA@mail.gmail.com>
Subject: Re: gemini: sl3516: Mainlining of NS 2502
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 5, 2021 at 8:39 PM Corentin Labbe <clabbe.montjoie@gmail.com> wrote:

> I own an Edimax NS 2502, which is a NAS based on StormLinix 3516.
> I successfully upgraded it with a recent Linux.

Pretty cool!

>         mdio0: ethernet-phy {
>                 compatible = "virtual,mdio-gpio";
>                 gpios = <&gpio0 22 GPIO_ACTIVE_HIGH>, /* MDC */
>                         <&gpio0 21 GPIO_ACTIVE_HIGH>; /* MDIO */
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 phy0: ethernet-phy@1 {
>                         reg = <1>;
>                         device_type = "ethernet-phy";
>                 };
>         };

This looks like the most typical way to attach an MDIO phy.

I always try to identify the exact component used on the board. Do you have
 a high res board photo?

Realtek RTL82111 is the most common configuration.

Compare to the D-Linux DNS-313 DTS:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/gemini-dlink-dns-313.dts

Try just copying the whole pinctrl-gmii section!


>                 syscon: syscon@40000000 {
>                         pinctrl {
>                                 /*
>                                  * gpio0agrp cover line 0-4
>                                  * gpio0bgrp cover line 5
>                                  */
>                                 gpio0_default_pins: pinctrl-gpio0 {
>                                         mux {
>                                                 function = "gpio0";
>                                                 groups = "gpio0agrp",
>                                                 "gpio0bgrp";
>                                         };
>                                 };

Change groups to

groups = "gpio0agrp", "gpio0bgrp", "gpio0hgrp";

So you mux in group h which is where the GPIO 21, 22 go out
to the MDIO on 3516 IIUC. The right mux out is pretty important,
if you have vendor source code, please share so I can check how
they set it up.

> BUT neither ethernet nor USB works.

For USB try this patch:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git/commit/?h=gemini-usb&id=cbaf6cdf770b90de5f10bfa5112c679f1dffe948

Pls report progress! I hope we can mainline this device.

Yours,
Linus Walleij
