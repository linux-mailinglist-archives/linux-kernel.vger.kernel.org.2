Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6522A4167AA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 23:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243410AbhIWVoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 17:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243401AbhIWVoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 17:44:38 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64555C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 14:43:06 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t10so31788212lfd.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 14:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bv5z7TKeM3MrY4Op135K+ZHXfXdxQ7r37AdQq608Www=;
        b=UmulNDV0sB0n6qTn+9RDNXe/2gQ15OeGrZbI8ZVLlU9QO1Jmdikq3IPOx5dg8gfNZ4
         VV0bCYkZKR7szrW9SgwXoOMCxEUPSG9Q7mBtOS/ic27S76BEq4TUSqVvdi8Dv0m0Xoiz
         SiQZDmRW1mOIYx5Y5GAywbckmFrDtlEsrb0WbfPPS8hEhLBVl57EmNl85Hyh7kJJzUQn
         /gsqPKnw7RucVOL3WSu7RniCQefof4SubCPhjxdsSQvytCID2JHOfYVd1luY+TtcRmPw
         lLNcNOhyMIOSZXvItX6Rbr11ITnopRZrWAK0C5cTX2kD0DPaYMEFQB3nlatUj2Ucy7uT
         8IKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bv5z7TKeM3MrY4Op135K+ZHXfXdxQ7r37AdQq608Www=;
        b=aEUIrAVrrRrPxEES3c50oxOL8sGTwDMbzRzPRddhrkqgvrdGZhq70x4kyZ51P7/xfE
         Ft22eCRxsmiR7sb1AzxhfYLmEEPFy48J5cqyFNdDK+nkzJGDjs9J9/N0Tc4XkM92D7LI
         7zYB4HYKF1cnOMRBErOLN1wtX55LOP/2zhGDH+sXycl2ND7Y7dk4UJGhDJ30m957fgNy
         9R/z4iZzpGZQ+B6Fwsu0Sl9cri8Qwu0+fN9vajgeN0NVI0qM0HAqAwjp7hdkeVv+72AY
         jTDuhF2Es6mDUL3ITW/KpHOjk+EwmionqHciuu7U8E/nRISFom+Z0vrsjTGHEmw92gJq
         VL8A==
X-Gm-Message-State: AOAM531E5GeFGb1CxoCwvihZGo2jATbwUMeD7L3DljqL6nhh3OF1QMaY
        aTeUdugIee3VOip8LYqK0laz0dZse+uO4Yyu8W1vWQ==
X-Google-Smtp-Source: ABdhPJwRwz/kz0/X1e4yF2JwXSsml2lz7kj3xT83695Gx0Qd6T1bZdtQb4LSjXt0NKoKTGNzxTttdxL7oXaPxuQ+BMw=
X-Received: by 2002:a05:651c:4ca:: with SMTP id e10mr7891549lji.259.1632433384674;
 Thu, 23 Sep 2021 14:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210921193028.13099-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20210921193028.13099-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210921193028.13099-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Sep 2021 23:42:53 +0200
Message-ID: <CACRpkdZLosCHy2=Vn0EsaLVuFtdQ2yrhqcXOx4UzU5X8xskC=w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] dt-bindings: interrupt-controller: Add Renesas
 RZ/G2L Interrupt Controller
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 9:30 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:

> Add DT bindings for the Renesas RZ/G2L Interrupt Controller.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
(...)
> +            interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 453 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 471 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>;

It is not custom to code all the interrupts into the device tree if this
a one-to-one mapping, instead the hardware driver is supposed to
know which IRQs to pick in the 1-to-1 map based on the compatible
string, which should be unique per-SoC.

Yours,
Linus Walleij
