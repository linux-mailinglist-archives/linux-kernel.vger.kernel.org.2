Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB3B338684
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 08:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhCLHY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 02:24:27 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:54683 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhCLHYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 02:24:19 -0500
Received: from xps13 (lfbn-tou-1-1325-59.w90-89.abo.wanadoo.fr [90.89.138.59])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id D9B9A200002;
        Fri, 12 Mar 2021 07:24:12 +0000 (UTC)
Date:   Fri, 12 Mar 2021 08:24:11 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Culhane <conor.culhane@silvaco.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i3c@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: i3c: Fix silvaco,i3c-master-v1 compatible
 string
Message-ID: <20210312082411.1435f9aa@xps13>
In-Reply-To: <20210311234056.1588751-1-robh@kernel.org>
References: <20210311234056.1588751-1-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Rob Herring <robh@kernel.org> wrote on Thu, 11 Mar 2021 16:40:56 -0700:

> The example for the Silvaco I3C master doesn't match the schema's
> compatible string. Fix it.
> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Conor Culhane <conor.culhane@silvaco.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: linux-i3c@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
> index adb5165505aa..62f3ca66274f 100644
> --- a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
> +++ b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
> @@ -49,7 +49,7 @@ additionalProperties: true
>  examples:
>    - |
>      i3c-master@a0000000 {
> -        compatible = "silvaco,i3c-master";
> +        compatible = "silvaco,i3c-master-v1";
>          clocks = <&zynqmp_clk 71>, <&fclk>, <&sclk>;
>          clock-names = "pclk", "fast_clk", "slow_clk";
>          interrupt-parent = <&gic>;

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
