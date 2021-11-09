Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4507B449FEF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 01:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbhKIAsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 19:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbhKIAsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 19:48:52 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610D6C061764
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 16:46:07 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id l7-20020a0568302b0700b0055ae988dcc8so25139859otv.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 16:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bG3Y/BqnxEVlePdqiSugZ7Hd/V/NSxSTAbSGa+VvoRs=;
        b=M6szQqyTjFsganR9sNUTE9fnidl9uukXt7LqnK2czDeOY6OBN5fgOVflmA10HlXbqT
         lSXjpwutL+GQALNCuC1yLgmH/Tw4T4hOVVXH6wSaiVbh7ge7Uq04DuVUfZalIDcXFKc/
         FiSxguiMBIMljRGqkcw0wu2bdV1c5njLZhxFNcDf/bQBeEwcbCZKb+fS2xr+Ux+0IQ6/
         eKPVPOTG5dWftFTBl6lnooe3AvycKpiY0cRbyr8cM/sArSde0d779fPCKd8hd6RWvG6T
         aEsfRwwfb8ze7Lk/2Gfjkfn5+tm9deonu5TsIItVbE2PAQBRdIvCtpxQl0bN18se165b
         GQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bG3Y/BqnxEVlePdqiSugZ7Hd/V/NSxSTAbSGa+VvoRs=;
        b=8Pzhrk/aMFdlsjswXTLG0M+Q6lR+RPj7CyFbkpXn9G4XCC4cxdm+RJwsdbw16D6moU
         WZUiTGs9yIQC6wyJojp5LqA3xglRHGwRYuVnD7d+we5f+hfhZ76grcp9UagwTqflcZyp
         zPQqEP+7dtNV7rD3p8Gox/mRieRusF3wXEK599rkQ1O/ZZhxB3FfF+YEs/jsaxGWhakh
         gcZ3qSuuA6Y1IC5p2Q00GkdfqRmZqJuWpuq4uuQlhmiZqgNxfYBVS8D+97fMuTkuGgxU
         lfGmfFqoUKCKdpZxSgGt0pPXEAGEf6yq2pz4pasgVKLe0XEj3CA4iaJYE9839Td9CBLA
         pATA==
X-Gm-Message-State: AOAM5325WEUOUzU4r1hxRT/6fMqN/qeyioRav/am/K8ovj5brsV4u+HK
        TBbSRGa9amlbAdcApOQAxQHiFhVDlxJkJ2ibacQa7A==
X-Google-Smtp-Source: ABdhPJyys3qfTJGPVjeVT/HCn3VkOqbY3GVCdzVh24eOXr7uLVD857f62jht8jhypUUWDkrPmq/NlW044n5qV03SLYA=
X-Received: by 2002:a9d:ed6:: with SMTP id 80mr2580722otj.35.1636418766697;
 Mon, 08 Nov 2021 16:46:06 -0800 (PST)
MIME-Version: 1.0
References: <20211102161125.1144023-1-kernel@esmil.dk> <20211102161125.1144023-12-kernel@esmil.dk>
In-Reply-To: <20211102161125.1144023-12-kernel@esmil.dk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 01:45:55 +0100
Message-ID: <CACRpkdb0CrJ_uTbtfg-xGq8uu0AKoqfAB03mF2CA_G8ys_8Lzg@mail.gmail.com>
Subject: Re: [PATCH v3 11/16] dt-bindings: pinctrl: Add StarFive JH7100 bindings
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Drew Fustini <drew@beagleboard.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Fu Wei <tekkamanninja@gmail.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Matteo Croce <mcroce@microsoft.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 2, 2021 at 5:12 PM Emil Renner Berthing <kernel@esmil.dk> wrote:

> Add bindings for the GPIO/pin controller on the JH7100 RISC-V SoC by
> StarFive Ltd. This is a test chip for their upcoming JH7110 SoC.
>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> ---
>
> @Linus: I'm really struggling to find a good way to describe how pin
> muxing works on the JH7100. As you can see I've now resorted to
> ascii-art to try to explain it, but please let me know if it's still
> unclear.

This looks perfectly acceptable to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

As it appears to have some cross dependencies I assume
it will be merged through the SoC tree?

Yours,
Linus Walleij
