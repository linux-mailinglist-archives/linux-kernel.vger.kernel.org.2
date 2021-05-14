Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81593803F0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 09:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbhENHDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 03:03:42 -0400
Received: from foss.arm.com ([217.140.110.172]:44078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232389AbhENHDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 03:03:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8203A1476;
        Fri, 14 May 2021 00:02:28 -0700 (PDT)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 259A13F718;
        Fri, 14 May 2021 00:02:27 -0700 (PDT)
Date:   Fri, 14 May 2021 08:02:20 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: allwinner: add v3s pwm
 compatible
Message-ID: <20210514080220.44e0f74c@slackpad.fritz.box>
In-Reply-To: <20210513203527.2072090-2-t.schramm@manjaro.org>
References: <20210513203527.2072090-1-t.schramm@manjaro.org>
        <20210513203527.2072090-2-t.schramm@manjaro.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2021 22:35:26 +0200
Tobias Schramm <t.schramm@manjaro.org> wrote:

> The Allwinner V3s pwm peripheral is compatible with the pwm peripheral
> inside the Allwinner A20.
> This patch adds a compatible string for it.
> 
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>

Compared the A20 and V3s manuals, the register description on the
PWM peripherals look indeed identical.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  .../devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml       | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> index 7dcab2bf8128..04ff708fdc86 100644
> --- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> @@ -24,6 +24,9 @@ properties:
>        - items:
>            - const: allwinner,sun8i-a83t-pwm
>            - const: allwinner,sun8i-h3-pwm
> +      - items:
> +          - const: allwinner,sun8i-v3s-pwm
> +          - const: allwinner,sun7i-a20-pwm
>        - items:
>            - const: allwinner,sun50i-a64-pwm
>            - const: allwinner,sun5i-a13-pwm

