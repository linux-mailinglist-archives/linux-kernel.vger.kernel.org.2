Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038C4426752
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 12:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239562AbhJHKEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 06:04:08 -0400
Received: from gloria.sntech.de ([185.11.138.130]:56816 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236118AbhJHKEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 06:04:06 -0400
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mYmhb-0008SB-JP; Fri, 08 Oct 2021 12:02:07 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     krzysztof.kozlowski@canonical.com, robh@kernel.org,
        linux-riscv@lists.infradead.org
Cc:     krzysztof.kozlowski@canonical.com, zong.li@sifive.com,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        mturquette@baylibre.com, Paul Walmsley <paul.walmsley@sifive.com>,
        sboyd@kernel.org, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH] dt-bindings: clock: fu740-prci: add reset-cells
Date:   Fri, 08 Oct 2021 12:02:06 +0200
Message-ID: <24526929.Pe8KFHSfS2@diego>
In-Reply-To: <mhng-b9e6d8f9-b9be-4651-9649-3378d227eae1@palmerdabbelt-glaptop>
References: <mhng-b9e6d8f9-b9be-4651-9649-3378d227eae1@palmerdabbelt-glaptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 8. Oktober 2021, 03:29:17 CEST schrieb Palmer Dabbelt:
> On Thu, 23 Sep 2021 09:59:32 PDT (-0700), robh@kernel.org wrote:
> > On Mon, 20 Sep 2021 16:49:44 +0200, Krzysztof Kozlowski wrote:
> >> The SiFive FU740 Power Reset Clock Interrupt Controller is a reset line
> >> provider so add respective reset-cells property to fix:
> >>
> >>   arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dt.yaml: clock-controller@10000000:
> >>     '#reset-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> >> ---
> >>  .../devicetree/bindings/clock/sifive/fu740-prci.yaml          | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> For some reason I thought these went through your tree, LMK if you were 
> planning on having me take it through mine.

Normally both driver + binding patches go through the driver-tree
and actual dts changes through the tree carrying the dts files.

So for a clock-patch this should be the clock-tree aka Mike Turquette
and Stephen Boyd - already in Cc of original patch, so I'd assume they'll
pick it up.


Heiko


